L1 : .ascii aname 
L2 : .ascii somewhere 
L3 : .ascii  
L4 : .ascii Kapoios 
L5 : .ascii Kapou 
L6 : .ascii Allos 
L16 : .ascii kati 
L23 : .ascii sfd 
L24 : .ascii sdf 
# ----- emit L0 -----
# ----- translated L0 -----
SEQ(
 LABEL L0,
 MOVE(
  TEMP t106,
  ESEQ(
   SEQ(
    MOVE(
     TEMP t101,
     CALL(
      NAME initArray,
       CONST 10,
       CONST 0)),
    SEQ(
     MOVE(
      TEMP t103,
      CALL(
       NAME initArray,
        CONST 5,
        ESEQ(
         SEQ(
          MOVE(
           TEMP t102,
           CALL(
            NAME malloc,
             CONST 16)),
          SEQ(
           MOVE(
            MEM(
             BINOP(PLUS,
              TEMP t102,
              CONST 0)),
            NAME L1),
           SEQ(
            MOVE(
             MEM(
              BINOP(PLUS,
               TEMP t102,
               CONST 4)),
             NAME L2),
            SEQ(
             MOVE(
              MEM(
               BINOP(PLUS,
                TEMP t102,
                CONST 8)),
              CONST 0),
             SEQ(
              MOVE(
               MEM(
                BINOP(PLUS,
                 TEMP t102,
                 CONST 12)),
               CONST 0),
              EXP(
               CONST 0)))))),
         TEMP t102))),
     SEQ(
      MOVE(
       TEMP t104,
       CALL(
        NAME initArray,
         CONST 100,
         NAME L3)),
      SEQ(
       MOVE(
        TEMP t106,
        ESEQ(
         SEQ(
          MOVE(
           TEMP t105,
           CALL(
            NAME malloc,
             CONST 16)),
          SEQ(
           MOVE(
            MEM(
             BINOP(PLUS,
              TEMP t105,
              CONST 0)),
            NAME L4),
           SEQ(
            MOVE(
             MEM(
              BINOP(PLUS,
               TEMP t105,
               CONST 4)),
             NAME L5),
            SEQ(
             MOVE(
              MEM(
               BINOP(PLUS,
                TEMP t105,
                CONST 8)),
              CONST 2432),
             SEQ(
              MOVE(
               MEM(
                BINOP(PLUS,
                 TEMP t105,
                 CONST 12)),
               CONST 44),
              EXP(
               CONST 0)))))),
         TEMP t105)),
       MOVE(
        TEMP t108,
        ESEQ(
         SEQ(
          MOVE(
           TEMP t107,
           CALL(
            NAME malloc,
             CONST 8)),
          SEQ(
           MOVE(
            MEM(
             BINOP(PLUS,
              TEMP t107,
              CONST 0)),
            NAME L6),
           SEQ(
            MOVE(
             MEM(
              BINOP(PLUS,
               TEMP t107,
               CONST 4)),
             CALL(
              NAME initArray,
               CONST 3,
               CONST 1900)),
            EXP(
             CONST 0)))),
         TEMP t107)))))),
   ESEQ(
    MOVE(
     ESEQ(
      SEQ(
       MOVE(
        TEMP t109,
        CONST 0),
       SEQ(
        MOVE(
         TEMP t110,
         MEM(
          BINOP(PLUS,
           TEMP t101,
           CONST ~4))),
        SEQ(
         CJUMP(GE,
          TEMP t109,
          TEMP t110,
          L7,L8),
         SEQ(
          LABEL L8,
          SEQ(
           CJUMP(LT,
            TEMP t109,
            CONST 0,
            L7,L9),
           SEQ(
            LABEL L7,
            SEQ(
             EXP(
              CALL(
               NAME exit,
                CONST 1)),
             LABEL L9))))))),
      MEM(
       BINOP(PLUS,
        TEMP t101,
        BINOP(MUL,
         CONST 0,
         CONST 4)))),
     CONST 1),
    ESEQ(
     MOVE(
      ESEQ(
       SEQ(
        MOVE(
         TEMP t111,
         CONST 9),
        SEQ(
         MOVE(
          TEMP t112,
          MEM(
           BINOP(PLUS,
            TEMP t101,
            CONST ~4))),
         SEQ(
          CJUMP(GE,
           TEMP t111,
           TEMP t112,
           L10,L11),
          SEQ(
           LABEL L11,
           SEQ(
            CJUMP(LT,
             TEMP t111,
             CONST 0,
             L10,L12),
            SEQ(
             LABEL L10,
             SEQ(
              EXP(
               CALL(
                NAME exit,
                 CONST 1)),
              LABEL L12))))))),
       MEM(
        BINOP(PLUS,
         TEMP t101,
         BINOP(MUL,
          CONST 9,
          CONST 4)))),
      CONST 3),
     ESEQ(
      MOVE(
       MEM(
        ESEQ(
         SEQ(
          MOVE(
           TEMP t113,
           CONST 3),
          SEQ(
           MOVE(
            TEMP t114,
            MEM(
             BINOP(PLUS,
              TEMP t103,
              CONST ~4))),
           SEQ(
            CJUMP(GE,
             TEMP t113,
             TEMP t114,
             L13,L14),
            SEQ(
             LABEL L14,
             SEQ(
              CJUMP(LT,
               TEMP t113,
               CONST 0,
               L13,L15),
              SEQ(
               LABEL L13,
               SEQ(
                EXP(
                 CALL(
                  NAME exit,
                   CONST 1)),
                LABEL L15))))))),
         MEM(
          BINOP(PLUS,
           TEMP t103,
           BINOP(MUL,
            CONST 3,
            CONST 4))))),
       NAME L16),
      ESEQ(
       MOVE(
        MEM(
         BINOP(PLUS,
          ESEQ(
           SEQ(
            MOVE(
             TEMP t115,
             CONST 1),
            SEQ(
             MOVE(
              TEMP t116,
              MEM(
               BINOP(PLUS,
                TEMP t103,
                CONST ~4))),
             SEQ(
              CJUMP(GE,
               TEMP t115,
               TEMP t116,
               L17,L18),
              SEQ(
               LABEL L18,
               SEQ(
                CJUMP(LT,
                 TEMP t115,
                 CONST 0,
                 L17,L19),
                SEQ(
                 LABEL L17,
                 SEQ(
                  EXP(
                   CALL(
                    NAME exit,
                     CONST 1)),
                  LABEL L19))))))),
           MEM(
            BINOP(PLUS,
             TEMP t103,
             BINOP(MUL,
              CONST 1,
              CONST 4)))),
          CONST 12)),
        CONST 23),
       ESEQ(
        MOVE(
         ESEQ(
          SEQ(
           MOVE(
            TEMP t117,
            CONST 34),
           SEQ(
            MOVE(
             TEMP t118,
             MEM(
              BINOP(PLUS,
               TEMP t104,
               CONST ~4))),
            SEQ(
             CJUMP(GE,
              TEMP t117,
              TEMP t118,
              L20,L21),
             SEQ(
              LABEL L21,
              SEQ(
               CJUMP(LT,
                TEMP t117,
                CONST 0,
                L20,L22),
               SEQ(
                LABEL L20,
                SEQ(
                 EXP(
                  CALL(
                   NAME exit,
                    CONST 1)),
                 LABEL L22))))))),
          MEM(
           BINOP(PLUS,
            TEMP t104,
            BINOP(MUL,
             CONST 34,
             CONST 4)))),
         NAME L23),
        ESEQ(
         MOVE(
          MEM(
           TEMP t106),
          NAME L24),
         ESEQ(
          MOVE(
           ESEQ(
            SEQ(
             MOVE(
              TEMP t119,
              CONST 0),
             SEQ(
              MOVE(
               TEMP t120,
               MEM(
                BINOP(PLUS,
                 MEM(
                  BINOP(PLUS,
                   TEMP t108,
                   CONST 4)),
                 CONST ~4))),
              SEQ(
               CJUMP(GE,
                TEMP t119,
                TEMP t120,
                L25,L26),
               SEQ(
                LABEL L26,
                SEQ(
                 CJUMP(LT,
                  TEMP t119,
                  CONST 0,
                  L25,L27),
                 SEQ(
                  LABEL L25,
                  SEQ(
                   EXP(
                    CALL(
                     NAME exit,
                      CONST 1)),
                   LABEL L27))))))),
            MEM(
             BINOP(PLUS,
              MEM(
               BINOP(PLUS,
                TEMP t108,
                CONST 4)),
              BINOP(MUL,
               CONST 0,
               CONST 4)))),
           CONST 2323),
          ESEQ(
           MOVE(
            ESEQ(
             SEQ(
              MOVE(
               TEMP t121,
               CONST 2),
              SEQ(
               MOVE(
                TEMP t122,
                MEM(
                 BINOP(PLUS,
                  MEM(
                   BINOP(PLUS,
                    TEMP t108,
                    CONST 4)),
                  CONST ~4))),
               SEQ(
                CJUMP(GE,
                 TEMP t121,
                 TEMP t122,
                 L28,L29),
                SEQ(
                 LABEL L29,
                 SEQ(
                  CJUMP(LT,
                   TEMP t121,
                   CONST 0,
                   L28,L30),
                  SEQ(
                   LABEL L28,
                   SEQ(
                    EXP(
                     CALL(
                      NAME exit,
                       CONST 1)),
                    LABEL L30))))))),
             MEM(
              BINOP(PLUS,
               MEM(
                BINOP(PLUS,
                 TEMP t108,
                 CONST 4)),
               BINOP(MUL,
                CONST 2,
                CONST 4)))),
            CONST 2323),
           CONST 0)))))))))))
# ----- linearize L0 -----
LABEL L0
MOVE(
 TEMP t101,
 CALL(
  NAME initArray,
   CONST 10,
   CONST 0))
MOVE(
 TEMP t102,
 CALL(
  NAME malloc,
   CONST 16))
MOVE(
 MEM(
  BINOP(PLUS,
   TEMP t102,
   CONST 0)),
 NAME L1)
MOVE(
 MEM(
  BINOP(PLUS,
   TEMP t102,
   CONST 4)),
 NAME L2)
MOVE(
 MEM(
  BINOP(PLUS,
   TEMP t102,
   CONST 8)),
 CONST 0)
MOVE(
 MEM(
  BINOP(PLUS,
   TEMP t102,
   CONST 12)),
 CONST 0)
MOVE(
 TEMP t103,
 CALL(
  NAME initArray,
   CONST 5,
   TEMP t102))
MOVE(
 TEMP t104,
 CALL(
  NAME initArray,
   CONST 100,
   NAME L3))
MOVE(
 TEMP t105,
 CALL(
  NAME malloc,
   CONST 16))
MOVE(
 MEM(
  BINOP(PLUS,
   TEMP t105,
   CONST 0)),
 NAME L4)
MOVE(
 MEM(
  BINOP(PLUS,
   TEMP t105,
   CONST 4)),
 NAME L5)
MOVE(
 MEM(
  BINOP(PLUS,
   TEMP t105,
   CONST 8)),
 CONST 2432)
MOVE(
 MEM(
  BINOP(PLUS,
   TEMP t105,
   CONST 12)),
 CONST 44)
MOVE(
 TEMP t106,
 TEMP t105)
MOVE(
 TEMP t107,
 CALL(
  NAME malloc,
   CONST 8))
MOVE(
 MEM(
  BINOP(PLUS,
   TEMP t107,
   CONST 0)),
 NAME L6)
MOVE(
 TEMP t124,
 BINOP(PLUS,
  TEMP t107,
  CONST 4))
MOVE(
 TEMP t123,
 CALL(
  NAME initArray,
   CONST 3,
   CONST 1900))
MOVE(
 MEM(
  TEMP t124),
 TEMP t123)
MOVE(
 TEMP t108,
 TEMP t107)
MOVE(
 TEMP t109,
 CONST 0)
MOVE(
 TEMP t110,
 MEM(
  BINOP(PLUS,
   TEMP t101,
   CONST ~4)))
CJUMP(GE,
 TEMP t109,
 TEMP t110,
 L7,L8)
LABEL L8
CJUMP(LT,
 TEMP t109,
 CONST 0,
 L7,L9)
LABEL L9
MOVE(
 MEM(
  BINOP(PLUS,
   TEMP t101,
   BINOP(MUL,
    CONST 0,
    CONST 4))),
 CONST 1)
MOVE(
 TEMP t111,
 CONST 9)
MOVE(
 TEMP t112,
 MEM(
  BINOP(PLUS,
   TEMP t101,
   CONST ~4)))
CJUMP(GE,
 TEMP t111,
 TEMP t112,
 L10,L11)
LABEL L11
CJUMP(LT,
 TEMP t111,
 CONST 0,
 L10,L12)
LABEL L12
MOVE(
 MEM(
  BINOP(PLUS,
   TEMP t101,
   BINOP(MUL,
    CONST 9,
    CONST 4))),
 CONST 3)
MOVE(
 TEMP t113,
 CONST 3)
MOVE(
 TEMP t114,
 MEM(
  BINOP(PLUS,
   TEMP t103,
   CONST ~4)))
CJUMP(GE,
 TEMP t113,
 TEMP t114,
 L13,L14)
LABEL L14
CJUMP(LT,
 TEMP t113,
 CONST 0,
 L13,L15)
LABEL L15
MOVE(
 MEM(
  MEM(
   BINOP(PLUS,
    TEMP t103,
    BINOP(MUL,
     CONST 3,
     CONST 4)))),
 NAME L16)
MOVE(
 TEMP t115,
 CONST 1)
MOVE(
 TEMP t116,
 MEM(
  BINOP(PLUS,
   TEMP t103,
   CONST ~4)))
CJUMP(GE,
 TEMP t115,
 TEMP t116,
 L17,L18)
LABEL L18
CJUMP(LT,
 TEMP t115,
 CONST 0,
 L17,L19)
LABEL L19
MOVE(
 MEM(
  BINOP(PLUS,
   MEM(
    BINOP(PLUS,
     TEMP t103,
     BINOP(MUL,
      CONST 1,
      CONST 4))),
   CONST 12)),
 CONST 23)
MOVE(
 TEMP t117,
 CONST 34)
MOVE(
 TEMP t118,
 MEM(
  BINOP(PLUS,
   TEMP t104,
   CONST ~4)))
CJUMP(GE,
 TEMP t117,
 TEMP t118,
 L20,L21)
LABEL L21
CJUMP(LT,
 TEMP t117,
 CONST 0,
 L20,L22)
LABEL L22
MOVE(
 MEM(
  BINOP(PLUS,
   TEMP t104,
   BINOP(MUL,
    CONST 34,
    CONST 4))),
 NAME L23)
MOVE(
 MEM(
  TEMP t106),
 NAME L24)
MOVE(
 TEMP t119,
 CONST 0)
MOVE(
 TEMP t120,
 MEM(
  BINOP(PLUS,
   MEM(
    BINOP(PLUS,
     TEMP t108,
     CONST 4)),
   CONST ~4)))
CJUMP(GE,
 TEMP t119,
 TEMP t120,
 L25,L26)
LABEL L26
CJUMP(LT,
 TEMP t119,
 CONST 0,
 L25,L27)
LABEL L27
MOVE(
 MEM(
  BINOP(PLUS,
   MEM(
    BINOP(PLUS,
     TEMP t108,
     CONST 4)),
   BINOP(MUL,
    CONST 0,
    CONST 4))),
 CONST 2323)
MOVE(
 TEMP t121,
 CONST 2)
MOVE(
 TEMP t122,
 MEM(
  BINOP(PLUS,
   MEM(
    BINOP(PLUS,
     TEMP t108,
     CONST 4)),
   CONST ~4)))
CJUMP(GE,
 TEMP t121,
 TEMP t122,
 L28,L29)
LABEL L29
CJUMP(LT,
 TEMP t121,
 CONST 0,
 L28,L30)
LABEL L30
MOVE(
 MEM(
  BINOP(PLUS,
   MEM(
    BINOP(PLUS,
     TEMP t108,
     CONST 4)),
   BINOP(MUL,
    CONST 2,
    CONST 4))),
 CONST 2323)
MOVE(
 TEMP t106,
 CONST 0)
JUMP(
 NAME L31)
LABEL L7
EXP(
 CALL(
  NAME exit,
   CONST 1))
JUMP(
 NAME L9)
LABEL L10
EXP(
 CALL(
  NAME exit,
   CONST 1))
JUMP(
 NAME L12)
LABEL L13
EXP(
 CALL(
  NAME exit,
   CONST 1))
JUMP(
 NAME L15)
LABEL L17
EXP(
 CALL(
  NAME exit,
   CONST 1))
JUMP(
 NAME L19)
LABEL L20
EXP(
 CALL(
  NAME exit,
   CONST 1))
JUMP(
 NAME L22)
LABEL L25
EXP(
 CALL(
  NAME exit,
   CONST 1))
JUMP(
 NAME L27)
LABEL L28
EXP(
 CALL(
  NAME exit,
   CONST 1))
JUMP(
 NAME L30)
LABEL L31
# ----- Assembly L0 -----
L0:
addi t125, $0, 10
add t108, t125, $0
addi t126, $0, 0
add t109, t126, $0
jal initArray 
add t101, t106, $0
addi t127, $0, 16
add t108, t127, $0
jal malloc 
add t102, t106, $0
la t128, L1
sw t128, 0(t102)
la t129, L2
sw t129, 4(t102)
addi t130, $0, 0
sw t130, 8(t102)
addi t131, $0, 0
sw t131, 12(t102)
addi t132, $0, 5
add t108, t132, $0
add t109, t102, $0
jal initArray 
add t103, t106, $0
addi t133, $0, 100
add t108, t133, $0
la t134, L3
add t109, t134, $0
jal initArray 
add t104, t106, $0
addi t135, $0, 16
add t108, t135, $0
jal malloc 
add t105, t106, $0
la t136, L4
sw t136, 0(t105)
la t137, L5
sw t137, 4(t105)
addi t138, $0, 2432
sw t138, 8(t105)
addi t139, $0, 44
sw t139, 12(t105)
add t106, t105, $0
addi t140, $0, 8
add t108, t140, $0
jal malloc 
add t107, t106, $0
la t141, L6
sw t141, 0(t107)
addi t142, t107, 4
add t124, t142, $0
addi t143, $0, 3
add t108, t143, $0
addi t144, $0, 1900
add t109, t144, $0
jal initArray 
add t123, t106, $0
sw t124, 0(t123)
add t108, t107, $0
addi t145, $0, 0
add t109, t145, $0
lw t146, -4(t101)
add t110, t146, $0
bge t109, t110, L7
L8:
blt t109, 0, L7
L9:
addi t149, $0, 0
addi t150, $0, 4
mul t148, t149, t150
add t147, t101, t148
addi t151, $0, 1
sw t147, 0(t151)
addi t152, $0, 9
add t111, t152, $0
lw t153, -4(t101)
add t112, t153, $0
bge t111, t112, L10
L11:
blt t111, 0, L10
L12:
addi t156, $0, 9
addi t157, $0, 4
mul t155, t156, t157
add t154, t101, t155
addi t158, $0, 3
sw t154, 0(t158)
addi t159, $0, 3
add t113, t159, $0
lw t160, -4(t103)
add t114, t160, $0
bge t113, t114, L13
L14:
blt t113, 0, L13
L15:
addi t164, $0, 3
addi t165, $0, 4
mul t163, t164, t165
add t162, t103, t163
lw t161, 0(t162)
la t166, L16
sw t161, 0(t166)
addi t167, $0, 1
add t115, t167, $0
lw t168, -4(t103)
add t116, t168, $0
bge t115, t116, L17
L18:
blt t115, 0, L17
L19:
addi t172, $0, 1
addi t173, $0, 4
mul t171, t172, t173
add t170, t103, t171
lw t169, 0(t170)
addi t174, $0, 23
sw t174, 12(t169)
addi t175, $0, 34
add t117, t175, $0
lw t176, -4(t104)
add t118, t176, $0
bge t117, t118, L20
L21:
blt t117, 0, L20
L22:
addi t179, $0, 34
addi t180, $0, 4
mul t178, t179, t180
add t177, t104, t178
la t181, L23
sw t177, 0(t181)
la t182, L24
sw t106, 0(t182)
addi t183, $0, 0
add t119, t183, $0
lw t185, 4(t108)
lw t184, -4(t185)
add t120, t184, $0
bge t119, t120, L25
L26:
blt t119, 0, L25
L27:
lw t187, 4(t108)
addi t189, $0, 0
addi t190, $0, 4
mul t188, t189, t190
add t186, t187, t188
addi t191, $0, 2323
sw t186, 0(t191)
addi t192, $0, 2
add t121, t192, $0
lw t194, 4(t108)
lw t193, -4(t194)
add t122, t193, $0
bge t121, t122, L28
L29:
blt t121, 0, L28
L30:
lw t196, 4(t108)
addi t198, $0, 2
addi t199, $0, 4
mul t197, t198, t199
add t195, t196, t197
addi t200, $0, 2323
sw t195, 0(t200)
addi t201, $0, 0
add t106, t201, $0
j L31 
L7:
addi t202, $0, 1
add t108, t202, $0
jal exit 
j L9 
L10:
addi t203, $0, 1
add t108, t203, $0
jal exit 
j L12 
L13:
addi t204, $0, 1
add t108, t204, $0
jal exit 
j L15 
L17:
addi t205, $0, 1
add t108, t205, $0
jal exit 
j L19 
L20:
addi t206, $0, 1
add t108, t206, $0
jal exit 
j L22 
L25:
addi t207, $0, 1
add t108, t207, $0
jal exit 
j L27 
L28:
addi t208, $0, 1
add t108, t208, $0
jal exit 
j L30 
L31:
