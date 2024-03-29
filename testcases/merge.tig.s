L1 : .ascii 0 
L2 : .ascii 9 
# ----- emit isdigit -----
isdigit:
move t100, t101
addi t101, t101, -44
sw t102, 8(t101)
sw t100, 4(t101)
L44:
add t134, t109, $0
sw t108, -4(t100)
sw t120, -8(t100)
sw t121, -12(t100)
sw t122, -16(t100)
sw t123, -20(t100)
sw t124, -24(t100)
sw t125, -28(t100)
sw t126, -32(t100)
sw t127, -36(t100)
lw t166, 0(t100)
lw t165, 0(t166)
lw t164, -8(t165)
add t108, t164, $0
jal L3 
add t158, t106, $0
add t160, t158, $0
la t167, L1
add t108, t167, $0
jal L3 
add t159, t106, $0
bge t160, t159, L5
L6:
addi t168, $0, 0
add t136, t168, $0
L7:
add t106, t136, $0
lw t169, -8(t100)
add t120, t169, $0
lw t170, -12(t100)
add t121, t170, $0
lw t171, -16(t100)
add t122, t171, $0
lw t172, -20(t100)
add t123, t172, $0
lw t173, -24(t100)
add t124, t173, $0
lw t174, -28(t100)
add t125, t174, $0
lw t175, -32(t100)
add t126, t175, $0
lw t176, -36(t100)
add t127, t176, $0
j L43 
L5:
addi t177, $0, 1
add t135, t177, $0
lw t180, 0(t100)
lw t179, 0(t180)
lw t178, -8(t179)
add t108, t178, $0
jal L3 
add t161, t106, $0
add t163, t161, $0
la t181, L2
add t108, t181, $0
jal L3 
add t162, t106, $0
ble t163, t162, L3
L4:
addi t182, $0, 0
add t135, t182, $0
L3:
add t136, t135, $0
j L7 
L43:
lw t102, 8(t101)
lw t100, 4(t101)
addi t101, t101, 44
jr t102
L9 : .ascii   
L10 : .ascii 
 
# ----- emit skipto -----
skipto:
move t100, t101
addi t101, t101, -44
sw t102, 8(t101)
sw t100, 4(t101)
L46:
sw t108, -4(t100)
sw t120, -8(t100)
sw t121, -12(t100)
sw t122, -16(t100)
sw t123, -20(t100)
sw t124, -24(t100)
sw t125, -28(t100)
sw t126, -32(t100)
sw t127, -36(t100)
L15:
lw t188, 0(t100)
lw t187, 0(t188)
lw t186, -8(t187)
add t108, t186, $0
la t189, L9
add t109, t189, $0
jal stringEqual 
add t185, t106, $0
addi t190, $0, 0
bne t185, t190, L11
L12:
lw t193, 0(t100)
lw t192, 0(t193)
lw t191, -8(t192)
add t108, t191, $0
la t194, L10
add t109, t194, $0
jal stringEqual 
add t137, t106, $0
L13:
addi t195, $0, 0
bne t137, t195, L14
L8:
addi t196, $0, 0
add t106, t196, $0
lw t197, -8(t100)
add t120, t197, $0
lw t198, -12(t100)
add t121, t198, $0
lw t199, -16(t100)
add t122, t199, $0
lw t200, -20(t100)
add t123, t200, $0
lw t201, -24(t100)
add t124, t201, $0
lw t202, -28(t100)
add t125, t202, $0
lw t203, -32(t100)
add t126, t203, $0
lw t204, -36(t100)
add t127, t204, $0
j L45 
L14:
lw t207, 0(t100)
lw t206, 0(t207)
addi t205, t206, -8
add t184, t205, $0
jal L2 
add t183, t106, $0
sw t183, 0(t184)
j L15 
L11:
addi t208, $0, 1
add t137, t208, $0
j L13 
L45:
lw t102, 8(t101)
lw t100, 4(t101)
addi t101, t101, 44
jr t102
# ----- emit readint -----
readint:
move t100, t101
addi t101, t101, -44
sw t102, 8(t101)
sw t100, 4(t101)
L48:
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
addi t218, $0, 0
add t133, t218, $0
add t108, t100, $0
jal skipto 
add t210, t132, $0
add t108, t100, $0
lw t220, 0(t100)
lw t219, -8(t220)
add t109, t219, $0
jal isdigit 
add t209, t106, $0
sw t209, 0(t210)
L18:
add t108, t100, $0
lw t222, 0(t100)
lw t221, -8(t222)
add t109, t221, $0
jal isdigit 
add t217, t106, $0
addi t223, $0, 0
bne t217, t223, L17
L16:
add t106, t133, $0
lw t224, -8(t100)
add t120, t224, $0
lw t225, -12(t100)
add t121, t225, $0
lw t226, -16(t100)
add t122, t226, $0
lw t227, -20(t100)
add t123, t227, $0
lw t228, -24(t100)
add t124, t228, $0
lw t229, -28(t100)
add t125, t229, $0
lw t230, -32(t100)
add t126, t230, $0
lw t231, -36(t100)
add t127, t231, $0
j L47 
L17:
addi t233, $0, 10
mul t232, t133, t233
add t212, t232, $0
lw t235, 0(t100)
lw t234, -8(t235)
add t108, t234, $0
jal L3 
add t211, t106, $0
add t236, t212, t211
add t214, t236, $0
la t237, L1
add t108, t237, $0
jal L3 
add t213, t106, $0
sub t238, t214, t213
add t133, t238, $0
lw t240, 0(t100)
addi t239, t240, -8
add t216, t239, $0
jal L2 
add t215, t106, $0
sw t215, 0(t216)
j L18 
L47:
lw t102, 8(t101)
lw t100, 4(t101)
addi t101, t101, 44
jr t102
# ----- emit readlist -----
readlist:
move t100, t101
addi t101, t101, -44
sw t102, 8(t101)
sw t100, 4(t101)
L50:
sw t108, -4(t100)
sw t120, -8(t100)
sw t121, -12(t100)
sw t122, -16(t100)
sw t123, -20(t100)
sw t124, -24(t100)
sw t125, -28(t100)
sw t126, -32(t100)
sw t127, -36(t100)
addi t243, $0, 4
add t108, t243, $0
jal malloc 
add t142, t106, $0
addi t244, $0, 0
sw t244, 0(t142)
add t143, t142, $0
lw t245, 0(t100)
add t108, t245, $0
add t109, t143, $0
jal readint 
add t144, t106, $0
lw t246, 0(t143)
addi t247, $0, 0
bne t246, t247, L19
L20:
addi t248, $0, 0
add t146, t248, $0
L21:
add t106, t146, $0
lw t249, -8(t100)
add t120, t249, $0
lw t250, -12(t100)
add t121, t250, $0
lw t251, -16(t100)
add t122, t251, $0
lw t252, -20(t100)
add t123, t252, $0
lw t253, -24(t100)
add t124, t253, $0
lw t254, -28(t100)
add t125, t254, $0
lw t255, -32(t100)
add t126, t255, $0
lw t256, -36(t100)
add t127, t256, $0
j L49 
L19:
addi t257, $0, 8
add t108, t257, $0
jal malloc 
add t145, t106, $0
sw t144, 0(t145)
addi t258, t145, 4
add t242, t258, $0
lw t259, 0(t100)
add t108, t259, $0
jal readlist 
add t241, t106, $0
sw t241, 0(t242)
add t146, t145, $0
j L21 
L49:
lw t102, 8(t101)
lw t100, 4(t101)
addi t101, t101, 44
jr t102
# ----- emit merge -----
merge:
move t100, t101
addi t101, t101, -44
sw t102, 8(t101)
sw t100, 4(t101)
L52:
add t139, t110, $0
add t138, t109, $0
sw t108, -4(t100)
sw t120, -8(t100)
sw t121, -12(t100)
sw t122, -16(t100)
sw t123, -20(t100)
sw t124, -24(t100)
sw t125, -28(t100)
sw t126, -32(t100)
sw t127, -36(t100)
addi t264, $0, 0
beq t138, t264, L28
L29:
addi t265, $0, 0
beq t139, t265, L25
L26:
lw t266, 0(t138)
lw t267, 0(t139)
blt t266, t267, L22
L23:
addi t268, $0, 8
add t108, t268, $0
jal malloc 
add t148, t106, $0
lw t269, 0(t139)
sw t269, 0(t148)
addi t270, t148, 4
add t263, t270, $0
lw t271, 0(t100)
add t108, t271, $0
add t109, t138, $0
lw t272, 4(t139)
add t110, t272, $0
jal merge 
add t262, t106, $0
sw t262, 0(t263)
add t149, t148, $0
L24:
add t150, t149, $0
L27:
add t151, t150, $0
L30:
add t106, t151, $0
lw t273, -8(t100)
add t120, t273, $0
lw t274, -12(t100)
add t121, t274, $0
lw t275, -16(t100)
add t122, t275, $0
lw t276, -20(t100)
add t123, t276, $0
lw t277, -24(t100)
add t124, t277, $0
lw t278, -28(t100)
add t125, t278, $0
lw t279, -32(t100)
add t126, t279, $0
lw t280, -36(t100)
add t127, t280, $0
j L51 
L28:
add t151, t139, $0
j L30 
L25:
add t150, t138, $0
j L27 
L22:
addi t281, $0, 8
add t108, t281, $0
jal malloc 
add t147, t106, $0
lw t282, 0(t138)
sw t282, 0(t147)
addi t283, t147, 4
add t261, t283, $0
lw t284, 0(t100)
add t108, t284, $0
lw t285, 4(t138)
add t109, t285, $0
add t110, t139, $0
jal merge 
add t260, t106, $0
sw t260, 0(t261)
add t149, t147, $0
j L24 
L51:
lw t102, 8(t101)
lw t100, 4(t101)
addi t101, t101, 44
jr t102
# ----- emit f -----
f:
move t100, t101
addi t101, t101, -44
sw t102, 8(t101)
sw t100, 4(t101)
L54:
add t152, t109, $0
sw t108, -4(t100)
sw t120, -8(t100)
sw t121, -12(t100)
sw t122, -16(t100)
sw t123, -20(t100)
sw t124, -24(t100)
sw t125, -28(t100)
sw t126, -32(t100)
sw t127, -36(t100)
addi t289, $0, 0
bgt t152, t289, L31
L32:
addi t290, $0, 0
add t106, t290, $0
lw t291, -8(t100)
add t120, t291, $0
lw t292, -12(t100)
add t121, t292, $0
lw t293, -16(t100)
add t122, t293, $0
lw t294, -20(t100)
add t123, t294, $0
lw t295, -24(t100)
add t124, t295, $0
lw t296, -28(t100)
add t125, t296, $0
lw t297, -32(t100)
add t126, t297, $0
lw t298, -36(t100)
add t127, t298, $0
j L53 
L31:
lw t299, 0(t100)
add t108, t299, $0
addi t301, $0, 10
div t300, t152, t301
add t109, t300, $0
jal f 
addi t305, $0, 10
div t304, t152, t305
addi t306, $0, 10
mul t303, t304, t306
sub t302, t152, t303
add t288, t302, $0
la t307, L1
add t108, t307, $0
jal L3 
add t287, t106, $0
add t308, t288, t287
add t108, t308, $0
jal L4 
add t286, t106, $0
add t108, t286, $0
jal L0 
j L32 
L53:
lw t102, 8(t101)
lw t100, 4(t101)
addi t101, t101, 44
jr t102
L33 : .ascii - 
# ----- emit printint -----
printint:
move t100, t101
addi t101, t101, -44
sw t102, 8(t101)
sw t100, 4(t101)
L56:
add t140, t109, $0
sw t108, -4(t100)
sw t120, -8(t100)
sw t121, -12(t100)
sw t122, -16(t100)
sw t123, -20(t100)
sw t124, -24(t100)
sw t125, -28(t100)
sw t126, -32(t100)
sw t127, -36(t100)
addi t309, $0, 0
blt t140, t309, L37
L38:
addi t310, $0, 0
bgt t140, t310, L34
L35:
la t311, L1
add t108, t311, $0
jal L0 
add t153, t106, $0
L36:
add t154, t153, $0
L39:
add t106, t154, $0
lw t312, -8(t100)
add t120, t312, $0
lw t313, -12(t100)
add t121, t313, $0
lw t314, -16(t100)
add t122, t314, $0
lw t315, -20(t100)
add t123, t315, $0
lw t316, -24(t100)
add t124, t316, $0
lw t317, -28(t100)
add t125, t317, $0
lw t318, -32(t100)
add t126, t318, $0
lw t319, -36(t100)
add t127, t319, $0
j L55 
L37:
la t320, L33
add t108, t320, $0
jal L0 
add t108, t100, $0
addi t321, t140, 0
add t109, t321, $0
jal f 
add t154, t106, $0
j L39 
L34:
add t108, t100, $0
add t109, t140, $0
jal f 
add t153, t106, $0
j L36 
L55:
lw t102, 8(t101)
lw t100, 4(t101)
addi t101, t101, 44
jr t102
# ----- emit printlist -----
printlist:
move t100, t101
addi t101, t101, -44
sw t102, 8(t101)
sw t100, 4(t101)
L58:
add t141, t109, $0
sw t108, -4(t100)
sw t120, -8(t100)
sw t121, -12(t100)
sw t122, -16(t100)
sw t123, -20(t100)
sw t124, -24(t100)
sw t125, -28(t100)
sw t126, -32(t100)
sw t127, -36(t100)
addi t322, $0, 0
beq t141, t322, L40
L41:
lw t323, 0(t100)
add t108, t323, $0
lw t324, 0(t141)
add t109, t324, $0
jal printint 
la t325, L9
add t108, t325, $0
jal L0 
lw t326, 0(t100)
add t108, t326, $0
lw t327, 4(t141)
add t109, t327, $0
jal printlist 
add t155, t106, $0
L42:
add t106, t155, $0
lw t328, -8(t100)
add t120, t328, $0
lw t329, -12(t100)
add t121, t329, $0
lw t330, -16(t100)
add t122, t330, $0
lw t331, -20(t100)
add t123, t331, $0
lw t332, -24(t100)
add t124, t332, $0
lw t333, -28(t100)
add t125, t333, $0
lw t334, -32(t100)
add t126, t334, $0
lw t335, -36(t100)
add t127, t335, $0
j L57 
L40:
la t336, L10
add t108, t336, $0
jal L0 
add t155, t106, $0
j L42 
L57:
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
L60:
sw t108, -4(t100)
sw t120, -12(t100)
sw t121, -16(t100)
sw t122, -20(t100)
sw t123, -24(t100)
sw t124, -28(t100)
sw t125, -32(t100)
sw t126, -36(t100)
sw t127, -40(t100)
addi t343, t100, -8
add t338, t343, $0
jal L2 
add t337, t106, $0
sw t337, 0(t338)
add t108, t100, $0
jal readlist 
add t156, t106, $0
addi t344, t100, -8
add t340, t344, $0
jal L2 
add t339, t106, $0
sw t339, 0(t340)
add t108, t100, $0
jal readlist 
add t157, t106, $0
add t342, t100, $0
add t108, t100, $0
add t109, t156, $0
add t110, t157, $0
jal merge 
add t341, t106, $0
add t108, t342, $0
add t109, t341, $0
jal printlist 
add t106, t106, $0
lw t345, -12(t100)
add t120, t345, $0
lw t346, -16(t100)
add t121, t346, $0
lw t347, -20(t100)
add t122, t347, $0
lw t348, -24(t100)
add t123, t348, $0
lw t349, -28(t100)
add t124, t349, $0
lw t350, -32(t100)
add t125, t350, $0
lw t351, -36(t100)
add t126, t351, $0
lw t352, -40(t100)
add t127, t352, $0
j L59 
L59:
lw t102, 8(t101)
lw t100, 4(t101)
addi t101, t101, 48
jr t102
