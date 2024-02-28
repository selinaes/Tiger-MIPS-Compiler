signature TABLE = 
sig
   type key
   type 'a table
   val empty : 'a table
   val enter : 'a table * key * 'a -> 'a table
   val look  : 'a table * key -> 'a option
end


functor IntMapTable (type key
		     val getInt: key -> int) : TABLE =
struct
  type key=key
  type 'a table = 'a IntBinaryMap.map
  val empty = IntBinaryMap.empty
  fun enter(t,k,a) = IntBinaryMap.insert(t,getInt k,a)
  fun look(t,k) = IntBinaryMap.find(t,getInt k)
end

signature SYMBOL =
sig
  eqtype symbol
  val symbol : string -> symbol
  val name : symbol -> string
  type 'a table
  val empty : 'a table
  val enter : 'a table * symbol * 'a -> 'a table
  val look  : 'a table * symbol -> 'a option
end

structure Symbol :> SYMBOL =
struct

  type symbol = string * int

  structure H = HashTable

  exception Symbol
  val nextsym = ref 0
  val sizeHint = 128
  val hashtable : (string,int) H.hash_table = 
		H.mkTable(HashString.hashString, op = ) (sizeHint,Symbol)
  
  fun symbol name =
      case H.find hashtable name
       of SOME i => (name,i)
        | NONE => let val i = !nextsym
	           in nextsym := i+1;
		      H.insert hashtable (name,i);
		      (name,i)
		  end

  fun name(s,n) = s

  structure Table = IntMapTable(type key = symbol
				fun getInt(s,n) = n)

  type 'a table= 'a Table.table
  val empty = Table.empty
  val enter = Table.enter
  val look = Table.look
end

structure Absyn = 
struct

type pos = int   and   symbol = Symbol.symbol

datatype var = SimpleVar of symbol * pos
            | FieldVar of var * symbol * pos
            | SubscriptVar of var * exp * pos

and exp = VarExp of var
        | NilExp
        | IntExp of int
        | StringExp of string * pos
        | CallExp of {func: symbol, args: exp list, pos: pos}
        | OpExp of {left: exp, oper: oper, right: exp, pos: pos}
        | RecordExp of {fields: (symbol * exp * pos) list,
			typ: symbol, pos: pos}
        | SeqExp of (exp * pos) list
        | AssignExp of {var: var, exp: exp, pos: pos}
        | IfExp of {test: exp, then': exp, else': exp option, pos: pos}
        | WhileExp of {test: exp, body: exp, pos: pos}
	| ForExp of {var: symbol, escape: bool ref,
		     lo: exp, hi: exp, body: exp, pos: pos}
        | BreakExp of pos
        | LetExp of {decs: dec list, body: exp, pos: pos}
        | ArrayExp of {typ: symbol, size: exp, init: exp, pos: pos}

and dec = FunctionDec of fundec list
        | VarDec of {name: symbol,
		     escape: bool ref,
		     typ: (symbol * pos) option,
		     init: exp,
		     pos: pos}
        | TypeDec of {name: symbol, ty: ty, pos: pos} list

and ty = NameTy of symbol * pos
       | RecordTy of field list
       | ArrayTy of symbol * pos

and oper = PlusOp | MinusOp | TimesOp | DivideOp
         | EqOp | NeqOp | LtOp | LeOp | GtOp | GeOp

withtype field = {name: symbol, escape: bool ref, 
		  typ: symbol, pos: pos}
   and   fundec = {name: symbol,
		   params: field list,
		   result: (symbol * pos) option,
		   body: exp,
		   pos: pos}
     
end
        

structure A = Absyn
open Symbol

fun fix(A.FunctionDec(fdA)::A.FunctionDec(fdB)::rest) = fix(A.FunctionDec(fdA@fdB)::rest)
|fix(A.TypeDec(tdA)::A.TypeDec(tdB)::rest) = fix(A.TypeDec(tdA@tdB)::rest)
|fix(a::rest)=a::fix(rest)