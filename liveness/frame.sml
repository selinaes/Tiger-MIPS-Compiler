structure MipsFrame : FRAME = 
struct
    datatype access = InFrame of int | InReg of Temp.temp
    
    (* name: tag of the frame, formals: functions arguments, stackSize: size of the frmae, 4 * #(formals + locals)) *)
    type frame = {name: Temp.label, formals: access list, stackSize: int ref, instrs: Tree.stm list ref}

    (* MIPS registers *)
    type register = string

    (* this order is the priority of the reg allocation, the former defined is allocated first *)
    (* Temporary registers (caller saves) *)
    val T0 = Temp.newtemp() (* t100 *)
    val T1 = Temp.newtemp() (* t101 *)
    val T2 = Temp.newtemp() (* t102 *)
    val T3 = Temp.newtemp() (* t103 *)
    val T4 = Temp.newtemp() (* t104 *)
    val T5 = Temp.newtemp() (* t105 *)
    val T6 = Temp.newtemp() (* t106 *)
    val T7 = Temp.newtemp() (* t107 *)
    (* More temporary registers *)
    val T8 = Temp.newtemp() (* t108 *)
    val T9 = Temp.newtemp() (* t109 *)
    (* Saved registers (callee saves) *)
    val S0 = Temp.newtemp() (* t110*)
    val S1 = Temp.newtemp() (* t111 *)
    val S2 = Temp.newtemp() (* t112 *)
    val S3 = Temp.newtemp() (* t113 *)
    val S4 = Temp.newtemp() (* t114 *)
    val S5 = Temp.newtemp() (* t115 *)
    val S6 = Temp.newtemp() (* t116 *)
    val S7 = Temp.newtemp() (* t117 *)
    (* First four arguments to functions *)
    val A0 = Temp.newtemp() (* t118  *)
    val A1 = Temp.newtemp() (* t119  *)
    val A2 = Temp.newtemp() (* t120 *)
    val A3 = Temp.newtemp() (* t121 *)
    (**)
    val FP = Temp.newtemp() (* t122 *)
    val SP = Temp.newtemp() (* t123 *)
    val RA = Temp.newtemp() (* t124 *)
    (* Global pointer *)
    val GP = Temp.newtemp() (* t125 *)
    (* Return value *)
    val ZERO = Temp.newtemp() (* t126 *)
    (* Reserved for assembler *)
    val AT = Temp.newtemp() (* t127 *)
    (* First and second return values *)
    val RV = Temp.newtemp() (* t128 *)
    val V1 = Temp.newtemp() (* t129 *)
    
    (* Reserved for kernel (operating system) *)
    val K0 = Temp.newtemp() (* t130 *)
    val K1 = Temp.newtemp()  (* t131 *)
    

    val specialregs: Temp.temp list = [ZERO, AT, FP, SP, RA, RV, V1, K0, K1, GP] (* 10 *)
    val argregs: Temp.temp list = [A0, A1, A2, A3] (* 4 *)
    val calleesaves: Temp.temp list = [S0, S1, S2, S3, S4, S5, S6, S7] (* 8 *)
    val callersaves: Temp.temp list = [T0, T1, T2, T3, T4, T5, T6, T7, T8, T9] (* 10 *)

    val wordSize = 4
    val kDefaultRegSize = 4 (* MIPS has 4 registers for function arguments *)

    datatype frag = PROC of {body: Tree.stm, frame: frame} 
                | STRING of Temp.label * string

    val colorableTempMap: register Temp.Table.table = 
        let 
            val baseRegs = [
                (T0, "$t0"), (T1, "$t1"), (T2, "$t2"), (T3, "$t3"), (T4, "$t4"), (T5, "$t5"), (T6, "$t6"),
                (T7, "$t7"), (S0, "$s0"), (S1, "$s1"), (S2, "$s2"), (S3, "$s3"), (S4, "$s4"),
                (S5, "$s5"), (S6, "$s6"), (S7, "$s7"), (T8, "$t8"), (T9, "$t9"), (FP, "$fp"),
                (SP, "$sp"), (RA, "$ra"), (RV, "$v0"), (V1, "$v1"), (A0, "$a0"), (A1, "$a1"),
                (A2, "$a2"), (A3, "$a3")
            ]
        in
           foldr (fn ((s, t), acc) => Temp.Table.enter(acc, s, t)) Temp.Table.empty baseRegs 
       end
    val tempMap: register Temp.Table.table = 
        let 
            
            val baseRegs = 
                [(T0, "$t0"), (T1, "$t1"), (T2, "$t2"), (T3, "$t3"), (T4, "$t4"), (T5, "$t5"), (T6, "$t6"), 
                (T7, "$t7"), (S0, "$s0"), (S1, "$s1"), (S2, "$s2"), (S3, "$s3"), (S4, "$s4"), 
                (S5, "$s5"), (S6, "$s6"), (S7, "$s7"), (T8, "$t8"), (T9, "$t9"), (FP, "$fp"), 
                (SP, "$sp"), (RA, "$ra"), (RV, "$v0"), (V1, "$v1"), (A0, "$a0"), (A1, "$a1"), 
                (A2, "$a2"), (A3, "$a3"),  (GP, "$gp"), (ZERO, "$0"), 
                (AT, "$at"), (K0, "$k0"), (K1, "$k1")]
        in
             foldr (fn ((s, t), acc) => Temp.Table.enter(acc, s, t)) Temp.Table.empty baseRegs 
        end 


    fun string(lab, s) = (Symbol.name lab) ^ ":\n .word " ^ Int.toString(String.size(s)) ^ "\n .ascii \"" ^ s ^ "\"\n"

    fun tempToString (t: Temp.temp): string = 
        case Temp.Table.look(tempMap, t) of 
            SOME (str) => str
            | NONE => Temp.makestring t


    val registers = Temp.Table.listItems colorableTempMap

    fun printFrag(outputstream, []) = ()
        | printFrag(outputstream, (PROC {body, frame}) :: frags) = 
            (TextIO.output(outputstream, "PROC: frame with name: " ^ Symbol.name (#name frame) ^ "\n");
            Printtree.printtree(outputstream, body);
            printFrag(outputstream, frags))
            
        | printFrag(outputstream, (STRING (label, str)) :: frags) = 
            (TextIO.output(outputstream, "STRING: " ^ Symbol.name label ^ " " ^ str ^ "\n");
            printFrag(outputstream, frags))
            

    fun newFrame {name: Temp.label, formals: bool list} : frame = 
        let
            val curSize = ref 0
            val curParams = ref 0
            val instrsNew = ref []

            fun allocFormal([], _) = []
            | allocFormal (escape::re, index) : access list = 
                let
                    val from = (case index of 
                                      0 => Tree.TEMP A0
                                    | 1 => Tree.TEMP A1
                                    | 2 => Tree.TEMP A2
                                    | 3 => Tree.TEMP A3
                                    | _ => Tree.MEM(Tree.BINOP(Tree.MINUS, Tree.TEMP (FP), Tree.CONST ((index-3)*4))))
                    val (to, toIR) = (case escape of 
                                    true => (let
                                                val res = (InFrame(~(!curSize)), Tree.MEM(Tree.BINOP(Tree.MINUS, Tree.TEMP FP, Tree.CONST (!curSize))))
                                            in
                                                curSize := !curSize + wordSize; 
                                                res
                                            end)
                                          
                                    | false => 
                                        let
                                            val newReg = Temp.newtemp()
                                        in (InReg(newReg), Tree.TEMP newReg)
                                        end
                                    )
                in
                    instrsNew := Tree.MOVE(toIR, from) :: !instrsNew;
                    to::allocFormal(re, index + 1)
                end
            (* foldr (fn( esc, (result, index)) => (allocFormal(esc, index), index+1)) ([], 0) formals *)
        in
            {name = name, formals = (allocFormal (formals, 0)), stackSize = curSize, instrs = instrsNew}
        end


    fun name(frame: frame): Temp.label = #name frame
    fun formals(frame: frame): access list = #formals frame

    fun allocLocal ({name, formals, stackSize, instrs}: frame) (escape:bool) : access = 
        let
            val currAccess = InFrame(~(!stackSize))
        in
            if escape then
                (stackSize := !stackSize + wordSize; currAccess)
            else
                InReg(Temp.newtemp())
        end
        

    fun exp(InFrame offset) fp = Tree.MEM(Tree.BINOP(Tree.PLUS, fp, Tree.CONST offset))
      | exp(InReg reg) fp = Tree.TEMP reg

    (* View Shift: 
    4: Arguments conventional passing loc -> expected callee-view loc
    5: save callee saved regs. 
    8: restore callee-saves *)
    fun procEntryExit1({name,formals,stackSize,instrs},body: Tree.stm) = 
        let
            fun for1reg (reg) = 
                let
                    (* val InFrame(offset) = allocLocal {name=name, formals=formals, stackSize=stackSize, instrs=instrs} true *)
                    (* val () = print("Allocated: " ^ tempToString reg ^ "\n") *)
                    (* val frameLoc = Tree.MEM(Tree.BINOP(Tree.PLUS, Tree.TEMP FP, Tree.CONST(offset))) *)
                    val newt = Temp.newtemp()
                    val newLoc = Tree.TEMP newt
                    val regLoc = Tree.TEMP reg
                in
                    (
                        Tree.MOVE(newLoc, regLoc),
                        Tree.MOVE(regLoc, newLoc)
                    )
                end
            val tupleList = map (fn reg => (for1reg reg)) (RA::calleesaves)
            val store = map #1 tupleList
            val restore = rev(map #2 tupleList)
            val lst = (!instrs@store@[body]@restore)
        in
            Tree.seq(lst)
        end

    (* Append sink instruction, mark regs still live at exit, prevent allocator from reuse *)
    fun procEntryExit2(frame, body) = 
        body @ [Assem.OPER{assem="", src =[SP], dst=[], jump=NONE}]

    (* Rest of prologue / epilogue 
    1: peudo-announce start 2: function name label 3: adjust SP 
    9: reset SP 10: jump to return addr 11:peudo-announce end
    Note: src/dst here has no use. Already colored
    *)
    fun procEntryExit3({name,formals,stackSize,instrs}: frame, body) = 
        let 
            val labeling = Assem.LABEL{assem = Symbol.name name ^ ":\n", lab = name}

            (* Allocate more space for RA + FP, (sallee-save is done at procEntryExit1's allocLocal) *)
            val () = stackSize := !stackSize + 2 * wordSize
            (* Allocate Frame *)
            val extendSP = Assem.OPER {assem="addi `d0, `s0, -" ^ Int.toString (!stackSize) ^ "\n", src=[SP], dst=[SP], jump=NONE}
            val saveFP = Assem.OPER {assem="sw `s0, 4(`s1)\n",src=[FP,SP], dst=[],jump=NONE} (* save old fp *)
            (* val saveRA = Assem.OPER {assem="sw `s0, 8(`s1)\n", src=[RA,SP], dst=[], jump=NONE} *)
            val setnewFP = Assem.OPER {assem ="add `d0, `s0, " ^ Int.toString (!stackSize) ^"\n",src =[SP], dst=[FP], jump=NONE}
            
            (* Deallocate Frame *)
            (* val restoreRA = Assem.OPER {assem="lw `d0, 8(`s0)\n", src=[SP], dst=[RA], jump=NONE} *)
            val restoreFP = Assem.OPER {assem="lw `d0, 4(`s0)\n", src=[SP], dst=[FP], jump=NONE}
            val resetSP = Assem.OPER {assem="addi `d0, `s0, " ^ Int.toString (!stackSize) ^ "\n", src=[SP], dst=[SP], jump=NONE}
            val jumpToRA = Assem.OPER {assem="jr $ra\n", src=[], dst=[], jump=SOME[]}
            (*  *)
        in
            {prolog = "PROCEDURE " ^ Symbol.name name ^ "\n",
            body = [labeling, extendSP, saveFP, setnewFP]
                    @body
                    @[restoreFP, resetSP, jumpToRA],
            epilog = "END " ^ Symbol.name name ^ "\n"}
        end
        

    fun externalCall(name: string, args: Tree.exp list): Tree.exp = 
        Tree.CALL(Tree.NAME(Temp.namedlabel name), args)
    
    fun getAccessOffset(acc: access) = 
        case acc of
            InFrame x => x
            |InReg t => ErrorMsg.impossible "alloced InReg" 
end

structure Frame : FRAME = MipsFrame