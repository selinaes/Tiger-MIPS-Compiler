structure Reg_Alloc: REG_ALLOC = 
struct
    (* structure Frame = FRAME *)
    type allocation = Frame.register Temp.Table.table
    
    fun getSpillCost node = 1
(* 
    fun alloc(instrs: Assem.instr list, frame: Frame.frame): Assem.instr list * allocation = 
        let
            val precoloredInit : allocation = Frame.tempMap

            val graph = MakeGraph.instrs2graph instrs
            val (igraph, liveOut) = Liveness.interferenceGraph(graph)
            val allocMapping: allocation * Temp.temp list = Color.color ({interference=igraph, initial=precoloredInit, spillCost=getSpillCost, registers=Frame.registers})
        in
            (, allocMapping)
        end *)
    fun printAllocation (out, mappings) = 
        let
            fun printOneMapping (t, reg) = TextIO.output(out, Temp.makestring t ^ " -> " ^ reg ^ "\n")
        in
            Temp.Table.appi printOneMapping mappings
        end

end