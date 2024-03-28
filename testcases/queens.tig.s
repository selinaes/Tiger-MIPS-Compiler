L8 : .ascii  O 
L9 : .ascii  . 
L15 : .ascii 
 
# ----- emit L1 -----
# ----- translated L1 -----
SEQ(
 LABEL L1,
 MOVE(
  TEMP t106,
  ESEQ(
   SEQ(
    MOVE(
     TEMP t104,
     CONST 0),
    SEQ(
     CJUMP(LE,
      TEMP t104,
      BINOP(MINUS,
       MEM(
        BINOP(PLUS,
         MEM(
          TEMP t100),
         CONST 0)),
       CONST 1),
      L16,L3),
     SEQ(
      LABEL L17,
      SEQ(
       MOVE(
        TEMP t104,
        BINOP(PLUS,
         TEMP t104,
         CONST 1)),
       SEQ(
        LABEL L16,
        SEQ(
         EXP(
          ESEQ(
           SEQ(
            MOVE(
             TEMP t105,
             CONST 0),
            SEQ(
             CJUMP(LE,
              TEMP t105,
              BINOP(MINUS,
               MEM(
                BINOP(PLUS,
                 MEM(
                  TEMP t100),
                 CONST 0)),
               CONST 1),
              L13,L4),
             SEQ(
              LABEL L14,
              SEQ(
               MOVE(
                TEMP t105,
                BINOP(PLUS,
                 TEMP t105,
                 CONST 1)),
               SEQ(
                LABEL L13,
                SEQ(
                 EXP(
                  CALL(
                   NAME L0,
                    ESEQ(
                     SEQ(
                      CJUMP(EQ,
                       ESEQ(
                        SEQ(
                         MOVE(
                          TEMP t106,
                          TEMP t104),
                         SEQ(
                          MOVE(
                           TEMP t107,
                           MEM(
                            BINOP(PLUS,
                             MEM(
                              BINOP(PLUS,
                               MEM(
                                TEMP t100),
                               CONST ~8)),
                             CONST ~4))),
                          SEQ(
                           CJUMP(GE,
                            TEMP t106,
                            TEMP t107,
                            L5,L6),
                           SEQ(
                            LABEL L6,
                            SEQ(
                             CJUMP(LT,
                              TEMP t106,
                              CONST 0,
                              L5,L7),
                             SEQ(
                              LABEL L5,
                              SEQ(
                               EXP(
                                CALL(
                                 NAME exit,
                                  CONST 1)),
                               LABEL L7))))))),
                        MEM(
                         BINOP(PLUS,
                          MEM(
                           BINOP(PLUS,
                            MEM(
                             TEMP t100),
                            CONST ~8)),
                          BINOP(MUL,
                           TEMP t104,
                           CONST 4)))),
                       TEMP t105,
                       L10,L11),
                      SEQ(
                       LABEL L10,
                       SEQ(
                        MOVE(
                         TEMP t108,
                         NAME L8),
                        SEQ(
                         JUMP(
                          NAME L12),
                         SEQ(
                          LABEL L11,
                          SEQ(
                           MOVE(
                            TEMP t108,
                            NAME L9),
                           LABEL L12)))))),
                     TEMP t108))),
                 SEQ(
                  CJUMP(LT,
                   TEMP t105,
                   BINOP(MINUS,
                    MEM(
                     BINOP(PLUS,
                      MEM(
                       TEMP t100),
                      CONST 0)),
                    CONST 1),
                   L14,L4),
                  LABEL L4))))))),
           CALL(
            NAME L0,
             NAME L15))),
         SEQ(
          CJUMP(LT,
           TEMP t104,
           BINOP(MINUS,
            MEM(
             BINOP(PLUS,
              MEM(
               TEMP t100),
              CONST 0)),
            CONST 1),
           L17,L3),
          LABEL L3))))))),
   CALL(
    NAME L0,
     NAME L15))))
# ----- linearize L1 -----
LABEL L1
MOVE(
 TEMP t104,
 CONST 0)
CJUMP(LE,
 TEMP t104,
 BINOP(MINUS,
  MEM(
   BINOP(PLUS,
    MEM(
     TEMP t100),
    CONST 0)),
  CONST 1),
 L16,L3)
LABEL L3
MOVE(
 TEMP t106,
 CALL(
  NAME L0,
   NAME L15))
JUMP(
 NAME L66)
LABEL L17
MOVE(
 TEMP t104,
 BINOP(PLUS,
  TEMP t104,
  CONST 1))
LABEL L16
MOVE(
 TEMP t105,
 CONST 0)
CJUMP(LE,
 TEMP t105,
 BINOP(MINUS,
  MEM(
   BINOP(PLUS,
    MEM(
     TEMP t100),
    CONST 0)),
  CONST 1),
 L13,L4)
LABEL L4
EXP(
 CALL(
  NAME L0,
   NAME L15))
CJUMP(LT,
 TEMP t104,
 BINOP(MINUS,
  MEM(
   BINOP(PLUS,
    MEM(
     TEMP t100),
    CONST 0)),
  CONST 1),
 L17,L67)
LABEL L67
JUMP(
 NAME L3)
LABEL L14
MOVE(
 TEMP t105,
 BINOP(PLUS,
  TEMP t105,
  CONST 1))
LABEL L13
MOVE(
 TEMP t106,
 TEMP t104)
MOVE(
 TEMP t107,
 MEM(
  BINOP(PLUS,
   MEM(
    BINOP(PLUS,
     MEM(
      TEMP t100),
     CONST ~8)),
   CONST ~4)))
CJUMP(GE,
 TEMP t106,
 TEMP t107,
 L5,L6)
LABEL L6
CJUMP(LT,
 TEMP t106,
 CONST 0,
 L5,L7)
LABEL L7
CJUMP(EQ,
 MEM(
  BINOP(PLUS,
   MEM(
    BINOP(PLUS,
     MEM(
      TEMP t100),
     CONST ~8)),
   BINOP(MUL,
    TEMP t104,
    CONST 4))),
 TEMP t105,
 L10,L11)
LABEL L11
MOVE(
 TEMP t108,
 NAME L9)
LABEL L12
EXP(
 CALL(
  NAME L0,
   TEMP t108))
CJUMP(LT,
 TEMP t105,
 BINOP(MINUS,
  MEM(
   BINOP(PLUS,
    MEM(
     TEMP t100),
    CONST 0)),
  CONST 1),
 L14,L68)
LABEL L68
JUMP(
 NAME L4)
LABEL L5
EXP(
 CALL(
  NAME exit,
   CONST 1))
JUMP(
 NAME L7)
LABEL L10
MOVE(
 TEMP t108,
 NAME L8)
JUMP(
 NAME L12)
LABEL L66
# ----- Assembly L1 -----
L1:
addi t135, $0, 0
add t104, t135, $0
lw t138, 0(t100)
lw t137, 0(t138)
addi t136, t137, -1
ble t104, t136, L16
L3:
la t139, L15
add t108, t139, $0
jal L0 
add t106, t106, $0
j L66 
L17:
addi t140, t104, 1
add t104, t140, $0
L16:
addi t141, $0, 0
add t105, t141, $0
lw t144, 0(t100)
lw t143, 0(t144)
addi t142, t143, -1
ble t105, t142, L13
L4:
la t145, L15
add t108, t145, $0
jal L0 
lw t148, 0(t100)
lw t147, 0(t148)
addi t146, t147, -1
blt t104, t146, L17
L67:
j L3 
L14:
addi t149, t105, 1
add t105, t149, $0
L13:
add t106, t104, $0
lw t152, 0(t100)
lw t151, -8(t152)
lw t150, -4(t151)
add t107, t150, $0
bge t106, t107, L5
L6:
blt t106, 0, L5
L7:
lw t156, 0(t100)
lw t155, -8(t156)
addi t158, $0, 4
mul t157, t104, t158
add t154, t155, t157
lw t153, 0(t154)
beq t153, t105, L10
L11:
la t159, L9
add t108, t159, $0
L12:
add t108, t108, $0
jal L0 
lw t162, 0(t100)
lw t161, 0(t162)
addi t160, t161, -1
blt t105, t160, L14
L68:
j L4 
L5:
addi t163, $0, 1
add t108, t163, $0
jal exit 
j L7 
L10:
la t164, L8
add t108, t164, $0
j L12 
L66:
# ----- emit L2 -----
# ----- translated L2 -----
SEQ(
 LABEL L2,
 MOVE(
  TEMP t106,
  ESEQ(
   SEQ(
    CJUMP(EQ,
     TEMP t103,
     MEM(
      BINOP(PLUS,
       MEM(
        TEMP t100),
       CONST 0)),
     L63,L64),
    SEQ(
     LABEL L63,
     SEQ(
      MOVE(
       TEMP t134,
       CALL(
        NAME L1,
         MEM(
          TEMP t100))),
      SEQ(
       JUMP(
        NAME L65),
       SEQ(
        LABEL L64,
        SEQ(
         MOVE(
          TEMP t134,
          ESEQ(
           SEQ(
            MOVE(
             TEMP t109,
             CONST 0),
            SEQ(
             CJUMP(LE,
              TEMP t109,
              BINOP(MINUS,
               MEM(
                BINOP(PLUS,
                 MEM(
                  TEMP t100),
                 CONST 0)),
               CONST 1),
              L61,L18),
             SEQ(
              LABEL L62,
              SEQ(
               MOVE(
                TEMP t109,
                BINOP(PLUS,
                 TEMP t109,
                 CONST 1)),
               SEQ(
                LABEL L61,
                SEQ(
                 SEQ(
                  CJUMP(NE,
                   ESEQ(
                    SEQ(
                     CJUMP(NE,
                      ESEQ(
                       SEQ(
                        CJUMP(EQ,
                         ESEQ(
                          SEQ(
                           MOVE(
                            TEMP t110,
                            TEMP t109),
                           SEQ(
                            MOVE(
                             TEMP t111,
                             MEM(
                              BINOP(PLUS,
                               MEM(
                                BINOP(PLUS,
                                 MEM(
                                  TEMP t100),
                                 CONST ~4)),
                               CONST ~4))),
                            SEQ(
                             CJUMP(GE,
                              TEMP t110,
                              TEMP t111,
                              L19,L20),
                             SEQ(
                              LABEL L20,
                              SEQ(
                               CJUMP(LT,
                                TEMP t110,
                                CONST 0,
                                L19,L21),
                               SEQ(
                                LABEL L19,
                                SEQ(
                                 EXP(
                                  CALL(
                                   NAME exit,
                                    CONST 1)),
                                 LABEL L21))))))),
                          MEM(
                           BINOP(PLUS,
                            MEM(
                             BINOP(PLUS,
                              MEM(
                               TEMP t100),
                              CONST ~4)),
                            BINOP(MUL,
                             TEMP t109,
                             CONST 4)))),
                         CONST 0,
                         L27,L28),
                        SEQ(
                         LABEL L27,
                         SEQ(
                          MOVE(
                           TEMP t115,
                           ESEQ(
                            SEQ(
                             MOVE(
                              TEMP t114,
                              CONST 1),
                             SEQ(
                              CJUMP(EQ,
                               ESEQ(
                                SEQ(
                                 MOVE(
                                  TEMP t112,
                                  BINOP(PLUS,
                                   TEMP t109,
                                   TEMP t103)),
                                 SEQ(
                                  MOVE(
                                   TEMP t113,
                                   MEM(
                                    BINOP(PLUS,
                                     MEM(
                                      BINOP(PLUS,
                                       MEM(
                                        TEMP t100),
                                       CONST ~12)),
                                     CONST ~4))),
                                  SEQ(
                                   CJUMP(GE,
                                    TEMP t112,
                                    TEMP t113,
                                    L22,L23),
                                   SEQ(
                                    LABEL L23,
                                    SEQ(
                                     CJUMP(LT,
                                      TEMP t112,
                                      CONST 0,
                                      L22,L24),
                                     SEQ(
                                      LABEL L22,
                                      SEQ(
                                       EXP(
                                        CALL(
                                         NAME exit,
                                          CONST 1)),
                                       LABEL L24))))))),
                                MEM(
                                 BINOP(PLUS,
                                  MEM(
                                   BINOP(PLUS,
                                    MEM(
                                     TEMP t100),
                                    CONST ~12)),
                                  BINOP(MUL,
                                   BINOP(PLUS,
                                    TEMP t109,
                                    TEMP t103),
                                   CONST 4)))),
                               CONST 0,
                               L25,L26),
                              SEQ(
                               LABEL L26,
                               SEQ(
                                MOVE(
                                 TEMP t114,
                                 CONST 0),
                                LABEL L25)))),
                            TEMP t114)),
                          SEQ(
                           JUMP(
                            NAME L29),
                           SEQ(
                            LABEL L28,
                            SEQ(
                             MOVE(
                              TEMP t115,
                              CONST 0),
                             LABEL L29)))))),
                       TEMP t115),
                      CONST 0,
                      L35,L36),
                     SEQ(
                      LABEL L35,
                      SEQ(
                       MOVE(
                        TEMP t119,
                        ESEQ(
                         SEQ(
                          MOVE(
                           TEMP t118,
                           CONST 1),
                          SEQ(
                           CJUMP(EQ,
                            ESEQ(
                             SEQ(
                              MOVE(
                               TEMP t116,
                               BINOP(MINUS,
                                BINOP(PLUS,
                                 TEMP t109,
                                 CONST 7),
                                TEMP t103)),
                              SEQ(
                               MOVE(
                                TEMP t117,
                                MEM(
                                 BINOP(PLUS,
                                  MEM(
                                   BINOP(PLUS,
                                    MEM(
                                     TEMP t100),
                                    CONST ~16)),
                                  CONST ~4))),
                               SEQ(
                                CJUMP(GE,
                                 TEMP t116,
                                 TEMP t117,
                                 L30,L31),
                                SEQ(
                                 LABEL L31,
                                 SEQ(
                                  CJUMP(LT,
                                   TEMP t116,
                                   CONST 0,
                                   L30,L32),
                                  SEQ(
                                   LABEL L30,
                                   SEQ(
                                    EXP(
                                     CALL(
                                      NAME exit,
                                       CONST 1)),
                                    LABEL L32))))))),
                             MEM(
                              BINOP(PLUS,
                               MEM(
                                BINOP(PLUS,
                                 MEM(
                                  TEMP t100),
                                 CONST ~16)),
                               BINOP(MUL,
                                BINOP(MINUS,
                                 BINOP(PLUS,
                                  TEMP t109,
                                  CONST 7),
                                 TEMP t103),
                                CONST 4)))),
                            CONST 0,
                            L33,L34),
                           SEQ(
                            LABEL L34,
                            SEQ(
                             MOVE(
                              TEMP t118,
                              CONST 0),
                             LABEL L33)))),
                         TEMP t118)),
                       SEQ(
                        JUMP(
                         NAME L37),
                        SEQ(
                         LABEL L36,
                         SEQ(
                          MOVE(
                           TEMP t119,
                           CONST 0),
                          LABEL L37)))))),
                    TEMP t119),
                   CONST 0,
                   L59,L60),
                  SEQ(
                   LABEL L59,
                   SEQ(
                    EXP(
                     ESEQ(
                      MOVE(
                       ESEQ(
                        SEQ(
                         MOVE(
                          TEMP t120,
                          TEMP t109),
                         SEQ(
                          MOVE(
                           TEMP t121,
                           MEM(
                            BINOP(PLUS,
                             MEM(
                              BINOP(PLUS,
                               MEM(
                                TEMP t100),
                               CONST ~4)),
                             CONST ~4))),
                          SEQ(
                           CJUMP(GE,
                            TEMP t120,
                            TEMP t121,
                            L38,L39),
                           SEQ(
                            LABEL L39,
                            SEQ(
                             CJUMP(LT,
                              TEMP t120,
                              CONST 0,
                              L38,L40),
                             SEQ(
                              LABEL L38,
                              SEQ(
                               EXP(
                                CALL(
                                 NAME exit,
                                  CONST 1)),
                               LABEL L40))))))),
                        MEM(
                         BINOP(PLUS,
                          MEM(
                           BINOP(PLUS,
                            MEM(
                             TEMP t100),
                            CONST ~4)),
                          BINOP(MUL,
                           TEMP t109,
                           CONST 4)))),
                       CONST 1),
                      ESEQ(
                       MOVE(
                        ESEQ(
                         SEQ(
                          MOVE(
                           TEMP t122,
                           BINOP(PLUS,
                            TEMP t109,
                            TEMP t103)),
                          SEQ(
                           MOVE(
                            TEMP t123,
                            MEM(
                             BINOP(PLUS,
                              MEM(
                               BINOP(PLUS,
                                MEM(
                                 TEMP t100),
                                CONST ~12)),
                              CONST ~4))),
                           SEQ(
                            CJUMP(GE,
                             TEMP t122,
                             TEMP t123,
                             L41,L42),
                            SEQ(
                             LABEL L42,
                             SEQ(
                              CJUMP(LT,
                               TEMP t122,
                               CONST 0,
                               L41,L43),
                              SEQ(
                               LABEL L41,
                               SEQ(
                                EXP(
                                 CALL(
                                  NAME exit,
                                   CONST 1)),
                                LABEL L43))))))),
                         MEM(
                          BINOP(PLUS,
                           MEM(
                            BINOP(PLUS,
                             MEM(
                              TEMP t100),
                             CONST ~12)),
                           BINOP(MUL,
                            BINOP(PLUS,
                             TEMP t109,
                             TEMP t103),
                            CONST 4)))),
                        CONST 1),
                       ESEQ(
                        MOVE(
                         ESEQ(
                          SEQ(
                           MOVE(
                            TEMP t124,
                            BINOP(MINUS,
                             BINOP(PLUS,
                              TEMP t109,
                              CONST 7),
                             TEMP t103)),
                           SEQ(
                            MOVE(
                             TEMP t125,
                             MEM(
                              BINOP(PLUS,
                               MEM(
                                BINOP(PLUS,
                                 MEM(
                                  TEMP t100),
                                 CONST ~16)),
                               CONST ~4))),
                            SEQ(
                             CJUMP(GE,
                              TEMP t124,
                              TEMP t125,
                              L44,L45),
                             SEQ(
                              LABEL L45,
                              SEQ(
                               CJUMP(LT,
                                TEMP t124,
                                CONST 0,
                                L44,L46),
                               SEQ(
                                LABEL L44,
                                SEQ(
                                 EXP(
                                  CALL(
                                   NAME exit,
                                    CONST 1)),
                                 LABEL L46))))))),
                          MEM(
                           BINOP(PLUS,
                            MEM(
                             BINOP(PLUS,
                              MEM(
                               TEMP t100),
                              CONST ~16)),
                            BINOP(MUL,
                             BINOP(MINUS,
                              BINOP(PLUS,
                               TEMP t109,
                               CONST 7),
                              TEMP t103),
                             CONST 4)))),
                         CONST 1),
                        ESEQ(
                         MOVE(
                          ESEQ(
                           SEQ(
                            MOVE(
                             TEMP t126,
                             TEMP t103),
                            SEQ(
                             MOVE(
                              TEMP t127,
                              MEM(
                               BINOP(PLUS,
                                MEM(
                                 BINOP(PLUS,
                                  MEM(
                                   TEMP t100),
                                  CONST ~8)),
                                CONST ~4))),
                             SEQ(
                              CJUMP(GE,
                               TEMP t126,
                               TEMP t127,
                               L47,L48),
                              SEQ(
                               LABEL L48,
                               SEQ(
                                CJUMP(LT,
                                 TEMP t126,
                                 CONST 0,
                                 L47,L49),
                                SEQ(
                                 LABEL L47,
                                 SEQ(
                                  EXP(
                                   CALL(
                                    NAME exit,
                                     CONST 1)),
                                  LABEL L49))))))),
                           MEM(
                            BINOP(PLUS,
                             MEM(
                              BINOP(PLUS,
                               MEM(
                                TEMP t100),
                               CONST ~8)),
                             BINOP(MUL,
                              TEMP t103,
                              CONST 4)))),
                          TEMP t109),
                         ESEQ(
                          EXP(
                           CALL(
                            NAME L2,
                             MEM(
                              TEMP t100),
                             BINOP(PLUS,
                              TEMP t103,
                              CONST 1))),
                          ESEQ(
                           MOVE(
                            ESEQ(
                             SEQ(
                              MOVE(
                               TEMP t128,
                               TEMP t109),
                              SEQ(
                               MOVE(
                                TEMP t129,
                                MEM(
                                 BINOP(PLUS,
                                  MEM(
                                   BINOP(PLUS,
                                    MEM(
                                     TEMP t100),
                                    CONST ~4)),
                                  CONST ~4))),
                               SEQ(
                                CJUMP(GE,
                                 TEMP t128,
                                 TEMP t129,
                                 L50,L51),
                                SEQ(
                                 LABEL L51,
                                 SEQ(
                                  CJUMP(LT,
                                   TEMP t128,
                                   CONST 0,
                                   L50,L52),
                                  SEQ(
                                   LABEL L50,
                                   SEQ(
                                    EXP(
                                     CALL(
                                      NAME exit,
                                       CONST 1)),
                                    LABEL L52))))))),
                             MEM(
                              BINOP(PLUS,
                               MEM(
                                BINOP(PLUS,
                                 MEM(
                                  TEMP t100),
                                 CONST ~4)),
                               BINOP(MUL,
                                TEMP t109,
                                CONST 4)))),
                            CONST 0),
                           ESEQ(
                            MOVE(
                             ESEQ(
                              SEQ(
                               MOVE(
                                TEMP t130,
                                BINOP(PLUS,
                                 TEMP t109,
                                 TEMP t103)),
                               SEQ(
                                MOVE(
                                 TEMP t131,
                                 MEM(
                                  BINOP(PLUS,
                                   MEM(
                                    BINOP(PLUS,
                                     MEM(
                                      TEMP t100),
                                     CONST ~12)),
                                   CONST ~4))),
                                SEQ(
                                 CJUMP(GE,
                                  TEMP t130,
                                  TEMP t131,
                                  L53,L54),
                                 SEQ(
                                  LABEL L54,
                                  SEQ(
                                   CJUMP(LT,
                                    TEMP t130,
                                    CONST 0,
                                    L53,L55),
                                   SEQ(
                                    LABEL L53,
                                    SEQ(
                                     EXP(
                                      CALL(
                                       NAME exit,
                                        CONST 1)),
                                     LABEL L55))))))),
                              MEM(
                               BINOP(PLUS,
                                MEM(
                                 BINOP(PLUS,
                                  MEM(
                                   TEMP t100),
                                  CONST ~12)),
                                BINOP(MUL,
                                 BINOP(PLUS,
                                  TEMP t109,
                                  TEMP t103),
                                 CONST 4)))),
                             CONST 0),
                            ESEQ(
                             MOVE(
                              ESEQ(
                               SEQ(
                                MOVE(
                                 TEMP t132,
                                 BINOP(MINUS,
                                  BINOP(PLUS,
                                   TEMP t109,
                                   CONST 7),
                                  TEMP t103)),
                                SEQ(
                                 MOVE(
                                  TEMP t133,
                                  MEM(
                                   BINOP(PLUS,
                                    MEM(
                                     BINOP(PLUS,
                                      MEM(
                                       TEMP t100),
                                      CONST ~16)),
                                    CONST ~4))),
                                 SEQ(
                                  CJUMP(GE,
                                   TEMP t132,
                                   TEMP t133,
                                   L56,L57),
                                  SEQ(
                                   LABEL L57,
                                   SEQ(
                                    CJUMP(LT,
                                     TEMP t132,
                                     CONST 0,
                                     L56,L58),
                                    SEQ(
                                     LABEL L56,
                                     SEQ(
                                      EXP(
                                       CALL(
                                        NAME exit,
                                         CONST 1)),
                                      LABEL L58))))))),
                               MEM(
                                BINOP(PLUS,
                                 MEM(
                                  BINOP(PLUS,
                                   MEM(
                                    TEMP t100),
                                   CONST ~16)),
                                 BINOP(MUL,
                                  BINOP(MINUS,
                                   BINOP(PLUS,
                                    TEMP t109,
                                    CONST 7),
                                   TEMP t103),
                                  CONST 4)))),
                              CONST 0),
                             CONST 0))))))))),
                    LABEL L60))),
                 SEQ(
                  CJUMP(LT,
                   TEMP t109,
                   BINOP(MINUS,
                    MEM(
                     BINOP(PLUS,
                      MEM(
                       TEMP t100),
                      CONST 0)),
                    CONST 1),
                   L62,L18),
                  LABEL L18))))))),
           CONST 0)),
         LABEL L65)))))),
   TEMP t134)))
# ----- linearize L2 -----
LABEL L2
CJUMP(EQ,
 TEMP t103,
 MEM(
  BINOP(PLUS,
   MEM(
    TEMP t100),
   CONST 0)),
 L63,L64)
LABEL L64
MOVE(
 TEMP t109,
 CONST 0)
CJUMP(LE,
 TEMP t109,
 BINOP(MINUS,
  MEM(
   BINOP(PLUS,
    MEM(
     TEMP t100),
    CONST 0)),
  CONST 1),
 L61,L18)
LABEL L18
MOVE(
 TEMP t134,
 CONST 0)
LABEL L65
MOVE(
 TEMP t106,
 TEMP t134)
JUMP(
 NAME L69)
LABEL L63
MOVE(
 TEMP t134,
 CALL(
  NAME L1,
   MEM(
    TEMP t100)))
JUMP(
 NAME L65)
LABEL L62
MOVE(
 TEMP t109,
 BINOP(PLUS,
  TEMP t109,
  CONST 1))
LABEL L61
MOVE(
 TEMP t110,
 TEMP t109)
MOVE(
 TEMP t111,
 MEM(
  BINOP(PLUS,
   MEM(
    BINOP(PLUS,
     MEM(
      TEMP t100),
     CONST ~4)),
   CONST ~4)))
CJUMP(GE,
 TEMP t110,
 TEMP t111,
 L19,L20)
LABEL L20
CJUMP(LT,
 TEMP t110,
 CONST 0,
 L19,L21)
LABEL L21
CJUMP(EQ,
 MEM(
  BINOP(PLUS,
   MEM(
    BINOP(PLUS,
     MEM(
      TEMP t100),
     CONST ~4)),
   BINOP(MUL,
    TEMP t109,
    CONST 4))),
 CONST 0,
 L27,L28)
LABEL L28
MOVE(
 TEMP t115,
 CONST 0)
LABEL L29
CJUMP(NE,
 TEMP t115,
 CONST 0,
 L35,L36)
LABEL L36
MOVE(
 TEMP t119,
 CONST 0)
LABEL L37
CJUMP(NE,
 TEMP t119,
 CONST 0,
 L59,L60)
LABEL L60
CJUMP(LT,
 TEMP t109,
 BINOP(MINUS,
  MEM(
   BINOP(PLUS,
    MEM(
     TEMP t100),
    CONST 0)),
  CONST 1),
 L62,L70)
LABEL L70
JUMP(
 NAME L18)
LABEL L19
EXP(
 CALL(
  NAME exit,
   CONST 1))
JUMP(
 NAME L21)
LABEL L27
MOVE(
 TEMP t114,
 CONST 1)
MOVE(
 TEMP t112,
 BINOP(PLUS,
  TEMP t109,
  TEMP t103))
MOVE(
 TEMP t113,
 MEM(
  BINOP(PLUS,
   MEM(
    BINOP(PLUS,
     MEM(
      TEMP t100),
     CONST ~12)),
   CONST ~4)))
CJUMP(GE,
 TEMP t112,
 TEMP t113,
 L22,L23)
LABEL L23
CJUMP(LT,
 TEMP t112,
 CONST 0,
 L22,L24)
LABEL L24
CJUMP(EQ,
 MEM(
  BINOP(PLUS,
   MEM(
    BINOP(PLUS,
     MEM(
      TEMP t100),
     CONST ~12)),
   BINOP(MUL,
    BINOP(PLUS,
     TEMP t109,
     TEMP t103),
    CONST 4))),
 CONST 0,
 L25,L26)
LABEL L26
MOVE(
 TEMP t114,
 CONST 0)
LABEL L25
MOVE(
 TEMP t115,
 TEMP t114)
JUMP(
 NAME L29)
LABEL L22
EXP(
 CALL(
  NAME exit,
   CONST 1))
JUMP(
 NAME L24)
LABEL L35
MOVE(
 TEMP t118,
 CONST 1)
MOVE(
 TEMP t116,
 BINOP(MINUS,
  BINOP(PLUS,
   TEMP t109,
   CONST 7),
  TEMP t103))
MOVE(
 TEMP t117,
 MEM(
  BINOP(PLUS,
   MEM(
    BINOP(PLUS,
     MEM(
      TEMP t100),
     CONST ~16)),
   CONST ~4)))
CJUMP(GE,
 TEMP t116,
 TEMP t117,
 L30,L31)
LABEL L31
CJUMP(LT,
 TEMP t116,
 CONST 0,
 L30,L32)
LABEL L32
CJUMP(EQ,
 MEM(
  BINOP(PLUS,
   MEM(
    BINOP(PLUS,
     MEM(
      TEMP t100),
     CONST ~16)),
   BINOP(MUL,
    BINOP(MINUS,
     BINOP(PLUS,
      TEMP t109,
      CONST 7),
     TEMP t103),
    CONST 4))),
 CONST 0,
 L33,L34)
LABEL L34
MOVE(
 TEMP t118,
 CONST 0)
LABEL L33
MOVE(
 TEMP t119,
 TEMP t118)
JUMP(
 NAME L37)
LABEL L30
EXP(
 CALL(
  NAME exit,
   CONST 1))
JUMP(
 NAME L32)
LABEL L59
MOVE(
 TEMP t120,
 TEMP t109)
MOVE(
 TEMP t121,
 MEM(
  BINOP(PLUS,
   MEM(
    BINOP(PLUS,
     MEM(
      TEMP t100),
     CONST ~4)),
   CONST ~4)))
CJUMP(GE,
 TEMP t120,
 TEMP t121,
 L38,L39)
LABEL L39
CJUMP(LT,
 TEMP t120,
 CONST 0,
 L38,L40)
LABEL L40
MOVE(
 MEM(
  BINOP(PLUS,
   MEM(
    BINOP(PLUS,
     MEM(
      TEMP t100),
     CONST ~4)),
   BINOP(MUL,
    TEMP t109,
    CONST 4))),
 CONST 1)
MOVE(
 TEMP t122,
 BINOP(PLUS,
  TEMP t109,
  TEMP t103))
MOVE(
 TEMP t123,
 MEM(
  BINOP(PLUS,
   MEM(
    BINOP(PLUS,
     MEM(
      TEMP t100),
     CONST ~12)),
   CONST ~4)))
CJUMP(GE,
 TEMP t122,
 TEMP t123,
 L41,L42)
LABEL L42
CJUMP(LT,
 TEMP t122,
 CONST 0,
 L41,L43)
LABEL L43
MOVE(
 MEM(
  BINOP(PLUS,
   MEM(
    BINOP(PLUS,
     MEM(
      TEMP t100),
     CONST ~12)),
   BINOP(MUL,
    BINOP(PLUS,
     TEMP t109,
     TEMP t103),
    CONST 4))),
 CONST 1)
MOVE(
 TEMP t124,
 BINOP(MINUS,
  BINOP(PLUS,
   TEMP t109,
   CONST 7),
  TEMP t103))
MOVE(
 TEMP t125,
 MEM(
  BINOP(PLUS,
   MEM(
    BINOP(PLUS,
     MEM(
      TEMP t100),
     CONST ~16)),
   CONST ~4)))
CJUMP(GE,
 TEMP t124,
 TEMP t125,
 L44,L45)
LABEL L45
CJUMP(LT,
 TEMP t124,
 CONST 0,
 L44,L46)
LABEL L46
MOVE(
 MEM(
  BINOP(PLUS,
   MEM(
    BINOP(PLUS,
     MEM(
      TEMP t100),
     CONST ~16)),
   BINOP(MUL,
    BINOP(MINUS,
     BINOP(PLUS,
      TEMP t109,
      CONST 7),
     TEMP t103),
    CONST 4))),
 CONST 1)
MOVE(
 TEMP t126,
 TEMP t103)
MOVE(
 TEMP t127,
 MEM(
  BINOP(PLUS,
   MEM(
    BINOP(PLUS,
     MEM(
      TEMP t100),
     CONST ~8)),
   CONST ~4)))
CJUMP(GE,
 TEMP t126,
 TEMP t127,
 L47,L48)
LABEL L48
CJUMP(LT,
 TEMP t126,
 CONST 0,
 L47,L49)
LABEL L49
MOVE(
 MEM(
  BINOP(PLUS,
   MEM(
    BINOP(PLUS,
     MEM(
      TEMP t100),
     CONST ~8)),
   BINOP(MUL,
    TEMP t103,
    CONST 4))),
 TEMP t109)
EXP(
 CALL(
  NAME L2,
   MEM(
    TEMP t100),
   BINOP(PLUS,
    TEMP t103,
    CONST 1)))
MOVE(
 TEMP t128,
 TEMP t109)
MOVE(
 TEMP t129,
 MEM(
  BINOP(PLUS,
   MEM(
    BINOP(PLUS,
     MEM(
      TEMP t100),
     CONST ~4)),
   CONST ~4)))
CJUMP(GE,
 TEMP t128,
 TEMP t129,
 L50,L51)
LABEL L51
CJUMP(LT,
 TEMP t128,
 CONST 0,
 L50,L52)
LABEL L52
MOVE(
 MEM(
  BINOP(PLUS,
   MEM(
    BINOP(PLUS,
     MEM(
      TEMP t100),
     CONST ~4)),
   BINOP(MUL,
    TEMP t109,
    CONST 4))),
 CONST 0)
MOVE(
 TEMP t130,
 BINOP(PLUS,
  TEMP t109,
  TEMP t103))
MOVE(
 TEMP t131,
 MEM(
  BINOP(PLUS,
   MEM(
    BINOP(PLUS,
     MEM(
      TEMP t100),
     CONST ~12)),
   CONST ~4)))
CJUMP(GE,
 TEMP t130,
 TEMP t131,
 L53,L54)
LABEL L54
CJUMP(LT,
 TEMP t130,
 CONST 0,
 L53,L55)
LABEL L55
MOVE(
 MEM(
  BINOP(PLUS,
   MEM(
    BINOP(PLUS,
     MEM(
      TEMP t100),
     CONST ~12)),
   BINOP(MUL,
    BINOP(PLUS,
     TEMP t109,
     TEMP t103),
    CONST 4))),
 CONST 0)
MOVE(
 TEMP t132,
 BINOP(MINUS,
  BINOP(PLUS,
   TEMP t109,
   CONST 7),
  TEMP t103))
MOVE(
 TEMP t133,
 MEM(
  BINOP(PLUS,
   MEM(
    BINOP(PLUS,
     MEM(
      TEMP t100),
     CONST ~16)),
   CONST ~4)))
CJUMP(GE,
 TEMP t132,
 TEMP t133,
 L56,L57)
LABEL L57
CJUMP(LT,
 TEMP t132,
 CONST 0,
 L56,L58)
LABEL L58
MOVE(
 MEM(
  BINOP(PLUS,
   MEM(
    BINOP(PLUS,
     MEM(
      TEMP t100),
     CONST ~16)),
   BINOP(MUL,
    BINOP(MINUS,
     BINOP(PLUS,
      TEMP t109,
      CONST 7),
     TEMP t103),
    CONST 4))),
 CONST 0)
JUMP(
 NAME L60)
LABEL L38
EXP(
 CALL(
  NAME exit,
   CONST 1))
JUMP(
 NAME L40)
LABEL L41
EXP(
 CALL(
  NAME exit,
   CONST 1))
JUMP(
 NAME L43)
LABEL L44
EXP(
 CALL(
  NAME exit,
   CONST 1))
JUMP(
 NAME L46)
LABEL L47
EXP(
 CALL(
  NAME exit,
   CONST 1))
JUMP(
 NAME L49)
