# Instruction Selection

## Get Started
- `run.sml` contains script to run the test, it will generate `.s` and `.result` files. `.s` contains assmebly code.



## Features
- We add "instrs" field to the frame data structure, which is the function formals viewshift instructions. They are initialized in `Frame.newFrame` as we allocate accesses for formals.
- Currently, we use function names as function label in PROC. This might cause problem if two functions have the same name, and exist in different scopes. But we currently keep it as is for debugging easiness. We'll change to 'newlabel' at the end.
- To malloc array, we malloc size of 4 * (size + 1) space. And move pointer of the array to the first element, and store size at the beginning of the array. Thus, we can access size using `pointer - 4`.
- We have implemented procEntryExit to satisfy frame modification requirement mentioned in textbook. 

The number below is from textbook indicated in page 167 - 168.
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
    