# ----- emit L0 -----
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
addi t132, $0, 20
addi t133, $0, 0
bne t132, t133, L1
L2:
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
j L3 
L1:
j L2 
L3:
lw t102, 8(t101)
lw t100, 4(t101)
addi t101, t101, 44
jr t102
