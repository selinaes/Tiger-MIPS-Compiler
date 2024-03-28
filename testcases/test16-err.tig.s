L1 : .ascii  
# ----- emit L0 -----
# ----- translated L0 -----
SEQ(
 LABEL L0,
 MOVE(
  TEMP t106,
  NAME L1))
# ----- linearize L0 -----
LABEL L0
MOVE(
 TEMP t106,
 NAME L1)
JUMP(
 NAME L2)
LABEL L2
# ----- Assembly L0 -----
L0:
la t101, L1
add t106, t101, $0
j L2 
L2:
