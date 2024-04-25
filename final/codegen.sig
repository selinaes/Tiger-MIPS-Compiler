signature CODEGEN =
sig
    val intToString : int -> string
    val codegen : Frame.frame -> Tree.stm -> Assem.instr list
end