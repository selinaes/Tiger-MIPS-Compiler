structure Translate : TRANSLATE = 
struct
    datatype exp = Ex of Tree.exp 
                 | Nx of Tree.stm
                 | Cx of Temp.label * Temp.label -> Tree.stm
    datatype level = OUTMOST | LEVEL of {parent : level, frame : Frame.frame, unique: unit ref}
    val outermost = OUTMOST
    type access = level * Frame.access

    structure Err = ErrorMsg
    structure Tr = Tree

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



    fun followLink(_, OUTMOST, _ ) = 
        (Error.impossible "followLink: does not find matched frame. "; Ex(Tr.CONST 0))
    | followLink(_, _, OUTMOST) = 
        (Error.impossible "followLink: does not find matched frame. "; Ex(Tr.CONST 0))
    | followLink(currFp, definedLevel, currentLevel) = 
        let val LEVEL {parent=parentLevel, frame=frame, unique=unique} = currentLevel
            val LEVEL {parent=parentLevel', frame=frame', unique=unique'} = definedLevel    
        in
          if unique = unique'
                then 
                    currFP
                else
                (* Tr.MEM(currFP): static link is located at the first place *)
                    followLink(Tr.MEM(currFP), definedLevel, parentLevel)
        end

              
    (* access contains defined level, usedLevel is OUTMOST? true -> error, false ->  *)
    fun simpleVar (_, OUTMOST) = (Error.impossible "simpleVar: used level cannot be OUTMOST. "; Ex(Tr.CONST 0))
        | simpleVar ((OUTMOST, _): access, _) = (Error.impossible "simpleVar: defined level cannot be OUTMOST. "; Ex(Tr.CONST 0))    
        | simpleVar (definedLevel, usedLevel) : exp = 
            Ex(Frame.exp(frameAccess, followLink(Tr.TEMP(Frame.FP), definedLevel, usedLevel)))
    
    fun transIfThen(ir1: exp, ir2: exp): Nx = 
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

(* TODO: page 162 *)
    fun transIfThenElse(ir1, ir2, ir3): exp = 
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

    fun transWhile(test: exp, body: exp): exp = 
        let val test' = unCx test
            val body' = unNx body
            val truelbl = Temp.newlabel()
            val falselbl = Temp.newlabel()
            val testlbl = Temp.newlabel()
        in
            Nx(seq[Tr.JUMP(Tr.NAME testlbl, [testlbl]),
                   Tr.LABEL truelbl,
                   body',
                   Tr.LABEL testlbl,
                   test'(truelbl, falselbl),
                   Tr.LABEL falselbl])
end 
