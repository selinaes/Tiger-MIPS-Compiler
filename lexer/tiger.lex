

(* Define a global variable *)
type pos = int
type lexresult = Tokens.token

val lineNum = ErrorMsg.lineNum
val linePos = ErrorMsg.linePos
fun err(p1,p2) = ErrorMsg.error p1
fun newLine(yypos) = (lineNum := !lineNum+1; linePos := yypos :: !linePos);

structure Comment =
struct
    val nestedLoop = ref 0
    fun incrementLoop () = nestedLoop := (!nestedLoop + 1)
    fun decrementLoop () = nestedLoop := (!nestedLoop - 1)
    fun reset () = nestedLoop := 0
end

structure StringBuilder =
struct
    val sb : string ref = ref ""
    val startPos : int ref = ref 0
    val inStrState : bool ref = ref false

    fun enterStrState(yypos) = (inStrState := true; startPos := yypos)
    fun exitStrState() = inStrState := false

    fun formatHandler(yypos, str) = 
        let
            
            fun countHelper([], posList, lineSize) : int list = posList
            | countHelper(#"\n"::rest, posList, lineSize) = countHelper(rest, (yypos + lineSize) :: posList, lineSize + 1)
            | countHelper(_::rest, posList, lineSize) = countHelper(rest, posList, lineSize + 1)
            val pl = countHelper(String.explode str, [], 0)
            fun callNewLine (x, acc) = 
                let val f = newLine x;
                in 
                    acc
                end
        in
            foldr callNewLine () pl
        end;
        

    fun isEmpty() = String.size (!sb) = 0

    fun concat(s) = sb := !sb ^ s

    fun appendChar(c) = sb := !sb ^ (Char.toString c)

    fun reset() = (sb := ""; startPos := 0)

    fun toString(endPos) = 
        let
            val token = Tokens.STRING(!sb, !startPos, endPos)
        in
            reset();
            token
        end;
end

(* convert escaped ascii in form \ddd to char *)
fun toChar ascii = 
                Char.chr (valOf (Int.fromString (String.extract (ascii, 1, NONE))));




fun eof() = 
    let 
        val pos = hd(!linePos) 
    in 
        if !StringBuilder.inStrState 
        then 
            ErrorMsg.error pos ("End of File still unclosed String")
        else if !Comment.nestedLoop <> 0
        then 
            ErrorMsg.error pos ("End of File still unclosed Comment")
        else
            ();
        Comment.reset ();
        StringBuilder.reset ();
        Tokens.EOF(pos,pos)
    end

%%
%s COMMENT STRING;
alpha=[A-Za-z];
digit=[0-9];
ascii = 00digit|01-9{digit}|1{digit}{digit}|2[0-4]{digit}|25[0-5];
ws = [ \t\012\r];
formatChars = [ \t\012\r\n];
%%
<INITIAL, COMMENT>\n      => (newLine yypos; continue());
<INITIAL, COMMENT>{ws}+      => (continue());

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

<INITIAL>{alpha}({alpha}|{digit}|_)* => (Tokens.ID(yytext, yypos, yypos+size(yytext)));
<INITIAL>{digit}+ => (Tokens.INT(valOf (Int.fromString(yytext)), yypos, yypos+size(yytext)));

<INITIAL>\"   => (YYBEGIN STRING; StringBuilder.enterStrState(yypos); continue());
<STRING>\\\\    => (StringBuilder.concat "\\"; continue());
<STRING>\\\"    => (StringBuilder.concat "\""; continue());
<STRING>\\n    => (StringBuilder.concat "\n"; continue());
<STRING>\\t    => (StringBuilder.concat yytext; continue());
<STRING>[ ]+    => (StringBuilder.concat yytext; continue());
<STRING>\\{ascii} => (StringBuilder.appendChar (toChar yytext); continue());
<STRING>\"    => (YYBEGIN INITIAL; StringBuilder.exitStrState(); StringBuilder.toString(yypos+1));
<STRING>\\{formatChars}+\\   => (StringBuilder.formatHandler (yypos, yytext); continue());
<STRING>\\.    => (ErrorMsg.error yypos ("Unrecongized escaped chars : " ^ yytext); continue());

<STRING>.   => (StringBuilder.concat yytext; continue());
<STRING>\n   => (ErrorMsg.error yypos ("newline in string without \\\\ "); newLine yypos; continue());
<STRING>{ws}+ => (continue());

<INITIAL>"/*"   => (Comment.incrementLoop(); YYBEGIN COMMENT; continue());
<COMMENT>"/*"   => (Comment.incrementLoop(); continue());
<COMMENT>"*/"   => (Comment.decrementLoop(); if !Comment.nestedLoop = 0 then YYBEGIN INITIAL else (); continue());
<COMMENT>.      => (continue());


<INITIAL>.      => (ErrorMsg.error yypos ("Incorrect unmatched : " ^ String.extract(yytext, 0, NONE)); continue());
