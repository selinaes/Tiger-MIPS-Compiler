# ----- emit L1 -----
# ----- translated L1 -----
SEQ(
 LABEL L1,
 MOVE(
  TEMP t106,
  CALL(
   NAME L2,
    MEM(
     TEMP t100),
    BINOP(PLUS,
     TEMP t102,
     CONST 1))))
# ----- linearize L1 -----
LABEL L1
MOVE(
 TEMP t106,
 CALL(
  NAME L2,
   MEM(
    TEMP t100),
   BINOP(PLUS,
    TEMP t102,
    CONST 1)))
JUMP(
 NAME L5)
LABEL L5
# ----- Assembly L1 -----
L1:
lw t106, 0(t100)
add t108, t106, $0
addi t107, t102, 1
add t109, t107, $0
jal L2 
add t106, t106, $0
j L5 
L5:
L3 : .ascii str 
# ----- emit L2 -----
# ----- translated L2 -----
SEQ(
 LABEL L2,
 MOVE(
  TEMP t106,
  CALL(
   NAME L1,
    MEM(
     TEMP t100),
    TEMP t105,
    NAME L3)))
# ----- linearize L2 -----
LABEL L2
MOVE(
 TEMP t106,
 CALL(
  NAME L1,
   MEM(
    TEMP t100),
   TEMP t105,
   NAME L3))
JUMP(
 NAME L6)
LABEL L6
# ----- Assembly L2 -----
L2:
lw t108, 0(t100)
add t108, t108, $0
add t109, t105, $0
la t109, L3
add t110, t109, $0
jal L1 
add t106, t106, $0
j L6 
L6:
L4 : .ascii str2 
# ----- emit L0 -----
# ----- translated L0 -----
SEQ(
 LABEL L0,
 MOVE(
  TEMP t106,
  CALL(
   NAME L1,
    TEMP t100,
    CONST 0,
    NAME L4)))
# ----- linearize L0 -----
LABEL L0
MOVE(
 TEMP t106,
 CALL(
  NAME L1,
   TEMP t100,
   CONST 0,
   NAME L4))
JUMP(
 NAME L7)
LABEL L7
# ----- Assembly L0 -----
L0:
add t108, t100, $0
addi t110, $0, 0
add t109, t110, $0
la t111, L4
add t110, t111, $0
jal L1 
add t106, t106, $0
j L7 
L7:
