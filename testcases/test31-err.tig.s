L1 : .ascii   
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
 NAME L2)
LABEL L2
# ----- Assembly L0 -----
L0:
addi t102, $0, 1
add t108, t102, $0
jal exit 
add t106, t106, $0
j L2 
L2:
