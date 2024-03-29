# ----- emit do_nothing1 -----
do_nothing1:
move t100, t101
addi t101, t101, -44
sw t102, 8(t101)
sw t100, 4(t101)
L5:
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
addi t136, $0, 1
add t108, t136, $0
jal exit 
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
L4:
lw t102, 8(t101)
lw t100, 4(t101)
addi t101, t101, 44
jr t102
L1 : .ascii str 
L2 : .ascii   
# ----- emit do_nothing2 -----
do_nothing2:
move t100, t101
addi t101, t101, -44
sw t102, 8(t101)
sw t100, 4(t101)
L7:
add t135, t109, $0
sw t108, -4(t100)
sw t120, -8(t100)
sw t121, -12(t100)
sw t122, -16(t100)
sw t123, -20(t100)
sw t124, -24(t100)
sw t125, -28(t100)
sw t126, -32(t100)
sw t127, -36(t100)
lw t146, 0(t100)
add t108, t146, $0
add t109, t135, $0
la t147, L1
add t110, t147, $0
jal do_nothing1 
la t148, L2
add t106, t148, $0
lw t149, -8(t100)
add t120, t149, $0
lw t150, -12(t100)
add t121, t150, $0
lw t151, -16(t100)
add t122, t151, $0
lw t152, -20(t100)
add t123, t152, $0
lw t153, -24(t100)
add t124, t153, $0
lw t154, -28(t100)
add t125, t154, $0
lw t155, -32(t100)
add t126, t155, $0
lw t156, -36(t100)
add t127, t156, $0
j L6 
L6:
lw t102, 8(t101)
lw t100, 4(t101)
addi t101, t101, 44
jr t102
L3 : .ascii str2 
# ----- emit L0 -----
L0:
move t100, t101
addi t101, t101, -44
sw t102, 8(t101)
sw t100, 4(t101)
L9:
sw t108, -4(t100)
sw t120, -8(t100)
sw t121, -12(t100)
sw t122, -16(t100)
sw t123, -20(t100)
sw t124, -24(t100)
sw t125, -28(t100)
sw t126, -32(t100)
sw t127, -36(t100)
addi t157, $0, 0
add t134, t157, $0
add t108, t100, $0
addi t158, $0, 0
add t109, t158, $0
la t159, L3
add t110, t159, $0
jal do_nothing1 
add t106, t106, $0
lw t160, -8(t100)
add t120, t160, $0
lw t161, -12(t100)
add t121, t161, $0
lw t162, -16(t100)
add t122, t162, $0
lw t163, -20(t100)
add t123, t163, $0
lw t164, -24(t100)
add t124, t164, $0
lw t165, -28(t100)
add t125, t165, $0
lw t166, -32(t100)
add t126, t166, $0
lw t167, -36(t100)
add t127, t167, $0
j L8 
L8:
lw t102, 8(t101)
lw t100, 4(t101)
addi t101, t101, 44
jr t102
