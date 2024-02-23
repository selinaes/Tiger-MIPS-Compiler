structure Types =
struct

  type unique = unit ref

  datatype ty = 
    RECORD of (Symbol.symbol * ty) list * unique
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
  | (RECORD(_, unique1), RECORD(_, unique2)) => if unique1 = unique2 then t1 else UNIT
  | (RECORD(_, _), NIL) => t1
  | (ARRAY(_, unique1), ARRAY(_, unique2)) => if unique1 = unique2 then t1 else UNIT
  | (ARRAY(_, _), NIL) => t1
  | (INT, INT) => t1
  | (STRING, STRING) => t1
  | (NIL, RECORD(_, _)) => t2
  | (NIL, ARRAY(_, _)) => t2
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

