signature TEMP = 
sig
  eqtype temp
  val newtemp : unit -> temp
  val resetTemp : unit -> unit
  structure Table : TABLE sharing type Table.key = temp
  val makestring: temp -> string
  type label = Symbol.symbol
  val newlabel : unit -> label
  val namedlabel : string -> label
  val resetLabs : unit -> unit
end

