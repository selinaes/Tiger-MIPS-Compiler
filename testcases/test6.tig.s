# ----- emit do_nothing1 -----
do_nothing1:
move t100, t101
addi t101, t101, -44
sw t102, 8(t101)
sw t100, 4(t101)
L4:
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
lw t135, 0(t100)
add t108, t135, $0
addi t136, t132, 1
add t109, t136, $0
jal do_nothing2 
add t106, t106, $0
lw t137, -8(t100)
add t120, t137, $0
lw t138, -12(t100)
add t121, t138, $0
lw t139, -16(t100)
add t122, t139, $0
lw t140, -20(t100)
add t123, t140, $0
lw t141, -24(t100)
add t124, t141, $0
lw t142, -28(t100)
add t125, t142, $0
lw t143, -32(t100)
add t126, t143, $0
lw t144, -36(t100)
add t127, t144, $0
j L3 
L3:
lw t102, 8(t101)
lw t100, 4(t101)
addi t101, t101, 44
jr t102
L1 : .ascii str 
# ----- emit do_nothing2 -----
do_nothing2:
move t100, t101
addi t101, t101, -44
sw t102, 8(t101)
sw t100, 4(t101)
L6:
add t134, t109, $0
sw t108, -4(t100)
sw t120, -8(t100)
sw t121, -12(t100)
sw t122, -16(t100)
sw t123, -20(t100)
sw t124, -24(t100)
sw t125, -28(t100)
sw t126, -32(t100)
sw t127, -36(t100)
lw t145, 0(t100)
add t108, t145, $0
add t109, t134, $0
la t146, L1
add t110, t146, $0
jal do_nothing1 
add t106, t106, $0
lw t147, -8(t100)
add t120, t147, $0
lw t148, -12(t100)
add t121, t148, $0
lw t149, -16(t100)
add t122, t149, $0
lw t150, -20(t100)
add t123, t150, $0
lw t151, -24(t100)
add t124, t151, $0
lw t152, -28(t100)
add t125, t152, $0
lw t153, -32(t100)
add t126, t153, $0
lw t154, -36(t100)
add t127, t154, $0
j L5 
L5:
lw t102, 8(t101)
lw t100, 4(t101)
addi t101, t101, 44
jr t102
L2 : .ascii str2 
# ----- emit L0 -----
L0:
move t100, t101
addi t101, t101, -44
sw t102, 8(t101)
sw t100, 4(t101)
L8:
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
addi t155, $0, 0
add t109, t155, $0
la t156, L2
add t110, t156, $0
jal do_nothing1 
add t106, t106, $0
lw t157, -8(t100)
add t120, t157, $0
lw t158, -12(t100)
add t121, t158, $0
lw t159, -16(t100)
add t122, t159, $0
lw t160, -20(t100)
add t123, t160, $0
lw t161, -24(t100)
add t124, t161, $0
lw t162, -28(t100)
add t125, t162, $0
lw t163, -32(t100)
add t126, t163, $0
lw t164, -36(t100)
add t127, t164, $0
j L7 
L7:
lw t102, 8(t101)
lw t100, 4(t101)
addi t101, t101, 44
jr t102
