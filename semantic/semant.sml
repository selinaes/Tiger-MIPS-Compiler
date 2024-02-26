structure Semant :> SEMANTIC =

struct
    structure A = Absyn
    structure S = Symbol
    structure E = Env
    structure T = Types
    structure Error = ErrorMsg

    type expty = {exp: Translate.exp, ty: Types.ty}
    type venv = Env.enventry Symbol.table 
    type tenv = Types.ty Symbol.table

    structure LoopCounter = struct
        val count = ref 0
        fun enter() = (count := !count + 1; !count)
        fun exit() = (count := !count - 1; !count)
        fun reset() = (count := 0)
    end

    fun symToType (tenv, sym, pos) : T.ty= 
        case S.look(tenv,sym) of
        SOME(ty) => ty
        | NONE => (Error.error pos ("Error: undefined type: " ^ S.name sym);
        T.INT)
    
    fun checkint ({exp,ty=T.INT},pos) = ()
    | checkint (_,pos) = Error.error pos ("Error: non-integer provided")
    
    fun checkTwoInts (left, right,pos) = (checkint(left, pos); checkint(right, pos))

    fun checkUnit ({exp,ty=T.UNIT},pos) = ()
    | checkUnit (_,pos) = Error.error pos ("Error: non-unit provided")

    fun checkstr({exp,ty=T.STRING},pos) = ()
    | checkstr(_,pos) = Error.error pos ("Error: non-string provided")
    
    fun checkTwoIntsOrStrs ({exp=_, ty=T.INT}, {exp=_, ty=T.INT}, pos) = ()
    | checkTwoIntsOrStrs({exp=_, ty=T.STRING}, {exp=_, ty=T.STRING}, pos) = ()
    | checkTwoIntsOrStrs(_,_,pos) = Error.error pos ("Error: non-integer or non-string provided using comparison operator")

    fun checkTwoEqTypes ({exp=_, ty=T.INT}, {exp=_, ty=T.INT}, pos) = ()
    | checkTwoEqTypes ({exp=_, ty=T.STRING}, {exp=_, ty=T.STRING}, pos) = ()
    | checkTwoEqTypes ({exp=_, ty=T.RECORD(f1)}, {exp=_, ty=T.RECORD(f2)}, pos) = 
        let val (_, unique1) = f1()
            val (_, unique2) = f2()
        in
            if unique1 = unique2 
            then () 
            else Error.error pos ("Error: comparing two different records at pos: " ^ (Int.toString pos))
        end
    | checkTwoEqTypes ({exp=_, ty=T.NIL}, {exp=_, ty=T.RECORD(_)}, pos) = ()
    | checkTwoEqTypes ({exp=_, ty=T.RECORD(_)}, {exp=_, ty=T.NIL}, pos) = ()
    | checkTwoEqTypes ({exp=_, ty=T.ARRAY(_,unique1)}, {exp=_, ty=T.ARRAY(_,unique2)}, pos) = if unique1 = unique2 then () else Error.error pos ("Error: comparing two different arrays at pos: " ^ (Int.toString pos))
    | checkTwoEqTypes ({exp=_, ty=T.NIL}, {exp=_, ty=T.NIL}, pos) = ()
    | checkTwoEqTypes(_,_,pos) = Error.error pos ("Error: comparing two different types" )

    fun transExp(venv,tenv,exp): expty =
        let 
        fun trop (left,A.PlusOp,right,pos) = (checkTwoInts(trexp left,trexp right,pos);{exp=(),ty=Types.INT})
            |   trop (left,A.MinusOp,right,pos) = (checkTwoInts(trexp left,trexp right,pos);{exp=(),ty=Types.INT})
            |   trop (left,A.TimesOp,right,pos) = (checkTwoInts(trexp left,trexp right,pos);{exp=(),ty=Types.INT})
            |   trop (left,A.DivideOp,right,pos) = (checkTwoInts(trexp left,trexp right,pos);{exp=(),ty=Types.INT})
            |   trop (left,A.EqOp,right,pos) = (checkTwoEqTypes(trexp left,trexp right,pos);{exp=(),ty=Types.INT})
            |   trop (left,A.NeqOp,right,pos) = (checkTwoEqTypes(trexp left,trexp right,pos);{exp=(),ty=Types.INT})
            |   trop (left,A.LtOp,right,pos) = (checkTwoIntsOrStrs(trexp left,trexp right,pos);{exp=(),ty=Types.INT})
            |   trop (left,A.LeOp,right,pos) = (checkTwoIntsOrStrs(trexp left,trexp right,pos);{exp=(),ty=Types.INT})
            |   trop (left,A.GtOp,right,pos) = (checkTwoIntsOrStrs(trexp left,trexp right,pos);{exp=(),ty=Types.INT})
            |   trop (left,A.GeOp,right,pos) = (checkTwoIntsOrStrs(trexp left,trexp right,pos);{exp=(),ty=Types.INT})
            (* | trop _ = {exp=(),ty=Types.INT} *)
        
        and trcall (func,args,pos) = 
            case S.look(venv,func) of 
                SOME(E.FunEntry{formals,result}) => 
                    let fun checkArgs([],[]) = true
                        | checkArgs([],_) = (Error.error pos ("Error: too many arguments"); false)
                        | checkArgs(_,[]) = (Error.error pos ("Error: too few arguments"); false)
                        | checkArgs (formal::formals, arg::args) = 
                            if T.matchType(formal,arg) 
                            then checkArgs(formals,args)
                            else (Error.error pos "Error: argument type mismatch"; false)
                    in  
                        if (length formals) <> (length args)
                        then (Error.error pos ("Error: argument number mismatch"); {exp=(),ty=Types.IMPOSSIBLE})
                        else 
                            if checkArgs(formals, map (fn a => #ty (trexp a)) args)
                            then {exp=(),ty=result}
                            else {exp=(),ty=Types.IMPOSSIBLE}
                    end
                | _ => (Error.error pos ("Error: undefined function"); {exp=(),ty=Types.IMPOSSIBLE})
        
        and trrecord (fields,typ,pos) = 
        (*  field: (symbol * exp * pos)
        A.RecordExp of {fields: (symbol * exp * pos) list,
			typ: symbol, pos: pos}
        T.RECORD of (Symbol.symbol * ty) list * unique
            table -> record typ -> symTyList
            symTyList contains field sym, (symTyList s1.sym = field f1.sym) symTyList s1.ty ?= field f1.exp ty?*)
            case S.look(tenv,typ) of
                SOME(T.RECORD(f1)) =>
                    let 
                        val (symTyList, unique) = f1()
                        fun checkField (sym, exp, pos) =
                            case List.find (fn (tsym,tty) => tsym = sym) symTyList of
                                SOME (tsym,tty) =>
                                    let
                                        val {exp=vexp, ty} = trexp(exp)
                                    in
                                        if T.matchType(tty, ty) 
                                        then ()
                                        else Error.error pos ("Error: field type mismatch")
                                    end
                                | NONE =>
                                    Error.error pos ("Error: missing field at pos")
                in
                        List.app checkField fields;
                        if length fields = length symTyList
                        then
                            {exp=(),ty=T.RECORD(fn () => (symTyList, unique))}
                        else
                            (Error.error pos ("Error: field number mismatch, expe"); {exp=(),ty=Types.IMPOSSIBLE})
                        
                    end
                | _ => (Error.error pos ("Error: undefined record type"); {exp=(),ty=Types.IMPOSSIBLE})

        and trseq (exps) = (
            case exps
            of [] => {exp=(),ty=Types.UNIT}
            | [(exp,pos)] => trexp exp
            | (exp,pos)::rest => (trexp exp; trseq(rest)) )

        and trassign (var,exp,pos) =
         let val {exp=v,ty=vty} = transVar(venv, tenv, var)
                val {exp=e,ty=ety} = trexp exp
            in
               if T.matchType(vty,ety) 
               then ({exp = (), ty = Types.UNIT})
               else (Error.error pos ("Error: type mismatch"); {exp=(),ty=Types.UNIT})
            end

        and trif (test,then',else',pos) = case else' of 
            NONE => 
                let 
                    val {exp, ty} = trexp then'
                in
                    checkint(trexp test, pos);
                    {exp=(),ty=ty}
                end
            | SOME(else') => 
                let val {exp=t,ty} = trexp test
                    val {exp=th,ty=tht} = trexp then'
                    val {exp=el,ty=elt} = trexp else'
                in
                    checkint(trexp test,pos);
                    {exp=(),ty=T.findLUB(tht,elt)}
                end

        and trwhile (test,body,pos) = 
            (checkint(trexp test,pos); 
            LoopCounter.enter();
            checkUnit(trexp body, pos);
            LoopCounter.exit();
            {exp=(),ty=Types.UNIT})
            
        and trfor (var,escape,lo,hi,body,pos) = 
               let val venv' = S.enter(venv,var,E.VarEntry{ty=Types.INT})
                in
                    checkint(trexp lo,pos);
                    checkint(trexp hi,pos);
                    LoopCounter.enter();
                    checkUnit(transExp (venv',tenv,body), pos);
                    LoopCounter.exit();
                    {exp=(),ty=Types.UNIT}
                 end

        
        and trlet (decs,body,pos) = 
            let 
                val {venv=venv',tenv=tenv'} = foldl (fn (dec, {venv=v',tenv=t'}) => transDec (v', t', dec)) {venv=venv, tenv=tenv} decs
            in
                transExp(venv',tenv',body)
            end

        and trarray (typ,size,init,pos) = 
            let
                val {exp=initExp, ty=initTy} = trexp init
                val size' = trexp size
            in
                checkint(size',pos);
                case S.look(tenv,typ) of
                    SOME(T.ARRAY(ty, unique)) =>
                        if T.matchType(ty,initTy)
                        then 
                        (* (print ((S.name typ) ^" " ^  (T.toString ty)^ "\n"); *)
                        {exp=(),ty=T.ARRAY(ty,unique)}
                        else (Error.error pos ("Error: type mismatch"); {exp=(),ty=Types.IMPOSSIBLE})
                    | _ => (Error.error pos ("Error: undefined array type"); {exp=(),ty=Types.IMPOSSIBLE})
            end
        
        and trbreak (pos) = 
            if !LoopCounter.count > 0
            then {exp=(),ty=Types.UNIT}
            else (Error.error pos ("Error: break outside loop");
             {exp=(),ty=Types.IMPOSSIBLE})

        and trexp exp = 
            case exp of 
                A.OpExp{left,oper,right,pos} => trop(left,oper,right,pos)
                | A.VarExp v => transVar (venv, tenv, v)
                | A.NilExp => {exp=(),ty=Types.NIL}
                | A.IntExp i => {exp=(),ty=Types.INT}
                | A.StringExp s => {exp=(),ty=Types.STRING}
                | A.CallExp{func,args,pos} => trcall(func,args,pos)
                | A.RecordExp{fields,typ,pos} => trrecord(fields,typ,pos)
                | A.SeqExp exps => trseq(exps)
                | A.AssignExp{var,exp,pos} => trassign(var,exp,pos)
                | A.IfExp{test,then',else',pos} => trif(test,then',else',pos)
                | A.WhileExp{test,body,pos} => trwhile(test,body,pos)
                | A.ForExp{var,escape,lo,hi,body,pos} => trfor(var,escape,lo,hi,body,pos)
                | A.LetExp{decs,body,pos} => trlet(decs,body,pos)
                | A.ArrayExp{typ,size,init,pos} => trarray(typ,size,init,pos)
                | A.BreakExp pos => trbreak(pos)
        in
            trexp exp
        end
            
    and transVar(venv,tenv,A.SimpleVar(id,pos)): expty = 
                (case S.look(venv,id) of 
                    SOME(E.VarEntry{ty}) =>
                        {exp=(), ty=ty}
                    | _ => (Error.error pos ("Error:undefined variable "^ S.name id);
                                {exp=(), ty=T.INT}))
        | transVar(venv,tenv,A.FieldVar(v,id,pos))  = 
                (case transVar (venv, tenv, v) of
                    {exp = vexp, ty = T.RECORD(f)} =>
                        let
                            val (symbolLst, _) = f()
                            fun findFieldById (id, lst) =
                                case lst of
                                    [] => NONE
                                    | (fieldId, fieldTy) :: rest =>
                                        if id = fieldId then
                                            SOME fieldTy
                                        else
                                            findFieldById (id, rest)
                        in
                            case findFieldById (id, symbolLst) of
                                SOME fieldTy =>
                                    {exp = (), ty = fieldTy}
                                | NONE =>
                                    (Error.error pos ("Error:undefined field " ^ S.name id ^ " in record");
                                    {exp = (), ty = T.INT})
                        end
                    | _ =>
                        (Error.error pos "Error:accessing fields of a non-record type";
                        {exp = (), ty = T.INT}))
        | transVar (venv, tenv, A.SubscriptVar(v,exp,pos)) =  
                (case transVar (venv, tenv, v) of
                    {exp = vexp, ty = T.ARRAY (elementTy,_)} =>
                        let
                            val index = transExp (venv, tenv, exp)
                        in
                            case #ty index of
                                T.INT =>
                                    {exp = (),
                                    ty = elementTy}
                                | _ =>
                                    (Error.error pos "Error:array index must be an integer";
                                    { exp = (),
                                    ty = T.INT })
                        end
                    | {exp = vexp, ty = thety} =>
                        (Error.error pos ("Error:subscripting non-array type" ^ (T.toString thety) );
                        {exp = (), ty = T.INT}))

    and transDec (venv, tenv, A.VarDec{name,escape,typ,init,pos}) = 
        (case typ of 
        (* TODO: check nil *)
            NONE => 
                let 
                    val {exp=_,ty} = transExp(venv,tenv,init)
                in 
                    {tenv=tenv,
                    venv=S.enter(venv,name,E.VarEntry{ty=ty})}
                end
        | SOME(sym,pos) =>
            let
                val {exp=initExp,ty=calcTy} = transExp(venv,tenv,init)
                val typ = symToType (tenv, sym, pos)
            in
                if not(T.matchType(typ,calcTy))
                then (Error.error pos "Error: type mismatch"; 
                    {venv=venv,tenv=tenv})
                else {
                    venv=S.enter(venv,name,E.VarEntry{ty=typ}),
                    tenv=tenv
                }
            end)
                (* Nonrecursive TypeDec *)
        | transDec (venv,tenv,A.TypeDec tydecList) =
            let    
                val allTyName = map (fn {name,ty,pos} => name) tydecList
                val uniqueMap: unit ref S.table ref = ref S.empty
                (* keep track of the refs within the same dec group *)
                fun getOrDefault(sym) = 
                    case S.look(!uniqueMap, sym) of
                        SOME(u) => u
                        | NONE => 
                            let val unique = ref () 
                            in  
                            (* print ("getOrDefault: old ref" ^ S.name sym); *)
                                uniqueMap := S.enter(!uniqueMap, sym, unique);
                                unique
                            end
                fun makeRec (fieldlist): unit -> (Symbol.symbol * T.ty) list * T.unique =
                    let
                        val unique = ref ()
                        fun processFieldList ([]) : (S.symbol * T.ty) list = []
                          | processFieldList ({name,escape,typ,pos} :: rest) = 
                            let
                                val ty = evalType(typ, [], pos)
                            in
                                (* print ("makerec" ^"name: " ^ S.name name ^ " ty: " ^ T.toString ty ^ "\n"); *)
                                (name,ty)::processFieldList(rest)
                            end
                    in
                        fn () => (processFieldList(fieldlist), unique)
                    end
                and evalType(name: S.symbol, visited: S.symbol list, pos): T.ty = 
                    if (List.exists (fn n => name = n) allTyName)
                    then
                        if (List.exists (fn n => name = n) visited)
                        then
                           ( Error.error pos "Error: cycle"; T.IMPOSSIBLE)
                        else 
                            let val ty = #ty (valOf (List.find (fn {name=tyname,ty,pos} => tyname = name) tydecList))
                                (* val () = print ("name: " ^ S.name name ^ " ty: " ^ T.toString ty ^ "\n") *)
                            in
                                case ty of
                                    A.NameTy(sym, pos) => evalType(sym, name::visited, pos)
                                    | A.ArrayTy(sym, pos) => 
                                        let
                                        val t = evalType(sym, name::visited, pos)
                                        in 
                                        (* print ("array name: " ^ S.name name ^ " ty: " ^ T.toString t ^ "\n"); *)
                                        T.ARRAY(t, getOrDefault(name))
                                        end
                                    | A.RecordTy(fieldlist) => T.RECORD(makeRec(fieldlist))
                            end
                    else (* not in group*)
                        case S.look(tenv, name) of
                            SOME(ty) => ty
                            | NONE => (Error.error pos ("Error: undefined type: " ^ S.name name); T.IMPOSSIBLE)
                fun transTyDec ({name,ty,pos}, tenv) =
                    let
                        val ty' = evalType(name, [], pos)
                                    
                    in
                    (* TODO: records with inte *)
                        case ty' of
                            T.RECORD(f) =>
                                let 
                                    val (fields, unique) = f() 
                                    in
                                   ()
                                end 
                            | _ => (); 
                         S.enter(tenv,name,ty')
                    end
                 (* see if name is in this group or not*)
                   (* if not in this group: look in tenv -> done*)
                (* otherwise
                   in visited?  cycle-->error
                   not in visited? what kind of declaration?
                       name -> recurse (and add to visited)
                    Array -> recurse (and add to visited), but then return Array of those
                    Record -> make Record *)
                (* Example of 1 tydec in 1 TypeDec (mutgroup) *)    
                (* "type a = b type b = int" is: makeRec(a) => RECORD(fn() => ([(b* (fn()->makeRec b))] *unique)) *)
                (* " type x = {y:b,z:string, r:s}", tyname=x,cordT () is: makeRec(x) => RECORD (fn() => ([(y, (fn () -> makeRec b)), (z, string)] , unique)) *)
                (* "type c = int" is: makeRec(c) => RECORD (fn() => ([(c,int)] * unique))*)
            in
                {venv=venv,
                tenv=foldl transTyDec tenv tydecList}
          end

        (* Nonrecursive FuncDec *)
        | transDec(venv,tenv, A.FunctionDec fundecList) =
            let
                fun transFunDec ({name,params,result,body,pos}: A.fundec,venv): venv =
                    let val result_ty = case result of
                                    NONE => T.UNIT
                                  | SOME(rt,pos) => symToType (tenv, rt, pos)
                                   
                        fun transparam ({name,escape,typ,pos}:A.field) =
                            {name=name, ty=symToType (tenv,typ, pos)}
                        val params' = map transparam params
                        val venv' = S.enter(venv,name,
                                    E.FunEntry{formals= map #ty params',
                                            result=result_ty})
                        fun enterparam ({name,ty},venv) =
                                    S.enter(venv,name, E.VarEntry{ty=ty})
                        val venv'' = foldl enterparam venv' params' 
                        val {exp=_,ty=calcTy} = transExp(venv'',tenv, body)
                    in 
                        if not(T.matchType(result_ty,calcTy))(* check bodyType = declared return type *)
                        then (Error.error pos "Error: function bodyType mismatched returnType"; 
                            venv
                        )
                        else venv'
                    end
            in
                {venv=foldl transFunDec venv fundecList,
                tenv=tenv}
            end


    fun transProg exp = 
        let val {exp=result, ty=ty}= transExp(E.base_venv,E.base_tenv, exp)
        in
            if T.matchType(Types.UNIT, ty)
            then ()
            else Error.error 0 "Error: top-level expression does not have type unit"
        end
end

