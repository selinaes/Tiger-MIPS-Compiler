CM.make "sources.cm";
fun readAllFiles (dir : string) : string list =
        let
            val dirStream = OS.FileSys.openDir dir
            val files = ref []
            fun readDir () =
                    case OS.FileSys.readDir dirStream of
                        NONE => OS.FileSys.closeDir dirStream
                    | SOME d =>
                        case d of "." => readDir ()
                        | ".." => readDir ()
                        | s => (files := d :: !files; readDir ())
        in
            readDir ();
            !files
        end;
fun par f = 
        let 
            val _ = print ("Parsing ../testcases/" ^ f ^ "\n");
            val ast = Parse.parse ("../testcases/" ^ f);
            val fName = "../testcases/" ^ f ^ ".result";
            val outputStream = TextIO.openOut fName; 
            val _ = FindEscape.findEscape ast;
            val fragLst = Semant.transProg ast;
        in 

            TextIO.output(outputStream,"----------- AST -----------\n");
            PrintAbsyn.print (outputStream, ast);
            (* Run the findEscape function on the test case *)
            TextIO.output(outputStream,"----------- IR -----------\n");
            Frame.printFrag(outputStream, fragLst);
            (* Printtree.printtree(outputStream, fragLst); *)
            TextIO.output(outputStream,"----------- Proc List -----------\n");
            (* Semant.transProg ast; *)
            (* fragLst; *)
            TextIO.closeOut(outputStream)
            
        end;

fun sort (list: string list) = foldr (fn (x,lst)=> List.filter (fn a => a < x) lst @ [x] @ List.filter (fn a => a >= x) lst ) [] list;
fun contains (x, []) = false
            | contains (x, y::ys) = if x = y then true else contains (x, ys)

(* fun filterRes lst = List.filter (fn x => not (String.isSuffix ".result" x)) lst; *)

fun runAllTests () = 
        let val fs = readAllFiles "../testcases";
            val exlusiveFolder = ["skip-compile"];
            (* val exlusiveTest = ["testnew-err.tig"] *)
            val ts = List.filter (fn f => (not (contains (f, exlusiveFolder)))) fs
            (* val ts = List.filter (fn f => (not (contains (f, exlusiveTest)))) fs  *)
            val ts = List.filter (fn x => not (String.isSuffix ".result" x)) ts;
            val ts = List.filter (fn x => not (String.isSuffix ".s" x)) ts;
            val ts = sort ts
            val ts = List.map (fn x => "../testcases/" ^ x) ts

        in
            (* app (fn f => print f) ts; *)
            app (fn f => (print ("Processing ../testcases/" ^ f ^ "\n"); Main.compile f)) ts
        end;
        
fun clear() = 
        let val fs = readAllFiles "../testcases";
            val ts = List.filter (fn x => (String.isSuffix ".result" x)) fs;
        in
            app (fn f => (OS.FileSys.remove ("../testcases/" ^ f))) ts
        end;

(* clear(); *)
runAllTests ();
(* Main.compile "../testcases/test6.tig"; *)
(* par "error-inte.tig"; *)
(* par "testEsc-err.tig";  *)
(* par "test19-err.tig"; *)
(* par "merge.tig"; *)
(* par "queen.tig"; *)
