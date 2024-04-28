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
[library $SMLNJ-ML-YACC-LIB/ml-yacc-lib.cm is stable]
[library $SMLNJ-LIB/Util/smlnj-lib.cm is stable]
[loading (sources.cm):table.sig]
[loading (sources.cm):table.sml]
[loading (sources.cm):symbol.sml]
[loading (sources.cm):temp.sig]
[loading (sources.cm):temp.sml]
[loading (sources.cm):errormsg.sml]
[loading (sources.cm):assem.sml]
[loading (sources.cm):graph.sig]
[loading (sources.cm):graph.sml]
[loading (sources.cm):flowgraph.sml]
[loading (sources.cm):types.sml]
[loading (sources.cm):tree.sml]
[loading (sources.cm):printtree.sml]
[loading (sources.cm):frame.sig]
[loading (sources.cm):frame.sml]
[loading (sources.cm):translate.sig]
[loading (sources.cm):translate.sml]
[loading (sources.cm):makegraph.sig]
[loading (sources.cm):liveness.sig]
[loading (sources.cm):liveness.sml]
[loading (sources.cm):color.sig]
[loading (sources.cm):makegraph.sml]
[loading (sources.cm):reachingDef.sig]
[loading (sources.cm):reachingDef.sml]
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
[loading (sources.cm):dominator.sig]
[loading (sources.cm):dominator.sml]
[loading (sources.cm):canon.sml]
[loading (sources.cm):main.sml]
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
# ----- emit f -----
n0 : L15:
n1 : move t138, t119
n2 : sw t118, 0(t122)
n3 : move t139, t124
n4 : move t140, t110
n5 : move t141, t111
n6 : move t142, t112
n7 : move t143, t113
n8 : move t144, t114
n9 : move t145, t115
n10 : move t146, t116
n11 : move t147, t117
n12 : addi t171, t126, 0
n13 : bgt t138, t171, L2
n14 : L3:
n15 : addi t128, t126, 0
n16 : move t117, t147
n17 : move t116, t146
n18 : move t115, t145
n19 : move t114, t144
n20 : move t113, t143
n21 : move t112, t142
n22 : move t111, t141
n23 : move t110, t140
n24 : move t124, t139
n25 : j L14 
n26 : L2:
n27 : lw t172, 0(t122)
n28 : move t118, t172
n29 : addi t174, t126, 10
n30 : div t173, t138, t174
n31 : move t119, t173
n32 : jal f
n33 : 
n34 : addi t178, t126, 10
n35 : div t177, t138, t178
n36 : addi t179, t126, 10
n37 : mul t176, t177, t179
n38 : sub t175, t138, t176
n39 : move t170, t175
n40 : la t180, L1
n41 : move t118, t180
n42 : jal tig_ord
n43 : 
n44 : move t169, t128
n45 : add t181, t170, t169
n46 : move t118, t181
n47 : jal tig_chr
n48 : 
n49 : move t168, t128
n50 : move t118, t168
n51 : jal tig_print
n52 : 
n53 : j L3 
n54 : L14:
n55 : 
Loops: 
rewrite program done
# ----- emit printint -----
n0 : L17:
n1 : move t137, t119
n2 : sw t118, 0(t122)
n3 : move t150, t124
n4 : move t151, t110
n5 : move t152, t111
n6 : move t153, t112
n7 : move t154, t113
n8 : move t155, t114
n9 : move t156, t115
n10 : move t157, t116
n11 : move t158, t117
n12 : addi t191, t126, 0
n13 : blt t137, t191, L8
n14 : L9:
n15 : addi t192, t126, 0
n16 : bgt t137, t192, L5
n17 : L6:
n18 : la t193, L1
n19 : move t118, t193
n20 : jal tig_print
n21 : 
n22 : move t148, t128
n23 : L7:
n24 : move t149, t148
n25 : L10:
n26 : move t128, t149
n27 : move t117, t158
n28 : move t116, t157
n29 : move t115, t156
n30 : move t114, t155
n31 : move t113, t154
n32 : move t112, t153
n33 : move t111, t152
n34 : move t110, t151
n35 : move t124, t150
n36 : j L16 
n37 : L8:
n38 : la t194, L4
n39 : move t118, t194
n40 : jal tig_print
n41 : 
n42 : move t118, t122
n43 : addi t196, t126, 0
n44 : sub t195, t196, t137
n45 : move t119, t195
n46 : jal f
n47 : 
n48 : move t149, t128
n49 : j L10 
n50 : L5:
n51 : move t118, t122
n52 : move t119, t137
n53 : jal f
n54 : 
n55 : move t148, t128
n56 : j L7 
n57 : L16:
n58 : 
Loops: 
rewrite program done
# ----- emit tig_main -----
n0 : L19:
n1 : sw t118, 0(t122)
n2 : move t159, t124
n3 : move t160, t110
n4 : move t161, t111
n5 : move t162, t112
n6 : move t163, t113
n7 : move t164, t114
n8 : move t165, t115
n9 : move t166, t116
n10 : move t167, t117
n11 : addi t132, t126, 0
n12 : addi t133, t126, 6
n13 : addi t134, t126, 1
n14 : addi t135, t126, 5
n15 : addi t136, t126, 2
n16 : L13:
n17 : ble t133, t135, L12
n18 : L11:
n19 : move t118, t122
n20 : move t119, t136
n21 : jal printint
n22 : 
n23 : move t128, t128
n24 : move t117, t167
n25 : move t116, t166
n26 : move t115, t165
n27 : move t114, t164
n28 : move t113, t163
n29 : move t112, t162
n30 : move t111, t161
n31 : move t110, t160
n32 : move t124, t159
n33 : j L18 
n34 : L12:
n35 : addi t204, t132, 1
n36 : move t136, t204
n37 : addi t205, t136, 8
n38 : move t132, t205
n39 : addi t206, t133, 1
n40 : move t133, t206
n41 : j L13 
n42 : L18:
n43 : 
Loops: (from: n16, to: n41) 
hoistlst len=0
rewrite program done
val it = () : unit
val it = () : unit
- 
