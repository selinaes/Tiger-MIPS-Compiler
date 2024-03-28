L1 : .ascii df 
# ----- emit L0 -----
# ----- translated L0 -----
SEQ(
 LABEL L0,
 MOVE(
  TEMP t106,
  ESEQ(
   SEQ(
    MOVE(
     TEMP t101,
     CONST 1),
    SEQ(
     CJUMP(GT,
      CONST 3,
      NAME L1,
      L2,L3),
     SEQ(
      LABEL L3,
      SEQ(
       MOVE(
        TEMP t101,
        CONST 0),
       LABEL L2)))),
   TEMP t101)))
# ----- linearize L0 -----
LABEL L0
MOVE(
 TEMP t101,
 CONST 1)
CJUMP(GT,
 CONST 3,
 NAME L1,
 L2,L3)
LABEL L3
MOVE(
 TEMP t101,
 CONST 0)
LABEL L2
MOVE(
 TEMP t106,
 TEMP t101)
JUMP(
 NAME L4)
LABEL L4
# ----- Assembly L0 -----
L0:
addi t102, $0, 1
add t101, t102, $0
la t103, L1
bgt 3, t103, L2
L3:
addi t104, $0, 0
add t101, t104, $0
L2:
add t106, t101, $0
j L4 
L4:
