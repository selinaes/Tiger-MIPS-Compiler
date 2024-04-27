signature MAKE_GRAPH =
sig
    val instrs2graph: Assem.instr list -> Flow.flowgraph * Graph.node list
    val printInstrs: Assem.instr list -> unit 
end