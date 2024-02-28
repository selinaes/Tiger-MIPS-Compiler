CM.make "sources.cm";
fun par f = 
        let 
            val _ = print ("Parsing ../testcases/" ^ f ^ "\n");
            val ast = Parse.parse ("../testcases/" ^ f);
            (* val fName = "../testcases/result/" ^ f;
            val outputStream = TextIO.openOut fName; *)
            (* Run the findEscape function on the test case *)
            val () = FindEscape.findEscape ast;
        in 
            PrintAbsyn.print (TextIO.stdOut, ast)
            (* TextIO.closeOut(outputStream) *)
        end;

par "testEsc.tig";

(* 
fun runTest 0 = print "DONE\n"
    |runTest 1 = par "test1.tig"
    |runTest n = (runTest (n-1); par ("test" ^ (Int.toString n) ^ ".tig")); *)