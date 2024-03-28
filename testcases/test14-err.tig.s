L1 : .ascii aname 
# ----- emit L0 -----
# ----- translated L0 -----
SEQ(
 LABEL L0,
 MOVE(
  TEMP t106,
  ESEQ(
   SEQ(
    MOVE(
     TEMP t102,
     ESEQ(
      SEQ(
       MOVE(
        TEMP t101,
        CALL(
         NAME malloc,
          CONST 8)),
       SEQ(
        MOVE(
         MEM(
          BINOP(PLUS,
           TEMP t101,
           CONST 0)),
         NAME L1),
        SEQ(
         MOVE(
          MEM(
           BINOP(PLUS,
            TEMP t101,
            CONST 4)),
          CONST 0),
         EXP(
          CONST 0)))),
      TEMP t101)),
    MOVE(
     TEMP t103,
     CALL(
      NAME initArray,
       CONST 3,
       CONST 0))),
   ESEQ(
    SEQ(
     CJUMP(NE,
      TEMP t102,
      TEMP t103,
      L2,L3),
     SEQ(
      LABEL L2,
      SEQ(
       MOVE(
        TEMP t104,
        CONST 3),
       SEQ(
        JUMP(
         NAME L4),
        SEQ(
         LABEL L3,
         SEQ(
          MOVE(
           TEMP t104,
           CONST 4),
          LABEL L4)))))),
    TEMP t104))))
# ----- linearize L0 -----
LABEL L0
MOVE(
 TEMP t101,
 CALL(
  NAME malloc,
   CONST 8))
MOVE(
 MEM(
  BINOP(PLUS,
   TEMP t101,
   CONST 0)),
 NAME L1)
MOVE(
 MEM(
  BINOP(PLUS,
   TEMP t101,
   CONST 4)),
 CONST 0)
MOVE(
 TEMP t102,
 TEMP t101)
MOVE(
 TEMP t103,
 CALL(
  NAME initArray,
   CONST 3,
   CONST 0))
CJUMP(NE,
 TEMP t102,
 TEMP t103,
 L2,L3)
LABEL L3
MOVE(
 TEMP t104,
 CONST 4)
LABEL L4
MOVE(
 TEMP t106,
 TEMP t104)
JUMP(
 NAME L5)
LABEL L2
MOVE(
 TEMP t104,
 CONST 3)
JUMP(
 NAME L4)
LABEL L5
# ----- Assembly L0 -----
L0:
addi t105, $0, 8
add t108, t105, $0
jal malloc 
add t101, t106, $0
la t106, L1
sw t106, 0(t101)
addi t107, $0, 0
sw t107, 4(t101)
add t102, t101, $0
addi t108, $0, 3
add t108, t108, $0
addi t109, $0, 0
add t109, t109, $0
jal initArray 
add t103, t106, $0
bne t102, t103, L2
L3:
addi t110, $0, 4
add t104, t110, $0
L4:
add t106, t104, $0
j L5 
L2:
addi t111, $0, 3
add t104, t111, $0
j L4 
L5:
