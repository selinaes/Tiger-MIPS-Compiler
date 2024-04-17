# ----- emit nfactor -----
L5:
move t132, t119
sw t118, -4(t122)
sw t110, -8(t122)
sw t111, -12(t122)
sw t112, -16(t122)
sw t113, -20(t122)
sw t114, -24(t122)
sw t115, -28(t122)
sw t116, -32(t122)
sw t117, -36(t122)
addi t136, $0, 0
beq t132, t136, L1
L2:
move t135, t132
lw t137, 0(t122)
move t118, t137
addi t138, t132, -1
move t119, t138
jal nfactor
move t134, t128
mul t139, t135, t134
move t133, t139
L3:
move t128, t133
lw t140, -8(t122)
move t110, t140
lw t141, -12(t122)
move t111, t141
lw t142, -16(t122)
move t112, t142
lw t143, -20(t122)
move t113, t143
lw t144, -24(t122)
move t114, t144
lw t145, -28(t122)
move t115, t145
lw t146, -32(t122)
move t116, t146
lw t147, -36(t122)
move t117, t147
j L4 
L1:
addi t148, $0, 1
move t133, t148
j L3 
L4:
# -------------------
nfactor:
move %fp, %sp
addi %sp, %sp, -44
sw %ra, 8(%sp)
sw %fp, 4(%sp)
L5:
move %a1, %a1
sw %a0, -4(%fp)
sw %s0, -8(%fp)
sw %s1, -12(%fp)
sw %s2, -16(%fp)
sw %s3, -20(%fp)
sw %s4, -24(%fp)
sw %s5, -28(%fp)
sw %s6, -32(%fp)
sw %s7, -36(%fp)
addi %t0, $0, 0
beq %a1, %t0, L1
L2:
move %t0, %a1
lw %a0, 0(%fp)
move %a0, %a0
addi %a1, %a1, -1
move %a1, %a1
jal nfactor
move %rv, %rv
mul %rv, %t0, %rv
move %rv, %rv
L3:
move %rv, %rv
lw %s0, -8(%fp)
move %s0, %s0
lw %s1, -12(%fp)
move %s1, %s1
lw %s2, -16(%fp)
move %s2, %s2
lw %s3, -20(%fp)
move %s3, %s3
lw %s4, -24(%fp)
move %s4, %s4
lw %s5, -28(%fp)
move %s5, %s5
lw %s6, -32(%fp)
move %s6, %s6
lw %s7, -36(%fp)
move %s7, %s7
j L4 
L1:
addi %rv, $0, 1
move %rv, %rv
j L3 
L4:
lw %ra, 8(%sp)
lw %fp, 4(%sp)
addi %sp, %sp, 44
jr $ra
# ----- emit L0 -----
L7:
sw t118, -4(t122)
sw t110, -8(t122)
sw t111, -12(t122)
sw t112, -16(t122)
sw t113, -20(t122)
sw t114, -24(t122)
sw t115, -28(t122)
sw t116, -32(t122)
sw t117, -36(t122)
move t118, t122
addi t149, $0, 10
move t119, t149
jal nfactor
move t128, t128
lw t150, -8(t122)
move t110, t150
lw t151, -12(t122)
move t111, t151
lw t152, -16(t122)
move t112, t152
lw t153, -20(t122)
move t113, t153
lw t154, -24(t122)
move t114, t154
lw t155, -28(t122)
move t115, t155
lw t156, -32(t122)
move t116, t156
lw t157, -36(t122)
move t117, t157
j L6 
L6:
# -------------------
L0:
move %fp, %sp
addi %sp, %sp, -44
sw %ra, 8(%sp)
sw %fp, 4(%sp)
L7:
sw %a0, -4(%fp)
sw %s0, -8(%fp)
sw %s1, -12(%fp)
sw %s2, -16(%fp)
sw %s3, -20(%fp)
sw %s4, -24(%fp)
sw %s5, -28(%fp)
sw %s6, -32(%fp)
sw %s7, -36(%fp)
move %a0, %fp
addi %a1, $0, 10
move %a1, %a1
jal nfactor
move %rv, %rv
lw %s0, -8(%fp)
move %s0, %s0
lw %s1, -12(%fp)
move %s1, %s1
lw %s2, -16(%fp)
move %s2, %s2
lw %s3, -20(%fp)
move %s3, %s3
lw %s4, -24(%fp)
move %s4, %s4
lw %s5, -28(%fp)
move %s5, %s5
lw %s6, -32(%fp)
move %s6, %s6
lw %s7, -36(%fp)
move %s7, %s7
j L6 
L6:
lw %ra, 8(%sp)
lw %fp, 4(%sp)
addi %sp, %sp, 44
jr $ra
