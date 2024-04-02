structure Liveness : LIVENESS = 
struct
    (* TODO: may improve *)
    (* type liveSet = unit Temp.Table.table * temp list  *)

    type liveSet = BitArray.array
    (* InstrNode -> liveSet: set of live temporaries at that node*)
    type liveMap = liveSet Flow.Graph.Table.table
    

    val tnodeMap: Graph.node Temp.Table.table ref = ref Temp.Table.empty
    val gtempMap: Temp.temp Graph.Table.table ref = ref Graph.Table.empty

    fun interferenceGraph (Flow.FGRAPH {control, def, use, ismove}) : igraph * (Flow.Graph.node -> Temp.temp list) = 
        let
            val N = Temp.temps - 100
            val reversedNodes = rev (Graph.nodes control)
            val liveInMap: liveMap ref  = ref Flow.Graph.Table.empty
            (* flow-graph node -> set of temps that are live-out at that node *)
            val liveOutMap: liveMap ref  = ref Flow.Graph.Table.empty

            (* Ret: 1. an igraph 2. flow-graph node -> set of temps that are live-out at that node *)
            fun computeLiveness () = 
                let
                    val hasChanged = ref false
                    fun computeOneNodeLivesness node = 
                        let
                            fun lookupLiveSet (liveMap, node) = Option.getOpt(Flow.Graph.Table.look (liveMap, node), BitArray.bits (N, []))
                            val successors = Graph.succ control node
                            (* val liveout = Temp.Table.find liveMap node down *)
                            (* LiveOut[B] = (U, for each S of B's succ) LiveIn[S] *)
                            val liveout = foldl (fn (succ, acc) => BitArray.orb acc (lookupLiveSet (liveInMap, succ))) BitArray.bits (N, []) successors
                            val () = liveOutMap := Flow.Graph.Table.enter (!liveOutMap, node, liveout)

                            val genSet =  Option.getOpt(Graph.Table.look(use, node), BitArray.bits (N, []))
                            val killSet =  Option.getOpt(Graph.Table.look(def, node), BitArray.bits (N, []))
                            
                            (* LiveIn[B] = (LiveOut[B] - Kill[B]) U Gen[B] *)
                            (* Perform AND NOT operation: clear bits set in Kill[B] *)
                            (* Perform OR operation: add bits set in Gen[B] *)
                            val liveIn = BitArray.orb (BitArray.andb (liveout, BitArray.notb killSet, N), genSet, N)

                            (* this is to compare the old and new *)
                            (* live in: y, x:= 3;, live out: y*)
                            val oldLiveInMap = lookupLiveSet (liveInMap, node)
                        in
                            if BitArray.isZero (BitArray.xorb (liveIn, oldLiveInMap, N)) then
                                (Temp.Table.insert liveInMap node liveIn; hasChanged := true)
                            else
                                ()
                        end
                in
                    (app computeOneNodeLivesness reversedNodes;
                    if hasChanged then
                        computeLiveness()
                    else
                        ())
                end
            
            fun addAllINodes () = 
                let
                    val igraph = G.empty()
                    fun addNodeByTemp (1) = G.newNode igraph;
                        addNodeByTemp (n) = 
                            (G.newNode igraph; 
                            addNodeByTemp (n-1))
                in
                    addNodeByTemp N;
                    IGRAPH {
                        graph = igraph,
                        tnode = 
                    }
                end

            (* add edge to igraph, process 1 liveout set at a moment *)
            fun processOneLiveSet (ls : liveSet) = 
                let
                    fun getOneIdxLst (idx, []) = []
                    | getOneIdxLst (idx, temp::lst) = if temp = 1 then idx::getOneIdxLst(idx + 1, lst) else getOneIdxLst(idx + 1, lst)
                    val nodes = G.nodes igraph 
                    val oneIdLst = getOneIdxLst(0, BitArray.getBits(liveSet))
                    val num = length oneIdLst
                    fun createEdge (0, -1) = () (* return case *)
                        | createEdge (i, -1) = createEdge(i - 1, num)
                        | createEdge (i, j) = 
                            let    
                                val n1 = List.nth(nodes, i)
                                val n2 = List.nth(nodes, j)
                            in
                                G.mk_edge {from = n1, to = n2};
                                G.mk_edge {from = n2, to = n1};
                                createEdge (i, j - 1)
                            end
                in
                    createEdge (num-1, num-1)
                end
            
        in
            computeLiveness();
            addAllINodes();
            app processOneLiveSet liveOutMap.values()
        end 

    fun show (outs, ig) : unit = ()
end