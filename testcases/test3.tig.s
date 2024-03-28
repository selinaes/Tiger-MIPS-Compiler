L1 : .ascii Nobody 
L2 : .ascii Somebody 
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
         CONST 1000),
        EXP(
         CONST 0)))),
     TEMP t101)),
   ESEQ(
    MOVE(
     MEM(
      TEMP t102),
     NAME L2),
    ESEQ(
     MOVE(
      MEM(
       BINOP(PLUS,
        TEMP t102,
        CONST 4)),
      CONST 900),
     TEMP t102)))))
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
 CONST 1000)
MOVE(
 TEMP t102,
 TEMP t101)
MOVE(
 MEM(
  TEMP t102),
 NAME L2)
MOVE(
 MEM(
  BINOP(PLUS,
   TEMP t102,
   CONST 4)),
 CONST 900)
MOVE(
 TEMP t106,
 TEMP t102)
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
addi t105, $0, 1000
sw t105, 4(t101)
add t102, t101, $0
la t106, L2
sw t102, 0(t106)
addi t107, $0, 900
sw t107, 4(t102)
add t106, t102, $0
j L3 
L3:
