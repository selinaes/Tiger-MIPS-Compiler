# ----- emit L0 -----
# ----- translated L0 -----
SEQ(
 LABEL L0,
 MOVE(
  TEMP t106,
  ESEQ(
   MOVE(
    TEMP t101,
    BINOP(PLUS,
     CALL(
      NAME exit,
       CONST 1),
     CONST 0)),
   TEMP t101)))
# ----- linearize L0 -----
LABEL L0
MOVE(
 TEMP t102,
 CALL(
  NAME exit,
   CONST 1))
MOVE(
 TEMP t101,
 BINOP(PLUS,
  TEMP t102,
  CONST 0))
MOVE(
 TEMP t106,
 TEMP t101)
JUMP(
 NAME L1)
LABEL L1
# ----- Assembly L0 -----
L0:
addi t103, $0, 1
add t108, t103, $0
jal exit 
add t102, t106, $0
addi t104, t102, 0
add t101, t104, $0
add t106, t101, $0
j L1 
L1:
