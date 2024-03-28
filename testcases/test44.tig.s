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
    MOVE(
     TEMP t101,
     CONST 0),
    CONST 0))))
# ----- linearize L0 -----
LABEL L0
MOVE(
 TEMP t101,
 CONST 0)
MOVE(
 TEMP t101,
 CONST 0)
MOVE(
 TEMP t106,
 CONST 0)
JUMP(
 NAME L1)
LABEL L1
# ----- Assembly L0 -----
L0:
addi t102, $0, 0
add t101, t102, $0
addi t103, $0, 0
add t101, t103, $0
addi t104, $0, 0
add t106, t104, $0
j L1 
L1:
