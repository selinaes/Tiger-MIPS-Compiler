# ----- emit L0 -----
# ----- translated L0 -----
SEQ(
 LABEL L0,
 MOVE(
  TEMP t106,
  ESEQ(
   MOVE(
    TEMP t101,
    CALL(
     NAME initArray,
      CONST 10,
      CONST 0)),
   TEMP t101)))
# ----- linearize L0 -----
LABEL L0
MOVE(
 TEMP t101,
 CALL(
  NAME initArray,
   CONST 10,
   CONST 0))
MOVE(
 TEMP t106,
 TEMP t101)
JUMP(
 NAME L1)
LABEL L1
# ----- Assembly L0 -----
L0:
addi t102, $0, 10
add t108, t102, $0
addi t103, $0, 0
add t109, t103, $0
jal initArray 
add t101, t106, $0
add t106, t101, $0
j L1 
L1:
