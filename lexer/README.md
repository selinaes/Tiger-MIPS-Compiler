# Lexer Implementation Details

## Quick Start
- To run our lexer, start sml REPL and type `CM.make "sources.cm";` to build the lexer. 
- `Parse.parse "<input_tiger_file>";` to parse the input file, path is relative to sml start path. 

## Comment Handling
    We created a state called COMMENT and using a counter to keep track the number of nested loops.     
    - In the INITIAL state, if next symbol matches "/*", transition to the COMMENT state.
    - At COMMENT state, 
            next symbol matches "/*", increment the counter.
            next symbol matches "*/", decrement the counter. If counter value reaches to 0, enter the INITIAL state.
    - At the end of file, reset the counter to be 0.

## String Handling
- `<STRING>` state is to enter string mode when it detech a `"`. In `<STRING>`, it initalized a buffer to keep track of all characters scanned so far. Once it gets to another closed `"`, it generated a string token and refresh button. 
- For multi-line string, it needs to be two `\` at end of the firt line and `\` at the begin of the second. Following examples are the valid input file.
```tiger
var s1 = "\n\t\\\""
val s2 = "asd\ 
	
	\asd"
var s5 = "this is a really long string\
\ that spans multiple  lines\
\ the slash at the end of the line says to continue to the next\
\ and the slash at the front of the line says where to start it"
```
Follwing examples are not valid:
```tiger
/* cannot manully type \n between two slash */
val s3 = "str\ \n
	\hahaaha"
```
- Multi-line String have a entire regex to match any non-printable characters between two slashes. It will ignore everything between as well as slashes. 

- How to handle `\ddd`: when regex match any `\(0-254)` (valid ascii number), it will first drop the first slash and convert the number into char, then append the char to buffer.

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

