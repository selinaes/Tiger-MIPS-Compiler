L4 : .ascii 0 
L5 : .ascii 9 
# ----- emit L2 -----
# ----- translated L2 -----
SEQ(
 LABEL L2,
 MOVE(
  TEMP t106,
  ESEQ(
   SEQ(
    CJUMP(GE,
     CALL(
      NAME L3,
       MEM(
        BINOP(PLUS,
         MEM(
          MEM(
           TEMP t100)),
         CONST 0))),
     CALL(
      NAME L3,
       NAME L4),
     L8,L9),
    SEQ(
     LABEL L8,
     SEQ(
      MOVE(
       TEMP t108,
       ESEQ(
        SEQ(
         MOVE(
          TEMP t107,
          CONST 1),
         SEQ(
          CJUMP(LE,
           CALL(
            NAME L3,
             MEM(
              BINOP(PLUS,
               MEM(
                MEM(
                 TEMP t100)),
               CONST 0))),
           CALL(
            NAME L3,
             NAME L5),
           L6,L7),
          SEQ(
           LABEL L7,
           SEQ(
            MOVE(
             TEMP t107,
             CONST 0),
            LABEL L6)))),
        TEMP t107)),
      SEQ(
       JUMP(
        NAME L10),
       SEQ(
        LABEL L9,
        SEQ(
         MOVE(
          TEMP t108,
          CONST 0),
         LABEL L10)))))),
   TEMP t108)))
# ----- linearize L2 -----
LABEL L2
MOVE(
 TEMP t135,
 CALL(
  NAME L3,
   MEM(
    BINOP(PLUS,
     MEM(
      MEM(
       TEMP t100)),
     CONST 0))))
MOVE(
 TEMP t137,
 TEMP t135)
MOVE(
 TEMP t136,
 CALL(
  NAME L3,
   NAME L4))
CJUMP(GE,
 TEMP t137,
 TEMP t136,
 L8,L9)
LABEL L9
MOVE(
 TEMP t108,
 CONST 0)
LABEL L10
MOVE(
 TEMP t106,
 TEMP t108)
JUMP(
 NAME L51)
LABEL L8
MOVE(
 TEMP t107,
 CONST 1)
MOVE(
 TEMP t138,
 CALL(
  NAME L3,
   MEM(
    BINOP(PLUS,
     MEM(
      MEM(
       TEMP t100)),
     CONST 0))))
MOVE(
 TEMP t140,
 TEMP t138)
MOVE(
 TEMP t139,
 CALL(
  NAME L3,
   NAME L5))
CJUMP(LE,
 TEMP t140,
 TEMP t139,
 L6,L7)
LABEL L7
MOVE(
 TEMP t107,
 CONST 0)
LABEL L6
MOVE(
 TEMP t108,
 TEMP t107)
JUMP(
 NAME L10)
LABEL L51
# ----- Assembly L2 -----
L2:
lw t143, 0(t100)
lw t142, 0(t143)
lw t141, 0(t142)
add t108, t141, $0
jal L3 
add t135, t106, $0
add t137, t135, $0
la t144, L4
add t108, t144, $0
jal L3 
add t136, t106, $0
bge t137, t136, L8
L9:
addi t145, $0, 0
add t108, t145, $0
L10:
add t106, t108, $0
j L51 
L8:
addi t146, $0, 1
add t107, t146, $0
lw t149, 0(t100)
lw t148, 0(t149)
lw t147, 0(t148)
add t108, t147, $0
jal L3 
add t138, t106, $0
add t140, t138, $0
la t150, L5
add t108, t150, $0
jal L3 
add t139, t106, $0
ble t140, t139, L6
L7:
addi t151, $0, 0
add t107, t151, $0
L6:
add t108, t107, $0
j L10 
L51:
L12 : .ascii   
L13 : .ascii 
 
