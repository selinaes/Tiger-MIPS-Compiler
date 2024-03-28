# ----- emit L0 -----
# ----- translated L0 -----
SEQ(
 LABEL L0,
 MOVE(
  TEMP t106,
  ESEQ(
   SEQ(
    CJUMP(GT,
     CONST 10,
     CONST 20,
     L1,L2),
    SEQ(
     LABEL L1,
     SEQ(
      MOVE(
       TEMP t101,
       CONST 30),
      SEQ(
       JUMP(
        NAME L3),
       SEQ(
        LABEL L2,
        SEQ(
         MOVE(
          TEMP t101,
          CONST 40),
         LABEL L3)))))),
   TEMP t101)))
# ----- linearize L0 -----
LABEL L0
CJUMP(GT,
 CONST 10,
 CONST 20,
 L1,L2)
LABEL L2
MOVE(
 TEMP t101,
 CONST 40)
LABEL L3
MOVE(
 TEMP t106,
 TEMP t101)
JUMP(
 NAME L4)
LABEL L1
MOVE(
 TEMP t101,
 CONST 30)
JUMP(
 NAME L3)
LABEL L4
# ----- Assembly L0 -----
L0:
addi t102, $0, 10
bgt t102, 20, L1
L2:
addi t103, $0, 40
add t101, t103, $0
L3:
add t106, t101, $0
j L4 
L1:
addi t104, $0, 30
add t101, t104, $0
j L3 
L4:
