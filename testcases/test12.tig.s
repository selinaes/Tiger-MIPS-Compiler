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
addi t134, $0, 0
add t132, t134, $0
addi t135, $0, 0
add t133, t135, $0
addi t136, $0, 100
ble t133, t136, L2
L1:
addi t137, $0, 0
add t106, t137, $0
lw t138, -8(t100)
add t120, t138, $0
lw t139, -12(t100)
add t121, t139, $0
lw t140, -16(t100)
add t122, t140, $0
lw t141, -20(t100)
add t123, t141, $0
lw t142, -24(t100)
add t124, t142, $0
lw t143, -28(t100)
add t125, t143, $0
lw t144, -32(t100)
add t126, t144, $0
lw t145, -36(t100)
add t127, t145, $0
j L4 
L3:
addi t146, t133, 1
add t133, t146, $0
L2:
addi t147, t132, 1
add t132, t147, $0
addi t148, $0, 100
blt t133, t148, L3
L6:
j L1 
L4:
lw t102, 8(t101)
lw t100, 4(t101)
addi t101, t101, 44
jr t102
