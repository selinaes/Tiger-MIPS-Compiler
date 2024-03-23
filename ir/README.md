# Frame Analysis and IR


- dummy: We used a dummy IR (external call exit)
    -- test19-err.tig, line 8 because 'a' is not defiend in do_nothing2's scope, we cannot find it, then the transVar in Semant will turn it into a ty "IMPOSSIBLE", and return an exp "dummy", then the IR will turn this argument into EXIT. In reality, we will generate an 'undefined variable' error at type-checking stage and stop processing. But for purpose of continuation, we didn't stop.

- bound checking: when accessing array, ir checked the index is in the range `0 <= index < array length`. The memory layout for the array is that it points to the first element of the array, and - 4 store the length of the array. So, it first move length to a register and compare index is valid. 