signature LIVENESS =
sig
    datatype igraph =
        IGRAPH of  {graph: Graph.graph,
                    tnode: Temp.temp -> Graph.node,
                    gtemp: Graph.node -> Temp.temp,
                    moves: (Graph.node * Graph.node) list}
    val interferenceGraph: Flow.flowgraph -> igraph * (Graph.node -> BitArray.array)
    val show: TextIO.outstream * igraph -> unit
end