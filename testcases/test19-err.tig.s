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
lw t135, 0(t100)
add t108, t135, $0
addi t136, t132, 1
add t109, t136, $0
jal do_nothing2 
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
lw t148, 0(t100)
add t147, t148, $0
addi t149, $0, 1
add t108, t149, $0
jal exit 
add t146, t106, $0
add t108, t147, $0
add t109, t146, $0
la t150, L1
add t110, t150, $0
jal do_nothing1 
la t151, L2
add t106, t151, $0
lw t152, -8(t100)
add t120, t152, $0
lw t153, -12(t100)
add t121, t153, $0
lw t154, -16(t100)
add t122, t154, $0
lw t155, -20(t100)
add t123, t155, $0
lw t156, -24(t100)
add t124, t156, $0
lw t157, -28(t100)
add t125, t157, $0
lw t158, -32(t100)
add t126, t158, $0
lw t159, -36(t100)
add t127, t159, $0
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
add t108, t100, $0
addi t160, $0, 0
add t109, t160, $0
la t161, L3
add t110, t161, $0
jal do_nothing1 
add t106, t106, $0
lw t162, -8(t100)
add t120, t162, $0
lw t163, -12(t100)
add t121, t163, $0
lw t164, -16(t100)
add t122, t164, $0
lw t165, -20(t100)
add t123, t165, $0
lw t166, -24(t100)
add t124, t166, $0
lw t167, -28(t100)
add t125, t167, $0
lw t168, -32(t100)
add t126, t168, $0
lw t169, -36(t100)
add t127, t169, $0
j L8 
L8:
lw t102, 8(t101)
lw t100, 4(t101)
addi t101, t101, 44
jr t102