# ----- emit L3 -----
# ----- translated L3 -----
SEQ(
 LABEL L3,
 MOVE(
  TEMP t106,
  ESEQ(
   SEQ(
    JUMP(
     NAME L18),
    SEQ(
     LABEL L17,
     SEQ(
      MOVE(
       MEM(
        BINOP(PLUS,
         MEM(
          MEM(
           TEMP t100)),
         CONST 0)),
       CALL(
        NAME L2)),
      SEQ(
       LABEL L18,
       SEQ(
        CJUMP(NE,
         ESEQ(
          SEQ(
           CJUMP(NE,
            CALL(
             NAME stringEqual,
              MEM(
               BINOP(PLUS,
                MEM(
                 MEM(
                  TEMP t100)),
                CONST 0)),
              NAME L12),
            CONST 0,
            L14,L15),
           SEQ(
            LABEL L14,
            SEQ(
             MOVE(
              TEMP t109,
              CONST 1),
             SEQ(
              JUMP(
               NAME L16),
              SEQ(
               LABEL L15,
               SEQ(
                MOVE(
                 TEMP t109,
                 CALL(
                  NAME stringEqual,
                   MEM(
                    BINOP(PLUS,
                     MEM(
                      MEM(
                       TEMP t100)),
                     CONST 0)),
                   NAME L13)),
                LABEL L16)))))),
          TEMP t109),
         CONST 0,
         L17,L11),
        LABEL L11))))),
   CONST 0)))
# ----- linearize L3 -----
LABEL L3
LABEL L18
MOVE(
 TEMP t154,
 CALL(
  NAME stringEqual,
   MEM(
    BINOP(PLUS,
     MEM(
      MEM(
       TEMP t100)),
     CONST 0)),
   NAME L12))
CJUMP(NE,
 TEMP t154,
 CONST 0,
 L14,L15)
LABEL L15
MOVE(
 TEMP t109,
 CALL(
  NAME stringEqual,
   MEM(
    BINOP(PLUS,
     MEM(
      MEM(
       TEMP t100)),
     CONST 0)),
   NAME L13))
LABEL L16
CJUMP(NE,
 TEMP t109,
 CONST 0,
 L17,L11)
LABEL L11
MOVE(
 TEMP t106,
 CONST 0)
JUMP(
 NAME L52)
LABEL L17
MOVE(
 TEMP t153,
 BINOP(PLUS,
  MEM(
   MEM(
    TEMP t100)),
  CONST 0))
MOVE(
 TEMP t152,
 CALL(
  NAME L2))
MOVE(
 MEM(
  TEMP t153),
 TEMP t152)
JUMP(
 NAME L18)
LABEL L14
MOVE(
 TEMP t109,
 CONST 1)
JUMP(
 NAME L16)
LABEL L52
# ----- Assembly L3 -----
L3:
L18:
lw t157, 0(t100)
lw t156, 0(t157)
lw t155, 0(t156)
add t108, t155, $0
la t158, L12
add t109, t158, $0
jal stringEqual 
add t154, t106, $0
bne t154, 0, L14
L15:
lw t161, 0(t100)
lw t160, 0(t161)
lw t159, 0(t160)
add t108, t159, $0
la t162, L13
add t109, t162, $0
jal stringEqual 
add t109, t106, $0
L16:
bne t109, 0, L17
L11:
addi t163, $0, 0
add t106, t163, $0
j L52 
L17:
lw t166, 0(t100)
lw t165, 0(t166)
addi t164, t165, 0
add t153, t164, $0
jal L2 
add t152, t106, $0
sw t153, 0(t152)
j L18 
L14:
addi t167, $0, 1
add t109, t167, $0
j L16 
L52:
# ----- emit L1 -----
# ----- translated L1 -----
SEQ(
 LABEL L1,
 MOVE(
  TEMP t106,
  ESEQ(
   MOVE(
    TEMP t103,
    CONST 0),
   ESEQ(
    EXP(
     CALL(
      NAME L3,
       TEMP t100)),
    ESEQ(
     MOVE(
      MEM(
       TEMP t102),
      CALL(
       NAME L2,
        TEMP t100,
        MEM(
         BINOP(PLUS,
          MEM(
           TEMP t100),
          CONST 0)))),
     ESEQ(
      SEQ(
       JUMP(
        NAME L21),
       SEQ(
        LABEL L20,
        SEQ(
         EXP(
          ESEQ(
           MOVE(
            TEMP t103,
            BINOP(MINUS,
             BINOP(PLUS,
              BINOP(MUL,
               TEMP t103,
               CONST 10),
              CALL(
               NAME L3,
                MEM(
                 BINOP(PLUS,
                  MEM(
                   TEMP t100),
                  CONST 0)))),
             CALL(
              NAME L3,
               NAME L4))),
           ESEQ(
            MOVE(
             MEM(
              BINOP(PLUS,
               MEM(
                TEMP t100),
               CONST 0)),
             CALL(
              NAME L2)),
            CONST 0))),
         SEQ(
          LABEL L21,
          SEQ(
           CJUMP(NE,
            CALL(
             NAME L2,
              TEMP t100,
              MEM(
               BINOP(PLUS,
                MEM(
                 TEMP t100),
                CONST 0))),
            CONST 0,
            L20,L19),
           LABEL L19))))),
      TEMP t103))))))
