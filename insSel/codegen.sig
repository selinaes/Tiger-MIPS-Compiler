signature CODEGEN =
sig
    val codegen : Frame.frame -> Tree.stm -> Assem.instr list
end