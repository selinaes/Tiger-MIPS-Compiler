structure Semant :> SEMANTIC =

struct
    structure A = Absyn
    structure S = Symbol
    structure E = Env
    structure T = Types
    structure Error = ErrorMsg
    
    fun checkint ({exp,ty=T.INT},pos) = ()
    | checkint (_,pos) = Error.error pos "Error: non-integer provided at pos: " ^ (Int.toString pos)
    
    fun checkTwoInts (left, right,pos) = (checkint(left, pos); checkint(right, pos))

    fun checkstr({exp,ty=T.STRING},pos) = ()
    | checkstr(_,pos) = Error.error pos "Error: non-string provided at pos: " ^ (Int.toString pos)
    
    fun checkTwoIntsOrStrs ({exp=_, ty=T.INT}, {exp=_, ty=T.INT}, pos) = ()
    | checkTwoIntsOrStrs({exp=_, ty=T.STRING}, {exp=_, ty=T.STRING}, pos)     = ()
    | checkTwoIntsOrStrs(_,_,pos) = Error.error pos "Error: non-integer or non-string provided at pos: " ^ (Int.toString pos) ^ "using comparison operator"

    fun checkTwoEqTypes ({exp=_, ty=T.INT}, {exp=_, ty=T.INT}, pos) = ()
    | checkTwoEqTypes ({exp=_, ty=T.STRING}, {exp=_, ty=T.STRING}, pos) = ()
    | checkTwoEqTypes ({exp=_, ty=T.RECORD(_,unique1)}, {exp=_, ty=T.RECORD(_,unique2)}, pos) = if unique1 = unique2 then () else Error.error pos "Error: comparing two different records at pos: " ^ (Int.toString pos)
    | checkTwoEqTypes ({exp=_, ty=T.NIL}, {exp=_, ty=T.RECORD}, pos) = ()
    | checkTwoEqTypes ({exp=_, ty=T.RECORD}, {exp=_, ty=T.NIL}, pos) = ()
    | checkTwoEqTypes ({exp=_, ty=T.ARRAY(_,unique1)}, {exp=_, ty=T.ARRAY(_,unique2)}, pos) = if unique1 = unique2 then () else Error.error pos "Error: comparing two different arrays at pos: " ^ (Int.toString pos)
    | checkTwoEqTypes ({exp=_, ty=T.NIL}, {exp=_, ty=T.NIL}, pos) = ()
    | checkTwoEqTypes(_,_,pos) = Error.error pos "Error: comparing two different types at pos: " ^ (Int.toString pos)
        
    fun transExp(venv,tenv) =

        let fun trop (A.OpExp(left,oper=A.PlusOp,right,pos)) = (checkTwoInts(trexp left,trexp right,pos),{exp=(),ty=Types.INT})
            |   trop (A.OpExp(left,oper=A.MinusOp,right,pos)) = (checkTwoInts(trexp left,trexp right,pos),{exp=(),ty=Types.INT})
            |   trop (A.OpExp(left,oper=A.TimesOp,right,pos)) = (checkTwoInts(trexp left,trexp right,pos),{exp=(),ty=Types.INT})
            |   trop (A.OpExp(left,oper=A.DivideOp,right,pos)) = (checkTwoInts(trexp left,trexp right,pos),{exp=(),ty=Types.INT})
            |   trop (A.OpExp(left,oper=A.EqOp,right,pos)) = (checkTwoEqTypes(trexp left,trexp right,pos),{exp=(),ty=Types.INT})
            |   trop (A.OpExp(left,oper=A.NeqOp,right,pos)) = (checkTwoEqTypes(trexp left,trexp right,pos),{exp=(),ty=Types.INT})
            |   trop (A.OpExp(left,oper=A.LtOp,right,pos)) = (checkTwoIntsOrStrs(trexp left,trexp right,pos,{exp=(),ty=Types.INT}))
            |   trop (A.OpExp(left,oper=A.LeOp,right,pos)) = (checkTwoIntsOrStrs(trexp left,trexp right,pos),{exp=(),ty=Types.INT})
            |   trop (A.OpExp(left,oper=A.GtOp,right,pos)) = (checkTwoIntsOrStrs(trexp left,trexp right,pos),{exp=(),ty=Types.INT})
            |   trop (A.OpExp(left,oper=A.GeOp,right,pos)) = (checkTwoIntsOrStrs(trexp left,trexp right,pos),{exp=(),ty=Types.INT})
         and trvar (A.SimpleVar(id,pos)) = ()
        (*        (case Symbol.look(venv,id)
                of SOME(E.VarEntry{ty}) =>
                    {exp=(), ty=actual_ty ty}
                  |NONE => (error pos ("undefined variable "^ S.name id);
                            exp=(), ty=Types.INT))
            | trvar (A.FieldVar(v,id,pos)) = ...
            | trvar (A.SubscriptVar(v,exp,pos)) = ... *)
        and trcall (A.CallExp{func,args,pos}) = ()
        and trrecord (A.RecordExp{fields,typ,pos}) = ()
        and trseq (A.SeqExp exps) = ()
        and trassign (A.AssignExp{var,exp,pos}) = 
            let val (v,ty) = trvar var
                val (e,ty') = trexp exp
            in
                if ty = ty' 
                then ()
                else Error.error pos "Error: assigning different types at pos: " ^ (Int.toString pos)
            end
        and trif (A.IfExp{test,then',else',pos}) = ()
        and trwhile (A.WhileExp{test,body,pos}) = ()
        and trfor (A.ForExp{var,lo,hi,body,pos}) = ()
        and trlet (A.LetExp{decs,body,pos}) = ()
        and trarray (A.ArrayExp{typ,size,init,pos}) = ()
            
        and trexp (A.OpExp{left, oper, right,pos}) = trop(left, oper,right,pos)
        | trexp (A.VarExp v) = trvar v
        | trexp (A.NilExp) = {exp=(),ty=Types.NIL}
        | trexp (A.IntExp i) = {exp=(),ty=Types.INT}
        | trexp (A.StringExp s) = {exp=(),ty=Types.STRING}
        | trexp (A.CallExp{func,args,pos}) = trcall(A.CallExp{func=func,args=args,pos=pos})
        | trexp (A.RecordExp{fields,typ,pos} ) = trrecord(A.RecordExp{fields=fields,typ=typ,pos=pos})
        | trexp (A.SeqExp exps) = trseq(A.SeqExp exps)
        | trexp (A.AssignExp{var,exp,pos}) = trassign(A.AssignExp{var=var,exp=exp,pos=pos})
        | trexp (A.IfExp{test,then',else',pos}) = trif(A.IfExp{test=test,then'=then',else'=else',pos=pos})
        | trexp (A.WhileExp{test,body,pos}) = trwhile(A.WhileExp{test=test,body=body,pos=pos})
        | trexp (A.ForExp{var,lo,hi,body,pos}) = trfor(A.ForExp{var=var,lo=lo,hi=hi,body=body,pos=pos})
        | trexp (A.LetExp{decs,body,pos}) = trlet(A.LetExp{decs=decs,body=body,pos=pos})
        | trexp (A.ArrayExp{typ,size,init,pos}) = trarray(A.ArrayExp{typ=typ,size=size,init=init,pos=pos})
        | trexp (A.BreakExp pos) = {exp=(), ty=Types.UNIT}
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

