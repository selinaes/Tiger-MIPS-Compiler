(* To use this test script, use "../runTest.sml"; *)
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
        end

fun par f = 
        let 
            val _ = print ("Parsing ./testcases/" ^ f ^ "\n");
            val v = Parse.parse ("../testcases/" ^ f)
            val fName = "../testcases/result/" ^ f;
            val outputStream = TextIO.openOut fName;
        in 
    
            PrintAbsyn.print (outputStream, v);
            TextIO.closeOut(outputStream)
        end

fun runTest 0 = print "DONE\n"
    |runTest 1 = par "test1.tig"
    |runTest n = (runTest (n-1); par ("test" ^ (Int.toString n) ^ ".tig"));

fun runAllTests () = 
        let val fs = readAllFiles "../testcases";
        in
            app (fn f => par f) fs
        end;
        

runAllTests ();