# 553-compiler

```sml
CM.make "sources.cm";
Parse.parse "../testcases/empty-let-in.tig";
use "../runTest.sml";
```

```sml
use "main.sml";
```

## Lexer
The details of implementation of lexer can be found at ![Lexer](./lexer/README.md).

## Parser
The details of implementation of parser(including Abstract Syntax Tree) can be found at ![Parser](./parser/README.md).

## Type Checker
The details of implementation of a type checker (including Escape analyzer) can be found at ![Semantic](./semantic/README.md).


## IR
The details of implementation of a type checker (including Escape analyzer) can be found at ![IR](./ir/README.md).