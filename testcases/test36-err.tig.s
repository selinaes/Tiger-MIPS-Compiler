# ----- emit g -----
g:
move t100, t101
addi t101, t101, -44
sw t102, 8(t101)
sw t100, 4(t101)
L3:
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
j L2 
L2:
lw t102, 8(t101)
lw t100, 4(t101)
addi t101, t101, 44
jr t102
L1 : .ascii one 
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
addi t142, $0, 1
add t108, t142, $0
jal exit 
add t106, t106, $0
lw t143, -8(t100)
add t120, t143, $0
lw t144, -12(t100)
add t121, t144, $0
lw t145, -16(t100)
add t122, t145, $0
lw t146, -20(t100)
add t123, t146, $0
lw t147, -24(t100)
add t124, t147, $0
lw t148, -28(t100)
add t125, t148, $0
lw t149, -32(t100)
add t126, t149, $0
lw t150, -36(t100)
add t127, t150, $0
j L4 
L4:
lw t102, 8(t101)
lw t100, 4(t101)
addi t101, t101, 44
jr t102
