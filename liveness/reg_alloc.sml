structure Reg_Alloc: REG_ALLOC = 
struct
    (* structure Frame = FRAME *)
    type allocation = Frame.register Temp.Table.table
    
    fun getSpillCost node = 1

    fun rewriteProgram (instrs: Assem.instr list, spill: Temp.temp list, frame: Frame.frame):Assem.instr list = instrs

    fun alloc(instrs: Assem.instr list, frame: Frame.frame): Assem.instr list * allocation = 
        let
            val precoloredInit : allocation = Frame.tempMap

            val (fgr, ndlist) = MakeGraph.instrs2graph instrs
            val (igraph, liveOut) = Liveness.interferenceGraph(fgr)
            val (allocMapping, spills): allocation * Temp.temp list = Color.color ({interference=igraph, initial=precoloredInit, spillCost=getSpillCost, registers=Frame.registers})
            fun removeRedundantMove instr = 
                (case instr of 
                    Assem.MOVE {src, dst, ...} => 
                        let
                            val srcColor = valOf(Temp.Table.look (allocMapping, src))
                            val dstColor = valOf(Temp.Table.look (allocMapping, dst))
                        in
                            srcColor <> dstColor
                        end
                    | _ => true)
            val filteredInstrs = List.filter removeRedundantMove instrs
        in
            if spills = [] then
                (filteredInstrs, allocMapping)
            else
                alloc(rewriteProgram(instrs, spills, frame), frame)
        end
    

            
    fun printAllocation (out, mappings) = 
        let
            fun printOneMapping (t, reg) = TextIO.output(out, Temp.makestring t ^ " -> " ^ reg ^ "\n")
        in
            Temp.Table.appi printOneMapping mappings
        end

end