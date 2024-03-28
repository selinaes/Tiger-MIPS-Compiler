# ----- emit L0 -----
# ----- translated L0 -----
SEQ(
 LABEL L0,
 MOVE(
  TEMP t106,
  ESEQ(
   MOVE(
    TEMP t101,
    CONST 0),
   ESEQ(
    SEQ(
     CJUMP(EQ,
      TEMP t101,
      CONST 0,
      L1,L1),
     LABEL L1),
    ESEQ(
     SEQ(
      MOVE(
       TEMP t102,
       CONST 1),
      SEQ(
       CJUMP(NE,
        TEMP t101,
        CONST 0,
        L2,L3),
       SEQ(
        LABEL L3,
        SEQ(
         MOVE(
          TEMP t102,
          CONST 0),
         LABEL L2)))),
     TEMP t102)))))
# ----- linearize L0 -----
LABEL L0
MOVE(
 TEMP t101,
 CONST 0)
CJUMP(EQ,
 TEMP t101,
 CONST 0,
 L1,L1)
LABEL L1
MOVE(
 TEMP t102,
 CONST 1)
CJUMP(NE,
 TEMP t101,
 CONST 0,
 L2,L3)
LABEL L3
MOVE(
 TEMP t102,
 CONST 0)
LABEL L2
MOVE(
 TEMP t106,
 TEMP t102)
JUMP(
 NAME L4)
LABEL L4
# ----- Assembly L0 -----
L0:
addi t103, $0, 0
add t101, t103, $0
beq t101, 0, L1
L1:
addi t104, $0, 1
add t102, t104, $0
bne t101, 0, L2
L3:
addi t105, $0, 0
add t102, t105, $0
L2:
add t106, t102, $0
j L4 
L4:
