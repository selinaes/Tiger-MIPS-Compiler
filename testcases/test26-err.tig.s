L1 : .ascii var 
# ----- emit L0 -----
# ----- translated L0 -----
SEQ(
 LABEL L0,
 MOVE(
  TEMP t106,
  BINOP(PLUS,
   CONST 3,
   NAME L1)))
# ----- linearize L0 -----
LABEL L0
MOVE(
 TEMP t106,
 BINOP(PLUS,
  CONST 3,
  NAME L1))
JUMP(
 NAME L2)
LABEL L2
# ----- Assembly L0 -----
L0:
la t102, L1
addi t101, t102, 3
add t106, t101, $0
j L2 
L2:
