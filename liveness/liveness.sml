structure Liveness : LIVENESS = 
struct
    (* TODO: may improve *)
    (* type liveSet = unit Temp.Table.table * temp list  *)
    datatype igraph =
        IGRAPH of  {graph: Graph.graph,
                    tnode: Temp.temp -> Graph.node,
                    gtemp: Graph.node -> Temp.temp,
                    moves: (Graph.node * Graph.node) list}
                    
    type liveSet = BitArray.array
    (* InstrNode -> liveSet: set of live temporaries at that node*)
    type liveMap = liveSet Graph.Table.table
    structure G = Graph
    

    val tnodeMap: Graph.node Temp.Table.table ref = ref Temp.Table.empty
    val gtempMap: Temp.temp Graph.Table.table ref = ref Graph.Table.empty

    fun show (out, ig) : unit = 
        let
            val IGRAPH {graph, tnode, gtemp, moves} = ig
            fun printMoves (out, []) = TextIO.output(out, "no moves\n")
                | printMoves (out, (n1, n2)::moves) = 
                        (TextIO.output(out, G.nodename n1 ^ " -> " ^ G.nodename n2 ^ "\n");
                        printMoves(out, moves))
        in
            Graph.printGraph (out, graph);
            TextIO.output(out, "Moves: \n");
            printMoves (out, moves)
        end
    (* igraph * (Graph.node -> Temp.temp list) *)
    fun interferenceGraph (Flow.FGRAPH {control, def, use, ismove}) : igraph * (Graph.node -> liveSet) = 
        let
            val N = Temp.getTemps() - 100
            val reversedNodes = rev (Graph.nodes control)
            val liveInMap: liveMap ref  = ref Graph.Table.empty
            (* flow-graph node -> set of temps that are live-out at that node *)
            val liveOutMap: liveMap ref  = ref Graph.Table.empty

            (* Ret: 1. an igraph 2. flow-graph node -> set of temps that are live-out at that node *)
            
            fun computeLiveness () = 
                let
                    val hasChanged = ref false
                    fun computeOneNodeLivesness node = 
                        let
                            fun lookupLiveSet (liveMap, node) = Option.getOpt(Graph.Table.look (liveMap, node), BitArray.bits (N, []))
                            val successors = Graph.succ node
                            (* LiveOut[B] = (U, for each S of B's succ) LiveIn[S] *)
                            val liveout: liveSet = foldl (fn (succ, acc) => BitArray.orb (acc, (lookupLiveSet (!liveInMap, succ)), N)) (BitArray.bits (N, [])) successors
                            val () = liveOutMap := Graph.Table.enter (!liveOutMap, node, liveout)

                            val genSet =  Option.getOpt(Graph.Table.look(use, node), BitArray.bits (N, []))
                            val killSet =  Option.getOpt(Graph.Table.look(def, node), BitArray.bits (N, []))
                            
                            (* LiveIn[B] = (LiveOut[B] - Kill[B]) U Gen[B] *)
                            (* Perform AND NOT operation: clear bits set in Kill[B] *)
                            (* Perform OR operation: add bits set in Gen[B] *)
                            val liveIn = BitArray.orb (BitArray.andb (liveout, BitArray.notb killSet, N), genSet, N)

                            (* this is to compare the old and new *)
                            val oldLiveInMap = lookupLiveSet (!liveInMap, node)
                        in
                            if not (BitArray.isZero (BitArray.xorb (liveIn, oldLiveInMap, N))) then
                                (liveInMap := Graph.Table.enter (!liveInMap,node,liveIn); hasChanged := true)
                            else
                                ()
                        end
                in
                    (app computeOneNodeLivesness reversedNodes;
                    if !hasChanged then
                        computeLiveness()
                    else
                        ())
                end

            fun livesetToString(ls:liveSet) = 
                let
                    val oneIdLst = BitArray.getBits(ls)
                    fun oneIdToString (id) = Int.toString id ^ " "
                in
                    foldl (fn (id, acc) => acc ^ oneIdToString id) "" oneIdLst
                end
            
            fun addAllINodes (graph: G.graph) = 
                let
                    fun addNodeByTemp (1) = G.newNode graph
                      | addNodeByTemp (n) = 
                        let
                            val newNode = G.newNode graph
                        in
                            tnodeMap := Temp.Table.enter (!tnodeMap, n, newNode);
                            gtempMap := Graph.Table.enter (!gtempMap, newNode, n); 
                            addNodeByTemp (n-1)
                        end  
                in
                    (addNodeByTemp N;
                    IGRAPH {
                        graph = graph,
                        tnode = fn temp => Option.getOpt(Temp.Table.look (!tnodeMap, temp), ErrorMsg.impossible "addNodeByTemp, tnodeMap"),
                        gtemp = fn node => Option.getOpt(Graph.Table.look (!gtempMap, node), ErrorMsg.impossible "addNodeByTemp, gtempMap"),
                        moves = []
                    })
                end
            
            fun addAllMoves (IGRAPH {graph=gr, tnode, gtemp, moves}) = 
                let
                   fun addOneMove ([defidx], [useidx], prevmoves) = 
                        let
                            val deftnode = tnode defidx
                            val usetnode = tnode useidx
                        in
                            (deftnode, usetnode)::prevmoves
                        end
                    | addOneMove(_,_,_) = ErrorMsg.impossible "addOneMove: multiple def or use temps" 
                
                    fun checkAndAddMove (instrNode, prevmoves) = 
                        case Graph.Table.look(ismove, instrNode) of 
                            SOME (true) =>
                                let
                                    val defba = Option.getOpt(Graph.Table.look(def, instrNode), BitArray.bits (N, []))
                                    val useba = Option.getOpt(Graph.Table.look(use, instrNode), BitArray.bits (N, []))
                                    val defidx = BitArray.getBits defba
                                    val useidx = BitArray.getBits useba
                                in 
                                    addOneMove(defidx, useidx, prevmoves)
                                end
                            | _ => prevmoves    
                 in 
                    IGRAPH {
                        graph = gr,
                        tnode = tnode,
                        gtemp = gtemp,
                        moves = foldl checkAndAddMove moves (Graph.nodes control) 
                    }
                end

            (* add edge to igraph, process 1 liveout set at a moment *)
            fun addEdgesAtOneLiveset (ls : liveSet, gr: Graph.graph) = 
                let
                    val nodes = G.nodes gr
                    val oneIdLst = BitArray.getBits(ls) 
                    val num = length oneIdLst
                    fun createEdge oneId = 
                        let
                            val n1 = List.nth(nodes, oneId)
                            val lst = List.filter (fn x => x <> oneId) oneIdLst
                            fun secondLoop (i) = 
                                let
                                    val n2 = List.nth(nodes, i)
                                in
                                    G.mk_edge {from = n1, to = n2};
                                    G.mk_edge {from = n2, to = n1}
                                end
                        in
                            app secondLoop lst
                        end
                in
                    print (livesetToString(ls) ^ "\n");
                    app createEdge oneIdLst
                end
                
            val _ = computeLiveness()
            val gr = G.newGraph()
            val igraph = addAllINodes(gr)
            val igraph' = addAllMoves(igraph)
            (* (fgraph node : liveset) *)
            val _ = app (fn (k: int,v) => (print ("n"^(Int.toString k)^": ");addEdgesAtOneLiveset(v, gr))) (G.Table.listItemsi(!liveOutMap))
            (* val _ = app (fn (k: int,v) => (G.printNode(control,k);addEdgesAtOneLiveset(v, gr))) (G.Table.listItemsi(!liveOutMap)) *)
            (* val _ = show (TextIO.stdOut, igraph) *)
        in
            (igraph', 
            fn node => Option.getOpt(Graph.Table.look(!liveOutMap, node), 
                    ErrorMsg.impossible "interferenceGraph: liveOutMap can't find"))
        end 

   
end