LABEL L50
EXP(
 CALL(
  NAME exit,
   CONST 1))
JUMP(
 NAME L52)
LABEL L53
EXP(
 CALL(
  NAME exit,
   CONST 1))
JUMP(
 NAME L55)
LABEL L56
EXP(
 CALL(
  NAME exit,
   CONST 1))
JUMP(
 NAME L58)
LABEL L69
# ----- Assembly L2 -----
L2:
lw t166, 0(t100)
lw t165, 0(t166)
beq t103, t165, L63
L64:
addi t167, $0, 0
add t109, t167, $0
lw t170, 0(t100)
lw t169, 0(t170)
addi t168, t169, -1
ble t109, t168, L61
L18:
addi t171, $0, 0
add t134, t171, $0
L65:
add t106, t134, $0
j L69 
L63:
lw t172, 0(t100)
add t108, t172, $0
jal L1 
add t134, t106, $0
j L65 
L62:
addi t173, t109, 1
add t109, t173, $0
L61:
add t110, t109, $0
lw t176, 0(t100)
lw t175, -4(t176)
lw t174, -4(t175)
add t111, t174, $0
bge t110, t111, L19
L20:
blt t110, 0, L19
L21:
lw t180, 0(t100)
lw t179, -4(t180)
addi t182, $0, 4
mul t181, t109, t182
add t178, t179, t181
lw t177, 0(t178)
beq t177, 0, L27
L28:
addi t183, $0, 0
add t115, t183, $0
L29:
bne t115, 0, L35
L36:
addi t184, $0, 0
add t119, t184, $0
L37:
bne t119, 0, L59
L60:
lw t187, 0(t100)
lw t186, 0(t187)
addi t185, t186, -1
blt t109, t185, L62
L70:
j L18 
L19:
addi t188, $0, 1
add t108, t188, $0
jal exit 
j L21 
L27:
addi t189, $0, 1
add t114, t189, $0
add t190, t109, t103
add t112, t190, $0
lw t193, 0(t100)
lw t192, -12(t193)
lw t191, -4(t192)
add t113, t191, $0
bge t112, t113, L22
L23:
blt t112, 0, L22
L24:
lw t197, 0(t100)
lw t196, -12(t197)
add t199, t109, t103
addi t200, $0, 4
mul t198, t199, t200
add t195, t196, t198
lw t194, 0(t195)
beq t194, 0, L25
L26:
addi t201, $0, 0
add t114, t201, $0
L25:
add t115, t114, $0
j L29 
L22:
addi t202, $0, 1
add t108, t202, $0
jal exit 
j L24 
L35:
addi t203, $0, 1
add t118, t203, $0
addi t205, t109, 7
sub t204, t205, t103
add t116, t204, $0
lw t208, 0(t100)
lw t207, -16(t208)
lw t206, -4(t207)
add t117, t206, $0
bge t116, t117, L30
L31:
blt t116, 0, L30
L32:
lw t212, 0(t100)
lw t211, -16(t212)
addi t215, t109, 7
sub t214, t215, t103
addi t216, $0, 4
mul t213, t214, t216
add t210, t211, t213
lw t209, 0(t210)
beq t209, 0, L33
L34:
addi t217, $0, 0
add t118, t217, $0
L33:
add t119, t118, $0
j L37 
L30:
addi t218, $0, 1
add t108, t218, $0
jal exit 
j L32 
L59:
add t120, t109, $0
lw t221, 0(t100)
lw t220, -4(t221)
lw t219, -4(t220)
add t121, t219, $0
bge t120, t121, L38
L39:
blt t120, 0, L38
L40:
lw t224, 0(t100)
lw t223, -4(t224)
addi t226, $0, 4
mul t225, t109, t226
add t222, t223, t225
addi t227, $0, 1
sw t222, 0(t227)
add t228, t109, t103
add t122, t228, $0
lw t231, 0(t100)
lw t230, -12(t231)
lw t229, -4(t230)
add t123, t229, $0
bge t122, t123, L41
L42:
blt t122, 0, L41
L43:
lw t234, 0(t100)
lw t233, -12(t234)
add t236, t109, t103
addi t237, $0, 4
mul t235, t236, t237
add t232, t233, t235
addi t238, $0, 1
sw t232, 0(t238)
addi t240, t109, 7
sub t239, t240, t103
add t124, t239, $0
lw t243, 0(t100)
lw t242, -16(t243)
lw t241, -4(t242)
add t125, t241, $0
bge t124, t125, L44
L45:
blt t124, 0, L44
L46:
lw t246, 0(t100)
lw t245, -16(t246)
addi t249, t109, 7
sub t248, t249, t103
addi t250, $0, 4
mul t247, t248, t250
add t244, t245, t247
addi t251, $0, 1
sw t244, 0(t251)
add t126, t103, $0
lw t254, 0(t100)
lw t253, -8(t254)
lw t252, -4(t253)
add t127, t252, $0
bge t126, t127, L47
L48:
blt t126, 0, L47
L49:
lw t257, 0(t100)
lw t256, -8(t257)
addi t259, $0, 4
mul t258, t103, t259
add t255, t256, t258
sw t255, 0(t109)
lw t260, 0(t100)
add t108, t260, $0
addi t261, t103, 1
add t109, t261, $0
jal L2 
add t128, t109, $0
lw t264, 0(t100)
lw t263, -4(t264)
lw t262, -4(t263)
add t129, t262, $0
bge t128, t129, L50
L51:
blt t128, 0, L50
L52:
lw t267, 0(t100)
lw t266, -4(t267)
addi t269, $0, 4
mul t268, t109, t269
add t265, t266, t268
addi t270, $0, 0
sw t265, 0(t270)
add t271, t109, t103
add t130, t271, $0
lw t274, 0(t100)
lw t273, -12(t274)
lw t272, -4(t273)
add t131, t272, $0
bge t130, t131, L53
L54:
blt t130, 0, L53
L55:
lw t277, 0(t100)
lw t276, -12(t277)
add t279, t109, t103
addi t280, $0, 4
mul t278, t279, t280
add t275, t276, t278
addi t281, $0, 0
sw t275, 0(t281)
addi t283, t109, 7
sub t282, t283, t103
add t132, t282, $0
lw t286, 0(t100)
lw t285, -16(t286)
lw t284, -4(t285)
add t133, t284, $0
bge t132, t133, L56
L57:
blt t132, 0, L56
L58:
lw t289, 0(t100)
lw t288, -16(t289)
addi t292, t109, 7
sub t291, t292, t103
addi t293, $0, 4
mul t290, t291, t293
add t287, t288, t290
addi t294, $0, 0
sw t287, 0(t294)
j L60 
L38:
addi t295, $0, 1
add t108, t295, $0
jal exit 
j L40 
L41:
addi t296, $0, 1
add t108, t296, $0
jal exit 
j L43 
L44:
addi t297, $0, 1
add t108, t297, $0
jal exit 
j L46 
L47:
addi t298, $0, 1
add t108, t298, $0
jal exit 
j L49 
L50:
addi t299, $0, 1
add t108, t299, $0
jal exit 
j L52 
L53:
addi t300, $0, 1
add t108, t300, $0
jal exit 
j L55 
L56:
addi t301, $0, 1
add t108, t301, $0
jal exit 
j L58 
L69:
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
     CONST 8),
    SEQ(
     MOVE(
      MEM(
       BINOP(PLUS,
        TEMP t100,
        CONST ~4)),
      CALL(
       NAME initArray,
        MEM(
         BINOP(PLUS,
          TEMP t100,
          CONST 0)),
        CONST 0)),
     SEQ(
      MOVE(
       MEM(
        BINOP(PLUS,
         TEMP t100,
         CONST ~8)),
       CALL(
        NAME initArray,
         MEM(
          BINOP(PLUS,
           TEMP t100,
           CONST 0)),
         CONST 0)),
      SEQ(
       MOVE(
        MEM(
         BINOP(PLUS,
          TEMP t100,
          CONST ~12)),
        CALL(
         NAME initArray,
          BINOP(MINUS,
           BINOP(PLUS,
            MEM(
             BINOP(PLUS,
              TEMP t100,
              CONST 0)),
            MEM(
             BINOP(PLUS,
              TEMP t100,
              CONST 0))),
           CONST 1),
          CONST 0)),
       MOVE(
        MEM(
         BINOP(PLUS,
          TEMP t100,
          CONST ~16)),
        CALL(
         NAME initArray,
          BINOP(MINUS,
           BINOP(PLUS,
            MEM(
             BINOP(PLUS,
              TEMP t100,
              CONST 0)),
            MEM(
             BINOP(PLUS,
              TEMP t100,
              CONST 0))),
           CONST 1),
          CONST 0)))))),
   CALL(
    NAME L2,
     TEMP t100,
     CONST 0))))
# ----- linearize L0 -----
LABEL L0
MOVE(
 MEM(
  BINOP(PLUS,
   TEMP t100,
   CONST 0)),
 CONST 8)
MOVE(
 TEMP t303,
 BINOP(PLUS,
  TEMP t100,
  CONST ~4))
MOVE(
 TEMP t302,
 CALL(
  NAME initArray,
   MEM(
    BINOP(PLUS,
     TEMP t100,
     CONST 0)),
   CONST 0))
MOVE(
 MEM(
  TEMP t303),
 TEMP t302)
MOVE(
 TEMP t305,
 BINOP(PLUS,
  TEMP t100,
  CONST ~8))
MOVE(
 TEMP t304,
 CALL(
  NAME initArray,
   MEM(
    BINOP(PLUS,
     TEMP t100,
     CONST 0)),
   CONST 0))
MOVE(
 MEM(
  TEMP t305),
 TEMP t304)
MOVE(
 TEMP t307,
 BINOP(PLUS,
  TEMP t100,
  CONST ~12))
MOVE(
 TEMP t306,
 CALL(
  NAME initArray,
   BINOP(MINUS,
    BINOP(PLUS,
     MEM(
      BINOP(PLUS,
       TEMP t100,
       CONST 0)),
     MEM(
      BINOP(PLUS,
       TEMP t100,
       CONST 0))),
    CONST 1),
   CONST 0))
MOVE(
 MEM(
  TEMP t307),
 TEMP t306)
MOVE(
 TEMP t309,
 BINOP(PLUS,
  TEMP t100,
  CONST ~16))
MOVE(
 TEMP t308,
 CALL(
  NAME initArray,
   BINOP(MINUS,
    BINOP(PLUS,
     MEM(
      BINOP(PLUS,
       TEMP t100,
       CONST 0)),
     MEM(
      BINOP(PLUS,
       TEMP t100,
       CONST 0))),
    CONST 1),
   CONST 0))
MOVE(
 MEM(
  TEMP t309),
 TEMP t308)
MOVE(
 TEMP t106,
 CALL(
  NAME L2,
   TEMP t100,
   CONST 0))
JUMP(
 NAME L71)
LABEL L71
# ----- Assembly L0 -----
L0:
addi t310, $0, 8
sw t310, 0(t100)
addi t311, t100, -4
add t303, t311, $0
lw t312, 0(t100)
add t108, t312, $0
addi t313, $0, 0
add t109, t313, $0
jal initArray 
add t302, t106, $0
sw t303, 0(t302)
addi t314, t100, -8
add t305, t314, $0
lw t315, 0(t100)
add t108, t315, $0
addi t316, $0, 0
add t109, t316, $0
jal initArray 
add t304, t106, $0
sw t305, 0(t304)
addi t317, t100, -12
add t307, t317, $0
lw t320, 0(t100)
lw t321, 0(t100)
add t319, t320, t321
addi t318, t319, -1
add t108, t318, $0
addi t322, $0, 0
add t109, t322, $0
jal initArray 
add t306, t106, $0
sw t307, 0(t306)
addi t323, t100, -16
add t309, t323, $0
lw t326, 0(t100)
lw t327, 0(t100)
add t325, t326, t327
addi t324, t325, -1
add t108, t324, $0
addi t328, $0, 0
add t109, t328, $0
jal initArray 
add t308, t106, $0
sw t309, 0(t308)
add t108, t100, $0
addi t329, $0, 0
add t109, t329, $0
jal L2 
add t106, t106, $0
j L71 
L71:
