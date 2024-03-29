L1 : .ascii df 
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
addi t133, $0, 1
add t132, t133, $0
addi t134, $0, 3
la t135, L1
bgt t134, t135, L2
L3:
addi t136, $0, 0
add t132, t136, $0
L2:
add t106, t132, $0
lw t137, -8(t100)
add t120, t137, $0
lw t138, -12(t100)
add t121, t138, $0
lw t139, -16(t100)
add t122, t139, $0
lw t140, -20(t100)
add t123, t140, $0
lw t141, -24(t100)
add t124, t141, $0
lw t142, -28(t100)
add t125, t142, $0
lw t143, -32(t100)
add t126, t143, $0
lw t144, -36(t100)
add t127, t144, $0
j L4 
L4:
lw t102, 8(t101)
lw t100, 4(t101)
addi t101, t101, 44
jr t102
