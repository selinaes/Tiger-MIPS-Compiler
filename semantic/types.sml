structure Types =
struct

  type unique = unit ref

  datatype ty = 
    RECORD of unit -> (Symbol.symbol * ty) list * unique (*{a:int, b: string, c: int}*)
  | NIL
  | INT
  | STRING
  | ARRAY of ty * unique
  (* | NAME of Symbol.symbol * ty option ref *)
  | UNIT
  | IMPOSSIBLE (* bottom of the lattice *)

  (* return ty *)
  fun findLUB(t1,t2): ty = 
  case (t1,t2) of
    (_, IMPOSSIBLE) => t1
  | (IMPOSSIBLE, _) => t2
  | (RECORD(f1), RECORD(f2)) => 
      let
      val (_, unique1) = f1()
      val (_, unique2) = f2()
      in
      if unique1 = unique2 then t1 else UNIT
      end
  (* | (RECORD, RECORD(_, unique2)) => if unique1 = unique2 then t1 else UNIT *)
  (* | (RECORD(_, _), NIL) => t1 *)
  | (RECORD(_), NIL) => t1
  | (ARRAY(f1), ARRAY(f2)) => 
      let
      val (_, unique1) = f1
      val (_, unique2) = f2
      in
      if unique1 = unique2 then t1 else UNIT
      end
  | (ARRAY(f1), NIL) => #2 f1()
  (* | (ARRAY(_, unique1), ARRAY(_, unique2)) => if unique1 = unique2 then t1 else UNIT *)
  (* | (ARRAY(_, _), NIL) => t1 *)
  (* | (ARRAY(_, unique1), ARRAY(_, unique2)) => if unique1 = unique2 then t1 else UNIT
  | (ARRAY(_, _), NIL) => t1 *)
  | (INT, INT) => t1
  | (STRING, STRING) => t1
  | (NIL, RECORD(f2, _)) => #2 f2()
  | (NIL, ARRAY(f2, _)) => #2 f2()
  | (NIL, NIL) => t1
  | (_, _) => UNIT


  (* target type, return type *) 
  fun matchType(targetType, returnType): bool = 
    findLUB(targetType, returnType) = targetType
  


(* unit to any other is false, impossible to any other is true *)
  fun equals (RECORD(_, unique1), RECORD(_, unique2)) = unique1 = unique2
    | equals (RECORD(_, _), NIL) = true
    | equals (NIL, RECORD(_, _)) = true
    | equals (ARRAY(_, unique1), ARRAY(_, unique2)) = unique1 = unique2
    | equals (ARRAY(_, _), NIL) = true
    | equals (NIL, ARRAY(_, _)) = true
    | equals (NIL, NIL) = true
    | equals (INT, INT) = true
    | equals (STRING, STRING) = true
    | equals (UNIT, UNIT) = true
    | equals (IMPOSSIBLE, _) = true
    | equals (_, IMPOSSIBLE) = true
    | equals _ = false
end
(* "type a = b", name=a, ty=A.nameTy(b) is: makeRec(a) => RECORD(fn() => ((b* (fn()->makeRec b)) *unique)) *)
(* "type x = {y:b,z:string}", tyname=x, ty=A.recordT () is: makeRec(x) => RECORD (fn() => ([(y, (fn () -> makeRec b)), (z, string)] , unique)) *)
(* fun transTyDec (tenv, A.TypeDec tydecList) =
  let
    val unique = ref ()
    val allTyName: S.symbol list = map (fn {name,ty,pos} => name) tydecList
    fun getTypeByName (n: Symbol.symbol):T.ty = 
      case (find (fn {name,ty,pos} => n = name) tydecList) of
        SOME {name,ty,pos} => ty
        | NONE => Error.error pos "Error: undefined type name"
    fun makeRec name: () -> (Symbol.symbol * ty) list * unique = fn () =>
    let val fieldList: (Symbol.symbol * ty) list = ref []
        fun addToFieldList (fieldname, ty) = fieldList := (fieldname, ty) :: !fieldList
    in
     case (find (fn tyName => tyName = name) allTyName) of
          (* found mutually recurse *)
          SOME foundName => (addToFieldList(tySym, RECORD (fn () => (tenv, transTy (getTypeByName foundName)))))
          (* found in outside tenv *)
          | NONE =>  
            case S.look(tenv,ty) of
              SOME(ty) => addToFieldList(fieldname, ty)
                  NONE => Error.error pos "Error: undefined type name"
      fn () => (!fieldList, unique)
      end
  in
    List.app (fn {name,ty,pos} => S.enter(tenv, name, RECORD(makeRec name))) tydecList
  end

  fun transFunDec (tenv, A.FunctionDec fundecList) = ()

  fun transTy (tenv, ty: A.ty) = 
   let 
      val absynTySymLst: (* name, typ *) (T.symbol * T.symbol) list =
                case ty of
                    A.NameTy(absynTySym,pos) => [(absynTySym, absynTySym)]
                    | A.RecordTy(fields) => 
                        map (fn {name,escape,typ,pos} => (name, typ)) fields
                    | A.ArrayTy(absynTySym,pos) => [(absynTySym, absynTySym)]
    in

    end *)
