# ----- emit nfactor -----
digraph G {
n0 -> succ={n1 } 
    pred{}
n1 -> succ={n2 } 
    pred{n0 }
n2 -> succ={n3 } 
    pred{n1 }
n3 -> succ={n4 } 
    pred{n2 }
n4 -> succ={n5 } 
    pred{n3 }
n5 -> succ={n6 } 
    pred{n4 }
n6 -> succ={n7 } 
    pred{n5 }
n7 -> succ={n8 } 
    pred{n6 }
n8 -> succ={n9 } 
    pred{n7 }
n9 -> succ={n10 } 
    pred{n8 }
n10 -> succ={n11 } 
    pred{n9 }
n11 -> succ={n12 } 
    pred{n10 }
n12 -> succ={n13 } 
    pred{n11 }
n13 -> succ={n14 } 
    pred{n12 }
n14 -> succ={n15 } 
    pred{n13 }
n15 -> succ={n16 } 
    pred{n14 }
n16 -> succ={n17 } 
    pred{n15 }
n17 -> succ={n18 n47 } 
    pred{n16 }
n18 -> succ={n19 } 
    pred{n17 }
n19 -> succ={n20 } 
    pred{n18 }
n20 -> succ={n21 } 
    pred{n19 }
n21 -> succ={n22 } 
    pred{n20 }
n22 -> succ={n23 } 
    pred{n21 }
n23 -> succ={n24 } 
    pred{n22 }
n24 -> succ={n25 } 
    pred{n23 }
n25 -> succ={n26 } 
    pred{n24 }
n26 -> succ={n27 } 
    pred{n25 }
n27 -> succ={n28 } 
    pred{n26 }
n28 -> succ={n29 } 
    pred{n27 n50 }
n29 -> succ={n30 } 
    pred{n28 }
n30 -> succ={n31 } 
    pred{n29 }
n31 -> succ={n32 } 
    pred{n30 }
n32 -> succ={n33 } 
    pred{n31 }
n33 -> succ={n34 } 
    pred{n32 }
n34 -> succ={n35 } 
    pred{n33 }
n35 -> succ={n36 } 
    pred{n34 }
n36 -> succ={n37 } 
    pred{n35 }
n37 -> succ={n38 } 
    pred{n36 }
n38 -> succ={n39 } 
    pred{n37 }
n39 -> succ={n40 } 
    pred{n38 }
n40 -> succ={n41 } 
    pred{n39 }
n41 -> succ={n42 } 
    pred{n40 }
n42 -> succ={n43 } 
    pred{n41 }
n43 -> succ={n44 } 
    pred{n42 }
n44 -> succ={n45 } 
    pred{n43 }
n45 -> succ={n46 } 
    pred{n44 }
n46 -> succ={n51 } 
    pred{n45 }
n47 -> succ={n48 } 
    pred{n17 }
n48 -> succ={n49 } 
    pred{n47 }
n49 -> succ={n50 } 
    pred{n48 }
n50 -> succ={n28 } 
    pred{n49 }
n51 -> succ={n52 } 
    pred{n46 }
n52 -> succ={} 
    pred{n51 }
n53 -> succ={n54 } 
    pred{}
n54 -> succ={n55 } 
    pred{n53 }
n55 -> succ={n56 } 
    pred{n54 }
n56 -> succ={} 
    pred{n55 }
}
nfactor:
move t158, t159
addi t159, t159, -44
sw t160, 8(t159)
sw t158, 4(t159)
L5:
add t132, t167, $0
sw t166, -4(t158)
sw t178, -8(t158)
sw t179, -12(t158)
sw t180, -16(t158)
sw t181, -20(t158)
sw t182, -24(t158)
sw t183, -28(t158)
sw t184, -32(t158)
sw t185, -36(t158)
addi t136, $0, 0
beq t132, t136, L1
L2:
add t135, t132, $0
lw t137, 0(t158)
add t166, t137, $0
addi t138, t132, -1
add t167, t138, $0
jal nfactor
add t134, t164, $0
mul t139, t135, t134
add t133, t139, $0
L3:
add t164, t133, $0
lw t140, -8(t158)
add t178, t140, $0
lw t141, -12(t158)
add t179, t141, $0
lw t142, -16(t158)
add t180, t142, $0
lw t143, -20(t158)
add t181, t143, $0
lw t144, -24(t158)
add t182, t144, $0
lw t145, -28(t158)
add t183, t145, $0
lw t146, -32(t158)
add t184, t146, $0
lw t147, -36(t158)
add t185, t147, $0
j L4 
L1:
addi t148, $0, 1
add t133, t148, $0
j L3 
L4:
livein: sp, ra
some[] procEntryExit2, assem=""
liveout: empty
lw t160, 8(t159)
lw t158, 4(t159)
addi t159, t159, 44
jr t160
some[]

# ----- emit L0 -----
digraph G {
n0 -> succ={n1 } 
    pred{}
n1 -> succ={n2 } 
    pred{n0 }
n2 -> succ={n3 } 
    pred{n1 }
n3 -> succ={n4 } 
    pred{n2 }
n4 -> succ={n5 } 
    pred{n3 }
n5 -> succ={n6 } 
    pred{n4 }
n6 -> succ={n7 } 
    pred{n5 }
n7 -> succ={n8 } 
    pred{n6 }
n8 -> succ={n9 } 
    pred{n7 }
n9 -> succ={n10 } 
    pred{n8 }
n10 -> succ={n11 } 
    pred{n9 }
n11 -> succ={n12 } 
    pred{n10 }
n12 -> succ={n13 } 
    pred{n11 }
n13 -> succ={n14 } 
    pred{n12 }
n14 -> succ={n15 } 
    pred{n13 }
n15 -> succ={n16 } 
    pred{n14 }
n16 -> succ={n17 } 
    pred{n15 }
n17 -> succ={n18 } 
    pred{n16 }
n18 -> succ={n19 } 
    pred{n17 }
n19 -> succ={n20 } 
    pred{n18 }
n20 -> succ={n21 } 
    pred{n19 }
n21 -> succ={n22 } 
    pred{n20 }
n22 -> succ={n23 } 
    pred{n21 }
n23 -> succ={n24 } 
    pred{n22 }
n24 -> succ={n25 } 
    pred{n23 }
n25 -> succ={n26 } 
    pred{n24 }
n26 -> succ={n27 } 
    pred{n25 }
n27 -> succ={n28 } 
    pred{n26 }
n28 -> succ={n29 } 
    pred{n27 }
n29 -> succ={n30 } 
    pred{n28 }
n30 -> succ={n31 } 
    pred{n29 }
n31 -> succ={n32 } 
    pred{n30 }
n32 -> succ={n33 } 
    pred{n31 }
n33 -> succ={n34 } 
    pred{n32 }
n34 -> succ={n35 } 
    pred{n33 }
n35 -> succ={n36 } 
    pred{n34 }
n36 -> succ={n37 } 
    pred{n35 }
n37 -> succ={n38 } 
    pred{n36 }
n38 -> succ={} 
    pred{n37 }
n39 -> succ={n40 } 
    pred{}
n40 -> succ={n41 } 
    pred{n39 }
n41 -> succ={n42 } 
    pred{n40 }
n42 -> succ={} 
    pred{n41 }
}
L0:
move t158, t159
addi t159, t159, -44
sw t160, 8(t159)
sw t158, 4(t159)
L7:
sw t166, -4(t158)
sw t178, -8(t158)
sw t179, -12(t158)
sw t180, -16(t158)
sw t181, -20(t158)
sw t182, -24(t158)
sw t183, -28(t158)
sw t184, -32(t158)
sw t185, -36(t158)
add t166, t158, $0
addi t149, $0, 10
add t167, t149, $0
jal nfactor
add t164, t164, $0
lw t150, -8(t158)
add t178, t150, $0
lw t151, -12(t158)
add t179, t151, $0
lw t152, -16(t158)
add t180, t152, $0
lw t153, -20(t158)
add t181, t153, $0
lw t154, -24(t158)
add t182, t154, $0
lw t155, -28(t158)
add t183, t155, $0
lw t156, -32(t158)
add t184, t156, $0
lw t157, -36(t158)
add t185, t157, $0
j L6 
L6:
lw t160, 8(t159)
lw t158, 4(t159)
addi t159, t159, 44
jr t160
