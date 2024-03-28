L2 : .ascii   
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
     CONST 10),
    SEQ(
     CJUMP(LE,
      TEMP t101,
      NAME L2,
      L3,L1),
     SEQ(
      LABEL L4,
      SEQ(
       MOVE(
        TEMP t101,
        BINOP(PLUS,
         TEMP t101,
         CONST 1)),
       SEQ(
        LABEL L3,
        SEQ(
         MOVE(
          TEMP t101,
          BINOP(MINUS,
           TEMP t101,
           CONST 1)),
         SEQ(
          CJUMP(LT,
           TEMP t101,
           NAME L2,
           L4,L1),
          LABEL L1))))))),
   CONST 0)))
# ----- linearize L0 -----
LABEL L0
MOVE(
 TEMP t101,
 CONST 10)
CJUMP(LE,
 TEMP t101,
 NAME L2,
 L3,L1)
LABEL L1
MOVE(
 TEMP t106,
 CONST 0)
JUMP(
 NAME L5)
LABEL L4
MOVE(
 TEMP t101,
 BINOP(PLUS,
  TEMP t101,
  CONST 1))
LABEL L3
MOVE(
 TEMP t101,
 BINOP(MINUS,
  TEMP t101,
  CONST 1))
CJUMP(LT,
 TEMP t101,
 NAME L2,
 L4,L6)
LABEL L6
JUMP(
 NAME L1)
LABEL L5
# ----- Assembly L0 -----
L0:
addi t102, $0, 10
add t101, t102, $0
la t103, L2
ble t101, t103, L3
L1:
addi t104, $0, 0
add t106, t104, $0
j L5 
L4:
addi t105, t101, 1
add t101, t105, $0
L3:
addi t106, t101, -1
add t101, t106, $0
la t107, L2
blt t101, t107, L4
L6:
j L1 
L5:
