L1 : .ascii Nobody 
L2 : .ascii Somebody 
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
addi t134, $0, 8
add t108, t134, $0
jal malloc 
add t132, t106, $0
la t135, L1
sw t135, 0(t132)
addi t136, $0, 1000
sw t136, 4(t132)
add t133, t132, $0
la t137, L2
sw t137, 0(t133)
addi t138, $0, 900
sw t138, 4(t133)
add t106, t133, $0
lw t139, -8(t100)
add t120, t139, $0
lw t140, -12(t100)
add t121, t140, $0
lw t141, -16(t100)
add t122, t141, $0
lw t142, -20(t100)
add t123, t142, $0
lw t143, -24(t100)
add t124, t143, $0
lw t144, -28(t100)
add t125, t144, $0
lw t145, -32(t100)
add t126, t145, $0
lw t146, -36(t100)
add t127, t146, $0
j L3 
L3:
lw t102, 8(t101)
lw t100, 4(t101)
addi t101, t101, 44
jr t102
