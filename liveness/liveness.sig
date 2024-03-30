structure LIVENESS:
sig
    datatype igraph =
        IGRAPH of  {graph: Graph.graph,
                    tnode: Temp.temp -> Graph.node,
                    gtemp: Graph.node -> Temp.temp,
                    moves: (Graph.node * Graph.node) list}
    val interferenceGraph (flowgraph: Flow.flowgraph): igraph * (Flow.Graph.node -> Temp.temp list) = 
            
    val show(out:outstream, igraph:igraph)= () 
end