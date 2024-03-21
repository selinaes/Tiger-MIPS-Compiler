
signature FRAME = sig 
    type frame
    type access
    datatype frag = PROC of {body: Tree.stm, frame: frame} 
                  | STRING of Temp.label * string
    val wordSize : int
    val RV : Temp.temp
    val FP : Temp.temp
    val newFrame : {name: Temp.label, formals: bool list} -> frame 
    val name : frame -> Temp.label
    val formals : frame -> access list
    (*Frame.allocLocal(f)(true) -> allocate a new localVar in frame f. T=escape, frame, F = to reg Temp*)
    val allocLocal : frame -> bool -> access 
    
    val exp : access -> Tree.exp -> Tree.exp (* InFrame/InReg -> (cury)frame pointer -> IR MEM/TEMP *)
    val procEntryExit1 : frame * Tree.stm -> Tree.stm
    val externalCall: string * Tree.exp list -> Tree.exp


end