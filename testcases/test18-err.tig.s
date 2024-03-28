# ----- emit L1 -----
# ----- translated L1 -----
SEQ(
 LABEL L1,
 MOVE(
  TEMP t106,
  ESEQ(
   EXP(
    CALL(
     NAME exit,
      CONST 1)),
   CONST 0)))
# ----- linearize L1 -----
LABEL L1
EXP(
 CALL(
  NAME exit,
   CONST 1))
MOVE(
 TEMP t106,
 CONST 0)
JUMP(
 NAME L6)
LABEL L6
# ----- Assembly L1 -----
L1:
addi t107, $0, 1
add t108, t107, $0
jal exit 
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
      TEMP t106,
      NAME L3)),
   NAME L4)))
# ----- linearize L2 -----
LABEL L2
EXP(
 CALL(
  NAME L1,
   MEM(
    TEMP t100),
   TEMP t106,
   NAME L3))
MOVE(
 TEMP t106,
 NAME L4)
JUMP(
 NAME L7)
LABEL L7
# ----- Assembly L2 -----
L2:
lw t109, 0(t100)
add t108, t109, $0
add t109, t106, $0
la t110, L3
add t110, t110, $0
jal L1 
la t111, L4
add t106, t111, $0
j L7 
L7:
L5 : .ascii str2 
# ----- emit L0 -----
# ----- translated L0 -----
SEQ(
 LABEL L0,
 MOVE(
  TEMP t106,
  ESEQ(
   MOVE(
    TEMP t104,
    CONST 0),
   CALL(
    NAME L1,
     TEMP t100,
     CONST 0,
     NAME L5))))
# ----- linearize L0 -----
LABEL L0
MOVE(
 TEMP t104,
 CONST 0)
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
addi t112, $0, 0
add t104, t112, $0
add t108, t100, $0
addi t113, $0, 0
add t109, t113, $0
la t114, L5
add t110, t114, $0
jal L1 
add t106, t106, $0
j L8 
L8:
