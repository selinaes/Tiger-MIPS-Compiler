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
            val fName = "../testcases/results/" ^ f;
            val outputStream = TextIO.openOut fName; 
        in 
            (* Run the findEscape function on the test case *)
            FindEscape.findEscape ast;
            Semant.transProg ast;
            PrintAbsyn.print (outputStream, ast);
            TextIO.closeOut(outputStream) 
        end;

fun sort (list: string list) = foldr (fn (x,lst)=> List.filter (fn a => a < x) lst @ [x] @ List.filter (fn a => a >= x) lst ) [] list;
fun contains (x, []) = false
            | contains (x, y::ys) = if x = y then true else contains (x, ys)
          

fun runAllTests () = 
        let val fs = readAllFiles "../testcases";
            val exlusiveFolder = ["results"];
            val exlusiveTest = ["testnew-err.tig"]
            val ts = List.filter (fn f => (not (contains (f, exlusiveFolder)))) fs
            val ts = List.filter (fn f => (not (contains (f, exlusiveTest)))) ts
            val ts = sort ts
        in
            app (fn f => par f) ts
        end;
        

runAllTests ();
(* par "error-inte.tig";
par "ref_test.tig"; *)
(* par "test6.tig"; *)
