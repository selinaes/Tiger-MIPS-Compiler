# Lexer Implementation Details
## Comment Handling
    We created a state called COMMENT and using a counter to keep track the number of nested loops.     
    - In the INITIAL state, if next symbol matches "/*", transition to the COMMENT state.
    - At COMMENT state, 
            next symbol matches "/*", increment the counter.
            next symbol matches "*/", decrement the counter. If counter value reaches to 0, enter the INITIAL state.
    - At the end of file, reset the counter to be 0.

2. how you handle strings;

## Error Handling
    - Print error message for unclosed comment and unclosed string at EOF.
    - Report error if encountered a character where no previous rules matched. For example, '@'.
    - In String escape sequence \f__f\, if anything other than allowed formatting character appeared, report an error.
    - Continue even in error cases, so that all errors could be detected in 1 pass.
## End-of-File Handling
    - Check for the unclosed String and unclosed Comment error.
    - Reset the comment counter, StringBuilder structure and the ErrorMsg.
    - Return the EOF token.

## Other
    - We treat special characters typed using 'enter'/'tab'/etc keys as special characters, and treated hand-typed '\n', '\t' as a slash followed by the letter. So '\n' in initial state will be handled so that '\' is reported as error, and 'n' treated as an identifier

