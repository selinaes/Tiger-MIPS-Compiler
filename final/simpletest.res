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
[parsing (sources.cm):dominator.sig]
[parsing (sources.cm):dominator.sml]
[parsing (sources.cm):reg_alloc.sml]
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
[loading (sources.cm):reachingDef.sig]
[loading (sources.cm):reachingDef.sml]
[loading (sources.cm):env.sig]
[loading (sources.cm):env.sml]
[loading (sources.cm):absyn.sml]
[loading (sources.cm):tiger.grm.sig]
[loading (sources.cm):tiger.grm.sml]
[loading (sources.cm):tiger.lex.sml]
[compiling (sources.cm):dominator.sig]
[code: 65, data: 1, env: 133 bytes]
[compiling (sources.cm):dominator.sml]
[code: 8047, data: 47, env: 52 bytes]
[loading (sources.cm):color.sml]
[loading (sources.cm):codegen.sig]
[loading (sources.cm):codegen.sml]
[loading (sources.cm):reg_alloc.sig]
[compiling (sources.cm):reg_alloc.sml]
reg_alloc.sml:77.41-77.80 Warning: binding not exhaustive
          (allLoad,src' :: nil) = ...
reg_alloc.sml:76.41-76.82 Warning: binding not exhaustive
          (allStore,dst' :: nil) = ...
[code: 11353, data: 153, env: 424 bytes]
[loading (sources.cm):parse.sml]
[loading (sources.cm):semant.sig]
[loading (sources.cm):semant.sml]
[loading (sources.cm):findEscape.sig]
[loading (sources.cm):findEscape.sml]
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
# ----- emit tig_main -----
n0 : L2:
n1 : sw t118, 0(t122)
n2 : move t135, t124
n3 : move t136, t110
n4 : move t137, t111
n5 : move t138, t112
n6 : move t139, t113
n7 : move t140, t114
n8 : move t141, t115
n9 : move t142, t116
n10 : move t143, t117
n11 : addi t132, t126, 0
n12 : addi t133, t126, 1
n13 : addi t134, t126, 1
n14 : add t144, t132, t133
n15 : move t134, t144
n16 : addi t128, t126, 0
n17 : move t117, t143
n18 : move t116, t142
n19 : move t115, t141
n20 : move t114, t140
n21 : move t113, t139
n22 : move t112, t138
n23 : move t111, t137
n24 : move t110, t136
n25 : move t124, t135
n26 : j L1 
n27 : L1:
n28 : 
Instr1:1 
Instr2:2 
Instr3:3 
Instr4:4 
Instr5:5 
Instr6:6 
Instr7:7 
Instr8:8 
Instr9:9 
Instr10:10 
Instr11:11 
Instr12:12 
Instr13:13 
Instr14:14 
Instr15:15 
Instr16:16 
Instr17:17 
Instr18:18 
Instr19:19 
Instr20:20 
Instr21:21 
Instr22:22 
Instr23:23 
Instr24:24 
Instr25:25 
Instr26:26 
Instr27:27 
Instr28:28 
val it = () : unit
val it = () : unit
- 
