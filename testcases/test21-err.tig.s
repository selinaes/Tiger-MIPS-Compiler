# ----- emit L1 -----
# ----- translated L1 -----
SEQ(
 LABEL L1,
 MOVE(
  TEMP t106,
  ESEQ(
   SEQ(
    CJUMP(EQ,
     TEMP t102,
     CONST 0,
     L2,L3),
    SEQ(
     LABEL L2,
     SEQ(
      MOVE(
       TEMP t103,
       CONST 1),
      SEQ(
       JUMP(
        NAME L4),
       SEQ(
        LABEL L3,
        SEQ(
         MOVE(
          TEMP t103,
          BINOP(MUL,
           TEMP t102,
           CALL(
            NAME L1,
             MEM(
              TEMP t100),
             BINOP(MINUS,
              TEMP t102,
              CONST 1)))),
         LABEL L4)))))),
   TEMP t103)))
# ----- linearize L1 -----
LABEL L1
CJUMP(EQ,
 TEMP t102,
 CONST 0,
 L2,L3)
LABEL L3
MOVE(
 TEMP t105,
 TEMP t102)
MOVE(
 TEMP t104,
 CALL(
  NAME L1,
   MEM(
    TEMP t100),
   BINOP(MINUS,
    TEMP t102,
    CONST 1)))
MOVE(
 TEMP t103,
 BINOP(MUL,
  TEMP t105,
  TEMP t104))
LABEL L4
MOVE(
 TEMP t106,
 TEMP t103)
JUMP(
 NAME L5)
LABEL L2
MOVE(
 TEMP t103,
 CONST 1)
JUMP(
 NAME L4)
LABEL L5
# ----- Assembly L1 -----
L1:
beq t102, 0, L2
L3:
add t105, t102, $0
lw t106, 0(t100)
add t108, t106, $0
addi t107, t102, -1
add t109, t107, $0
jal L1 
add t104, t106, $0
mul t108, t105, t104
add t103, t108, $0
L4:
add t106, t103, $0
j L5 
L2:
addi t109, $0, 1
add t103, t109, $0
j L4 
L5:
# ----- emit L0 -----
# ----- translated L0 -----
SEQ(
 LABEL L0,
 MOVE(
  TEMP t106,
  CALL(
   NAME L1,
    TEMP t100,
    CONST 10)))
# ----- linearize L0 -----
LABEL L0
MOVE(
 TEMP t106,
 CALL(
  NAME L1,
   TEMP t100,
   CONST 10))
JUMP(
 NAME L6)
LABEL L6
# ----- Assembly L0 -----
L0:
add t108, t100, $0
addi t110, $0, 10
add t109, t110, $0
jal L1 
add t106, t106, $0
j L6 
L6:
