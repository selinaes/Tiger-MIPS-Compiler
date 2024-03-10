
signature TRANSLATE = 
sig
    type level
    type access (*not the same as Frame.access*)
    val outermost : level
    type exp

    (* structure Frame : FRAME *)
    val newLevel : {parent: level, name: Temp.label, formals: bool list} -> level 
    val formals: level -> access list
    val allocLocal: level -> bool -> access 
    val procEntryExit : {level: level, body: exp} -> unit
    val getResult : unit -> Frame.frag list
    val unEx: exp -> Tree.exp
    val unNx: exp -> Tree.stm
    val unCx: exp -> (Temp.label * Temp.labels -> Tree.stm)
    val simpleVar: access * level -> exp
    val transIfThen: exp * exp  -> exp
    val transIfThenElse: exp * exp * exp -> exp
    val transWhile: exp * exp -> exp
end