structure MakeGraph: MAKE_GRAPH = 
struct
    structure A = Assem
    structure F = Flow
    structure G = Graph
    structure Err = ErrorMsg


    fun instrs2graph(instrs: A.instr list): Flow.flowgraph * Graph.node list = 
        let
            val N = Temp.getTemps()
            val emptyGraph = F.FGRAPH {control = G.newGraph(),
                                    def = Graph.Table.empty,
                                    use = Graph.Table.empty,
                                    ismove = G.Table.empty}
            fun getInstrSrcDst instr = 
                case instr of
                    A.OPER{assem, dst, src, ...} => (src, dst)
                  | A.LABEL{lab, ...} => (nil, nil)
                  | A.MOVE{assem, dst, src} => ([src], [dst])
            
            (* label -> node, use to fast search node with given jump label  *)
            val labelNodeMap: Graph.node Symbol.table ref = ref Symbol.empty
            

            (*'a * 'b -> 'b *)
            fun addNode (instr, F.FGRAPH {control,def,use,ismove}): F.flowgraph = 
                let
                    val node = G.newNode control
                    val (srcs, dsts) = getInstrSrcDst instr
                    val bitDsts = BitArray.bits(N, map (fn x => x - 100) dsts)
                    val bitSrcs = BitArray.bits(N, map (fn x => x - 100) srcs)
                    val def = G.Table.enter(def, node, bitDsts)
                    val use = G.Table.enter(use, node, bitSrcs)
                    val ismove = G.Table.enter(ismove, node, case instr of A.MOVE _ => true | _ => false)
                    val () = case instr of
                        A.LABEL{lab, ...} => labelNodeMap := Symbol.enter(!labelNodeMap, lab, node)
                      | _ => ()
                in
                    F.FGRAPH {control = control,
                              def = def,
                              use = use,
                              ismove = ismove}
                end 

            
            fun addEdge ([], _, _) = ()
            | addEdge ([i], [n], index) = ()
            | addEdge (instr::restI, (n1::n2::nodes): G.node list, index) = 
                case instr of
                    (* has jump label, add edge to nodes with those label *)
                    A.OPER{assem, dst, src, jump=SOME labs, ...} => 
                        let
                            fun mkJumpEdge lab = 
                                case Symbol.look(!labelNodeMap, lab) of
                                    NONE => Err.impossible "not found jump label node in labelNodeMap"
                                  | SOME node => G.mk_edge({from=n1, to=node})
                        in
                            app mkJumpEdge labs;
                            addEdge(restI, n2::nodes, index + 1)
                        end
                    (* fall through, add edge to the next instruction node *)
                  |  A.OPER{assem, dst, src, jump=NONE, ...} => 
                        (G.mk_edge({from=n1, to=n2}); 
                        addEdge(restI, n2::nodes, index + 1))
                  | _ => addEdge(restI, n2::nodes, index + 1)
            val graph: F.flowgraph = foldl addNode emptyGraph instrs
        in
            addEdge(instrs, G.nodes (#control graph), 0);
            (graph, G.nodes graph)
        end
end