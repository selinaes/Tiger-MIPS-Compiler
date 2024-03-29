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
L3:
addi t133, $0, 10
addi t134, $0, 5
bgt t133, t134, L2
L1:
addi t135, $0, 0
add t106, t135, $0
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
L2:
addi t144, $0, 1
add t108, t144, $0
jal exit 
add t132, t106, $0
addi t145, t132, 1
j L3 
L4:
lw t102, 8(t101)
lw t100, 4(t101)
addi t101, t101, 44
jr t102
