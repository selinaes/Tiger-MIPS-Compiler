# Full runnable Compiler

## Get Started
- `run.sml` contains script to run the test, it will generate `.s` file containing assmebly code. 
- Download a MIPS simulator, like 'SPIM', then load the generated `.s` code in, then it could correctly run.


## Extra Credits
- We used functional record to deal with recursive reference, and it has a unit mapping to solve type reference sameness checking. use `1mutualNameTy.tig` to test.
- In "codegen.sml," we added optimization matchings
    - BINOP add with CONST 0 is turned into an Assem.MOVE (not OPER), in this way, adding with 0 can be optimized as potential move edges in coloring
    - MOVE from a CONST to a TEMP is turned into a single `addi`, instead of one `move` and one `addi`, saving many instructions
    - For both, verify at `../testcases/spillTest.tig`.
- We used bit array to represent live-in/out map to have fast binary opperation (and/or).
- In "color.sml," we changed all worklist and moves data structures to sets using RedBlackSetFn, which makes operations easier than using doubly linked lists, as suggested by Appel.
- Coalescing is supported, try `../testcases/test1.tig`.
- Spill is supported, if out of register, put it onto stack and load it back every use. No matter how many parameters and locals a Tiger program has, our compiler can still compile it. Use `../testcases/spillTest.tig` to check the spilling implementation.
- Unfreeze is supported, try `../testcases/spillTest.tig`.(we still named it freeze in code)
- For ArrayCreateIR (in translate.sml), we optimized the code, so that we call "malloc" directly instead of "initArray." This way, we manually put the size into the first allocated int space, and return a pointer to the first array content. This solves the "I LOVE PYTHON" problem, so each initialized slot will be different, instead of copies of the same pointer. try `../testcases/test42.tig`. It will print two different names.
- After implementing spills, we no longer save and store all calleesave("s")+RA registers. In procEntryExit1, we move each calleesave into a new temp, then after the body, move them back. This way, 
    - Used calleesaves will be spilled automatically, and unused calleesaves won't be stored/restored, saving instructions. The difference could be shown in `../testcases/merge.tig`.
    - Only non-leaf functions will save and restore RA. Could be shown in `../testcases/simpleTest.tig`.




## Features
- Added `runtime-le.s` and `sysspim.s` before generated `.s` file. Modified library function name (ex. ord to tig_ord), so that external calls find them correctly
- Added needed headers, such as `.data` and the word-aligned ascii strings into it, also `.text` directive.
- Fix procEntryExit1/2/3, and tested to ensure entry/exit function work correctly during actual run.