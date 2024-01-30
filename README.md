# 553-compiler

```sml
CM.make "sources.cm";
Parse.parse "test.tig";
Tokens.STRING(!StringBuilder.sb, !StringBuilder.startPos, yypos+1)
formatChars = [\t\ \f\r\n];
```

## Lexer
The details of implementation of lexer can be found at ![Lexer](./lexer/README.md).