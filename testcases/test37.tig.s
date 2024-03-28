L1 : .ascii   
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
     CONST 0),
    MOVE(
     TEMP t102,
     NAME L1)),
   CONST 0)))
# ----- linearize L0 -----
LABEL L0
MOVE(
 TEMP t101,
 CONST 0)
MOVE(
 TEMP t102,
 NAME L1)
MOVE(
 TEMP t106,
 CONST 0)
JUMP(
 NAME L2)
LABEL L2
# ----- Assembly L0 -----
L0:
addi t103, $0, 0
add t101, t103, $0
la t104, L1
add t102, t104, $0
addi t105, $0, 0
add t106, t105, $0
j L2 
L2:
