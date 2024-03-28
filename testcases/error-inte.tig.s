# ----- emit L0 -----
# ----- translated L0 -----
SEQ(
 LABEL L0,
 MOVE(
  TEMP t106,
  ESEQ(
   MOVE(
    TEMP t102,
    ESEQ(
     SEQ(
      MOVE(
       TEMP t101,
       CALL(
        NAME malloc,
         CONST 4)),
      SEQ(
       MOVE(
        MEM(
         BINOP(PLUS,
          TEMP t101,
          CONST 0)),
        CONST 2),
       EXP(
        CONST 0))),
     TEMP t101)),
   ESEQ(
    SEQ(
     MOVE(
      TEMP t103,
      CONST 1),
     SEQ(
      CJUMP(EQ,
       MEM(
        TEMP t102),
       CONST 3,
       L1,L2),
      SEQ(
       LABEL L2,
       SEQ(
        MOVE(
         TEMP t103,
         CONST 0),
        LABEL L1)))),
    TEMP t103))))
# ----- linearize L0 -----
LABEL L0
MOVE(
 TEMP t101,
 CALL(
  NAME malloc,
   CONST 4))
MOVE(
 MEM(
  BINOP(PLUS,
   TEMP t101,
   CONST 0)),
 CONST 2)
MOVE(
 TEMP t102,
 TEMP t101)
MOVE(
 TEMP t103,
 CONST 1)
CJUMP(EQ,
 MEM(
  TEMP t102),
 CONST 3,
 L1,L2)
LABEL L2
MOVE(
 TEMP t103,
 CONST 0)
LABEL L1
MOVE(
 TEMP t106,
 TEMP t103)
JUMP(
 NAME L3)
LABEL L3
# ----- Assembly L0 -----
L0:
addi t104, $0, 4
add t108, t104, $0
jal malloc 
add t101, t106, $0
addi t105, $0, 2
sw t105, 0(t101)
add t102, t101, $0
addi t106, $0, 1
add t103, t106, $0
lw t107, 0(t102)
beq t107, 3, L1
L2:
addi t108, $0, 0
add t103, t108, $0
L1:
add t106, t103, $0
j L3 
L3:
