signature REG_ALLOC =
sig
    (* structure Frame : FRAME *)

    type allocation = Frame.register Temp.Table.table
    val printAllocation: (TextIO.outstream * allocation) -> unit

    val alloc : Assem.instr list * Frame.frame ->
                Assem.instr list * allocation
end