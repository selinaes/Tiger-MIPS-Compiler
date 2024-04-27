signature REACHING_DEF =
sig
    type rdSet = BitArray.array
    (* InstrNode -> rdSet: set of reachable definition instr # *)
    type rdMap = rdSet Graph.Table.table
    val handleReachingDef: Flow.flowgraph -> rdMap
end