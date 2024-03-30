structure MAKEG_RAPH: sig
    val instrs2graph: Assem.instr list -> Flow.flowgraph * Flow.Graph.node list
end