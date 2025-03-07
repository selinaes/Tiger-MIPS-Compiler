signature GRAPH =
sig
    type graph
    type node

    (* structure NeighborSet = RedBlackSetFn (struct
            type ord_key = node'
            val compare = Int.compare
    end); *)

    val augment: graph -> int -> node
    
    val nodes: graph -> node list
    val succ: node -> node list
    val pred: node -> node list

    val eq: node * node -> bool
    val compareEdge: ((node * node) * (node * node)) -> order
    val compareNode: node * node -> order

    val outdegree: node -> int
    val indegree: node -> int

    val newGraph: unit -> graph
    val newNode : graph -> node
    exception GraphEdge
    val mk_edge: {from: node, to: node} -> unit
    val rm_edge: {from: node, to: node} -> unit

    (* val nth: (graph, int) -> node *)

    structure Table : TABLE 
    sharing type Table.key = node

    val nodename: node -> string  (* for debugging only *)
    val nodenum: node -> int

    val printGraph: TextIO.outstream * graph -> unit
    val printNode: graph * int-> unit


end
