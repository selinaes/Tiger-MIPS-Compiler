structure Semant :> SEMANTIC =

struct
    structure A = Absyn
    structure S = Symbol
    structure E = Env
    structure T = Types
    structure Error = ErrorMsg
    
    fun checkint ({exp,ty=T.INT},pos) = ()
    | checkint (_,pos) = Error.error pos "Error: non-integer provided at pos: " ^ (Int.toString pos)

    fun checkstr({exp,ty=T.STRING},pos) = ()
    | checkstr(_,pos) = Error.error pos "Error: non-string provided at pos: " ^ (Int.toString pos)

    fun transExp(venv,tenv) =
        let fun trexp (A.OpExp{left, oper=A.PlusOp, right,pos}) =
                    (checkint(trexp left, pos);
                    checkint(trexp right, pos);
                    {exp=(),ty=Types.INT})
                | trexp (A.RecordExp ) = 
                | trexp(A.LetExp{decs,body,pos}) =
                    let 
                        val {venv=venv',tenv=tenv'} = transDecs(venv,tenv,decs)
                    in 
                        transExp(venv',tenv') body
                    end
            and trvar (A.SimpleVar(id,pos)) =
                    (case Symbol.look(venv,id)
                    of SOME(E.VarEntry{ty}) =>
                        {exp=(), ty=actual_ty ty}
                      |NONE => (error pos ("undefined variable "^ S.name id);
                                exp=(), ty=Types.INT))
                | trvar (A.FieldVar(v,id,pos)) = ...
        in
            trexp
        end

    
    fun transDec (venv, tenv, A.VarDec{name,typ=NONE,init,...}) = 
        (* VarDec, var x : = exp *)
        let 
            val (exp,ty) = transExp(venv,tenv,init)
        in 
            {tenv=tenv,
            venv=S.enter(venv,name,E.VarEntry{ty=ty})}
        end
        (* Nonrecursive Type Dec *)
        | transDec (venv,tenv,A.TypeDec[{name,ty}]) =
            {venv=venv,
            tenv=S.enter(tenv,name,transTy(tenv,ty))}
        (* Fun Dec, basics: single func, has return, did not match body*)
        | transDec(venv,tenv, A.FunctionDec[{name,params,body,pos,lt=SOME(rt,pos)}]) =
            let val SOME(result_ty) = S.look(tenv,rt)
                fun transparam{name,typ,pos} =
                    case S.look(tenv,typ)
                    of SOME t => {name=name,ty=t}
                val params' = map transparam params
                val venv' = S.enter(venv,name,
                            E.FunEntry{formals= map #ty params',
                                       result=result_ty})
                fun enterparam ({name,ty},venv) =
                            S.enter(venv,name, E.VarEntry{access=(),ty=ty})
                val venv'' = fold enterparam params' venv'
            in transExp(venv'',tenv) body;
                {venv=venv',tenv=tenv}
            end
end;