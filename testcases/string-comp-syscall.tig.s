L1 : .ascii a 
L2 : .ascii b 
# ----- emit L0 -----
# ----- translated L0 -----
SEQ(
 LABEL L0,
 MOVE(
  TEMP t106,
  CALL(
   NAME stringGt,
    NAME L1,
    NAME L2)))
# ----- linearize L0 -----
LABEL L0
MOVE(
 TEMP t106,
 CALL(
  NAME stringGt,
   NAME L1,
   NAME L2))
JUMP(
 NAME L3)
LABEL L3
# ----- Assembly L0 -----
L0:
la t101, L1
add t108, t101, $0
la t102, L2
add t109, t102, $0
jal stringGt 
add t106, t106, $0
j L3 
L3:
