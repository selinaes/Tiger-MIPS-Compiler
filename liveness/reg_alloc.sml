structure Reg_Alloc: REG_ALLOC = 
struct
    (* structure Frame = FRAME *)
    type allocation = Frame.register Temp.Table.table
    
    fun getSpillCost node = 1

    fun rewriteProgram (instrs: Assem.instr list, spill: Temp.temp list, frame: Frame.frame): Assem.instr list = 
    (* for each spill node, move it to stack, save for each def, lw for each use *)
        let
            val spillAccessMap = ref Temp.Table.empty
            (* def => store to offset *)
            (* use => load to newtemp, change all use to use newtemp *)
            fun allocSpill (spill: Temp.temp) = 
                let
                    val offset = Frame.getAccessOffset(Frame.allocLocal frame true)
                in
                    spillAccessMap := Temp.Table.enter(!spillAccessMap, spill, offset)
                end
           
            fun changeSpillInstrs (instr, acc) = 
                let
                    fun generateStores (dst: Temp.temp list) = 
                        let
                            fun storeOne (dst, (storesAcc, dstAcc)) = 
                                (case Temp.Table.look (!spillAccessMap, dst) of
                                    SOME offset => 
                                        let
                                            val v1 = Temp.newtemp()
                                            val sw = Assem.MOVE {assem="sw `s0, " ^ MipsGen.intToString offset ^ "(`d0)\n", src=v1, dst=Frame.FP}
                                        in
                                            (sw::storesAcc, v1::dstAcc)
                                        end
                                    | NONE => (storesAcc, dst::dstAcc))
                        in
                            foldr storeOne ([], []) dst
                        end
                    fun generateLoads (src: Temp.temp list) = 
                        let
                            fun loadOne (src, (loadsAcc, srcAcc)) = 
                                case Temp.Table.look (!spillAccessMap, src) of
                                    SOME offset => 
                                        let
                                            val v2 = Temp.newtemp()
                                            val lw = Assem.MOVE {assem="lw `d0, "^ MipsGen.intToString offset ^"(`s0)\n", src=Frame.FP, dst=v2}
                                        in
                                            (lw::loadsAcc, v2::srcAcc)
                                        end
                                    | NONE => (loadsAcc, src::srcAcc)
                        in
                            foldr loadOne ([], []) src
                        end
                    
                    fun instrGen instr = 
                        case instr of
                            Assem.OPER {assem, dst, src, jump} => 
                                let val (allStore, dst') = generateStores dst
                                    val (allLoad, src') = generateLoads src
                                in
                                    allStore @ [Assem.OPER {assem=assem, dst=dst', src=src', jump=jump}] @ allLoad
                                end
                            | Assem.MOVE {assem, dst, src} =>
                                let val (allStore, [dst']) = generateStores [dst]
                                    val (allLoad, [src']) = generateLoads [src]
                                in
                                    allStore @ [Assem.MOVE {assem=assem, dst=dst', src=src'}] @ allLoad
                                end
                            | instr => [instr]
                in
                    acc@(instrGen instr)
                end
        in
            let
                val _ =  app allocSpill spill;
                val x = foldr changeSpillInstrs [] instrs
                val format1 = Assem.format(Temp.makestring)
            in
                (* print spill access map *)
                print("spill access map:");
                Temp.Table.appi (fn (t, offset) => TextIO.output(TextIO.stdOut, Temp.makestring t ^ " -> " ^ Int.toString offset ^ "\n")) (!spillAccessMap);
                (* print all spill node *)
                print("spill nodes:");
                app (fn i => TextIO.output(TextIO.stdOut, Temp.makestring i ^ ", ")) spill;
                print "\n";
                 app (fn i => TextIO.output(TextIO.stdOut,format1 i)) x;
                 x
            end
           
        end

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
            (* val filteredInstrs = List.filter removeRedundantMove instrs *)
        in
            if spills = [] then
                (List.filter removeRedundantMove instrs, allocMapping)
            else
                (print "num of spills: "; print (Int.toString (length spills)); print "\n";
                alloc(rewriteProgram(instrs, spills, frame), frame))
        end
    

            
    fun printAllocation (out, mappings) = 
        let
            fun printOneMapping (t, reg) = TextIO.output(out, Temp.makestring t ^ " -> " ^ reg ^ "\n")
        in
            Temp.Table.appi printOneMapping mappings
        end

end