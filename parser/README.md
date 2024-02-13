# Parser Implementation Details

## Quick Start
- To run our parser, start sml REPL under this folder and type `CM.make "sources.cm";` 
- `Parse.parse "<input_tiger_file>";` to parse the input file, path is relative to sml start path. 
- Run all tests together inside the `553-compiler/testcases` folder, type `use "../runTest.sml";`

## Shift-reduce conflict
    We currently don't have any shift-reduce conflict or reduce-reduce conflict.

## Parsable Correct Syntax
    - Refer to Appel's textbook `Appendix: Tiger Language Reference Manual` for details for syntax
    - All grammars we wrote followed Appel's descriptions


## Error
    - Now whenever there's an invalid syntax (tokens can be parsed, but the sequence of syntax does not make sense), the parser will report an error like
    ```
    uncaught exception Error
    raised at: parse.sml:17.48-17.62
             ../compiler/TopLevel/interact/interact.sml:56.51-56.55
    ```
    And the parse will stop.
    We asked Drew and he thinks it is a reasonable behavior.

## Other
    - We set `escape` to all false whenever this field occurs in the AST, as a placeholder before semantic analysis
