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
 NAME L2)
LABEL L2
# ----- Assembly L1 -----
L1:
add t106, t102, $0
j L2 
L2:
# ----- emit L0 -----
# ----- translated L0 -----
SEQ(
 LABEL L0,
 MOVE(
  TEMP t106,
  CALL(
   NAME L1,
    TEMP t100,
    CONST 2)))
# ----- linearize L0 -----
LABEL L0
MOVE(
 TEMP t106,
 CALL(
  NAME L1,
   TEMP t100,
   CONST 2))
JUMP(
 NAME L3)
LABEL L3
# ----- Assembly L0 -----
L0:
add t108, t100, $0
addi t103, $0, 2
add t109, t103, $0
jal L1 
add t106, t106, $0
j L3 
L3:
