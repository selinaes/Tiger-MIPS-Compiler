signature REACHING_DEF =
sig
    datatype igraph =
        IGRAPH of  {graph: Graph.graph,
                    tnode: Temp.temp -> Graph.node,
                    gtemp: Graph.node -> Temp.temp,
                    moves: (Graph.node * Graph.node) list}
    val handleReachingDef: Flow.flowgraph -> unit
    val show: TextIO.outstream * igraph -> unit
end