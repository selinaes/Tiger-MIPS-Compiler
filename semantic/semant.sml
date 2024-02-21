structure Semant :> SEMANTIC =

struct
    structure A = Absyn
    structure S = Symbol
    structure E = Env
    structure T = Types
    structure Error = ErrorMsg

    structure LoopCounter = struct
        val count = ref 0
        fun enter() = (count := !count + 1; !count)
        fun exit() = (count := !count - 1; !count)
        fun reset() = (count := 0)
    end
    
    fun checkint ({exp,ty=T.INT},pos) = ()
    | checkint (_,pos) = Error.error pos "Error: non-integer provided at pos: " ^ (Int.toString pos)
    
    fun checkTwoInts (left, right,pos) = (checkint(left, pos); checkint(right, pos))

    fun checkUnit ({exp,ty=T.UNIT},pos) = ()
    | checkUnit (_,pos) = Error.error pos "Error: non-unit provided at pos: " ^ (Int.toString pos)
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
         and trvar (A.SimpleVar(id,pos)) = 
                case S.look(venv,id) of 
                    SOME(E.VarEntry{ty}) =>
                        {exp=(), ty=ty}
                    | NONE => (error pos ("undefined variable "^ S.name id);
                                exp=(), ty=T.INT)
            | trvar (A.FieldVar(v,id,pos)) =  
                case trvar v of
                    {exp = vexp, ty = T.RECORD symbolLst} =>
                        let
                            fun findFieldById (id, lst) =
                                case lst of
                                    [] => NONE
                                    | (fieldId, fieldTy) :: rest =>
                                        if id.name = fieldId.name then
                                            SOME fieldTy
                                        else
                                            findFieldById id rest
                        in
                            case findFieldById (id, symbolLst) of
                                SOME fieldTy =>
                                    {exp = A.FieldVar(vexp, id, pos), ty = fieldTy}
                                | NONE =>
                                    (error pos ("undefined field " ^ S.name id ^ " in record");
                                    {exp = A.FieldVar(vexp, id, pos), ty = Types.INT})
                        end
                    | _ =>
                        (error pos "accessing fields of a non-record type";
                        { exp = A.FieldVar(trvar v).exp, ty = Types.INT })
            | trvar (A.SubscriptVar(v,exp,pos)) =  
                case trvar v of
                    {exp = vexp, ty = T.ARRAY elementTy} =>
                        let
                            val index = trexp exp
                        in
                            case index.ty of
                                T.INT =>
                                    {exp = A.SubscriptVar (vexp, index.exp, pos),
                                    ty = elementTy}
                                | _ =>
                                    (error pos "array index must be an integer";
                                    { exp = A.SubscriptVar (vexp, indexExpResult.exp, pos),
                                    ty = T.INT })
                        end
                | _ =>
                        (error pos "subscripting non-array type";
                        { exp = A.SubscriptVar (trvar v).exp, ty = Types.INT })
        
        and trcall (A.CallExp{func,args,pos}) = 
            case S.look(venv,func) of 
                SOME(E.FunEntry{formals,result}) => 
                    let fun checkArgs([],[]) = true
                        | checkArgs (formal::formals, arg::args) = 
                            if T.equals(formal,arg) 
                            then checkArgs(formals,args)
                            else Error.error pos "Error: argument type mismatch at pos: " ^ (Int.toString pos)
                    in
                        if checkArgs(formals,args)
                        then {exp=(),ty=result}
                        else {exp=(),ty=Types.IMPOSSIBLE}
                    end
                | _ => (Error.error pos "Error: undefined function at pos: " ^ (Int.toString pos); {exp=(),ty=Types.IMPOSSIBLE})
        
        and trrecord (A.RecordExp{fields,typ,pos}) = 
            case S.look(tenv,typ) of
                SOME(T.RECORD(typedFields, unique)) =>
                    let
                        fun checkField (field, (name, ty)) =
                            case List.find (fn {name=name',escape,typ,pos} => name = name') fields of
                                SOME {exp, ty=fieldTy} =>
                                    if T.equals(ty, fieldTy) 
                                    then ()
                                    else Error.error pos "Error: type mismatch at pos: " ^ (Int.toString pos)
                                | NONE =>
                                    Error.error pos "Error: missing field at pos: " ^ (Int.toString pos)
                    in
                        List.app checkField typedFields;
                        {exp=(),ty=T.RECORD(typedFields, unique)}
                    end
                | _ => (Error.error pos "Error: undefined record type at pos: " ^ (Int.toString pos); {exp=(),ty=Types.IMPOSSIBLE})
        and trseq (A.SeqExp exps) = (
            case exps
            of [] => {exp=(),ty=Types.UNIT}
            | [exp] => trexp exp
            | exp::exps => (trexp exp; trseq(A.SeqExp exps)) )
        and trassign (A.AssignExp{var,exp,pos}) =
         let val (v,vty) = trvar var
                val (e,ety) = trexp exp
            in
               if T.equals(vty,ety) 
               then (exp = (); ty = Types.UNIT)
               else (Error.error pos "Error: type mismatch at pos: " ^ (Int.toString pos); {exp=(),ty=Types.UNIT})
            end
        and trif (A.IfExp{test,then',else',pos}) = 
        case else' of 
            NONE => (checkint(trexp test,pos); 
                        checkUnit(trexp then'))
            | SOME(else') => 
                let val (t,ty) = trexp test
                    val (th,tht) = trexp then'
                    val (el,elt) = trexp else'
                in
                    checkint(trexp test,pos);
                    if T.equals(tht,elt)
                    then (exp = (); ty = tht)
                    else (Error.error pos "Error: type mismatch at pos: " ^ (Int.toString pos); {exp=(),ty=Types.UNIT})
                end
        and trwhile (A.WhileExp{test,body,pos}) = 
            (checkint(trexp test,pos); 
            LoopCounter.enter();
            checkUnit(trexp body);
            LoopCounter.exit()
            {exp=(),ty=Types.UNIT})
            
        and trfor (A.ForExp{var,lo,hi,body,pos}) = 
               
               let val venv' = S.enter(venv,var,E.VarEntry{ty=Types.INT})
                in
                    checkint(trexp lo,pos);
                    checkint(trexp hi,pos);
                    LoopCounter.enter();
                    checkUnit(transExp (venv',tenv,body));
                    LoopCounter.exit();
                    {exp=(),ty=Types.UNIT}
                 end

        
        and trlet (A.LetExp{decs,body,pos}) = 
            let val (venv=venv',tenv=tenv') = foldl (fn {v',t'} => transDec (v', t', decs)) (venv, tenv) decs
            in
                transExp(venv',tenv') body
            end
        and trarray (A.ArrayExp{typ,size,init,pos}) = 
            let
                val {exp=initExp, ty=initTy} = trexp init
                val size' = trexp size
            in
                checkint(size',pos);
                case S.look(tenv,typ) of
                    SOME(T.ARRAY(ty, unique)) =>
                        if T.equals(ty,initTy)
                        then {exp=(),ty=T.ARRAY(ty,unique)}
                        else (Error.error pos "Error: type mismatch at pos: " ^ (Int.toString pos); {exp=(),ty=Types.IMPOSSIBLE})
                    | _ => (Error.error pos "Error: undefined array type at pos: " ^ (Int.toString pos); {exp=(),ty=Types.IMPOSSIBLE})
            end
        
        and trbreak (A.BreakExp pos) = 
            if LoopCounter.count() > 0
            then {exp=(),ty=Types.UNIT}
            else (Error.error pos "Error: break outside loop at pos: " ^ (Int.toString pos); {exp=(),ty=Types.IMPOSSIBLE})
            
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
        | trexp (A.BreakExp pos) = trbreak(A.BreakExp pos)
        in
            trexp
        end

    fun transTy (tenv, absynTy): ty = 
        case absynTy of
            A.NameTy(sym,pos) => 
                case S.look(tenv,sym) of
                    SOME(ty) => ty
                    | NONE => (Error.error pos "Error: undefined NameTy at pos: " ^ (Int.toString pos); Types.INT)
            | A.RecordTy(fields) =>
                let
                    val unique = ref ()
                    val symTyList = map (fn {name,escape,typ,pos} =>
                        case S.look(tenv,typ) of
                            SOME(ty) => (name,ty)
                            | NONE => (Error.error pos "Error: undefined RecordTy field type at pos: " ^ (Int.toString pos); (name,Types.INT))
                    ) fields
                in
                    Types.RECORD(typedFields,unique)
                end
            | A.ArrayTy(sym,pos) =>
                let
                    val unique = ref ()
                    val elem_ty = 
                        case S.look(tenv,sym) of
                            SOME(ty) => ty
                            | NONE => (Error.error pos "Error: undefined ArrayTy at pos: " ^ (Int.toString pos); Types.INT)
                in
                    Types.ARRAY(elem_ty,unique)
                end
               
            | _ => T.INT (* default, should not happen *)
            
                
    
    fun transDec (venv, tenv, A.VarDec{name,escape,typ,init,pos}) = 
        case typ of 
            NONE => 
                let 
                    val {exp=_,ty} = transExp(venv,tenv,init)
                    val ty' = transTy(tenv,ty)
                in 
                    {tenv=tenv,
                    venv=S.enter(venv,name,E.VarEntry{ty=ty'})}
                end
        | SOME(typ) =>
            let
                val {exp=initExp,ty=calcTy} = transExp(venv,tenv,init)
                val ty' = transTy(tenv,typ)
            in
                if not(T.equals(ty',calcTy))
                then (Error.error pos "Error: type mismatch at pos: " ^ (Int.toString pos); 
                    {venv=venv,tenv=tenv}
                )
                else {
                    venv=S.enter(venv,name,E.VarEntry{ty=ty'}),
                    tenv=tenv
                }
            end
        (* Nonrecursive TypeDec *)
        | transDec (venv,tenv,A.TypeDec tydecList) =
            let
                fun transTyDec (tenv, {name,ty,pos}) =
                    let
                        val ty' = transTy(tenv,ty)
                    in
                        S.enter(tenv,name,ty')
                    end
            in
                {venv=venv,
                tenv=foldl transTyDec tenv tydecList}
            end
            
        (* Nonrecursive FuncDec *)
        | transDec(venv,tenv, A.FunctionDec fundecList) =
            let
                fun transFunDec ({name,params,body,pos,result}) =
                    let val result_ty = case result of
                                    None => T.UNIT
                                  | SOME(rt,pos) => transTy(tenv,rt);
                        fun transparam{name,escape,typ,pos} =
                            {name=name, ty=transTy(tenv,typ)}
                        val params' = map transparam params
                        val venv' = S.enter(venv,name,
                                    E.FunEntry{formals= map #ty params',
                                            result=result_ty})
                        fun enterparam ({name,ty},venv) =
                                    S.enter(venv,name, E.VarEntry{ty=ty})
                        val venv'' = fold enterparam params' venv'
                        val {exp=_,ty=calcTy} = transExp(venv'',tenv, body)
                    in 
                        if not(T.equals(result_ty,calcTy))(* check bodyType = declared return type *)
                        then (Error.error pos "Error: function bodyType mismatched returnType at pos: " ^ (Int.toString pos); 
                            {venv=venv,tenv=tenv}
                        )
                        else {venv=venv',tenv=tenv}
                    end
            in
                {venv=venv,
                tenv=fold transFunDec tenv fundecList}
            end
            




    fun transProg exp = 
        let val {exp=result, ty=ty}= transExp(E.base_venv,E.base_tenv) exp
        in
            if T.equals(ty,Types.UNIT)
            then ()
            else Error.error 0 "Error: top-level expression does not have type unit"
        end
end

