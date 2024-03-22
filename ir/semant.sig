
signature SEMANTIC =

sig 
    type expty
    type venv
    type tenv
    
    val transVar: venv * tenv * Translate.level * Absyn.var * Temp.label -> expty (*old: venv * tenv * Absyn.var*)
    val transExp: venv * tenv * Translate.level * Absyn.exp * Temp.label -> expty (* venv * tenv * Absyn.exp *)
    val transDec: venv * tenv * Translate.exp list * Translate.level * Absyn.dec * Temp.label -> {venv: venv, tenv: tenv, explist: Translate.exp list}  (*old: venv * tenv * Absyn.dec *)
    (* val transTy: tenv * Absyn.ty -> Types.ty *)
    val transProg : Absyn.exp -> Frame.frag list
end