L1 : .ascii aname 
L2 : .ascii  
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
   ESEQ(
    EXP(
     CALL(
      NAME exit,
       CONST 1)),
    CALL(
     NAME exit,
      CONST 1)))))
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
EXP(
 CALL(
  NAME exit,
   CONST 1))
MOVE(
 TEMP t106,
 CALL(
  NAME exit,
   CONST 1))
JUMP(
 NAME L3)
LABEL L3
# ----- Assembly L0 -----
L0:
addi t103, $0, 8
add t108, t103, $0
jal malloc 
add t101, t106, $0
la t104, L1
sw t104, 0(t101)
addi t105, $0, 0
sw t105, 4(t101)
add t102, t101, $0
addi t106, $0, 1
add t108, t106, $0
jal exit 
addi t107, $0, 1
add t108, t107, $0
jal exit 
add t106, t106, $0
j L3 
L3:
