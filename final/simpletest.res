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
[parsing (sources.cm):makegraph.sig]
[parsing (sources.cm):makegraph.sml]
[parsing (sources.cm):main.sml]
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
[compiling (sources.cm):makegraph.sig]
[code: 65, data: 1, env: 232 bytes]
[loading (sources.cm):liveness.sig]
[loading (sources.cm):liveness.sml]
[loading (sources.cm):color.sig]
[compiling (sources.cm):makegraph.sml]
makegraph.sml:13.39-13.44 Error: unbound variable or constructor: instr
makegraph.sml:15.21-16.38 Error: operator is not a function [tycon mismatch]
  operator: unit
  in expression:
    (print
      ("n" ^ Int.toString index ^ " : " ^
          String.substring (str,0,String.size str - 1) ^ "\n")) printOne
val it = false : bool
[autoloading]
[autoloading done]
val readAllFiles = fn : string -> string list
[autoloading]
[autoloading done]
run.sml:20.23-20.34 Error: unbound structure: Parse in path Parse.parse
run.sml:23.21-23.42 Error: unbound structure: FindEscape in path FindEscape.findEscape
run.sml:24.27-24.43 Error: unbound structure: Semant in path Semant.transProg
run.sml:31.13-31.28 Error: unbound structure: Frame in path Frame.printFrag
run.sml:28.13-28.29 Error: unbound structure: PrintAbsyn in path PrintAbsyn.print
val it = () : unit
- 
