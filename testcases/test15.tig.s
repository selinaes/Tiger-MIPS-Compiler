# ----- emit L0 -----
# ----- translated L0 -----
SEQ(
 LABEL L0,
 MOVE(
  TEMP t106,
  ESEQ(
   SEQ(
    CJUMP(NE,
     CONST 20,
     CONST 0,
     L1,L2),
    SEQ(
     LABEL L1,
     SEQ(
      EXP(
       CONST 3),
      LABEL L2))),
   CONST 0)))
# ----- linearize L0 -----
LABEL L0
CJUMP(NE,
 CONST 20,
 CONST 0,
 L1,L2)
LABEL L2
MOVE(
 TEMP t106,
 CONST 0)
JUMP(
 NAME L3)
LABEL L1
JUMP(
 NAME L2)
LABEL L3
# ----- Assembly L0 -----
L0:
addi t101, $0, 20
bne t101, 0, L1
L2:
addi t102, $0, 0
add t106, t102, $0
j L3 
L1:
j L2 
L3:
