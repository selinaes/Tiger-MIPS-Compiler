structure Color: COLOR = 
struct
    structure Err = ErrorMsg
    type allocation = Frame.register Temp.Table.table
    type edge = (Graph.node * Graph.node)
    structure EdgeSet = RedBlackSetFn (struct
                type ord_key = edge
                val compare = Int.compare
    end);

    structure NodeSet = RedBlackSetFn (struct
                type ord_key = Graph.node
                val compare = Int.compare
    end);
    (* Graphs *)
    fun color ({interference: IGRAPH {graph, tnode, gtemp, moves}: Liveness.igraph, initial=allocated: allocation,
                spillCost: Graph.node -> int, registers: Frame.register list})
                : allocation * Temp.temp list = (* Returns: (alloc, list of spills) *)
        let
           
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
            
            val moveList: EdgeSet.set Temp.Table.table = ref Temp.Table.empty
            val workListMoves: move list ref = ref []  
            
            val adjSet: EdgeSet.set ref = ref EdgeSet.empty
            val adjList: NodeSet.set Graph.Table.table ref = ref Graph.Table.empty
            val degree: int Graph.Table.table ref = ref Graph.Table.empty
             
            val color: Frame.register Graph.Table.tabel = Graph.Table.empty
            
            (* constructs the interference graph (and bit matrix) using the results of static liveness analysis, and also initializes the worklistMoves to contain all the moves in the program. *)
            fun build() = 
                let    
                    fun buildAdjSetAdjList () = 
                        let
                            fun addOneIEdge (u, v) = 
                                if (u <> v) then
                                    (adjSet := EdgeSet.add(!adjSet, (u, v));
                                    adjSet := EdgeSet.add(!adjSet, (v, u));
                                    if not (NodeSet.member(!precolored, u)) then
                                        adjList := Graph.Table.enter(!adjList, u, NodeSet.add(Option.optOf(Graph.Table.look(!adjList, u), Graph.Table.empty), v))
                                    else ();
                                    if not (NodeSet.member(!precolored, v)) then
                                        adjList := Graph.Table.enter(!adjList, v, NodeSet.add(Option.optOf(Graph.Table.look(!adjList, v), Graph.Table.empty), u))
                                    else ())
                                else ()
                            fun processOneNode n = 
                                let
                                    val adj = Graph.adjacent n
                                in
                                    app (fn m => addOneIEdge(n, m)) adj
                                end
                            in
                            app processOneNode (Graph.nodes graph)
                        end
                    fun computeDegree () = 
                        Graph.Table.appi (fn (n, adjs) = degree := Graph.Table.enter(!degree, n, NodeSet.numItems adjs)) adjList

                    fun initColor (node as (graph, temp)) = 
                        (case Temp.Table.look(allocated, temp) of
                            SOME reg => (Graph.Table.enter(!color, node, reg); 
                                        NodeSet.add(!precolored, node))
                            | NONE => NodeSet.add(!initial, node))
                            
                    fun addMoves (n1, n2) = 
                            (moveList := Temp.Table.enter (!moveList, n1, 
                               EdgeSet.add(Option.optOf(Temp.Table.look(!moveList, n1), EdgeSet.empty), (n1,n2)));
                            moveList := Temp.Table.enter (!moveList, n2, 
                               EdgeSet.add(Option.optOf(Temp.Table.look(!moveList, n2), EdgeSet.empty), (n1,n2)));
                            workListMoves := (n1, n2) :: !workListMoves)
                in
                    (buildAdjSetAdjList (); computeDegree(); app initColor graph; app addMoves moves)
                end
                
            fun makeWorklist() = 
                (NodeSet.app addNodeToWL !initial; initial := NodeSet.empty)

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
                    NodeSet.substractList (adjLstOfn, selectStack)
                end
                
            fun nodeMoves (n) = 
                case Temp.Table.look(moveList, n) of 
                    SOME m => EdgeSet.intersection(m, EdgeSet.union(activeMoves, workListMoves))
                    | NONE => ErrorMsg.impossible "nodeMoves"
            
            fun moveRelated (n) = not (EdgeSet.isEmpty(nodeMoves(n)))
            
            fun enableMoves(nodes) = 
                let
                  fun forEachN n= 
                    let
                        val moves = nodeMoves n
                        fun forEachM m = 
                            if EdgeSet.member(activeMoves, m) then
                                (activeMoves := EdgeSet.delete(!activeMoves, m);
                                workListMoves := EdgeSet.add(!workListMoves, m))
                            else ()
                    in
                        app forEachM moves
                    end
                in
                  app forEachN nodes
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
                        simplifyWorklist := NodeSet.delete(!simplifyWorklist, n);
                        selectStack := !selectStack@[n];
                        app (fn m => decrementDegree m) (adjacent n)

                in
                    NodeSet.app simplifyOneNode !simplifyWorklist
                end
            
            (* Pre-coalesce version *)
            fun assignColors() = 
                let
                    fun forNinStack n =
                        let
                            val okColors = ref registers
                            fun forEachW w = 
                                if NodeSet.member(NodeSet.union(coloredNodes, precolored), w)
                                then 
                                    okColors := List.filter (fn c => c <> Option.valOf(Graph.Table.look(!color, w))) !okColors
                                else ()
                            val ws = case Graph.Table.look(!adjList, n) of
                                        SOME ws => ws
                                        | NONE => ErrorMsg.impossible "assignColors cannot find node in adjList"
                        in
                            app forEachW ws;
                            if Linull (!okColors) then
                                spilledNodes := NodeSet.add(!spilledNodes, n)
                            else
                                (coloredNodes := NodeSet.add(!coloredNodes, n);
                                Graph.Table.enter(!color, n, hd (!okColors)))
                        end
                in
                    app forNinStack rev(!selectStack)
                end
            
            (*color = node:register, alloc = temp:register*)
            fun colorToAllocation() = 
                let
                    val finalAlloc : allocation = ref Temp.Table.empty
                    fun forN n = 
                        case Graph.Table.look(!color, n) of
                            SOME r => finalAlloc := Temp.Table.enter(!finalAlloc, gtemp n, r)
                            | NONE => ErrorMsg.impossible "colorToAllocation unfound"
                in
                    (List.app forN NodeSet.toList(coloredNodes);
                    !finalAlloc)
                end
        in
            (
            build();
            makeWorklist();
            simplify();
            assignColors();
            (colorToAllocation(), map gtemp NodeSet.toList(!spilledNodes))
            )
        end

end