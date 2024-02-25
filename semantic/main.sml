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
            val fName = "../testcases/semantResults/" ^ f;
            val outputStream = TextIO.openOut fName; 
            (* Run the findEscape function on the test case *)
            val () = Semant.transProg ast;
        in 
            PrintAbsyn.print (outputStream, ast);
            TextIO.closeOut(outputStream) 
        end;

fun runAllTests () = 
        let val fs = readAllFiles "../testcases";
        val exlusiveFolder = ["result", "semantResults"];
            fun contains (x, []) = false
            | contains (x, y::ys) = if x = y then true else contains (x, ys)
        in
        
            app (fn f => par f) (List.filter (fn f => (not (contains (f, exlusiveFolder)))) fs)
        end;
        

runAllTests ();
