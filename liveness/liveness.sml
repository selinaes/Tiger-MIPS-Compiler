structure Liveness : LIVENESS = 
struct
    (* TODO: may improve *)
    (* type liveSet = unit Temp.Table.table * temp list  *)

    type liveSet = BitArray.array
    (* bits(N, [])    bits(N, [0] * N)*)
    (* InstrNode -> liveSet: set of live temporaries at that node*)
    type liveMap = liveSet Flow.Graph.Table.table
    

    val tnodeMap: Graph.node Temp.Table.table ref = ref Temp.Table.empty
    val gtempMap: Temp.temp Graph.Table.table ref = ref Graph.Table.empty

    fun interferenceGraph (Flow.FGRAPH {control, def, use, ismove}) : igraph * (Flow.Graph.node -> Temp.temp list) = 
        let
            val N = !Temp.temps
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
                in
                    IGRAPH {
                        graph = 
                        tnode = 
                    }
                end
            
            
            
        in
            addAllINodes();
            computeLiveness();
        end 

    fun show (outs, ig) : unit = ()
end