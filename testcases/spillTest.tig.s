# ----- emit L0 -----
L2:
sw t118, -4(t122)
sw t110, -8(t122)
sw t111, -12(t122)
sw t112, -16(t122)
sw t113, -20(t122)
sw t114, -24(t122)
sw t115, -28(t122)
sw t116, -32(t122)
sw t117, -36(t122)
addi t165, $0, 1
move t132, t165
addi t166, $0, 2
move t133, t166
addi t167, $0, 3
move t134, t167
addi t168, $0, 4
move t135, t168
addi t169, $0, 5
move t136, t169
addi t170, $0, 6
move t137, t170
addi t171, $0, 7
move t138, t171
addi t172, $0, 8
move t139, t172
addi t173, $0, 9
move t140, t173
addi t174, $0, 10
move t141, t174
addi t175, $0, 11
move t142, t175
addi t176, $0, 12
move t143, t176
addi t177, $0, 13
move t144, t177
addi t178, $0, 14
move t145, t178
addi t179, $0, 15
move t146, t179
addi t180, $0, 16
move t147, t180
addi t181, $0, 17
move t148, t181
addi t182, $0, 18
move t149, t182
addi t183, $0, 19
move t150, t183
addi t184, $0, 20
move t151, t184
addi t185, $0, 21
move t152, t185
addi t186, $0, 22
move t153, t186
addi t187, $0, 23
move t154, t187
addi t188, $0, 24
move t155, t188
addi t189, $0, 25
move t156, t189
addi t190, $0, 26
move t157, t190
addi t191, $0, 27
move t158, t191
addi t192, $0, 28
move t159, t192
addi t193, $0, 29
move t160, t193
addi t194, $0, 30
move t161, t194
addi t195, $0, 31
move t162, t195
addi t196, $0, 32
move t163, t196
addi t197, $0, 33
move t164, t197
add t229, t132, t133
add t228, t229, t134
add t227, t228, t135
add t226, t227, t136
add t225, t226, t137
add t224, t225, t138
add t223, t224, t139
add t222, t223, t140
add t221, t222, t141
add t220, t221, t142
add t219, t220, t143
add t218, t219, t144
add t217, t218, t145
add t216, t217, t146
add t215, t216, t147
add t214, t215, t148
add t213, t214, t149
add t212, t213, t150
add t211, t212, t151
add t210, t211, t152
add t209, t210, t153
add t208, t209, t154
add t207, t208, t155
add t206, t207, t156
add t205, t206, t157
add t204, t205, t158
add t203, t204, t159
add t202, t203, t160
add t201, t202, t161
add t200, t201, t162
add t199, t200, t163
add t198, t199, t164
move t128, t198
lw t230, -8(t122)
move t110, t230
lw t231, -12(t122)
move t111, t231
lw t232, -16(t122)
move t112, t232
lw t233, -20(t122)
move t113, t233
lw t234, -24(t122)
move t114, t234
lw t235, -28(t122)
move t115, t235
lw t236, -32(t122)
move t116, t236
lw t237, -36(t122)
move t117, t237
j L1 
L1:
# -------------------
L0:
move %fp, %sp
addi %sp, %sp, -348
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
addi %s0, $0, 1
sw %s0, -172(%fp)
sw %t0, -40(%fp)
lw %t0, -172(%fp)
move %t0, %t0
addi %t0, $0, 2
sw %t0, -176(%fp)
sw %t7, -44(%fp)
lw %t7, -176(%fp)
move %t7, %t7
addi %t0, $0, 3
sw %t0, -180(%fp)
sw %t8, -48(%fp)
lw %t8, -180(%fp)
move %t8, %t8
addi %t0, $0, 4
sw %t0, -184(%fp)
sw %t9, -52(%fp)
lw %t9, -184(%fp)
move %t9, %t9
addi %t0, $0, 5
sw %t0, -188(%fp)
sw %a1, -56(%fp)
lw %a1, -188(%fp)
move %a1, %a1
addi %t0, $0, 6
sw %t0, -192(%fp)
sw %a2, -60(%fp)
lw %a2, -192(%fp)
move %a2, %a2
addi %t0, $0, 7
sw %t0, -196(%fp)
lw %t0, -196(%fp)
move %t0, %t0
sw %t0, -64(%fp)
addi %t0, $0, 8
sw %t0, -200(%fp)
lw %t0, -200(%fp)
move %t0, %t0
sw %t0, -68(%fp)
addi %t0, $0, 9
sw %t0, -204(%fp)
lw %t0, -204(%fp)
move %t0, %t0
sw %t0, -72(%fp)
addi %t0, $0, 10
sw %t0, -208(%fp)
lw %t0, -208(%fp)
move %t0, %t0
sw %t0, -76(%fp)
addi %t0, $0, 11
sw %t0, -212(%fp)
lw %t0, -212(%fp)
move %t0, %t0
sw %t0, -80(%fp)
addi %t0, $0, 12
sw %t0, -216(%fp)
lw %t0, -216(%fp)
move %t0, %t0
sw %t0, -84(%fp)
addi %t0, $0, 13
sw %t0, -220(%fp)
lw %t0, -220(%fp)
move %t0, %t0
sw %t0, -88(%fp)
addi %t0, $0, 14
sw %t0, -224(%fp)
lw %t0, -224(%fp)
move %t0, %t0
sw %t0, -92(%fp)
addi %t0, $0, 15
sw %t0, -228(%fp)
lw %t0, -228(%fp)
move %t0, %t0
sw %t0, -96(%fp)
addi %t0, $0, 16
sw %t0, -232(%fp)
lw %t0, -232(%fp)
move %t0, %t0
sw %t0, -100(%fp)
addi %t0, $0, 17
sw %t0, -236(%fp)
lw %t0, -236(%fp)
move %t0, %t0
sw %t0, -104(%fp)
addi %t0, $0, 18
sw %t0, -240(%fp)
lw %t0, -240(%fp)
move %t0, %t0
sw %t0, -108(%fp)
addi %t0, $0, 19
sw %t0, -244(%fp)
lw %t0, -244(%fp)
move %t0, %t0
sw %t0, -112(%fp)
addi %t0, $0, 20
sw %t0, -248(%fp)
lw %t0, -248(%fp)
move %t0, %t0
sw %t0, -116(%fp)
addi %t0, $0, 21
sw %t0, -252(%fp)
lw %t0, -252(%fp)
move %t0, %t0
sw %t0, -120(%fp)
addi %t0, $0, 22
sw %t0, -256(%fp)
lw %t0, -256(%fp)
move %t0, %t0
sw %t0, -124(%fp)
addi %t0, $0, 23
sw %t0, -260(%fp)
lw %t0, -260(%fp)
move %t0, %t0
sw %t0, -128(%fp)
addi %t0, $0, 24
sw %t0, -264(%fp)
lw %t0, -264(%fp)
move %t0, %t0
sw %t0, -132(%fp)
addi %t0, $0, 25
sw %t0, -268(%fp)
lw %t0, -268(%fp)
move %t0, %t0
sw %t0, -136(%fp)
addi %t0, $0, 26
sw %t0, -272(%fp)
lw %t0, -272(%fp)
move %t0, %t0
sw %t0, -140(%fp)
addi %t0, $0, 27
sw %t0, -276(%fp)
lw %t0, -276(%fp)
move %t0, %t0
sw %t0, -144(%fp)
addi %t0, $0, 28
sw %t0, -280(%fp)
lw %t0, -280(%fp)
move %t0, %t0
sw %t0, -148(%fp)
addi %t0, $0, 29
sw %t0, -284(%fp)
lw %t0, -284(%fp)
move %t0, %t0
sw %t0, -152(%fp)
addi %t0, $0, 30
sw %t0, -288(%fp)
lw %t0, -288(%fp)
move %t0, %t0
sw %t0, -156(%fp)
addi %t0, $0, 31
sw %t0, -292(%fp)
lw %t0, -292(%fp)
move %t0, %t0
sw %t0, -160(%fp)
addi %t0, $0, 32
sw %t0, -296(%fp)
lw %t0, -296(%fp)
move %t0, %t0
sw %t0, -164(%fp)
addi %t0, $0, 33
sw %t0, -300(%fp)
lw %t0, -300(%fp)
move %t0, %t0
sw %t0, -168(%fp)
add %t0, %t1, %t2
lw %t2, -44(%fp)
lw %t1, -40(%fp)
add %t0, %t0, %t3
lw %t3, -48(%fp)
add %t0, %t0, %t4
lw %t4, -52(%fp)
add %t0, %t0, %t5
lw %t5, -56(%fp)
add %t1, %t0, %t6
lw %t6, -60(%fp)
lw %t0, -64(%fp)
add %t1, %t1, %t0
lw %t0, -68(%fp)
add %t1, %t1, %t0
lw %t0, -72(%fp)
add %t1, %t1, %t0
lw %t0, -76(%fp)
add %t1, %t1, %t0
lw %t0, -80(%fp)
add %t1, %t1, %t0
lw %t0, -84(%fp)
add %t1, %t1, %t0
lw %t0, -88(%fp)
add %t1, %t1, %t0
lw %t0, -92(%fp)
add %t1, %t1, %t0
lw %t0, -96(%fp)
add %t1, %t1, %t0
lw %t0, -100(%fp)
add %t1, %t1, %t0
lw %t0, -104(%fp)
add %t1, %t1, %t0
lw %t0, -108(%fp)
add %t1, %t1, %t0
lw %t0, -112(%fp)
add %t1, %t1, %t0
lw %t0, -116(%fp)
add %t1, %t1, %t0
lw %t0, -120(%fp)
add %t1, %t1, %t0
lw %t0, -124(%fp)
add %t1, %t1, %t0
lw %t0, -128(%fp)
add %t1, %t1, %t0
lw %t0, -132(%fp)
add %t0, %t1, %t0
sw %t0, -340(%fp)
lw %t0, -340(%fp)
lw %t1, -136(%fp)
add %t0, %t0, %t1
sw %t0, -336(%fp)
lw %t0, -336(%fp)
lw %t1, -140(%fp)
add %t0, %t0, %t1
sw %t0, -332(%fp)
lw %t0, -332(%fp)
lw %t1, -144(%fp)
add %t0, %t0, %t1
sw %t0, -328(%fp)
lw %t0, -328(%fp)
lw %t1, -148(%fp)
add %t0, %t0, %t1
sw %t0, -324(%fp)
lw %t0, -324(%fp)
lw %t1, -152(%fp)
add %t0, %t0, %t1
sw %t0, -320(%fp)
lw %t0, -320(%fp)
lw %t1, -156(%fp)
add %t0, %t0, %t1
sw %t0, -316(%fp)
lw %t0, -316(%fp)
lw %t1, -160(%fp)
add %t0, %t0, %t1
sw %t0, -312(%fp)
lw %t0, -312(%fp)
lw %t1, -164(%fp)
add %t0, %t0, %t1
sw %t0, -308(%fp)
lw %t0, -308(%fp)
lw %t1, -168(%fp)
add %t0, %t0, %t1
sw %t0, -304(%fp)
lw %rv, -304(%fp)
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
j L1 
L1:
lw %ra, 8(%sp)
lw %fp, 4(%sp)
addi %sp, %sp, 348
jr $ra
