# ----- emit nfactor -----
# -------------------
nfactor:
move %fp, %sp
addi %sp, %sp, -44
sw %ra, 8(%sp)
sw %fp, 4(%sp)
L5:
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
addi %a1, %a1, -1
jal nfactor
mul %rv, %t0, %rv
L3:
lw %s0, -8(%fp)
lw %s1, -12(%fp)
lw %s2, -16(%fp)
lw %s3, -20(%fp)
lw %s4, -24(%fp)
lw %s5, -28(%fp)
lw %s6, -32(%fp)
lw %s7, -36(%fp)
j L4 
L1:
addi %rv, $0, 1
j L3 
L4:
lw %ra, 8(%sp)
lw %fp, 4(%sp)
addi %sp, %sp, 44
jr $ra
# ----- emit L0 -----
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
jal nfactor
lw %s0, -8(%fp)
lw %s1, -12(%fp)
lw %s2, -16(%fp)
lw %s3, -20(%fp)
lw %s4, -24(%fp)
lw %s5, -28(%fp)
lw %s6, -32(%fp)
lw %s7, -36(%fp)
j L6 
L6:
lw %ra, 8(%sp)
lw %fp, 4(%sp)
addi %sp, %sp, 44
jr $ra
