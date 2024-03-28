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
       BINOP(PLUS,
        CONST 5,
        CONST 6)),
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
EXP(
 BINOP(PLUS,
  CONST 5,
  CONST 6))
JUMP(
 NAME L3)
LABEL L4
# ----- Assembly L0 -----
L0:
L3:
addi t101, $0, 10
bgt t101, 5, L2
L1:
addi t102, $0, 0
add t106, t102, $0
j L4 
L2:
addi t104, $0, 5
addi t103, t104, 6
j L3 
L4:
