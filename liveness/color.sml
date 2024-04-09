structure Color: COLOR = 
struct
    structure Err = ErrorMsg
    type allocation = Frame.register Temp.Table.table
    type edge = (Graph.node * Graph.node)
    structure EdgeSet = RedBlackSetFn (struct
                type ord_key = edge
                val compare = Graph.compareEdge

    end);

    structure NodeSet = RedBlackSetFn (struct
                type ord_key = Graph.node
                val compare = Graph.compareNode
    end);
    (* Graphs *)
    fun color ({interference: Liveness.igraph, initial=allocated: allocation,
                spillCost: Graph.node -> int, registers: Frame.register list})
                : allocation * Temp.temp list = (* Returns: (alloc, list of spills) *)
        let
            val Liveness.IGRAPH {graph, tnode, gtemp, moves} = interference
            (* Node work-lists, sets, and stacks.*)
            val precolored = ref NodeSet.empty (* machine registers, preassigned a color.*)
            val initial = ref NodeSet.empty (* temporary registers, not precolored and not yet processed*)

            val simplifyWorklist = ref NodeSet.empty (* list of low-degree non-move-related nodes.*)
            val freezeWorklist = ref NodeSet.empty (* low-degree move-related nodes..*)
            val spillWorklist = ref NodeSet.empty (* high-degree nodes.*)
            
            val spilledNodes = ref NodeSet.empty (* nodes marked for spilling during this round; initially empty*)
            val coalescedNodes = ref NodeSet.empty (* nodes that have been coalesced*)
            val coloredNodes = ref NodeSet.empty (* nodes successfully colored. *)
            
            val selectStack = ref [] (* stack containing temporaries removed from the graph. *)

            (* Move Sets *)
            val coalescedMoves = ref EdgeSet.empty (* moves that have been coalesced.*)
            val constrainedMoves = ref EdgeSet.empty (* moves whose source and target interfere.*)
            val frozenMoves = ref EdgeSet.empty (* moves that will no longer be considered for coalescing.*)
            val workListMoves = ref EdgeSet.empty (* moves enabled for possible coalescing.*)
            val activeMoves = ref EdgeSet.empty (* moves not yet ready for coalescing.*)
            
            val moveList: EdgeSet.set Temp.Table.table ref = ref Temp.Table.empty
            
            val adjSet: EdgeSet.set ref = ref EdgeSet.empty
            val adjList: NodeSet.set Graph.Table.table ref = ref Graph.Table.empty
            val degree: int Graph.Table.table ref = ref Graph.Table.empty
             
            val color: Frame.register Graph.Table.table ref = ref Graph.Table.empty
            
            (* constructs the interference graph (and bit matrix) using the results of static liveness analysis, and also initializes the worklistMoves to contain all the moves in the program. *)
            fun build() = 
                let    
                    fun buildAdjSetAdjList () = 
                        let
                            fun addOneIEdge (u:Graph.node, v:Graph.node) = 
                                if (not (Graph.eq(u, v))) then
                                    (adjSet := EdgeSet.add(!adjSet, (u, v));
                                    adjSet := EdgeSet.add(!adjSet, (v, u));
                                    if not (NodeSet.member(!precolored, u)) then
                                        adjList := Graph.Table.enter(!adjList, u, NodeSet.add(Option.getOpt(Graph.Table.look(!adjList, u), NodeSet.empty), v))
                                    else ();
                                    if not (NodeSet.member(!precolored, v)) then
                                        adjList := Graph.Table.enter(!adjList, v, NodeSet.add(Option.getOpt(Graph.Table.look(!adjList, v), NodeSet.empty), u))
                                    else ())
                                else ()
                            fun processOneNode n = 
                                let
                                
                                    val adj = Graph.pred n (* since pred and succ are all the same, choose either one is ok *)
                                in
                                    app (fn m => addOneIEdge(n, m)) adj
                                end
                            in
                            app processOneNode (Graph.nodes graph)
                        end

                    (* AdjList: NodeSet.set Graph.Table.table ref -> node : nodeset *)
                    (*  val appi: ((int * 'a) -> unit) -> 'a table -> unit *)
                    fun computeDegree () = 
                        let
                            fun addNodesDegree (n: int, adjs: NodeSet.set) = 
                                degree := Graph.Table.enter(!degree, Graph.augment graph n, NodeSet.numItems adjs)
                        in
                            Graph.Table.appi addNodesDegree (!adjList)
                        end
                        
                    fun initColor (node: Graph.node) = 
                            (
                                (* print ("initColor: " ^ Graph.nodename node ^ "\n"); *)
                                case Temp.Table.look(allocated, gtemp node) of
                            SOME reg => (color := Graph.Table.enter(!color, node, reg); 
                                        precolored := NodeSet.add(!precolored, node))
                            | NONE => initial := NodeSet.add(!initial, node))
                        
                            
                    fun addMoves (n1: Graph.node, n2: Graph.node) = 
                            (moveList := Temp.Table.enter (!moveList, gtemp n1, 
                               EdgeSet.add(Option.getOpt(Temp.Table.look(!moveList, gtemp n1), EdgeSet.empty), (n1,n2)));
                            moveList := Temp.Table.enter (!moveList, gtemp n2, 
                               EdgeSet.add(Option.getOpt(Temp.Table.look(!moveList, gtemp n2), EdgeSet.empty), (n1,n2)));
                            workListMoves := EdgeSet.add(!workListMoves, (n1, n2)))
                in
                    (buildAdjSetAdjList (); computeDegree(); List.app initColor (Graph.nodes graph); app addMoves moves)
                end
                
            fun nodeMoves (n: Graph.node) = 
                case Temp.Table.look(!moveList, gtemp n) of 
                    SOME m => EdgeSet.intersection(m, EdgeSet.union(!activeMoves, !workListMoves))
                    | NONE => EdgeSet.empty
                    (* (print (Graph.nodename n);ErrorMsg.impossible "nodeMoves") *)
            
            fun moveRelated (n) = not (EdgeSet.isEmpty(nodeMoves(n)))
            fun addNodeToWL n = 
                if (Graph.indegree n >= length registers) 
                then
                    (spillWorklist := NodeSet.add(!spillWorklist, n))
                else
                    if moveRelated n
                    then 
                        (freezeWorklist := NodeSet.add(!freezeWorklist, n))
                    else
                        (simplifyWorklist := NodeSet.add(!simplifyWorklist, n))

             fun makeWorklist() = 
                (NodeSet.app addNodeToWL (!initial); initial := NodeSet.empty)
            (* Node in igraph 'graph' *)
            (* fun addEdge((g,u):Graph.node, (g',v):Graph.node) = 
                if (not (Graph.isAdjacent(g, u, v)) andalso u <> v) then
                    (Graph.mk_edge(u, v); Graph.mk_edge(v, u))
                else () *)
            

            fun adjacent (n) = 
                let val adjLstOfn = case Graph.Table.look(!adjList, n) of
                                SOME lst => lst
                                | NONE => NodeSet.empty
                in
                    NodeSet.subtractList (adjLstOfn, !selectStack)
                end
                
         
            fun enableMoves(nodes) = 
                let
                  fun forEachN n= 
                    let
                        val moves = nodeMoves n
                        fun forEachM m = 
                            if EdgeSet.member(!activeMoves, m) then
                                (activeMoves := EdgeSet.delete(!activeMoves, m);
                                workListMoves := EdgeSet.add(!workListMoves, m))
                            else ()
                    in
                        EdgeSet.app forEachM moves
                    end
                in
                  NodeSet.app forEachN nodes
                end
            
            fun decrementDegree(m) = 
                let
                    val d = case Graph.Table.look(!degree, m) of
                                SOME d => d
                                | NONE => ErrorMsg.impossible "decrementDegree node not exist"
                    
                in
                    Graph.Table.enter(!degree, m, d-1);
                    if d = length registers 
                    then
                       (enableMoves(NodeSet.union(NodeSet.singleton(m), adjacent(m))); 
                        spillWorklist := NodeSet.delete(!spillWorklist, m);
                        if moveRelated m then
                            freezeWorklist := NodeSet.add(!freezeWorklist, m)
                        else
                            simplifyWorklist := NodeSet.add(!simplifyWorklist, m)
                        )
                    else ()
                end
        
            fun simplify() = 
                let
                    fun simplifyOneNode n = 
                        (simplifyWorklist := NodeSet.delete(!simplifyWorklist, n);
                        selectStack := !selectStack@[n];
                        NodeSet.app (fn m => decrementDegree m) (adjacent n))

                in
                    NodeSet.app simplifyOneNode (!simplifyWorklist)
                end
            
            (* Pre-coalesce version *)
            fun assignColors() = 
                let
                    fun forNinStack n =
                        let
                            val okColors = ref registers
                            fun forEachW w = 
                                if NodeSet.member(NodeSet.union(!coloredNodes, !precolored), w)
                                then 
                                    case Graph.Table.look(!color, w) of
                                        SOME c => okColors := List.filter (fn r => r <> c) (!okColors)
                                        | NONE => ()
                                else ()
                            val ws = case Graph.Table.look(!adjList, n) of
                                        SOME ws => ws
                                        | NONE => ErrorMsg.impossible "assignColors cannot find node in adjList"
                        in
                            NodeSet.app forEachW ws;
                            if List.null (!okColors) then
                                spilledNodes := NodeSet.add(!spilledNodes, n)
                            else
                                (Graph.Table.enter(!color, n, hd (!okColors));
                                coloredNodes := NodeSet.add(!coloredNodes, n))
                        end
                in
                    app forNinStack (rev(!selectStack))
                end
            
            (*color = node:register, alloc = temp:register*)
            fun colorToAllocation() = 
                let
                    val finalAlloc : allocation ref = ref Temp.Table.empty
                    fun forN (n:Graph.node) = 
                        case Graph.Table.look(!color, n) of
                            SOME r => finalAlloc := Temp.Table.enter(!finalAlloc, gtemp n, r)
                            | NONE => ErrorMsg.impossible "colorToAllocation unfound"
                in
                    (NodeSet.app forN (!coloredNodes);
                    !finalAlloc)
                end
        in
            (
            build();
            makeWorklist();
            simplify();
            assignColors();
            (colorToAllocation(), List.map gtemp (NodeSet.toList(!spilledNodes)))
            )
        end

end