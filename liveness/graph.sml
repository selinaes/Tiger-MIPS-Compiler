structure Graph :> GRAPH =
struct
  type node' = int
  type temp = Temp.temp

  
  structure NeighborSet = RedBlackSetFn (struct
                type ord_key = node'
                val compare = Int.compare
        end);

  (* datatype noderep = NODE of {succ: node' list, pred: node' list} *)

  datatype noderep = NODE of {succ: NeighborSet.set , pred: NeighborSet.set} 
  
  val emptyNode = NODE{succ=NeighborSet.empty,pred=NeighborSet.empty}

  val bogusSet = NeighborSet.add(NeighborSet.empty, ~1)
  val bogusNode = NODE{succ=bogusSet,pred=NeighborSet.empty}
  (* val emptyNode = NODE{succ=[],pred=[]}

  val bogusNode = NODE{succ=[~1],pred=[]} *)

  fun isBogus(NODE{succ,...}) = NeighborSet.member (succ, ~1)
    (* | isBogus _ = false *)

  (* fun isBogus(NODE{succ= ~1::_,...}) = true
    | isBogus _ = false *)

  structure A = DynamicArrayFn(struct open Array
				    type elem = noderep
				    type vector = noderep vector
				    type array = noderep array
                             end)

  type graph = A.array

  type node = graph * node'
  fun eq((_,a),(_,b)) = a=b

  fun augment (g: graph) (n: node') : node = (g,n)

  fun newGraph() = A.array(0,bogusNode)

  fun nodes g = let val b = A.bound g
                    fun f i = if isBogus( A.sub(g,i)) then nil
			           else (g,i)::f(i+1)
		 in f 0			     
                end

  fun succ(g,i) = let val NODE{succ=s,...} = A.sub(g,i) 
		   in map (augment g) (NeighborSet.listItems s) 
		  end
  fun pred(g,i) = let val NODE{pred=p,...} = A.sub(g,i)
                     in map (augment g) (NeighborSet.listItems p) 
		  end
  fun adj gi = pred gi @ succ gi

  fun newNode g = (* binary search for unused node *)
    let fun look(lo,hi) =
               (* i < lo indicates i in use
                  i >= hi indicates i not in use *)
            if lo=hi then (A.update(g,lo,emptyNode); (g,lo))
            else let val m = (lo+hi) div 2
                  in if isBogus(A.sub(g,m)) then look(lo,m) else look(m+1,hi)
                 end
     in look(0, 1 + A.bound g)
    end

  exception GraphEdge
  fun check(g,g') = (* if g=g' then () else raise GraphEdge *) ()

  fun delete(i,j::rest) = if i=j then rest else j::delete(i,rest)
    | delete(_,nil) = raise GraphEdge

  fun diddle_edge change {from=(g:graph, i),to=(g':graph, j)} = 
      let val _ = check(g,g')
          (* val i = NeighborSet.fromList i
          val j = NeighborSet.fromList j *)
          val NODE{succ=si,pred=pi} = A.sub(g,i)
          val _ = A.update(g,i,NODE{succ=change(si,j),pred=pi})
          val NODE{succ=sj,pred=pj} = A.sub(g,j)
          val _ = A.update(g,j,NODE{succ=sj,pred=change(pj,i)})
       in ()
      end

  val mk_edge = diddle_edge NeighborSet.add
  (* (op ::) *)
  val rm_edge = diddle_edge NeighborSet.delete 
  (* delete *)

  structure Table = IntMapTable(type key = node
				fun getInt(g,n) = n)


  fun nodename(g,i:int) = "n" ^ Int.toString(i)
  fun printNode (graph,i) = 
        let
          val NODE{succ=succ, pred=pred} = A.sub(graph, i)
        in
          (TextIO.output(TextIO.stdOut, (nodename (graph, i)) ^ " -> succ={");
          NeighborSet.app (fn j => TextIO.output(TextIO.stdOut, nodename(graph, j) ^ " ") ) succ;
          TextIO.output(TextIO.stdOut, "} \n       pred={");
          NeighborSet.app (fn j => TextIO.output(TextIO.stdOut, nodename(graph, j) ^ " ") ) pred;
          TextIO.output(TextIO.stdOut, "}\n"))
        end




  fun printGraph (out, graph: graph) = 
  let
    val () = ()
    (* fun printNode (g, i) = 
      let
        val NODE{succ=succ, pred=pred} = A.sub(g, i)
      in
        (TextIO.output(out, (nodename (g, i)) ^ " -> succ={");
        NeighborSet.app (fn j => TextIO.output(out, nodename(graph, j) ^ " ") ) succ;
        TextIO.output(out, "} \n       pred={");
        NeighborSet.app (fn j => TextIO.output(out, nodename(graph, j) ^ " ") ) pred;
        TextIO.output(out, "}\n"))
      end *)
  in
    (TextIO.output(out, "digraph G {\n");
    app printNode (nodes graph);
    TextIO.output(out, "}\n"))
  end

end

