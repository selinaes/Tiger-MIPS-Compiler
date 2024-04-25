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
            
            val moveList: EdgeSet.set Graph.Table.table ref = ref Graph.Table.empty
            
            val adjSet: EdgeSet.set ref = ref EdgeSet.empty
            val adjList: NodeSet.set Graph.Table.table ref = ref Graph.Table.empty
            val degree: int Graph.Table.table ref = ref Graph.Table.empty
            val K = length registers
            val alias: Graph.node Graph.Table.table ref = ref Graph.Table.empty
            val color: Frame.register Graph.Table.table ref = ref Graph.Table.empty
            
            fun getDegree n = 
                    if (NodeSet.member(!precolored, n)) 
                    then 
                        (K)
                    else
                        (case Graph.Table.look(!degree, n) of
                        SOME d => d
                        | NONE => 0) (* No interference edge, won't add to degree *)
                
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
                            (case Temp.Table.look(allocated, gtemp node) of
                                    SOME reg => (color := Graph.Table.enter(!color, node, reg); 
                                                precolored := NodeSet.add(!precolored, node))
                                    | NONE => initial := NodeSet.add(!initial, node))
                        
                            
                    fun addMove (node: Graph.node, m: edge) = 
                        moveList := Graph.Table.enter (!moveList, node, 
                               EdgeSet.add(Option.getOpt(Graph.Table.look(!moveList, node), EdgeSet.empty), m)
                        )

                    fun addMoves (n1: Graph.node, n2: Graph.node) = 
                            (if (not (NodeSet.member(!precolored, n1)) ) then
                                addMove(n1, (n1, n2)) else ();
                            if (not (NodeSet.member(!precolored, n2)) ) then
                                addMove(n2, (n1, n2)) else ();
                            workListMoves := EdgeSet.add(!workListMoves, (n1, n2)))
                in
                    (List.app initColor (Graph.nodes graph); 
                    buildAdjSetAdjList (); 
                    computeDegree();  
                    app addMoves moves)
                end
            
            fun nodeMoves (n: Graph.node) = 
                (case Graph.Table.look(!moveList, n) of 
                    SOME m => (EdgeSet.intersection(m, EdgeSet.union(!activeMoves, !workListMoves)))
                    | NONE => EdgeSet.empty)

            fun moveRelated (n) = (
                let
                    val res = not (EdgeSet.isEmpty(nodeMoves(n)))
                in
                    (* print ("moveRelated: " ^ (Graph.nodename n) ^ " is - " ^ Bool.toString res ^ "\n"); *)
                    res
                end)
                
            fun addNodeToWL n = 
                if ((getDegree n) >= K) 
                then
                    (spillWorklist := NodeSet.add(!spillWorklist, n))
                else
                    if (moveRelated n)
                    then 
                        (freezeWorklist := NodeSet.add(!freezeWorklist, n))
                    else
                        (simplifyWorklist := NodeSet.add(!simplifyWorklist, n))

             fun makeWorklist() = 
                (NodeSet.app addNodeToWL (!initial); initial := NodeSet.empty)

            fun spillCheck (u) = 
                (if (getDegree u) >= K andalso NodeSet.member(!freezeWorklist, u)
                then (
                    (* print ("combine: u in freezeWorklist - " ^ Bool.toString (NodeSet.member(!freezeWorklist, u)) ^ "\n"); *)
                    freezeWorklist := NodeSet.delete(!freezeWorklist, u); 
                    spillWorklist := NodeSet.add(!spillWorklist, u))
                else ())
            
            fun addEdge (u:Graph.node, v:Graph.node) = 
                if (not (EdgeSet.member(!adjSet, (u,v))) andalso not (Graph.eq(u, v))) then
                    (adjSet := EdgeSet.add(!adjSet, (u, v));
                    adjSet := EdgeSet.add(!adjSet, (v, u));
                    (if not (NodeSet.member(!precolored, u)) then
                        (adjList := Graph.Table.enter(!adjList, u, NodeSet.add(Option.getOpt(Graph.Table.look(!adjList, u), NodeSet.empty), v));
                        (* print ("Degree from " ^ Int.toString(getDegree u) ^ " to " ^ Int.toString(getDegree u + 1) ^ "\n"); *)
                        degree := Graph.Table.enter(!degree, u, (getDegree u)+1);
                        spillCheck(u)
                        )
                    else ());
                    (if not (NodeSet.member(!precolored, v)) then
                        (adjList := Graph.Table.enter(!adjList, v, NodeSet.add(Option.getOpt(Graph.Table.look(!adjList, v), NodeSet.empty), u));
                        (* print ("Degree from " ^ Int.toString(getDegree u) ^ " to " ^ Int.toString(getDegree u + 1) ^ "\n"); *)
                        degree := Graph.Table.enter(!degree, v, (getDegree v)+1);
                        spillCheck(v)
                        )
                    else ()))
                else ()

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
                                (
                                (* print ("enableMoves: m in active moves - " ^ Bool.toString (EdgeSet.member(!activeMoves, m)) ^ "\n"); *)
                                activeMoves := EdgeSet.delete(!activeMoves, m);
                                workListMoves := EdgeSet.add(!workListMoves, m))
                            else ()
                    in
                        EdgeSet.app forEachM moves
                    end
                in
                  NodeSet.app forEachN nodes
                end
            
            fun decrementDegree(n) = 
                let
                    val d = getDegree n
                in
                    (case Temp.Table.look(allocated, gtemp n) of
                        SOME _ => ()
                        | NONE =>
                            (degree := Graph.Table.enter(!degree, n, d-1);
                            if d = K
                            then
                            (enableMoves(NodeSet.union(NodeSet.singleton(n), adjacent(n))); 
                            (* print ("decrementDegree: v in freezeworklist - " ^ Bool.toString (NodeSet.member(!freezeWorklist, n)) ^ "\n"); 
                            print ("decrementDegree: v in spillWorklist - " ^ Bool.toString (NodeSet.member(!spillWorklist, n)) ^ "\n"); 
                            print ("decrementDegree: v in initial - " ^ Bool.toString (NodeSet.member(!initial, n)) ^ "\n"); 
                            print ("decrementDegree: v in simplifyWorklist - " ^ Bool.toString (NodeSet.member(!simplifyWorklist, n)) ^ "\n"); 
                            print ("decrementDegree: v in precolored - " ^ Bool.toString (NodeSet.member(!precolored, n)) ^ "\n"); 
                            print ("decrementDegree: v in spilledNodes - " ^ Bool.toString (NodeSet.member(!spilledNodes, n)) ^ "\n"); 
                            print ("decrementDegree: v in coalescedNodes - " ^ Bool.toString (NodeSet.member(!coalescedNodes, n)) ^ "\n"); 
                            print ("decrementDegree: v in coloredNodes - " ^ Bool.toString (NodeSet.member(!coloredNodes, n)) ^ "\n");  *)
                            (* print (Graph.nodename n); *)
                            spillWorklist := NodeSet.delete(!spillWorklist, n);
                            (* print ("decrementDegree: Delete from spillworklist " ^ (Graph.nodename n) ^ "\n"); *)
                            if moveRelated n then
                                (freezeWorklist := NodeSet.add(!freezeWorklist, n))
                            else
                                (simplifyWorklist := NodeSet.add(!simplifyWorklist, n))
                            )
                    else ()))
                end
        
            fun simplify() = 
                let
                    fun simplifyOneNode n = 
                        ((* print ("simplify: n in simplifyWorklist - " ^ Bool.toString (NodeSet.member(!simplifyWorklist, n)) ^ "\n"); *)
                        simplifyWorklist := NodeSet.delete(!simplifyWorklist, n);
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
            
            (*George: t neigh either trivial, or shared, or precolored *)
            fun OK(t: Graph.node, r: Graph.node): bool = 
                let
                    val tDegree = getDegree t
                in
                    tDegree < K orelse NodeSet.member(!precolored, t) orelse EdgeSet.member(!adjSet, (t, r))
                end

            (* Briggs: <K combined neighbors have significant degree *)
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
                        (
                            (* print ("addWorkList: u in freezeWorklist - " ^ Bool.toString (NodeSet.member(!freezeWorklist, u)) ^ "\n"); *)
                            freezeWorklist := NodeSet.delete(!freezeWorklist, u);
                        simplifyWorklist := NodeSet.add(!simplifyWorklist, u))
                    else ()
                end
                

            fun combine (u, v) = 
                let
                    fun handleAdjacent t = 
                        (addEdge (t, u); decrementDegree t)
                in
                    (if NodeSet.member(!freezeWorklist, v)
                    then (
                        (* print ("combine: v in freezeWorklist - " ^ Bool.toString (NodeSet.member(!freezeWorklist,v)) ^ "\n"); *)
                        freezeWorklist := NodeSet.delete(!freezeWorklist, v))
                    else (
                        (* print ("combine: v in spillWorklist - " ^ Bool.toString (NodeSet.member(!spillWorklist,v)) ^ "\n"); *)
                        spillWorklist := NodeSet.delete(!spillWorklist, v)
                        (* print ("combine: Delete from spillworklist " ^ (Graph.nodename v) ^ "\n") *)
                        )
                    );
                    
                    coalescedNodes := NodeSet.add(!coalescedNodes, v); (* v = n32*)
                    alias := Graph.Table.enter(!alias, v, u);  (* alias key=n=n32, value=n184 *)
                    (* print ("combined " ^ Graph.nodename(v) ^ " into " ^ Graph.nodename u ^ "\n"); *)
                    moveList := Graph.Table.enter (!moveList, u, 
                               EdgeSet.union(nodeMoves(u), nodeMoves(v)));
                    NodeSet.app handleAdjacent (adjacent v);
                    spillCheck u
                end

            fun coalesce() = 
                let
                    fun coalesceOneMove (m: edge) = 
                        let
                            val (x, y) = m
                            val x' = getAlias(x)
                            val y' = getAlias(y)
                            val (u, v) = if NodeSet.member(!precolored, y') then (y',x') else (x',y')
                            (* George, fulfill using v *)
                            fun checkVadjAllOK v = 
                                let val tlist = adjacent(v)
                                in NodeSet.all (fn t => OK(t, u)) tlist
                                end  
                            val vneighs: NodeSet.set = (case Graph.Table.look(!adjList, v) of
                                                                SOME ws => ws
                                                                | NONE => NodeSet.empty)
                            val uneighs: NodeSet.set = (case Graph.Table.look(!adjList, u) of
                                                                SOME ws => ws
                                                                | NONE => NodeSet.empty)
                        in
                            (* print ("coalesce: m in worklistmoves - " ^ Bool.toString (EdgeSet.member(!workListMoves, m)) ^ "\n"); *)
                            workListMoves := EdgeSet.delete(!workListMoves, m);
                            if Graph.eq(u,v)
                            then (coalescedMoves := EdgeSet.add(!coalescedMoves, m); addWorkList(u))
                            else
                                if NodeSet.member(!precolored, v) orelse EdgeSet.member(!adjSet, (u,v))
                                then (constrainedMoves := EdgeSet.add(!constrainedMoves, m); addWorkList(u); addWorkList(v))
                                else 
                                    let
                                        val isGeorge = (NodeSet.member(!precolored, u) andalso checkVadjAllOK v)
                                        val isBriggs = (not (NodeSet.member(!precolored, u))) 
                                                 andalso conservative(NodeSet.union(adjacent(u), adjacent(v)))
                                    in
                                        if (isGeorge orelse isBriggs)
                                        then (
                                            coalescedMoves := EdgeSet.add(!coalescedMoves,m); 
                                            combine(u,v); 
                                            addWorkList(u))
                                        else
                                            (activeMoves := EdgeSet.add(!activeMoves, m)) 

                                    end
                        end
                        (* val (n1,n2) = EdgeSet.minItem (!workListMoves) *)
                in
                    (* print ("coalesce " ^ (Graph.nodename(n1)) ^ ", "^ (Graph.nodename(n2)) ^ "\n"); *)
                    coalesceOneMove (EdgeSet.minItem (!workListMoves))
                end
            

            fun freezeMoves u = 
                let 
                    val edges: EdgeSet.set = nodeMoves u 
                    fun printNodeMoves u = 
                        (print ("nodeMoves " ^(Graph.nodename u)^ " are: " ); EdgeSet.app (fn (x,y) => print ((Graph.nodename x) ^ "," ^ (Graph.nodename y) ^ " ")) (nodeMoves u);
                        print "\n")
                    fun freezeOneMove m = 
                    let
                        val (x, y) = m
                        (* val _ = print ("u is: " ^ (Graph.nodename u) ^ "\n")
                        val _ = print ("(x,y)=" ^(Graph.nodename x) ^ "," ^(Graph.nodename y)^ "\n") *)
                        val v = if Graph.eq(getAlias y, getAlias u) 
                                then (getAlias x)
                                else (getAlias y)
                        val vDegree = getDegree v
                    in
                        (* print ("freezeOneMove: m in activeMoves - " ^ Bool.toString (EdgeSet.member(!activeMoves, m)) ^ "\n"); *)
                        activeMoves := EdgeSet.delete(!activeMoves, m);
                        frozenMoves := EdgeSet.add(!frozenMoves, m);
                        (* printNodeMoves(v); *)
                        (* print ("(EdgeSet.isEmpty(nodeMoves v):"^Bool.toString (EdgeSet.isEmpty(nodeMoves v)));
                        print ("EdgeSet.numItems(nodeMoves v) = 0:"^Bool.toString (EdgeSet.numItems(nodeMoves v) = 0)); *)
                        (if (EdgeSet.isEmpty(nodeMoves v) andalso (getDegree v < K) andalso not (NodeSet.member(!precolored,v)))
                        then (
                            freezeWorklist := NodeSet.delete(!freezeWorklist, v);
                            simplifyWorklist := NodeSet.add(!simplifyWorklist, v))
                        else ())
                    end
                in
                    EdgeSet.app freezeOneMove edges
                end
            
            fun freeze () = 
                let
                    fun freezeOneNode u = 
                        (
                            (* print ("freeze: n in freezeWorklist - " ^ Bool.toString (NodeSet.member(!freezeWorklist, u)) ^ "\n"); *)
                        freezeWorklist := NodeSet.delete (!freezeWorklist, u);
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
                    (* print ("selectSpill: chosedSpill in spillWorklist - " ^ Bool.toString (NodeSet.member(!spillWorklist, chosedSpill)) ^ "\n"); *)
                    (* print ("selectSpill: Delete from spillworklist " ^ (Graph.nodename chosedSpill) ^ "\n"); *)
                    spillWorklist := NodeSet.delete (!spillWorklist, chosedSpill);
                    simplifyWorklist := NodeSet.add (!simplifyWorklist, chosedSpill);
                    freezeMoves chosedSpill
                end

            fun assignColors() = 
                let
                    fun forNinStack n =
                        let
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
                                (
                                    (* (print (Graph.nodename n ^"'s adjList: \n");
                                    NodeSet.app (fn w => print((Graph.nodename w) ^ ", ")) ws;
                                    print ("no available color for " ^(Graph.nodename n)^ "\n"); *)
                                spilledNodes := NodeSet.add(!spilledNodes, n)
                                )
                            else
                                
                                (
                                (* print ("ok color for " ^ Graph.nodename n); *)
                                (* (app (fn c => print (c ^ ", ")) (!okColors));
                                print "\n"; *)
                                color := Graph.Table.enter(!color, n, hd (!okColors));
                                (* print ("Now coloring: " ^ Graph.nodename n ^ " to " ^ hd (!okColors) ^ "\n"); *)
                                coloredNodes := NodeSet.add(!coloredNodes, n))
                        end
                    fun colorOneCoalesce (n: Graph.node) = 
                        let
                            val nAlias = getAlias n
                            
                        in
                            (* print ("nAlias in freezeworklist - " ^ Bool.toString (NodeSet.member(!freezeWorklist, nAlias)) ^ "\n"); 
                            print ("nAlias in spillWorklist - " ^ Bool.toString (NodeSet.member(!spillWorklist, nAlias)) ^ "\n"); 
                            print ("nAlias in initial - " ^ Bool.toString (NodeSet.member(!initial, nAlias)) ^ "\n"); 
                            print ("nAlias in simplifyWorklist - " ^ Bool.toString (NodeSet.member(!simplifyWorklist, nAlias)) ^ "\n"); 
                            print ("nAlias in precolored - " ^ Bool.toString (NodeSet.member(!precolored, nAlias)) ^ "\n"); 
                            print ("nAlias in spilledNodes - " ^ Bool.toString (NodeSet.member(!spilledNodes, nAlias)) ^ "\n"); 
                            print ("nAlias in coalescedNodes - " ^ Bool.toString (NodeSet.member(!coalescedNodes, nAlias)) ^ "\n"); 
                            print ("nAlias in coloredNodes - " ^ Bool.toString (NodeSet.member(!coloredNodes, nAlias)) ^ "\n");  *)
                            (case Graph.Table.look(!color, nAlias) of
                                SOME c => (color := Graph.Table.enter(!color, n, c); coloredNodes := NodeSet.add(!coloredNodes, n))
                                | NONE => ErrorMsg.impossible ("assignColors cannot find alias color, given: orig-" ^ (Graph.nodename n) ^ ", alias-"^ (Graph.nodename nAlias)))
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
                     (* print "colorToAllocation - print finalAlloc\n"; *)
                    (* Temp.Table.appi (fn (k,v) => print((Temp.makestring k) ^ ":" ^ v ^ "\n")) (!finalAlloc); *)
                    (!finalAlloc)
                end


            fun iterateOptimizeStep () = 
                (
                
                if not (NodeSet.isEmpty (!simplifyWorklist)) then (simplify()) else 
                    if not (EdgeSet.isEmpty (!workListMoves)) then (coalesce()) else 
                        if not (NodeSet.isEmpty (!freezeWorklist)) then (freeze()) else 
                            if not (NodeSet.isEmpty (!spillWorklist)) then (selectSpill()) else ();
                if (NodeSet.isEmpty (!simplifyWorklist) andalso EdgeSet.isEmpty (!workListMoves)
                    andalso NodeSet.isEmpty (!freezeWorklist) andalso NodeSet.isEmpty (!spillWorklist))
                then ()
                else iterateOptimizeStep())
            
        
            
        in
        (* this return allocation * spilledNodes and  do not recall color and rewrite program *)
            (
            build();
            makeWorklist();
            iterateOptimizeStep();
            assignColors();
            (colorToAllocation(), List.map gtemp (NodeSet.toList(!spilledNodes)))
            )
        end

end