# ----- linearize L1 -----
LABEL L1
MOVE(
 TEMP t103,
 CONST 0)
EXP(
 CALL(
  NAME L3,
   TEMP t100))
MOVE(
 TEMP t169,
 TEMP t102)
MOVE(
 TEMP t168,
 CALL(
  NAME L2,
   TEMP t100,
   MEM(
    BINOP(PLUS,
     MEM(
      TEMP t100),
     CONST 0))))
MOVE(
 MEM(
  TEMP t169),
 TEMP t168)
LABEL L21
MOVE(
 TEMP t176,
 CALL(
  NAME L2,
   TEMP t100,
   MEM(
    BINOP(PLUS,
     MEM(
      TEMP t100),
     CONST 0))))
CJUMP(NE,
 TEMP t176,
 CONST 0,
 L20,L19)
LABEL L19
MOVE(
 TEMP t106,
 TEMP t103)
JUMP(
 NAME L53)
LABEL L20
MOVE(
 TEMP t171,
 BINOP(MUL,
  TEMP t103,
  CONST 10))
MOVE(
 TEMP t170,
 CALL(
  NAME L3,
   MEM(
    BINOP(PLUS,
     MEM(
      TEMP t100),
     CONST 0))))
MOVE(
 TEMP t173,
 BINOP(PLUS,
  TEMP t171,
  TEMP t170))
MOVE(
 TEMP t172,
 CALL(
  NAME L3,
   NAME L4))
MOVE(
 TEMP t103,
 BINOP(MINUS,
  TEMP t173,
  TEMP t172))
MOVE(
 TEMP t175,
 BINOP(PLUS,
  MEM(
   TEMP t100),
  CONST 0))
MOVE(
 TEMP t174,
 CALL(
  NAME L2))
MOVE(
 MEM(
  TEMP t175),
 TEMP t174)
JUMP(
 NAME L21)
LABEL L53
# ----- Assembly L1 -----
L1:
addi t177, $0, 0
add t103, t177, $0
add t108, t100, $0
jal L3 
add t169, t102, $0
add t108, t100, $0
lw t179, 0(t100)
lw t178, 0(t179)
add t109, t178, $0
jal L2 
add t168, t106, $0
sw t169, 0(t168)
L21:
add t108, t100, $0
lw t181, 0(t100)
lw t180, 0(t181)
add t109, t180, $0
jal L2 
add t176, t106, $0
bne t176, 0, L20
L19:
add t106, t103, $0
j L53 
L20:
addi t183, $0, 10
mul t182, t103, t183
add t171, t182, $0
lw t185, 0(t100)
lw t184, 0(t185)
add t108, t184, $0
jal L3 
add t170, t106, $0
add t186, t171, t170
add t173, t186, $0
la t187, L4
add t108, t187, $0
jal L3 
add t172, t106, $0
sub t188, t173, t172
add t103, t188, $0
lw t190, 0(t100)
addi t189, t190, 0
add t175, t189, $0
jal L2 
add t174, t106, $0
sw t175, 0(t174)
j L21 
L53:
# ----- emit L22 -----
# ----- translated L22 -----
SEQ(
 LABEL L22,
 MOVE(
  TEMP t106,
  ESEQ(
   SEQ(
    MOVE(
     TEMP t119,
     ESEQ(
      SEQ(
       MOVE(
        TEMP t118,
        CALL(
         NAME malloc,
          CONST 4)),
       SEQ(
        MOVE(
         MEM(
          BINOP(PLUS,
           TEMP t118,
           CONST 0)),
         CONST 0),
        EXP(
         CONST 0))),
      TEMP t118)),
    MOVE(
     TEMP t120,
     CALL(
      NAME L1,
       MEM(
        TEMP t100),
       TEMP t119))),
   ESEQ(
    SEQ(
     CJUMP(NE,
      MEM(
       TEMP t119),
      CONST 0,
      L26,L27),
     SEQ(
      LABEL L26,
      SEQ(
       MOVE(
        TEMP t122,
        ESEQ(
         SEQ(
          MOVE(
           TEMP t121,
           CALL(
            NAME malloc,
             CONST 8)),
          SEQ(
           MOVE(
            MEM(
             BINOP(PLUS,
              TEMP t121,
              CONST 0)),
            TEMP t120),
           SEQ(
            MOVE(
             MEM(
              BINOP(PLUS,
               TEMP t121,
               CONST 4)),
             CALL(
              NAME L22,
               MEM(
                TEMP t100))),
            EXP(
             CONST 0)))),
         TEMP t121)),
       SEQ(
        JUMP(
         NAME L28),
        SEQ(
         LABEL L27,
         SEQ(
          MOVE(
           TEMP t122,
           CONST 0),
          LABEL L28)))))),
    TEMP t122))))
