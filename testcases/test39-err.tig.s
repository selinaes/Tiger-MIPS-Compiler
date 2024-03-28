# ----- emit L2 -----
# ----- translated L2 -----
SEQ(
 LABEL L2,
 MOVE(
  TEMP t106,
  TEMP t104))
# ----- linearize L2 -----
LABEL L2
MOVE(
 TEMP t106,
 TEMP t104)
JUMP(
 NAME L3)
LABEL L3
# ----- Assembly L2 -----
L2:
add t106, t104, $0
j L3 
L3:
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
 NAME L4)
LABEL L4
# ----- Assembly L0 -----
L0:
addi t105, $0, 0
add t106, t105, $0
j L4 
L4:
