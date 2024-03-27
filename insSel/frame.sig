
signature FRAME = sig 
    type frame
    type access
    type register
    datatype frag = PROC of {body: Tree.stm, frame: frame} 
                  | STRING of Temp.label * string
    val wordSize : int
   
    val newFrame : {name: Temp.label, formals: bool list} -> frame 
    val name : frame -> Temp.label
    val formals : frame -> access list
    (*Frame.allocLocal(f)(true) -> allocate a new localVar in frame f. T=escape, frame, F = to reg Temp*)
    val allocLocal : frame -> bool -> access 
    val string : Temp.label * string -> string
    
    val exp : access -> Tree.exp -> Tree.exp (* InFrame/InReg -> (cury)frame pointer -> IR MEM/TEMP *)
    val procEntryExit1 : frame * Tree.stm -> Tree.stm
    val procEntryExit2 : frame * Assem.instr list -> Assem.instr list
    val procEntryExit3 : frame * Assem.instr list -> {prolog: string, body: Assem.instr list, epilog: string}
    val externalCall: string * Tree.exp list -> Tree.exp

    val printFrag: TextIO.outstream * frag list -> unit

    val tempToString : Temp.temp -> string
    val tempMap: register Temp.Table.table
    val FP : Temp.temp
    val SP : Temp.temp
    val RA : Temp.temp
    val ZERO : Temp.temp
    (* Reserved for assembler *)
    val AT : Temp.temp
    (* First and second return values *)
    val RV : Temp.temp
    val V1 : Temp.temp
    (* First four arguments to functions *)
    val A0 : Temp.temp
    val A1 : Temp.temp
    val A2 : Temp.temp
    val A3 : Temp.temp
    (* Temporary registers (caller saves) *)
    val T0 : Temp.temp
    val T1 : Temp.temp
    val T2 : Temp.temp
    val T3 : Temp.temp
    val T4 : Temp.temp
    val T5 : Temp.temp
    val T6 : Temp.temp
    val T7 : Temp.temp
    (* Saved registers (callee saves) *)
    val S0 : Temp.temp
    val S1 : Temp.temp
    val S2 : Temp.temp
    val S3 : Temp.temp
    val S4 : Temp.temp
    val S5 : Temp.temp
    val S6 : Temp.temp
    val S7 : Temp.temp
    (* More temporary registers *)
    val T8 : Temp.temp
    val T9 : Temp.temp
    (* Reserved for kernel (operating system) *)
    val K0 : Temp.temp
    val K1 : Temp.temp
    (* Global pointer *)
    val GP : Temp.temp

    val specialregs: Temp.temp list
    val argregs: Temp.temp list
    val calleesaves: Temp.temp list
    val callersaves: Temp.temp list
end