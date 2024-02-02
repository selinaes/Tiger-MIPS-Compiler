functor TigerLrValsFun(structure Token : TOKEN)
 : sig structure ParserData : PARSER_DATA
       structure Tokens : Tiger_TOKENS
   end
 = 
struct
structure ParserData=
struct
structure Header = 
struct

end
structure LrTable = Token.LrTable
structure Token = Token
local open LrTable in 
val table=let val actionRows =
"\
\\001\000\001\000\000\000\000\000\
\\001\000\001\000\190\000\005\000\190\000\006\000\190\000\007\000\190\000\
\\009\000\190\000\011\000\190\000\013\000\190\000\015\000\037\000\
\\016\000\036\000\017\000\035\000\018\000\034\000\026\000\190\000\
\\027\000\190\000\031\000\190\000\032\000\190\000\035\000\190\000\
\\036\000\190\000\038\000\190\000\039\000\190\000\043\000\190\000\
\\044\000\190\000\045\000\190\000\000\000\
\\001\000\001\000\191\000\005\000\191\000\006\000\191\000\007\000\191\000\
\\009\000\191\000\011\000\191\000\013\000\191\000\015\000\037\000\
\\016\000\036\000\017\000\035\000\018\000\034\000\026\000\191\000\
\\027\000\191\000\031\000\191\000\032\000\191\000\035\000\191\000\
\\036\000\191\000\038\000\191\000\039\000\191\000\043\000\191\000\
\\044\000\191\000\045\000\191\000\000\000\
\\001\000\001\000\192\000\005\000\192\000\006\000\192\000\007\000\192\000\
\\009\000\192\000\011\000\192\000\013\000\192\000\015\000\037\000\
\\016\000\036\000\017\000\035\000\018\000\034\000\026\000\192\000\
\\027\000\192\000\031\000\192\000\032\000\192\000\035\000\192\000\
\\036\000\192\000\038\000\192\000\039\000\192\000\043\000\192\000\
\\044\000\192\000\045\000\192\000\000\000\
\\001\000\001\000\193\000\005\000\193\000\006\000\193\000\007\000\193\000\
\\009\000\193\000\011\000\193\000\013\000\193\000\015\000\037\000\
\\016\000\036\000\017\000\035\000\018\000\034\000\026\000\193\000\
\\027\000\193\000\031\000\193\000\032\000\193\000\035\000\193\000\
\\036\000\193\000\038\000\193\000\039\000\193\000\043\000\193\000\
\\044\000\193\000\045\000\193\000\000\000\
\\001\000\001\000\194\000\005\000\194\000\006\000\194\000\007\000\194\000\
\\009\000\194\000\011\000\194\000\013\000\194\000\015\000\037\000\
\\016\000\036\000\017\000\035\000\018\000\034\000\026\000\194\000\
\\027\000\194\000\031\000\194\000\032\000\194\000\035\000\194\000\
\\036\000\194\000\038\000\194\000\039\000\194\000\043\000\194\000\
\\044\000\194\000\045\000\194\000\000\000\
\\001\000\001\000\195\000\005\000\195\000\006\000\195\000\007\000\195\000\
\\009\000\195\000\011\000\195\000\013\000\195\000\015\000\037\000\
\\016\000\036\000\017\000\035\000\018\000\034\000\026\000\195\000\
\\027\000\195\000\031\000\195\000\032\000\195\000\035\000\195\000\
\\036\000\195\000\038\000\195\000\039\000\195\000\043\000\195\000\
\\044\000\195\000\045\000\195\000\000\000\
\\001\000\002\000\022\000\003\000\021\000\004\000\020\000\008\000\019\000\
\\009\000\085\000\016\000\018\000\030\000\017\000\033\000\016\000\
\\034\000\015\000\037\000\014\000\041\000\013\000\042\000\012\000\000\000\
\\001\000\002\000\022\000\003\000\021\000\004\000\020\000\008\000\019\000\
\\016\000\018\000\030\000\017\000\033\000\016\000\034\000\015\000\
\\037\000\014\000\041\000\013\000\042\000\012\000\000\000\
\\001\000\002\000\046\000\000\000\
\\001\000\002\000\056\000\000\000\
\\001\000\002\000\072\000\000\000\
\\001\000\002\000\073\000\000\000\
\\001\000\002\000\074\000\000\000\
\\001\000\002\000\081\000\000\000\
\\001\000\002\000\105\000\012\000\104\000\029\000\103\000\000\000\
\\001\000\002\000\107\000\000\000\
\\001\000\002\000\109\000\000\000\
\\001\000\002\000\109\000\013\000\117\000\000\000\
\\001\000\002\000\125\000\000\000\
\\001\000\002\000\130\000\000\000\
\\001\000\002\000\134\000\000\000\
\\001\000\006\000\090\000\028\000\089\000\000\000\
\\001\000\006\000\120\000\000\000\
\\001\000\006\000\129\000\019\000\128\000\000\000\
\\001\000\008\000\091\000\000\000\
\\001\000\009\000\078\000\000\000\
\\001\000\009\000\099\000\000\000\
\\001\000\009\000\119\000\000\000\
\\001\000\011\000\086\000\015\000\037\000\016\000\036\000\017\000\035\000\
\\018\000\034\000\019\000\033\000\020\000\032\000\021\000\031\000\
\\022\000\030\000\023\000\029\000\024\000\028\000\026\000\027\000\
\\027\000\026\000\000\000\
\\001\000\011\000\098\000\015\000\037\000\016\000\036\000\017\000\035\000\
\\018\000\034\000\019\000\033\000\020\000\032\000\021\000\031\000\
\\022\000\030\000\023\000\029\000\024\000\028\000\026\000\027\000\
\\027\000\026\000\000\000\
\\001\000\013\000\096\000\000\000\
\\001\000\013\000\126\000\000\000\
\\001\000\015\000\037\000\016\000\036\000\017\000\035\000\018\000\034\000\
\\019\000\033\000\020\000\032\000\021\000\031\000\022\000\030\000\
\\023\000\029\000\024\000\028\000\026\000\027\000\027\000\026\000\
\\031\000\077\000\000\000\
\\001\000\015\000\037\000\016\000\036\000\017\000\035\000\018\000\034\000\
\\019\000\033\000\020\000\032\000\021\000\031\000\022\000\030\000\
\\023\000\029\000\024\000\028\000\026\000\027\000\027\000\026\000\
\\035\000\110\000\000\000\
\\001\000\015\000\037\000\016\000\036\000\017\000\035\000\018\000\034\000\
\\019\000\033\000\020\000\032\000\021\000\031\000\022\000\030\000\
\\023\000\029\000\024\000\028\000\026\000\027\000\027\000\026\000\
\\036\000\076\000\000\000\
\\001\000\015\000\037\000\016\000\036\000\017\000\035\000\018\000\034\000\
\\019\000\033\000\020\000\032\000\021\000\031\000\022\000\030\000\
\\023\000\029\000\024\000\028\000\026\000\027\000\027\000\026\000\
\\036\000\131\000\000\000\
\\001\000\019\000\088\000\000\000\
\\001\000\019\000\097\000\000\000\
\\001\000\019\000\137\000\000\000\
\\001\000\028\000\075\000\000\000\
\\001\000\028\000\118\000\000\000\
\\001\000\038\000\071\000\043\000\045\000\044\000\044\000\045\000\043\000\000\000\
\\001\000\039\000\101\000\000\000\
\\001\000\040\000\113\000\000\000\
\\001\000\040\000\115\000\000\000\
\\001\000\043\000\045\000\044\000\044\000\045\000\043\000\000\000\
\\141\000\015\000\037\000\016\000\036\000\017\000\035\000\018\000\034\000\
\\019\000\033\000\020\000\032\000\021\000\031\000\022\000\030\000\
\\023\000\029\000\024\000\028\000\026\000\027\000\027\000\026\000\000\000\
\\142\000\000\000\
\\143\000\000\000\
\\144\000\000\000\
\\145\000\010\000\025\000\014\000\024\000\028\000\023\000\000\000\
\\146\000\000\000\
\\147\000\000\000\
\\148\000\000\000\
\\149\000\000\000\
\\150\000\000\000\
\\151\000\015\000\037\000\016\000\036\000\017\000\035\000\018\000\034\000\
\\019\000\033\000\020\000\032\000\021\000\031\000\022\000\030\000\
\\023\000\029\000\024\000\028\000\026\000\027\000\027\000\026\000\000\000\
\\152\000\015\000\037\000\016\000\036\000\017\000\035\000\018\000\034\000\
\\019\000\033\000\020\000\032\000\021\000\031\000\022\000\030\000\
\\023\000\029\000\024\000\028\000\026\000\027\000\027\000\026\000\
\\032\000\111\000\000\000\
\\153\000\015\000\037\000\016\000\036\000\017\000\035\000\018\000\034\000\
\\019\000\033\000\020\000\032\000\021\000\031\000\022\000\030\000\
\\023\000\029\000\024\000\028\000\026\000\027\000\027\000\026\000\000\000\
\\154\000\015\000\037\000\016\000\036\000\017\000\035\000\018\000\034\000\
\\019\000\033\000\020\000\032\000\021\000\031\000\022\000\030\000\
\\023\000\029\000\024\000\028\000\026\000\027\000\027\000\026\000\000\000\
\\155\000\000\000\
\\156\000\000\000\
\\157\000\000\000\
\\158\000\000\000\
\\159\000\000\000\
\\160\000\000\000\
\\161\000\006\000\123\000\015\000\037\000\016\000\036\000\017\000\035\000\
\\018\000\034\000\019\000\033\000\020\000\032\000\021\000\031\000\
\\022\000\030\000\023\000\029\000\024\000\028\000\026\000\027\000\
\\027\000\026\000\000\000\
\\162\000\000\000\
\\163\000\000\000\
\\164\000\000\000\
\\165\000\005\000\100\000\015\000\037\000\016\000\036\000\017\000\035\000\
\\018\000\034\000\019\000\033\000\020\000\032\000\021\000\031\000\
\\022\000\030\000\023\000\029\000\024\000\028\000\026\000\027\000\
\\027\000\026\000\000\000\
\\166\000\000\000\
\\167\000\000\000\
\\168\000\000\000\
\\169\000\000\000\
\\170\000\007\000\079\000\015\000\037\000\016\000\036\000\017\000\035\000\
\\018\000\034\000\019\000\033\000\020\000\032\000\021\000\031\000\
\\022\000\030\000\023\000\029\000\024\000\028\000\026\000\027\000\
\\027\000\026\000\000\000\
\\171\000\000\000\
\\172\000\000\000\
\\173\000\000\000\
\\174\000\000\000\
\\175\000\000\000\
\\176\000\000\000\
\\177\000\000\000\
\\178\000\000\000\
\\179\000\005\000\135\000\000\000\
\\180\000\000\000\
\\181\000\015\000\037\000\016\000\036\000\017\000\035\000\018\000\034\000\
\\019\000\033\000\020\000\032\000\021\000\031\000\022\000\030\000\
\\023\000\029\000\024\000\028\000\026\000\027\000\027\000\026\000\000\000\
\\182\000\015\000\037\000\016\000\036\000\017\000\035\000\018\000\034\000\
\\019\000\033\000\020\000\032\000\021\000\031\000\022\000\030\000\
\\023\000\029\000\024\000\028\000\026\000\027\000\027\000\026\000\000\000\
\\183\000\015\000\037\000\016\000\036\000\017\000\035\000\018\000\034\000\
\\019\000\033\000\020\000\032\000\021\000\031\000\022\000\030\000\
\\023\000\029\000\024\000\028\000\026\000\027\000\027\000\026\000\000\000\
\\184\000\015\000\037\000\016\000\036\000\017\000\035\000\018\000\034\000\
\\019\000\033\000\020\000\032\000\021\000\031\000\022\000\030\000\
\\023\000\029\000\024\000\028\000\026\000\027\000\027\000\026\000\000\000\
\\185\000\015\000\037\000\016\000\036\000\017\000\035\000\018\000\034\000\
\\019\000\033\000\020\000\032\000\021\000\031\000\022\000\030\000\
\\023\000\029\000\024\000\028\000\026\000\027\000\027\000\026\000\000\000\
\\186\000\015\000\037\000\016\000\036\000\017\000\035\000\018\000\034\000\
\\019\000\033\000\020\000\032\000\021\000\031\000\022\000\030\000\
\\023\000\029\000\024\000\028\000\026\000\027\000\027\000\026\000\000\000\
\\187\000\008\000\054\000\010\000\053\000\012\000\052\000\000\000\
\\188\000\000\000\
\\189\000\000\000\
\\196\000\015\000\037\000\016\000\036\000\017\000\035\000\018\000\034\000\
\\019\000\033\000\020\000\032\000\021\000\031\000\022\000\030\000\
\\023\000\029\000\024\000\028\000\000\000\
\\197\000\015\000\037\000\016\000\036\000\017\000\035\000\018\000\034\000\
\\019\000\033\000\020\000\032\000\021\000\031\000\022\000\030\000\
\\023\000\029\000\024\000\028\000\026\000\027\000\000\000\
\\198\000\017\000\035\000\018\000\034\000\000\000\
\\199\000\017\000\035\000\018\000\034\000\000\000\
\\200\000\000\000\
\\201\000\000\000\
\\202\000\000\000\
\"
val actionRowNumbers =
"\008\000\054\000\065\000\053\000\
\\055\000\064\000\056\000\051\000\
\\052\000\047\000\050\000\061\000\
\\046\000\009\000\008\000\008\000\
\\008\000\008\000\049\000\048\000\
\\093\000\008\000\010\000\008\000\
\\008\000\008\000\008\000\008\000\
\\008\000\008\000\008\000\008\000\
\\008\000\008\000\008\000\008\000\
\\042\000\073\000\077\000\078\000\
\\079\000\011\000\012\000\013\000\
\\040\000\035\000\033\000\102\000\
\\026\000\076\000\014\000\008\000\
\\007\000\092\000\095\000\029\000\
\\097\000\096\000\005\000\003\000\
\\006\000\004\000\002\000\001\000\
\\101\000\100\000\099\000\098\000\
\\074\000\008\000\037\000\022\000\
\\025\000\008\000\008\000\008\000\
\\063\000\008\000\031\000\038\000\
\\030\000\027\000\071\000\069\000\
\\094\000\043\000\015\000\008\000\
\\016\000\017\000\034\000\059\000\
\\058\000\075\000\066\000\008\000\
\\044\000\070\000\008\000\062\000\
\\080\000\045\000\018\000\081\000\
\\087\000\041\000\028\000\023\000\
\\008\000\008\000\067\000\008\000\
\\072\000\019\000\032\000\083\000\
\\008\000\024\000\020\000\036\000\
\\057\000\014\000\091\000\084\000\
\\082\000\088\000\008\000\021\000\
\\085\000\008\000\068\000\089\000\
\\039\000\017\000\060\000\008\000\
\\086\000\090\000\000\000"
val gotoT =
"\
\\001\000\009\000\002\000\138\000\003\000\008\000\004\000\007\000\
\\005\000\006\000\006\000\005\000\016\000\004\000\017\000\003\000\
\\019\000\002\000\020\000\001\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\007\000\040\000\009\000\039\000\011\000\038\000\013\000\037\000\
\\014\000\036\000\000\000\
\\000\000\
\\001\000\045\000\003\000\008\000\004\000\007\000\005\000\006\000\
\\006\000\005\000\016\000\004\000\017\000\003\000\019\000\002\000\
\\020\000\001\000\000\000\
\\001\000\046\000\003\000\008\000\004\000\007\000\005\000\006\000\
\\006\000\005\000\016\000\004\000\017\000\003\000\019\000\002\000\
\\020\000\001\000\000\000\
\\001\000\047\000\003\000\008\000\004\000\007\000\005\000\006\000\
\\006\000\005\000\016\000\004\000\017\000\003\000\019\000\002\000\
\\020\000\001\000\000\000\
\\001\000\049\000\003\000\008\000\004\000\007\000\005\000\006\000\
\\006\000\005\000\012\000\048\000\016\000\004\000\017\000\003\000\
\\019\000\002\000\020\000\001\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\001\000\053\000\003\000\008\000\004\000\007\000\005\000\006\000\
\\006\000\005\000\016\000\004\000\017\000\003\000\019\000\002\000\
\\020\000\001\000\000\000\
\\000\000\
\\001\000\055\000\003\000\008\000\004\000\007\000\005\000\006\000\
\\006\000\005\000\016\000\004\000\017\000\003\000\019\000\002\000\
\\020\000\001\000\000\000\
\\001\000\056\000\003\000\008\000\004\000\007\000\005\000\006\000\
\\006\000\005\000\016\000\004\000\017\000\003\000\019\000\002\000\
\\020\000\001\000\000\000\
\\001\000\057\000\003\000\008\000\004\000\007\000\005\000\006\000\
\\006\000\005\000\016\000\004\000\017\000\003\000\019\000\002\000\
\\020\000\001\000\000\000\
\\001\000\058\000\003\000\008\000\004\000\007\000\005\000\006\000\
\\006\000\005\000\016\000\004\000\017\000\003\000\019\000\002\000\
\\020\000\001\000\000\000\
\\001\000\059\000\003\000\008\000\004\000\007\000\005\000\006\000\
\\006\000\005\000\016\000\004\000\017\000\003\000\019\000\002\000\
\\020\000\001\000\000\000\
\\001\000\060\000\003\000\008\000\004\000\007\000\005\000\006\000\
\\006\000\005\000\016\000\004\000\017\000\003\000\019\000\002\000\
\\020\000\001\000\000\000\
\\001\000\061\000\003\000\008\000\004\000\007\000\005\000\006\000\
\\006\000\005\000\016\000\004\000\017\000\003\000\019\000\002\000\
\\020\000\001\000\000\000\
\\001\000\062\000\003\000\008\000\004\000\007\000\005\000\006\000\
\\006\000\005\000\016\000\004\000\017\000\003\000\019\000\002\000\
\\020\000\001\000\000\000\
\\001\000\063\000\003\000\008\000\004\000\007\000\005\000\006\000\
\\006\000\005\000\016\000\004\000\017\000\003\000\019\000\002\000\
\\020\000\001\000\000\000\
\\001\000\064\000\003\000\008\000\004\000\007\000\005\000\006\000\
\\006\000\005\000\016\000\004\000\017\000\003\000\019\000\002\000\
\\020\000\001\000\000\000\
\\001\000\065\000\003\000\008\000\004\000\007\000\005\000\006\000\
\\006\000\005\000\016\000\004\000\017\000\003\000\019\000\002\000\
\\020\000\001\000\000\000\
\\001\000\066\000\003\000\008\000\004\000\007\000\005\000\006\000\
\\006\000\005\000\016\000\004\000\017\000\003\000\019\000\002\000\
\\020\000\001\000\000\000\
\\001\000\067\000\003\000\008\000\004\000\007\000\005\000\006\000\
\\006\000\005\000\016\000\004\000\017\000\003\000\019\000\002\000\
\\020\000\001\000\000\000\
\\007\000\040\000\009\000\039\000\011\000\038\000\013\000\068\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\018\000\078\000\000\000\
\\001\000\080\000\003\000\008\000\004\000\007\000\005\000\006\000\
\\006\000\005\000\016\000\004\000\017\000\003\000\019\000\002\000\
\\020\000\001\000\000\000\
\\001\000\082\000\003\000\008\000\004\000\007\000\005\000\006\000\
\\006\000\005\000\015\000\081\000\016\000\004\000\017\000\003\000\
\\019\000\002\000\020\000\001\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\001\000\049\000\003\000\008\000\004\000\007\000\005\000\006\000\
\\006\000\005\000\012\000\085\000\016\000\004\000\017\000\003\000\
\\019\000\002\000\020\000\001\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\001\000\090\000\003\000\008\000\004\000\007\000\005\000\006\000\
\\006\000\005\000\016\000\004\000\017\000\003\000\019\000\002\000\
\\020\000\001\000\000\000\
\\001\000\091\000\003\000\008\000\004\000\007\000\005\000\006\000\
\\006\000\005\000\016\000\004\000\017\000\003\000\019\000\002\000\
\\020\000\001\000\000\000\
\\001\000\092\000\003\000\008\000\004\000\007\000\005\000\006\000\
\\006\000\005\000\016\000\004\000\017\000\003\000\019\000\002\000\
\\020\000\001\000\000\000\
\\000\000\
\\001\000\049\000\003\000\008\000\004\000\007\000\005\000\006\000\
\\006\000\005\000\012\000\093\000\016\000\004\000\017\000\003\000\
\\019\000\002\000\020\000\001\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\010\000\100\000\000\000\
\\001\000\104\000\003\000\008\000\004\000\007\000\005\000\006\000\
\\006\000\005\000\016\000\004\000\017\000\003\000\019\000\002\000\
\\020\000\001\000\000\000\
\\000\000\
\\008\000\106\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\001\000\110\000\003\000\008\000\004\000\007\000\005\000\006\000\
\\006\000\005\000\016\000\004\000\017\000\003\000\019\000\002\000\
\\020\000\001\000\000\000\
\\000\000\
\\000\000\
\\001\000\082\000\003\000\008\000\004\000\007\000\005\000\006\000\
\\006\000\005\000\015\000\112\000\016\000\004\000\017\000\003\000\
\\019\000\002\000\020\000\001\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\008\000\114\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\001\000\119\000\003\000\008\000\004\000\007\000\005\000\006\000\
\\006\000\005\000\016\000\004\000\017\000\003\000\019\000\002\000\
\\020\000\001\000\000\000\
\\001\000\120\000\003\000\008\000\004\000\007\000\005\000\006\000\
\\006\000\005\000\016\000\004\000\017\000\003\000\019\000\002\000\
\\020\000\001\000\000\000\
\\000\000\
\\001\000\122\000\003\000\008\000\004\000\007\000\005\000\006\000\
\\006\000\005\000\016\000\004\000\017\000\003\000\019\000\002\000\
\\020\000\001\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\001\000\125\000\003\000\008\000\004\000\007\000\005\000\006\000\
\\006\000\005\000\016\000\004\000\017\000\003\000\019\000\002\000\
\\020\000\001\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\018\000\130\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\001\000\131\000\003\000\008\000\004\000\007\000\005\000\006\000\
\\006\000\005\000\016\000\004\000\017\000\003\000\019\000\002\000\
\\020\000\001\000\000\000\
\\000\000\
\\000\000\
\\001\000\134\000\003\000\008\000\004\000\007\000\005\000\006\000\
\\006\000\005\000\016\000\004\000\017\000\003\000\019\000\002\000\
\\020\000\001\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\008\000\136\000\000\000\
\\000\000\
\\001\000\137\000\003\000\008\000\004\000\007\000\005\000\006\000\
\\006\000\005\000\016\000\004\000\017\000\003\000\019\000\002\000\
\\020\000\001\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\"
val numstates = 139
val numrules = 62
val s = ref "" and index = ref 0
val string_to_int = fn () => 
let val i = !index
in index := i+2; Char.ord(String.sub(!s,i)) + Char.ord(String.sub(!s,i+1)) * 256
end
val string_to_list = fn s' =>
    let val len = String.size s'
        fun f () =
           if !index < len then string_to_int() :: f()
           else nil
   in index := 0; s := s'; f ()
   end
val string_to_pairlist = fn (conv_key,conv_entry) =>
     let fun f () =
         case string_to_int()
         of 0 => EMPTY
          | n => PAIR(conv_key (n-1),conv_entry (string_to_int()),f())
     in f
     end
val string_to_pairlist_default = fn (conv_key,conv_entry) =>
    let val conv_row = string_to_pairlist(conv_key,conv_entry)
    in fn () =>
       let val default = conv_entry(string_to_int())
           val row = conv_row()
       in (row,default)
       end
   end
val string_to_table = fn (convert_row,s') =>
    let val len = String.size s'
        fun f ()=
           if !index < len then convert_row() :: f()
           else nil
     in (s := s'; index := 0; f ())
     end
local
  val memo = Array.array(numstates+numrules,ERROR)
  val _ =let fun g i=(Array.update(memo,i,REDUCE(i-numstates)); g(i+1))
       fun f i =
            if i=numstates then g i
            else (Array.update(memo,i,SHIFT (STATE i)); f (i+1))
          in f 0 handle General.Subscript => ()
          end
in
val entry_to_action = fn 0 => ACCEPT | 1 => ERROR | j => Array.sub(memo,(j-2))
end
val gotoT=Array.fromList(string_to_table(string_to_pairlist(NT,STATE),gotoT))
val actionRows=string_to_table(string_to_pairlist_default(T,entry_to_action),actionRows)
val actionRowNumbers = string_to_list actionRowNumbers
val actionT = let val actionRowLookUp=
let val a=Array.fromList(actionRows) in fn i=>Array.sub(a,i) end
in Array.fromList(List.map actionRowLookUp actionRowNumbers)
end
in LrTable.mkLrTable {actions=actionT,gotos=gotoT,numRules=numrules,
numStates=numstates,initialState=STATE 0}
end
end
local open Header in
type pos = int
type arg = unit
structure MlyValue = 
struct
datatype svalue = VOID | ntVOID of unit ->  unit
 | STRING of unit ->  (string) | INT of unit ->  (int)
 | ID of unit ->  (string)
end
type svalue = MlyValue.svalue
type result = unit
end
structure EC=
struct
open LrTable
infix 5 $$
fun x $$ y = y::x
val is_keyword =
fn (T 32) => true | (T 33) => true | (T 34) => true | (T 40) => true
 | (T 36) => true | (T 37) => true | (T 38) => true | (T 42) => true
 | (T 43) => true | (T 44) => true | (T 28) => true | (T 29) => true
 | (T 30) => true | (T 31) => true | (T 35) => true | (T 39) => true
 | (T 41) => true | _ => false
val preferred_change : (term list * term list) list = 
(nil
,nil
 $$ (T 30))::
(nil
,nil
 $$ (T 31))::
(nil
,nil
 $$ (T 7))::
nil
val noShift = 
fn (T 0) => true | _ => false
val showTerminal =
fn (T 0) => "EOF"
  | (T 1) => "ID"
  | (T 2) => "INT"
  | (T 3) => "STRING"
  | (T 4) => "COMMA"
  | (T 5) => "COLON"
  | (T 6) => "SEMICOLON"
  | (T 7) => "LPAREN"
  | (T 8) => "RPAREN"
  | (T 9) => "LBRACK"
  | (T 10) => "RBRACK"
  | (T 11) => "LBRACE"
  | (T 12) => "RBRACE"
  | (T 13) => "DOT"
  | (T 14) => "PLUS"
  | (T 15) => "MINUS"
  | (T 16) => "TIMES"
  | (T 17) => "DIVIDE"
  | (T 18) => "EQ"
  | (T 19) => "NEQ"
  | (T 20) => "LT"
  | (T 21) => "LE"
  | (T 22) => "GT"
  | (T 23) => "GE"
  | (T 24) => "UMINUS"
  | (T 25) => "AND"
  | (T 26) => "OR"
  | (T 27) => "ASSIGN"
  | (T 28) => "ARRAY"
  | (T 29) => "IF"
  | (T 30) => "THEN"
  | (T 31) => "ELSE"
  | (T 32) => "WHILE"
  | (T 33) => "FOR"
  | (T 34) => "TO"
  | (T 35) => "DO"
  | (T 36) => "LET"
  | (T 37) => "IN"
  | (T 38) => "END"
  | (T 39) => "OF"
  | (T 40) => "BREAK"
  | (T 41) => "NIL"
  | (T 42) => "FUNCTION"
  | (T 43) => "VAR"
  | (T 44) => "TYPE"
  | _ => "bogus-term"
local open Header in
val errtermvalue=
fn (T 1) => MlyValue.ID(fn () => ("bogus")) | 
(T 2) => MlyValue.INT(fn () => (1)) | 
(T 3) => MlyValue.STRING(fn () => ("")) | 
_ => MlyValue.VOID
end
val terms : term list = nil
 $$ (T 44) $$ (T 43) $$ (T 42) $$ (T 41) $$ (T 40) $$ (T 39) $$ (T 38)
 $$ (T 37) $$ (T 36) $$ (T 35) $$ (T 34) $$ (T 33) $$ (T 32) $$ (T 31)
 $$ (T 30) $$ (T 29) $$ (T 28) $$ (T 27) $$ (T 26) $$ (T 25) $$ (T 24)
 $$ (T 23) $$ (T 22) $$ (T 21) $$ (T 20) $$ (T 19) $$ (T 18) $$ (T 17)
 $$ (T 16) $$ (T 15) $$ (T 14) $$ (T 13) $$ (T 12) $$ (T 11) $$ (T 10)
 $$ (T 9) $$ (T 8) $$ (T 7) $$ (T 6) $$ (T 5) $$ (T 4) $$ (T 0)end
structure Actions =
struct 
exception mlyAction of int
local open Header in
val actions = 
fn (i392,defaultPos,stack,
    (()):arg) =>
case (i392,stack)
of  ( 0, ( ( _, ( MlyValue.ntVOID exp1, exp1left, exp1right)) :: 
rest671)) => let val  result = MlyValue.ntVOID (fn _ => ( let val  (
exp as exp1) = exp1 ()
 in (print "R0 program : exp\n")
end; ()))
 in ( LrTable.NT 1, ( result, exp1left, exp1right), rest671)
end
|  ( 1, ( ( _, ( MlyValue.INT INT1, INT1left, INT1right)) :: rest671))
 => let val  result = MlyValue.ntVOID (fn _ => ( let val  (INT as INT1
) = INT1 ()
 in (print "R1 exp : INT\n")
end; ()))
 in ( LrTable.NT 0, ( result, INT1left, INT1right), rest671)
end
|  ( 2, ( ( _, ( MlyValue.STRING STRING1, STRING1left, STRING1right))
 :: rest671)) => let val  result = MlyValue.ntVOID (fn _ => ( let val 
 (STRING as STRING1) = STRING1 ()
 in (print "R2 exp : STRING\n")
end; ()))
 in ( LrTable.NT 0, ( result, STRING1left, STRING1right), rest671)
end
|  ( 3, ( ( _, ( _, NIL1left, NIL1right)) :: rest671)) => let val  
result = MlyValue.ntVOID (fn _ => (print "R3 exp : NIL\n"))
 in ( LrTable.NT 0, ( result, NIL1left, NIL1right), rest671)
end
|  ( 4, ( ( _, ( MlyValue.ntVOID lvalue1, lvalue1left, lvalue1right))
 :: rest671)) => let val  result = MlyValue.ntVOID (fn _ => ( let val 
 (lvalue as lvalue1) = lvalue1 ()
 in (print "R4 exp : lvalue\n")
end; ()))
 in ( LrTable.NT 0, ( result, lvalue1left, lvalue1right), rest671)
end
|  ( 5, ( ( _, ( MlyValue.ntVOID arithmeticExp1, arithmeticExp1left, 
arithmeticExp1right)) :: rest671)) => let val  result = 
MlyValue.ntVOID (fn _ => ( let val  (arithmeticExp as arithmeticExp1)
 = arithmeticExp1 ()
 in (print "R5 exp : arithmeticExp\n")
end; ()))
 in ( LrTable.NT 0, ( result, arithmeticExp1left, arithmeticExp1right)
, rest671)
end
|  ( 6, ( ( _, ( MlyValue.ntVOID booleanExp1, booleanExp1left, 
booleanExp1right)) :: rest671)) => let val  result = MlyValue.ntVOID
 (fn _ => ( let val  (booleanExp as booleanExp1) = booleanExp1 ()
 in (print "R6 exp : booleanExp\n")
end; ()))
 in ( LrTable.NT 0, ( result, booleanExp1left, booleanExp1right), 
rest671)
end
|  ( 7, ( ( _, ( MlyValue.ntVOID comparison1, comparison1left, 
comparison1right)) :: rest671)) => let val  result = MlyValue.ntVOID
 (fn _ => ( let val  (comparison as comparison1) = comparison1 ()
 in (print "R7 exp : comparison\n")
end; ()))
 in ( LrTable.NT 0, ( result, comparison1left, comparison1right), 
rest671)
end
|  ( 8, ( ( _, ( MlyValue.ntVOID functionCall1, functionCall1left, 
functionCall1right)) :: rest671)) => let val  result = MlyValue.ntVOID
 (fn _ => ( let val  (functionCall as functionCall1) = functionCall1
 ()
 in (print "R8 exp : functionCall\n")
end; ()))
 in ( LrTable.NT 0, ( result, functionCall1left, functionCall1right), 
rest671)
end
|  ( 9, ( ( _, ( MlyValue.ntVOID assignment1, assignment1left, 
assignment1right)) :: rest671)) => let val  result = MlyValue.ntVOID
 (fn _ => ( let val  (assignment as assignment1) = assignment1 ()
 in (print "R9 exp : assignment\n")
end; ()))
 in ( LrTable.NT 0, ( result, assignment1left, assignment1right), 
rest671)
end
|  ( 10, ( ( _, ( MlyValue.ntVOID exp3, _, exp3right)) :: _ :: ( _, ( 
MlyValue.ntVOID exp2, _, _)) :: _ :: ( _, ( MlyValue.ntVOID exp1, _, _
)) :: ( _, ( _, IF1left, _)) :: rest671)) => let val  result = 
MlyValue.ntVOID (fn _ => ( let val  (exp as exp1) = exp1 ()
 val  exp2 = exp2 ()
 val  exp3 = exp3 ()
 in (print "R10 exp : IF exp THEN exp ELSE exp\n")
end; ()))
 in ( LrTable.NT 0, ( result, IF1left, exp3right), rest671)
end
|  ( 11, ( ( _, ( MlyValue.ntVOID exp2, _, exp2right)) :: _ :: ( _, ( 
MlyValue.ntVOID exp1, _, _)) :: ( _, ( _, IF1left, _)) :: rest671)) =>
 let val  result = MlyValue.ntVOID (fn _ => ( let val  (exp as exp1) =
 exp1 ()
 val  exp2 = exp2 ()
 in (print "R11 exp : IF exp THEN exp\n")
end; ()))
 in ( LrTable.NT 0, ( result, IF1left, exp2right), rest671)
end
|  ( 12, ( ( _, ( MlyValue.ntVOID exp2, _, exp2right)) :: _ :: ( _, ( 
MlyValue.ntVOID exp1, _, _)) :: ( _, ( _, WHILE1left, _)) :: rest671))
 => let val  result = MlyValue.ntVOID (fn _ => ( let val  (exp as exp1
) = exp1 ()
 val  exp2 = exp2 ()
 in (print "R12 exp : WHILE exp DO exp\n")
end; ()))
 in ( LrTable.NT 0, ( result, WHILE1left, exp2right), rest671)
end
|  ( 13, ( ( _, ( MlyValue.ntVOID exp3, _, exp3right)) :: _ :: ( _, ( 
MlyValue.ntVOID exp2, _, _)) :: _ :: ( _, ( MlyValue.ntVOID exp1, _, _
)) :: _ :: ( _, ( MlyValue.ID ID1, _, _)) :: ( _, ( _, FOR1left, _))
 :: rest671)) => let val  result = MlyValue.ntVOID (fn _ => ( let val 
 (ID as ID1) = ID1 ()
 val  (exp as exp1) = exp1 ()
 val  exp2 = exp2 ()
 val  exp3 = exp3 ()
 in (print "R13 exp : FOR ID ASSIGN exp TO exp DO exp\n")
end; ()))
 in ( LrTable.NT 0, ( result, FOR1left, exp3right), rest671)
end
|  ( 14, ( ( _, ( _, BREAK1left, BREAK1right)) :: rest671)) => let
 val  result = MlyValue.ntVOID (fn _ => (print "R14 exp : BREAK\n"))
 in ( LrTable.NT 0, ( result, BREAK1left, BREAK1right), rest671)
end
|  ( 15, ( ( _, ( _, _, END1right)) :: ( _, ( MlyValue.ntVOID expseq1,
 _, _)) :: _ :: ( _, ( MlyValue.ntVOID decs1, _, _)) :: ( _, ( _, 
LET1left, _)) :: rest671)) => let val  result = MlyValue.ntVOID (fn _
 => ( let val  (decs as decs1) = decs1 ()
 val  (expseq as expseq1) = expseq1 ()
 in (print "R15 exp : LET decs IN expseq END\n")
end; ()))
 in ( LrTable.NT 0, ( result, LET1left, END1right), rest671)
end
|  ( 16, ( ( _, ( _, _, RPAREN1right)) :: ( _, ( MlyValue.ntVOID 
expseq1, _, _)) :: ( _, ( _, LPAREN1left, _)) :: rest671)) => let val 
 result = MlyValue.ntVOID (fn _ => ( let val  (expseq as expseq1) = 
expseq1 ()
 in (print "R16 exp : LPAREN expseq RPAREN\n")
end; ()))
 in ( LrTable.NT 0, ( result, LPAREN1left, RPAREN1right), rest671)
end
|  ( 17, ( ( _, ( MlyValue.ntVOID array1, array1left, array1right)) ::
 rest671)) => let val  result = MlyValue.ntVOID (fn _ => ( let val  (
array as array1) = array1 ()
 in (print "R17 exp : array\n")
end; ()))
 in ( LrTable.NT 0, ( result, array1left, array1right), rest671)
end
|  ( 18, ( ( _, ( MlyValue.ntVOID record1, record1left, record1right))
 :: rest671)) => let val  result = MlyValue.ntVOID (fn _ => ( let val 
 (record as record1) = record1 ()
 in (print "R18 exp : record\n")
end; ()))
 in ( LrTable.NT 0, ( result, record1left, record1right), rest671)
end
|  ( 19, ( ( _, ( _, _, RBRACE1right)) :: ( _, ( MlyValue.ntVOID 
recflds1, _, _)) :: _ :: ( _, ( MlyValue.ID ID1, ID1left, _)) :: 
rest671)) => let val  result = MlyValue.ntVOID (fn _ => ( let val  (ID
 as ID1) = ID1 ()
 val  (recflds as recflds1) = recflds1 ()
 in (print "R19 record: ID LBRACE recflds RBRACE\n")
end; ()))
 in ( LrTable.NT 18, ( result, ID1left, RBRACE1right), rest671)
end
|  ( 20, ( ( _, ( MlyValue.ntVOID exp1, _, exp1right)) :: _ :: ( _, ( 
MlyValue.ID ID1, ID1left, _)) :: rest671)) => let val  result = 
MlyValue.ntVOID (fn _ => ( let val  (ID as ID1) = ID1 ()
 val  (exp as exp1) = exp1 ()
 in (print "R20 recflds: ID EQ exp\n")
end; ()))
 in ( LrTable.NT 17, ( result, ID1left, exp1right), rest671)
end
|  ( 21, ( ( _, ( MlyValue.ntVOID recflds1, _, recflds1right)) :: _ ::
 ( _, ( MlyValue.ntVOID exp1, _, _)) :: _ :: ( _, ( MlyValue.ID ID1, 
ID1left, _)) :: rest671)) => let val  result = MlyValue.ntVOID (fn _
 => ( let val  (ID as ID1) = ID1 ()
 val  (exp as exp1) = exp1 ()
 val  (recflds as recflds1) = recflds1 ()
 in (print "R21 recflds: ID EQ exp COLON recflds\n")
end; ()))
 in ( LrTable.NT 17, ( result, ID1left, recflds1right), rest671)
end
|  ( 22, ( ( _, ( _, _, RPAREN1right)) :: _ :: ( _, ( MlyValue.ID ID1,
 ID1left, _)) :: rest671)) => let val  result = MlyValue.ntVOID (fn _
 => ( let val  (ID as ID1) = ID1 ()
 in (print "R22 functionCall: ID LPAREN RPAREN\n")
end; ()))
 in ( LrTable.NT 15, ( result, ID1left, RPAREN1right), rest671)
end
|  ( 23, ( ( _, ( _, _, RPAREN1right)) :: ( _, ( MlyValue.ntVOID 
funargs1, _, _)) :: _ :: ( _, ( MlyValue.ID ID1, ID1left, _)) :: 
rest671)) => let val  result = MlyValue.ntVOID (fn _ => ( let val  (ID
 as ID1) = ID1 ()
 val  (funargs as funargs1) = funargs1 ()
 in (print "R23 functionCall: ID LPAREN funargs RPAREN\n")
end; ()))
 in ( LrTable.NT 15, ( result, ID1left, RPAREN1right), rest671)
end
|  ( 24, ( ( _, ( MlyValue.ntVOID exp1, exp1left, exp1right)) :: 
rest671)) => let val  result = MlyValue.ntVOID (fn _ => ( let val  (
exp as exp1) = exp1 ()
 in (print "R24 funargs: exp\n")
end; ()))
 in ( LrTable.NT 14, ( result, exp1left, exp1right), rest671)
end
|  ( 25, ( ( _, ( MlyValue.ntVOID funargs1, _, funargs1right)) :: _ ::
 ( _, ( MlyValue.ntVOID exp1, exp1left, _)) :: rest671)) => let val  
result = MlyValue.ntVOID (fn _ => ( let val  (exp as exp1) = exp1 ()
 val  (funargs as funargs1) = funargs1 ()
 in (print "R25 funargs: exp COMMA funargs\n")
end; ()))
 in ( LrTable.NT 14, ( result, exp1left, funargs1right), rest671)
end
|  ( 26, ( ( _, ( MlyValue.ntVOID dec1, dec1left, dec1right)) :: 
rest671)) => let val  result = MlyValue.ntVOID (fn _ => ( let val  (
dec as dec1) = dec1 ()
 in (print "R26 decs: dec\n")
end; ()))
 in ( LrTable.NT 13, ( result, dec1left, dec1right), rest671)
end
|  ( 27, ( ( _, ( MlyValue.ntVOID dec1, _, dec1right)) :: ( _, ( 
MlyValue.ntVOID decs1, decs1left, _)) :: rest671)) => let val  result
 = MlyValue.ntVOID (fn _ => ( let val  (decs as decs1) = decs1 ()
 val  (dec as dec1) = dec1 ()
 in (print "R27 decs: decs dec\n")
end; ()))
 in ( LrTable.NT 13, ( result, decs1left, dec1right), rest671)
end
|  ( 28, ( ( _, ( MlyValue.ntVOID expseq1, _, expseq1right)) :: _ :: (
 _, ( MlyValue.ntVOID exp1, exp1left, _)) :: rest671)) => let val  
result = MlyValue.ntVOID (fn _ => ( let val  (exp as exp1) = exp1 ()
 val  (expseq as expseq1) = expseq1 ()
 in (print "R28 expseq: exp SEMICOLON expseq\n")
end; ()))
 in ( LrTable.NT 11, ( result, exp1left, expseq1right), rest671)
end
|  ( 29, ( ( _, ( MlyValue.ntVOID exp1, exp1left, exp1right)) :: 
rest671)) => let val  result = MlyValue.ntVOID (fn _ => ( let val  (
exp as exp1) = exp1 ()
 in (print "R29 expseq: exp\n")
end; ()))
 in ( LrTable.NT 11, ( result, exp1left, exp1right), rest671)
end
|  ( 30, ( ( _, ( MlyValue.ntVOID tydec1, tydec1left, tydec1right)) ::
 rest671)) => let val  result = MlyValue.ntVOID (fn _ => ( let val  (
tydec as tydec1) = tydec1 ()
 in (print "R30 dec: tydec\n")
end; ()))
 in ( LrTable.NT 12, ( result, tydec1left, tydec1right), rest671)
end
|  ( 31, ( ( _, ( MlyValue.ntVOID vardec1, vardec1left, vardec1right))
 :: rest671)) => let val  result = MlyValue.ntVOID (fn _ => ( let val 
 (vardec as vardec1) = vardec1 ()
 in (print "R31 dec: vardec\n")
end; ()))
 in ( LrTable.NT 12, ( result, vardec1left, vardec1right), rest671)

end
|  ( 32, ( ( _, ( MlyValue.ntVOID fundec1, fundec1left, fundec1right))
 :: rest671)) => let val  result = MlyValue.ntVOID (fn _ => ( let val 
 (fundec as fundec1) = fundec1 ()
 in (print "R32 dec: fundec\n")
end; ()))
 in ( LrTable.NT 12, ( result, fundec1left, fundec1right), rest671)

end
|  ( 33, ( ( _, ( MlyValue.ntVOID ty1, _, ty1right)) :: _ :: ( _, ( 
MlyValue.ID ID1, _, _)) :: ( _, ( _, TYPE1left, _)) :: rest671)) =>
 let val  result = MlyValue.ntVOID (fn _ => ( let val  (ID as ID1) = 
ID1 ()
 val  (ty as ty1) = ty1 ()
 in (print "R33 tydec: TYPE ID EQ ty\n")
end; ()))
 in ( LrTable.NT 10, ( result, TYPE1left, ty1right), rest671)
end
|  ( 34, ( ( _, ( MlyValue.ID ID1, ID1left, ID1right)) :: rest671)) =>
 let val  result = MlyValue.ntVOID (fn _ => ( let val  (ID as ID1) = 
ID1 ()
 in (print "R34 ty: ID\n")
end; ()))
 in ( LrTable.NT 9, ( result, ID1left, ID1right), rest671)
end
|  ( 35, ( ( _, ( _, _, RBRACE1right)) :: ( _, ( MlyValue.ntVOID 
tyfields1, _, _)) :: ( _, ( _, LBRACE1left, _)) :: rest671)) => let
 val  result = MlyValue.ntVOID (fn _ => ( let val  (tyfields as 
tyfields1) = tyfields1 ()
 in (print "R35 ty: LBRACE tyfields RBRACE\n")
end; ()))
 in ( LrTable.NT 9, ( result, LBRACE1left, RBRACE1right), rest671)
end
|  ( 36, ( ( _, ( _, _, RBRACE1right)) :: ( _, ( _, LBRACE1left, _))
 :: rest671)) => let val  result = MlyValue.ntVOID (fn _ => (
print "R36 ty: LBRACE RBRACE\n"))
 in ( LrTable.NT 9, ( result, LBRACE1left, RBRACE1right), rest671)
end
|  ( 37, ( ( _, ( MlyValue.ID ID1, _, ID1right)) :: _ :: ( _, ( _, 
ARRAY1left, _)) :: rest671)) => let val  result = MlyValue.ntVOID (fn
 _ => ( let val  (ID as ID1) = ID1 ()
 in (print "R37 ty: ARRAY OF ID\n")
end; ()))
 in ( LrTable.NT 9, ( result, ARRAY1left, ID1right), rest671)
end
|  ( 38, ( ( _, ( MlyValue.ID ID2, _, ID2right)) :: _ :: ( _, ( 
MlyValue.ID ID1, ID1left, _)) :: rest671)) => let val  result = 
MlyValue.ntVOID (fn _ => ( let val  (ID as ID1) = ID1 ()
 val  ID2 = ID2 ()
 in (print "R38 tyfields: ID COLON ID\n")
end; ()))
 in ( LrTable.NT 7, ( result, ID1left, ID2right), rest671)
end
|  ( 39, ( ( _, ( MlyValue.ntVOID tyfields1, _, tyfields1right)) :: _
 :: ( _, ( MlyValue.ID ID2, _, _)) :: _ :: ( _, ( MlyValue.ID ID1, 
ID1left, _)) :: rest671)) => let val  result = MlyValue.ntVOID (fn _
 => ( let val  (ID as ID1) = ID1 ()
 val  ID2 = ID2 ()
 val  (tyfields as tyfields1) = tyfields1 ()
 in (print "R39 tyfields: ID COLON ID COMMA tyfields\n")
end; ()))
 in ( LrTable.NT 7, ( result, ID1left, tyfields1right), rest671)
end
|  ( 40, ( ( _, ( MlyValue.ntVOID exp1, _, exp1right)) :: _ :: ( _, ( 
MlyValue.ID ID1, _, _)) :: ( _, ( _, VAR1left, _)) :: rest671)) => let
 val  result = MlyValue.ntVOID (fn _ => ( let val  (ID as ID1) = ID1
 ()
 val  (exp as exp1) = exp1 ()
 in (print "R40 vardec: VAR ID ASSIGN exp\n")
end; ()))
 in ( LrTable.NT 8, ( result, VAR1left, exp1right), rest671)
end
|  ( 41, ( ( _, ( MlyValue.ntVOID exp1, _, exp1right)) :: _ :: ( _, ( 
MlyValue.ID ID2, _, _)) :: _ :: ( _, ( MlyValue.ID ID1, _, _)) :: ( _,
 ( _, VAR1left, _)) :: rest671)) => let val  result = MlyValue.ntVOID
 (fn _ => ( let val  (ID as ID1) = ID1 ()
 val  ID2 = ID2 ()
 val  (exp as exp1) = exp1 ()
 in (print "R41 vardec: VAR ID COLON ID ASSIGN exp\n")
end; ()))
 in ( LrTable.NT 8, ( result, VAR1left, exp1right), rest671)
end
|  ( 42, ( ( _, ( MlyValue.ntVOID exp1, _, exp1right)) :: _ :: _ :: (
 _, ( MlyValue.ntVOID tyfields1, _, _)) :: _ :: ( _, ( MlyValue.ID ID1
, _, _)) :: ( _, ( _, FUNCTION1left, _)) :: rest671)) => let val  
result = MlyValue.ntVOID (fn _ => ( let val  (ID as ID1) = ID1 ()
 val  (tyfields as tyfields1) = tyfields1 ()
 val  (exp as exp1) = exp1 ()
 in (print "R42 fundec: FUNCTION ID LPAREN tyfields RPAREN EQ exp\n")

end; ()))
 in ( LrTable.NT 6, ( result, FUNCTION1left, exp1right), rest671)
end
|  ( 43, ( ( _, ( MlyValue.ntVOID exp1, _, exp1right)) :: _ :: ( _, ( 
MlyValue.ID ID2, _, _)) :: _ :: _ :: ( _, ( MlyValue.ntVOID tyfields1,
 _, _)) :: _ :: ( _, ( MlyValue.ID ID1, _, _)) :: ( _, ( _, 
FUNCTION1left, _)) :: rest671)) => let val  result = MlyValue.ntVOID
 (fn _ => ( let val  (ID as ID1) = ID1 ()
 val  (tyfields as tyfields1) = tyfields1 ()
 val  ID2 = ID2 ()
 val  (exp as exp1) = exp1 ()
 in (
print "R43 fundec: FUNCTION ID LPAREN tyfields RPAREN COLON ID EQ exp\n"
)
end; ()))
 in ( LrTable.NT 6, ( result, FUNCTION1left, exp1right), rest671)
end
|  ( 44, ( ( _, ( MlyValue.ntVOID exp2, _, exp2right)) :: _ :: _ :: (
 _, ( MlyValue.ntVOID exp1, _, _)) :: _ :: ( _, ( MlyValue.ID ID1, 
ID1left, _)) :: rest671)) => let val  result = MlyValue.ntVOID (fn _
 => ( let val  (ID as ID1) = ID1 ()
 val  (exp as exp1) = exp1 ()
 val  exp2 = exp2 ()
 in (print "R44 array: ID LBRACK exp RBRACK OF exp\n")
end; ()))
 in ( LrTable.NT 5, ( result, ID1left, exp2right), rest671)
end
|  ( 45, ( ( _, ( MlyValue.ntVOID exp1, _, exp1right)) :: _ :: ( _, ( 
MlyValue.ntVOID lvalue1, lvalue1left, _)) :: rest671)) => let val  
result = MlyValue.ntVOID (fn _ => ( let val  (lvalue as lvalue1) = 
lvalue1 ()
 val  (exp as exp1) = exp1 ()
 in (print "R45 assignment: lvalue ASSIGN exp\n")
end; ()))
 in ( LrTable.NT 4, ( result, lvalue1left, exp1right), rest671)
end
|  ( 46, ( ( _, ( MlyValue.ID ID1, ID1left, ID1right)) :: rest671)) =>
 let val  result = MlyValue.ntVOID (fn _ => ( let val  (ID as ID1) = 
ID1 ()
 in (print "R46 lvalue: ID\n")
end; ()))
 in ( LrTable.NT 3, ( result, ID1left, ID1right), rest671)
end
|  ( 47, ( ( _, ( _, _, RBRACK1right)) :: ( _, ( MlyValue.ntVOID exp1,
 _, _)) :: _ :: ( _, ( MlyValue.ntVOID lvalue1, lvalue1left, _)) :: 
rest671)) => let val  result = MlyValue.ntVOID (fn _ => ( let val  (
lvalue as lvalue1) = lvalue1 ()
 val  (exp as exp1) = exp1 ()
 in (print "R47 lvalue: lvalue LBRACK exp RBRACK\n")
end; ()))
 in ( LrTable.NT 3, ( result, lvalue1left, RBRACK1right), rest671)
end
|  ( 48, ( ( _, ( MlyValue.ID ID1, _, ID1right)) :: _ :: ( _, ( 
MlyValue.ntVOID lvalue1, lvalue1left, _)) :: rest671)) => let val  
result = MlyValue.ntVOID (fn _ => ( let val  (lvalue as lvalue1) = 
lvalue1 ()
 val  (ID as ID1) = ID1 ()
 in (print "R48 lvalue: lvalue DOT ID\n")
end; ()))
 in ( LrTable.NT 3, ( result, lvalue1left, ID1right), rest671)
end
|  ( 49, ( ( _, ( MlyValue.ntVOID exp2, _, exp2right)) :: _ :: ( _, ( 
MlyValue.ntVOID exp1, exp1left, _)) :: rest671)) => let val  result = 
MlyValue.ntVOID (fn _ => ( let val  (exp as exp1) = exp1 ()
 val  exp2 = exp2 ()
 in (print "R49 comparison: exp EQ exp\n")
end; ()))
 in ( LrTable.NT 19, ( result, exp1left, exp2right), rest671)
end
|  ( 50, ( ( _, ( MlyValue.ntVOID exp2, _, exp2right)) :: _ :: ( _, ( 
MlyValue.ntVOID exp1, exp1left, _)) :: rest671)) => let val  result = 
MlyValue.ntVOID (fn _ => ( let val  (exp as exp1) = exp1 ()
 val  exp2 = exp2 ()
 in (print "R50 comparison: exp NEQ exp\n")
end; ()))
 in ( LrTable.NT 19, ( result, exp1left, exp2right), rest671)
end
|  ( 51, ( ( _, ( MlyValue.ntVOID exp2, _, exp2right)) :: _ :: ( _, ( 
MlyValue.ntVOID exp1, exp1left, _)) :: rest671)) => let val  result = 
MlyValue.ntVOID (fn _ => ( let val  (exp as exp1) = exp1 ()
 val  exp2 = exp2 ()
 in (print "R51 comparison: exp GT exp\n")
end; ()))
 in ( LrTable.NT 19, ( result, exp1left, exp2right), rest671)
end
|  ( 52, ( ( _, ( MlyValue.ntVOID exp2, _, exp2right)) :: _ :: ( _, ( 
MlyValue.ntVOID exp1, exp1left, _)) :: rest671)) => let val  result = 
MlyValue.ntVOID (fn _ => ( let val  (exp as exp1) = exp1 ()
 val  exp2 = exp2 ()
 in (print "R52 comparison: exp LT exp\n")
end; ()))
 in ( LrTable.NT 19, ( result, exp1left, exp2right), rest671)
end
|  ( 53, ( ( _, ( MlyValue.ntVOID exp2, _, exp2right)) :: _ :: ( _, ( 
MlyValue.ntVOID exp1, exp1left, _)) :: rest671)) => let val  result = 
MlyValue.ntVOID (fn _ => ( let val  (exp as exp1) = exp1 ()
 val  exp2 = exp2 ()
 in (print "R53 comparison: exp GE exp\n")
end; ()))
 in ( LrTable.NT 19, ( result, exp1left, exp2right), rest671)
end
|  ( 54, ( ( _, ( MlyValue.ntVOID exp2, _, exp2right)) :: _ :: ( _, ( 
MlyValue.ntVOID exp1, exp1left, _)) :: rest671)) => let val  result = 
MlyValue.ntVOID (fn _ => ( let val  (exp as exp1) = exp1 ()
 val  exp2 = exp2 ()
 in (print "R54 comparison: exp LE exp\n")
end; ()))
 in ( LrTable.NT 19, ( result, exp1left, exp2right), rest671)
end
|  ( 55, ( ( _, ( MlyValue.ntVOID exp2, _, exp2right)) :: _ :: ( _, ( 
MlyValue.ntVOID exp1, exp1left, _)) :: rest671)) => let val  result = 
MlyValue.ntVOID (fn _ => ( let val  (exp as exp1) = exp1 ()
 val  exp2 = exp2 ()
 in (print "R55 booleanExp: exp AND exp\n")
end; ()))
 in ( LrTable.NT 16, ( result, exp1left, exp2right), rest671)
end
|  ( 56, ( ( _, ( MlyValue.ntVOID exp2, _, exp2right)) :: _ :: ( _, ( 
MlyValue.ntVOID exp1, exp1left, _)) :: rest671)) => let val  result = 
MlyValue.ntVOID (fn _ => ( let val  (exp as exp1) = exp1 ()
 val  exp2 = exp2 ()
 in (print "R56 booleanExp: exp OR exp\n")
end; ()))
 in ( LrTable.NT 16, ( result, exp1left, exp2right), rest671)
end
|  ( 57, ( ( _, ( MlyValue.ntVOID exp2, _, exp2right)) :: _ :: ( _, ( 
MlyValue.ntVOID exp1, exp1left, _)) :: rest671)) => let val  result = 
MlyValue.ntVOID (fn _ => ( let val  (exp as exp1) = exp1 ()
 val  exp2 = exp2 ()
 in (print "R57 arithmeticExp: exp PLUS exp\n")
end; ()))
 in ( LrTable.NT 2, ( result, exp1left, exp2right), rest671)
end
|  ( 58, ( ( _, ( MlyValue.ntVOID exp2, _, exp2right)) :: _ :: ( _, ( 
MlyValue.ntVOID exp1, exp1left, _)) :: rest671)) => let val  result = 
MlyValue.ntVOID (fn _ => ( let val  (exp as exp1) = exp1 ()
 val  exp2 = exp2 ()
 in (print "R58 arithmeticExp: exp MINUS exp\n")
end; ()))
 in ( LrTable.NT 2, ( result, exp1left, exp2right), rest671)
end
|  ( 59, ( ( _, ( MlyValue.ntVOID exp2, _, exp2right)) :: _ :: ( _, ( 
MlyValue.ntVOID exp1, exp1left, _)) :: rest671)) => let val  result = 
MlyValue.ntVOID (fn _ => ( let val  (exp as exp1) = exp1 ()
 val  exp2 = exp2 ()
 in (print "R59 arithmeticExp: exp TIMES exp\n")
end; ()))
 in ( LrTable.NT 2, ( result, exp1left, exp2right), rest671)
end
|  ( 60, ( ( _, ( MlyValue.ntVOID exp2, _, exp2right)) :: _ :: ( _, ( 
MlyValue.ntVOID exp1, exp1left, _)) :: rest671)) => let val  result = 
MlyValue.ntVOID (fn _ => ( let val  (exp as exp1) = exp1 ()
 val  exp2 = exp2 ()
 in (print "R60 arithmeticExp: exp DIVIDE exp\n")
end; ()))
 in ( LrTable.NT 2, ( result, exp1left, exp2right), rest671)
end
|  ( 61, ( ( _, ( MlyValue.ntVOID exp1, _, exp1right)) :: ( _, ( _, 
MINUS1left, _)) :: rest671)) => let val  result = MlyValue.ntVOID (fn
 _ => ( let val  (exp as exp1) = exp1 ()
 in (print "R61 arithmeticExp: MINUS exp %prec UMINUS \n")
end; ()))
 in ( LrTable.NT 2, ( result, MINUS1left, exp1right), rest671)
end
| _ => raise (mlyAction i392)
end
val void = MlyValue.VOID
val extract = fn a => (fn MlyValue.ntVOID x => x
| _ => let exception ParseInternal
	in raise ParseInternal end) a ()
end
end
structure Tokens : Tiger_TOKENS =
struct
type svalue = ParserData.svalue
type ('a,'b) token = ('a,'b) Token.token
fun EOF (p1,p2) = Token.TOKEN (ParserData.LrTable.T 0,(
ParserData.MlyValue.VOID,p1,p2))
fun ID (i,p1,p2) = Token.TOKEN (ParserData.LrTable.T 1,(
ParserData.MlyValue.ID (fn () => i),p1,p2))
fun INT (i,p1,p2) = Token.TOKEN (ParserData.LrTable.T 2,(
ParserData.MlyValue.INT (fn () => i),p1,p2))
fun STRING (i,p1,p2) = Token.TOKEN (ParserData.LrTable.T 3,(
ParserData.MlyValue.STRING (fn () => i),p1,p2))
fun COMMA (p1,p2) = Token.TOKEN (ParserData.LrTable.T 4,(
ParserData.MlyValue.VOID,p1,p2))
fun COLON (p1,p2) = Token.TOKEN (ParserData.LrTable.T 5,(
ParserData.MlyValue.VOID,p1,p2))
fun SEMICOLON (p1,p2) = Token.TOKEN (ParserData.LrTable.T 6,(
ParserData.MlyValue.VOID,p1,p2))
fun LPAREN (p1,p2) = Token.TOKEN (ParserData.LrTable.T 7,(
ParserData.MlyValue.VOID,p1,p2))
fun RPAREN (p1,p2) = Token.TOKEN (ParserData.LrTable.T 8,(
ParserData.MlyValue.VOID,p1,p2))
fun LBRACK (p1,p2) = Token.TOKEN (ParserData.LrTable.T 9,(
ParserData.MlyValue.VOID,p1,p2))
fun RBRACK (p1,p2) = Token.TOKEN (ParserData.LrTable.T 10,(
ParserData.MlyValue.VOID,p1,p2))
fun LBRACE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 11,(
ParserData.MlyValue.VOID,p1,p2))
fun RBRACE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 12,(
ParserData.MlyValue.VOID,p1,p2))
fun DOT (p1,p2) = Token.TOKEN (ParserData.LrTable.T 13,(
ParserData.MlyValue.VOID,p1,p2))
fun PLUS (p1,p2) = Token.TOKEN (ParserData.LrTable.T 14,(
ParserData.MlyValue.VOID,p1,p2))
fun MINUS (p1,p2) = Token.TOKEN (ParserData.LrTable.T 15,(
ParserData.MlyValue.VOID,p1,p2))
fun TIMES (p1,p2) = Token.TOKEN (ParserData.LrTable.T 16,(
ParserData.MlyValue.VOID,p1,p2))
fun DIVIDE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 17,(
ParserData.MlyValue.VOID,p1,p2))
fun EQ (p1,p2) = Token.TOKEN (ParserData.LrTable.T 18,(
ParserData.MlyValue.VOID,p1,p2))
fun NEQ (p1,p2) = Token.TOKEN (ParserData.LrTable.T 19,(
ParserData.MlyValue.VOID,p1,p2))
fun LT (p1,p2) = Token.TOKEN (ParserData.LrTable.T 20,(
ParserData.MlyValue.VOID,p1,p2))
fun LE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 21,(
ParserData.MlyValue.VOID,p1,p2))
fun GT (p1,p2) = Token.TOKEN (ParserData.LrTable.T 22,(
ParserData.MlyValue.VOID,p1,p2))
fun GE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 23,(
ParserData.MlyValue.VOID,p1,p2))
fun UMINUS (p1,p2) = Token.TOKEN (ParserData.LrTable.T 24,(
ParserData.MlyValue.VOID,p1,p2))
fun AND (p1,p2) = Token.TOKEN (ParserData.LrTable.T 25,(
ParserData.MlyValue.VOID,p1,p2))
fun OR (p1,p2) = Token.TOKEN (ParserData.LrTable.T 26,(
ParserData.MlyValue.VOID,p1,p2))
fun ASSIGN (p1,p2) = Token.TOKEN (ParserData.LrTable.T 27,(
ParserData.MlyValue.VOID,p1,p2))
fun ARRAY (p1,p2) = Token.TOKEN (ParserData.LrTable.T 28,(
ParserData.MlyValue.VOID,p1,p2))
fun IF (p1,p2) = Token.TOKEN (ParserData.LrTable.T 29,(
ParserData.MlyValue.VOID,p1,p2))
fun THEN (p1,p2) = Token.TOKEN (ParserData.LrTable.T 30,(
ParserData.MlyValue.VOID,p1,p2))
fun ELSE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 31,(
ParserData.MlyValue.VOID,p1,p2))
fun WHILE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 32,(
ParserData.MlyValue.VOID,p1,p2))
fun FOR (p1,p2) = Token.TOKEN (ParserData.LrTable.T 33,(
ParserData.MlyValue.VOID,p1,p2))
fun TO (p1,p2) = Token.TOKEN (ParserData.LrTable.T 34,(
ParserData.MlyValue.VOID,p1,p2))
fun DO (p1,p2) = Token.TOKEN (ParserData.LrTable.T 35,(
ParserData.MlyValue.VOID,p1,p2))
fun LET (p1,p2) = Token.TOKEN (ParserData.LrTable.T 36,(
ParserData.MlyValue.VOID,p1,p2))
fun IN (p1,p2) = Token.TOKEN (ParserData.LrTable.T 37,(
ParserData.MlyValue.VOID,p1,p2))
fun END (p1,p2) = Token.TOKEN (ParserData.LrTable.T 38,(
ParserData.MlyValue.VOID,p1,p2))
fun OF (p1,p2) = Token.TOKEN (ParserData.LrTable.T 39,(
ParserData.MlyValue.VOID,p1,p2))
fun BREAK (p1,p2) = Token.TOKEN (ParserData.LrTable.T 40,(
ParserData.MlyValue.VOID,p1,p2))
fun NIL (p1,p2) = Token.TOKEN (ParserData.LrTable.T 41,(
ParserData.MlyValue.VOID,p1,p2))
fun FUNCTION (p1,p2) = Token.TOKEN (ParserData.LrTable.T 42,(
ParserData.MlyValue.VOID,p1,p2))
fun VAR (p1,p2) = Token.TOKEN (ParserData.LrTable.T 43,(
ParserData.MlyValue.VOID,p1,p2))
fun TYPE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 44,(
ParserData.MlyValue.VOID,p1,p2))
end
end
