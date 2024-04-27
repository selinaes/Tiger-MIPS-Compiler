structure Dominator : DOMINATOR = 
struct
    type dSet = BitArray.array
    (* InstrNode -> rdSet: set of reachable definition instr # *)
    type dMap = dSet Graph.Table.table
    structure G = Graph
    structure NodeSet = RedBlackSetFn (struct
                type ord_key = Graph.node
                val compare = Graph.compareNode
    end);
    
    fun handleDominators (Flow.FGRAPH {control, def, use, rdgen, rdkill, ismove}) = 
        let
            val nodes = G.nodes control
            val N = length nodes
            val dominateMap: dMap ref  = ref Graph.Table.empty

            fun setToString(ds:dSet) = 
                let
                    val oneIdLst = BitArray.getBits(ds)
                    fun oneIdToString (id) = Int.toString id ^ " "
                in
                    foldl (fn (id, acc) => acc ^ oneIdToString id) "" oneIdLst
                end

            (* Compute inSet and outSet *)
            fun computeDomination () = 
                let
                    val startNode = List.hd(G.nodes control)
                    val hasChanged = ref false
                    fun computeOneNodeDom node = 
                        let
                            fun lookupSet (map, node) = Option.getOpt(Graph.Table.look (map, node), BitArray.notb(BitArray.bits (N, [])))
                            val predecessors = Graph.pred node

                            (* D[n] = {n} U (intersect, for each pred of n, D[pred])*)
                            val dominators = foldl (fn (pred, acc) => ((BitArray.intersection acc (lookupSet (!dominateMap, pred))); acc)) (BitArray.notb(BitArray.bits (N, []))) predecessors
                            val _ = BitArray.setBit(dominators, Graph.nodenum node)

                            (* this is to compare the old and new *)
                            val oldDom = lookupSet(!dominateMap, node)
                        in
                            if (not (BitArray.isZero (BitArray.xorb (dominators, oldDom, N))))
                             then
                                (   dominateMap := Graph.Table.enter (!dominateMap, node, dominators);
                                    hasChanged := true)
                            else
                                ()
                        end
                in
                    (
                        dominateMap := Graph.Table.enter(!dominateMap, startNode, BitArray.bits(N, [0]));
                        app computeOneNodeDom (List.tl (Graph.nodes control));
                        if !hasChanged then
                            computeDomination()
                        else
                            app (fn (k: int,v) => (print ("Instr" ^ (Int.toString k) ^ ":"^ setToString(v) ^ "\n"))) (G.Table.listItemsi(!dominateMap))
                    )
                end

            val _ = computeDomination()
            (* val gr = G.newGraph()
            val igraph = addAllINodes(gr)
            val igraph' = addAllMoves(igraph)
            val _ = app (fn (k: int,v) => (addEdgesAtOneLiveset(k, v, gr))) (G.Table.listItemsi(!liveOutMap)) *)
            (* val _ = app (fn (k: int,v) => (print ("n"^(Int.toString k)^": ");addEdgesAtOneLiveset(v, gr))) (G.Table.listItemsi(!liveOutMap)) *)

        in
            (* (igraph', 
            fn node => Option.getOpt(Graph.Table.look(!liveOutMap, node), 
                    ErrorMsg.impossible "interferenceGraph: liveOutMap can't find")) *)
            ()
        end
    
    (* startNode endNode (dominator, dominatee)
    start -> end, each instru (mid of loop)
            for each src(temp111)
                see nearest reach def of src  temp111 -  5 
                if all src outside loop -> hoist *)

    fun findLoops (Flow.FGRAPH {control, def, use, rdgen, rdkill, ismove}, domiMap : dMap) : (Graph.node * Graph.node) list =
         (* n -> b, b is n's succ, if b dom n, n->b is backedge. Return (from, to) = (b,n) *)
        let
            val fnodes = G.nodes control
            fun handleOneNode(n: Graph.node, acc: (Graph.node * Graph.node) list) = 
                let
                    val successorsIdxs = map Graph.nodenum (Graph.succ n)
                    val doms: ds = valOf(Graph.Table.look (domiMap, n))
                    val succBA: ds = BitArray.bits(N, [successorsIdxs])
                    val backTargets = BitArray.andb(succBA, doms, N)
                    val backTgtLst = BitArray.getBits(backTargets)
                in
                    acc @ (map (fn tgt => (List.nth(fnodes, tgt), n)) backTgtLst)
                end
        in
            foldl handleOneNode [] fnodes
        end
        


    fun processOneLoop (from, to, Flow.FGRAPH {control, def, use, rdgen, rdkill, ismove}, instrs) = 
        let
            rdInMap rdOutMap
            val inLoopNodesSet: NodeSet = ref NodeSet.empty

            fun dfs([]: Graph.node list, visited: NodeSet.set) = ()
            | dfs(current::stack, visited) = 
                let
                    val successors = Graph.succ current
                in  
                    if (Graph.nodenum current) = (Graph.nodenum to) then ()
                    else
                        app (fn n => if NodeSet.member(visited, n) 
                                    then () 
                                    else (NodeSet.add(!inLoopNodesSet, current); 
                                        dfs(n::stack, NodeSet.add(visited, n))))
                            successors
                end
                
            (* Only need to process the path from -> to*)
            fun processOneNodeInBetween (curr, to) = 
                if curr = to then []
                else
                    let
                        val reachableNodes = Graph.Table.look(!rdOutMap, curr) (* for each instruction*)
                        fun reachableNodesOutLoop [] = true
                            | reachableNodesOutLoop node::rest = 
                                if NodeSet.member(!inLoopNodesSet, node) then false 
                                else reachableNodesOutLoop rest
                    in
                        if reachableNodesOutLoop reachableNodes then curr::processOneNodeInBetween
                    end
        in
            dfs([from], NodeSet.empty);
            processOneNodeInBetween
        end

    fun loopReachDefOptimize (Flow.FGRAPH {control, def, use, rdgen, rdkill, ismove}) = 
        let

        in
            
        end
end 