L1 : .ascii aname 
# ----- emit L0 -----
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
addi t136, $0, 8
add t108, t136, $0
jal malloc 
add t132, t106, $0
la t137, L1
sw t137, 0(t132)
addi t138, $0, 0
sw t138, 4(t132)
add t133, t132, $0
addi t139, $0, 3
add t108, t139, $0
addi t140, $0, 0
add t109, t140, $0
jal initArray 
add t134, t106, $0
bne t133, t134, L2
L3:
addi t141, $0, 4
add t135, t141, $0
L4:
add t106, t135, $0
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
j L5 
L2:
addi t150, $0, 3
add t135, t150, $0
j L4 
L5:
lw t102, 8(t101)
lw t100, 4(t101)
addi t101, t101, 44
jr t102
