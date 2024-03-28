# ----- emit L1 -----
# ----- translated L1 -----
SEQ(
 LABEL L1,
 MOVE(
  TEMP t106,
  ESEQ(
   EXP(
    CALL(
     NAME L2,
      MEM(
       TEMP t100),
      BINOP(PLUS,
       TEMP t102,
       CONST 1))),
   CONST 0)))
# ----- linearize L1 -----
LABEL L1
EXP(
 CALL(
  NAME L2,
   MEM(
    TEMP t100),
   BINOP(PLUS,
    TEMP t102,
    CONST 1)))
MOVE(
 TEMP t106,
 CONST 0)
JUMP(
 NAME L6)
LABEL L6
# ----- Assembly L1 -----
L1:
lw t106, 0(t100)
add t108, t106, $0
addi t107, t102, 1
add t109, t107, $0
jal L2 
addi t108, $0, 0
add t106, t108, $0
j L6 
L6:
L3 : .ascii str 
L4 : .ascii   
# ----- emit L2 -----
# ----- translated L2 -----
SEQ(
 LABEL L2,
 MOVE(
  TEMP t106,
  ESEQ(
   EXP(
    CALL(
     NAME L1,
      MEM(
       TEMP t100),
      CALL(
       NAME exit,
        CONST 1),
      NAME L3)),
   NAME L4)))
# ----- linearize L2 -----
LABEL L2
MOVE(
 TEMP t110,
 MEM(
  TEMP t100))
MOVE(
 TEMP t109,
 CALL(
  NAME exit,
   CONST 1))
EXP(
 CALL(
  NAME L1,
   TEMP t110,
   TEMP t109,
   NAME L3))
MOVE(
 TEMP t106,
 NAME L4)
JUMP(
 NAME L7)
LABEL L7
# ----- Assembly L2 -----
L2:
lw t111, 0(t100)
add t110, t111, $0
addi t112, $0, 1
add t108, t112, $0
jal exit 
add t109, t106, $0
add t108, t110, $0
add t109, t109, $0
la t113, L3
add t110, t113, $0
jal L1 
la t114, L4
add t106, t114, $0
j L7 
L7:
L5 : .ascii str2 
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
    NAME L5)))
# ----- linearize L0 -----
LABEL L0
MOVE(
 TEMP t106,
 CALL(
  NAME L1,
   TEMP t100,
   CONST 0,
   NAME L5))
JUMP(
 NAME L8)
LABEL L8
# ----- Assembly L0 -----
L0:
add t108, t100, $0
addi t115, $0, 0
add t109, t115, $0
la t116, L5
add t110, t116, $0
jal L1 
add t106, t106, $0
j L8 
L8:
