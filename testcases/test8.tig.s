# ----- emit L0 -----
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
addi t133, $0, 10
addi t134, $0, 20
bgt t133, t134, L1
L2:
addi t135, $0, 40
add t132, t135, $0
L3:
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
j L4 
L1:
addi t144, $0, 30
add t132, t144, $0
j L3 
L4:
lw t102, 8(t101)
lw t100, 4(t101)
addi t101, t101, 44
jr t102
