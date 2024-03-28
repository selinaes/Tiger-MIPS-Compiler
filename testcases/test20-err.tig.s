# ----- emit L0 -----
# ----- translated L0 -----
SEQ(
 LABEL L0,
 MOVE(
  TEMP t106,
  ESEQ(
   SEQ(
    JUMP(
     NAME L3),
    SEQ(
     LABEL L2,
     SEQ(
      EXP(
       ESEQ(
        EXP(
         BINOP(PLUS,
          CALL(
           NAME exit,
            CONST 1),
          CONST 1)),
        CONST 0)),
      SEQ(
       LABEL L3,
       SEQ(
        CJUMP(GT,
         CONST 10,
         CONST 5,
         L2,L1),
        LABEL L1))))),
   CONST 0)))
# ----- linearize L0 -----
LABEL L0
LABEL L3
CJUMP(GT,
 CONST 10,
 CONST 5,
 L2,L1)
LABEL L1
MOVE(
 TEMP t106,
 CONST 0)
JUMP(
 NAME L4)
LABEL L2
MOVE(
 TEMP t101,
 CALL(
  NAME exit,
   CONST 1))
EXP(
 BINOP(PLUS,
  TEMP t101,
  CONST 1))
JUMP(
 NAME L3)
LABEL L4
# ----- Assembly L0 -----
L0:
L3:
addi t102, $0, 10
bgt t102, 5, L2
L1:
addi t103, $0, 0
add t106, t103, $0
j L4 
L2:
addi t104, $0, 1
add t108, t104, $0
jal exit 
add t101, t106, $0
addi t105, t101, 1
j L3 
L4:
