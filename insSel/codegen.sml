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
        
    fun binopTrAsmImmMap T.PLUS = "addi"
        | binopTrAsmImmMap T.AND = "andi"
        | binopTrAsmImmMap T.OR = "or"
    
    fun relopBranchMap T.EQ = "beq"
        | relopBranchMap T.NE = "bne"
        | relopBranchMap T.LT = "blt"
        | relopBranchMap T.GT = "bgt"
        | relopBranchMap T.LE = "ble"
        | relopBranchMap T.GE = "bge"
        | relopBranchMap T.ULT = "bltu"
        | relopBranchMap T.ULE = "bleu"
        | relopBranchMap T.UGT = "bgtu"
        | relopBranchMap T.UGE = "bgeu"
        

    (* fun codegen frame: Frame.frame stm:Tree.stm : Assem.instr list = []  *)
    fun codegen (frame) (stm: Tree.stm) : A.instr list =
        let val ilist = ref (nil: A.instr list)
            fun emit x= ilist := x :: !ilist
            fun result(gen) = let val t = Temp.newtemp() in gen t; t end
            fun munchStm(T.SEQ(a,b)) = (munchStm a; munchStm b)
            (* 4 node *)
            | munchStm(T.MOVE(T.MEM(T.BINOP(T.PLUS,e1,T.CONST i)),e2)) =
                    emit(A.OPER{assem="sw 's1, " ^ Int.toString(i) ^ "('s0)\n",
                                src=[munchExp e1, munchExp e2],
                                dst=[],jump=NONE})
            | munchStm(T.MOVE(T.MEM(T.BINOP(T.PLUS,T.CONST i,e1)),e2)) =
                    emit(A.OPER{assem="sw 's1" ^ Int.toString(i) ^ "('s0)\n",
                                src=[munchExp e1, munchExp e2],
                                dst=[],jump=NONE})
            | munchStm(T.MOVE(T.MEM(T.BINOP(T.MINUS,e1,T.CONST i)),e2)) =
                    emit(A.OPER{assem="sw 's1, " ^ Int.toString(~i) ^ "('s0)\n",
                                src=[munchExp e1, munchExp e2],
                                dst=[],jump=NONE})

            (* 3 node *) 
                | munchStm(T.MOVE(T.MEM(T.CONST i),e2)) =
                    emit(A.OPER{assem="sw 's0, " ^ Int.toString(i) ^ "($0)\n",
                    src=[munchExp e2], dst=[],jump=NONE})
                | munchStm(T.CJUMP(relop,e1,T.CONST(i), t, f)) = 
                    emit(A.OPER{assem=relopBranchMap relop ^ " 's0, " ^ Int.toString(i) ^ ", 'j0\n",
                                src=[munchExp e1],
                                dst=[],jump=SOME([t,f])})
                | munchStm(T.CJUMP(relop,T.CONST(i),e2, t, f)) = 
                    emit(A.OPER{assem=relopBranchMap relop ^ " " ^ Int.toString(i) ^ ", 's0, 'j0\n",
                                src=[munchExp e2],
                                dst=[],jump=SOME([t,f])})
            (* 2 node *)
                | munchStm(T.MOVE(T.MEM(e1),e2)) =
                    emit(A.OPER{assem="sw 's0, 0('s1)\n",
                    src=[munchExp e1, munchExp e2],
                    dst= [] ,jump=NONE})
                | munchStm(T.MOVE(T.TEMP i, e2) ) =
                    emit(A.OPER{assem="add 'd0, 's0, $0\n",
                    src=[munchExp e2],
                    dst=[i],jump=NONE})
                | munchStm(T.JUMP(T.NAME elbl, lblLst)) = 
                    emit(A.OPER{assem="j 'j0 \n",
                    src=[],
                    dst=[], jump=SOME([elbl])})
                | munchStm(T.JUMP(exp, lblLst)) = 
                    emit(A.OPER{assem="jr 's0 \n",
                    src=[munchExp exp],
                    dst=[], jump=SOME(lblLst)}) 
                | munchStm(T.CJUMP(relop, e1 , e2, t, f)) = 
                    emit(A.OPER{assem=relopBranchMap relop ^  " 's0, 's1, 'j0\n",
                                src=[munchExp e1, munchExp e2],
                                dst=[],jump=SOME([t,f])})

            (* 1 node *)
                | munchStm(T.LABEL lab) =
                    emit(A.LABEL{assem=lab ^ ":\n", lab=lab})
                | munchStm(T.EXP e) = (munchExp e; ())
            (* 3 node *)
            and munchExp(T.MEM(T.BINOP(T.PLUS,e1,T.CONST i))) =
                    result (fn r => emit (A. OPER{assem= "lw 'd0, " ^ Int.toString(i) ^ "('s0)\n",
                                                 src= [munchExp e1], dst=[r], jump=NONE}) )
                | munchExp(T.MEM(T.BINOP(T.PLUS,T.CONST i,e1))) =
                    result(fn r => emit(A.OPER {assem="lw 'd0," ^ Int.toString(i) ^ "('s0)\n",
                                                src=[munchExp e1], dst=[r], jump=NONE}))
                |   munchExp(T.MEM(T.BINOP(T.MINUS, e1, T.CONST i))) =
                    result (fn r => emit (A. OPER{assem= "lw 'd0," ^ Int.toString(~i) ^ "('s0)\n",
                                                 src= [munchExp e1], dst=[r], jump=NONE}))
                | munchExp(T.MEM(T.CONST i)) =
                    result(fn r => emit(A.OPER {assem="lw 'd0," ^ Int.toString(i) ^ "($0)\n",
                                                src=[], dst=[r], jump=NONE}))
                | munchExp(T.BINOP(binop, e1,T.CONST i)) =
                    result(fn r => emit(A.OPER {assem=binopTrAsmImmMap binop ^ " 'd0, 's0, " ^ Int.toString(i) ^ "\n",
                                                src=[munchExp e1], dst=[r], jump=NONE}))
                | munchExp(T.BINOP(binop,T.CONST i,e1)) =
                    result(fn r => emit(A.OPER {assem=binopTrAsmImmMap binop ^ " 'd0, 's0, " ^ Int.toString(i) ^ "\n",
                                                src=[munchExp e1], dst=[r], jump=NONE}))
                | munchExp(T.BINOP(T.MINUS, e1,T.CONST i)) =
                    result(fn r => emit(A.OPER {assem="addi 'd0, 's0, " ^ Int.toString(~i) ^ "\n",
                                                src=[munchExp e1], dst=[r], jump=NONE}))
                | munchExp(T.BINOP(T.MINUS,T.CONST i,e1)) =
                    result(fn r => emit(A.OPER {assem="addi 'd0, 's0, " ^ Int.toString(~i) ^ "\n",
                                                src=[munchExp e1], dst=[r], jump=NONE}))
                | munchExp(T.CALL(T.NAME clbl, [args])) = 
                    let val () = (A.OPER{assem="jal 'j0 \n",
                                    src=[munchArgs (0, args)],
                                    dst=[],jump=SOME([clbl])})
                    in Frame.RV
                    end
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
                | munchExp(T.ESEQ(_,_)) = ErrorMsg.impossible "ESEQ appeared in InstrSel"
            and munchArgs(index: int, args: Tree.exp list): T.temp list = 
                if index > (length args) then []
                else
                    (case index of 
                        0 => munchStm(T.MOVE(Frame.A0, #0 args)); Frame.A0 :: munchArgs(index+1, args)
                        | 1 => munchStm(T.MOVE(Frame.A1, #1 args)); Frame.A1 :: munchArgs(index+1, args)
                        | 2 => munchStm(T.MOVE(Frame.A2, #2 args)); Frame.A2 :: munchArgs(index+1, args)
                        | 3 => munchStm(T.MOVE(Frame.A3, #3 args)); Frame.A3 :: munchArgs(index+1, args)
                        | _ => (munchStm(T.MOVE(T.MEM(T.BINOP(T.PLUS, T.Temp (Frame.SP), T.CONST ((index-3)*4))), List.nth(args, index)); [])))
                
        in munchStm stm;
            rev(!ilist)
        end
end