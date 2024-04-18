structure Env :> ENV =

struct
    type access = unit
    (* type ty = Types.ty *)
    structure TR = Translate
    structure TE = Temp
    datatype enventry =   VarEntry of {access: Translate.access, ty: Types.ty}  
                        | FunEntry of {level: Translate.level, label: Temp.label,
                                        formals: Types.ty list, result: Types.ty}  
    val base_tenv : Types.ty Symbol.table (* predefined types*) = 
        let
            val baseTypes = [(Symbol.symbol "int", Types.INT), (Symbol.symbol "string", Types.STRING)]
        in
            foldr (fn ((s, t), acc) => Symbol.enter(acc, s, t)) Symbol.empty baseTypes
        end

    val base_venv : enventry Symbol.table (* predefinedfunctions*)  = 
        let 
            val baseFunctions = [
                    (Symbol.symbol "print", FunEntry{level=TR.outmost, label=Temp.namedlabel "tig_print", formals=[Types.STRING], result=Types.UNIT}),
                    (Symbol.symbol "flush", FunEntry{level=TR.outmost, label=Temp.namedlabel "tig_flush", formals=[], result=Types.UNIT}),
                    (Symbol.symbol "getchar", FunEntry{level=TR.outmost, label=Temp.namedlabel "tig_getchar", formals=[], result=Types.STRING}),
                    (Symbol.symbol "ord", FunEntry{level=TR.outmost, label=Temp.namedlabel "tig_ord", formals=[Types.STRING], result=Types.INT}),
                    (Symbol.symbol "chr", FunEntry{level=TR.outmost, label=Temp.namedlabel "tig_chr", formals=[Types.INT], result=Types.STRING}),
                    (Symbol.symbol "size", FunEntry{level=TR.outmost, label=Temp.namedlabel "tig_size", formals=[Types.STRING], result=Types.INT}),
                    (Symbol.symbol "substring", FunEntry{level=TR.outmost, label=Temp.namedlabel "tig_substring", formals=[Types.STRING, Types.INT, Types.INT], result=Types.STRING}),
                    (Symbol.symbol "concat", FunEntry{level=TR.outmost, label=Temp.namedlabel "tig_concat", formals=[Types.STRING, Types.STRING], result=Types.STRING}),
                    (Symbol.symbol "not", FunEntry{level=TR.outmost, label=Temp.namedlabel "tig_not", formals=[Types.INT], result=Types.INT}),
                    (Symbol.symbol "exit", FunEntry{level=TR.outmost, label=Temp.namedlabel "tig_exit", formals=[Types.INT], result=Types.IMPOSSIBLE})
                ]
        in
            foldr (fn ((s, t), acc) => Symbol.enter(acc, s, t)) Symbol.empty baseFunctions
        end
end;