
signature FRAME = sig 
    type frame
    type access
    val newFrame : {name: Temp.label, formals: bool list} -> frame 
    val name : frame -> Temp.label
    val formals : frame -> access list
    (*Frame.allocLocal(f)(true) -> allocate a new localVar in frame f. T=escape, frame, F = to reg Temp*)
    val allocLocal : frame -> bool -> access 
    val wordSize : int
end