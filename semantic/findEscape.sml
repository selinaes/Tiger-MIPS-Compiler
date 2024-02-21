structure FindEscape : FIND_ESCAPE =
struct
  open Absyn

  type depth = int
  type escEnv = (depth * bool ref) Symbol.table

  (* Escape meaning = exit current scope, don't erase this variable, bc used outside 
    Accessed outside their definition scope *)
  fun markEscape (env: escEnv, depth: depth, sym: Symbol.symbol) = 
      case Symbol.look(env, sym) of
        SOME (d, escape) =>
            if depth > d then escape := true else ()
      | NONE => ()

  fun traverseVar (env:escEnv, d:depth, s:Absyn.var): unit = 
      case s of 
        SimpleVar (sym, _) => markEscape(env, d, sym)
      | FieldVar (var, _, _) => traverseVar(env, d, var)
      | SubscriptVar (var, exp, _) => (traverseVar(env, d, var); traverseExp(env, d, exp))
  and traverseExp(env:escEnv, d:depth, s:Absyn.exp): unit =
      case s of
        VarExp v => traverseVar(env, d, v)
      | LetExp {decs, body, pos} => traverseExp(traverseDecs(env, d, decs), d, body)
      | CallExp {func, args, pos} => List.app (fn arg => traverseExp(env, d, arg)) args
      | OpExp {left, oper, right, pos} => (traverseExp(env, d, left); traverseExp(env, d, right))
      | AssignExp {var, exp, pos} => (traverseVar(env, d, var); traverseExp(env, d, exp))
      | ForExp {var, escape, lo, hi, body, pos} =>
        let
          val env' = Symbol.enter(env, var, (d, escape))
        in
          traverseExp(env', d, lo);
          traverseExp(env', d, hi);
          traverseExp(env', d, body)
        end
      | RecordExp {fields, typ, pos} => 
        (List.app (fn (sym, exp, pos) => (markEscape(env, d, sym); traverseExp(env, d, exp))) fields)
      | SeqExp exps => List.app (fn (e, pos) => traverseExp(env, d, e)) exps
      | IfExp {test, then', else', pos} => 
        (traverseExp(env, d, test);
          traverseExp(env, d, then'); 
          case else' of
            SOME e => traverseExp(env, d, e)
          | NONE => ())
      | WhileExp {test, body, pos} => (traverseExp(env, d, test); traverseExp(env, d, body))
      | ArrayExp {typ, size, init, pos} => (traverseExp(env, d, size); traverseExp(env, d, init))
      | _ => ()

  and traverseDecs (env : escEnv, depth : depth, decs : Absyn.dec list) : escEnv = 
      let
        fun insertParam env (depth, param:field) =
            Symbol.enter(env, #name param, (depth, #escape param))
        fun traverseFuncDec env depth ({name, params,result, body, pos}:fundec) = 
            let
              val newDepth = depth + 1
              val env' = foldl (fn (param,e) => insertParam e (newDepth, param)) env params
              val _ = traverseExp(env', newDepth, body)
            in
              env
            end
        
        fun traverseDec env depth dec = case dec of
              VarDec {name, escape,typ,init,pos} => 
                let
                  val env' = Symbol.enter(env, name, (depth, escape))
                in
                  traverseExp(env', depth, init);
                  env'
                end
            | FunctionDec fundecs => 
              foldl (fn (fundec, e) => traverseFuncDec e depth fundec) env fundecs
            | TypeDec _ => env

      in
        foldl (fn (dec,e) => traverseDec e depth dec) env decs
      end


  fun findEscape (program : Absyn.exp) = 
      let
        val initialEnv: escEnv = Symbol.empty 
        val initialDepth = 0
      in
        traverseExp (initialEnv, initialDepth, program)
      end
end
