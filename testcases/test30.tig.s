# ----- emit L0 -----
# ----- linearize L0 -----
LABEL L5
MOVE(
 MEM(
  BINOP(MINUS,
   TEMP t100,
   CONST 4)),
 TEMP t108)
MOVE(
 MEM(
  BINOP(PLUS,
   TEMP t100,
   CONST ~8)),
 TEMP t120)
MOVE(
 MEM(
  BINOP(PLUS,
   TEMP t100,
   CONST ~12)),
 TEMP t121)
MOVE(
 MEM(
  BINOP(PLUS,
   TEMP t100,
   CONST ~16)),
 TEMP t122)
MOVE(
 MEM(
  BINOP(PLUS,
   TEMP t100,
   CONST ~20)),
 TEMP t123)
MOVE(
 MEM(
  BINOP(PLUS,
   TEMP t100,
   CONST ~24)),
 TEMP t124)
MOVE(
 MEM(
  BINOP(PLUS,
   TEMP t100,
   CONST ~28)),
 TEMP t125)
MOVE(
 MEM(
  BINOP(PLUS,
   TEMP t100,
   CONST ~32)),
 TEMP t126)
MOVE(
 MEM(
  BINOP(PLUS,
   TEMP t100,
   CONST ~36)),
 TEMP t127)
MOVE(
 TEMP t132,
 CALL(
  NAME initArray,
   CONST 10,
   CONST 0))
MOVE(
 TEMP t133,
 CONST 2)
MOVE(
 TEMP t134,
 MEM(
  BINOP(PLUS,
   TEMP t132,
   CONST ~4)))
CJUMP(GE,
 TEMP t133,
 TEMP t134,
 L1,L2)
LABEL L2
CJUMP(LT,
 TEMP t133,
 CONST 0,
 L1,L3)
LABEL L3
MOVE(
 TEMP t106,
 MEM(
  BINOP(PLUS,
   TEMP t132,
   BINOP(MUL,
    CONST 2,
    CONST 4))))
MOVE(
 TEMP t120,
 MEM(
  BINOP(PLUS,
   TEMP t100,
   CONST ~8)))
MOVE(
 TEMP t121,
 MEM(
  BINOP(PLUS,
   TEMP t100,
   CONST ~12)))
MOVE(
 TEMP t122,
 MEM(
  BINOP(PLUS,
   TEMP t100,
   CONST ~16)))
MOVE(
 TEMP t123,
 MEM(
  BINOP(PLUS,
   TEMP t100,
   CONST ~20)))
MOVE(
 TEMP t124,
 MEM(
  BINOP(PLUS,
   TEMP t100,
   CONST ~24)))
MOVE(
 TEMP t125,
 MEM(
  BINOP(PLUS,
   TEMP t100,
   CONST ~28)))
MOVE(
 TEMP t126,
 MEM(
  BINOP(PLUS,
   TEMP t100,
   CONST ~32)))
MOVE(
 TEMP t127,
 MEM(
  BINOP(PLUS,
   TEMP t100,
   CONST ~36)))
JUMP(
 NAME L4)
LABEL L1
EXP(
 CALL(
  NAME exit,
   CONST 1))
JUMP(
 NAME L3)
LABEL L4
# ----- Assembly L0 -----
L0:
move t100, t101
addi t101, t101, -44
sw t102, 8(t101)
sw t100, 4(t101)
L5:
sw t108, -4(t100)
sw t120, -8(t100)
sw t121, -12(t100)
sw t122, -16(t100)
sw t123, -20(t100)
sw t124, -24(t100)
sw t125, -28(t100)
sw t126, -32(t100)
sw t127, -36(t100)
addi t135, $0, 10
add t108, t135, $0
addi t136, $0, 0
add t109, t136, $0
jal initArray 
add t132, t106, $0
addi t137, $0, 2
add t133, t137, $0
lw t138, -4(t132)
add t134, t138, $0
bge t133, t134, L1
L2:
addi t139, $0, 0
blt t133, t139, L1
L3:
addi t143, $0, 2
addi t144, $0, 4
mul t142, t143, t144
add t141, t132, t142
lw t140, 0(t141)
add t106, t140, $0
lw t145, -8(t100)
add t120, t145, $0
lw t146, -12(t100)
add t121, t146, $0
lw t147, -16(t100)
add t122, t147, $0
lw t148, -20(t100)
add t123, t148, $0
lw t149, -24(t100)
add t124, t149, $0
lw t150, -28(t100)
add t125, t150, $0
lw t151, -32(t100)
add t126, t151, $0
lw t152, -36(t100)
add t127, t152, $0
j L4 
L1:
addi t153, $0, 1
add t108, t153, $0
jal exit 
j L3 
L4:
lw t102, 8(t101)
lw t100, 4(t101)
addi t101, t101, 44
jr t102
