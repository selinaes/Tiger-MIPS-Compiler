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
         CONST 8)),
      SEQ(
       MOVE(
        MEM(
         BINOP(PLUS,
          TEMP t101,
          CONST 0)),
        CONST 0),
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
   TEMP t102)))
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
 CONST 0)
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
 TEMP t106,
 TEMP t102)
JUMP(
 NAME L1)
LABEL L1
# ----- Assembly L0 -----
L0:
addi t103, $0, 8
add t108, t103, $0
jal malloc 
add t101, t106, $0
addi t104, $0, 0
sw t104, 0(t101)
addi t105, $0, 0
sw t105, 4(t101)
add t102, t101, $0
add t106, t102, $0
j L1 
L1:
