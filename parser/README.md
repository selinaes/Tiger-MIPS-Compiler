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


## Error Handling
    - 

## Other
    - We set `escape` to all false whenever this field occurs in the AST, as a placeholder before semantic analysis
