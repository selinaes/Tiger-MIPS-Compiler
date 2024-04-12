# ----- emit L0 -----
L0:
move t100, t101
addi t101, t101, -44
sw t102, 8(t101)
sw t100, 4(t101)
L2:
sw t108, -4(t100)
sw t120, -8(t100)
sw t121, -12(t100)
sw t122, -16(t100)
sw t123, -20(t100)
sw t124, -24(t100)
sw t125, -28(t100)
sw t126, -32(t100)
sw t127, -36(t100)
addi t136, $0, 10
move t133, t132
addi t137, t133, 10
addi t138, t132, 10
addi t139, $0, 0
lw t140, -8(t100)
lw t141, -12(t100)
lw t142, -16(t100)
lw t143, -20(t100)
lw t144, -24(t100)
lw t145, -28(t100)
lw t146, -32(t100)
lw t147, -36(t100)
j L1 
L1:
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
L2:
sw %a0, -4(%fp)
sw %t2, -8(%fp)
sw %t1, -12(%fp)
sw %t0, -16(%fp)
sw %a3, -20(%fp)
sw %a2, -24(%fp)
sw %a1, -28(%fp)
sw %v1, -32(%fp)
sw %rv, -36(%fp)
addi %rv, $0, 10
move %ra, %rv
addi %ra, %ra, 10
addi %ra, %rv, 10
addi %ra, $0, 0
lw %t2, -8(%fp)
lw %t1, -12(%fp)
lw %t0, -16(%fp)
lw %a3, -20(%fp)
lw %a2, -24(%fp)
lw %a1, -28(%fp)
lw %v1, -32(%fp)
lw %rv, -36(%fp)
j L1 
L1:
lw %ra, 8(%sp)
lw %fp, 4(%sp)
addi %sp, %sp, 44
jr $ra
