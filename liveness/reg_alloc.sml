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
                                            val sw = Assem.OPER {assem="sw `s0, " ^ MipsGen.intToString offset ^ "(`s1)\n", src=[v1,Frame.FP], dst=[],jump=NONE}
                                             (* val format0 = Assem.format(Temp.makestring) *)
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
                                            val lw = Assem.OPER {assem="lw `d0, "^ MipsGen.intToString offset ^"(`s0)\n", src=[Frame.FP], dst=[v2],jump=NONE}
                                            (* val format0 = Assem.format(Temp.makestring) *)
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
                            (* 
                            lw -> src: FP, dst: v2
                            lw -> src: FP, dst: v2'
                            add t219, t220, t143 -> src: t220, t143, dst: t219. => src: v2, v2', dst: v1
                            sw -> src: v1, dst: FP
                            *)
                                let 
                                    val (allLoad, src') = generateLoads src
                                    val (allStore, dst') = generateStores dst
                                    val format0 = Assem.format(Temp.makestring)
                                in
                                    print "loads:";
                                    app (fn i => TextIO.output(TextIO.stdOut,format0 i)) allLoad;
                                    print "instr:";
                                    TextIO.output(TextIO.stdOut, format0 (Assem.OPER {assem=assem, dst=dst, src=src, jump=jump}));
                                    print "   new:    ";
                                    TextIO.output(TextIO.stdOut, format0 (Assem.OPER {assem=assem, dst=dst', src=src', jump=jump}));
                                    print "stores:";
                                    app (fn i => TextIO.output(TextIO.stdOut,format0 i)) allStore;
                                    print "\n----------------\n";
                                   allLoad @ [Assem.OPER {assem=assem, dst=dst', src=src', jump=jump}] @ allStore
                                end
                            | Assem.MOVE {assem, dst, src} =>
                                let val (allStore, [dst']) = generateStores [dst]
                                    val (allLoad, [src']) = generateLoads [src]
                                    val format0 = Assem.format(Temp.makestring)
                                in
                                    print "loads:";
                                    app (fn i => TextIO.output(TextIO.stdOut,format0 i)) allLoad;
                                    print "instr:";
                                    TextIO.output(TextIO.stdOut, format0 (Assem.MOVE {assem=assem, dst=dst, src=src}));
                                    print "   new:    ";
                                    TextIO.output(TextIO.stdOut, format0 (Assem.MOVE {assem=assem, dst=dst', src=src'}));
                                    print "stores:";
                                    app (fn i => TextIO.output(TextIO.stdOut,format0 i)) allStore;
                                    print "\n----------------\n";
                                    allLoad @ [Assem.MOVE {assem=assem, dst=dst', src=src'}] @ allStore
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
                (* print("spill access map:" ^ (Int.toString (length(Temp.Table.listItems (!spillAccessMap)))) ^ "\n");  *)
                (* Temp.Table.appi (fn (t, offset) => TextIO.output(TextIO.stdOut, Temp.makestring t ^ " -> " ^ Int.toString offset ^ "\n")) (!spillAccessMap); *)
                (* print all spill node  *)
                 print("spill nodes:" ^ (Int.toString (length spill)) ^ "\n");
                app (fn i => TextIO.output(TextIO.stdOut, Temp.makestring i ^ ", ")) spill;
                print "\n";
                 (* app (fn i => TextIO.output(TextIO.stdOut,format1 i)) x; *)
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
                (* (List.filter removeRedundantMove  *)
                (instrs, allocMapping)
            else 
                let
                    val x = rewriteProgram(instrs, spills, frame)
                in
                    print("rewrite program done\n");
                    alloc(x, frame)
                end
            (* (List.filter removeRedundantMove instrs, allocMapping) *)
            (* ( *)
                (* (print "num of spills: "; print (Int.toString (length spills)); print "\n"; *)
                 (* print("spill nodes:");
                app (fn i => TextIO.output(TextIO.stdOut, Temp.makestring i ^ ", ")) spill *)
                (* alloc(rewriteProgram(instrs, spills, frame), frame) *)
        end
    

            
    fun printAllocation (out, mappings) = 
        let
            fun printOneMapping (t, reg) = TextIO.output(out, Temp.makestring t ^ " -> " ^ reg ^ "\n")
        in
            Temp.Table.appi printOneMapping mappings
        end

end