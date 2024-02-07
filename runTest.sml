(* To use this test script, use "../runTest.sml"; *)
CM.make "sources.cm";
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

runTest 49;
par "merge.tig";
par "queens.tig";
