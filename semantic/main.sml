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
        in
            app (fn f => par f) fs
        end;
        

runAllTests ();
