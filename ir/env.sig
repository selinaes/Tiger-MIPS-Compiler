signature ENV =
sig
    type access
    (* type ty = Types.ty *)
    datatype enventry = VarEntry of {access: Translate.access, ty: Types.ty}  (* ty: ty *)
    | FunEntry of {level: Translate.level, label: Temp.label,
                    formals: Types.ty list, result: Types.ty}  (* formals: ty list, result: ty *)
    val base_tenv : Types.ty Symbol.table (* predefined types*)
    val base_venv : enventry Symbol.table (* predefinedfunctions*) 
end