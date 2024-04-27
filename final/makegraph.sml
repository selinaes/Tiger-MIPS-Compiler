structure MakeGraph: MAKE_GRAPH = 
struct
    structure A = Assem
    structure F = Flow
    structure G = Graph
    structure Err = ErrorMsg

    fun printInstrs(instrs) = 
        let
            val len = length instrs
            fun printOne(index) = 
                let
                    val format0 = Assem.format(Temp.makestring)
                    val str = format0 (List.nth (instrs, index))
                in
                    print ( "n" ^ Int.toString index ^ " : " ^ String.substring(str,0,String.size(str)-1)  ^ "\n");
                    if (index + 1 = len) then () else printOne(index+1)
                end
        in  
            printOne(0)
        end

    fun instrs2graph(instrs: A.instr list): Flow.flowgraph * Graph.node list = 
        let
            val N = Temp.getTemps()
          
            fun getInstrSrcDst instr = 
                case instr of
                    A.OPER{assem, dst, src, ...} => (src, dst)
                  | A.LABEL{lab, ...} => (nil, nil)
                  | A.MOVE{assem, dst, src} => ([src], [dst])
            
            (* label -> node, use to fast search node with given jump label  *)
            

            (*'a * 'b -> 'b *)
            (* fun addNode (nil, fgr) = fgr *)
            fun convertInstrToString (instr) = 
                case instr of
                    A.OPER{assem, dst, src, jump} => "OPER" 
                  | A.LABEL{lab, ...} => "LABEL"
                  | A.MOVE{assem, dst, src} => "MOVE"

            fun addNode (instr, F.FGRAPH {control,nodeToInstr, labelNodeMap,def,use,ismove,rdgen,rdkill}): F.flowgraph = 
                let
                    
                    val node = G.newNode control
                    (* val instrlst = [21, 16, 17, 18, 19, 20 , 22, 23] *)
                    (* val instrlst = [25] *)
                    (* String.substring(str,0,String.size(str)-1) *)
                    (* val _ = if (List.exists (fn f => (f = G.nodenum node)) instrlst)
                            then (
                                let
                                val format0 = Assem.format(Temp.makestring)
                                val str = format0 instr
                                in print ( G.nodename node ^ " : " ^ str ^ "\n")
                                end
                            )
                            else ()*)


                    val (srcs, dsts) = getInstrSrcDst instr
                    val bitDsts = BitArray.bits(N, map (fn x => x - 100) dsts)
                    val bitSrcs = BitArray.bits(N, map (fn x => x - 100) srcs)
                    val nodeToInstr = G.Table.enter(nodeToInstr, node, instr)
                    val def = G.Table.enter(def, node, bitDsts)
                    val use = G.Table.enter(use, node, bitSrcs)
                    val ismove' = G.Table.enter(ismove, node, case instr of A.MOVE _ => true | _ => false)
                    val labelNodeMap' = case instr of
                        A.LABEL{lab: Symbol.symbol, ...} => (let val labelNodeMap' = Symbol.enter(labelNodeMap, lab, node) in labelNodeMap' end)
                      | _ => labelNodeMap

                in
                    F.FGRAPH {control = control,
                              nodeToInstr = nodeToInstr,
                              labelNodeMap = labelNodeMap',
                              def = def,
                              use = use,
                              ismove = ismove',
                              rdgen = rdgen,
                              rdkill = rdkill}
                end 

            
            fun addEdge ([i], [n], index, fg as F.FGRAPH{labelNodeMap,...}) = ()
            | addEdge (instr::restI, (n1::n2::nodes): G.node list, index, fg as F.FGRAPH{labelNodeMap,...}) = 
                (case instr of
                    (* has jump label, add edge to nodes with those label *)
                    A.OPER{assem, dst, src, jump=SOME labs} => 
                        let
                            fun mkJumpEdge lab = 
                                case Symbol.look(labelNodeMap, lab) of
                                    NONE => Err.impossible ("not found jump label " ^ Symbol.name lab ^ " node in labelNodeMap")
                                  | SOME node => G.mk_edge({from=n1, to=node})
                        in
                            app mkJumpEdge labs;
                            addEdge(restI, n2::nodes, index + 1, fg)
                        end
                    (* fall through, add edge to the next instruction node *)
                  |  _ => 
                        (G.mk_edge({from=n1, to=n2}); 
                        addEdge(restI, n2::nodes, index + 1, fg))
                )
            | addEdge (_, _, _, _) = Err.impossible "addEdge: instrs and nodes length not match"

            (* unambiguous definition: Assems with content in def[] *)
            val rdDefs: BitArray.array Temp.Table.table ref = ref Temp.Table.empty
            val instrN = length instrs
            fun computeRdDefs([], _) = ()
            | computeRdDefs (instr::rest, index) = 
                let
                    (* if instr dst is t, add index to t *)
                    val (_, dstLst) = getInstrSrcDst(instr)
                    fun forEachDst t =
                        let 
                            val bitarray = Option.getOpt(Temp.Table.look(!rdDefs,t), BitArray.bits (instrN, []))
                        in
                            BitArray.setBit(bitarray, index);
                            rdDefs := Temp.Table.enter(!rdDefs, t, bitarray) 
                        end
                in 
                    app forEachDst dstLst;
                    computeRdDefs (rest, index + 1)
                end
                
            fun addRdInfo (instrs) (F.FGRAPH {control,nodeToInstr,labelNodeMap,def,use,ismove,rdgen,rdkill}) = 
                let
                    fun addOneRdInfo ([], _) = (rdgen,rdkill)
                    | addOneRdInfo (instr::rest, index) = 
                        let
                            val (_, dstLst) = getInstrSrcDst(instr)
                            val genSet = if (length dstLst > 0)  (* genset empty if not definition *)
                                        then BitArray.bits(instrN,[index])
                                        else BitArray.bits(instrN, [])
                            fun addOneDstInfoToKill [] = BitArray.bits(instrN,[])
                                | addOneDstInfoToKill (dst::rest) = 
                                    let
                                        val dstDefs = Option.getOpt(Temp.Table.look(!rdDefs, dst), BitArray.bits (instrN, []))
                                        val dstDefs' = BitArray.bits(instrN, BitArray.getBits(dstDefs)) (* deep copy *)
                                    in
                                        BitArray.clrBit(dstDefs', index);
                                        (BitArray.union dstDefs' (addOneDstInfoToKill(rest)));
                                        dstDefs'
                                    end
                            val killSet = addOneDstInfoToKill dstLst
                            val instrNode = List.nth(G.nodes control, index)
                            val (rdgen, rdkill) = addOneRdInfo (rest,index + 1)
                        in 
                            (Graph.Table.enter(rdgen, instrNode, genSet),
                            Graph.Table.enter(rdkill, instrNode, killSet))
                        end
                    val (rdgen', rdkill') = addOneRdInfo (instrs,0)
                in
                    F.FGRAPH {control = control,
                              nodeToInstr = nodeToInstr,
                              labelNodeMap = labelNodeMap,
                              def = def,
                              use = use,
                              ismove = ismove,
                              rdgen = rdgen',
                              rdkill = rdkill'}
                end


            val control = G.newGraph()
            val emptyGraph = F.FGRAPH {control = control,
                        nodeToInstr = Graph.Table.empty,
                        labelNodeMap = Symbol.empty,
                        def = Graph.Table.empty,
                        use = Graph.Table.empty,
                        rdgen = Graph.Table.empty,
                        rdkill = Graph.Table.empty,
                        ismove = G.Table.empty}
            
            val flowGraph: F.flowgraph = foldl addNode emptyGraph instrs 
            val _ = computeRdDefs (instrs, 0)
            val flowGraph = addRdInfo instrs flowGraph
        in
            
            (* print (Int.toString(length (Symbol.listItems(!labelNodeMap)))); *)
            addEdge(instrs, G.nodes control, 0, flowGraph);
            (* G.printGraph (TextIO.stdOut,control); *)
            (flowGraph, G.nodes control)
        end
end