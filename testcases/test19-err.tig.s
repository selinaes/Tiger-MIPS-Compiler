# ----- emit do_nothing1 -----
# ----- linearize do_nothing1 -----
LABEL L5
MOVE(
 TEMP t133,
 TEMP t110)
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
EXP(
 CALL(
  NAME do_nothing2,
   MEM(
    TEMP t100),
   BINOP(PLUS,
    TEMP t132,
    CONST 1)))
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
LABEL L4
# ----- Assembly do_nothing1 -----
do_nothing1:
move t100, t101
addi t101, t101, -44
sw t102, 8(t101)
sw t100, 4(t101)
L5:
add t133, t110, $0
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
lw t135, 0(t100)
add t108, t135, $0
addi t136, t132, 1
add t109, t136, $0
jal do_nothing2 
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
L4:
lw t102, 8(t101)
lw t100, 4(t101)
addi t101, t101, 44
jr t102
L1 : .ascii str 
L2 : .ascii   
# ----- emit do_nothing2 -----
# ----- linearize do_nothing2 -----
LABEL L7
MOVE(
 TEMP t134,
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
 TEMP t147,
 MEM(
  TEMP t100))
MOVE(
 TEMP t146,
 CALL(
  NAME exit,
   CONST 1))
EXP(
 CALL(
  NAME do_nothing1,
   TEMP t147,
   TEMP t146,
   NAME L1))
MOVE(
 TEMP t106,
 NAME L2)
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
 NAME L6)
LABEL L6
# ----- Assembly do_nothing2 -----
do_nothing2:
move t100, t101
addi t101, t101, -44
sw t102, 8(t101)
sw t100, 4(t101)
L7:
add t134, t109, $0
sw t108, -4(t100)
sw t120, -8(t100)
sw t121, -12(t100)
sw t122, -16(t100)
sw t123, -20(t100)
sw t124, -24(t100)
sw t125, -28(t100)
sw t126, -32(t100)
sw t127, -36(t100)
lw t148, 0(t100)
add t147, t148, $0
addi t149, $0, 1
add t108, t149, $0
jal exit 
add t146, t106, $0
add t108, t147, $0
add t109, t146, $0
la t150, L1
add t110, t150, $0
jal do_nothing1 
la t151, L2
add t106, t151, $0
lw t152, -8(t100)
add t120, t152, $0
lw t153, -12(t100)
add t121, t153, $0
lw t154, -16(t100)
add t122, t154, $0
lw t155, -20(t100)
add t123, t155, $0
lw t156, -24(t100)
add t124, t156, $0
lw t157, -28(t100)
add t125, t157, $0
lw t158, -32(t100)
add t126, t158, $0
lw t159, -36(t100)
add t127, t159, $0
j L6 
L6:
lw t102, 8(t101)
lw t100, 4(t101)
addi t101, t101, 44
jr t102
L3 : .ascii str2 
# ----- emit L0 -----
# ----- linearize L0 -----
LABEL L9
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
 CALL(
  NAME do_nothing1,
   TEMP t100,
   CONST 0,
   NAME L3))
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
 NAME L8)
LABEL L8
# ----- Assembly L0 -----
L0:
move t100, t101
addi t101, t101, -44
sw t102, 8(t101)
sw t100, 4(t101)
L9:
sw t108, -4(t100)
sw t120, -8(t100)
sw t121, -12(t100)
sw t122, -16(t100)
sw t123, -20(t100)
sw t124, -24(t100)
sw t125, -28(t100)
sw t126, -32(t100)
sw t127, -36(t100)
add t108, t100, $0
addi t160, $0, 0
add t109, t160, $0
la t161, L3
add t110, t161, $0
jal do_nothing1 
add t106, t106, $0
lw t162, -8(t100)
add t120, t162, $0
lw t163, -12(t100)
add t121, t163, $0
lw t164, -16(t100)
add t122, t164, $0
lw t165, -20(t100)
add t123, t165, $0
lw t166, -24(t100)
add t124, t166, $0
lw t167, -28(t100)
add t125, t167, $0
lw t168, -32(t100)
add t126, t168, $0
lw t169, -36(t100)
add t127, t169, $0
j L8 
L8:
lw t102, 8(t101)
lw t100, 4(t101)
addi t101, t101, 44
jr t102
