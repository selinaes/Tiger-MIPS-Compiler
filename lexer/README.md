1. how you handle comments
    We created a state called COMMENT and using a counter to keep track the number of nested loops.     
    • In the INITIAL state, if next symbol matches "/*", transition to the COMMENT state.
    • At COMMENT state, 
            next symbol matches "/*", increment the counter.
            next symbol matches "*/", decrement the counter. If counter value reaches to 0, enter the INITIAL state.
    • At the end of file, reset the counter to be 0.

2. how you handle strings;

3. error handling;
    • Throw exceptions for unclosed comment and unclosed string.
4. end-of-file handling;
    • Check for the unclosed String and unclosed Comment error.
    • Reset the comment counter, StringBuilder structure and the ErrorMsg.
    • Return the EOF token.
5. other interesting features of your lexer.
