# ----- emit L0 -----
L0:
move %fp, %sp
addi %sp, %sp, -72
sw %ra, 8(%sp)
sw %fp, 4(%sp)
L2:
sw %a0, -4(%fp)
sw %s0, -8(%fp)
sw %s1, -12(%fp)
sw %s2, -16(%fp)
sw %s3, -20(%fp)
sw %s4, -24(%fp)
sw %s5, -28(%fp)
sw %s6, -32(%fp)
sw %s7, -36(%fp)
addi %t0, $0, 1
sw %t0, -40(%fp)
addi %t0, $0, 2
sw %t0, -44(%fp)
addi %t0, $0, 3
sw %t0, -48(%fp)
addi %t0, $0, 4
sw %t0, -52(%fp)
addi %t0, $0, 5
sw %t0, -56(%fp)
addi %t0, $0, 6
sw %t0, -60(%fp)
addi %t0, $0, 7
sw %t0, -64(%fp)
addi %v1, $0, 8
addi %rv, $0, 9
addi %at, $0, 10
addi %gp, $0, 11
addi %a3, $0, 12
addi %a2, $0, 13
addi %a1, $0, 14
addi %a0, $0, 15
addi %s7, $0, 16
addi %s6, $0, 17
addi %s5, $0, 18
addi %s4, $0, 19
addi %s3, $0, 20
addi %s2, $0, 21
addi %s1, $0, 22
addi %s0, $0, 23
addi %t9, $0, 24
addi %t8, $0, 25
addi %t7, $0, 26
addi %t6, $0, 27
addi %t5, $0, 28
addi %t4, $0, 29
addi %t3, $0, 30
addi %t2, $0, 31
addi %t1, $0, 32
addi %t0, $0, 33
lw %k0, -40(%fp)
lw %k1, -44(%fp)
add %k1, %k0, %k1
lw %k0, -48(%fp)
add %k1, %k1, %k0
lw %k0, -52(%fp)
add %k1, %k1, %k0
lw %k0, -56(%fp)
add %k1, %k1, %k0
lw %k0, -60(%fp)
add %k1, %k1, %k0
lw %k0, -64(%fp)
add %k0, %k1, %k0
add %v1, %k0, %v1
add %rv, %v1, %rv
add %at, %rv, %at
add %gp, %at, %gp
add %a3, %gp, %a3
add %a2, %a3, %a2
add %a1, %a2, %a1
add %a0, %a1, %a0
add %s7, %a0, %s7
add %s6, %s7, %s6
add %s5, %s6, %s5
add %s4, %s5, %s4
add %s3, %s4, %s3
add %s2, %s3, %s2
add %s1, %s2, %s1
add %s0, %s1, %s0
add %t9, %s0, %t9
add %t8, %t9, %t8
add %t7, %t8, %t7
add %t6, %t7, %t6
add %t5, %t6, %t5
add %t4, %t5, %t4
add %t3, %t4, %t3
add %t2, %t3, %t2
add %t1, %t2, %t1
add %rv, %t1, %t0
lw %s0, -8(%fp)
lw %s1, -12(%fp)
lw %s2, -16(%fp)
lw %s3, -20(%fp)
lw %s4, -24(%fp)
lw %s5, -28(%fp)
lw %s6, -32(%fp)
lw %s7, -36(%fp)
j L1 
L1:
lw %ra, 8(%sp)
lw %fp, 4(%sp)
addi %sp, %sp, 72
jr $ra
