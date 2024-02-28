structure Types =
struct

  type unique = unit ref

  datatype ty = 
    RECORD of unit -> (Symbol.symbol * ty) list * unique 
  | NIL
  | INT
  | STRING
  | ARRAY of ty * unique
  | UNIT
  | IMPOSSIBLE (* bottom of the lattice *)

  fun toString (RECORD _) = "RECORD"
    | toString NIL = "NIL"
    | toString INT = "INT"
    | toString STRING = "STRING"
    | toString (ARRAY _) = "ARRAY"
    | toString UNIT = "UNIT"
    | toString IMPOSSIBLE = "IMPOSSIBLE"


(* exact same *)
  fun equals (RECORD(f1), RECORD(f2)) = 
     let
        val (_, unique1) = f1()
        val (_, unique2) = f2()
      in
       unique1 = unique2 
      end
    | equals (ARRAY(_, unique1), ARRAY(_, unique2)) = unique1 = unique2
    | equals (NIL, ARRAY(_, _)) = true 
    | equals (NIL, NIL) = true
    | equals (INT, INT) = true
    | equals (STRING, STRING) = true
    | equals (UNIT, UNIT) = true
    | equals (IMPOSSIBLE, IMPOSSIBLE) = true
    | equals (t1,t2) =  false
    

  fun findLUB(t1: ty, t2: ty): ty = 
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
    | (RECORD(_), NIL) => t1
    | (ARRAY(_, unique1), ARRAY(_, unique2)) => if unique1 = unique2 then t1 else UNIT
    | (ARRAY(_, _), NIL) => t1 
    | (INT, INT) => t1
    | (STRING, STRING) => t1
    | (NIL, RECORD(f2)) => t2
    | (NIL, ARRAY(_, _)) => t2
    | (NIL, NIL) => t1
    | (_, _) => UNIT


  (* target type, return type *) 
  fun matchType(targetType: ty, returnType: ty): bool = 
    equals(findLUB(targetType, returnType), targetType)

end
