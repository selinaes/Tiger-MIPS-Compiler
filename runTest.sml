(* To use this test script, use "../runTest.sml" *)
CM.make "sources.cm";
fun par f = 
    (print ("Parsing ./testcases/" ^ f ^ "\n");
    Parse.parse ("../testcases/" ^ f));

fun runTest 0 = print "DONE\n"
    |runTest 1 = par "test1.tig"
    |runTest n = (runTest (n-1); par ("test" ^ (Int.toString n) ^ ".tig"));

runTest 49;
par "../testcases/merge.tig";
par "../testcases/queens.tig";
