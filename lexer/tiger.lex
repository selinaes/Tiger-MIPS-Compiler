

(* Define a global variable *)
structure Comment =
struct
    val nestedLoop = ref 0
    fun incrementLoop () = nestedLoop := (!nestedLoop + 1)
    fun decrementLoop () = nestedLoop := (!nestedLoop - 1)
    fun reset () = nestedLoop := 0
end
(* val _ = reset () *)


type pos = int
type lexresult = Tokens.token

val lineNum = ErrorMsg.lineNum
val linePos = ErrorMsg.linePos
fun err(p1,p2) = ErrorMsg.error p1

fun eof() = 
    let 
        val pos = hd(!linePos) 
    in 
        (* if StringBuilder.inStrState () 
        then 
            ErrorMsg.error yypos ("End of File still unclosed String")
        else if !Comment.nestedLoop <> 0
        then 
            ErrorMsg.error yypos ("End of File still unclosed Comment")
        else
            (); *)
        reset ();
        Tokens.EOF(pos,pos);
    end

%%
%s COMMENT STRING;
alpha=[A-Za-z];
digit=[0-9];
ws = [\r\ \t];

%%
<INITIAL, COMMENT, STRING>\n      => (lineNum := !lineNum+1; linePos := yypos :: !linePos; continue());




<INITIAL>type    => (Tokens.TYPE(yypos,yypos+4));
<INITIAL>var     => (Tokens.VAR(yypos,yypos+3));
<INITIAL>function    => (Tokens.FUNCTION(yypos,yypos+7));
<INITIAL>break   => (Tokens.BREAK(yypos,yypos+5));
<INITIAL>of      => (Tokens.OF(yypos,yypos+2));
<INITIAL>end     => (Tokens.END(yypos,yypos+3));
<INITIAL>in      => (Tokens.IN(yypos,yypos+2));
<INITIAL>nil     => (Tokens.NIL(yypos,yypos+3));
<INITIAL>let     => (Tokens.LET(yypos,yypos+3));
<INITIAL>do      => (Tokens.DO(yypos,yypos+2));
<INITIAL>to      => (Tokens.TO(yypos,yypos+2));
<INITIAL>for     => (Tokens.FOR(yypos,yypos+3));
<INITIAL>while   => (Tokens.WHILE(yypos,yypos+5));
<INITIAL>else    => (Tokens.ELSE(yypos,yypos+4));
<INITIAL>then    => (Tokens.THEN(yypos,yypos+4));
<INITIAL>if      => (Tokens.IF(yypos,yypos+2));
<INITIAL>array   => (Tokens.ARRAY(yypos,yypos+5));
<INITIAL>":="    => (Tokens.ASSIGN(yypos,yypos+2));
<INITIAL>"|"     => (Tokens.OR(yypos,yypos+1));
<INITIAL>"&"     => (Tokens.AND(yypos,yypos+1));
<INITIAL>">="    => (Tokens.GE(yypos,yypos+2));
<INITIAL>">"     => (Tokens.GT(yypos,yypos+1));
<INITIAL>"<="    => (Tokens.LE(yypos,yypos+2));
<INITIAL>"<"     => (Tokens.LT(yypos,yypos+1));
<INITIAL>"<>"    => (Tokens.NEQ(yypos,yypos+2));
<INITIAL>"="     => (Tokens.EQ(yypos,yypos+1));
<INITIAL>"/"     => (Tokens.DIVIDE(yypos,yypos+1));
<INITIAL>"*"     => (Tokens.TIMES(yypos,yypos+1));
<INITIAL>"-"     => (Tokens.MINUS(yypos,yypos+1));
<INITIAL>"+"     => (Tokens.PLUS(yypos,yypos+1));
<INITIAL>"."     => (Tokens.DOT(yypos,yypos+1));
<INITIAL>"}"     => (Tokens.RBRACE(yypos,yypos+1));
<INITIAL>"{"     => (Tokens.LBRACE(yypos,yypos+1));
<INITIAL>"]"     => (Tokens.RBRACK(yypos,yypos+1));
<INITIAL>"["     => (Tokens.LBRACK(yypos,yypos+1));
<INITIAL>")"     => (Tokens.RPAREN(yypos,yypos+1));
<INITIAL>"("     => (Tokens.LPAREN(yypos,yypos+1));
<INITIAL>";"     => (Tokens.SEMICOLON(yypos,yypos+1));
<INITIAL>":"     => (Tokens.COLON(yypos,yypos+1));
<INITIAL>","     => (Tokens.COMMA(yypos,yypos+1));

<INITIAL>{alpha}({alpha}|{digit})* => (Tokens.ID(yytext, yypos, yypos+size(yytext)-1));


<INITIAL>{digit}+ => (Tokens.INT(valOf (Int.fromString(yytext)), yypos, yypos+size(yytext)-1));


<INITIAL>"\""   => (YYBEGIN STRING; continue());
<STRING>"\""    => (YYBEGIN INITIAL; continue());
<STRING>.       => (continue());

<INITIAL>"/*"   => (Comment.incrementLoop();print "enter comment\n"; YYBEGIN COMMENT; continue());
<COMMENT>"/*"   => (Comment.incrementLoop();print "enter comment deeper\n";continue());
<COMMENT>"*/"   => (Comment.decrementLoop();print ("out comment layer" ^ (Int.toString(!nestedLoop)) ^ "\n"); if !Comment.nestedLoop = 0 then YYBEGIN INITIAL else (); continue());
<COMMENT>.      => (continue());


<INITIAL>.      => (continue());
