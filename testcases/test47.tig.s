# ----- emit L0 -----
# ----- linearize L0 -----
LABEL L2
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
 CONST 4)
MOVE(
 TEMP t106,
 CONST 0)
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
 NAME L1)
LABEL L1
# ----- Assembly L0 -----
L0:
move t100, t101
addi t101, t101, -44
sw t102, 8(t101)
sw t100, 4(t101)
L2:
sw t108, -4(t100)
sw t120, -8(t100)
sw t121, -12(t100)
sw t122, -16(t100)
sw t123, -20(t100)
sw t124, -24(t100)
sw t125, -28(t100)
sw t126, -32(t100)
sw t127, -36(t100)
addi t133, $0, 4
add t132, t133, $0
addi t134, $0, 0
add t106, t134, $0
lw t135, -8(t100)
add t120, t135, $0
lw t136, -12(t100)
add t121, t136, $0
lw t137, -16(t100)
add t122, t137, $0
lw t138, -20(t100)
add t123, t138, $0
lw t139, -24(t100)
add t124, t139, $0
lw t140, -28(t100)
add t125, t140, $0
lw t141, -32(t100)
add t126, t141, $0
lw t142, -36(t100)
add t127, t142, $0
j L1 
L1:
lw t102, 8(t101)
lw t100, 4(t101)
addi t101, t101, 44
jr t102
