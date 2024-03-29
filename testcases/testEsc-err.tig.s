# ----- emit y -----
y:
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
lw t137, 0(t100)
lw t136, -8(t137)
addi t135, t136, 1
add t106, t135, $0
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
j L7 
L7:
lw t102, 8(t101)
lw t100, 4(t101)
addi t101, t101, 44
jr t102
# ----- emit x -----
x:
move t100, t101
addi t101, t101, -48
sw t102, 8(t101)
sw t100, 4(t101)
L10:
sw t109, -8(t100)
sw t108, -4(t100)
sw t120, -12(t100)
sw t121, -16(t100)
sw t122, -20(t100)
sw t123, -24(t100)
sw t124, -28(t100)
sw t125, -32(t100)
sw t126, -36(t100)
sw t127, -40(t100)
addi t146, $0, 0
add t106, t146, $0
lw t147, -12(t100)
add t120, t147, $0
lw t148, -16(t100)
add t121, t148, $0
lw t149, -20(t100)
add t122, t149, $0
lw t150, -24(t100)
add t123, t150, $0
lw t151, -28(t100)
add t124, t151, $0
lw t152, -32(t100)
add t125, t152, $0
lw t153, -36(t100)
add t126, t153, $0
lw t154, -40(t100)
add t127, t154, $0
j L9 
L9:
lw t102, 8(t101)
lw t100, 4(t101)
addi t101, t101, 48
jr t102
# ----- emit z -----
z:
move t100, t101
addi t101, t101, -44
sw t102, 8(t101)
sw t100, 4(t101)
L12:
add t133, t109, $0
sw t108, -4(t100)
sw t120, -8(t100)
sw t121, -12(t100)
sw t122, -16(t100)
sw t123, -20(t100)
sw t124, -24(t100)
sw t125, -28(t100)
sw t126, -32(t100)
sw t127, -36(t100)
add t134, t133, $0
addi t155, $0, 8
ble t134, t155, L5
L4:
addi t156, $0, 0
add t106, t156, $0
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
j L11 
L6:
addi t165, t134, 1
add t134, t165, $0
L5:
lw t168, 0(t100)
lw t167, -8(t168)
add t166, t134, t167
addi t169, $0, 8
blt t134, t169, L6
L13:
j L4 
L11:
lw t102, 8(t101)
lw t100, 4(t101)
addi t101, t101, 44
jr t102
# ----- emit L0 -----
L0:
move t100, t101
addi t101, t101, -48
sw t102, 8(t101)
sw t100, 4(t101)
L15:
sw t108, -4(t100)
sw t120, -12(t100)
sw t121, -16(t100)
sw t122, -20(t100)
sw t123, -24(t100)
sw t124, -28(t100)
sw t125, -32(t100)
sw t126, -36(t100)
sw t127, -40(t100)
addi t170, $0, 3
sw t170, -8(t100)
addi t171, $0, 3
add t132, t171, $0
L3:
addi t172, $0, 7
blt t132, t172, L2
L1:
addi t173, $0, 1
add t108, t173, $0
jal exit 
add t106, t106, $0
lw t174, -12(t100)
add t120, t174, $0
lw t175, -16(t100)
add t121, t175, $0
lw t176, -20(t100)
add t122, t176, $0
lw t177, -24(t100)
add t123, t177, $0
lw t178, -28(t100)
add t124, t178, $0
lw t179, -32(t100)
add t125, t179, $0
lw t180, -36(t100)
add t126, t180, $0
lw t181, -40(t100)
add t127, t181, $0
j L14 
L2:
j L3 
L14:
lw t102, 8(t101)
lw t100, 4(t101)
addi t101, t101, 48
jr t102
