
structure Main = struct

  structure Tr = Translate
  structure F = Frame
   (* structure R = RegAlloc *)

  fun getsome (SOME x) = x

  fun emitproc out (F.PROC{body,frame}) =
    let 
        (* val _ = print ("# ----- emit " ^ Symbol.name (Frame.name frame) ^ " -----\n") *)
        val _ = TextIO.output(out,"# ----- emit " ^ Symbol.name (Frame.name frame) ^ " -----\n");

        (* val _ = TextIO.output(out,"# ----- translated " ^ Symbol.name (Frame.name frame) ^ " -----\n"); *)
        (* val _ = Printtree.printtree(out,body); *)
        
        val _ = TextIO.output(out,"# ----- linearize " ^ Symbol.name (Frame.name frame) ^ " -----\n");
        val stms = Canon.linearize body
        val stms' = Canon.traceSchedule(Canon.basicBlocks stms)
        val _ = app (fn s => Printtree.printtree(out,s)) stms';

        val _ = TextIO.output(out,"# ----- Assembly " ^ Symbol.name (Frame.name frame) ^ " -----\n");
	      val instrs = List.concat(map (MipsGen.codegen frame) stms') 
        val instrs' = Frame.procEntryExit2(frame, instrs)
        val {prolog, body=body', epilog} = Frame.procEntryExit3(frame, instrs')
        val format0 = Assem.format(Temp.makestring)
 
    in  
      app (fn i => TextIO.output(out,format0 i)) body'
    end
    | emitproc out (F.STRING(lab,s)) = TextIO.output(out,F.string(lab,s))

  fun withOpenFile fname f = 
      let val out = TextIO.openOut fname
      in (f out before TextIO.closeOut out) 
          handle e => (TextIO.closeOut out; raise e)
      end 

  fun compile filename = 
       let 
          val () = (Translate.resetfragLst(); Temp.resetLabs())
          val absyn = Parse.parse filename
          val frags = (FindEscape.findEscape absyn; Semant.transProg absyn)
       in 
            withOpenFile (filename ^ ".s") 
	          (fn out => (app (emitproc out) frags))
            (* app (emitproc out) frags *)
       end

end



