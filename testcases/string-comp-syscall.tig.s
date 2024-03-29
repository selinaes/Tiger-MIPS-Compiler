L1 : .ascii a 
L2 : .ascii b 
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
la t132, L1
add t108, t132, $0
la t133, L2
add t109, t133, $0
jal stringGt 
add t106, t106, $0
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
j L3 
L3:
lw t102, 8(t101)
lw t100, 4(t101)
addi t101, t101, 44
jr t102
