structure MipsFrame : FRAME = struct
    datatype access = InFrame of int | InReg of Temp.temp
    (* name: tag of the frame, formals: functions arguments, stackSize: size of the frmae, 4 * #(formals + locals)) *)
    type frame = {name: Temp.label, formals: access list, stackSize: int ref}

    val FP = Temp.newtemp()
    val RV = Temp.newtemp()
    
    val wordSize = 4
    val kDefaultRegSize = 4 (* MIPS has 4 registers for function arguments *)

    datatype frag = PROC of {body: Tree.stm, frame: frame} 
                | STRING of Temp.label * string

    fun newFrame {name: Temp.label, formals: bool list} : frame = 
        let
            val curSize = ref 0
            val curParams = ref 0
            fun allocFormal (escape) : access = 
                if !curParams < kDefaultRegSize 
                then (curParams := !curParams + 1; InReg(Temp.newtemp()))
                else 
                    if escape
                    then (curSize := !curSize + wordSize; InFrame(~(!curSize)))
                    else InReg(Temp.newtemp())
        in
            {name = name, formals = map allocFormal formals , stackSize = curSize}
        end


    fun name(frame): Temp.label = #name frame
    fun formals(frame): access list = #formals frame
    (*Frame.allocLocal(f)(true) -> allocate a new localVar in frame f. T=escape, frame, F = to reg Temp*)
    fun allocLocal ({name, formals, stackSize}: frame) (escape:bool) : access = 
        if escape then
            let
                val size = !stackSize
            in
                stackSize := size + wordSize;
                InFrame(~size)
            end
        else
            InReg(Temp.newtemp())

    fun exp(InFrame offset) = Tree.MEM(Tree.BINOP(Tree.PLUS, Tree.TEMP FP, Tree.CONST offset))
      | exp(InReg reg) = Tree.TEMP reg

    fun procEntryExit1(frame,body) = body


end

structure Frame : FRAME = MipsFrame