signature TREE = 
sig 
  type label = Temp.label
  type size

datatype stm = SEQ of stm * stm
             | LABEL of label
             | JUMP of exp * label list
             | CJUMP of relop * exp * exp * label * label
	           | MOVE of exp * exp
             | EXP of exp

     and exp = BINOP of binop * exp * exp
             | MEM of exp
             | TEMP of Temp.temp
             | ESEQ of stm * exp
             | NAME of label
             | CONST of int
	           | CALL of exp * exp list

      and binop = PLUS | MINUS | MUL | DIV 
                | AND | OR | LSHIFT | RSHIFT | ARSHIFT | XOR

      and relop = EQ | NE | LT | GT | LE | GE 
	        | ULT | ULE | UGT | UGE

  val notRel : relop -> relop
  val binopToStr : binop -> string
  val seq : stm list -> stm
  (* val commute: relop -> relop *)
end

structure Tree : TREE = 
struct
  type label=Temp.label
  type size = int

datatype stm = SEQ of stm * stm
             | LABEL of label
             | JUMP of exp * label list
             | CJUMP of relop * exp * exp * label * label
	           | MOVE of exp * exp (* (loc, e) - evaluate e, store to loc*)
             | EXP of exp

     and exp = BINOP of binop * exp * exp
             | MEM of exp
             | TEMP of Temp.temp
             | ESEQ of stm * exp
             | NAME of label
             | CONST of int
	           | CALL of exp * exp list

      and binop = PLUS | MINUS | MUL | DIV 
                | AND | OR | LSHIFT | RSHIFT | ARSHIFT | XOR

      and relop = EQ | NE | LT | GT | LE | GE 
	        | ULT | ULE | UGT | UGE

  fun binopToStr PLUS = "PLUS"
    | binopToStr MINUS = "MINUS"
    | binopToStr MUL = "MUL"
    | binopToStr DIV = "DIV"
    | binopToStr AND = "AND"
    | binopToStr OR = "OR"
    | binopToStr LSHIFT = "LSHIFT"
    | binopToStr RSHIFT = "RSHIFT"
    | binopToStr ARSHIFT = "ARSHIFT"
    | binopToStr XOR = "XOR"

  
  fun seq [s] = s
      | seq (s::ss) = SEQ(s, seq ss)
      | seq [] = EXP(CONST 0) 

  fun notRel(opr: relop) : relop = 
    (case opr of
      EQ => NE
      | NE => EQ
      | LT => GE
      | GT => LE
      | LE => GT
      | GE => LT
      | ULT => UGE
      | ULE => UGT
      | UGE => ULT
      | UGT => ULE )

end

