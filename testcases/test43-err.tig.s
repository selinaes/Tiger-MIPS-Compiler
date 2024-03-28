# ----- emit L0 -----
# ----- translated L0 -----
SEQ(
 LABEL L0,
 MOVE(
  TEMP t106,
  ESEQ(
   MOVE(
    TEMP t101,
    CONST 0),
   BINOP(PLUS,
    TEMP t101,
    CONST 3))))
# ----- linearize L0 -----
LABEL L0
MOVE(
 TEMP t101,
 CONST 0)
MOVE(
 TEMP t106,
 BINOP(PLUS,
  TEMP t101,
  CONST 3))
JUMP(
 NAME L1)
LABEL L1
# ----- Assembly L0 -----
L0:
addi t102, $0, 0
add t101, t102, $0
addi t103, t101, 3
add t106, t103, $0
j L1 
L1:
