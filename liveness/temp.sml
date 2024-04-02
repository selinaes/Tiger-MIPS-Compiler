(* make this an abstraction sometime *)
structure Temp : TEMP =
struct
    type temp = int
    val temps = ref 100
    fun newtemp() = let val t = !temps  in temps := t+1; t end
    (* 100-131 are the 32 named registers in Frame, this reset only used between tests *)
    fun resetTemp() = temps := 132 
    fun getTemps() = !temps
    structure Table = IntMapTable(type key = int
				  fun getInt n = n)

    fun makestring t = "t" ^ Int.toString t

  type label = Symbol.symbol

local structure F = Format
      fun postinc x = let val i = !x in x := i+1; i end
      fun resetLocal x = x := 0
      val labs = ref 0
 in
    fun resetLabs() = (resetLocal labs; resetTemp())
    fun newlabel() = Symbol.symbol(F.format "L%d" [F.INT(postinc labs)])
    val namedlabel = Symbol.symbol
end


end
