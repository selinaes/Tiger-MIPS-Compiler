signature DOMINATOR =
sig
    type dSet = BitArray.array
    type dMap = dSet Graph.Table.table
    val loopReachDefOptimize: Flow.flowgraph * Assem.instr list *  Reaching_Def.rdMap -> Assem.instr list
end