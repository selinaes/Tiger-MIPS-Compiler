# ----- emit L0 -----
# ----- translated L0 -----
SEQ(
 LABEL L0,
 MOVE(
  TEMP t106,
  ESEQ(
   MOVE(
    TEMP t101,
    CALL(
     NAME initArray,
      CONST 10,
      CONST 0)),
   ESEQ(
    SEQ(
     MOVE(
      TEMP t102,
      CONST 2),
     SEQ(
      MOVE(
       TEMP t103,
       MEM(
        BINOP(PLUS,
         TEMP t101,
         CONST ~4))),
      SEQ(
       CJUMP(GE,
        TEMP t102,
        TEMP t103,
        L1,L2),
       SEQ(
        LABEL L2,
        SEQ(
         CJUMP(LT,
          TEMP t102,
          CONST 0,
          L1,L3),
         SEQ(
          LABEL L1,
          SEQ(
           EXP(
            CALL(
             NAME exit,
              CONST 1)),
           LABEL L3))))))),
    MEM(
     BINOP(PLUS,
      TEMP t101,
      BINOP(MUL,
       CONST 2,
       CONST 4)))))))
# ----- linearize L0 -----
LABEL L0
MOVE(
 TEMP t101,
 CALL(
  NAME initArray,
   CONST 10,
   CONST 0))
MOVE(
 TEMP t102,
 CONST 2)
MOVE(
 TEMP t103,
 MEM(
  BINOP(PLUS,
   TEMP t101,
   CONST ~4)))
CJUMP(GE,
 TEMP t102,
 TEMP t103,
 L1,L2)
LABEL L2
CJUMP(LT,
 TEMP t102,
 CONST 0,
 L1,L3)
LABEL L3
MOVE(
 TEMP t106,
 MEM(
  BINOP(PLUS,
   TEMP t101,
   BINOP(MUL,
    CONST 2,
    CONST 4))))
JUMP(
 NAME L4)
LABEL L1
EXP(
 CALL(
  NAME exit,
   CONST 1))
JUMP(
 NAME L3)
LABEL L4
# ----- Assembly L0 -----
L0:
addi t104, $0, 10
add t108, t104, $0
addi t105, $0, 0
add t109, t105, $0
jal initArray 
add t101, t106, $0
addi t106, $0, 2
add t102, t106, $0
lw t107, -4(t101)
add t103, t107, $0
bge t102, t103, L1
L2:
blt t102, 0, L1
L3:
addi t111, $0, 2
addi t112, $0, 4
mul t110, t111, t112
add t109, t101, t110
lw t108, 0(t109)
add t106, t108, $0
j L4 
L1:
addi t113, $0, 1
add t108, t113, $0
jal exit 
j L3 
L4:
