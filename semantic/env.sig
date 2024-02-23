signature ENV =
sig
    type access
    (* type ty = Types.ty *)
    datatype enventry = VarEntry of {ty: Types.ty}
    | FunEntry of {formals: Types.ty list, result: Types.ty}
    val base_tenv : Types.ty Symbol.table (* predefined types*)
    val base_venv : enventry Symbol.table (* predefinedfunctions*) 
end