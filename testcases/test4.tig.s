n0 : nfactor:
n1 : move t100, t101
n2 : addi t101, t101, -44
n3 : sw t102, 8(t101)
n4 : sw t100, 4(t101)
n5 : L5:
n6 : add t132, t109, $0
n7 : sw t108, -4(t100)
n8 : sw t120, -8(t100)
n9 : sw t121, -12(t100)
n10 : sw t122, -16(t100)
n11 : sw t123, -20(t100)
n12 : sw t124, -24(t100)
n13 : sw t125, -28(t100)
n14 : sw t126, -32(t100)
n15 : sw t127, -36(t100)
n16 : addi t136, $0, 0
n17 : beq t132, t136, L1
n18 : L2:
n19 : add t135, t132, $0
n20 : lw t137, 0(t100)
n21 : add t108, t137, $0
n22 : addi t138, t132, -1
n23 : add t109, t138, $0
n24 : jal nfactor
n25 : add t134, t106, $0
n26 : mul t139, t135, t134
n27 : add t133, t139, $0
n28 : L3:
n29 : add t106, t133, $0
n30 : lw t140, -8(t100)
n31 : add t120, t140, $0
n32 : lw t141, -12(t100)
n33 : add t121, t141, $0
n34 : lw t142, -16(t100)
n35 : add t122, t142, $0
n36 : lw t143, -20(t100)
n37 : add t123, t143, $0
n38 : lw t144, -24(t100)
n39 : add t124, t144, $0
n40 : lw t145, -28(t100)
n41 : add t125, t145, $0
n42 : lw t146, -32(t100)
n43 : add t126, t146, $0
n44 : lw t147, -36(t100)
n45 : add t127, t147, $0
n46 : j L4 
n47 : L1:
n48 : addi t148, $0, 1
n49 : add t133, t148, $0
n50 : j L3 
n51 : L4:
n52 : lw t102, 8(t101)
n53 : lw t100, 4(t101)
n54 : addi t101, t101, 44
n55 : jr $ra
n0: 1 2 4 8 9 20 21 22 23 24 25 26 27 
n1: 0 1 2 4 8 9 20 21 22 23 24 25 26 27 
n2: 0 2 4 8 9 20 21 22 23 24 25 26 27 
n3: 0 4 8 9 20 21 22 23 24 25 26 27 
n4: 0 1 4 8 9 20 21 22 23 24 25 26 27 
n5: 0 1 4 8 9 20 21 22 23 24 25 26 27 
n6: 0 1 4 8 20 21 22 23 24 25 26 27 32 
n7: 0 1 4 20 21 22 23 24 25 26 27 32 
n8: 0 1 4 21 22 23 24 25 26 27 32 
n9: 0 1 4 22 23 24 25 26 27 32 
n10: 0 1 4 23 24 25 26 27 32 
n11: 0 1 4 24 25 26 27 32 
n12: 0 1 4 25 26 27 32 
n13: 0 1 4 26 27 32 
n14: 0 1 4 27 32 
n15: 0 1 4 32 
n16: 0 1 4 32 36 
n17: 0 1 4 32 
n18: 0 1 4 32 
n19: 0 1 4 32 35 
n20: 0 1 4 32 35 37 
n21: 0 1 4 8 32 35 
n22: 0 1 4 8 35 38 
n23: 0 1 4 8 9 35 
n24: 0 1 4 6 35 
n25: 0 1 4 34 35 
n26: 0 1 4 39 
n27: 0 1 4 33 
n28: 0 1 4 33 
n29: 0 1 4 
n30: 0 1 4 40 
n31: 0 1 4 20 
n32: 0 1 4 20 41 
n33: 0 1 4 20 21 
n34: 0 1 4 20 21 42 
n35: 0 1 4 20 21 22 
n36: 0 1 4 20 21 22 43 
n37: 0 1 4 20 21 22 23 
n38: 0 1 4 20 21 22 23 44 
n39: 0 1 4 20 21 22 23 24 
n40: 0 1 4 20 21 22 23 24 45 
n41: 0 1 4 20 21 22 23 24 25 
n42: 0 1 4 20 21 22 23 24 25 46 
n43: 0 1 4 20 21 22 23 24 25 26 
n44: 1 4 20 21 22 23 24 25 26 47 
n45: 1 4 20 21 22 23 24 25 26 27 
n46: 1 4 20 21 22 23 24 25 26 27 
n47: 0 1 4 
n48: 0 1 4 48 
n49: 0 1 4 33 
n50: 0 1 4 33 
n51: 1 4 20 21 22 23 24 25 26 27 
n52: 1 2 4 20 21 22 23 24 25 26 27 
n53: 1 2 4 20 21 22 23 24 25 26 27 
n54: 1 2 4 20 21 22 23 24 25 26 27 
n55: 
n0 -> succ={n1 n2 n4 n6 n8 n9 n20 n21 n22 n23 n24 n25 n26 n27 n32 n33 n34 n35 n36 n37 n38 n39 n40 n41 n42 n43 n44 n45 n46 n48 } 
       pred={n1 n2 n4 n6 n8 n9 n20 n21 n22 n23 n24 n25 n26 n27 n32 n33 n34 n35 n36 n37 n38 n39 n40 n41 n42 n43 n44 n45 n46 n48 }
n1 -> succ={n0 n2 n4 n6 n8 n9 n20 n21 n22 n23 n24 n25 n26 n27 n32 n33 n34 n35 n36 n37 n38 n39 n40 n41 n42 n43 n44 n45 n46 n47 n48 } 
       pred={n0 n2 n4 n6 n8 n9 n20 n21 n22 n23 n24 n25 n26 n27 n32 n33 n34 n35 n36 n37 n38 n39 n40 n41 n42 n43 n44 n45 n46 n47 n48 }
n2 -> succ={n0 n1 n4 n8 n9 n20 n21 n22 n23 n24 n25 n26 n27 } 
       pred={n0 n1 n4 n8 n9 n20 n21 n22 n23 n24 n25 n26 n27 }
n3 -> succ={} 
       pred={}
n4 -> succ={n0 n1 n2 n6 n8 n9 n20 n21 n22 n23 n24 n25 n26 n27 n32 n33 n34 n35 n36 n37 n38 n39 n40 n41 n42 n43 n44 n45 n46 n47 n48 } 
       pred={n0 n1 n2 n6 n8 n9 n20 n21 n22 n23 n24 n25 n26 n27 n32 n33 n34 n35 n36 n37 n38 n39 n40 n41 n42 n43 n44 n45 n46 n47 n48 }
n5 -> succ={} 
       pred={}
n6 -> succ={n0 n1 n4 n35 } 
       pred={n0 n1 n4 n35 }
n7 -> succ={} 
       pred={}
n8 -> succ={n0 n1 n2 n4 n9 n20 n21 n22 n23 n24 n25 n26 n27 n32 n35 n38 } 
       pred={n0 n1 n2 n4 n9 n20 n21 n22 n23 n24 n25 n26 n27 n32 n35 n38 }
n9 -> succ={n0 n1 n2 n4 n8 n20 n21 n22 n23 n24 n25 n26 n27 n35 } 
       pred={n0 n1 n2 n4 n8 n20 n21 n22 n23 n24 n25 n26 n27 n35 }
n10 -> succ={} 
       pred={}
n11 -> succ={} 
       pred={}
n12 -> succ={} 
       pred={}
n13 -> succ={} 
       pred={}
n14 -> succ={} 
       pred={}
n15 -> succ={} 
       pred={}
n16 -> succ={} 
       pred={}
n17 -> succ={} 
       pred={}
n18 -> succ={} 
       pred={}
n19 -> succ={} 
       pred={}
n20 -> succ={n0 n1 n2 n4 n8 n9 n21 n22 n23 n24 n25 n26 n27 n32 n41 n42 n43 n44 n45 n46 n47 } 
       pred={n0 n1 n2 n4 n8 n9 n21 n22 n23 n24 n25 n26 n27 n32 n41 n42 n43 n44 n45 n46 n47 }
n21 -> succ={n0 n1 n2 n4 n8 n9 n20 n22 n23 n24 n25 n26 n27 n32 n42 n43 n44 n45 n46 n47 } 
       pred={n0 n1 n2 n4 n8 n9 n20 n22 n23 n24 n25 n26 n27 n32 n42 n43 n44 n45 n46 n47 }
n22 -> succ={n0 n1 n2 n4 n8 n9 n20 n21 n23 n24 n25 n26 n27 n32 n43 n44 n45 n46 n47 } 
       pred={n0 n1 n2 n4 n8 n9 n20 n21 n23 n24 n25 n26 n27 n32 n43 n44 n45 n46 n47 }
n23 -> succ={n0 n1 n2 n4 n8 n9 n20 n21 n22 n24 n25 n26 n27 n32 n44 n45 n46 n47 } 
       pred={n0 n1 n2 n4 n8 n9 n20 n21 n22 n24 n25 n26 n27 n32 n44 n45 n46 n47 }
n24 -> succ={n0 n1 n2 n4 n8 n9 n20 n21 n22 n23 n25 n26 n27 n32 n45 n46 n47 } 
       pred={n0 n1 n2 n4 n8 n9 n20 n21 n22 n23 n25 n26 n27 n32 n45 n46 n47 }
n25 -> succ={n0 n1 n2 n4 n8 n9 n20 n21 n22 n23 n24 n26 n27 n32 n46 n47 } 
       pred={n0 n1 n2 n4 n8 n9 n20 n21 n22 n23 n24 n26 n27 n32 n46 n47 }
n26 -> succ={n0 n1 n2 n4 n8 n9 n20 n21 n22 n23 n24 n25 n27 n32 n47 } 
       pred={n0 n1 n2 n4 n8 n9 n20 n21 n22 n23 n24 n25 n27 n32 n47 }
n27 -> succ={n0 n1 n2 n4 n8 n9 n20 n21 n22 n23 n24 n25 n26 n32 } 
       pred={n0 n1 n2 n4 n8 n9 n20 n21 n22 n23 n24 n25 n26 n32 }
n28 -> succ={} 
       pred={}
n29 -> succ={} 
       pred={}
n30 -> succ={} 
       pred={}
n31 -> succ={} 
       pred={}
n32 -> succ={n0 n1 n4 n8 n20 n21 n22 n23 n24 n25 n26 n27 n35 n36 n37 } 
       pred={n0 n1 n4 n8 n20 n21 n22 n23 n24 n25 n26 n27 n35 n36 n37 }
n33 -> succ={n0 n1 n4 } 
       pred={n0 n1 n4 }
n34 -> succ={n0 n1 n4 n35 } 
       pred={n0 n1 n4 n35 }
n35 -> succ={n0 n1 n4 n6 n8 n9 n32 n34 n37 n38 } 
       pred={n0 n1 n4 n6 n8 n9 n32 n34 n37 n38 }
n36 -> succ={n0 n1 n4 n32 } 
       pred={n0 n1 n4 n32 }
n37 -> succ={n0 n1 n4 n32 n35 } 
       pred={n0 n1 n4 n32 n35 }
n38 -> succ={n0 n1 n4 n8 n35 } 
       pred={n0 n1 n4 n8 n35 }
n39 -> succ={n0 n1 n4 } 
       pred={n0 n1 n4 }
n40 -> succ={n0 n1 n4 } 
       pred={n0 n1 n4 }
n41 -> succ={n0 n1 n4 n20 } 
       pred={n0 n1 n4 n20 }
n42 -> succ={n0 n1 n4 n20 n21 } 
       pred={n0 n1 n4 n20 n21 }
n43 -> succ={n0 n1 n4 n20 n21 n22 } 
       pred={n0 n1 n4 n20 n21 n22 }
n44 -> succ={n0 n1 n4 n20 n21 n22 n23 } 
       pred={n0 n1 n4 n20 n21 n22 n23 }
n45 -> succ={n0 n1 n4 n20 n21 n22 n23 n24 } 
       pred={n0 n1 n4 n20 n21 n22 n23 n24 }
n46 -> succ={n0 n1 n4 n20 n21 n22 n23 n24 n25 } 
       pred={n0 n1 n4 n20 n21 n22 n23 n24 n25 }
n47 -> succ={n1 n4 n20 n21 n22 n23 n24 n25 n26 } 
       pred={n1 n4 n20 n21 n22 n23 n24 n25 n26 }
n48 -> succ={n0 n1 n4 } 
       pred={n0 n1 n4 }
n0 : L0:
n1 : move t100, t101
n2 : addi t101, t101, -44
n3 : sw t102, 8(t101)
n4 : sw t100, 4(t101)
n5 : L7:
n6 : sw t108, -4(t100)
n7 : sw t120, -8(t100)
n8 : sw t121, -12(t100)
n9 : sw t122, -16(t100)
n10 : sw t123, -20(t100)
n11 : sw t124, -24(t100)
n12 : sw t125, -28(t100)
n13 : sw t126, -32(t100)
n14 : sw t127, -36(t100)
n15 : add t108, t100, $0
n16 : addi t149, $0, 10
n17 : add t109, t149, $0
n18 : jal nfactor
n19 : add t106, t106, $0
n20 : lw t150, -8(t100)
n21 : add t120, t150, $0
n22 : lw t151, -12(t100)
n23 : add t121, t151, $0
n24 : lw t152, -16(t100)
n25 : add t122, t152, $0
n26 : lw t153, -20(t100)
n27 : add t123, t153, $0
n28 : lw t154, -24(t100)
n29 : add t124, t154, $0
n30 : lw t155, -28(t100)
n31 : add t125, t155, $0
n32 : lw t156, -32(t100)
n33 : add t126, t156, $0
n34 : lw t157, -36(t100)
n35 : add t127, t157, $0
n36 : j L6 
n37 : L6:
n38 : lw t102, 8(t101)
n39 : lw t100, 4(t101)
n40 : addi t101, t101, 44
n41 : jr $ra
n0: 1 2 4 8 20 21 22 23 24 25 26 27 
n1: 0 1 2 4 8 20 21 22 23 24 25 26 27 
n2: 0 2 4 8 20 21 22 23 24 25 26 27 
n3: 0 4 8 20 21 22 23 24 25 26 27 
n4: 0 1 4 8 20 21 22 23 24 25 26 27 
n5: 0 1 4 8 20 21 22 23 24 25 26 27 
n6: 0 1 4 20 21 22 23 24 25 26 27 
n7: 0 1 4 21 22 23 24 25 26 27 
n8: 0 1 4 22 23 24 25 26 27 
n9: 0 1 4 23 24 25 26 27 
n10: 0 1 4 24 25 26 27 
n11: 0 1 4 25 26 27 
n12: 0 1 4 26 27 
n13: 0 1 4 27 
n14: 0 1 4 
n15: 0 1 4 8 
n16: 0 1 4 8 49 
n17: 0 1 4 8 9 
n18: 0 1 4 6 
n19: 0 1 4 
n20: 0 1 4 50 
n21: 0 1 4 20 
n22: 0 1 4 20 51 
n23: 0 1 4 20 21 
n24: 0 1 4 20 21 52 
n25: 0 1 4 20 21 22 
n26: 0 1 4 20 21 22 53 
n27: 0 1 4 20 21 22 23 
n28: 0 1 4 20 21 22 23 54 
n29: 0 1 4 20 21 22 23 24 
n30: 0 1 4 20 21 22 23 24 55 
n31: 0 1 4 20 21 22 23 24 25 
n32: 0 1 4 20 21 22 23 24 25 56 
n33: 0 1 4 20 21 22 23 24 25 26 
n34: 1 4 20 21 22 23 24 25 26 57 
n35: 1 4 20 21 22 23 24 25 26 27 
n36: 1 4 20 21 22 23 24 25 26 27 
n37: 1 4 20 21 22 23 24 25 26 27 
n38: 1 2 4 20 21 22 23 24 25 26 27 
n39: 1 2 4 20 21 22 23 24 25 26 27 
n40: 1 2 4 20 21 22 23 24 25 26 27 
n41: 
n0 -> succ={n1 n2 n4 n6 n8 n9 n20 n21 n22 n23 n24 n25 n26 n27 n49 n50 n51 n52 n53 n54 n55 n56 } 
       pred={n1 n2 n4 n6 n8 n9 n20 n21 n22 n23 n24 n25 n26 n27 n49 n50 n51 n52 n53 n54 n55 n56 }
n1 -> succ={n0 n2 n4 n6 n8 n9 n20 n21 n22 n23 n24 n25 n26 n27 n49 n50 n51 n52 n53 n54 n55 n56 n57 } 
       pred={n0 n2 n4 n6 n8 n9 n20 n21 n22 n23 n24 n25 n26 n27 n49 n50 n51 n52 n53 n54 n55 n56 n57 }
n2 -> succ={n0 n1 n4 n8 n20 n21 n22 n23 n24 n25 n26 n27 } 
       pred={n0 n1 n4 n8 n20 n21 n22 n23 n24 n25 n26 n27 }
n3 -> succ={} 
       pred={}
n4 -> succ={n0 n1 n2 n6 n8 n9 n20 n21 n22 n23 n24 n25 n26 n27 n49 n50 n51 n52 n53 n54 n55 n56 n57 } 
       pred={n0 n1 n2 n6 n8 n9 n20 n21 n22 n23 n24 n25 n26 n27 n49 n50 n51 n52 n53 n54 n55 n56 n57 }
n5 -> succ={} 
       pred={}
n6 -> succ={n0 n1 n4 } 
       pred={n0 n1 n4 }
n7 -> succ={} 
       pred={}
n8 -> succ={n0 n1 n2 n4 n9 n20 n21 n22 n23 n24 n25 n26 n27 n49 } 
       pred={n0 n1 n2 n4 n9 n20 n21 n22 n23 n24 n25 n26 n27 n49 }
n9 -> succ={n0 n1 n4 n8 } 
       pred={n0 n1 n4 n8 }
n10 -> succ={} 
       pred={}
n11 -> succ={} 
       pred={}
n12 -> succ={} 
       pred={}
n13 -> succ={} 
       pred={}
n14 -> succ={} 
       pred={}
n15 -> succ={} 
       pred={}
n16 -> succ={} 
       pred={}
n17 -> succ={} 
       pred={}
n18 -> succ={} 
       pred={}
n19 -> succ={} 
       pred={}
n20 -> succ={n0 n1 n2 n4 n8 n21 n22 n23 n24 n25 n26 n27 n51 n52 n53 n54 n55 n56 n57 } 
       pred={n0 n1 n2 n4 n8 n21 n22 n23 n24 n25 n26 n27 n51 n52 n53 n54 n55 n56 n57 }
n21 -> succ={n0 n1 n2 n4 n8 n20 n22 n23 n24 n25 n26 n27 n52 n53 n54 n55 n56 n57 } 
       pred={n0 n1 n2 n4 n8 n20 n22 n23 n24 n25 n26 n27 n52 n53 n54 n55 n56 n57 }
n22 -> succ={n0 n1 n2 n4 n8 n20 n21 n23 n24 n25 n26 n27 n53 n54 n55 n56 n57 } 
       pred={n0 n1 n2 n4 n8 n20 n21 n23 n24 n25 n26 n27 n53 n54 n55 n56 n57 }
n23 -> succ={n0 n1 n2 n4 n8 n20 n21 n22 n24 n25 n26 n27 n54 n55 n56 n57 } 
       pred={n0 n1 n2 n4 n8 n20 n21 n22 n24 n25 n26 n27 n54 n55 n56 n57 }
n24 -> succ={n0 n1 n2 n4 n8 n20 n21 n22 n23 n25 n26 n27 n55 n56 n57 } 
       pred={n0 n1 n2 n4 n8 n20 n21 n22 n23 n25 n26 n27 n55 n56 n57 }
n25 -> succ={n0 n1 n2 n4 n8 n20 n21 n22 n23 n24 n26 n27 n56 n57 } 
       pred={n0 n1 n2 n4 n8 n20 n21 n22 n23 n24 n26 n27 n56 n57 }
n26 -> succ={n0 n1 n2 n4 n8 n20 n21 n22 n23 n24 n25 n27 n57 } 
       pred={n0 n1 n2 n4 n8 n20 n21 n22 n23 n24 n25 n27 n57 }
n27 -> succ={n0 n1 n2 n4 n8 n20 n21 n22 n23 n24 n25 n26 } 
       pred={n0 n1 n2 n4 n8 n20 n21 n22 n23 n24 n25 n26 }
n28 -> succ={} 
       pred={}
n29 -> succ={} 
       pred={}
n30 -> succ={} 
       pred={}
n31 -> succ={} 
       pred={}
n32 -> succ={} 
       pred={}
n33 -> succ={} 
       pred={}
n34 -> succ={} 
       pred={}
n35 -> succ={} 
       pred={}
n36 -> succ={} 
       pred={}
n37 -> succ={} 
       pred={}
n38 -> succ={} 
       pred={}
n39 -> succ={} 
       pred={}
n40 -> succ={} 
       pred={}
n41 -> succ={} 
       pred={}
n42 -> succ={} 
       pred={}
n43 -> succ={} 
       pred={}
n44 -> succ={} 
       pred={}
n45 -> succ={} 
       pred={}
n46 -> succ={} 
       pred={}
n47 -> succ={} 
       pred={}
n48 -> succ={} 
       pred={}
n49 -> succ={n0 n1 n4 n8 } 
       pred={n0 n1 n4 n8 }
n50 -> succ={n0 n1 n4 } 
       pred={n0 n1 n4 }
n51 -> succ={n0 n1 n4 n20 } 
       pred={n0 n1 n4 n20 }
n52 -> succ={n0 n1 n4 n20 n21 } 
       pred={n0 n1 n4 n20 n21 }
n53 -> succ={n0 n1 n4 n20 n21 n22 } 
       pred={n0 n1 n4 n20 n21 n22 }
n54 -> succ={n0 n1 n4 n20 n21 n22 n23 } 
       pred={n0 n1 n4 n20 n21 n22 n23 }
n55 -> succ={n0 n1 n4 n20 n21 n22 n23 n24 } 
       pred={n0 n1 n4 n20 n21 n22 n23 n24 }
n56 -> succ={n0 n1 n4 n20 n21 n22 n23 n24 n25 } 
       pred={n0 n1 n4 n20 n21 n22 n23 n24 n25 }
n57 -> succ={n1 n4 n20 n21 n22 n23 n24 n25 n26 } 
       pred={n1 n4 n20 n21 n22 n23 n24 n25 n26 }
# ----- emit nfactor -----
digraph G {
}
Moves: 
no moves
nfactor:
move t100, t101
addi t101, t101, -44
sw t102, 8(t101)
sw t100, 4(t101)
L5:
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
addi t136, $0, 0
beq t132, t136, L1
L2:
add t135, t132, $0
lw t137, 0(t100)
add t108, t137, $0
addi t138, t132, -1
add t109, t138, $0
jal nfactor
add t134, t106, $0
mul t139, t135, t134
add t133, t139, $0
L3:
add t106, t133, $0
lw t140, -8(t100)
add t120, t140, $0
lw t141, -12(t100)
add t121, t141, $0
lw t142, -16(t100)
add t122, t142, $0
lw t143, -20(t100)
add t123, t143, $0
lw t144, -24(t100)
add t124, t144, $0
lw t145, -28(t100)
add t125, t145, $0
lw t146, -32(t100)
add t126, t146, $0
lw t147, -36(t100)
add t127, t147, $0
j L4 
L1:
addi t148, $0, 1
add t133, t148, $0
j L3 
L4:
lw t102, 8(t101)
lw t100, 4(t101)
addi t101, t101, 44
jr $ra
# ----- emit L0 -----
digraph G {
}
Moves: 
no moves
L0:
move t100, t101
addi t101, t101, -44
sw t102, 8(t101)
sw t100, 4(t101)
L7:
sw t108, -4(t100)
sw t120, -8(t100)
sw t121, -12(t100)
sw t122, -16(t100)
sw t123, -20(t100)
sw t124, -24(t100)
sw t125, -28(t100)
sw t126, -32(t100)
sw t127, -36(t100)
add t108, t100, $0
addi t149, $0, 10
add t109, t149, $0
jal nfactor
add t106, t106, $0
lw t150, -8(t100)
add t120, t150, $0
lw t151, -12(t100)
add t121, t151, $0
lw t152, -16(t100)
add t122, t152, $0
lw t153, -20(t100)
add t123, t153, $0
lw t154, -24(t100)
add t124, t154, $0
lw t155, -28(t100)
add t125, t155, $0
lw t156, -32(t100)
add t126, t156, $0
lw t157, -36(t100)
add t127, t157, $0
j L6 
L6:
lw t102, 8(t101)
lw t100, 4(t101)
addi t101, t101, 44
jr $ra
