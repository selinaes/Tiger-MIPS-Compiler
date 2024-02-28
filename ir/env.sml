structure Env :> ENV =

struct
    type access = unit
    (* type ty = Types.ty *)
    datatype enventry = 
        VarEntry of {ty: Types.ty}
    | FunEntry of {formals: Types.ty list, result: Types.ty} 
    val base_tenv : Types.ty Symbol.table (* predefined types*) = 
        let
            val baseTypes = [(Symbol.symbol "int", Types.INT), (Symbol.symbol "string", Types.STRING)]
        in
            foldr (fn ((s, t), acc) => Symbol.enter(acc, s, t)) Symbol.empty baseTypes
        end

    val base_venv : enventry Symbol.table (* predefinedfunctions*)  = 
        let 
            val baseFunctions = [
                    (Symbol.symbol "print", FunEntry{formals=[Types.STRING], result=Types.UNIT}),
                    (Symbol.symbol "flush", FunEntry{formals=[], result=Types.UNIT}),
                    (Symbol.symbol "getchar", FunEntry{formals=[], result=Types.STRING}),
                    (Symbol.symbol "ord", FunEntry{formals=[Types.STRING], result=Types.INT}),
                    (Symbol.symbol "chr", FunEntry{formals=[Types.INT], result=Types.STRING}),
                    (Symbol.symbol "size", FunEntry{formals=[Types.STRING], result=Types.INT}),
                    (Symbol.symbol "substring", FunEntry{formals=[Types.STRING, Types.INT, Types.INT], result=Types.STRING}),
                    (Symbol.symbol "concat", FunEntry{formals=[Types.STRING, Types.STRING], result=Types.STRING}),
                    (Symbol.symbol "not", FunEntry{formals=[Types.INT], result=Types.INT}),
                    (Symbol.symbol "exit", FunEntry{formals=[Types.INT], result=Types.IMPOSSIBLE})
                ]
        in
            foldr (fn ((s, t), acc) => Symbol.enter(acc, s, t)) Symbol.empty baseFunctions
        end
end;