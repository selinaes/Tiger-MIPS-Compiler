L1 : .ascii aname 
L2 : .ascii somewhere 
L3 : .ascii  
L4 : .ascii Kapoios 
L5 : .ascii Kapou 
L6 : .ascii Allos 
L16 : .ascii kati 
L23 : .ascii sfd 
L24 : .ascii sdf 
# ----- emit L0 -----
L0:
move t100, t101
addi t101, t101, -44
sw t102, 8(t101)
sw t100, 4(t101)
L32:
sw t108, -4(t100)
sw t120, -8(t100)
sw t121, -12(t100)
sw t122, -16(t100)
sw t123, -20(t100)
sw t124, -24(t100)
sw t125, -28(t100)
sw t126, -32(t100)
sw t127, -36(t100)
addi t156, $0, 10
add t108, t156, $0
addi t157, $0, 0
add t109, t157, $0
jal initArray 
add t132, t106, $0
addi t158, $0, 16
add t108, t158, $0
jal malloc 
add t133, t106, $0
la t159, L1
sw t159, 0(t133)
la t160, L2
sw t160, 4(t133)
addi t161, $0, 0
sw t161, 8(t133)
addi t162, $0, 0
sw t162, 12(t133)
addi t163, $0, 5
add t108, t163, $0
add t109, t133, $0
jal initArray 
add t134, t106, $0
addi t164, $0, 100
add t108, t164, $0
la t165, L3
add t109, t165, $0
jal initArray 
add t135, t106, $0
addi t166, $0, 16
add t108, t166, $0
jal malloc 
add t136, t106, $0
la t167, L4
sw t167, 0(t136)
la t168, L5
sw t168, 4(t136)
addi t169, $0, 2432
sw t169, 8(t136)
addi t170, $0, 44
sw t170, 12(t136)
add t137, t136, $0
addi t171, $0, 8
add t108, t171, $0
jal malloc 
add t138, t106, $0
la t172, L6
sw t172, 0(t138)
addi t173, t138, 4
add t155, t173, $0
addi t174, $0, 3
add t108, t174, $0
addi t175, $0, 1900
add t109, t175, $0
jal initArray 
add t154, t106, $0
sw t154, 0(t155)
add t139, t138, $0
addi t176, $0, 0
add t140, t176, $0
lw t177, -4(t132)
add t141, t177, $0
bge t140, t141, L7
L8:
addi t178, $0, 0
blt t140, t178, L7
L9:
addi t181, $0, 0
addi t182, $0, 4
mul t180, t181, t182
add t179, t132, t180
addi t183, $0, 1
sw t183, 0(t179)
addi t184, $0, 9
add t142, t184, $0
lw t185, -4(t132)
add t143, t185, $0
bge t142, t143, L10
L11:
addi t186, $0, 0
blt t142, t186, L10
L12:
addi t189, $0, 9
addi t190, $0, 4
mul t188, t189, t190
add t187, t132, t188
addi t191, $0, 3
sw t191, 0(t187)
addi t192, $0, 3
add t144, t192, $0
lw t193, -4(t134)
add t145, t193, $0
bge t144, t145, L13
L14:
addi t194, $0, 0
blt t144, t194, L13
L15:
addi t198, $0, 3
addi t199, $0, 4
mul t197, t198, t199
add t196, t134, t197
lw t195, 0(t196)
la t200, L16
sw t200, 0(t195)
addi t201, $0, 1
add t146, t201, $0
lw t202, -4(t134)
add t147, t202, $0
bge t146, t147, L17
L18:
addi t203, $0, 0
blt t146, t203, L17
L19:
addi t207, $0, 1
addi t208, $0, 4
mul t206, t207, t208
add t205, t134, t206
lw t204, 0(t205)
addi t209, $0, 23
sw t209, 12(t204)
addi t210, $0, 34
add t148, t210, $0
lw t211, -4(t135)
add t149, t211, $0
bge t148, t149, L20
L21:
addi t212, $0, 0
blt t148, t212, L20
L22:
addi t215, $0, 34
addi t216, $0, 4
mul t214, t215, t216
add t213, t135, t214
la t217, L23
sw t217, 0(t213)
la t218, L24
sw t218, 0(t137)
addi t219, $0, 0
add t150, t219, $0
lw t221, 4(t139)
lw t220, -4(t221)
add t151, t220, $0
bge t150, t151, L25
L26:
addi t222, $0, 0
blt t150, t222, L25
L27:
lw t224, 4(t139)
addi t226, $0, 0
addi t227, $0, 4
mul t225, t226, t227
add t223, t224, t225
addi t228, $0, 2323
sw t228, 0(t223)
addi t229, $0, 2
add t152, t229, $0
lw t231, 4(t139)
lw t230, -4(t231)
add t153, t230, $0
bge t152, t153, L28
L29:
addi t232, $0, 0
blt t152, t232, L28
L30:
lw t234, 4(t139)
addi t236, $0, 2
addi t237, $0, 4
mul t235, t236, t237
add t233, t234, t235
addi t238, $0, 2323
sw t238, 0(t233)
addi t239, $0, 0
add t106, t239, $0
lw t240, -8(t100)
add t120, t240, $0
lw t241, -12(t100)
add t121, t241, $0
lw t242, -16(t100)
add t122, t242, $0
lw t243, -20(t100)
add t123, t243, $0
lw t244, -24(t100)
add t124, t244, $0
lw t245, -28(t100)
add t125, t245, $0
lw t246, -32(t100)
add t126, t246, $0
lw t247, -36(t100)
add t127, t247, $0
j L31 
L7:
addi t248, $0, 1
add t108, t248, $0
jal exit 
j L9 
L10:
addi t249, $0, 1
add t108, t249, $0
jal exit 
j L12 
L13:
addi t250, $0, 1
add t108, t250, $0
jal exit 
j L15 
L17:
addi t251, $0, 1
add t108, t251, $0
jal exit 
j L19 
L20:
addi t252, $0, 1
add t108, t252, $0
jal exit 
j L22 
L25:
addi t253, $0, 1
add t108, t253, $0
jal exit 
j L27 
L28:
addi t254, $0, 1
add t108, t254, $0
jal exit 
j L30 
L31:
lw t102, 8(t101)
lw t100, 4(t101)
addi t101, t101, 44
jr t102