# ----- linearize L22 -----
LABEL L22
MOVE(
 TEMP t118,
 CALL(
  NAME malloc,
   CONST 4))
MOVE(
 MEM(
  BINOP(PLUS,
   TEMP t118,
   CONST 0)),
 CONST 0)
MOVE(
 TEMP t119,
 TEMP t118)
MOVE(
 TEMP t120,
 CALL(
  NAME L1,
   MEM(
    TEMP t100),
   TEMP t119))
CJUMP(NE,
 MEM(
  TEMP t119),
 CONST 0,
 L26,L27)
LABEL L27
MOVE(
 TEMP t122,
 CONST 0)
LABEL L28
MOVE(
 TEMP t106,
 TEMP t122)
JUMP(
 NAME L54)
LABEL L26
MOVE(
 TEMP t121,
 CALL(
  NAME malloc,
   CONST 8))
MOVE(
 MEM(
  BINOP(PLUS,
   TEMP t121,
   CONST 0)),
 TEMP t120)
MOVE(
 TEMP t192,
 BINOP(PLUS,
  TEMP t121,
  CONST 4))
MOVE(
 TEMP t191,
 CALL(
  NAME L22,
   MEM(
    TEMP t100)))
MOVE(
 MEM(
  TEMP t192),
 TEMP t191)
MOVE(
 TEMP t122,
 TEMP t121)
JUMP(
 NAME L28)
LABEL L54
# ----- Assembly L22 -----
L22:
addi t193, $0, 4
add t108, t193, $0
jal malloc 
add t118, t106, $0
addi t194, $0, 0
sw t194, 0(t118)
add t119, t118, $0
lw t195, 0(t100)
add t108, t195, $0
add t109, t119, $0
jal L1 
add t120, t106, $0
lw t196, 0(t119)
bne t196, 0, L26
L27:
addi t197, $0, 0
add t122, t197, $0
L28:
add t106, t122, $0
j L54 
L26:
addi t198, $0, 8
add t108, t198, $0
jal malloc 
add t121, t106, $0
sw t120, 0(t121)
addi t199, t121, 4
add t192, t199, $0
lw t200, 0(t100)
add t108, t200, $0
jal L22 
add t191, t106, $0
sw t192, 0(t191)
add t122, t121, $0
j L28 
L54:
# ----- emit L23 -----
# ----- translated L23 -----
SEQ(
 LABEL L23,
 MOVE(
  TEMP t106,
  ESEQ(
   SEQ(
    CJUMP(EQ,
     TEMP t112,
     CONST 0,
     L35,L36),
    SEQ(
     LABEL L35,
     SEQ(
      MOVE(
       TEMP t127,
       TEMP t113),
      SEQ(
       JUMP(
        NAME L37),
       SEQ(
        LABEL L36,
        SEQ(
         MOVE(
          TEMP t127,
          ESEQ(
           SEQ(
            CJUMP(EQ,
             TEMP t113,
             CONST 0,
             L32,L33),
            SEQ(
             LABEL L32,
             SEQ(
              MOVE(
               TEMP t126,
               TEMP t112),
              SEQ(
               JUMP(
                NAME L34),
               SEQ(
                LABEL L33,
                SEQ(
                 MOVE(
                  TEMP t126,
                  ESEQ(
                   SEQ(
                    CJUMP(LT,
                     MEM(
                      TEMP t112),
                     MEM(
                      TEMP t113),
                     L29,L30),
                    SEQ(
                     LABEL L29,
                     SEQ(
                      MOVE(
                       TEMP t125,
                       ESEQ(
                        SEQ(
                         MOVE(
                          TEMP t123,
                          CALL(
                           NAME malloc,
                            CONST 8)),
                         SEQ(
                          MOVE(
                           MEM(
                            BINOP(PLUS,
                             TEMP t123,
                             CONST 0)),
                           MEM(
                            TEMP t112)),
                          SEQ(
                           MOVE(
                            MEM(
                             BINOP(PLUS,
                              TEMP t123,
                              CONST 4)),
                            CALL(
                             NAME L23,
                              MEM(
                               TEMP t100),
                              MEM(
                               BINOP(PLUS,
                                TEMP t112,
                                CONST 4)),
                              TEMP t113)),
                           EXP(
                            CONST 0)))),
                        TEMP t123)),
                      SEQ(
                       JUMP(
                        NAME L31),
                       SEQ(
                        LABEL L30,
                        SEQ(
                         MOVE(
                          TEMP t125,
                          ESEQ(
                           SEQ(
                            MOVE(
                             TEMP t124,
                             CALL(
                              NAME malloc,
                               CONST 8)),
                            SEQ(
                             MOVE(
                              MEM(
                               BINOP(PLUS,
                                TEMP t124,
                                CONST 0)),
                              MEM(
                               TEMP t113)),
                             SEQ(
                              MOVE(
                               MEM(
                                BINOP(PLUS,
                                 TEMP t124,
                                 CONST 4)),
                               CALL(
                                NAME L23,
                                 MEM(
                                  TEMP t100),
                                 TEMP t112,
                                 MEM(
                                  BINOP(PLUS,
                                   TEMP t113,
                                   CONST 4)))),
                              EXP(
                               CONST 0)))),
                           TEMP t124)),
                         LABEL L31)))))),
                   TEMP t125)),
                 LABEL L34)))))),
           TEMP t126)),
         LABEL L37)))))),
   TEMP t127)))
# ----- linearize L23 -----
LABEL L23
CJUMP(EQ,
 TEMP t112,
 CONST 0,
 L35,L36)
LABEL L36
CJUMP(EQ,
 TEMP t113,
 CONST 0,
 L32,L33)
LABEL L33
CJUMP(LT,
 MEM(
  TEMP t112),
 MEM(
  TEMP t113),
 L29,L30)
LABEL L30
MOVE(
 TEMP t124,
 CALL(
  NAME malloc,
   CONST 8))
MOVE(
 MEM(
  BINOP(PLUS,
   TEMP t124,
   CONST 0)),
 MEM(
  TEMP t113))
MOVE(
 TEMP t204,
 BINOP(PLUS,
  TEMP t124,
  CONST 4))
MOVE(
 TEMP t203,
 CALL(
  NAME L23,
   MEM(
    TEMP t100),
   TEMP t112,
   MEM(
    BINOP(PLUS,
     TEMP t113,
     CONST 4))))
MOVE(
 MEM(
  TEMP t204),
 TEMP t203)
MOVE(
 TEMP t125,
 TEMP t124)
LABEL L31
MOVE(
 TEMP t126,
 TEMP t125)
LABEL L34
MOVE(
 TEMP t127,
 TEMP t126)
LABEL L37
MOVE(
 TEMP t106,
 TEMP t127)
JUMP(
 NAME L55)
LABEL L35
MOVE(
 TEMP t127,
 TEMP t113)
JUMP(
 NAME L37)
LABEL L32
MOVE(
 TEMP t126,
 TEMP t112)
JUMP(
 NAME L34)
LABEL L29
MOVE(
 TEMP t123,
 CALL(
  NAME malloc,
   CONST 8))
MOVE(
 MEM(
  BINOP(PLUS,
   TEMP t123,
   CONST 0)),
 MEM(
  TEMP t112))
MOVE(
 TEMP t202,
 BINOP(PLUS,
  TEMP t123,
  CONST 4))
MOVE(
 TEMP t201,
 CALL(
  NAME L23,
   MEM(
    TEMP t100),
   MEM(
    BINOP(PLUS,
     TEMP t112,
     CONST 4)),
   TEMP t113))
MOVE(
 MEM(
  TEMP t202),
 TEMP t201)
MOVE(
 TEMP t125,
 TEMP t123)
JUMP(
 NAME L31)
LABEL L55
# ----- Assembly L23 -----
L23:
beq t112, 0, L35
L36:
beq t113, 0, L32
L33:
lw t205, 0(t112)
lw t206, 0(t113)
blt t205, t206, L29
L30:
addi t207, $0, 8
add t108, t207, $0
jal malloc 
add t124, t106, $0
lw t208, 0(t113)
sw t208, 0(t124)
addi t209, t124, 4
add t204, t209, $0
lw t210, 0(t100)
add t108, t210, $0
add t109, t112, $0
lw t211, 4(t113)
add t110, t211, $0
jal L23 
add t203, t106, $0
sw t204, 0(t203)
add t125, t124, $0
L31:
add t126, t125, $0
L34:
add t127, t126, $0
L37:
add t106, t127, $0
j L55 
L35:
add t127, t113, $0
j L37 
L32:
add t126, t112, $0
j L34 
L29:
addi t212, $0, 8
add t108, t212, $0
jal malloc 
add t123, t106, $0
lw t213, 0(t112)
sw t213, 0(t123)
addi t214, t123, 4
add t202, t214, $0
lw t215, 0(t100)
add t108, t215, $0
lw t216, 4(t112)
add t109, t216, $0
add t110, t113, $0
jal L23 
add t201, t106, $0
sw t202, 0(t201)
add t125, t123, $0
j L31 
L55:
# ----- emit L38 -----
# ----- translated L38 -----
SEQ(
 LABEL L38,
 MOVE(
  TEMP t106,
  ESEQ(
   SEQ(
    CJUMP(GT,
     TEMP t129,
     CONST 0,
     L39,L40),
    SEQ(
     LABEL L39,
     SEQ(
      EXP(
       ESEQ(
        EXP(
         CALL(
          NAME L38,
           MEM(
            TEMP t100),
           BINOP(DIV,
            TEMP t129,
            CONST 10))),
        CALL(
         NAME L0,
          CALL(
           NAME L4,
            BINOP(PLUS,
             BINOP(MINUS,
              TEMP t129,
              BINOP(MUL,
               BINOP(DIV,
                TEMP t129,
                CONST 10),
               CONST 10)),
             CALL(
              NAME L3,
               NAME L4)))))),
      LABEL L40))),
   CONST 0)))
# ----- linearize L38 -----
LABEL L38
CJUMP(GT,
 TEMP t129,
 CONST 0,
 L39,L40)
LABEL L40
MOVE(
 TEMP t106,
 CONST 0)
JUMP(
 NAME L56)
LABEL L39
EXP(
 CALL(
  NAME L38,
   MEM(
    TEMP t100),
   BINOP(DIV,
    TEMP t129,
    CONST 10)))
MOVE(
 TEMP t219,
 BINOP(MINUS,
  TEMP t129,
  BINOP(MUL,
   BINOP(DIV,
    TEMP t129,
    CONST 10),
   CONST 10)))
MOVE(
 TEMP t218,
 CALL(
  NAME L3,
   NAME L4))
MOVE(
 TEMP t217,
 CALL(
  NAME L4,
   BINOP(PLUS,
    TEMP t219,
    TEMP t218)))
EXP(
 CALL(
  NAME L0,
   TEMP t217))
JUMP(
 NAME L40)
LABEL L56
# ----- Assembly L38 -----
L38:
bgt t129, 0, L39
L40:
addi t220, $0, 0
add t106, t220, $0
j L56 
L39:
lw t221, 0(t100)
add t108, t221, $0
addi t223, $0, 10
div t222, t129, t223
add t109, t222, $0
jal L38 
addi t227, $0, 10
div t226, t129, t227
addi t228, $0, 10
mul t225, t226, t228
sub t224, t129, t225
add t219, t224, $0
la t229, L4
add t108, t229, $0
jal L3 
add t218, t106, $0
add t230, t219, t218
add t108, t230, $0
jal L4 
add t217, t106, $0
add t108, t217, $0
jal L0 
j L40 
L56:
L41 : .ascii - 
# ----- emit L24 -----
# ----- translated L24 -----
SEQ(
 LABEL L24,
 MOVE(
  TEMP t106,
  ESEQ(
   SEQ(
    CJUMP(LT,
     TEMP t115,
     CONST 0,
     L45,L46),
    SEQ(
     LABEL L45,
     SEQ(
      MOVE(
       TEMP t131,
       ESEQ(
        EXP(
         CALL(
          NAME L0,
           NAME L41)),
        CALL(
         NAME L38,
          TEMP t100,
          BINOP(MINUS,
           CONST 0,
           TEMP t115)))),
      SEQ(
       JUMP(
        NAME L47),
       SEQ(
        LABEL L46,
        SEQ(
         MOVE(
          TEMP t131,
          ESEQ(
           SEQ(
            CJUMP(GT,
             TEMP t115,
             CONST 0,
             L42,L43),
            SEQ(
             LABEL L42,
             SEQ(
              MOVE(
               TEMP t130,
               CALL(
                NAME L38,
                 TEMP t100,
                 TEMP t115)),
              SEQ(
               JUMP(
                NAME L44),
               SEQ(
                LABEL L43,
                SEQ(
                 MOVE(
                  TEMP t130,
                  CALL(
                   NAME L0,
                    NAME L4)),
                 LABEL L44)))))),
           TEMP t130)),
         LABEL L47)))))),
   TEMP t131)))
# ----- linearize L24 -----
LABEL L24
CJUMP(LT,
 TEMP t115,
 CONST 0,
 L45,L46)
LABEL L46
CJUMP(GT,
 TEMP t115,
 CONST 0,
 L42,L43)
LABEL L43
MOVE(
 TEMP t130,
 CALL(
  NAME L0,
   NAME L4))
LABEL L44
MOVE(
 TEMP t131,
 TEMP t130)
LABEL L47
MOVE(
 TEMP t106,
 TEMP t131)
JUMP(
 NAME L57)
LABEL L45
EXP(
 CALL(
  NAME L0,
   NAME L41))
MOVE(
 TEMP t131,
 CALL(
  NAME L38,
   TEMP t100,
   BINOP(MINUS,
    CONST 0,
    TEMP t115)))
JUMP(
 NAME L47)
LABEL L42
MOVE(
 TEMP t130,
 CALL(
  NAME L38,
   TEMP t100,
   TEMP t115))
JUMP(
 NAME L44)
LABEL L57
# ----- Assembly L24 -----
L24:
blt t115, 0, L45
L46:
bgt t115, 0, L42
L43:
la t231, L4
add t108, t231, $0
jal L0 
add t130, t106, $0
L44:
add t131, t130, $0
L47:
add t106, t131, $0
j L57 
L45:
la t232, L41
add t108, t232, $0
jal L0 
add t108, t100, $0
addi t233, t115, 0
add t109, t233, $0
jal L38 
add t131, t106, $0
j L47 
L42:
add t108, t100, $0
add t109, t115, $0
jal L38 
add t130, t106, $0
j L44 
L57:
# ----- emit L25 -----
# ----- translated L25 -----
SEQ(
 LABEL L25,
 MOVE(
  TEMP t106,
  ESEQ(
   SEQ(
    CJUMP(EQ,
     TEMP t117,
     CONST 0,
     L48,L49),
    SEQ(
     LABEL L48,
     SEQ(
      MOVE(
       TEMP t132,
       CALL(
        NAME L0,
         NAME L13)),
      SEQ(
       JUMP(
        NAME L50),
       SEQ(
        LABEL L49,
        SEQ(
         MOVE(
          TEMP t132,
          ESEQ(
           EXP(
            CALL(
             NAME L24,
              MEM(
               TEMP t100),
              MEM(
               TEMP t117))),
           ESEQ(
            EXP(
             CALL(
              NAME L0,
               NAME L12)),
            CALL(
             NAME L25,
              MEM(
               TEMP t100),
              MEM(
               BINOP(PLUS,
                TEMP t117,
                CONST 4)))))),
         LABEL L50)))))),
   TEMP t132)))
