# ----- emit g -----
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
lw t133, -8(t100)
add t120, t133, $0
lw t134, -12(t100)
add t121, t134, $0
lw t135, -16(t100)
add t122, t135, $0
lw t136, -20(t100)
add t123, t136, $0
lw t137, -24(t100)
add t124, t137, $0
lw t138, -28(t100)
add t125, t138, $0
lw t139, -32(t100)
add t126, t139, $0
lw t140, -36(t100)
add t127, t140, $0
j L1 
L1:
lw t102, 8(t101)
lw t100, 4(t101)
addi t101, t101, 44
jr t102
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
add t108, t100, $0
addi t141, $0, 2
add t109, t141, $0
jal g 
add t106, t106, $0
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
