# ----- emit L2 -----
# ----- translated L2 -----
SEQ(
 LABEL L2,
 MOVE(
  TEMP t106,
  BINOP(PLUS,
   CONST 1,
   TEMP t102)))
# ----- linearize L2 -----
LABEL L2
MOVE(
 TEMP t106,
 BINOP(PLUS,
  CONST 1,
  TEMP t102))
JUMP(
 NAME L10)
LABEL L10
# ----- Assembly L2 -----
L2:
addi t108, t102, 1
add t106, t108, $0
j L10 
L10:
# ----- emit L1 -----
# ----- translated L1 -----
SEQ(
 LABEL L1,
 MOVE(
  TEMP t106,
  CONST 0))
# ----- linearize L1 -----
LABEL L1
MOVE(
 TEMP t106,
 CONST 0)
JUMP(
 NAME L11)
LABEL L11
# ----- Assembly L1 -----
L1:
addi t109, $0, 0
add t106, t109, $0
j L11 
L11:
# ----- emit L6 -----
# ----- translated L6 -----
SEQ(
 LABEL L6,
 MOVE(
  TEMP t106,
  ESEQ(
   SEQ(
    MOVE(
     TEMP t107,
     TEMP t106),
    SEQ(
     CJUMP(LE,
      TEMP t107,
      CONST 8,
      L8,L7),
     SEQ(
      LABEL L9,
      SEQ(
       MOVE(
        TEMP t107,
        BINOP(PLUS,
         TEMP t107,
         CONST 1)),
       SEQ(
        LABEL L8,
        SEQ(
         EXP(
          BINOP(PLUS,
           TEMP t107,
           MEM(
            BINOP(PLUS,
             MEM(
              TEMP t100),
             CONST 0)))),
         SEQ(
          CJUMP(LT,
           TEMP t107,
           CONST 8,
           L9,L7),
          LABEL L7))))))),
   CONST 0)))
# ----- linearize L6 -----
LABEL L6
MOVE(
 TEMP t107,
 TEMP t106)
CJUMP(LE,
 TEMP t107,
 CONST 8,
 L8,L7)
LABEL L7
MOVE(
 TEMP t106,
 CONST 0)
JUMP(
 NAME L12)
LABEL L9
MOVE(
 TEMP t107,
 BINOP(PLUS,
  TEMP t107,
  CONST 1))
LABEL L8
EXP(
 BINOP(PLUS,
  TEMP t107,
  MEM(
   BINOP(PLUS,
    MEM(
     TEMP t100),
    CONST 0))))
CJUMP(LT,
 TEMP t107,
 CONST 8,
 L9,L13)
LABEL L13
JUMP(
 NAME L7)
LABEL L12
# ----- Assembly L6 -----
L6:
add t107, t106, $0
ble t107, 8, L8
L7:
addi t110, $0, 0
add t106, t110, $0
j L12 
L9:
addi t111, t107, 1
add t107, t111, $0
L8:
lw t114, 0(t100)
lw t113, 0(t114)
add t112, t107, t113
blt t107, 8, L9
L13:
j L7 
L12:
# ----- emit L0 -----
# ----- translated L0 -----
SEQ(
 LABEL L0,
 MOVE(
  TEMP t106,
  ESEQ(
   SEQ(
    MOVE(
     MEM(
      BINOP(PLUS,
       TEMP t100,
       CONST 0)),
     CONST 3),
    MOVE(
     TEMP t104,
     CONST 3)),
   ESEQ(
    SEQ(
     JUMP(
      NAME L5),
     SEQ(
      LABEL L4,
      SEQ(
       EXP(
        CONST 0),
       SEQ(
        LABEL L5,
        SEQ(
         CJUMP(LT,
          TEMP t104,
          CONST 7,
          L4,L3),
         LABEL L3))))),
    CALL(
     NAME exit,
      CONST 1)))))
# ----- linearize L0 -----
LABEL L0
MOVE(
 MEM(
  BINOP(PLUS,
   TEMP t100,
   CONST 0)),
 CONST 3)
MOVE(
 TEMP t104,
 CONST 3)
LABEL L5
CJUMP(LT,
 TEMP t104,
 CONST 7,
 L4,L3)
LABEL L3
MOVE(
 TEMP t106,
 CALL(
  NAME exit,
   CONST 1))
JUMP(
 NAME L14)
LABEL L4
JUMP(
 NAME L5)
LABEL L14
# ----- Assembly L0 -----
L0:
addi t115, $0, 3
sw t115, 0(t100)
addi t116, $0, 3
add t104, t116, $0
L5:
blt t104, 7, L4
L3:
addi t117, $0, 1
add t108, t117, $0
jal exit 
add t106, t106, $0
j L14 
L4:
j L5 
L14:
