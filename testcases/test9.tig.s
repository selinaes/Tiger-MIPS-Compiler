L1 : .ascii   
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
CJUMP(GT,
 CONST 5,
 CONST 4,
 L2,L3)
LABEL L3
MOVE(
 TEMP t132,
 NAME L1)
LABEL L4
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
 NAME L5)
LABEL L2
MOVE(
 TEMP t132,
 CONST 13)
JUMP(
 NAME L4)
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
addi t133, $0, 5
addi t134, $0, 4
bgt t133, t134, L2
L3:
la t135, L1
add t132, t135, $0
L4:
add t106, t132, $0
lw t136, -8(t100)
add t120, t136, $0
lw t137, -12(t100)
add t121, t137, $0
lw t138, -16(t100)
add t122, t138, $0
lw t139, -20(t100)
add t123, t139, $0
lw t140, -24(t100)
add t124, t140, $0
lw t141, -28(t100)
add t125, t141, $0
lw t142, -32(t100)
add t126, t142, $0
lw t143, -36(t100)
add t127, t143, $0
j L5 
L2:
addi t144, $0, 13
add t132, t144, $0
j L4 
L5:
lw t102, 8(t101)
lw t100, 4(t101)
addi t101, t101, 44
jr t102
