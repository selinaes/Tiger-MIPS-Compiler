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
     MOVE(
      TEMP t102,
      CONST 0),
     SEQ(
      CJUMP(LE,
       TEMP t102,
       CONST 100,
       L2,L1),
      SEQ(
       LABEL L3,
       SEQ(
        MOVE(
         TEMP t102,
         BINOP(PLUS,
          TEMP t102,
          CONST 1)),
        SEQ(
         LABEL L2,
         SEQ(
          EXP(
           ESEQ(
            MOVE(
             TEMP t101,
             BINOP(PLUS,
              TEMP t101,
              CONST 1)),
            CONST 0)),
          SEQ(
           CJUMP(LT,
            TEMP t102,
            CONST 100,
            L3,L1),
           LABEL L1))))))),
    CONST 0))))
# ----- linearize L0 -----
LABEL L0
MOVE(
 TEMP t101,
 CONST 0)
MOVE(
 TEMP t102,
 CONST 0)
CJUMP(LE,
 TEMP t102,
 CONST 100,
 L2,L1)
LABEL L1
MOVE(
 TEMP t106,
 CONST 0)
JUMP(
 NAME L4)
LABEL L3
MOVE(
 TEMP t102,
 BINOP(PLUS,
  TEMP t102,
  CONST 1))
LABEL L2
MOVE(
 TEMP t101,
 BINOP(PLUS,
  TEMP t101,
  CONST 1))
CJUMP(LT,
 TEMP t102,
 CONST 100,
 L3,L5)
LABEL L5
JUMP(
 NAME L1)
LABEL L4
# ----- Assembly L0 -----
L0:
addi t103, $0, 0
add t101, t103, $0
addi t104, $0, 0
add t102, t104, $0
ble t102, 100, L2
L1:
addi t105, $0, 0
add t106, t105, $0
j L4 
L3:
addi t106, t102, 1
add t102, t106, $0
L2:
addi t107, t101, 1
add t101, t107, $0
blt t102, 100, L3
L5:
j L1 
L4:
