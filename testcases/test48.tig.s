# ----- emit g -----
# ----- linearize g -----
LABEL L2
MOVE(
 TEMP t132,
 TEMP t109)
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
 TEMP t106,
 TEMP t132)
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
# ----- Assembly g -----
g:
move t100, t101
addi t101, t101, -44
sw t102, 8(t101)
sw t100, 4(t101)
L2:
add t132, t109, $0
sw t108, -4(t100)
sw t120, -8(t100)
sw t121, -12(t100)
sw t122, -16(t100)
sw t123, -20(t100)
sw t124, -24(t100)
sw t125, -28(t100)
sw t126, -32(t100)
sw t127, -36(t100)
add t106, t132, $0
lw t134, -8(t100)
add t120, t134, $0
lw t135, -12(t100)
add t121, t135, $0
lw t136, -16(t100)
add t122, t136, $0
lw t137, -20(t100)
add t123, t137, $0
lw t138, -24(t100)
add t124, t138, $0
lw t139, -28(t100)
add t125, t139, $0
lw t140, -32(t100)
add t126, t140, $0
lw t141, -36(t100)
add t127, t141, $0
j L1 
L1:
lw t102, 8(t101)
lw t100, 4(t101)
addi t101, t101, 44
jr t102
# ----- emit g -----
# ----- linearize g -----
LABEL L4
MOVE(
 TEMP t133,
 TEMP t109)
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
 TEMP t106,
 TEMP t133)
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
# ----- Assembly g -----
g:
move t100, t101
addi t101, t101, -44
sw t102, 8(t101)
sw t100, 4(t101)
L4:
add t133, t109, $0
sw t108, -4(t100)
sw t120, -8(t100)
sw t121, -12(t100)
sw t122, -16(t100)
sw t123, -20(t100)
sw t124, -24(t100)
sw t125, -28(t100)
sw t126, -32(t100)
sw t127, -36(t100)
add t106, t133, $0
lw t142, -8(t100)
add t120, t142, $0
lw t143, -12(t100)
add t121, t143, $0
lw t144, -16(t100)
add t122, t144, $0
lw t145, -20(t100)
add t123, t145, $0
lw t146, -24(t100)
add t124, t146, $0
lw t147, -28(t100)
add t125, t147, $0
lw t148, -32(t100)
add t126, t148, $0
lw t149, -36(t100)
add t127, t149, $0
j L3 
L3:
lw t102, 8(t101)
lw t100, 4(t101)
addi t101, t101, 44
jr t102
# ----- emit L0 -----
# ----- linearize L0 -----
LABEL L6
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
 NAME L5)
LABEL L5
# ----- Assembly L0 -----
L0:
move t100, t101
addi t101, t101, -44
sw t102, 8(t101)
sw t100, 4(t101)
L6:
sw t108, -4(t100)
sw t120, -8(t100)
sw t121, -12(t100)
sw t122, -16(t100)
sw t123, -20(t100)
sw t124, -24(t100)
sw t125, -28(t100)
sw t126, -32(t100)
sw t127, -36(t100)
addi t150, $0, 0
add t106, t150, $0
lw t151, -8(t100)
add t120, t151, $0
lw t152, -12(t100)
add t121, t152, $0
lw t153, -16(t100)
add t122, t153, $0
lw t154, -20(t100)
add t123, t154, $0
lw t155, -24(t100)
add t124, t155, $0
lw t156, -28(t100)
add t125, t156, $0
lw t157, -32(t100)
add t126, t157, $0
lw t158, -36(t100)
add t127, t158, $0
j L5 
L5:
lw t102, 8(t101)
lw t100, 4(t101)
addi t101, t101, 44
jr t102
