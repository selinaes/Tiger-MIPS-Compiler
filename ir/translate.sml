structure Translate : TRANSLATE = 
    struct type exp = unit 

    datatype level = OUTMOST | LEVEL of {parent : level, frame : Frame.frame, unique: unit ref}
    val outermost = OUTMOST
    type access = level * Frame.access

    structure Err = ErrorMsg

    fun newLevel {parent: level, name: Temp.label, formals: bool list} : level =
        LEVEL {parent=parent, frame=Frame.newFrame({name, formals = true::formals}), unique=ref ()}
    
    (* because F.formals returns a F.access list, not a TR.access list *)
    fun formals lvl : access list (* include the 0th - static link's access*) = 
        case lvl of
            OUTMOST => []
          | LEVEL {parent, frame, unique} => map (fn (frmaccs) => (lvl, frmaccs)) (Frame.formals frame)
        
    fun allocLocal OUTMOST (b:bool) : access = (Err error 0 "cannot allocate at outmost frame. \n"; (OUTMOST, Frame.InFrame 0))
    | allocLocal LEVEL {parent, frame, unique} (b:bool) = (LEVEL {parent, frame, unique}, Frame.allocLocal frame b)
end
