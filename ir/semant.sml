structure Semant :> SEMANTIC =

struct
    structure A = Absyn
    structure S = Symbol
    structure E = Env
    structure T = Types
    structure Error = ErrorMsg
    structure TS = Translate

    type expty = {exp: TS.exp, ty: Types.ty}
    type venv = Env.enventry Symbol.table 
    type tenv = Types.ty Symbol.table

    structure LoopCounter = struct
        val count = ref 0
        fun enter() = (count := !count + 1; !count)
        fun exit() = (count := !count - 1; !count)
        fun reset() = (count := 0)
    end

    fun symToType (tenv, sym, pos) : T.ty = 
        case S.look(tenv,sym) of
        SOME(ty) => ty
        | NONE => (Error.error pos ("Error: undefined type: " ^ S.name sym);
        T.IMPOSSIBLE)
    
    fun checkint ({exp,ty=T.INT},pos) = ()
    | checkint (_,pos) = Error.error pos ("Error: non-integer provided")
    
    fun checkTwoInts (left, right,pos) = (checkint(left, pos); checkint(right, pos))

    fun checkUnit (expty: expty,pos) = 
        if T.matchType(T.UNIT, #ty expty)
        then ()
        else Error.error pos ("Error: non-unit provided")

    fun checkstr({exp,ty=T.STRING},pos) = ()
    | checkstr(_,pos) = Error.error pos ("Error: non-string provided")
    
    fun checkTwoIntsOrStrs ({exp=_, ty=T.INT}, {exp=_, ty=T.INT}, pos) = ()
    | checkTwoIntsOrStrs({exp=_, ty=T.STRING}, {exp=_, ty=T.STRING}, pos) = ()
    | checkTwoIntsOrStrs(_,_,pos) = Error.error pos ("Error: non-integer or non-string provided using comparison operator")

     fun checkTwoEqTypes ({exp=_, ty=t1}, {exp=_, ty=t2}, pos) = 
        if T.matchType(t1,t2)
        then ()    
        else ErrorMsg.error pos ("Comparison of incompatible types. Comparing " ^ T.toString t1 ^ ", " ^ T.toString t2) ;

    fun transExp(venv,tenv,level,exp, doneLbl): expty =
        let 
            val left' = trexp left
            val right' = trexp right
            val leftExp = #exp left'
            val rightExp = #exp right'
            fun trop (left,A.PlusOp,right,pos) = (checkTwoInts(left', right',pos); {exp=TS.binOpIR(Tree.PLUS, leftExp, rightExp),ty=Types.INT})
                |   trop (left,A.MinusOp,right,pos) = (checkTwoInts(left', right',pos); {exp=TS.binlop(Tree.MINUS, leftExp, rightExp),ty=Types.INT})
                |   trop (left,A.TimesOp,right,pos) = (checkTwoInts(left', right',pos); {exp=TS.binlop(Tree.MUL, leftExp, rightExp),ty=Types.INT})
                |   trop (left,A.DivideOp,right,pos) = (checkTwoInts(left', right',pos); {exp=TS.binlop(Tree.DIV, leftExp, rightExp),ty=Types.INT})
                |   trop (left,A.EqOp,right,pos) = (checkTwoEqTypes(left', right', pos); {exp=TS.relop(Tree.EQ, leftExp, rightExp),ty=Types.INT})
                |   trop (left,A.NeqOp,right,pos) = (checkTwoEqTypes(left', right', pos); {exp=TS.relop(Tree.NE, leftExp, rightExp),ty=Types.INT})
                |   trop (left,A.LtOp,right,pos) = (checkTwoIntsOrStrs(left', right', pos); {exp=TS.relop(Tree.LT, leftExp, rightExp),ty=Types.INT})
                |   trop (left,A.LeOp,right,pos) = (checkTwoIntsOrStrs(left', right', pos); {exp=TS.relop(Tree.LE, leftExp, rightExp),ty=Types.INT})
                |   trop (left,A.GtOp,right,pos) = (checkTwoIntsOrStrs(left', right', pos); {exp=TS.relop(Tree.GT, leftExp, rightExp),ty=Types.INT})
                |   trop (left,A.GeOp,right,pos) = (checkTwoIntsOrStrs(left', right', pos); {exp=TS.relop(Tree.GE, leftExp, rightExp),ty=Types.INT})
        
        and trcall (func,args,pos) = 
            case S.look(venv,func) of 
                SOME(E.FunEntry{level=definedLevel,label,formals,result}) => 
                    let val args' = map (fn a => trexp a) args
                        fun checkArgs([],[]) = true
                        | checkArgs([],_) = (Error.error pos ("Error: too many arguments"); false)
                        | checkArgs(_,[]) = (Error.error pos ("Error: too few arguments"); false)
                        | checkArgs (formal::formals, arg::args) = 
                            if T.matchType(formal, arg) 
                            then checkArgs(formals, args)
                            else (Error.error pos "Error: argument type mismatch"; false)
                    in  
                        if (length formals) <> (length args)
                        then (Error.error pos ("Error: argument number mismatch"); {exp=TS.dummy,ty=Types.IMPOSSIBLE})
                        else 
                            if checkArgs(formals, map (fn a => #ty a) args')
                            then {exp=TS.callIR(label, map (fn a => #exp a) args', definedLevel, level),ty=result}
                            else {exp=TS.dummy, ty=Types.IMPOSSIBLE}
                    end
                | _ => (Error.error pos ("Error: undefined function: " ^ S.name func); {exp=TS.dummy,ty=Types.IMPOSSIBLE})
        
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
                            {exp=TS.recCreateIR(map (fn fld => #exp (trexp #2 fld)) fields), ty=T.RECORD(fn () => (symTyList, unique))}
                        else
                            (Error.error pos ("Error: field number mismatch, expe"); {exp=TS.dummy,ty=Types.IMPOSSIBLE})
                        
                    end
                | _ => (Error.error pos ("Error: undefined record type"); {exp=TS.dummy,ty=Types.IMPOSSIBLE})
        
        and trseq (exps) =  (* A.exp list -> {exp=TS.exp list,ty=last expr ty} *)
            case exps of [] => {exp=[],ty=Types.UNIT}
                    | [exp] => trexp exp (* only 1,return {exp,ty}, ty=exp's evaluated ty*)
                    | exps => 
                        let
                            val last = List.last exps
                            val exptyLast = trexp last
                            val front = List.take(exp, length exps - 1)
                            val expfront = map (fn ex => #exp (trexp ex)) front
                        in
                            {exp=expfront@[#exp exptyLast],ty=(#ty exptyLast)}
                        end


        and trassign (var,exp,pos) =
            let val {exp=vloc,ty=vty} = transVar(venv, tenv, var)
                val {exp=e,ty=ety} = trexp exp
            in
               if T.matchType(vty,ety) 
               then ({exp = TS.assignIR(vloc,exp), ty = Types.UNIT})
               else (Error.error pos ("Error: type mismatch"); {exp=TS.dummy,ty=Types.IMPOSSIBLE})
            end

        and trif (test, then', else', pos) = case else' of 
            NONE => 
                let 
                    val {exp=t, ty=testty} = trexp test
                    val {exp=e, ty} = trexp then'
                in
                    T.matchType(T.INT, testty);
                    {exp=TS.transIfThen(t, e), ty=T.UNIT} (* equivlent to findLUB(unit, ty)*)
                end
            | SOME(else') => 
                let val {exp=t,ty=testty} = trexp test
                    val {exp=th,ty=tht} = trexp then'
                    val {exp=el,ty=elt} = trexp else'
                in
                    T.matchType(T.INT,testty);
                    {exp=(TS.ifThenElseIR(t, th, el)),ty=T.findLUB(tht,elt)}
                end

        and trwhile (test,body,pos) = 
        let
            val breakpoint = Temp.newlabel()
            val test' = trexp test
            val body' = trexp body
        in
            (checkint(trexp test',pos); 
            LoopCounter.enter();
            checkUnit(trexp body', pos);
            LoopCounter.exit();
            {exp=TS.whileIR(#exp test', #exp body', breakpoint),ty=Types.UNIT})
        end
            
        and trfor (var,escape,lo,hi,body,pos) = 
               let
                    val breakpoint = Temp.newlabel()
                    val varaccess = TS.allocLocal(level, !escape)
                    val venv' = S.enter(venv,var,E.VarEntry{access=varaccess,ty=Types.INT}) 
                    val varloc = TS.simpleVar(varaccess,level)
               in
                    checkint(trexp lo,pos);
                    checkint(trexp hi,pos);
                    LoopCounter.enter();
                    checkUnit(transExp(venv', tenv, level, body, breakpoint), pos);
                    LoopCounter.exit();
                    {exp=TS.transFor(varloc,lo,hi,body),ty=Types.UNIT}
               end

        
        and trlet (decs,body,pos) = 
            let 
                val {venv=venv',tenv=tenv',explist=explist'} = foldl (fn (dec, {venv=v',tenv=t',explist = e'}) => transDec (v', t', e', level, dec)) {venv=venv, tenv=tenv, explist=[]} decs
                val {exp,ty} = transExp(venv',tenv',level,body,doneLbl)
            in
                {exp=TS.transLet(explist',body),ty=ty}
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
                        {exp=TS.arrayCreateIR(size', initExp),ty=T.ARRAY(ty,unique)}
                        else (Error.error pos ("Error: type mismatch"); {exp=TS.dummy,ty=Types.IMPOSSIBLE})
                    | _ => (Error.error pos ("Error: undefined array type"); {exp=TS.dummy,ty=Types.IMPOSSIBLE})
            end
        
        and trbreak (pos) = 
            if !LoopCounter.count > 0
            then {exp=TS.dummy,ty=Types.UNIT}
            else (Error.error pos ("Error: break outside loop");
             {exp=TS.breakIR(doneLbl),ty=Types.IMPOSSIBLE})

        and trexp exp: expty = 
            case exp of 
                A.OpExp{left,oper,right,pos} => trop(left,oper,right,pos)
                | A.VarExp v => transVar (venv, tenv, v)
                | A.NilExp => {exp=TS.nilIR(),ty=Types.NIL}
                | A.IntExp i => {exp=TS.intIR(i),ty=Types.INT}
                | A.StringExp s => {exp=TS.stringIR(s),ty=Types.STRING}
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
            
    and transVar(venv,tenv,level, A.SimpleVar(id,pos)): expty = 
                (case S.look(venv,id) of 
                    SOME(E.VarEntry{access, ty}) =>
                        {exp=TS.simpleVar(access,level), ty=ty}
                    | _ => (Error.error pos ("Error: undefined variable " ^ S.name id);
                                {exp=TS.dummy, ty=T.IMPOSSIBLE}))
        | transVar(venv,tenv,level,A.FieldVar(v,id,pos))  = 
                (case transVar (venv, tenv, v) of
                    {exp = vexp, ty = T.RECORD(f)} =>
                        let
                            val (symbolLst, _) = f()
                            fun findFieldById (id, lst, offset) =
                                case lst of
                                    [] => NONE
                                    | (fieldId, fieldTy) :: rest =>
                                        if id = fieldId then
                                            SOME (fieldTy, offset)
                                        else
                                            findFieldById (id, rest, offset + 1)
                        in
                            case findFieldById (id, symbolLst, 0) of
                                SOME (fieldTy, offset) =>
                                    {exp = (TS.fieldVar(vexp, offset)), ty = fieldTy}
                                | NONE =>
                                    (Error.error pos ("Error: undefined field " ^ S.name id ^ " in record");
                                    {exp = (), ty = T.IMPOSSIBLE})
                        end
                    | _ =>
                        (Error.error pos "Error:accessing fields of a non-record type";
                        {exp = (), ty = T.IMPOSSIBLE}))
        | transVar (venv, tenv, level, A.SubscriptVar(v,exp,pos)) =  
                (case transVar (venv, tenv, v) of
                    {exp = vexp, ty = T.ARRAY (elementTy,_)} =>
                        let
                            val index = transExp (venv, tenv, level, exp, doneLbl)
                        in
                            case #ty index of
                                T.INT =>
                                    {exp = TS.subscriptVar(vexp, #exp index),
                                    ty = elementTy}
                                | _ =>
                                    (Error.error pos "Error:array index must be an integer";
                                    { exp = (),
                                    ty = T.IMPOSSIBLE })
                        end
                    | {exp = vexp, ty = thety} =>
                        (Error.error pos ("Error:subscripting non-array type: " ^ (T.toString thety) );
                        {exp = (), ty = T.IMPOSSIBLE}))

    and transDec (venv, tenv, explist, level, A.VarDec{name,escape,typ,init,pos}) = 
        (case typ of 
            NONE => 
                let 
                    val {exp,ty} = transExp(venv,tenv,level,init,doneLbl)
                    val access = TS.allocLocal level !escape
                in 
                    case ty of
                        T.NIL => (Error.error pos "Error: nil cannot be used without type annotation"; {venv=venv,tenv=tenv})
                        | _ =>  {tenv=tenv,
                                venv=S.enter(venv,name,E.VarEntry{access=access, ty=ty})
                                explist=explist@[exp]}
                end
            | SOME(sym,pos) =>
                let
                    val {exp=initExp,ty=calcTy} = transExp(venv,tenv,level,init,doneLbl)
                    val access = TS.allocLocal level !escape
                    val typ = symToType (tenv, sym, pos)
                in
                    if not(T.matchType(typ,calcTy))
                    then (Error.error pos "Error: type mismatch"; 
                        {venv=venv,tenv=tenv,exp=TS.CONST 0})
                    else {
                        venv=S.enter(venv,name,E.VarEntry{access=access, ty=typ}),
                        tenv=tenv,
                        explist=explist@[initExp]
                    }
                end)
        (* Nonrecursive TypeDec *)  
        | transDec (venv,tenv, explist,level,A.TypeDec tydecList) =
            let    
                val allTyName = map (fn {name,ty,pos} => name) tydecList
                val uniqueMap: unit ref S.table ref = ref S.empty
                val definedType: S.symbol list ref = ref []
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
                fun makeRec (name, fieldlist): unit -> (Symbol.symbol * T.ty) list * T.unique =
                    let
                        val unique = getOrDefault(name)
                        fun processFieldList ([]) : (S.symbol * T.ty) list = []
                          | processFieldList ({name,escape,typ,pos} :: rest) = 
                            let
                                val ty = evalType(typ, [], pos)
                            in
                                (name, ty)::processFieldList(rest)
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
                                    | A.RecordTy(fieldlist) => T.RECORD(makeRec(name, fieldlist))
                            end
                    else (* not in group*)
                        case S.look(tenv, name) of
                            SOME(ty) => ty
                            | NONE => (Error.error pos ("Error: undefined type in record type: " ^ S.name name); T.IMPOSSIBLE)
                    
                fun transTyDec ({name,ty,pos}, tenv) =
                    let
                        val ty' = evalType(name, [], pos)
                    in
                    (* check error-inte case, prevent undefined type in record *)
                        case List.exists (fn (n) => n = name) (!definedType) of
                            true => Error.error pos ("Error: redefined type: " ^ S.name name)
                            |false =>   case ty' of
                                        T.RECORD(f) => (f(); ())
                                        | _ => (); 
                                    definedType := name :: !definedType;
                                    S.enter(tenv, name, ty')
                                   

                    end
                
            in
                {venv=venv,
                tenv=foldl transTyDec tenv tydecList,
                explist=explist}
          end

        (* Nonrecursive FuncDec *)
        | transDec(venv,tenv, explist, level, A.FunctionDec fundecList) =
            let
                
                val allFunName = map (fn {name,params,result,body,pos} => name) fundecList
                val definedFun: S.symbol list ref = ref []
                (* this is to prepare a temp venv that only contains signature of the functions in a group *)
                fun addAllHeaderToEnv(fundecList): venv = 
                    let
                        fun addHeaderToEnv({name,params,result,body,pos}, venv: venv) = 
                            let 
                                val result_ty = case result of
                                    NONE => T.UNIT
                                  | SOME(rt,pos) => symToType (tenv, rt, pos)
                                fun transparam ({name,escape,typ,pos}: A.field) =
                                {name=name, ty=symToType (tenv, typ, pos)}
                                val params' = map transparam params
                                 (* val level' = TR.newLevel(level, name, map #escape params') *)
                                 (* level is is a dummy value for temp venv *)
                                val venv' = S.enter(venv,name,
                                            E.FunEntry{level=level,label=TE.newlabel(), formals= map #ty params',
                                                    result=result_ty})
                            in
                               
                                venv' (*venv'' FunEntry, all params*)
                            end
                    in
                        foldl addHeaderToEnv venv fundecList
                    end
                

                (* temp_venv only contains signature of the function in a group, this is for recursive call validation checking only. *)
                val temp_venv = addAllHeaderToEnv(fundecList) 
                fun transFunDec ({name,params,result,body,pos}: A.fundec, venv): venv =
                    let 
                        val result_ty = case result of
                                    NONE => T.UNIT
                                  | SOME(rt,pos) => symToType (tenv, rt, pos)
                       
                        fun transparam ({name,escape,typ,pos}: A.field) =
                            {name=name, ty=symToType (tenv,typ, pos), escape=escape}
                        val params' = map transparam params
                        val level' = TS.newLevel(level, name, map #escape params')
                        val formalsList = TS.formals level' (* [sl, 1stformal, 2ndformal]*)
                        fun enterparam ({name,ty,escape}, (venv, index)) =
                                (S.enter(venv,name, E.VarEntry{access=List.nth(formalsList, 1), ty=ty}), index + 1)
                        val (venv'', _) = foldl enterparam (temp_venv, 1) params' 
                        val {exp=exp',ty=calcTy} = transExp(venv'',tenv, level', body,doneLbl)
                    in 
                        case List.exists (fn (n) => n = name) (!definedFun) of
                            true => (Error.error pos ("Error: redefined function: " ^ S.name name); venv)
                            | false => 
                                TS.procEntryExit(level', exp');
                                if not (T.matchType(result_ty,calcTy))(* check bodyType = declared return type *)
                                then (Error.error pos "Error: function bodyType mismatched returnType"; 
                                    venv
                                )
                                else (definedFun := name :: !definedFun;
                                    S.enter(venv,name,E.FunEntry{level=level', label=TE.newlabel (), formals=map #ty params',result=result_ty}))
                    end
            in
                {venv=foldl transFunDec venv fundecList,
                tenv=tenv,
                explist=explist}
            end


    fun transProg exp = 
        let 
            val startLabel = Temp.newlabel()
            val startLevel = TS.newLevel(TS.outermost, startLabel, [])
            val {exp=result, ty=ty}= transExp(E.base_venv,E.base_tenv, startLevel, exp, startLabel)
        in
            if T.matchType(Types.UNIT, ty)
            then (TS.procEntryExit(startLevel, result); TS.getResult())
            else Error.error 0 "Error: top-level expression does not have type unit"
        end
end

