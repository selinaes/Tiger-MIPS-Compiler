# Liveness & Register Allocation

## Get Started
- `run.sml` contains script to run the test, it will generate `.s` and `.result` files. `.s` contains assmebly code.


## Extra Credits
- We used functional record to deal with recursive reference, and it has a unit mapping to solve type reference sameness checking. use `1mutualNameTy.tig` to test.
- In "codegen.sml," we added optimization matchings, such as a BINOP add with CONST 0 is turned into an Assem.MOVE (not OPER), in this way, adding with 0 can be optimized as potential move edges in coloring.
- We used bit array to represent live-in/out map to have fast binary opperation (and/or).
- In "color.sml," we changed all worklist and moves data structures to sets using RedBlackSetFn, which makes operations easier than using doubly linked lists, as suggested by Appel.
- Coalescing is supported, try `../testcases/test1.tig`.
- Spill is supported, if out of register, put it onto stack and load it back every use. No matter how many parameters and locals a Tiger program has, our compiler can still compile it. Use `../testcases/spillTest.tig` to check the spilling implementation.
- Unfreeze is supported, try `../testcases/spillTest.tig`.(we still named it freeze in code)
- For ArrayCreateIR (in translate.sml), we optimized the code, so that we call "malloc" directly instead of "initArray." This way, we manually put the size into the first allocated int space, and return a pointer to the first array content. This solves the "I LOVE PYTHON" problem, so each initialized slot will be different, instead of copies of the same pointer.




## Features
- We hide certain 'reserved' registers from reg_alloc, by using a different "colorableTempMap" when passing colors in. In this way, register allocator do not attempt to reuse these special registers.
- We defined two kinds of sets in "color.sml," EdgeSet and NodeSet, which makes set operations easier. Any moves or interference edges are EdgeSet, and nodes are NodeSet.
- In "semant.sml" transProg, we used a namedLabel "tig_main" as the label for "startLevel," in this way, we will have a tig_main: label for the main program, letting the runtime environment know where to start.
tbook indicated in page 167 - 168.
- `procEntryExit`: 
    - 7. move the return value (result of the function) to the register reserved for that purpose
- `procEntryExit1`:  In this function, view shift is implemented: 
    - 4. Arguments conventional passing loc -> expected callee-view loc
    - 5. save callee saved regs. 
    - 8. restore callee-saves 
- `procEntryExit2`: Append sink instruction, mark regs still live at exit, prevent allocator from reuse.
- `procEntryExit3`: Rest of prologue / epilogue 
    - 1. peudo-announce start 
    - 2. function name label 
    - 3. adjust SP 
    - 9. reset SP 
    - 10. jump to return addr 
    - 11. peudo-announce end
    