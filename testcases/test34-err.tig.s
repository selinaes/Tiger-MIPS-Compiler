# ----- emit L1 -----
# ----- translated L1 -----
SEQ(
 LABEL L1,
 MOVE(
  TEMP t106,
  TEMP t102))
# ----- linearize L1 -----
LABEL L1
MOVE(
 TEMP t106,
 TEMP t102)
JUMP(
 NAME L4)
LABEL L4
# ----- Assembly L1 -----
L1:
add t106, t102, $0
j L4 
L4:
L2 : .ascii one 
L3 : .ascii two 
# ----- emit L0 -----
# ----- translated L0 -----
SEQ(
 LABEL L0,
 MOVE(
  TEMP t106,
  CALL(
   NAME exit,
    CONST 1)))
# ----- linearize L0 -----
LABEL L0
MOVE(
 TEMP t106,
 CALL(
  NAME exit,
   CONST 1))
JUMP(
 NAME L5)
LABEL L5
# ----- Assembly L0 -----
L0:
addi t104, $0, 1
add t108, t104, $0
jal exit 
add t106, t106, $0
j L5 
L5:
