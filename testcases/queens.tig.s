	#.file	1 "runtime.c"
	.option pic2
	.text
	.align 4
	.globl	tig_initArray
	.ent	tig_initArray
tig_initArray:
.LFB1:
	.frame	$fp,64,$ra		# vars= 16, regs= 3/0, args= 0, extra= 16
	.mask	0xd0000000,-16
	.fmask	0x00000000,0
	subu	$sp,$sp,64
.LCFI0:
	sd	$ra,48($sp)
.LCFI1:
	sd	$fp,40($sp)
.LCFI2:
.LCFI3:
	move	$fp,$sp
.LCFI4:
	.set	noat
	.set	at
	sw	$a0,16($fp)
	sw	$a1,20($fp)
	lw	$v1,16($fp)
	addu	$v0,$v1,1
	move	$v1,$v0
	sll	$v0,$v1,2
	move	$a0,$v0
	la	$t9,malloc
	jal	$ra,$t9
	sw	$v0,28($fp)
	lw	$v0,28($fp)
	lw	$v1,16($fp)
	sw	$v1,0($v0)
	li	$v0,1			# 0x1
	sw	$v0,24($fp)
.L3:
	lw	$v1,16($fp)
	addu	$v0,$v1,1
	lw	$v1,24($fp)
	slt	$v0,$v1,$v0
	bne	$v0,$zero,.L6
	b	.L4
.L6:
	lw	$v0,24($fp)
	move	$v1,$v0
	sll	$v0,$v1,2
	lw	$v1,28($fp)
	addu	$v0,$v0,$v1
	lw	$v1,20($fp)
	sw	$v1,0($v0)
.L5:
	lw	$v0,24($fp)
	addu	$v1,$v0,1
	sw	$v1,24($fp)
	b	.L3
.L4:
	lw	$v1,28($fp)
	move	$v0,$v1
	b	.L2
.L2:
	move	$sp,$fp
	ld	$ra,48($sp)
	ld	$fp,40($sp)
	addu	$sp,$sp,64
	j	$ra
.LFE1:
	.end	tig_initArray
	.align 4
	.globl	tig_allocRecord
	.ent	tig_allocRecord
tig_allocRecord:
.LFB2:
	.frame	$fp,64,$ra		# vars= 16, regs= 3/0, args= 0, extra= 16
	.mask	0xd0000000,-16
	.fmask	0x00000000,0
	subu	$sp,$sp,64
.LCFI5:
	sd	$ra,48($sp)
.LCFI6:
	sd	$fp,40($sp)
.LCFI7:
.LCFI8:
	move	$fp,$sp
.LCFI9:
	.set	noat
	.set	at
	sw	$a0,16($fp)
	lw	$a0,16($fp)
	la	$t9,malloc
	jal	$ra,$t9
	move	$v1,$v0
	move	$v0,$v1
	sw	$v0,28($fp)
	sw	$v0,24($fp)
	sw	$zero,20($fp)
.L8:
	lw	$v0,20($fp)
	lw	$v1,16($fp)
	slt	$v0,$v0,$v1
	bne	$v0,$zero,.L11
	b	.L9
.L11:
	addu	$v0,$fp,24
	lw	$v1,0($v0)
	sw	$zero,0($v1)
	addu	$v1,$v1,4
	sw	$v1,0($v0)
.L10:
	lw	$v0,20($fp)
	addu	$v1,$v0,4
	sw	$v1,20($fp)
	b	.L8
.L9:
	lw	$v1,28($fp)
	move	$v0,$v1
	b	.L7
.L7:
	move	$sp,$fp
	ld	$ra,48($sp)
	ld	$fp,40($sp)
	addu	$sp,$sp,64
	j	$ra
.LFE2:
	.end	tig_allocRecord
	.align 4
	.globl	tig_stringEqual
	.ent	tig_stringEqual
tig_stringEqual:
.LFB3:
	.frame	$fp,48,$ra		# vars= 16, regs= 2/0, args= 0, extra= 16
	.mask	0x50000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
.LCFI10:
	sd	$fp,40($sp)
.LCFI11:
.LCFI12:
	move	$fp,$sp
.LCFI13:
	.set	noat
	.set	at
	sw	$a0,16($fp)
	sw	$a1,20($fp)
	lw	$v0,16($fp)
	lw	$v1,20($fp)
	bne	$v0,$v1,.L13
	li	$v0,1			# 0x1
	b	.L12
.L13:
	lw	$v0,16($fp)
	lw	$v1,20($fp)
	lw	$v0,0($v0)
	lw	$v1,0($v1)
	beq	$v0,$v1,.L14
	move	$v0,$zero
	b	.L12
.L14:
	.set	noreorder
	nop
	.set	reorder
	sw	$zero,24($fp)
.L15:
	lw	$v0,16($fp)
	lw	$v1,24($fp)
	lw	$v0,0($v0)
	slt	$v1,$v1,$v0
	bne	$v1,$zero,.L18
	b	.L16
.L18:
	lw	$v0,16($fp)
	addu	$v1,$v0,4
	lw	$a0,24($fp)
	addu	$v0,$v1,$a0
	lw	$v1,20($fp)
	addu	$a0,$v1,4
	lw	$v1,24($fp)
	addu	$a0,$a0,$v1
	lbu	$v0,0($v0)
	lbu	$v1,0($a0)
	beq	$v0,$v1,.L17
	move	$v0,$zero
	b	.L12
.L19:
.L17:
	lw	$v0,24($fp)
	addu	$v1,$v0,1
	sw	$v1,24($fp)
	b	.L15
.L16:
	li	$v0,1			# 0x1
	b	.L12
.L12:
	move	$sp,$fp
	ld	$fp,40($sp)
	addu	$sp,$sp,48
	j	$ra
.LFE3:
	.end	tig_stringEqual
	.align 4
	.globl	tig_print
	.ent	tig_print
tig_print:
.LFB4:
	.frame	$fp,64,$ra		# vars= 16, regs= 3/0, args= 0, extra= 16
	.mask	0xd0000000,-16
	.fmask	0x00000000,0
	subu	$sp,$sp,64
.LCFI14:
	sd	$ra,48($sp)
.LCFI15:
	sd	$fp,40($sp)
.LCFI16:
.LCFI17:
	move	$fp,$sp
.LCFI18:
	.set	noat
	.set	at
	sw	$a0,16($fp)
	lw	$v0,16($fp)
	addu	$v1,$v0,4
	sw	$v1,24($fp)
	sw	$zero,20($fp)
.L21:
	lw	$v0,16($fp)
	lw	$v1,20($fp)
	lw	$v0,0($v0)
	slt	$v1,$v1,$v0
	bne	$v1,$zero,.L24
	b	.L22
.L24:
	lw	$v0,24($fp)
	lbu	$v1,0($v0)
	move	$a0,$v1
	la	$t9,putchar
	jal	$ra,$t9
.L23:
	lw	$v0,20($fp)
	addu	$v1,$v0,1
	sw	$v1,20($fp)
	lw	$v0,24($fp)
	addu	$v1,$v0,1
	sw	$v1,24($fp)
	b	.L21
.L22:
.L20:
	move	$sp,$fp
	ld	$ra,48($sp)
	ld	$fp,40($sp)
	addu	$sp,$sp,64
	j	$ra
.LFE4:
	.end	tig_print
	.globl	consts
	.data
	.align 4
consts:
	.word	0

	.byte	0x0
	.space	3
	.space	2040
	.globl	empty
	.align 4
empty:
	.word	0

	.byte	0x0
	.space	3
	.text
	.align 4
	.globl	main
	.ent	main
main:
.LFB5:
	.frame	$fp,64,$ra		# vars= 16, regs= 3/0, args= 0, extra= 16
	.mask	0xd0000000,-16
	.fmask	0x00000000,0
	subu	$sp,$sp,64
.LCFI19:
	sd	$ra,48($sp)
.LCFI20:
	sd	$fp,40($sp)
.LCFI21:
.LCFI22:
	move	$fp,$sp
.LCFI23:
	.set	noat
	.set	at
	.set	noreorder
	nop
	.set	reorder
	sw	$zero,16($fp)
.L26:
	lw	$v0,16($fp)
	slt	$v1,$v0,256
	bne	$v1,$zero,.L29
	b	.L27
.L29:
	lw	$v0,16($fp)
	move	$v1,$v0
	sll	$v0,$v1,3
	la	$v1,consts
	addu	$v0,$v1,$v0
	li	$v1,1			# 0x1
	sw	$v1,0($v0)
	lw	$v0,16($fp)
	move	$v1,$v0
	sll	$v0,$v1,3
	la	$v1,consts
	addu	$v0,$v0,$v1
	lbu	$v1,16($fp)
	sb	$v1,4($v0)
.L28:
	lw	$v0,16($fp)
	addu	$v1,$v0,1
	sw	$v1,16($fp)
	b	.L26
.L27:
	move	$a0,$zero
	la	$t9,tig_main
	jal	$ra,$t9
	move	$v1,$v0
	move	$v0,$v1
	b	.L25
.L25:
	move	$sp,$fp
	ld	$ra,48($sp)
	ld	$fp,40($sp)
	addu	$sp,$sp,64
	j	$ra
.LFE5:
	.end	main
	.align 4
	.globl	tig_ord
	.ent	tig_ord
tig_ord:
.LFB6:
	.frame	$fp,48,$ra		# vars= 16, regs= 2/0, args= 0, extra= 16
	.mask	0x50000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
.LCFI24:
	sd	$fp,40($sp)
.LCFI25:
.LCFI26:
	move	$fp,$sp
.LCFI27:
	.set	noat
	.set	at
	sw	$a0,16($fp)
	lw	$v0,16($fp)
	lw	$v1,0($v0)
	bne	$v1,$zero,.L31
	li	$v0,-1			# 0xffffffff
	b	.L30
	b	.L32
.L31:
	lw	$v0,16($fp)
	lbu	$v1,4($v0)
	move	$v0,$v1
	b	.L30
.L32:
.L30:
	move	$sp,$fp
	ld	$fp,40($sp)
	addu	$sp,$sp,48
	j	$ra
.LFE6:
	.end	tig_ord
	.align 4
	.globl	tig_chr
	.ent	tig_chr
tig_chr:
.LFB7:
	.frame	$fp,64,$ra		# vars= 16, regs= 3/0, args= 0, extra= 16
	.mask	0xd0000000,-16
	.fmask	0x00000000,0
	subu	$sp,$sp,64
.LCFI28:
	sd	$ra,48($sp)
.LCFI29:
	sd	$fp,40($sp)
.LCFI30:
.LCFI31:
	move	$fp,$sp
.LCFI32:
	.set	noat
	.set	at
	sw	$a0,16($fp)
	lw	$v0,16($fp)
	bltz	$v0,.L35
	lw	$v0,16($fp)
	slt	$v1,$v0,256
	beq	$v1,$zero,.L35
	b	.L34
.L35:
	li	$a0,1			# 0x1
	la	$t9,exit
	jal	$ra,$t9
.L34:
	lw	$v0,16($fp)
	move	$v1,$v0
	sll	$v0,$v1,3
	la	$a0,consts
	addu	$v1,$v0,$a0
	move	$v0,$v1
	b	.L33
.L33:
	move	$sp,$fp
	ld	$ra,48($sp)
	ld	$fp,40($sp)
	addu	$sp,$sp,64
	j	$ra
.LFE7:
	.end	tig_chr
	.align 4
	.globl	tig_size
	.ent	tig_size
tig_size:
.LFB8:
	.frame	$fp,48,$ra		# vars= 16, regs= 2/0, args= 0, extra= 16
	.mask	0x50000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
.LCFI33:
	sd	$fp,40($sp)
.LCFI34:
.LCFI35:
	move	$fp,$sp
.LCFI36:
	.set	noat
	.set	at
	sw	$a0,16($fp)
	lw	$v0,16($fp)
	lw	$v1,0($v0)
	move	$v0,$v1
	b	.L36
.L36:
	move	$sp,$fp
	ld	$fp,40($sp)
	addu	$sp,$sp,48
	j	$ra
.LFE8:
	.end	tig_size
.data
	.align 4
.LC0:

	.byte	0x73,0x75,0x62,0x73,0x74,0x72,0x69,0x6e
	.byte	0x67,0x28,0x5b,0x25,0x64,0x5d,0x2c,0x25
	.byte	0x64,0x2c,0x25,0x64,0x29,0x20,0x6f,0x75
	.byte	0x74,0x20,0x6f,0x66,0x20,0x72,0x61,0x6e
	.byte	0x67,0x65,0xa,0x0
	.text
	.align 4
	.globl	tig_substring
	.ent	tig_substring
tig_substring:
.LFB9:
	.frame	$fp,80,$ra		# vars= 32, regs= 3/0, args= 0, extra= 16
	.mask	0xd0000000,-16
	.fmask	0x00000000,0
	subu	$sp,$sp,80
.LCFI37:
	sd	$ra,64($sp)
.LCFI38:
	sd	$fp,56($sp)
.LCFI39:
.LCFI40:
	move	$fp,$sp
.LCFI41:
	.set	noat
	.set	at
	sw	$a0,16($fp)
	sw	$a1,20($fp)
	sw	$a2,24($fp)
	lw	$v0,20($fp)
	bltz	$v0,.L39
	lw	$v0,20($fp)
	lw	$v1,24($fp)
	addu	$v0,$v0,$v1
	lw	$v1,16($fp)
	lw	$a0,0($v1)
	slt	$v0,$a0,$v0
	bne	$v0,$zero,.L39
	b	.L38
.L39:
	lw	$v0,16($fp)
	la	$a0,.LC0
	lw	$a1,0($v0)
	lw	$a2,20($fp)
	lw	$a3,24($fp)
	la	$t9,printf
	jal	$ra,$t9
	li	$a0,1			# 0x1
	la	$t9,exit
	jal	$ra,$t9
.L38:
	lw	$v0,24($fp)
	li	$v1,1			# 0x1
	bne	$v0,$v1,.L40
	lw	$v0,16($fp)
	addu	$v1,$v0,4
	lw	$v0,20($fp)
	addu	$v1,$v1,$v0
	lbu	$v0,0($v1)
	move	$v1,$v0
	sll	$v0,$v1,3
	la	$a0,consts
	addu	$v1,$v0,$a0
	move	$v0,$v1
	b	.L37
.L40:
	lw	$v1,24($fp)
	addu	$v0,$v1,4
	move	$a0,$v0
	la	$t9,malloc
	jal	$ra,$t9
	sw	$v0,28($fp)
	lw	$v0,28($fp)
	lw	$v1,24($fp)
	sw	$v1,0($v0)
	sw	$zero,32($fp)
.L41:
	lw	$v0,32($fp)
	lw	$v1,24($fp)
	slt	$v0,$v0,$v1
	bne	$v0,$zero,.L44
	b	.L42
.L44:
	lw	$v0,28($fp)
	addu	$v1,$v0,4
	lw	$a0,32($fp)
	addu	$v0,$v1,$a0
	lw	$v1,16($fp)
	lw	$a0,20($fp)
	lw	$a1,32($fp)
	addu	$a0,$a0,$a1
	addu	$v1,$v1,4
	addu	$a0,$v1,$a0
	lbu	$v1,0($a0)
	sb	$v1,0($v0)
.L43:
	lw	$v0,32($fp)
	addu	$v1,$v0,1
	sw	$v1,32($fp)
	b	.L41
.L42:
	lw	$v1,28($fp)
	move	$v0,$v1
	b	.L37
.L37:
	move	$sp,$fp
	ld	$ra,64($sp)
	ld	$fp,56($sp)
	addu	$sp,$sp,80
	j	$ra
.LFE9:
	.end	tig_substring
	.align 4
	.globl	tig_concat
	.ent	tig_concat
tig_concat:
.LFB10:
	.frame	$fp,80,$ra		# vars= 32, regs= 3/0, args= 0, extra= 16
	.mask	0xd0000000,-16
	.fmask	0x00000000,0
	subu	$sp,$sp,80
.LCFI42:
	sd	$ra,64($sp)
.LCFI43:
	sd	$fp,56($sp)
.LCFI44:
.LCFI45:
	move	$fp,$sp
.LCFI46:
	.set	noat
	.set	at
	sw	$a0,16($fp)
	sw	$a1,20($fp)
	lw	$v0,16($fp)
	lw	$v1,0($v0)
	bne	$v1,$zero,.L46
	lw	$v1,20($fp)
	move	$v0,$v1
	b	.L45
	b	.L47
.L46:
	lw	$v0,20($fp)
	lw	$v1,0($v0)
	bne	$v1,$zero,.L48
	lw	$v1,16($fp)
	move	$v0,$v1
	b	.L45
	b	.L47
.L48:
	lw	$v0,16($fp)
	lw	$v1,20($fp)
	lw	$v0,0($v0)
	lw	$v1,0($v1)
	addu	$v0,$v0,$v1
	sw	$v0,28($fp)
	lw	$v1,28($fp)
	addu	$v0,$v1,4
	move	$a0,$v0
	la	$t9,malloc
	jal	$ra,$t9
	sw	$v0,32($fp)
	lw	$v0,32($fp)
	lw	$v1,28($fp)
	sw	$v1,0($v0)
	sw	$zero,24($fp)
.L50:
	lw	$v0,16($fp)
	lw	$v1,24($fp)
	lw	$v0,0($v0)
	slt	$v1,$v1,$v0
	bne	$v1,$zero,.L53
	b	.L51
.L53:
	lw	$v0,32($fp)
	addu	$v1,$v0,4
	lw	$a0,24($fp)
	addu	$v0,$v1,$a0
	lw	$v1,16($fp)
	addu	$a0,$v1,4
	lw	$v1,24($fp)
	addu	$a0,$a0,$v1
	lbu	$v1,0($a0)
	sb	$v1,0($v0)
.L52:
	lw	$v0,24($fp)
	addu	$v1,$v0,1
	sw	$v1,24($fp)
	b	.L50
.L51:
	.set	noreorder
	nop
	.set	reorder
	sw	$zero,24($fp)
.L54:
	lw	$v0,20($fp)
	lw	$v1,24($fp)
	lw	$v0,0($v0)
	slt	$v1,$v1,$v0
	bne	$v1,$zero,.L57
	b	.L55
.L57:
	lw	$v0,32($fp)
	lw	$v1,16($fp)
	lw	$a0,24($fp)
	lw	$a1,0($v1)
	addu	$v1,$a0,$a1
	addu	$a0,$v0,4
	addu	$v0,$a0,$v1
	lw	$v1,20($fp)
	addu	$a0,$v1,4
	lw	$v1,24($fp)
	addu	$a0,$a0,$v1
	lbu	$v1,0($a0)
	sb	$v1,0($v0)
.L56:
	lw	$v0,24($fp)
	addu	$v1,$v0,1
	sw	$v1,24($fp)
	b	.L54
.L55:
	lw	$v1,32($fp)
	move	$v0,$v1
	b	.L45
.L49:
.L47:
.L45:
	move	$sp,$fp
	ld	$ra,64($sp)
	ld	$fp,56($sp)
	addu	$sp,$sp,80
	j	$ra
.LFE10:
	.end	tig_concat
	.align 4
	.globl	tig_not
	.ent	tig_not
tig_not:
.LFB11:
	.frame	$fp,48,$ra		# vars= 16, regs= 2/0, args= 0, extra= 16
	.mask	0x50000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
.LCFI47:
	sd	$fp,40($sp)
.LCFI48:
.LCFI49:
	move	$fp,$sp
.LCFI50:
	.set	noat
	.set	at
	sw	$a0,16($fp)
	lw	$v0,16($fp)
	xori	$a0,$v0,0x0
	sltu	$v1,$a0,1
	move	$v0,$v1
	b	.L58
.L58:
	move	$sp,$fp
	ld	$fp,40($sp)
	addu	$sp,$sp,48
	j	$ra
.LFE11:
	.end	tig_not
	.align 4
	.globl	tig_getchar
	.ent	tig_getchar
tig_getchar:
.LFB12:
	.frame	$fp,48,$ra		# vars= 0, regs= 3/0, args= 0, extra= 16
	.mask	0xd0000000,-16
	.fmask	0x00000000,0
	subu	$sp,$sp,48
.LCFI51:
	sd	$ra,32($sp)
.LCFI52:
	sd	$fp,24($sp)
.LCFI53:
.LCFI54:
	move	$fp,$sp
.LCFI55:
	.set	noat
	.set	at
	la	$t9,getchar
	jal	$ra,$t9
	move	$a0,$v0
	la	$t9,tig_chr
	jal	$ra,$t9
	move	$v1,$v0
	move	$v0,$v1
	b	.L59
.L59:
	move	$sp,$fp
	ld	$ra,32($sp)
	ld	$fp,24($sp)
	addu	$sp,$sp,48
	j	$ra
.LFE12:
	.end	tig_getchar
tig_flush:
  j $ra
  .end tig_flush
tig_exit:
  j exit
  .end tig_exit
# system calls for Tiger, when running on SPIM
#
# $Id: sysspim.s,v 1.1 2002/08/25 05:06:41 shivers Exp $

	.globl malloc
	.ent malloc
	.text
malloc:
	# round up the requested amount to a multiple of 4
	add $a0, $a0, 3
	srl $a0, $a0, 2
	sll $a0, $a0, 2

	# allocate the memory with sbrk()
	li $v0, 9
	syscall
	
	j $ra

	.end malloc

	

	.data
	.align 4
getchar_buf:	.byte 0, 0

	.text
getchar:
	# read the character
	la $a0, getchar_buf
	li $a1, 2
	li $v0, 8
	syscall

	# return it
	lb $v0, ($a0)
	j $ra
	

	.data
	.align 4
putchar_buf:	.byte 0, 0

	.text
putchar:
	# save the character so that it is NUL-terminated 
	la $t0, putchar_buf
	sb $a0, ($t0)

	# print it out
	la $a0, putchar_buf
	li $v0, 4
	syscall

	j $ra


	.text	
# just prints the format string, not the arguments
printf:
	li $v0, 4
	syscall
	j $ra


	.text
exit:
	li $v0, 10
	syscall
	
.data
L18:
 .word 2
 .ascii " O"
L19:
 .word 2
 .ascii " ."
L25:
 .word 1
 .ascii "
"
.text
# ----- emit printboard -----
printboard:
addi $sp, $sp, -40
sw $fp, 4($sp)
add $fp, $sp, 40
L77:
sw $a0, 0($fp)
sw $ra, -12($fp)
sw $s0, -16($fp)
sw $s1, -20($fp)
sw $s2, -24($fp)
sw $s3, -28($fp)
addi $t0, $0, 0
sw $t0, -4($fp)
lw $t0, 0($fp)
lw $t0, -4($t0)
addi $t1, $t0, -1
lw $t0, -4($fp)
ble $t0, $t1, L80
L13:
la $a0, L25
jal tig_print

lw $s3, -28($fp)
lw $s2, -24($fp)
lw $s1, -20($fp)
lw $s0, -16($fp)
lw $ra, -12($fp)
j L76 
L27:
lw $t0, -4($fp)
addi $t0, $t0, 1
sw $t0, -4($fp)
L80:
lw $s0, 0($fp)
addi $s1, $0, 4
lw $s2, 0($fp)
addi $t2, $0, 0
lw $t0, 0($fp)
lw $s3, 0($fp)
lw $t1, 0($fp)
addi $t0, $0, 0
sw $t0, -8($fp)
L26:
lw $t0, -4($t1)
addi $t1, $t0, -1
lw $t0, -8($fp)
ble $t0, $t1, L81
L14:
la $a0, L25
jal tig_print

lw $t0, -4($s3)
addi $t1, $t0, -1
lw $t0, -4($fp)
blt $t0, $t1, L27
L78:
j L13 
L24:
lw $t0, -8($fp)
addi $t0, $t0, 1
sw $t0, -8($fp)
L81:
lw $s0, 0($fp)
addi $s1, $0, 4
lw $s2, 0($fp)
addi $t2, $0, 0
lw $t0, 0($fp)
lw $t1, -4($fp)
L23:
lw $t0, -12($t0)
lw $t0, -4($t0)
bge $t1, $t0, L15
L16:
blt $t1, $t2, L15
L17:
lw $t1, -12($s2)
lw $t0, -4($fp)
mul $t0, $t0, $s1
add $t0, $t1, $t0
lw $t1, 0($t0)
lw $t0, -8($fp)
beq $t1, $t0, L20
L21:
la $a0, L19
L22:
jal tig_print

lw $t0, -4($s0)
addi $t1, $t0, -1
lw $t0, -8($fp)
blt $t0, $t1, L24
L79:
j L14 
L15:
addi $a0, $0, 1
jal exit

j L17 
L20:
la $a0, L18
j L22 
L76:

lw $fp, 4($sp)
addi $sp, $sp, 40
jr $ra
# ----- emit try -----
try:
addi $sp, $sp, -244
sw $fp, 4($sp)
add $fp, $sp, 244
L83:
sw $a1, -4($fp)
sw $a0, 0($fp)
sw $ra, -24($fp)
sw $s0, -28($fp)
sw $s1, -32($fp)
sw $s2, -36($fp)
sw $s3, -40($fp)
sw $s4, -44($fp)
sw $s5, -48($fp)
sw $s6, -52($fp)
sw $s7, -56($fp)
lw $t0, 0($fp)
lw $t1, -4($t0)
lw $t0, -4($fp)
beq $t0, $t1, L73
L74:
addi $t0, $0, 0
sw $t0, -8($fp)
lw $t0, 0($fp)
lw $t0, -4($t0)
addi $t1, $t0, -1
lw $t0, -8($fp)
ble $t0, $t1, L85
L28:
addi $v0, $0, 0
L75:
lw $s7, -56($fp)
lw $s6, -52($fp)
lw $s5, -48($fp)
lw $s4, -44($fp)
lw $s3, -40($fp)
lw $s2, -36($fp)
lw $s1, -32($fp)
lw $s0, -28($fp)
lw $ra, -24($fp)
j L82 
L73:
lw $a0, 0($fp)
jal printboard

j L75 
L72:
lw $t0, -8($fp)
addi $t0, $t0, 1
sw $t0, -8($fp)
L85:
addi $s0, $0, 0
addi $s1, $0, 4
lw $s2, 0($fp)
addi $s3, $0, 0
lw $s4, 0($fp)
addi $s5, $0, 0
addi $s6, $0, 4
lw $s7, 0($fp)
addi $t0, $0, 0
sw $t0, -232($fp)
lw $t0, 0($fp)
sw $t0, -228($fp)
addi $t0, $0, 0
sw $t0, -224($fp)
addi $t0, $0, 4
sw $t0, -220($fp)
lw $t0, 0($fp)
sw $t0, -216($fp)
addi $t0, $0, 0
sw $t0, -212($fp)
lw $t0, 0($fp)
sw $t0, -208($fp)
lw $t0, -4($fp)
addi $t0, $t0, 1
sw $t0, -204($fp)
lw $t0, 0($fp)
sw $t0, -200($fp)
addi $t0, $0, 4
sw $t0, -196($fp)
lw $t0, 0($fp)
sw $t0, -192($fp)
addi $t0, $0, 0
sw $t0, -188($fp)
lw $t0, 0($fp)
sw $t0, -184($fp)
lw $t0, -4($fp)
sw $t0, -20($fp)
addi $t0, $0, 1
sw $t0, -180($fp)
addi $t0, $0, 4
sw $t0, -176($fp)
lw $t0, 0($fp)
sw $t0, -172($fp)
addi $t0, $0, 0
sw $t0, -168($fp)
lw $t0, 0($fp)
sw $t0, -164($fp)
addi $t0, $0, 1
sw $t0, -160($fp)
addi $t0, $0, 4
sw $t0, -156($fp)
lw $t0, 0($fp)
sw $t0, -152($fp)
addi $t0, $0, 0
sw $t0, -148($fp)
lw $t0, 0($fp)
sw $t0, -144($fp)
addi $t0, $0, 1
sw $t0, -140($fp)
addi $t0, $0, 4
sw $t0, -136($fp)
lw $t0, 0($fp)
sw $t0, -132($fp)
addi $t0, $0, 0
sw $t0, -128($fp)
lw $t0, 0($fp)
sw $t0, -124($fp)
addi $t0, $0, 0
sw $t0, -120($fp)
addi $t0, $0, 4
sw $t0, -116($fp)
lw $t0, 0($fp)
sw $t0, -112($fp)
addi $t0, $0, 0
sw $t0, -108($fp)
lw $t0, 0($fp)
sw $t0, -104($fp)
addi $t0, $0, 0
sw $t0, -100($fp)
addi $t0, $0, 4
sw $t0, -96($fp)
lw $t0, 0($fp)
sw $t0, -92($fp)
addi $t0, $0, 0
sw $t0, -88($fp)
lw $t0, 0($fp)
sw $t0, -84($fp)
lw $t0, 0($fp)
sw $t0, -80($fp)
addi $t0, $0, 0
sw $t0, -76($fp)
addi $t0, $0, 0
sw $t0, -72($fp)
addi $t0, $0, 0
sw $t0, -68($fp)
addi $t0, $0, 4
sw $t0, -64($fp)
lw $t0, 0($fp)
sw $t0, -60($fp)
addi $t2, $0, 0
lw $t0, 0($fp)
L71:
lw $t1, -8($fp)
lw $t0, -8($t0)
lw $t0, -4($t0)
bge $t1, $t0, L29
L30:
blt $t1, $t2, L29
L31:
lw $t0, -60($fp)
lw $t2, -8($t0)
lw $t0, -8($fp)
lw $t1, -64($fp)
mul $t0, $t0, $t1
add $t0, $t2, $t0
lw $t1, 0($t0)
lw $t0, -68($fp)
beq $t1, $t0, L37
L38:
addi $t0, $0, 0
L39:
lw $t1, -72($fp)
bne $t0, $t1, L45
L46:
addi $t0, $0, 0
L47:
lw $t1, -76($fp)
bne $t0, $t1, L69
L70:
lw $t0, -80($fp)
lw $t0, -4($t0)
addi $t1, $t0, -1
lw $t0, -8($fp)
blt $t0, $t1, L72
L84:
j L28 
L29:
addi $a0, $0, 1
jal exit

j L31 
L37:
addi $t0, $0, 1
sw $t0, -12($fp)
lw $t0, -8($fp)
lw $t1, -4($fp)
add $t1, $t0, $t1
lw $t0, -84($fp)
lw $t0, -16($t0)
lw $t0, -4($t0)
bge $t1, $t0, L32
L33:
lw $t0, -88($fp)
blt $t1, $t0, L32
L34:
lw $t0, -92($fp)
lw $t2, -16($t0)
lw $t0, -8($fp)
lw $t1, -4($fp)
add $t1, $t0, $t1
lw $t0, -96($fp)
mul $t0, $t1, $t0
add $t0, $t2, $t0
lw $t1, 0($t0)
lw $t0, -100($fp)
beq $t1, $t0, L35
L36:
addi $t0, $0, 0
sw $t0, -12($fp)
L35:
lw $t0, -12($fp)
j L39 
L32:
addi $a0, $0, 1
jal exit

j L34 
L45:
addi $t0, $0, 1
sw $t0, -16($fp)
lw $t0, -8($fp)
addi $t1, $t0, 7
lw $t0, -4($fp)
sub $t1, $t1, $t0
lw $t0, -104($fp)
lw $t0, -20($t0)
lw $t0, -4($t0)
bge $t1, $t0, L40
L41:
lw $t0, -108($fp)
blt $t1, $t0, L40
L42:
lw $t0, -112($fp)
lw $t2, -20($t0)
lw $t0, -8($fp)
addi $t1, $t0, 7
lw $t0, -4($fp)
sub $t1, $t1, $t0
lw $t0, -116($fp)
mul $t0, $t1, $t0
add $t0, $t2, $t0
lw $t1, 0($t0)
lw $t0, -120($fp)
beq $t1, $t0, L43
L44:
addi $t0, $0, 0
sw $t0, -16($fp)
L43:
lw $t0, -16($fp)
j L47 
L40:
addi $a0, $0, 1
jal exit

j L42 
L69:
lw $t1, -8($fp)
lw $t0, -124($fp)
lw $t0, -8($t0)
lw $t0, -4($t0)
bge $t1, $t0, L48
L49:
lw $t0, -128($fp)
blt $t1, $t0, L48
L50:
lw $t0, -132($fp)
lw $t2, -8($t0)
lw $t0, -8($fp)
lw $t1, -136($fp)
mul $t0, $t0, $t1
add $t1, $t2, $t0
lw $t0, -140($fp)
sw $t0, 0($t1)
lw $t0, -8($fp)
lw $t1, -4($fp)
add $t1, $t0, $t1
lw $t0, -144($fp)
lw $t0, -16($t0)
lw $t0, -4($t0)
bge $t1, $t0, L51
L52:
lw $t0, -148($fp)
blt $t1, $t0, L51
L53:
lw $t0, -152($fp)
lw $t2, -16($t0)
lw $t0, -8($fp)
lw $t1, -4($fp)
add $t1, $t0, $t1
lw $t0, -156($fp)
mul $t0, $t1, $t0
add $t1, $t2, $t0
lw $t0, -160($fp)
sw $t0, 0($t1)
lw $t0, -8($fp)
addi $t1, $t0, 7
lw $t0, -4($fp)
sub $t1, $t1, $t0
lw $t0, -164($fp)
lw $t0, -20($t0)
lw $t0, -4($t0)
bge $t1, $t0, L54
L55:
lw $t0, -168($fp)
blt $t1, $t0, L54
L56:
lw $t0, -172($fp)
lw $t2, -20($t0)
lw $t0, -8($fp)
addi $t1, $t0, 7
lw $t0, -4($fp)
sub $t1, $t1, $t0
lw $t0, -176($fp)
mul $t0, $t1, $t0
add $t1, $t2, $t0
lw $t0, -180($fp)
sw $t0, 0($t1)
lw $t0, -184($fp)
lw $t0, -12($t0)
lw $t0, -4($t0)
lw $t1, -20($fp)
bge $t1, $t0, L57
L58:
lw $t0, -20($fp)
lw $t1, -188($fp)
blt $t0, $t1, L57
L59:
lw $t0, -192($fp)
lw $t2, -12($t0)
lw $t0, -4($fp)
lw $t1, -196($fp)
mul $t0, $t0, $t1
add $t1, $t2, $t0
lw $t0, -8($fp)
sw $t0, 0($t1)
lw $a0, -200($fp)
lw $a1, -204($fp)
jal try

lw $t1, -8($fp)
lw $t0, -208($fp)
lw $t0, -8($t0)
lw $t0, -4($t0)
bge $t1, $t0, L60
L61:
lw $t0, -212($fp)
blt $t1, $t0, L60
L62:
lw $t0, -216($fp)
lw $t2, -8($t0)
lw $t0, -8($fp)
lw $t1, -220($fp)
mul $t0, $t0, $t1
add $t1, $t2, $t0
lw $t0, -224($fp)
sw $t0, 0($t1)
lw $t0, -8($fp)
lw $t1, -4($fp)
add $t1, $t0, $t1
lw $t0, -228($fp)
lw $t0, -16($t0)
lw $t0, -4($t0)
bge $t1, $t0, L63
L64:
lw $t0, -232($fp)
blt $t1, $t0, L63
L65:
lw $t2, -16($s7)
lw $t0, -8($fp)
lw $t1, -4($fp)
add $t0, $t0, $t1
mul $t0, $t0, $s6
add $t0, $t2, $t0
sw $s5, 0($t0)
lw $t0, -8($fp)
addi $t1, $t0, 7
lw $t0, -4($fp)
sub $t1, $t1, $t0
lw $t0, -20($s4)
lw $t0, -4($t0)
bge $t1, $t0, L66
L67:
blt $t1, $s3, L66
L68:
lw $t2, -20($s2)
lw $t0, -8($fp)
addi $t1, $t0, 7
lw $t0, -4($fp)
sub $t0, $t1, $t0
mul $t0, $t0, $s1
add $t0, $t2, $t0
sw $s0, 0($t0)
j L70 
L48:
addi $a0, $0, 1
jal exit

j L50 
L51:
addi $a0, $0, 1
jal exit

j L53 
L54:
addi $a0, $0, 1
jal exit

j L56 
L57:
addi $a0, $0, 1
jal exit

j L59 
L60:
addi $a0, $0, 1
jal exit

j L62 
L63:
addi $a0, $0, 1
jal exit

j L65 
L66:
addi $a0, $0, 1
jal exit

j L68 
L82:

lw $fp, 4($sp)
addi $sp, $sp, 244
jr $ra
# ----- emit tig_main -----
tig_main:
addi $sp, $sp, -56
sw $fp, 4($sp)
add $fp, $sp, 56
L87:
sw $a0, 0($fp)
sw $ra, -40($fp)
sw $s0, -44($fp)
addi $t0, $0, 8
sw $t0, -4($fp)
addi $t0, $fp, -8
move $s0, $t0
lw $t0, -4($fp)
sw $t0, -24($fp)
addi $t1, $0, 4
lw $t0, -24($fp)
mul $t0, $t0, $t1
addi $a0, $t0, 4
jal malloc

addi $t0, $0, 0
L88:
addi $t1, $0, 0
addi $t2, $0, 4
addi $t3, $0, 0
lw $t4, -4($fp)
L3:
sub $t4, $t4, $t0
bne $t4, $t3, L2
L1:
lw $t0, -24($fp)
sw $t0, 0($v0)
addi $t0, $v0, 4
sw $t0, 0($s0)
addi $t0, $fp, -12
move $s0, $t0
lw $t0, -4($fp)
sw $t0, -28($fp)
addi $t1, $0, 4
lw $t0, -28($fp)
mul $t0, $t0, $t1
addi $a0, $t0, 4
jal malloc

addi $t0, $0, 0
L89:
addi $t1, $0, 0
addi $t2, $0, 4
addi $t3, $0, 0
lw $t4, -4($fp)
L6:
sub $t4, $t4, $t0
bne $t4, $t3, L5
L4:
lw $t0, -28($fp)
sw $t0, 0($v0)
addi $t0, $v0, 4
sw $t0, 0($s0)
addi $t0, $fp, -16
move $s0, $t0
lw $t1, -4($fp)
lw $t0, -4($fp)
add $t0, $t1, $t0
addi $t0, $t0, -1
sw $t0, -32($fp)
addi $t1, $0, 4
lw $t0, -32($fp)
mul $t0, $t0, $t1
addi $a0, $t0, 4
jal malloc

addi $t0, $0, 0
L90:
addi $t1, $0, 0
addi $t2, $0, 4
addi $t3, $0, 0
lw $t4, -4($fp)
lw $t5, -4($fp)
L9:
add $t4, $t5, $t4
addi $t4, $t4, -1
sub $t4, $t4, $t0
bne $t4, $t3, L8
L7:
lw $t0, -32($fp)
sw $t0, 0($v0)
addi $t0, $v0, 4
sw $t0, 0($s0)
addi $t0, $fp, -20
move $s0, $t0
lw $t1, -4($fp)
lw $t0, -4($fp)
add $t0, $t1, $t0
addi $t0, $t0, -1
sw $t0, -36($fp)
addi $t1, $0, 4
lw $t0, -36($fp)
mul $t0, $t0, $t1
addi $a0, $t0, 4
jal malloc

addi $t0, $0, 0
L91:
addi $t1, $0, 0
addi $t2, $0, 4
addi $t3, $0, 0
lw $t4, -4($fp)
lw $t5, -4($fp)
L12:
add $t4, $t5, $t4
addi $t4, $t4, -1
sub $t4, $t4, $t0
bne $t4, $t3, L11
L10:
lw $t0, -36($fp)
sw $t0, 0($v0)
addi $t0, $v0, 4
sw $t0, 0($s0)
move $a0, $fp
addi $a1, $0, 0
jal try

lw $s0, -44($fp)
lw $ra, -40($fp)
j L86 
L2:
mul $t2, $t0, $t2
add $t2, $v0, $t2
sw $t1, 0($t2)
addi $t0, $t0, 1
j L88 
L5:
mul $t2, $t0, $t2
add $t2, $v0, $t2
sw $t1, 0($t2)
addi $t0, $t0, 1
j L89 
L8:
mul $t2, $t0, $t2
add $t2, $v0, $t2
sw $t1, 0($t2)
addi $t0, $t0, 1
j L90 
L11:
mul $t2, $t0, $t2
add $t2, $v0, $t2
sw $t1, 0($t2)
addi $t0, $t0, 1
j L91 
L86:

lw $fp, 4($sp)
addi $sp, $sp, 56
jr $ra
