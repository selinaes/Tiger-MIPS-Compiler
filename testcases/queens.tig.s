L6 : .ascii  O 
L7 : .ascii  . 
L13 : .ascii 
 
# ----- emit printboard -----
# ----- linearize printboard -----
LABEL L65
MOVE(
 MEM(
  BINOP(MINUS,
   TEMP t100,
   CONST 4)),
 TEMP t108)
MOVE(
 MEM(
  BINOP(PLUS,
   TEMP t100,
   CONST ~8)),
 TEMP t120)
MOVE(
 MEM(
  BINOP(PLUS,
   TEMP t100,
   CONST ~12)),
 TEMP t121)
MOVE(
 MEM(
  BINOP(PLUS,
   TEMP t100,
   CONST ~16)),
 TEMP t122)
MOVE(
 MEM(
  BINOP(PLUS,
   TEMP t100,
   CONST ~20)),
 TEMP t123)
MOVE(
 MEM(
  BINOP(PLUS,
   TEMP t100,
   CONST ~24)),
 TEMP t124)
MOVE(
 MEM(
  BINOP(PLUS,
   TEMP t100,
   CONST ~28)),
 TEMP t125)
MOVE(
 MEM(
  BINOP(PLUS,
   TEMP t100,
   CONST ~32)),
 TEMP t126)
MOVE(
 MEM(
  BINOP(PLUS,
   TEMP t100,
   CONST ~36)),
 TEMP t127)
MOVE(
 TEMP t133,
 CONST 0)
CJUMP(LE,
 TEMP t133,
 BINOP(MINUS,
  MEM(
   BINOP(PLUS,
    MEM(
     TEMP t100),
    CONST ~8)),
  CONST 1),
 L14,L1)
LABEL L1
MOVE(
 TEMP t106,
 CALL(
  NAME L0,
   NAME L13))
MOVE(
 TEMP t120,
 MEM(
  BINOP(PLUS,
   TEMP t100,
   CONST ~8)))
MOVE(
 TEMP t121,
 MEM(
  BINOP(PLUS,
   TEMP t100,
   CONST ~12)))
MOVE(
 TEMP t122,
 MEM(
  BINOP(PLUS,
   TEMP t100,
   CONST ~16)))
MOVE(
 TEMP t123,
 MEM(
  BINOP(PLUS,
   TEMP t100,
   CONST ~20)))
MOVE(
 TEMP t124,
 MEM(
  BINOP(PLUS,
   TEMP t100,
   CONST ~24)))
MOVE(
 TEMP t125,
 MEM(
  BINOP(PLUS,
   TEMP t100,
   CONST ~28)))
MOVE(
 TEMP t126,
 MEM(
  BINOP(PLUS,
   TEMP t100,
   CONST ~32)))
MOVE(
 TEMP t127,
 MEM(
  BINOP(PLUS,
   TEMP t100,
   CONST ~36)))
JUMP(
 NAME L64)
LABEL L15
MOVE(
 TEMP t133,
 BINOP(PLUS,
  TEMP t133,
  CONST 1))
LABEL L14
MOVE(
 TEMP t134,
 CONST 0)
CJUMP(LE,
 TEMP t134,
 BINOP(MINUS,
  MEM(
   BINOP(PLUS,
    MEM(
     TEMP t100),
    CONST ~8)),
  CONST 1),
 L11,L2)
LABEL L2
EXP(
 CALL(
  NAME L0,
   NAME L13))
CJUMP(LT,
 TEMP t133,
 BINOP(MINUS,
  MEM(
   BINOP(PLUS,
    MEM(
     TEMP t100),
    CONST ~8)),
  CONST 1),
 L15,L66)
LABEL L66
JUMP(
 NAME L1)
LABEL L12
MOVE(
 TEMP t134,
 BINOP(PLUS,
  TEMP t134,
  CONST 1))
LABEL L11
MOVE(
 TEMP t135,
 TEMP t133)
MOVE(
 TEMP t136,
 MEM(
  BINOP(PLUS,
   MEM(
    BINOP(PLUS,
     MEM(
      TEMP t100),
     CONST ~16)),
   CONST ~4)))
CJUMP(GE,
 TEMP t135,
 TEMP t136,
 L3,L4)
LABEL L4
CJUMP(LT,
 TEMP t135,
 CONST 0,
 L3,L5)
LABEL L5
CJUMP(EQ,
 MEM(
  BINOP(PLUS,
   MEM(
    BINOP(PLUS,
     MEM(
      TEMP t100),
     CONST ~16)),
   BINOP(MUL,
    TEMP t133,
    CONST 4))),
 TEMP t134,
 L8,L9)
LABEL L9
MOVE(
 TEMP t137,
 NAME L7)
LABEL L10
EXP(
 CALL(
  NAME L0,
   TEMP t137))
CJUMP(LT,
 TEMP t134,
 BINOP(MINUS,
  MEM(
   BINOP(PLUS,
    MEM(
     TEMP t100),
    CONST ~8)),
  CONST 1),
 L12,L67)
LABEL L67
JUMP(
 NAME L2)
LABEL L3
EXP(
 CALL(
  NAME exit,
   CONST 1))
JUMP(
 NAME L5)
LABEL L8
MOVE(
 TEMP t137,
 NAME L6)
JUMP(
 NAME L10)
LABEL L64
# ----- Assembly printboard -----
printboard:
move t100, t101
addi t101, t101, -44
sw t102, 8(t101)
sw t100, 4(t101)
L65:
sw t108, -4(t100)
sw t120, -8(t100)
sw t121, -12(t100)
sw t122, -16(t100)
sw t123, -20(t100)
sw t124, -24(t100)
sw t125, -28(t100)
sw t126, -32(t100)
sw t127, -36(t100)
addi t164, $0, 0
add t133, t164, $0
lw t167, 0(t100)
lw t166, -8(t167)
addi t165, t166, -1
ble t133, t165, L14
L1:
la t168, L13
add t108, t168, $0
jal L0 
add t106, t106, $0
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
j L64 
L15:
addi t177, t133, 1
add t133, t177, $0
L14:
addi t178, $0, 0
add t134, t178, $0
lw t181, 0(t100)
lw t180, -8(t181)
addi t179, t180, -1
ble t134, t179, L11
L2:
la t182, L13
add t108, t182, $0
jal L0 
lw t185, 0(t100)
lw t184, -8(t185)
addi t183, t184, -1
blt t133, t183, L15
L66:
j L1 
L12:
addi t186, t134, 1
add t134, t186, $0
L11:
add t135, t133, $0
lw t189, 0(t100)
lw t188, -16(t189)
lw t187, -4(t188)
add t136, t187, $0
bge t135, t136, L3
L4:
addi t190, $0, 0
blt t135, t190, L3
L5:
lw t194, 0(t100)
lw t193, -16(t194)
addi t196, $0, 4
mul t195, t133, t196
add t192, t193, t195
lw t191, 0(t192)
beq t191, t134, L8
L9:
la t197, L7
add t137, t197, $0
L10:
add t108, t137, $0
jal L0 
lw t200, 0(t100)
lw t199, -8(t200)
addi t198, t199, -1
blt t134, t198, L12
L67:
j L2 
L3:
addi t201, $0, 1
add t108, t201, $0
jal exit 
j L5 
L8:
la t202, L6
add t137, t202, $0
j L10 
L64:
lw t102, 8(t101)
lw t100, 4(t101)
addi t101, t101, 44
jr t102
# ----- emit try -----
# ----- linearize try -----
LABEL L69
MOVE(
 TEMP t132,
 TEMP t109)
MOVE(
 MEM(
  BINOP(MINUS,
   TEMP t100,
   CONST 4)),
 TEMP t108)
MOVE(
 MEM(
  BINOP(PLUS,
   TEMP t100,
   CONST ~8)),
 TEMP t120)
MOVE(
 MEM(
  BINOP(PLUS,
   TEMP t100,
   CONST ~12)),
 TEMP t121)
MOVE(
 MEM(
  BINOP(PLUS,
   TEMP t100,
   CONST ~16)),
 TEMP t122)
MOVE(
 MEM(
  BINOP(PLUS,
   TEMP t100,
   CONST ~20)),
 TEMP t123)
MOVE(
 MEM(
  BINOP(PLUS,
   TEMP t100,
   CONST ~24)),
 TEMP t124)
MOVE(
 MEM(
  BINOP(PLUS,
   TEMP t100,
   CONST ~28)),
 TEMP t125)
MOVE(
 MEM(
  BINOP(PLUS,
   TEMP t100,
   CONST ~32)),
 TEMP t126)
MOVE(
 MEM(
  BINOP(PLUS,
   TEMP t100,
   CONST ~36)),
 TEMP t127)
CJUMP(EQ,
 TEMP t132,
 MEM(
  BINOP(PLUS,
   MEM(
    TEMP t100),
   CONST ~8)),
 L61,L62)
LABEL L62
MOVE(
 TEMP t138,
 CONST 0)
CJUMP(LE,
 TEMP t138,
 BINOP(MINUS,
  MEM(
   BINOP(PLUS,
    MEM(
     TEMP t100),
    CONST ~8)),
  CONST 1),
 L59,L16)
LABEL L16
MOVE(
 TEMP t163,
 CONST 0)
LABEL L63
MOVE(
 TEMP t106,
 TEMP t163)
MOVE(
 TEMP t120,
 MEM(
  BINOP(PLUS,
   TEMP t100,
   CONST ~8)))
MOVE(
 TEMP t121,
 MEM(
  BINOP(PLUS,
   TEMP t100,
   CONST ~12)))
MOVE(
 TEMP t122,
 MEM(
  BINOP(PLUS,
   TEMP t100,
   CONST ~16)))
MOVE(
 TEMP t123,
 MEM(
  BINOP(PLUS,
   TEMP t100,
   CONST ~20)))
MOVE(
 TEMP t124,
 MEM(
  BINOP(PLUS,
   TEMP t100,
   CONST ~24)))
MOVE(
 TEMP t125,
 MEM(
  BINOP(PLUS,
   TEMP t100,
   CONST ~28)))
MOVE(
 TEMP t126,
 MEM(
  BINOP(PLUS,
   TEMP t100,
   CONST ~32)))
MOVE(
 TEMP t127,
 MEM(
  BINOP(PLUS,
   TEMP t100,
   CONST ~36)))
JUMP(
 NAME L68)
LABEL L61
MOVE(
 TEMP t163,
 CALL(
  NAME printboard,
   MEM(
    TEMP t100)))
JUMP(
 NAME L63)
LABEL L60
MOVE(
 TEMP t138,
 BINOP(PLUS,
  TEMP t138,
  CONST 1))
LABEL L59
MOVE(
 TEMP t139,
 TEMP t138)
MOVE(
 TEMP t140,
 MEM(
  BINOP(PLUS,
   MEM(
    BINOP(PLUS,
     MEM(
      TEMP t100),
     CONST ~12)),
   CONST ~4)))
CJUMP(GE,
 TEMP t139,
 TEMP t140,
 L17,L18)
LABEL L18
CJUMP(LT,
 TEMP t139,
 CONST 0,
 L17,L19)
LABEL L19
CJUMP(EQ,
 MEM(
  BINOP(PLUS,
   MEM(
    BINOP(PLUS,
     MEM(
      TEMP t100),
     CONST ~12)),
   BINOP(MUL,
    TEMP t138,
    CONST 4))),
 CONST 0,
 L25,L26)
LABEL L26
MOVE(
 TEMP t144,
 CONST 0)
LABEL L27
CJUMP(NE,
 TEMP t144,
 CONST 0,
 L33,L34)
LABEL L34
MOVE(
 TEMP t148,
 CONST 0)
LABEL L35
CJUMP(NE,
 TEMP t148,
 CONST 0,
 L57,L58)
LABEL L58
CJUMP(LT,
 TEMP t138,
 BINOP(MINUS,
  MEM(
   BINOP(PLUS,
    MEM(
     TEMP t100),
    CONST ~8)),
  CONST 1),
 L60,L70)
LABEL L70
JUMP(
 NAME L16)
LABEL L17
EXP(
 CALL(
  NAME exit,
   CONST 1))
JUMP(
 NAME L19)
LABEL L25
MOVE(
 TEMP t143,
 CONST 1)
MOVE(
 TEMP t141,
 BINOP(PLUS,
  TEMP t138,
  TEMP t132))
MOVE(
 TEMP t142,
 MEM(
  BINOP(PLUS,
   MEM(
    BINOP(PLUS,
     MEM(
      TEMP t100),
     CONST ~20)),
   CONST ~4)))
CJUMP(GE,
 TEMP t141,
 TEMP t142,
 L20,L21)
LABEL L21
CJUMP(LT,
 TEMP t141,
 CONST 0,
 L20,L22)
LABEL L22
CJUMP(EQ,
 MEM(
  BINOP(PLUS,
   MEM(
    BINOP(PLUS,
     MEM(
      TEMP t100),
     CONST ~20)),
   BINOP(MUL,
    BINOP(PLUS,
     TEMP t138,
     TEMP t132),
    CONST 4))),
 CONST 0,
 L23,L24)
LABEL L24
MOVE(
 TEMP t143,
 CONST 0)
LABEL L23
MOVE(
 TEMP t144,
 TEMP t143)
JUMP(
 NAME L27)
LABEL L20
EXP(
 CALL(
  NAME exit,
   CONST 1))
JUMP(
 NAME L22)
LABEL L33
MOVE(
 TEMP t147,
 CONST 1)
MOVE(
 TEMP t145,
 BINOP(MINUS,
  BINOP(PLUS,
   TEMP t138,
   CONST 7),
  TEMP t132))
MOVE(
 TEMP t146,
 MEM(
  BINOP(PLUS,
   MEM(
    BINOP(PLUS,
     MEM(
      TEMP t100),
     CONST ~24)),
   CONST ~4)))
CJUMP(GE,
 TEMP t145,
 TEMP t146,
 L28,L29)
LABEL L29
CJUMP(LT,
 TEMP t145,
 CONST 0,
 L28,L30)
LABEL L30
CJUMP(EQ,
 MEM(
  BINOP(PLUS,
   MEM(
    BINOP(PLUS,
     MEM(
      TEMP t100),
     CONST ~24)),
   BINOP(MUL,
    BINOP(MINUS,
     BINOP(PLUS,
      TEMP t138,
      CONST 7),
     TEMP t132),
    CONST 4))),
 CONST 0,
 L31,L32)
LABEL L32
MOVE(
 TEMP t147,
 CONST 0)
LABEL L31
MOVE(
 TEMP t148,
 TEMP t147)
JUMP(
 NAME L35)
LABEL L28
EXP(
 CALL(
  NAME exit,
   CONST 1))
JUMP(
 NAME L30)
LABEL L57
MOVE(
 TEMP t149,
 TEMP t138)
MOVE(
 TEMP t150,
 MEM(
  BINOP(PLUS,
   MEM(
    BINOP(PLUS,
     MEM(
      TEMP t100),
     CONST ~12)),
   CONST ~4)))
CJUMP(GE,
 TEMP t149,
 TEMP t150,
 L36,L37)
LABEL L37
CJUMP(LT,
 TEMP t149,
 CONST 0,
 L36,L38)
LABEL L38
MOVE(
 MEM(
  BINOP(PLUS,
   MEM(
    BINOP(PLUS,
     MEM(
      TEMP t100),
     CONST ~12)),
   BINOP(MUL,
    TEMP t138,
    CONST 4))),
 CONST 1)
MOVE(
 TEMP t151,
 BINOP(PLUS,
  TEMP t138,
  TEMP t132))
MOVE(
 TEMP t152,
 MEM(
  BINOP(PLUS,
   MEM(
    BINOP(PLUS,
     MEM(
      TEMP t100),
     CONST ~20)),
   CONST ~4)))
CJUMP(GE,
 TEMP t151,
 TEMP t152,
 L39,L40)
LABEL L40
CJUMP(LT,
 TEMP t151,
 CONST 0,
 L39,L41)
LABEL L41
MOVE(
 MEM(
  BINOP(PLUS,
   MEM(
    BINOP(PLUS,
     MEM(
      TEMP t100),
     CONST ~20)),
   BINOP(MUL,
    BINOP(PLUS,
     TEMP t138,
     TEMP t132),
    CONST 4))),
 CONST 1)
MOVE(
 TEMP t153,
 BINOP(MINUS,
  BINOP(PLUS,
   TEMP t138,
   CONST 7),
  TEMP t132))
MOVE(
 TEMP t154,
 MEM(
  BINOP(PLUS,
   MEM(
    BINOP(PLUS,
     MEM(
      TEMP t100),
     CONST ~24)),
   CONST ~4)))
CJUMP(GE,
 TEMP t153,
 TEMP t154,
 L42,L43)
LABEL L43
CJUMP(LT,
 TEMP t153,
 CONST 0,
 L42,L44)
LABEL L44
MOVE(
 MEM(
  BINOP(PLUS,
   MEM(
    BINOP(PLUS,
     MEM(
      TEMP t100),
     CONST ~24)),
   BINOP(MUL,
    BINOP(MINUS,
     BINOP(PLUS,
      TEMP t138,
      CONST 7),
     TEMP t132),
    CONST 4))),
 CONST 1)
MOVE(
 TEMP t155,
 TEMP t132)
MOVE(
 TEMP t156,
 MEM(
  BINOP(PLUS,
   MEM(
    BINOP(PLUS,
     MEM(
      TEMP t100),
     CONST ~16)),
   CONST ~4)))
CJUMP(GE,
 TEMP t155,
 TEMP t156,
 L45,L46)
LABEL L46
CJUMP(LT,
 TEMP t155,
 CONST 0,
 L45,L47)
LABEL L47
MOVE(
 MEM(
  BINOP(PLUS,
   MEM(
    BINOP(PLUS,
     MEM(
      TEMP t100),
     CONST ~16)),
   BINOP(MUL,
    TEMP t132,
    CONST 4))),
 TEMP t138)
EXP(
 CALL(
  NAME try,
   MEM(
    TEMP t100),
   BINOP(PLUS,
    TEMP t132,
    CONST 1)))
MOVE(
 TEMP t157,
 TEMP t138)
MOVE(
 TEMP t158,
 MEM(
  BINOP(PLUS,
   MEM(
    BINOP(PLUS,
     MEM(
      TEMP t100),
     CONST ~12)),
   CONST ~4)))
CJUMP(GE,
 TEMP t157,
 TEMP t158,
 L48,L49)
LABEL L49
CJUMP(LT,
 TEMP t157,
 CONST 0,
 L48,L50)
LABEL L50
MOVE(
 MEM(
  BINOP(PLUS,
   MEM(
    BINOP(PLUS,
     MEM(
      TEMP t100),
     CONST ~12)),
   BINOP(MUL,
    TEMP t138,
    CONST 4))),
 CONST 0)
MOVE(
 TEMP t159,
 BINOP(PLUS,
  TEMP t138,
  TEMP t132))
MOVE(
 TEMP t160,
 MEM(
  BINOP(PLUS,
   MEM(
    BINOP(PLUS,
     MEM(
      TEMP t100),
     CONST ~20)),
   CONST ~4)))
CJUMP(GE,
 TEMP t159,
 TEMP t160,
 L51,L52)
LABEL L52
CJUMP(LT,
 TEMP t159,
 CONST 0,
 L51,L53)
LABEL L53
MOVE(
 MEM(
  BINOP(PLUS,
   MEM(
    BINOP(PLUS,
     MEM(
      TEMP t100),
     CONST ~20)),
   BINOP(MUL,
    BINOP(PLUS,
     TEMP t138,
     TEMP t132),
    CONST 4))),
 CONST 0)
MOVE(
 TEMP t161,
 BINOP(MINUS,
  BINOP(PLUS,
   TEMP t138,
   CONST 7),
  TEMP t132))
MOVE(
 TEMP t162,
 MEM(
  BINOP(PLUS,
   MEM(
    BINOP(PLUS,
     MEM(
      TEMP t100),
     CONST ~24)),
   CONST ~4)))
CJUMP(GE,
 TEMP t161,
 TEMP t162,
 L54,L55)
LABEL L55
CJUMP(LT,
 TEMP t161,
 CONST 0,
 L54,L56)
LABEL L56
MOVE(
 MEM(
  BINOP(PLUS,
   MEM(
    BINOP(PLUS,
     MEM(
      TEMP t100),
     CONST ~24)),
   BINOP(MUL,
    BINOP(MINUS,
     BINOP(PLUS,
      TEMP t138,
      CONST 7),
     TEMP t132),
    CONST 4))),
 CONST 0)
JUMP(
 NAME L58)
LABEL L36
EXP(
 CALL(
  NAME exit,
   CONST 1))
JUMP(
 NAME L38)
LABEL L39
EXP(
 CALL(
  NAME exit,
   CONST 1))
JUMP(
 NAME L41)
LABEL L42
EXP(
 CALL(
  NAME exit,
   CONST 1))
JUMP(
 NAME L44)
LABEL L45
EXP(
 CALL(
  NAME exit,
   CONST 1))
JUMP(
 NAME L47)
LABEL L48
EXP(
 CALL(
  NAME exit,
   CONST 1))
JUMP(
 NAME L50)
LABEL L51
EXP(
 CALL(
  NAME exit,
   CONST 1))
JUMP(
 NAME L53)
LABEL L54
EXP(
 CALL(
  NAME exit,
   CONST 1))
JUMP(
 NAME L56)
LABEL L68
# ----- Assembly try -----
try:
move t100, t101
addi t101, t101, -44
sw t102, 8(t101)
sw t100, 4(t101)
L69:
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
lw t204, 0(t100)
lw t203, -8(t204)
beq t132, t203, L61
L62:
addi t205, $0, 0
add t138, t205, $0
lw t208, 0(t100)
lw t207, -8(t208)
addi t206, t207, -1
ble t138, t206, L59
L16:
addi t209, $0, 0
add t163, t209, $0
L63:
add t106, t163, $0
lw t210, -8(t100)
add t120, t210, $0
lw t211, -12(t100)
add t121, t211, $0
lw t212, -16(t100)
add t122, t212, $0
lw t213, -20(t100)
add t123, t213, $0
lw t214, -24(t100)
add t124, t214, $0
lw t215, -28(t100)
add t125, t215, $0
lw t216, -32(t100)
add t126, t216, $0
lw t217, -36(t100)
add t127, t217, $0
j L68 
L61:
lw t218, 0(t100)
add t108, t218, $0
jal printboard 
add t163, t106, $0
j L63 
L60:
addi t219, t138, 1
add t138, t219, $0
L59:
add t139, t138, $0
lw t222, 0(t100)
lw t221, -12(t222)
lw t220, -4(t221)
add t140, t220, $0
bge t139, t140, L17
L18:
addi t223, $0, 0
blt t139, t223, L17
L19:
lw t227, 0(t100)
lw t226, -12(t227)
addi t229, $0, 4
mul t228, t138, t229
add t225, t226, t228
lw t224, 0(t225)
addi t230, $0, 0
beq t224, t230, L25
L26:
addi t231, $0, 0
add t144, t231, $0
L27:
addi t232, $0, 0
bne t144, t232, L33
L34:
addi t233, $0, 0
add t148, t233, $0
L35:
addi t234, $0, 0
bne t148, t234, L57
L58:
lw t237, 0(t100)
lw t236, -8(t237)
addi t235, t236, -1
blt t138, t235, L60
L70:
j L16 
L17:
addi t238, $0, 1
add t108, t238, $0
jal exit 
j L19 
L25:
addi t239, $0, 1
add t143, t239, $0
add t240, t138, t132
add t141, t240, $0
lw t243, 0(t100)
lw t242, -20(t243)
lw t241, -4(t242)
add t142, t241, $0
bge t141, t142, L20
L21:
addi t244, $0, 0
blt t141, t244, L20
L22:
lw t248, 0(t100)
lw t247, -20(t248)
add t250, t138, t132
addi t251, $0, 4
mul t249, t250, t251
add t246, t247, t249
lw t245, 0(t246)
addi t252, $0, 0
beq t245, t252, L23
L24:
addi t253, $0, 0
add t143, t253, $0
L23:
add t144, t143, $0
j L27 
L20:
addi t254, $0, 1
add t108, t254, $0
jal exit 
j L22 
L33:
addi t255, $0, 1
add t147, t255, $0
addi t257, t138, 7
sub t256, t257, t132
add t145, t256, $0
lw t260, 0(t100)
lw t259, -24(t260)
lw t258, -4(t259)
add t146, t258, $0
bge t145, t146, L28
L29:
addi t261, $0, 0
blt t145, t261, L28
L30:
lw t265, 0(t100)
lw t264, -24(t265)
addi t268, t138, 7
sub t267, t268, t132
addi t269, $0, 4
mul t266, t267, t269
add t263, t264, t266
lw t262, 0(t263)
addi t270, $0, 0
beq t262, t270, L31
L32:
addi t271, $0, 0
add t147, t271, $0
L31:
add t148, t147, $0
j L35 
L28:
addi t272, $0, 1
add t108, t272, $0
jal exit 
j L30 
L57:
add t149, t138, $0
lw t275, 0(t100)
lw t274, -12(t275)
lw t273, -4(t274)
add t150, t273, $0
bge t149, t150, L36
L37:
addi t276, $0, 0
blt t149, t276, L36
L38:
lw t279, 0(t100)
lw t278, -12(t279)
addi t281, $0, 4
mul t280, t138, t281
add t277, t278, t280
addi t282, $0, 1
sw t282, 0(t277)
add t283, t138, t132
add t151, t283, $0
lw t286, 0(t100)
lw t285, -20(t286)
lw t284, -4(t285)
add t152, t284, $0
bge t151, t152, L39
L40:
addi t287, $0, 0
blt t151, t287, L39
L41:
lw t290, 0(t100)
lw t289, -20(t290)
add t292, t138, t132
addi t293, $0, 4
mul t291, t292, t293
add t288, t289, t291
addi t294, $0, 1
sw t294, 0(t288)
addi t296, t138, 7
sub t295, t296, t132
add t153, t295, $0
lw t299, 0(t100)
lw t298, -24(t299)
lw t297, -4(t298)
add t154, t297, $0
bge t153, t154, L42
L43:
addi t300, $0, 0
blt t153, t300, L42
L44:
lw t303, 0(t100)
lw t302, -24(t303)
addi t306, t138, 7
sub t305, t306, t132
addi t307, $0, 4
mul t304, t305, t307
add t301, t302, t304
addi t308, $0, 1
sw t308, 0(t301)
add t155, t132, $0
lw t311, 0(t100)
lw t310, -16(t311)
lw t309, -4(t310)
add t156, t309, $0
bge t155, t156, L45
L46:
addi t312, $0, 0
blt t155, t312, L45
L47:
lw t315, 0(t100)
lw t314, -16(t315)
addi t317, $0, 4
mul t316, t132, t317
add t313, t314, t316
sw t138, 0(t313)
lw t318, 0(t100)
add t108, t318, $0
addi t319, t132, 1
add t109, t319, $0
jal try 
add t157, t138, $0
lw t322, 0(t100)
lw t321, -12(t322)
lw t320, -4(t321)
add t158, t320, $0
bge t157, t158, L48
L49:
addi t323, $0, 0
blt t157, t323, L48
L50:
lw t326, 0(t100)
lw t325, -12(t326)
addi t328, $0, 4
mul t327, t138, t328
add t324, t325, t327
addi t329, $0, 0
sw t329, 0(t324)
add t330, t138, t132
add t159, t330, $0
lw t333, 0(t100)
lw t332, -20(t333)
lw t331, -4(t332)
add t160, t331, $0
bge t159, t160, L51
L52:
addi t334, $0, 0
blt t159, t334, L51
L53:
lw t337, 0(t100)
lw t336, -20(t337)
add t339, t138, t132
addi t340, $0, 4
mul t338, t339, t340
add t335, t336, t338
addi t341, $0, 0
sw t341, 0(t335)
addi t343, t138, 7
sub t342, t343, t132
add t161, t342, $0
lw t346, 0(t100)
lw t345, -24(t346)
lw t344, -4(t345)
add t162, t344, $0
bge t161, t162, L54
L55:
addi t347, $0, 0
blt t161, t347, L54
L56:
lw t350, 0(t100)
lw t349, -24(t350)
addi t353, t138, 7
sub t352, t353, t132
addi t354, $0, 4
mul t351, t352, t354
add t348, t349, t351
addi t355, $0, 0
sw t355, 0(t348)
j L58 
L36:
addi t356, $0, 1
add t108, t356, $0
jal exit 
j L38 
L39:
addi t357, $0, 1
add t108, t357, $0
jal exit 
j L41 
L42:
addi t358, $0, 1
add t108, t358, $0
jal exit 
j L44 
L45:
addi t359, $0, 1
add t108, t359, $0
jal exit 
j L47 
L48:
addi t360, $0, 1
add t108, t360, $0
jal exit 
j L50 
L51:
addi t361, $0, 1
add t108, t361, $0
jal exit 
j L53 
L54:
addi t362, $0, 1
add t108, t362, $0
jal exit 
j L56 
L68:
lw t102, 8(t101)
lw t100, 4(t101)
addi t101, t101, 44
jr t102
# ----- emit L0 -----
# ----- linearize L0 -----
LABEL L72
MOVE(
 MEM(
  BINOP(MINUS,
   TEMP t100,
   CONST 4)),
 TEMP t108)
MOVE(
 MEM(
  BINOP(PLUS,
   TEMP t100,
   CONST ~28)),
 TEMP t120)
MOVE(
 MEM(
  BINOP(PLUS,
   TEMP t100,
   CONST ~32)),
 TEMP t121)
MOVE(
 MEM(
  BINOP(PLUS,
   TEMP t100,
   CONST ~36)),
 TEMP t122)
MOVE(
 MEM(
  BINOP(PLUS,
   TEMP t100,
   CONST ~40)),
 TEMP t123)
MOVE(
 MEM(
  BINOP(PLUS,
   TEMP t100,
   CONST ~44)),
 TEMP t124)
MOVE(
 MEM(
  BINOP(PLUS,
   TEMP t100,
   CONST ~48)),
 TEMP t125)
MOVE(
 MEM(
  BINOP(PLUS,
   TEMP t100,
   CONST ~52)),
 TEMP t126)
MOVE(
 MEM(
  BINOP(PLUS,
   TEMP t100,
   CONST ~56)),
 TEMP t127)
MOVE(
 MEM(
  BINOP(PLUS,
   TEMP t100,
   CONST ~8)),
 CONST 8)
MOVE(
 TEMP t364,
 BINOP(PLUS,
  TEMP t100,
  CONST ~12))
MOVE(
 TEMP t363,
 CALL(
  NAME initArray,
   MEM(
    BINOP(PLUS,
     TEMP t100,
     CONST ~8)),
   CONST 0))
MOVE(
 MEM(
  TEMP t364),
 TEMP t363)
MOVE(
 TEMP t366,
 BINOP(PLUS,
  TEMP t100,
  CONST ~16))
MOVE(
 TEMP t365,
 CALL(
  NAME initArray,
   MEM(
    BINOP(PLUS,
     TEMP t100,
     CONST ~8)),
   CONST 0))
MOVE(
 MEM(
  TEMP t366),
 TEMP t365)
MOVE(
 TEMP t368,
 BINOP(PLUS,
  TEMP t100,
  CONST ~20))
MOVE(
 TEMP t367,
 CALL(
  NAME initArray,
   BINOP(MINUS,
    BINOP(PLUS,
     MEM(
      BINOP(PLUS,
       TEMP t100,
       CONST ~8)),
     MEM(
      BINOP(PLUS,
       TEMP t100,
       CONST ~8))),
    CONST 1),
   CONST 0))
MOVE(
 MEM(
  TEMP t368),
 TEMP t367)
MOVE(
 TEMP t370,
 BINOP(PLUS,
  TEMP t100,
  CONST ~24))
MOVE(
 TEMP t369,
 CALL(
  NAME initArray,
   BINOP(MINUS,
    BINOP(PLUS,
     MEM(
      BINOP(PLUS,
       TEMP t100,
       CONST ~8)),
     MEM(
      BINOP(PLUS,
       TEMP t100,
       CONST ~8))),
    CONST 1),
   CONST 0))
MOVE(
 MEM(
  TEMP t370),
 TEMP t369)
MOVE(
 TEMP t106,
 CALL(
  NAME try,
   TEMP t100,
   CONST 0))
MOVE(
 TEMP t120,
 MEM(
  BINOP(PLUS,
   TEMP t100,
   CONST ~28)))
MOVE(
 TEMP t121,
 MEM(
  BINOP(PLUS,
   TEMP t100,
   CONST ~32)))
MOVE(
 TEMP t122,
 MEM(
  BINOP(PLUS,
   TEMP t100,
   CONST ~36)))
MOVE(
 TEMP t123,
 MEM(
  BINOP(PLUS,
   TEMP t100,
   CONST ~40)))
MOVE(
 TEMP t124,
 MEM(
  BINOP(PLUS,
   TEMP t100,
   CONST ~44)))
MOVE(
 TEMP t125,
 MEM(
  BINOP(PLUS,
   TEMP t100,
   CONST ~48)))
MOVE(
 TEMP t126,
 MEM(
  BINOP(PLUS,
   TEMP t100,
   CONST ~52)))
MOVE(
 TEMP t127,
 MEM(
  BINOP(PLUS,
   TEMP t100,
   CONST ~56)))
JUMP(
 NAME L71)
LABEL L71
# ----- Assembly L0 -----
L0:
move t100, t101
addi t101, t101, -64
sw t102, 8(t101)
sw t100, 4(t101)
L72:
sw t108, -4(t100)
sw t120, -28(t100)
sw t121, -32(t100)
sw t122, -36(t100)
sw t123, -40(t100)
sw t124, -44(t100)
sw t125, -48(t100)
sw t126, -52(t100)
sw t127, -56(t100)
addi t371, $0, 8
sw t371, -8(t100)
addi t372, t100, -12
add t364, t372, $0
lw t373, -8(t100)
add t108, t373, $0
addi t374, $0, 0
add t109, t374, $0
jal initArray 
add t363, t106, $0
sw t363, 0(t364)
addi t375, t100, -16
add t366, t375, $0
lw t376, -8(t100)
add t108, t376, $0
addi t377, $0, 0
add t109, t377, $0
jal initArray 
add t365, t106, $0
sw t365, 0(t366)
addi t378, t100, -20
add t368, t378, $0
lw t381, -8(t100)
lw t382, -8(t100)
add t380, t381, t382
addi t379, t380, -1
add t108, t379, $0
addi t383, $0, 0
add t109, t383, $0
jal initArray 
add t367, t106, $0
sw t367, 0(t368)
addi t384, t100, -24
add t370, t384, $0
lw t387, -8(t100)
lw t388, -8(t100)
add t386, t387, t388
addi t385, t386, -1
add t108, t385, $0
addi t389, $0, 0
add t109, t389, $0
jal initArray 
add t369, t106, $0
sw t369, 0(t370)
add t108, t100, $0
addi t390, $0, 0
add t109, t390, $0
jal try 
add t106, t106, $0
lw t391, -28(t100)
add t120, t391, $0
lw t392, -32(t100)
add t121, t392, $0
lw t393, -36(t100)
add t122, t393, $0
lw t394, -40(t100)
add t123, t394, $0
lw t395, -44(t100)
add t124, t395, $0
lw t396, -48(t100)
add t125, t396, $0
lw t397, -52(t100)
add t126, t397, $0
lw t398, -56(t100)
add t127, t398, $0
j L71 
L71:
lw t102, 8(t101)
lw t100, 4(t101)
addi t101, t101, 64
jr t102
