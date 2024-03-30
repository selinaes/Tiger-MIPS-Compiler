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
 CONST 0)
MOVE(
 TEMP t133,
 CONST 0)
CJUMP(LE,
 TEMP t133,
 CONST 100,
 L2,L1)
LABEL L1
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
 NAME L4)
LABEL L3
MOVE(
 TEMP t133,
 BINOP(PLUS,
  TEMP t133,
  CONST 1))
LABEL L2
MOVE(
 TEMP t132,
 BINOP(PLUS,
  TEMP t132,
  CONST 1))
CJUMP(LT,
 TEMP t133,
 CONST 100,
 L3,L6)
LABEL L6
JUMP(
 NAME L1)
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
addi t134, $0, 0
add t132, t134, $0
addi t135, $0, 0
add t133, t135, $0
addi t136, $0, 100
ble t133, t136, L2
L1:
addi t137, $0, 0
add t106, t137, $0
lw t138, -8(t100)
add t120, t138, $0
lw t139, -12(t100)
add t121, t139, $0
lw t140, -16(t100)
add t122, t140, $0
lw t141, -20(t100)
add t123, t141, $0
lw t142, -24(t100)
add t124, t142, $0
lw t143, -28(t100)
add t125, t143, $0
lw t144, -32(t100)
add t126, t144, $0
lw t145, -36(t100)
add t127, t145, $0
j L4 
L3:
addi t146, t133, 1
add t133, t146, $0
L2:
addi t147, t132, 1
add t132, t147, $0
addi t148, $0, 100
blt t133, t148, L3
L6:
j L1 
L4:
lw t102, 8(t101)
lw t100, 4(t101)
addi t101, t101, 44
jr t102
