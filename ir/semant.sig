
signature SEMANTIC =

sig 
    type expty
    type venv
    type tenv
    
    val transVar: venv * tenv * Translate.level * Absyn.var -> expty (*old: venv * tenv * Absyn.var*)
    val transExp: venv * tenv * Translate.level * Absyn.exp -> expty (* venv * tenv * Absyn.exp *)
    val transDec: venv * tenv * Translate.level * Absyn.dec -> {venv: venv, tenv: tenv}  (*old: venv * tenv * Absyn.dec *)
    (* val transTy: tenv * Absyn.ty -> Types.ty *)
    val transProg : Absyn.exp -> unit
end