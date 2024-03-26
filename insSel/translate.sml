structure Translate : TRANSLATE = 
struct
    datatype exp = Ex of Tree.exp (* any exp, can be ESEQ *)
                 | Nx of Tree.stm (* any stm, can be SEQ *)
                 | Cx of Temp.label * Temp.label -> Tree.stm
    datatype level = OUTMOST | LEVEL of {parent : level, frame : Frame.frame, unique: unit ref}
    val outmost = OUTMOST
    type access = level * Frame.access
    val fragLst: Frame.frag list ref = ref []

    structure Err = ErrorMsg
    structure Tr = Tree
    structure T = Types

    val dummyTree: Tr.exp = Frame.externalCall("exit", [Tr.CONST 1])
    val dummy: exp = Ex(dummyTree)
    
    fun getResult() = !fragLst

    fun resetfragLst() = 
        fragLst := []
    
    fun newLevel {parent: level, name: Temp.label, formals: bool list} : level =
        LEVEL {parent=parent, frame=Frame.newFrame({name = name, formals = true::formals}), unique=ref ()}
    
    (* because F.formals returns a F.access list, not a TR.access list *)
    fun formals lvl : access list (* include the 0th - static link's access*) = 
        case lvl of
            OUTMOST => []
          | LEVEL {parent, frame, unique} => map (fn (frmaccs) => (lvl, frmaccs)) (Frame.formals frame)
        
    fun allocLocal OUTMOST (b:bool) : access = (Err.error 0 "cannot allocate at outmost frame. \n"; (OUTMOST, Frame.allocLocal (Frame.newFrame {name=Temp.newlabel(),formals=[]}) b))
    | allocLocal (LEVEL {parent, frame, unique}) (b:bool) : access = (LEVEL {parent=parent, frame=frame, unique=unique}, Frame.allocLocal frame b)

    fun seq [s] = s
        | seq (s::ss) = Tr.SEQ(s, seq ss)
        | seq [] = Tr.EXP(Tr.CONST 0) 

    fun unEx (Ex e) = e
        | unEx (Cx genstm) =
            let val r = Temp.newtemp()
                val t = Temp.newlabel() 
                val f = Temp.newlabel()
            in Tr.ESEQ(seq[Tr.MOVE(Tr.TEMP r, Tr.CONST 1), 
                            genstm(t,f),
                            Tr.LABEL f,
                            Tr.MOVE(Tr.TEMP r, Tr.CONST 0),
                            Tr.LABEL t],
                    Tr.TEMP r)
            end
        | unEx (Nx s) = Tr.ESEQ(s, Tr.CONST 0)

    fun unNx (Ex e) = Tr.EXP e
        | unNx (Cx genstm) = 
            let 
                val t = Temp.newlabel()
            in 
                seq[genstm(t, t), Tr.LABEL t]
            end
        | unNx (Nx s) = s

    fun unCx(Ex (Tr.CONST 0)) = (fn (t, f) => Tr.JUMP(Tr.NAME f, [f]))
    | unCx (Ex (Tr.CONST 1)) = (fn (t, f) => Tr.JUMP(Tr.NAME t, [t]))
    | unCx (Ex e) = (fn (t, f) => Tr.CJUMP(Tr.NE, e, Tr.CONST 0, t, f))
    | unCx (Cx genstm) = genstm
    | unCx (Nx _) = Err.impossible "unCx: Nx" 



    fun followLink(OUTMOST, _): Tr.exp = 
        (Err.impossible  "followLink: does not find matched frame. definedLevel reach to outmost"; dummyTree)
    | followLink(_, OUTMOST): Tr.exp = 
        (Err.impossible "followLink: does not find matched frame. currentLevel reach to outmost"; dummyTree)
    | followLink(definedParentLevel, currentLevel): Tr.exp = 
        let val (LEVEL{parent=_, frame=_, unique=unique'}) = definedParentLevel    
            val (LEVEL{parent=parentLevel, frame=_, unique=unique}) = currentLevel
        in
          if unique = unique'
                then 
                    Tr.TEMP Frame.FP
                else
                    Tr.MEM(followLink(definedLevel, parentLevel))
        end

    
(* TODO: call on outmost frame, what should we do? *)
    fun callIR(callLabel: Temp.label, args: exp list, OUTMOST , callLevel: level): exp =
        let
            val exArgs: Tr.exp list = map (fn a => unEx a) args
        in
            Ex(Tr.CALL(Tr.NAME callLabel, exArgs))
        end
    | callIR(callLabel: Temp.label, args: exp list, LEVEL {parent, frame, unique}, callLevel: level): exp =
        let
            val foundLink = followLink(parent, callLevel)
            val exArgs: Tr.exp list = map unEx args
        in
            Ex(Tr.CALL(Tr.NAME callLabel, foundLink :: exArgs))
        end

    (* access contains defined level, usedLevel is OUTMOST? true -> error, false ->  *)
    (* access * level -> exp,which is a MEM/TEMP *)
    fun simpleVar (_, OUTMOST) = (Err.impossible "simpleVar: used level cannot be OUTMOST. "; dummy)
        | simpleVar ((OUTMOST, _): access, _) = (Err.impossible "simpleVar: defined level cannot be OUTMOST. "; dummy)    
        | simpleVar ((definedLevel, frameAccess), usedLevel) : exp = 
            Ex(Frame.exp frameAccess (followLink(definedLevel, usedLevel)))


    fun fieldVar (record: exp, element: int): exp = 
        let 
            val record' = unEx record
        in
            if element = 0
            then Ex(Tr.MEM(record'))
            else
                Ex(Tr.MEM(Tr.BINOP(Tr.PLUS, record', Tr.CONST(Frame.wordSize * element))))
        end
    
    (* bound checking *)
    fun subscriptVar (arr: exp, index: exp): exp = 
        let 
            val arr' = unEx arr
            val index' = unEx index
            val indexTemp = Temp.newtemp()
            val sizeTemp = Temp.newtemp()
            val outOfBound = Temp.newlabel()
            val nextCheck = Temp.newlabel()
            val validIndex = Temp.newlabel()
            val checkUpperBound = Tr.CJUMP(Tr.GE, Tr.TEMP indexTemp, Tr.TEMP sizeTemp, outOfBound, nextCheck)
            val checkLowerBound = Tr.CJUMP(Tr.LT, Tr.TEMP indexTemp, Tr.CONST(0), outOfBound, validIndex)
        in
            Ex(Tr.ESEQ(seq[Tr.MOVE(Tr.TEMP indexTemp, index'),
                            Tr.MOVE(Tr.TEMP sizeTemp, Tr.MEM(Tr.BINOP(Tr.PLUS, arr', Tr.CONST(~4)))),
                            checkUpperBound,
                            Tr.LABEL nextCheck,
                            checkLowerBound,
                            Tr.LABEL outOfBound,
                            Tr.EXP(Frame.externalCall("exit", [Tr.CONST(1)])),
                            Tr.LABEL validIndex],
                        Tr.MEM(Tr.BINOP(Tr.PLUS, arr', Tr.BINOP(Tr.MUL, index', Tr.CONST(Frame.wordSize))))))
        end


    fun ifThenIR(ir1: exp, ir2: exp): exp = 
        let val test = unCx ir1
            val ir2' = unNx ir2
            val tlbl = Temp.newlabel()
            val elbl = Temp.newlabel()
        in
            Nx(seq[test (tlbl, elbl),
                    Tr.LABEL tlbl,
                    ir2',
                    Tr.LABEL elbl])
        end

(* TODO: page 162: remove redundent instructions *)
    fun ifThenElseIR(ir1, ir2, ir3): exp = 
     let val test = unCx ir1
            val ir2' = unEx ir2
            val ir3' = unEx ir3
            val tlbl = Temp.newlabel()
            val flbl = Temp.newlabel()
            val elbl = Temp.newlabel()
            val result = Temp.newtemp()
        in
            Ex(Tr.ESEQ(seq[test (tlbl, flbl),
                        Tr.LABEL tlbl,
                        Tr.MOVE(Tr.TEMP result, ir2'),
                        Tr.JUMP(Tr.NAME elbl, [elbl]),
                        Tr.LABEL flbl,
                        Tr.MOVE(Tr.TEMP result, ir3'),
                        Tr.LABEL elbl],
                Tr.TEMP result))
        end

    fun whileIR(test: exp, body: exp, breakLabel: Temp.label): exp = 
        let val test' = unCx test
            val body' = unNx body
            val truelbl = Temp.newlabel()
            (* val falselbl = Temp.newlabel() *)
            val testlbl = Temp.newlabel()
        in
            Nx(seq[Tr.JUMP(Tr.NAME testlbl, [testlbl]),
                   Tr.LABEL truelbl,
                   body',
                   Tr.LABEL testlbl,
                   test'(truelbl, breakLabel),
                   Tr.LABEL breakLabel])
                   
        end
   
    fun letIR([], body): exp = body
        | letIR(declist: exp list, body: exp) = Ex(Tr.ESEQ(seq(map unNx declist), unEx body))

    (* Translate.exp list, handle each *)
    fun seqIR([]): exp = Ex(Tr.CONST 0)
    | seqIR([exp]): exp = exp
    | seqIR(s :: l): exp = Ex(Tr.ESEQ(unNx s, unEx(seqIR l)))

    fun nilIR(): exp = Ex(Tr.CONST 0)


    fun assignIR(varloc: exp, assigned: exp) : exp =
        let val var' = unEx varloc
            val assigned' = unEx assigned
        in
            Nx(Tr.MOVE(var', assigned'))
        end



    fun breakIR(label: Temp.label): exp = 
        Nx(Tr.JUMP (Tr.NAME label, [label]))



    fun binOpIR(binop: Tr.binop, left: exp, right: exp): exp = 
        let val left' = unEx left
            val right' = unEx right
        in
            Ex(Tr.BINOP(binop, left', right'))
        end

    fun reOpIR(relop: Tr.relop, left: exp, right: exp, ty: T.ty): exp = 
        let 
            val left' = unEx left
            val right' = unEx right
        in
            case (ty, relop) of 
                 (T.STRING, Tr.EQ) => Ex(Frame.externalCall("stringEqual", [left', right']))
                | (T.STRING, Tr.NE) => Ex(Frame.externalCall("stringNe", [left', right']))
                | (T.STRING, Tr.LT) => Ex(Frame.externalCall("stringLt", [left', right']))
                | (T.STRING, Tr.GT) => Ex(Frame.externalCall("stringGt", [left', right']))
                | (T.STRING, Tr.LE) => Ex(Frame.externalCall("stringLe", [left', right']))
                | (T.STRING, Tr.GE) => Ex(Frame.externalCall("stringGe", [left', right']))
                | _ => Cx(fn (t, f) => Tr.CJUMP(relop, left', right', t, f))
        end
        
    (* todo: check str literal exist *)
    fun stringIR(str: string): exp = 
        let 
            fun findStrLiteral (Frame.STRING(lstLbl, lstStr)): bool = (str = lstStr)
              | findStrLiteral (Frame.PROC{body=body, frame=frame}): bool = false
                
        in
            case (List.find findStrLiteral (!fragLst)) of
                SOME (Frame.STRING(lstLbl, lstStr)) => Ex(Tr.NAME lstLbl)
                | NONE => 
                    let
                        val lbl = Temp.newlabel();
                    in
                        fragLst := !fragLst @ [Frame.STRING(lbl, str)]; 
                        Ex(Tr.NAME lbl)
                    end
                    
                | _ => (Err.error 0 "stringIR: impossible case, PROC found."; dummy) (* found proc *)
        end
    
    fun intIR(num: int): exp = Ex(Tr.CONST num)
    
    fun arrayCreateIR(size: exp, init: exp): exp = 
        let val size' = unEx size
            val init' = unEx init
        in
            Ex(Frame.externalCall("initArray", [size', init']))
        end

    fun recordCreateIR(fieldLsts: exp list): exp = 
        let val len = length fieldLsts
            val ans = Temp.newtemp()
            val fieldLsts' = map unEx fieldLsts
            fun storeNextField(_, []) = seq []
              | storeNextField(offset, fieldExp::r): Tr.stm = 
                    seq[Tr.MOVE(Tr.MEM(Tr.BINOP(Tr.PLUS, Tr.TEMP ans, Tr.CONST offset)), fieldExp),
                    storeNextField(offset + Frame.wordSize, r)]
        in
            (* Ex(Tr.ESEQ(foldl storeNextField recordSeq fieldLsts, Tr.TEMP recordPtr)) *)
            Ex(Tr.ESEQ(seq[Tr.MOVE(Tr.TEMP ans, Frame.externalCall("malloc", [Tr.CONST (len * Frame.wordSize)])),
                            storeNextField(0, fieldLsts')], Tr.TEMP ans))
        end

    fun forIR(vloc:exp, lo: exp, hi: exp, body: exp, falselbl): exp = 
        let val vloc' = unEx vloc
            val lo' = unEx lo
            val hi' = unEx hi
            val body' = unNx body
            val truelbl = Temp.newlabel() (*L2*)
            (* val falselbl = Temp.newlabel() L3 *)
            val incrementlbl = Temp.newlabel() (*L1*)
        in
            Nx(seq[
                    Tr.MOVE(vloc', lo'),
                    Tr.CJUMP(Tr.LE, vloc', hi', truelbl, falselbl),
                    Tr.LABEL incrementlbl,
                    Tr.MOVE(vloc', Tr.BINOP(Tr.PLUS, vloc', Tr.CONST 1)),
                    Tr.LABEL truelbl,
                    body',
                    Tr.CJUMP(Tr.LT, vloc', hi', incrementlbl, falselbl),
                    Tr.LABEL falselbl])
        end

    fun procEntryExit {level, body} : unit = 
        (case level of
            OUTMOST => Err.error 0 "cannot do procEntryExit at outmost frame. "
          | LEVEL {parent, frame, unique} => fragLst := !fragLst @ [Frame.PROC{body=unNx body, frame=frame}])
   
            
   
end 
