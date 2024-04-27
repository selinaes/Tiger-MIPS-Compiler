structure Reaching_Def : REACHING_DEF = 
struct
    type rdSet = BitArray.array
    (* InstrNode -> rdSet: set of reachable definition instr # *)
    type rdMap = rdSet Graph.Table.table
    structure G = Graph
    
    fun handleReachingDef (Flow.FGRAPH {control, nodeToInstr,labelNodeMap, def, use, rdgen, rdkill, ismove}) = 
        let
            val nodes = G.nodes control
            val N = length nodes
            val rdInMap: rdMap ref  = ref Graph.Table.empty
            val rdOutMap: rdMap ref  = ref Graph.Table.empty

            fun rdsetToString(rs:rdSet) = 
                let
                    val oneIdLst = BitArray.getBits(rs)
                    fun oneIdToString (id) = Int.toString id ^ " "
                in
                    foldl (fn (id, acc) => acc ^ oneIdToString id) "" oneIdLst
                end

            (* Compute inSet and outSet *)
            fun computeReaching () = 
                let
                    val hasChanged = ref false
                    fun computeOneNodeReaching node = 
                        let
                            fun lookupRdSet (rdMap, node) = Option.getOpt(Graph.Table.look (rdMap, node), BitArray.bits (N, []))
                            val predecessors = Graph.pred node
                            (* RD-In[B] = (U, for each P of B's pred) RD-Out[p] *)
                            val rdIn: rdSet = foldl (fn (pred, acc) => BitArray.orb (acc, (lookupRdSet (!rdOutMap, pred)), N)) (BitArray.bits (N, [])) predecessors

                            val genSet =  Option.getOpt(Graph.Table.look(rdgen, node), BitArray.bits (N, []))
                            val killSet =  Option.getOpt(Graph.Table.look(rdkill, node), BitArray.bits (N, []))
                            
                            (* RD-Out[B] = (RD-In[B] - Kill[B]) U Gen[B] *)
                            (* Perform AND NOT operation: clear bits set in Kill[B] *)
                            (* Perform OR operation: add bits set in Gen[B] *)
                            val rdOut = BitArray.orb (BitArray.andb (rdIn, BitArray.notb killSet, N), genSet, N)

                            (* this is to compare the old and new *)
                            val oldRdOut = lookupRdSet (!rdOutMap, node)
                            val oldRdIn = lookupRdSet (!rdInMap, node)

                        in
                            if (not (BitArray.isZero (BitArray.xorb (rdIn, oldRdIn, N)))) orelse 
                                (not (BitArray.isZero (BitArray.xorb (rdOut, oldRdOut, N))))
                             then
                                (   rdInMap := Graph.Table.enter (!rdInMap, node, rdIn);
                                    rdOutMap := Graph.Table.enter (!rdOutMap,node,rdOut); 
                                    hasChanged := true)
                            else
                                ()
                        end
                in
                    (app computeOneNodeReaching (Graph.nodes control);
                    if !hasChanged then
                        computeReaching()
                    else
                        ()
                        (* app (fn (k: int,v) => (print ("Instr" ^ (Int.toString k) ^ ":"^ rdsetToString(v) ^ "\n"))) (G.Table.listItemsi(!rdInMap)) *)
                    )
                end

            (* val _ = app (fn (k: int,v) => (addEdgesAtOneLiveset(k, v, gr))) (G.Table.listItemsi(!liveOutMap))  *)
            (* val _ = app (fn (k: int,v) => (print ("n"^(Int.toString k)^": ");addEdgesAtOneLiveset(v, gr))) (G.Table.listItemsi(!liveOutMap)) *)

        in
            computeReaching();
            (* (igraph', 
            fn node => Option.getOpt(Graph.Table.look(!liveOutMap, node), 
                    ErrorMsg.impossible "interferenceGraph: liveOutMap can't find")) *)
            !rdInMap
        end 

   
end