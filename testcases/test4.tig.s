# ----- emit nfactor -----
nfactor:
move t100, t101
addi t101, t101, -44
sw t102, 8(t101)
sw t100, 4(t101)
L5:
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
addi t136, $0, 0
beq t132, t136, L1
L2:
add t135, t132, $0
lw t137, 0(t100)
add t108, t137, $0
addi t138, t132, -1
add t109, t138, $0
jal nfactor
add t134, t106, $0
mul t139, t135, t134
add t133, t139, $0
L3:
add t106, t133, $0
lw t140, -8(t100)
add t120, t140, $0
lw t141, -12(t100)
add t121, t141, $0
lw t142, -16(t100)
add t122, t142, $0
lw t143, -20(t100)
add t123, t143, $0
lw t144, -24(t100)
add t124, t144, $0
lw t145, -28(t100)
add t125, t145, $0
lw t146, -32(t100)
add t126, t146, $0
lw t147, -36(t100)
add t127, t147, $0
j L4 
L1:
addi t148, $0, 1
add t133, t148, $0
j L3 
L4:
lw t102, 8(t101)
lw t100, 4(t101)
addi t101, t101, 44
jr $ra
# -------------------
nfactor:
move %fp, %sp
addi %sp, %sp, -44
sw %ra, 8(%sp)
sw %fp, 4(%sp)
L5:
add %rv, %a1, $0
sw %a0, -4(%fp)
sw %s0, -8(%fp)
sw %s1, -12(%fp)
sw %s2, -16(%fp)
sw %s3, -20(%fp)
sw %s4, -24(%fp)
sw %s5, -28(%fp)
sw %s6, -32(%fp)
sw %s7, -36(%fp)
addi %ra, $0, 0
beq %rv, %ra, L1
L2:
add %v1, %rv, $0
lw %ra, 0(%fp)
add %a0, %ra, $0
addi %ra, %rv, -1
add %a1, %ra, $0
jal nfactor
add %ra, %rv, $0
mul %ra, %v1, %ra
add %ra, %ra, $0
L3:
add %rv, %ra, $0
lw %ra, -8(%fp)
add %s0, %ra, $0
lw %ra, -12(%fp)
add %s1, %ra, $0
lw %ra, -16(%fp)
add %s2, %ra, $0
lw %ra, -20(%fp)
add %s3, %ra, $0
lw %ra, -24(%fp)
add %s4, %ra, $0
lw %ra, -28(%fp)
add %s5, %ra, $0
lw %ra, -32(%fp)
add %s6, %ra, $0
lw %fp, -36(%fp)
add %s7, %fp, $0
j L4 
L1:
addi %ra, $0, 1
add %ra, %ra, $0
j L3 
L4:
lw %ra, 8(%sp)
lw %fp, 4(%sp)
addi %sp, %sp, 44
jr $ra
# ----- emit L0 -----
L0:
move t100, t101
addi t101, t101, -44
sw t102, 8(t101)
sw t100, 4(t101)
L7:
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
addi t149, $0, 10
add t109, t149, $0
jal nfactor
add t106, t106, $0
lw t150, -8(t100)
add t120, t150, $0
lw t151, -12(t100)
add t121, t151, $0
lw t152, -16(t100)
add t122, t152, $0
lw t153, -20(t100)
add t123, t153, $0
lw t154, -24(t100)
add t124, t154, $0
lw t155, -28(t100)
add t125, t155, $0
lw t156, -32(t100)
add t126, t156, $0
lw t157, -36(t100)
add t127, t157, $0
j L6 
L6:
lw t102, 8(t101)
lw t100, 4(t101)
addi t101, t101, 44
jr $ra
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
add %a0, %fp, $0
addi %ra, $0, 10
add %a1, %ra, $0
jal nfactor
add %rv, %rv, $0
lw %ra, -8(%fp)
add %s0, %ra, $0
lw %ra, -12(%fp)
add %s1, %ra, $0
lw %ra, -16(%fp)
add %s2, %ra, $0
lw %ra, -20(%fp)
add %s3, %ra, $0
lw %ra, -24(%fp)
add %s4, %ra, $0
lw %ra, -28(%fp)
add %s5, %ra, $0
lw %ra, -32(%fp)
add %s6, %ra, $0
lw %fp, -36(%fp)
add %s7, %fp, $0
j L6 
L6:
lw %ra, 8(%sp)
lw %fp, 4(%sp)
addi %sp, %sp, 44
jr $ra
