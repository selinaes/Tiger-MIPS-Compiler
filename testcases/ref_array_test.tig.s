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
     CALL(
      NAME initArray,
       CONST 3,
       CONST 1)),
    MOVE(
     TEMP t102,
     CALL(
      NAME initArray,
       CONST 3,
       CONST 0))),
   ESEQ(
    SEQ(
     MOVE(
      TEMP t103,
      CONST 1),
     SEQ(
      CJUMP(EQ,
       TEMP t101,
       TEMP t102,
       L1,L2),
      SEQ(
       LABEL L2,
       SEQ(
        MOVE(
         TEMP t103,
         CONST 0),
        LABEL L1)))),
    TEMP t103))))
# ----- linearize L0 -----
LABEL L0
MOVE(
 TEMP t101,
 CALL(
  NAME initArray,
   CONST 3,
   CONST 1))
MOVE(
 TEMP t102,
 CALL(
  NAME initArray,
   CONST 3,
   CONST 0))
MOVE(
 TEMP t103,
 CONST 1)
CJUMP(EQ,
 TEMP t101,
 TEMP t102,
 L1,L2)
LABEL L2
MOVE(
 TEMP t103,
 CONST 0)
LABEL L1
MOVE(
 TEMP t106,
 TEMP t103)
JUMP(
 NAME L3)
LABEL L3
# ----- Assembly L0 -----
L0:
addi t104, $0, 3
add t108, t104, $0
addi t105, $0, 1
add t109, t105, $0
jal initArray 
add t101, t106, $0
addi t106, $0, 3
add t108, t106, $0
addi t107, $0, 0
add t109, t107, $0
jal initArray 
add t102, t106, $0
addi t108, $0, 1
add t103, t108, $0
beq t101, t102, L1
L2:
addi t109, $0, 0
add t103, t109, $0
L1:
add t106, t103, $0
j L3 
L3:
