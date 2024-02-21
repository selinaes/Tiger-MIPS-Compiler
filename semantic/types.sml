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



(* unit to any other is false, impossible to any other is true *)
  fun equals (RECORD(_, unique1), Record(_, unique2)) = unique1 = unique2
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

