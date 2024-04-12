# ----- emit nfactor -----
nfactor:
move %fp, %sp
addi %sp, %sp, -44
sw %ra, 8(%sp)
sw %fp, 4(%sp)
L5:
move %a1, %a1
sw %ra, -4(%fp)
sw %a2, -8(%fp)
sw %a0, -12(%fp)
sw %v1, -16(%fp)
sw %rv, -20(%fp)
sw %at, -24(%fp)
sw %gp, -28(%fp)
sw %ra, -32(%fp)
sw %fp, -36(%fp)
addi %ra, $0, 0
beq %a1, %ra, L1
L2:
move %gp, %a1
lw %ra, 0(%fp)
move %ra, %ra
addi %a1, %a1, -1
move %a1, %a1
jal nfactor
move %ra, %ra
mul %ra, %gp, %ra
move %ra, %ra
L3:
move %ra, %ra
lw %a2, -8(%fp)
move %a2, %a2
lw %a0, -12(%fp)
move %a0, %a0
lw %v1, -16(%fp)
move %v1, %v1
lw %rv, -20(%fp)
move %rv, %rv
lw %at, -24(%fp)
move %at, %at
lw %gp, -28(%fp)
move %gp, %gp
lw %ra, -32(%fp)
move %ra, %ra
lw %fp, -36(%fp)
move %fp, %fp
j L4 
L1:
addi %ra, $0, 1
move %ra, %ra
j L3 
L4:
lw %ra, 8(%sp)
lw %fp, 4(%sp)
addi %sp, %sp, 44
jr $ra
# -------------------
nfactor:
move %fp, %sp
addi %sp, %sp, -44
sw %ra, 8(%sp)
sw %fp, 4(%sp)
L5:
sw %ra, -4(%fp)
sw %a2, -8(%fp)
sw %a0, -12(%fp)
sw %v1, -16(%fp)
sw %rv, -20(%fp)
sw %at, -24(%fp)
sw %gp, -28(%fp)
sw %ra, -32(%fp)
sw %fp, -36(%fp)
addi %ra, $0, 0
beq %a1, %ra, L1
L2:
move %gp, %a1
lw %ra, 0(%fp)
addi %a1, %a1, -1
jal nfactor
mul %ra, %gp, %ra
L3:
lw %a2, -8(%fp)
lw %a0, -12(%fp)
lw %v1, -16(%fp)
lw %rv, -20(%fp)
lw %at, -24(%fp)
lw %gp, -28(%fp)
lw %ra, -32(%fp)
lw %fp, -36(%fp)
j L4 
L1:
addi %ra, $0, 1
j L3 
L4:
lw %ra, 8(%sp)
lw %fp, 4(%sp)
addi %sp, %sp, 44
jr $ra
# ----- emit L0 -----
L0:
move %fp, %sp
addi %sp, %sp, -44
sw %ra, 8(%sp)
sw %fp, 4(%sp)
L7:
sw %a0, -4(%fp)
sw %a1, -8(%fp)
sw %a0, -12(%fp)
sw %v1, -16(%fp)
sw %rv, -20(%fp)
sw %at, -24(%fp)
sw %gp, -28(%fp)
sw %ra, -32(%fp)
sw %fp, -36(%fp)
move %a0, %fp
addi %ra, $0, 10
move %ra, %ra
jal nfactor
move %rv, %rv
lw %a1, -8(%fp)
move %a1, %a1
lw %a0, -12(%fp)
move %a0, %a0
lw %v1, -16(%fp)
move %v1, %v1
lw %rv, -20(%fp)
move %rv, %rv
lw %at, -24(%fp)
move %at, %at
lw %gp, -28(%fp)
move %gp, %gp
lw %ra, -32(%fp)
move %ra, %ra
lw %fp, -36(%fp)
move %fp, %fp
j L6 
L6:
lw %ra, 8(%sp)
lw %fp, 4(%sp)
addi %sp, %sp, 44
jr $ra
# -------------------
L0:
move %fp, %sp
addi %sp, %sp, -44
sw %ra, 8(%sp)
sw %fp, 4(%sp)
L7:
sw %a0, -4(%fp)
sw %a1, -8(%fp)
sw %a0, -12(%fp)
sw %v1, -16(%fp)
sw %rv, -20(%fp)
sw %at, -24(%fp)
sw %gp, -28(%fp)
sw %ra, -32(%fp)
sw %fp, -36(%fp)
move %a0, %fp
addi %ra, $0, 10
jal nfactor
lw %a1, -8(%fp)
lw %a0, -12(%fp)
lw %v1, -16(%fp)
lw %rv, -20(%fp)
lw %at, -24(%fp)
lw %gp, -28(%fp)
lw %ra, -32(%fp)
lw %fp, -36(%fp)
j L6 
L6:
lw %ra, 8(%sp)
lw %fp, 4(%sp)
addi %sp, %sp, 44
jr $ra
