structure Translate = struct type exp = unit end

signature SEMANTIC =

sig 
    type expty
    type venv
    type tenv
    
    val transVar: venv * tenv * Absyn.var -> expty
    val transExp: venv * tenv * Absyn.exp -> expty
    val transDec: venv * tenv * Absyn.dec -> {venv: venv, tenv: tenv} 
    (* val transTy: tenv * Absyn.ty -> Types.ty *)
    val transProg : Absyn.exp -> unit
end