
signature TRANSLATE = 
sig
    type level
    type access (* not the same as Frame.access *)
    val outermost : level
    type exp
    val fragLst : Frame.frag list ref

    val newLevel : {parent: level, name: Temp.label, formals: bool list} -> level 
    val formals: level -> access list
    val allocLocal: level -> bool -> access 
    val procEntryExit : {level: level, body: exp} -> unit
    val getResult : unit -> Frame.frag list

    val unEx: exp -> Tree.exp
    val unNx: exp -> Tree.stm
    val unCx: exp -> (Temp.label * Temp.label -> Tree.stm)

    val simpleVar: access * level -> exp
    val fieldVar: exp * int -> exp
    val subscriptVar: exp * exp -> exp
    
    val ifThenIR: exp * exp  -> exp (*take in: if * then *)
    val ifThenElseIR: exp * exp * exp -> exp (* take in: if * then * else *)
    val whileIR: exp * exp * Temp.label -> exp
    val forIR: exp * exp * exp * exp -> exp (* take in: vloc * lo * hi * body *)
    val assignIR: exp * exp -> exp (* take in: vloc * assignmentExp *)
    val seqIR: exp list -> exp
    val nilIR: unit -> exp
    val letIR: exp list * exp -> exp (* takes in: declist * body *)
    val stringIR: string -> exp  (*mark*)
    val intIR: int -> exp
    val arrayIR: exp * exp -> exp
    val recordIR: exp list -> exp
    val breakIR: Temp.label -> exp
    val callIR: Temp.label * exp list * level * level -> exp (** calling level and defined level *)
    val binOpIR: Tree.binop * exp * exp -> exp
    val reOpIR: Tree.relop * exp * exp * Types.ty -> exp
end