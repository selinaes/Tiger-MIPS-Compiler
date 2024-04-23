Standard ML of New Jersey (64-bit) v110.99.4 [built: Tue Aug 01 16:07:38 2023]
- [opening run.sml]
[autoloading]
[library $smlnj/cm/cm.cm is stable]
[library $smlnj/internal/cm-sig-lib.cm is stable]
[library $/pgraph.cm is stable]
[library $smlnj/internal/srcpath-lib.cm is stable]
[library $SMLNJ-BASIS/basis.cm is stable]
[library $SMLNJ-BASIS/(basis.cm):basis-common.cm is stable]
[autoloading done]
[scanning sources.cm]
[library $/ml-yacc-lib.cm is stable]
[attempting to load plugin $/lex-ext.cm]
[library $/lex-ext.cm is stable]
[library $smlnj/cm/tools.cm is stable]
[library $smlnj/internal/cm-lib.cm is stable]
[plugin $/lex-ext.cm loaded successfully]
[attempting to load plugin $/mllex-tool.cm]
[library $/mllex-tool.cm is stable]
[plugin $/mllex-tool.cm loaded successfully]
[attempting to load plugin $/grm-ext.cm]
[library $/grm-ext.cm is stable]
[plugin $/grm-ext.cm loaded successfully]
[attempting to load plugin $/mlyacc-tool.cm]
[library $/mlyacc-tool.cm is stable]
[plugin $/mlyacc-tool.cm loaded successfully]
[parsing (sources.cm):main.sml]
[library $SMLNJ-ML-YACC-LIB/ml-yacc-lib.cm is stable]
[library $SMLNJ-LIB/Util/smlnj-lib.cm is stable]
[loading (sources.cm):table.sig]
[loading (sources.cm):table.sml]
[loading (sources.cm):symbol.sml]
[loading (sources.cm):temp.sig]
[loading (sources.cm):temp.sml]
[loading (sources.cm):graph.sig]
[loading (sources.cm):graph.sml]
[loading (sources.cm):flowgraph.sml]
[loading (sources.cm):types.sml]
[loading (sources.cm):tree.sml]
[loading (sources.cm):printtree.sml]
[loading (sources.cm):errormsg.sml]
[loading (sources.cm):assem.sml]
[loading (sources.cm):frame.sig]
[loading (sources.cm):frame.sml]
[loading (sources.cm):translate.sig]
[loading (sources.cm):translate.sml]
[loading (sources.cm):makegraph.sig]
[loading (sources.cm):liveness.sig]
[loading (sources.cm):liveness.sml]
[loading (sources.cm):color.sig]
[loading (sources.cm):makegraph.sml]
[loading (sources.cm):env.sig]
[loading (sources.cm):env.sml]
[loading (sources.cm):absyn.sml]
[loading (sources.cm):tiger.grm.sig]
[loading (sources.cm):tiger.grm.sml]
[loading (sources.cm):tiger.lex.sml]
[loading (sources.cm):color.sml]
[loading (sources.cm):codegen.sig]
[loading (sources.cm):codegen.sml]
[loading (sources.cm):reg_alloc.sig]
[loading (sources.cm):reg_alloc.sml]
[loading (sources.cm):parse.sml]
[loading (sources.cm):semant.sig]
[loading (sources.cm):semant.sml]
[loading (sources.cm):findEscape.sig]
[loading (sources.cm):findEscape.sml]
[loading (sources.cm):canon.sml]
[compiling (sources.cm):main.sml]
main.sml:8.8-8.28 Warning: match nonexhaustive
          SOME x => ...
  
[code: 10774, data: 158, env: 695 bytes]
[loading (sources.cm):prabsyn.sml]
[New bindings added.]
val it = true : bool
[autoloading]
[autoloading done]
val readAllFiles = fn : string -> string list
[autoloading]
[autoloading done]
val par = fn : string -> unit
[autoloading]
[autoloading done]
val sort = fn : string list -> string list
val contains = fn : string * string list -> bool
val runAllTests = fn : unit -> unit
val clear = fn : unit -> unit
isdigit:
addi t123, t123, -44
sw t122, 4(t123)
sw t124, 8(t123)
add t122, t123, 44
L44:
sw t118, 0(t122)
sw t110, -4(t122)
sw t111, -8(t122)
sw t112, -12(t122)
sw t113, -16(t122)
sw t114, -20(t122)
sw t115, -24(t122)
sw t116, -28(t122)
sw t117, -32(t122)
lw t166, 0(t122)
lw t165, 0(t166)
lw t164, -4(t165)
jal tig_ord
move t160, t158
la t167, L1
jal tig_ord
bge t160, t159, L5
L6:
addi t168, t126, 0
L7:
lw t169, -4(t122)
lw t170, -8(t122)
lw t171, -12(t122)
lw t172, -16(t122)
lw t173, -20(t122)
lw t174, -24(t122)
lw t175, -28(t122)
lw t176, -32(t122)
j L43 
L5:
addi t177, t126, 1
lw t180, 0(t122)
lw t179, 0(t180)
lw t178, -4(t179)
jal tig_ord
move t163, t161
la t181, L2
jal tig_ord
ble t163, t162, L3
L4:
addi t182, t126, 0
L3:
move t136, t135
j L7 
L43:
lw t124, 8(t123)
lw t122, 4(t123)
addi t123, t123, 44
jr $ra
skipto:
addi t123, t123, -44
sw t122, 4(t123)
sw t124, 8(t123)
add t122, t123, 44
L46:
sw t118, 0(t122)
sw t110, -4(t122)
sw t111, -8(t122)
sw t112, -12(t122)
sw t113, -16(t122)
sw t114, -20(t122)
sw t115, -24(t122)
sw t116, -28(t122)
sw t117, -32(t122)
L15:
lw t188, 0(t122)
lw t187, 0(t188)
lw t186, -4(t187)
la t189, L9
jal tig_stringEqual
addi t190, t126, 0
bne t185, t190, L11
L12:
lw t193, 0(t122)
lw t192, 0(t193)
lw t191, -4(t192)
la t194, L10
jal tig_stringEqual
L13:
addi t195, t126, 0
bne t137, t195, L14
L8:
addi t196, t126, 0
lw t197, -4(t122)
lw t198, -8(t122)
lw t199, -12(t122)
lw t200, -16(t122)
lw t201, -20(t122)
lw t202, -24(t122)
lw t203, -28(t122)
lw t204, -32(t122)
j L45 
L14:
lw t207, 0(t122)
lw t206, 0(t207)
addi t205, t206, -4
jal tig_getchar
sw t183, 0(t184)
j L15 
L11:
addi t208, t126, 1
j L13 
L45:
lw t124, 8(t123)
lw t122, 4(t123)
addi t123, t123, 44
jr $ra
readint:
addi t123, t123, -44
sw t122, 4(t123)
sw t124, 8(t123)
add t122, t123, 44
L48:
sw t118, 0(t122)
sw t110, -4(t122)
sw t111, -8(t122)
sw t112, -12(t122)
sw t113, -16(t122)
sw t114, -20(t122)
sw t115, -24(t122)
sw t116, -28(t122)
sw t117, -32(t122)
addi t218, t126, 0
move t118, t122
jal skipto
move t210, t132
move t118, t122
lw t220, 0(t122)
lw t219, -4(t220)
jal isdigit
sw t209, 0(t210)
L18:
move t118, t122
lw t222, 0(t122)
lw t221, -4(t222)
jal isdigit
addi t223, t126, 0
bne t217, t223, L17
L16:
move t128, t133
lw t224, -4(t122)
lw t225, -8(t122)
lw t226, -12(t122)
lw t227, -16(t122)
lw t228, -20(t122)
lw t229, -24(t122)
lw t230, -28(t122)
lw t231, -32(t122)
j L47 
L17:
addi t233, t126, 10
mul t232, t133, t233
lw t235, 0(t122)
lw t234, -4(t235)
jal tig_ord
add t236, t212, t211
la t237, L1
jal tig_ord
sub t238, t214, t213
lw t240, 0(t122)
addi t239, t240, -4
jal tig_getchar
sw t215, 0(t216)
j L18 
L47:
lw t124, 8(t123)
lw t122, 4(t123)
addi t123, t123, 44
jr $ra
readlist:
addi t123, t123, -44
sw t122, 4(t123)
sw t124, 8(t123)
add t122, t123, 44
L50:
sw t118, 0(t122)
sw t110, -4(t122)
sw t111, -8(t122)
sw t112, -12(t122)
sw t113, -16(t122)
sw t114, -20(t122)
sw t115, -24(t122)
sw t116, -28(t122)
sw t117, -32(t122)
addi t243, t126, 4
jal malloc
addi t244, t126, 0
sw t244, 0(t142)
move t143, t142
lw t245, 0(t122)
move t119, t143
jal readint
move t144, t128
lw t246, 0(t143)
addi t247, t126, 0
bne t246, t247, L19
L20:
addi t248, t126, 0
L21:
lw t249, -4(t122)
lw t250, -8(t122)
lw t251, -12(t122)
lw t252, -16(t122)
lw t253, -20(t122)
lw t254, -24(t122)
lw t255, -28(t122)
lw t256, -32(t122)
j L49 
L19:
addi t257, t126, 8
jal malloc
move t145, t128
sw t144, 0(t145)
addi t258, t145, 4
lw t259, 0(t122)
jal readlist
sw t241, 0(t242)
move t146, t145
j L21 
L49:
lw t124, 8(t123)
lw t122, 4(t123)
addi t123, t123, 44
jr $ra
merge:
addi t123, t123, -44
sw t122, 4(t123)
sw t124, 8(t123)
add t122, t123, 44
L52:
sw t118, 0(t122)
sw t110, -4(t122)
sw t111, -8(t122)
sw t112, -12(t122)
sw t113, -16(t122)
sw t114, -20(t122)
sw t115, -24(t122)
sw t116, -28(t122)
sw t117, -32(t122)
addi t264, t126, 0
beq t138, t264, L28
L29:
addi t265, t126, 0
beq t139, t265, L25
L26:
lw t266, 0(t138)
lw t267, 0(t139)
blt t266, t267, L22
L23:
addi t268, t126, 8
jal malloc
move t148, t128
lw t269, 0(t139)
sw t269, 0(t148)
addi t270, t148, 4
lw t271, 0(t122)
lw t272, 4(t139)
jal merge
sw t262, 0(t263)
L24:
move t150, t149
L27:
move t151, t150
L30:
lw t273, -4(t122)
lw t274, -8(t122)
lw t275, -12(t122)
lw t276, -16(t122)
lw t277, -20(t122)
lw t278, -24(t122)
lw t279, -28(t122)
lw t280, -32(t122)
j L51 
L28:
move t151, t139
j L30 
L25:
j L27 
L22:
addi t281, t126, 8
jal malloc
move t147, t128
lw t282, 0(t138)
sw t282, 0(t147)
addi t283, t147, 4
lw t284, 0(t122)
lw t285, 4(t138)
jal merge
sw t260, 0(t261)
j L24 
L51:
lw t124, 8(t123)
lw t122, 4(t123)
addi t123, t123, 44
jr $ra
f:
addi t123, t123, -44
sw t122, 4(t123)
sw t124, 8(t123)
add t122, t123, 44
L54:
move t152, t119
sw t118, 0(t122)
sw t110, -4(t122)
sw t111, -8(t122)
sw t112, -12(t122)
sw t113, -16(t122)
sw t114, -20(t122)
sw t115, -24(t122)
sw t116, -28(t122)
sw t117, -32(t122)
addi t289, t126, 0
bgt t152, t289, L31
L32:
addi t290, t126, 0
lw t291, -4(t122)
lw t292, -8(t122)
lw t293, -12(t122)
lw t294, -16(t122)
lw t295, -20(t122)
lw t296, -24(t122)
lw t297, -28(t122)
lw t298, -32(t122)
j L53 
L31:
lw t299, 0(t122)
addi t301, t126, 10
div t300, t152, t301
jal f
addi t305, t126, 10
div t304, t152, t305
addi t306, t126, 10
mul t303, t304, t306
sub t302, t152, t303
la t307, L1
jal tig_ord
add t308, t288, t287
jal tig_chr
move t286, t128
jal tig_print
j L32 
L53:
lw t124, 8(t123)
lw t122, 4(t123)
addi t123, t123, 44
jr $ra
printint:
addi t123, t123, -44
sw t122, 4(t123)
sw t124, 8(t123)
add t122, t123, 44
L56:
sw t118, 0(t122)
sw t110, -4(t122)
sw t111, -8(t122)
sw t112, -12(t122)
sw t113, -16(t122)
sw t114, -20(t122)
sw t115, -24(t122)
sw t116, -28(t122)
sw t117, -32(t122)
addi t309, t126, 0
blt t140, t309, L37
L38:
addi t310, t126, 0
bgt t140, t310, L34
L35:
la t311, L1
jal tig_print
L36:
L39:
lw t312, -4(t122)
lw t313, -8(t122)
lw t314, -12(t122)
lw t315, -16(t122)
lw t316, -20(t122)
lw t317, -24(t122)
lw t318, -28(t122)
lw t319, -32(t122)
j L55 
L37:
la t320, L33
jal tig_print
move t118, t122
addi t322, t126, 0
sub t321, t322, t140
jal f
j L39 
L34:
move t118, t122
jal f
j L36 
L55:
lw t124, 8(t123)
lw t122, 4(t123)
addi t123, t123, 44
jr $ra
printlist:
addi t123, t123, -44
sw t122, 4(t123)
sw t124, 8(t123)
add t122, t123, 44
L58:
move t141, t119
sw t118, 0(t122)
sw t110, -4(t122)
sw t111, -8(t122)
sw t112, -12(t122)
sw t113, -16(t122)
sw t114, -20(t122)
sw t115, -24(t122)
sw t116, -28(t122)
sw t117, -32(t122)
addi t323, t126, 0
beq t141, t323, L40
L41:
lw t324, 0(t122)
lw t325, 0(t141)
jal printint
la t326, L9
jal tig_print
lw t327, 0(t122)
lw t328, 4(t141)
jal printlist
L42:
lw t329, -4(t122)
lw t330, -8(t122)
lw t331, -12(t122)
lw t332, -16(t122)
lw t333, -20(t122)
lw t334, -24(t122)
lw t335, -28(t122)
lw t336, -32(t122)
j L57 
L40:
la t337, L10
jal tig_print
j L42 
L57:
lw t124, 8(t123)
lw t122, 4(t123)
addi t123, t123, 44
jr $ra
tig_main:
addi t123, t123, -48
sw t122, 4(t123)
sw t124, 8(t123)
add t122, t123, 48
L60:
sw t118, 0(t122)
sw t110, -8(t122)
sw t111, -12(t122)
sw t112, -16(t122)
sw t113, -20(t122)
sw t114, -24(t122)
sw t115, -28(t122)
sw t116, -32(t122)
sw t117, -36(t122)
addi t344, t122, -4
jal tig_getchar
sw t338, 0(t339)
move t118, t122
jal readlist
move t156, t128
addi t345, t122, -4
jal tig_getchar
sw t340, 0(t341)
move t118, t122
jal readlist
move t157, t128
move t343, t122
move t118, t122
jal merge
move t342, t128
move t118, t343
jal printlist
lw t346, -8(t122)
lw t347, -12(t122)
lw t348, -16(t122)
lw t349, -20(t122)
lw t350, -24(t122)
lw t351, -28(t122)
lw t352, -32(t122)
lw t353, -36(t122)
j L59 
L59:
lw t124, 8(t123)
lw t122, 4(t123)
addi t123, t123, 48
jr $ra
val it = () : unit
val it = () : unit
- 
