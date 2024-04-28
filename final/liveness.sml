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

    fun handleLiveness(Flow.FGRAPH {control, nodeToInstr,labelNodeMap, def, use, rdgen, rdkill, ismove}) =
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
                
            
        in
            computeLiveness ();
            (* print("nodes: " ^ Int.toString(length (Graph.nodes control)));
            print("liveOutMap: ");
            app (fn (k: int,v) => (print ("n"^(Int.toString k)^", "))) (G.Table.listItemsi(!liveOutMap)); *)
            (!liveInMap, !liveOutMap)
        end

    fun livesetToString(ls:liveSet) = 
        let
            val oneIdLst = BitArray.getBits(ls)
            fun oneIdToString (id) = Int.toString id ^ " "
        in
            foldl (fn (id, acc) => acc ^ oneIdToString id) "" oneIdLst
        end


    (* igraph * (Graph.node -> Temp.temp list) *)
    fun interferenceGraph (fgr as Flow.FGRAPH {control, def, use, ismove, ...}) : igraph * (Graph.node -> liveSet) = 
        let
            val N = Temp.getTemps() - 100
         

            fun addAllINodes (graph: G.graph) = 
                let
                    fun addNodeByTemp n = 
                        let fun helper (i, n) = 
                                if i = n then ()
                                else let
                                        val newNode = G.newNode graph
                                        val tnum = i + 100
                                    in
                                        tnodeMap := Temp.Table.enter (!tnodeMap, tnum, newNode);
                                        gtempMap := Graph.Table.enter (!gtempMap, newNode, tnum); 
                                        helper (i + 1, n)
                                    end  
                        in
                            helper(0, n)
                        end
                in
                    (   
                        addNodeByTemp N;

                    IGRAPH {
                        graph = graph,
                        tnode = fn temp => 
                        (case (Temp.Table.look (!tnodeMap, temp)) of 
                            SOME v => v
                            | _ => ErrorMsg.impossible "addNodeByTemp, tnodeMap"),
                        gtemp = fn node => 
                        (case (Graph.Table.look (!gtempMap, node)) of 
                            SOME v => v
                            | _ => ErrorMsg.impossible "addNodeByTemp, gtempMap"),
                        moves = []
                    })
                end
            
            fun addAllMoves (IGRAPH {graph=gr, tnode, gtemp, moves}) = 
                let
                   fun addOneMove ([defidx], [useidx], prevmoves) = 
                        let
                        (* val _ = List.app (fn (k,v) => (print (Temp.makestring k ^ " -> " ^ G.nodename v ^ "\n")) ) (Temp.Table.listItemsi(!tnodeMap)) *)
                            val deftnode = tnode (defidx+100)
                            val usetnode = tnode (useidx+100)
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
                                    (* print ("addOneMove\n"); *)
                                    addOneMove(defidx, useidx, prevmoves)
                                end
                            (* | SOME (false) => (print "false :no moves\n";prevmoves)  *)
                            | _ => (prevmoves)
                 in 
                    IGRAPH {
                        graph = gr,
                        tnode = tnode,
                        gtemp = gtemp,
                        moves = foldl checkAndAddMove moves (Graph.nodes control) 
                    }
                end

            (* add edge to igraph, process 1 liveout set at a moment *)
            fun addEdgesAtOneLiveset (k: int, ls : liveSet, gr: Graph.graph) = 
                let
                    val instrNode = List.nth(G.nodes control, k)

                    val defba = Option.getOpt(Graph.Table.look(def, instrNode), BitArray.bits (N, []))            
                    val defidxs = BitArray.getBits defba
(* 
                    val _ = print ("f" ^ (Int.toString k) ^ ":"^ livesetToString(ls) ^ "    ;   ");
                    val _ = print ("defidxs are ")
                    val _ = app (fn x => print("n"^Int.toString x ^ ", ")) defidxs 
                    val _ = print ("\n") *)

                    val nodes = G.nodes gr
                    val oneIdLst = BitArray.getBits(ls) (* ids whose bit=1 *)
                    (* val num = length oneIdLst *)
                    fun createEdge oneId = 
                        let
                            val n1 = List.nth(nodes, oneId)
                            val lst = List.filter (fn x => x <> oneId) defidxs
                            fun secondLoop (i) = 
                                let
                                    val n2 = List.nth(nodes, i)
                                in
                                    G.mk_edge {from = n1, to = n2};
                                    G.mk_edge {from = n2, to = n1}
                                    (* print ("n1, n2: " ^ Graph.nodename n1 ^ ", " ^ Graph.nodename n2 ^ "\n") *)
                                end
                        in
                            app secondLoop lst
                        end
                in
                    
                    app createEdge oneIdLst
                end
                
            val _ = gtempMap := Graph.Table.empty
            val _ = tnodeMap := Temp.Table.empty
            val (liveInMap, liveOutMap) = handleLiveness(fgr)
            val gr = G.newGraph()
            val igraph = addAllINodes(gr)
            val igraph' = addAllMoves(igraph)
            val _ = app (fn (k: int,v) => (addEdgesAtOneLiveset(k, v, gr))) (G.Table.listItemsi(liveOutMap))
            (* val _ = app (fn (k: int,v) => (print ("n"^(Int.toString k)^": ");addEdgesAtOneLiveset(v, gr))) (G.Table.listItemsi(!liveOutMap)) *)

        in
            (igraph', 
            fn node => Option.getOpt(Graph.Table.look(liveOutMap, node), 
                    ErrorMsg.impossible "interferenceGraph: liveOutMap can't find"))
        end 

   
end