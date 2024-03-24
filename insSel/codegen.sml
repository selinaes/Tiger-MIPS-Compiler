structure MipsGen : CODEGEN = 
struct
    structure A = Assem
    structure T = Tree
    fun binopTrAsmMap T.PLUS = "add"
        | binopTrAsmMap T.MINUS = "sub"
        | binopTrAsmMap T.MUL = "mul"
        | binopTrAsmMap T.DIV = "div"
        | binopTrAsmMap T.AND = "and"
        | binopTrAsmMap T.OR = "or"
        | binopTrAsmMap T.XOR = "xor"
        | binopTrAsmMap T.LSHIFT = "sll"
        | binopTrAsmMap T.RSHIFT = "srl"
        | binopTrAsmMap T.ARSHIFT = "sra"
        
    (* fun codegen frame: Frame.frame stm:Tree.stm : Assem.instr list = []  *)
    fun codegen (frame) (stm: Tree.stm) : A.instr list =
        let val ilist = ref (nil: A.instr list)
            fun emit x= ilist := x :: !ilist
            fun result(gen) = let val t = Temp.newtemp() in gen t; t end
            fun munchStm(T.SEQ(a,b)) = (munchStm a; munchStm b)
                | munchStm(T.MOVE(T.MEM(T.BINOP(T.PLUS,e1,T.CONST i)),e2)) =
                    emit(A.OPER{assem="sw 's1, " ^ Int.toString(i) ^ "('s0)\n",
                                src=[munchExp e1, munchExp e2],
                                dst=[],jump=NONE})
                | munchStm(T.MOVE(T.MEM(T.BINOP(T.PLUS,T.CONST i,e1)),e2)) =
                    emit(A.OPER{assem="sw 's1" ^ Int.toString(i) ^ "('s0)\n",
                                src=[munchExp e1, munchExp e2],
                                dst=[],jump=NONE})
                | munchStm(T.MOVE(T.MEM(e1),T.MEM(e2))) =
                    emit(A.OPER{assem="MOVE M['s0] <- M['s1]\n",
                    src=[munchExp e1, munchExp e2],
                    dst=[],jump=NONE})
                | munchStm(T.MOVE(T.MEM(T.CONST i),e2)) =
                    emit(A.OPER{assem="sw 's1" ^ Int.toString(i) ^ "(0)\n",
                    src=[munchExp e2], dst=[],jump=NONE})
                | munchStm(T.MOVE(T.MEM(e1),e2)) =
                    emit(A.OPER{assem="STORE M['s0] <- 's1\n",
                    src=[munchExp e1, munchExp e2],
                    dst= [] ,jump=NONE})
                | munchStm(T.MOVE(T.TEMP i, e2) ) =
                    emit(A.OPER{assem="ADD 'd0 <- 's0 + r0\n",
                    src=[munchExp e2],
                    dst=[i],jump=NONE})
                | munchStm(T.LABEL lab) =
                    emit(A.LABEL{assem=lab ^ ":\n", lab=lab})
            and result (gen) = let val t = Temp.newtemp() in gen t; t end
            
            and munchExp(T.MEM(T.BINOP(T.PLUS,e1,T.CONST i))) =
                (* 3 node *)
                    result (fn r => emit (A. OPER{assem= "lw 'd0," ^ Int.toString(i) ^ "('s0)\n",
                                                 src= [munchExp e1], dst=[r], jump=NONE}) )
                | munchExp(T.MEM(T.BINOP(T.PLUS,T.CONST i,e1))) =
                    result(fn r => emit(A.OPER {assem="lw 'd0," ^ Int.toString(i) ^ "('s0)\n",
                                                src=[munchExp e1], dst=[r], jump=NONE}))
                (* 2 node *)
                | munchExp(T.MEM(T.CONST i)) =
                    result(fn r => emit(A.OPER {assem="lw 'd0," ^ Int.toString(i) ^ "($0)\n",
                                                src=[], dst=[r], jump=NONE}))
                | munchExp(T.BINOP(T.PLUS, e1,T.CONST i)) =
                    result(fn r => emit(A.OPER {assem="addi 'd0, 's0, " ^ Int.toString(i) ^ "\n",
                                                src=[munchExp e1], dst=[r], jump=NONE}))
                | munchExp(T.BINOP(T.PLUS,T.CONST i,e1)) =
                    result(fn r => emit(A.OPER {assem="addi 'd0, 's0, " ^ Int.toString(i) ^ "\n",
                                                src=[munchExp e1], dst=[r], jump=NONE}))
                | munchExp(T.BINOP(T.MINUS, e1,T.CONST i)) =
                    result(fn r => emit(A.OPER {assem="addi 'd0, 's0, " ^ Int.toString(~i) ^ "\n",
                                                src=[munchExp e1], dst=[r], jump=NONE}))
                | munchExp(T.BINOP(T.MINUS,T.CONST i,e1)) =
                    result(fn r => emit(A.OPER {assem="addi 'd0, 's0, " ^ Int.toString(~i) ^ "\n",
                                                src=[munchExp e1], dst=[r], jump=NONE}))
                (* 1 node *)
                | munchExp(T.MEM(e1)) =
                    result(fn r => emit(A.OPER {assem="lw 'd0,0('s0)\n",
                                                src=[munchExp e1], dst=[r], jump=NONE}))
                | munchExp(T.CONST i) =
                    result(fn r => emit(A.OPER{assem="addi 'd0, $0" ^ Int.toString(i) ^ "\n",
                                            src=[], dst=[r], jump=NONE}))
                | munchExp(T.BINOP(binop,e1,e2)) =
                    result(fn r => emit(A.OPER{assem=binopTrAsmMap binop ^ " 'd0, 's0, 's1\n",
                                            src=[munchExp e1, munchExp e2], dst=[r],
                                            jump=NONE}))
                | munchExp(T.TEMP t) = t
        in munchStm stm;
            rev(!ilist)
        end
end