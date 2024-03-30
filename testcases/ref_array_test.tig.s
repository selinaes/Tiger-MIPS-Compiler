# ----- emit L0 -----
# ----- linearize L0 -----
LABEL L4
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
   CONST 3,
   CONST 1))
MOVE(
 TEMP t133,
 CALL(
  NAME initArray,
   CONST 3,
   CONST 0))
MOVE(
 TEMP t134,
 CONST 1)
CJUMP(EQ,
 TEMP t132,
 TEMP t133,
 L1,L2)
LABEL L2
MOVE(
 TEMP t134,
 CONST 0)
LABEL L1
MOVE(
 TEMP t106,
 TEMP t134)
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
 NAME L3)
LABEL L3
# ----- Assembly L0 -----
L0:
move t100, t101
addi t101, t101, -44
sw t102, 8(t101)
sw t100, 4(t101)
L4:
sw t108, -4(t100)
sw t120, -8(t100)
sw t121, -12(t100)
sw t122, -16(t100)
sw t123, -20(t100)
sw t124, -24(t100)
sw t125, -28(t100)
sw t126, -32(t100)
sw t127, -36(t100)
addi t135, $0, 3
add t108, t135, $0
addi t136, $0, 1
add t109, t136, $0
jal initArray 
add t132, t106, $0
addi t137, $0, 3
add t108, t137, $0
addi t138, $0, 0
add t109, t138, $0
jal initArray 
add t133, t106, $0
addi t139, $0, 1
add t134, t139, $0
beq t132, t133, L1
L2:
addi t140, $0, 0
add t134, t140, $0
L1:
add t106, t134, $0
lw t141, -8(t100)
add t120, t141, $0
lw t142, -12(t100)
add t121, t142, $0
lw t143, -16(t100)
add t122, t143, $0
lw t144, -20(t100)
add t123, t144, $0
lw t145, -24(t100)
add t124, t145, $0
lw t146, -28(t100)
add t125, t146, $0
lw t147, -32(t100)
add t126, t147, $0
lw t148, -36(t100)
add t127, t148, $0
j L3 
L3:
lw t102, 8(t101)
lw t100, 4(t101)
addi t101, t101, 44
jr t102
