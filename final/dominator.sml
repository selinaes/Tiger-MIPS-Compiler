structure Dominator : DOMINATOR = 
struct
    type dSet = BitArray.array
    type dMap = dSet Graph.Table.table
    structure G = Graph
    structure NodeSet = RedBlackSetFn (struct
                type ord_key = Graph.node
                val compare = Graph.compareNode
    end);

    structure IdxSet = RedBlackSetFn (struct
                type ord_key = int
                val compare = Int.compare
    end);

    structure Table = IntMapTable(type key = int
		fun getInt n = n);
    
    fun handleDominators (Flow.FGRAPH {control,nodeToInstr, labelNodeMap, def, use, rdgen, rdkill, ismove}) = 
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
                            dominateMap := Graph.Table.enter (!dominateMap, node, dominators);
                            if (not (BitArray.isZero (BitArray.xorb (dominators, oldDom, N))))
                            then
                                (hasChanged := true)
                            else
                                ()
                        end
                in
                    (
                        dominateMap := Graph.Table.enter(!dominateMap, startNode, BitArray.bits(N, [0]));
                        (* print ("Add 1st instr dominator: " ^Graph.nodename startNode^ "\n"); *)
                        app computeOneNodeDom (List.tl (Graph.nodes control));
                        if !hasChanged then
                            computeDomination()
                        else
                            ()
                            (* app (fn (k: int,v) => (print ("Instr" ^ (Int.toString k) ^ ":"^ setToString(v) ^ "\n"))) (G.Table.listItemsi(!dominateMap)) *)
                    )
                end

            val _ = computeDomination()
           
            (* val _ = app (fn (k: int,v) => (print ("n"^(Int.toString k)^": ");addEdgesAtOneLiveset(v, gr))) (G.Table.listItemsi(!liveOutMap)) *)

        in
           !dominateMap
        end
    

    fun findLoops (Flow.FGRAPH {control, nodeToInstr, labelNodeMap, def, use, rdgen, rdkill, ismove}, domiMap : dMap) : (Graph.node * Graph.node) list =
         (* n -> b, b is n's succ, if b dom n, n->b is backedge. Return (from, to) = (b,n) *)
        let
            val fnodes = G.nodes control
            val N = length fnodes
            fun handleOneNode(n: Graph.node, acc: (Graph.node * Graph.node) list) = 
                let
                    val successorsIdxs = map Graph.nodenum (Graph.succ n)
                    val doms: dSet = case Graph.Table.look (domiMap, n) of
                                        SOME x => x
                                        | NONE => ErrorMsg.impossible ("findLoop dSet notfound for: " ^ Graph.nodename n)
                    val succBA: dSet = BitArray.bits(N, successorsIdxs)
                    val backTargets = BitArray.andb(succBA, doms, N)
                    val backTgtLst = BitArray.getBits(backTargets)
                in
                    acc @ (map (fn tgt => (List.nth(fnodes, tgt), n)) backTgtLst)
                end
        in
            foldl handleOneNode [] fnodes
        end
        


    fun processOneLoop (from, to, Flow.FGRAPH {control, nodeToInstr, labelNodeMap, def, use, rdgen, rdkill, ismove},
     replaceMap, addMap, deleteSet, rdInMap: Reaching_Def.rdMap, domiMap: dMap, liveOutMap: Liveness.liveMap, liveInMap: Liveness.liveMap) = 
        let
            val inLoopNodesSet: NodeSet.set ref = ref NodeSet.empty
            val N = Temp.getTemps() - 100
            val exitSet: NodeSet.set ref = ref NodeSet.empty
                
            fun dfs([]: Graph.node list, visited: NodeSet.set) = false
            | dfs(current::stack, visited) = 
                let
                    val successors =  Graph.succ current
                    val isInitial = ref true
                in  
                    if (Graph.eq (current, to)) then (exitSet := NodeSet.add(!exitSet, current);inLoopNodesSet := NodeSet.add(!inLoopNodesSet, current); true)
                    else
                        foldl (fn (n, acc) => (if NodeSet.member(visited, n) 
                                                then acc 
                                                else ( 
                                                    let
                                                        val nthRes = dfs(n::stack, NodeSet.add(visited, n))
                                                    in
                                                        ( (* If 2 successors reaches different end, then this is an exit *)
                                                        if (not (nthRes = acc) andalso not (!isInitial)) then exitSet := NodeSet.add(!exitSet, current) else ();
                                                        (* One dfs has performed, already not initial *)
                                                        isInitial := false;
                                                        if nthRes then (inLoopNodesSet := NodeSet.add(!inLoopNodesSet, current); true) else acc)
                                                    end))) 
                        false successors
                end

            fun findHoistableInLoop (curr: Graph.node, acc) = 
                let
                    val useBA = case Graph.Table.look(use, curr) of
                                    SOME x => x
                                    | NONE => ErrorMsg.impossible "findHoistableInLoop, useBA not found"
                    val currDefBA = case Graph.Table.look(def, curr) of
                                    SOME x => x
                                    | NONE => ErrorMsg.impossible "findHoistableInLoop, currDefBA not found"
                    val reachableNodesSet : Reaching_Def.rdSet = case Graph.Table.look(rdInMap, curr) of (* for each instruction*)
                                                                    SOME x => x
                                                                    |NONE => ErrorMsg.impossible "findHoistableInLoop, reachableNodeSet not found"
                    val reachableNodes = BitArray.getBits(reachableNodesSet)
                    (* for curr instr, for each of its rdIn, see if that instr's def is used in curr's use. All a's use can be found in rdIn. Just inside/outside loop *)
                    (* instr (a) -> rdIn instr set (b), auseBA & bdefBA, if not iszero then if not in loop range then *)
                    
                    (* Not preheader liveout*)
                    fun isNotHeaderLiveIn () = 
                        case Graph.Table.look(liveInMap, from) of
                            SOME lIset => BitArray.isZero(BitArray.andb(currDefBA,lIset,N))
                            | NONE => ErrorMsg.impossible ("cannot find livein for: " ^ Graph.nodename from)
                            
                    fun dominatesAllExitWithLiveout () = 
                        let
                            fun thisExitLiveOut (exit, acc) = 
                                case Graph.Table.look(liveOutMap, exit) of
                                    SOME lOset => if not (BitArray.isZero(BitArray.andb(currDefBA,lOset,N))) then exit::acc else acc
                                    | NONE => ErrorMsg.impossible ("cannot find liveout for: " ^ Graph.nodename exit)
                            (* find exit set with t liveout*)
                            val viableExits = foldl thisExitLiveOut [] (NodeSet.listItems(!exitSet))
                            fun dominatesAll (exit, acc) = 
                                let
                                    val InsN = length (Graph.nodes control)
                                    val exitDominator = case Graph.Table.look(domiMap, exit) of 
                                                            SOME doms => let 
                                                                            val curr = BitArray.bits(InsN, [Graph.nodenum curr]) 
                                                                        in 
                                                                            if BitArray.isZero(BitArray.andb(curr,doms,InsN)) then false else acc
                                                                        end
                                                            | NONE => ErrorMsg.impossible "cannot find dominator"
                                in
                                    exitDominator
                                end
                        in
                            foldl dominatesAll true viableExits
                        end
                    
                    fun doubleDefInLoop (another, acc) = 
                        let
                            val anotherDefBA = case Graph.Table.look(def, another) of 
                                                 SOME x => x
                                                | NONE => ErrorMsg.impossible "findHoistableInLoop, defBA not found"
                        in
                            if (Graph.eq(curr, another)) then acc else 
                                (if (not (BitArray.isZero(BitArray.andb(currDefBA, anotherDefBA, N)))) then true else acc)
                        end
                    
                    fun reachableNodesOutLoop [] = true
                        | reachableNodesOutLoop (nodenum::rest) = 
                            let
                                val node = List.nth(Graph.nodes control, nodenum)
                                val defBA = case Graph.Table.look(def, node) of 
                                                 SOME x => x
                                                | NONE => ErrorMsg.impossible "findHoistableInLoop, defBA not found"
                            in
                                (* If no overlap, this rd's def not used here, continue *)
                                (*
                                print ("Instr not related: " ^ Graph.nodename node ^ " to curr: " ^ Graph.nodename curr^"\n");
                                print ("reachable instr outsideloop: " ^ Graph.nodename node ^ " of curr: " ^ Graph.nodename curr ^ "\n");
                                print ("Not hoistable: " ^ Graph.nodename curr ^ "\n"); 
                                *)
                                if BitArray.isZero(BitArray.andb(useBA, defBA, N)) then (reachableNodesOutLoop rest)
                                else (* if reached def in loop, false *)
                                    if NodeSet.member(!inLoopNodesSet, node) then (
                                        if (Graph.nodenum(curr) = 37) then (
                                        print ("check inloopnodeset: reach: " ^ Graph.nodename node ^ ", curr: " ^ Graph.nodename curr ^ "\n")) 
                                        else ();
                                        false) 
                                    else (if (Graph.nodenum(curr) = 37) then (
                                            print ("check not inloopnodeset: reach: " ^ Graph.nodename node ^ ", curr: " ^ Graph.nodename curr ^ "\n")) 
                                            else ();
                                            reachableNodesOutLoop rest)
                            end
                    fun notLabel(curr: Graph.node) = 
                        let
                            val nodeInstr = case Graph.Table.look(nodeToInstr, curr) of
                                                SOME instr => instr
                                                | NONE => ErrorMsg.impossible ("notLabel Error: Can't find node: " ^ Graph.nodename curr ^  " in nodeToInstr map")
                        in
                            case nodeInstr of
                                Assem.LABEL{lab, ...} => false
                                | _ => true
                        end
                    val hasDoubleDef = foldr doubleDefInLoop false (NodeSet.listItems (!inLoopNodesSet))
                in  (* 1.label don't hoist
                       2.src=[], jump/la/jal/jal's next, cannot hoist 
                       3.not liveout of preheader/livein of header 
                       4.dominates all t liveout exits 
                       5.t not defined twice in loop 
                       6.all its uses are defined outside loop *)
                    if (notLabel(curr) andalso not(BitArray.isZero(useBA)) andalso isNotHeaderLiveIn() 
                        andalso dominatesAllExitWithLiveout() andalso (not hasDoubleDef)  
                        andalso reachableNodesOutLoop (rev(reachableNodes)))
                                then (curr::acc )  (*print("hoistable instr: " ^ Graph.nodename curr ^ "\n");*)
                                else (acc)
                end

            (* Build brand new instr list, then makegraph again *)
            fun hoistInstrs(hoistlst)  = 
                let
                    val fromPredLst = Graph.pred from
                    val preheader = Temp.newlabel()
                    val newlblAssem = Assem.LABEL{assem=Symbol.name preheader ^ ":\n", lab=preheader}
                    fun changeOneLabel lb = 
                        case Symbol.look(labelNodeMap, lb) of 
                            SOME (node) => if (Graph.eq(node, from)) then (preheader) else (lb)
                            | NONE => ErrorMsg.impossible "hoistInstrs cannot find label"
                    fun modifyPredJump pred = 
                        let
                            val predInstr = case Graph.Table.look(nodeToInstr, pred) of
                                                    SOME x => x | NONE => ErrorMsg.impossible "modifyPredJump, predInstr unfound"
                                                    
                        in
                            case predInstr of
                                Assem.OPER{jump=SOME(lst),assem, dst, src} => 
                                    (let
                                        val newlst = (map changeOneLabel lst)
                                    in
                                        (* print("enter replaceMap: "^ Graph.nodename pred ^ "->" ^ assem ^ "\n"); *)
                                        replaceMap := Table.enter(!replaceMap, Graph.nodenum pred, (Assem.OPER{jump=SOME(newlst),assem=assem, dst=dst,src=src}))
                                    end
                                    )
                                | _ => ()
                        end
                    fun changeToAssem node = 
                        case Graph.Table.look(nodeToInstr, node) of
                            SOME instr => instr
                            | NONE => ErrorMsg.impossible ("ChangeToAssem Error: Can't find node: " ^ Graph.nodename node ^  " in nodeToInstr map")
                in
                    (* print ("hoistlst len=" ^ Int.toString (length hoistlst) ^ "\n"); *)
                    app modifyPredJump fromPredLst;
                    addMap := Table.enter(!addMap, (Graph.nodenum from), newlblAssem::(map changeToAssem hoistlst));
                    app (fn n => (deleteSet := IdxSet.add(!deleteSet, Graph.nodenum n))) hoistlst
                end

                
            val _ = dfs([from], NodeSet.empty)
            (* val _ = print("exit: ")
            val _ = NodeSet.app (fn (nd) => print (Graph.nodename nd ^ ", ")) (!exitSet)
            (*Process one range*)
            val _ = print ("inLoopNodesSet: " )
            val _ = NodeSet.app (fn (nd) => print (Graph.nodename nd ^ ", ")) (!inLoopNodesSet)
            val _ = print ("\n") *)
            val hoistLst = foldl (findHoistableInLoop) [] (NodeSet.listItems (!inLoopNodesSet))
            (* 1.Add to addMap/deleteSet 2.new header change: from's preds -> for each pred, if pred has jump label*)
        in
            hoistInstrs(hoistLst)
        end
    
    fun modifyInstrs(replaceMap,addMap, deleteSet, instrs) : Assem.instr list = 
        let
            val curOffset = ref 0

            fun tryDeleteInstr (index, currInstrs) = 
                let
                    (* val _ = print ("In delete: Instrs length: " ^ Int.toString (length currInstrs) ^ ", current Index: " ^ Int.toString (index + !curOffset) ^ "\n") *)
                    val instrs' = List.take(currInstrs, index + !curOffset);
                    val instrs'' = List.drop(currInstrs, index + !curOffset + 1);
                in
                    if IdxSet.member(!deleteSet, index)
                    then 
                        (curOffset := !curOffset - 1;
                        (instrs' @ instrs''))
                    else currInstrs
                end
            
            fun replaceCurr(index, newinstr, curAcc) = 
                let
                    val instrs' = List.take(curAcc, index + !curOffset);
                    val instrs'' = List.drop(curAcc, index + !curOffset + 1);
                in
                    (instrs' @ [newinstr] @ instrs'')
                end

            fun processOne (index, accInstrs) =
                    case (Table.look(!replaceMap, index)) of
                        SOME newinstr => replaceCurr(index, newinstr, accInstrs)
                        | NONE => 
                        (case (Table.look(!addMap, index)) of 
                            NONE => tryDeleteInstr(index, accInstrs)
                            | SOME lst => (
                                let
                                    val front = List.take(accInstrs, index + !curOffset)
                                    val back = List.drop(accInstrs, index + !curOffset)
                                    val instrs' = front @ lst @ back

                                    val format0 = Assem.format(Temp.makestring)
                                in
                                    (* print ("Front: "); *)
                                    (* app (fn instr => print (  String.substring((format0 instr),0,String.size((format0 instr))-1)  ^ "\n")) front; *)
                                    (* print ("lst: "); *)
                                    (* app (fn instr => print ( String.substring((format0 instr),0,String.size((format0 instr))-1)  ^ "\n")) lst; *)
                                    (* print ("Back: "); *)
                                    (* app (fn instr => print ( String.substring((format0 instr),0,String.size((format0 instr))-1)  ^ "\n")) back; *)
                                    curOffset := !curOffset + (length lst); 
                                    instrs'
                                end) )
                    
            fun createList n = 
                let fun helper i acc = 
                        if i < 0 then acc
                        else helper (i-1) (i::acc)
                in helper (n-1) [] end
           
            val format1 = Assem.format(Temp.makestring)
            val printStrs = (fn (asm, acc) => (acc ^ "; " ^ (format1 asm)))
        in
            foldl processOne instrs (createList (length instrs))
        end

    fun loopReachDefOptimize (fgr, instrs, rdInMap: Reaching_Def.rdMap) = 
        let
            val (liveInMap, liveOutMap) = Liveness.handleLiveness(fgr)
            val domMap = handleDominators(fgr)
            val loopsLst = findLoops(fgr, domMap)
            (* val _ = print("Loops: ")
            val _ = app (fn (bg, ed) => print ("(from: " ^ Graph.nodename bg ^ ", to: " ^ Graph.nodename ed ^ ") ")) loopsLst
            val _ = print("\n") *)
            (* Global- 
            Map: instr idx(要在它前面加) : list of instrs idxs (Lnew: xxx xxx )
            Set: todelete (?如何维持)*)
            val replaceMap: Assem.instr Table.table ref = ref Table.empty
            val addMap: Assem.instr list Table.table ref = ref Table.empty
            val deleteSet: IdxSet.set ref = ref IdxSet.empty
        in
            app (fn (from, to) => processOneLoop(from, to, fgr, replaceMap, addMap, deleteSet, rdInMap, domMap, liveOutMap, liveInMap)) loopsLst;
            modifyInstrs(replaceMap, addMap, deleteSet, instrs)
        end
end 