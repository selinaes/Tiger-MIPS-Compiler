# 553-compiler

```sml
CM.make "sources.cm";
Parse.parse "../testcases/empty-let-in.tig";
use "../runTest.sml";
```

## Lexer
The details of implementation of lexer can be found at ![Lexer](./lexer/README.md).

## Parser
The details of implementation of parser(including Abstract Syntax Tree) can be found at ![Parser](./parser/README.md).