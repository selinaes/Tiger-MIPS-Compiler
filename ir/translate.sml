structure Translate : TRANSLATE = 
struct
    datatype exp = Ex of Tree.exp (* any exp, can be ESEQ *)
                 | Nx of Tree.stm (* any stm, can be SEQ *)
                 | Cx of Temp.label * Temp.label -> Tree.stm
    datatype level = OUTMOST | LEVEL of {parent : level, frame : Frame.frame, unique: unit ref}
    val outermost = OUTMOST
    type access = level * Frame.access
    val fragLst = ref []

    val dummy = EX(Tr.CONST 0 )

    structure Err = ErrorMsg
    structure Tr = Tree
    structure T = Types

    fun newLevel {parent: level, name: Temp.label, formals: bool list} : level =
        LEVEL {parent=parent, frame=Frame.newFrame({name, formals = true::formals}), unique=ref ()}
    
    (* because F.formals returns a F.access list, not a TR.access list *)
    fun formals lvl : access list (* include the 0th - static link's access*) = 
        case lvl of
            OUTMOST => []
          | LEVEL {parent, frame, unique} => map (fn (frmaccs) => (lvl, frmaccs)) (Frame.formals frame)
        
    fun allocLocal OUTMOST (b:bool) : access = (Err error 0 "cannot allocate at outmost frame. \n"; (OUTMOST, Frame.InFrame 0))
    | allocLocal LEVEL {parent, frame, unique} (b:bool) = (LEVEL {parent, frame, unique}, Frame.allocLocal frame b)

    fun seq [s] = s 
        | seq (s::ss) = Tr.SEQ(s, seq ss)
        | seq [] = Tr.EXP(Tr.CONST 0) 

    fun unEx (Ex e) = e
        | unEx (Cx genstm) =
            let val r = Temp.newtemp()
                val t = Temp.newlabel() 
                val f = Temp.newlabel()
            in Tr.ESEQ(seq[T.MOVE(Tr.TEMP r, Tr.CONST 1), 
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

    fun unCx(Ex (Tr.CONST 0)) = fn (t, f) => Tr.JUMP(Tr.name f, [f])
    | unCx (Ex (Tr.CONST 1)) = fn (t, f) => Tr.JUMP(Tr.name t, [t])
    | unCx (Ex e) = fn (t, f) => Tr.CJUMP(Tr.NE, e, Tr.CONST 0, t, f)
    | unCx (Cx genstm) = genstm
    | unCx (Nx _) = Err.impossible "unCx: Nx" 



    fun followLink(OUTMOST, _ ): Tr.exp = 
        (Error.impossible "followLink: does not find matched frame. "; Tr.CONST 0)
    | followLink(_, OUTMOST): Tr.exp = 
        (Error.impossible "followLink: does not find matched frame. "; Tr.CONST 0)
    | followLink(definedLevel, currentLevel): Tr.exp = 
        let val LEVEL {parent=parentLevel, frame=frame, unique=unique} = currentLevel
            val LEVEL {parent=parentLevel', frame=frame', unique=unique'} = definedLevel    
        in
          if unique = unique'
                then 
                    Tr.MEM(Frame.FP)
                else
                    Tr.MEM(followLink(definedLevel, parentLevel))
        end

              
    (* access contains defined level, usedLevel is OUTMOST? true -> error, false ->  *)
    (* access * level -> exp,which is a MEM/TEMP *)
    fun simpleVar (_, OUTMOST) = (Error.impossible "simpleVar: used level cannot be OUTMOST. "; Ex(Tr.CONST 0))
        | simpleVar ((OUTMOST, _): access, _) = (Error.impossible "simpleVar: defined level cannot be OUTMOST. "; Ex(Tr.CONST 0))    
        | simpleVar ((frameAccess, definedLevel), usedLevel) : exp = 
            Ex(Frame.exp(frameAccess, followLink(definedLevel, usedLevel)))


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
    fun subscriptVar (arr: exp, index: exp): Ex = 
        let 
            val arr' = unEx arr
            val index' = unEx index
            val indexTemp = Temp.newtemp()
            val sizeTemp = Temp.newtemp()
            val outOfBound = Temp.newlabel()
            val nextCheck = Temp.newlabel()
            val validIndex = Temp.newlabel()
            val checkUpperBound = Tr.CJUMP(T.GE, T.Temp indexTemp, T.Temp sizeTemp, outOfBound, nextCheck)
            val checkLowerBound = Tr.CJUMP(T.LT, T.Temp indexTemp, Tr.CONST(0), outOfBound, validIndex)
        in
            Ex(Tr.ESEQ(seq[Tr.MOVE(T.Temp indexTemp, index'),
                            Tr.MOVE(T.Temp sizeTemp, Tr.MEM(Tr.BINOP(Tr.MINUS arr', Tr.CONST(4)))),
                            checkUpperBound,
                            Tr.LABEL next,
                            checkLowerBound,
                            Tr.LABEL outOfBound,
                            Tr.EXP(F.externalCall("exit", [Tr.CONST(1)])),
                            Tr.LABEL validIndex],
                        T.MEM(T.BINOP(T.PLUS, arr', T.BINOP(T.MUL, index', T.CONST(Frame.wordSize))))))
        end


    fun ifThenIR(ir1: exp, ir2: exp): Nx = 
        let val test = unCx ir1
            val ir2' = unNx ir2
            val tlbl = Temp.newlabel()
            val elbl = Temp.newlabel()
        in
            Nx(seq(test (tlbl, elbl),
                    Tr.LABEL tlbl,
                    ir2',
                    Tr.LABEL elbl))
        end

(* TODO: page 162: remove redundent instructions *)
    fun ifThenElseIR(ir1, ir2, ir3): Ex = 
     let val test = unCx ir1
            val ir2' = unEx ir2
            val ir3' = unEx ir3
            val tlbl = Temp.newlabel()
            val flbl = Temp.newlabel()
            val elbl = Temp.newlabel()
            val result = Temp.newtemp()
        in
            Ex(seq [test (tlbl, elbl),
                    Tr.LABEL tlbl,
                    Tr.MOVE(T.TEMP result, ir2'),
                    Tr.JUMP(Tr.NAME elbl, [elbl]),
                    Tr.LABEL flbl,
                    Tr.MOVE(T.TEMP result, ir3'),
                    Tr.LABEL elbl],
                T.TEMP result)
        end

    fun whileIR(test: exp, body: exp, breakLabel: Temp.label): Nx = 
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


    fun forIR(vloc:exp, lo: exp, hi: exp, body: exp): Nx = 
        let val lo' = unEx lo
            val hi' = unEx hi
            val body' = unNx body
            val truelbl = Temp.n ewlabel() (*L2*)
            val falselbl = Temp.newlabel() (*L3*)
            val incrementlbl = Temp.newlabel() (*L1*)
        in
            Nx(seq[assignIR(vloc, lo'),
                   Tr.CJUMP(Tr.LE, simpleVar(v, lev), hi', truelbl, falselbl),
                   Tr.LABEL incrementlbl,
                   assignIR(vloc, transBinOp(Tr.PLUS, simpleVar(v, lev), intIR 1)),
                   Tr.LABEL truelbl,
                   body',
                   Tr.CJUMP(Tr.LT, simpleVar(v, lev), hi', incrementlbl, falselbl),
                   Tr.LABEL falselbl])
        end
    
   
    fun letIR([], body) = Ex body
        | letIR(declist: exp list, body: exp) = Ex(Tr.ESEQ(seq(map unNx declist), unEx body))

    (* Translate.exp list, handle each *)
    fun seqIR([]): Ex = Ex(Tr.CONST 0)
    | seqIR([exp]): Ex = exp
    | seqIR(s :: l): Ex = Ex(Tr.ESEQ(unNx s, unEx(seqIR l)))

    fun nilIR(): Ex = Ex(Tr.CONST 0)


    fun assignIR(varloc: exp, assigned: exp)
        let val var' = unEx varloc
            val assigned' = unEx assigned
        in
            Nx(Tr.MOVE(var', assigned'))
        end

    fun breakIR(label: Temp.label): Nx = 
        Nx(Tr.JUMP (Tr.Name label, [label]))

(* TODO: call on outmost frame, what should we do? *)
    fun callIR(callLabel: Temp.label, args: exp list, OUTMOST, callLevel: level): Ex =
        let
            val foundLink = followLink(parent, callLevel)
            val exArgs: Ex list = map (fn a => unEx a) args
        in
            Ex(Tr.CALL(Tr.Name callLabel, exArgs))
        end
    | callIR(callLabel: Temp.label, args: exp list, LEVEL {parent, frame, unique}, callLevel: level): Ex =
        let
            val foundLink = followLink(parent, callLevel)
            val exArgs: Ex list = map (fn a => unEx a) args
        in
            Ex(Tr.CALL(Tr.Name callLabel, foundLink :: exArgs))
        end


    fun binOpIR(op: Tr.binlop, left: exp, right: exp): Ex = 
        let val left' = unEx left
            val right' = unEx right
        in
            Ex(Tr.BINOP(op, left', right'))
        end

    fun reOpIR(relop: Tr.relop, left: exp, right: exp, ty: T.ty): Cx = 
        let 
            val left' = unEx left
            val right' = unEx right
        in
            case (ty, relop) of 
                (T.STRING, Tr.EQ) => Ex(Frame.externalCall("stringEqual", [left', right']))
                (T.String, Tr.NE) => Ex(Frame.externalCall("stringNe", [left', right']))
                (T.STRING, Tr.LT) => Ex(Frame.externalCall("stringLt", [left', right']))
                (T.String, Tr.GT) => Ex(Frame.externalCall("stringGt", [left', right']))
                (T.STRING, Tr.LE) => Ex(Frame.externalCall("stringLe", [left', right']))
                (T.String, Tr.GE) => Ex(Frame.externalCall("stringGe", [left', right']))
                | _ => Cx(fn (t, f) => Tr.CJUMP(relop, left', right', t, f))
        end
        
    (* todo: check str literal exist *)
    fun stringIR(str: string): Ex = 
        let val lbl = Temp.newlabel()
            fun createStrLiteral(str) = 

        in
            (fragLst := !fragLst @ Frame.STRING(lbl, str); Ex(Tr.NAME lbl))
        end
    
    fun intIR(num: int): Ex = Ex(Tr.CONST num)
    fun arrayCreateIR(size: exp, init: exp): Ex = 
        let val size' = unEx size
            val init' = unEx init
        in
            Ex(Frame.externalCall("initArray", [size', init']))
        end

    fun recCreateIR(fieldLsts: exp list): Ex = 
        let val len = length fieldLsts
            val ans = Temp.newtemp()
            val initExp' = map unEx initExps
            fun storeNextField(_, []) = seq []
                storeNextField(offset, fieldExp:r): Ex = 
                    seq(Tr.MOVE(Tr.MEM(Tr.BINOP(Tr.PLUS, Tr.TEMP ans, Tr.CONST offset)), fieldExp), 
                        storeNextField(offset + Frame.wordSize, r))
        in
            (* Ex(Tr.ESEQ(foldl storeNextField recordSeq fieldLsts, Tr.TEMP recordPtr)) *)
            Ex(Tr.ESEQ(seq(Tr.MOVE(Tr.TEMP ans, Frame.externalCall("malloc", [Tr.CONST (len * Frame.wordSize)])),
                            storeNextField(0, initExp')), Tr.TEMP ans))
        end

    
end 