# ----- linearize L25 -----
LABEL L25
CJUMP(EQ,
 TEMP t117,
 CONST 0,
 L48,L49)
LABEL L49
EXP(
 CALL(
  NAME L24,
   MEM(
    TEMP t100),
   MEM(
    TEMP t117)))
EXP(
 CALL(
  NAME L0,
   NAME L12))
MOVE(
 TEMP t132,
 CALL(
  NAME L25,
   MEM(
    TEMP t100),
   MEM(
    BINOP(PLUS,
     TEMP t117,
     CONST 4))))
LABEL L50
MOVE(
 TEMP t106,
 TEMP t132)
JUMP(
 NAME L58)
LABEL L48
MOVE(
 TEMP t132,
 CALL(
  NAME L0,
   NAME L13))
JUMP(
 NAME L50)
LABEL L58
# ----- Assembly L25 -----
L25:
beq t117, 0, L48
L49:
lw t234, 0(t100)
add t108, t234, $0
lw t235, 0(t117)
add t109, t235, $0
jal L24 
la t236, L12
add t108, t236, $0
jal L0 
lw t237, 0(t100)
add t108, t237, $0
lw t238, 4(t117)
add t109, t238, $0
jal L25 
add t132, t106, $0
L50:
add t106, t132, $0
j L58 
L48:
la t239, L13
add t108, t239, $0
jal L0 
add t132, t106, $0
j L50 
L58:
# ----- emit L0 -----
# ----- translated L0 -----
SEQ(
 LABEL L0,
 MOVE(
  TEMP t106,
  ESEQ(
   SEQ(
    MOVE(
     MEM(
      BINOP(PLUS,
       TEMP t100,
       CONST 0)),
     CALL(
      NAME L2)),
    SEQ(
     MOVE(
      TEMP t133,
      CALL(
       NAME L22,
        TEMP t100)),
     MOVE(
      TEMP t134,
      ESEQ(
       MOVE(
        MEM(
         BINOP(PLUS,
          TEMP t100,
          CONST 0)),
        CALL(
         NAME L2)),
       CALL(
        NAME L22,
         TEMP t100))))),
   CALL(
    NAME L25,
     TEMP t100,
     CALL(
      NAME L23,
       TEMP t100,
       TEMP t133,
       TEMP t134)))))
# ----- linearize L0 -----
LABEL L0
MOVE(
 TEMP t241,
 BINOP(PLUS,
  TEMP t100,
  CONST 0))
MOVE(
 TEMP t240,
 CALL(
  NAME L2))
MOVE(
 MEM(
  TEMP t241),
 TEMP t240)
MOVE(
 TEMP t133,
 CALL(
  NAME L22,
   TEMP t100))
MOVE(
 TEMP t243,
 BINOP(PLUS,
  TEMP t100,
  CONST 0))
MOVE(
 TEMP t242,
 CALL(
  NAME L2))
MOVE(
 MEM(
  TEMP t243),
 TEMP t242)
MOVE(
 TEMP t134,
 CALL(
  NAME L22,
   TEMP t100))
MOVE(
 TEMP t245,
 TEMP t100)
MOVE(
 TEMP t244,
 CALL(
  NAME L23,
   TEMP t100,
   TEMP t133,
   TEMP t134))
MOVE(
 TEMP t106,
 CALL(
  NAME L25,
   TEMP t245,
   TEMP t244))
JUMP(
 NAME L59)
LABEL L59
# ----- Assembly L0 -----
L0:
addi t246, t100, 0
add t241, t246, $0
jal L2 
add t240, t106, $0
sw t241, 0(t240)
add t108, t100, $0
jal L22 
add t133, t106, $0
addi t247, t100, 0
add t243, t247, $0
jal L2 
add t242, t106, $0
sw t243, 0(t242)
add t108, t100, $0
jal L22 
add t134, t106, $0
add t245, t100, $0
add t108, t100, $0
add t109, t133, $0
add t110, t134, $0
jal L23 
add t244, t106, $0
add t108, t245, $0
add t109, t244, $0
jal L25 
add t106, t106, $0
j L59 
L59:
