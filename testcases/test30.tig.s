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
addi t135, $0, 10
add t108, t135, $0
addi t136, $0, 0
add t109, t136, $0
jal initArray 
add t132, t106, $0
addi t137, $0, 2
add t133, t137, $0
lw t138, -4(t132)
add t134, t138, $0
bge t133, t134, L1
L2:
addi t139, $0, 0
blt t133, t139, L1
L3:
addi t143, $0, 2
addi t144, $0, 4
mul t142, t143, t144
add t141, t132, t142
lw t140, 0(t141)
add t106, t140, $0
lw t145, -8(t100)
add t120, t145, $0
lw t146, -12(t100)
add t121, t146, $0
lw t147, -16(t100)
add t122, t147, $0
lw t148, -20(t100)
add t123, t148, $0
lw t149, -24(t100)
add t124, t149, $0
lw t150, -28(t100)
add t125, t150, $0
lw t151, -32(t100)
add t126, t151, $0
lw t152, -36(t100)
add t127, t152, $0
j L4 
L1:
addi t153, $0, 1
add t108, t153, $0
jal exit 
j L3 
L4:
lw t102, 8(t101)
lw t100, 4(t101)
addi t101, t101, 44
jr t102
