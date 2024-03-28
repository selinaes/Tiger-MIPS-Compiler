# ----- emit L0 -----
# ----- translated L0 -----
SEQ(
 LABEL L0,
 MOVE(
  TEMP t106,
  CONST 0))
# ----- linearize L0 -----
LABEL L0
MOVE(
 TEMP t106,
 CONST 0)
JUMP(
 NAME L1)
LABEL L1
# ----- Assembly L0 -----
L0:
addi t101, $0, 0
add t106, t101, $0
j L1 
L1:
