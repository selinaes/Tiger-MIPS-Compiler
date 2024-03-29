L2 : .ascii   
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
addi t133, $0, 10
add t132, t133, $0
la t134, L2
ble t132, t134, L3
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
j L5 
L4:
addi t144, t132, 1
add t132, t144, $0
L3:
addi t145, t132, -1
add t132, t145, $0
la t146, L2
blt t132, t146, L4
L7:
j L1 
L5:
lw t102, 8(t101)
lw t100, 4(t101)
addi t101, t101, 44
jr t102
