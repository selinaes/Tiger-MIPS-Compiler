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
            val K = length registers
            val alias: Graph.node Graph.Table.table ref = ref Graph.Table.empty
            val color: Frame.register Graph.Table.table ref = ref Graph.Table.empty
            
            fun getDegree n = 
                case Graph.Table.look(!degree, n) of
                    SOME d => d
                    | NONE => 0
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
                    (List.app initColor (Graph.nodes graph); buildAdjSetAdjList (); computeDegree();  app addMoves moves;
                     (* print all key for adjList *) 
                      print "adjList after build: \n";
                      List.app (fn (k,v) => print ("N" ^ (Int.toString k) ^ ", "))  (Graph.Table.listItemsi (!adjList) )
                     )
                end
            
            fun nodeMoves (n: Graph.node) = 
                case Temp.Table.look(!moveList, gtemp n) of 
                    SOME m => EdgeSet.intersection(m, EdgeSet.union(!activeMoves, !workListMoves))
                    | NONE => EdgeSet.empty
                    (* (print (Graph.nodename n);ErrorMsg.impossible "nodeMoves") *)
            
            fun moveRelated (n) = not (EdgeSet.isEmpty(nodeMoves(n)))
            fun addNodeToWL n = 
                if (Graph.indegree n >= K) 
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
                    NodeSet.difference(NodeSet.subtractList (adjLstOfn, !selectStack), !coalescedNodes)
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
                    val d = getDegree m
                in
                    Graph.Table.enter(!degree, m, d-1);
                    if d = K
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
                    simplifyOneNode (NodeSet.minItem(!simplifyWorklist))
                end

            fun getAlias(n: Graph.node) = 
                if NodeSet.member(!coalescedNodes, n) then getAlias(
                    case Graph.Table.look(!alias, n) of 
                        SOME x => x
                        | NONE => ErrorMsg.impossible "getAlias node not exist"
                    )
                else n

            fun OK(t: Graph.node, r: Graph.node): bool = 
                let
                    val tDegree = getDegree t
                in
                    tDegree < K orelse NodeSet.member(!precolored, t) orelse EdgeSet.member(!adjSet, (t, r))
                end

            fun conservative(nodes: NodeSet.set) = 
                let
                    val k = ref 0
                    fun calculate n = 
                        let
                            val d = getDegree n
                        in
                            if d >= K then k := !k + 1 else ()
                        end
                in
                    NodeSet.app calculate nodes;
                    (!k) < K
                end

            fun addWorkList(u: Graph.node) = 
                let
                    val uDegree = getDegree u
                in
                    if (not (NodeSet.member(!precolored, u)) andalso not (moveRelated(u)) andalso uDegree < K)
                    then
                        (freezeWorklist := NodeSet.delete(!freezeWorklist, u);
                        simplifyWorklist := NodeSet.add(!simplifyWorklist, u))
                    else ()
                end
                

            fun combine (u, v) = 
                let
                    fun handleAdjacent t = 
                        (adjSet := EdgeSet.add(!adjSet, (u, t));
                        adjList := Graph.Table.enter(!adjList, u, NodeSet.add(Option.getOpt(Graph.Table.look(!adjList, u), NodeSet.empty), t));    
                        adjList := Graph.Table.enter(!adjList, t, NodeSet.add(Option.getOpt(Graph.Table.look(!adjList, t), NodeSet.empty), u));    
                        decrementDegree t)
                    fun isFreezed n = NodeSet.member(!freezeWorklist, n)
                    fun spillCheck () = 
                        (if (getDegree u) > K andalso isFreezed v
                        then freezeWorklist := NodeSet.delete(!freezeWorklist, u)
                        else spillWorklist := NodeSet.add(!spillWorklist, u))
                in
                    (if isFreezed v
                    then freezeWorklist := NodeSet.delete(!freezeWorklist, v)
                    else spillWorklist := NodeSet.delete(!spillWorklist, v);
                    coalescedNodes := NodeSet.add(!coalescedNodes, v);
                    alias := Graph.Table.enter(!alias, v, u);
                    moveList := Temp.Table.enter (!moveList, gtemp u, 
                               EdgeSet.add(Option.getOpt(Temp.Table.look(!moveList, gtemp u), EdgeSet.empty), (u,v)));
                    NodeSet.app handleAdjacent (adjacent v);
                    spillCheck ()
                    )

                    
                end

            fun coalesce() = 
                let
                    fun coalesceOneMove (m: edge) = 
                        let
                            val (x, y) = m
                            val x' = getAlias(x)
                            val y' = getAlias(y)
                            val (u, v) = if NodeSet.member(!precolored, y') then (y',x') else (x',y')
                            fun checkVadjAllOK v = 
                                let val tlist = adjacent(v)
                                in NodeSet.all (fn t => OK(t, u)) tlist
                                end  
                        in
                            workListMoves := EdgeSet.delete(!workListMoves, m);
                            if Graph.eq(u,v)
                            then (coalescedMoves := EdgeSet.add(!coalescedMoves, m); addWorkList(u))
                            else
                                if NodeSet.member(!precolored, v) orelse EdgeSet.member(!adjSet, (u,v))
                                then (constrainedMoves := EdgeSet.add(!constrainedMoves, m); addWorkList(u); addWorkList(v))
                                else 
                                    if (NodeSet.member(!precolored, u) andalso checkVadjAllOK v 
                                        orelse (not (NodeSet.member(!precolored, u))) 
                                        andalso conservative(NodeSet.union(adjacent(u), adjacent(v))) )
                                    then (coalescedMoves := EdgeSet.add(!coalescedMoves,m) ; combine(u,v); addWorkList(u))
                                    else
                                        (activeMoves := EdgeSet.add(!activeMoves, m))
                        end
                in
                    EdgeSet.app (fn (n1, n2) => print (Graph.nodename n1 ^ " c " ^ Graph.nodename n2 ^ "\n")) (!constrainedMoves);
                    (* print "coalescedNodes: \n";
                    NodeSet.app (fn n => print (Graph.nodename n ^ "\n")) (!coalescedNodes); *)
                    coalesceOneMove (EdgeSet.minItem (!workListMoves))
                    (* EdgeSet.app coalesceOneMove (!workListMoves) *)
                end
            

            fun freezeMoves u = 
                let 
                    val edges: EdgeSet.set = nodeMoves u
                    fun freezeOneMove m = 
                    let
                        val (x, y) = m
                        val v = if Graph.eq(getAlias y, getAlias u) 
                                then (getAlias x)
                                else (getAlias y)
                        val vDegree = getDegree v
                    in
                        activeMoves := EdgeSet.delete(!activeMoves, m);
                        frozenMoves := EdgeSet.add(!frozenMoves, m);
                        if (EdgeSet.isEmpty(nodeMoves v) andalso vDegree < K)
                        then (freezeWorklist := NodeSet.delete(!freezeWorklist, v);
                            simplifyWorklist := NodeSet.add(!simplifyWorklist, v))
                        else ()
                    end
                in
                    EdgeSet.app freezeOneMove edges
                end
            
            fun freeze () = 
                let
                    fun freezeOneNode u = 
                        (freezeWorklist := NodeSet.delete (!freezeWorklist, u);
                        simplifyWorklist := NodeSet.add (!simplifyWorklist, u);
                        freezeMoves u )
                in
                    freezeOneNode (NodeSet.minItem (!freezeWorklist))
                    (* NodeSet.app freezeOneNode (!freezeWorklist) *)
                end

            fun selectSpill () = 
                let
                    val chosedSpill = NodeSet.foldl (fn (n, m) => if spillCost n > spillCost m then n else m) (NodeSet.minItem (!spillWorklist)) (!spillWorklist)
                in
                    spillWorklist := NodeSet.delete (!spillWorklist, chosedSpill);
                    simplifyWorklist := NodeSet.add (!simplifyWorklist, chosedSpill);
                    freezeMoves chosedSpill
                end

            fun assignColors() = 
                let
                    fun forNinStack n =
                        let
                            val _ = print ("Now coloring: " ^ Graph.nodename n ^ "\n")
                            val okColors = ref registers
                            fun forEachW w = 
                                if NodeSet.member(NodeSet.union(!coloredNodes, !precolored), getAlias w)
                                then 
                                    case Graph.Table.look(!color, getAlias w) of
                                        SOME c => okColors := List.filter (fn r => r <> c) (!okColors)
                                        | NONE => ()
                                else ()
                            (* val () = Graph.Table.appi (fn (k,i:NodeSet.set)=> print ((Int.toString k) ^ ", ")) (!adjList) *)
                            val ws: NodeSet.set = case Graph.Table.look(!adjList, n) of
                                        SOME ws => ws
                                        | NONE => NodeSet.empty
                                        (* ErrorMsg.impossible ("assignColors cannot find node in adjList, given: " ^ (Graph.nodename n)) *)
                        in
                            NodeSet.app forEachW ws;
                            if List.null (!okColors) then
                                spilledNodes := NodeSet.add(!spilledNodes, n)
                            else
                                (color := Graph.Table.enter(!color, n, hd (!okColors));
                                coloredNodes := NodeSet.add(!coloredNodes, n))
                        end
                    fun colorOneCoalesce (n: Graph.node) = 
                        let
                            val nAlias = getAlias n
                        in
                            case Graph.Table.look(!color, nAlias) of
                                SOME c => (color := Graph.Table.enter(!color, n, c); coloredNodes := NodeSet.add(!coloredNodes, n))
                                | NONE => ErrorMsg.impossible ("assignColors cannot find alias color, given: " ^ (Graph.nodename nAlias))
                        end
                in
                    app forNinStack (rev(!selectStack));
                    NodeSet.app colorOneCoalesce (!coalescedNodes)
                end
            
            (*color = node:register, alloc = temp:register*)
            fun colorToAllocation() = 
                let
                    val finalAlloc : allocation ref = ref Temp.Table.empty
                    fun forN (n:Graph.node) = 
                        case Graph.Table.look(!color, n) of
                            SOME r => finalAlloc := Temp.Table.enter(!finalAlloc, gtemp n, r)
                            | NONE => ErrorMsg.impossible ("colorToAllocation unfound, given " ^ (Graph.nodename n))
                in
                    (* print "colorToAllocation - print color\n";
                    Graph.Table.appi (fn (k,v) => print((Int.toString k) ^ ":" ^ v ^ "\n")) (!color); *)
                    NodeSet.app forN (!precolored);
                    NodeSet.app forN (!coloredNodes);
                     print "colorToAllocation - print finalAlloc\n";
                    Temp.Table.appi (fn (k,v) => print((Temp.makestring k) ^ ":" ^ v ^ "\n")) (!finalAlloc);
                    (!finalAlloc)
                end


        fun iterateOptimizeStep () = 
            (
            if not (NodeSet.isEmpty (!simplifyWorklist)) then (print "simplify node:";(NodeSet.app (fn(node) => print (Graph.nodename node ^ ", ")) (!simplifyWorklist)); simplify()) else 
                if not (EdgeSet.isEmpty (!workListMoves)) then (coalesce()) else 
                    if not (NodeSet.isEmpty (!freezeWorklist)) then (freeze()) else 
                        if not (NodeSet.isEmpty (!spillWorklist)) then (selectSpill()) else ();
            if (NodeSet.isEmpty (!simplifyWorklist) andalso EdgeSet.isEmpty (!workListMoves)
                andalso NodeSet.isEmpty (!freezeWorklist) andalso NodeSet.isEmpty (!spillWorklist))
            then ()
            else iterateOptimizeStep()
            )
        
            
        in
        (* this return allocation * spilledNodes and  do not recall color and rewrite program *)
            (
            build();
            makeWorklist();
            (* simplify(); *)
            iterateOptimizeStep();
            assignColors();
            print ("spilledNodes: " ^ Int.toString(NodeSet.numItems(!spilledNodes)) ^ "\n");
            (colorToAllocation(), List.map gtemp (NodeSet.toList(!spilledNodes)))
            )
        end

end