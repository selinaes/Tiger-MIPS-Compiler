structure MipsFrame : FRAME = 
struct
    datatype access = InFrame of int | InReg of Temp.temp
    
    (* name: tag of the frame, formals: functions arguments, stackSize: size of the frmae, 4 * #(formals + locals)) *)
    type frame = {name: Temp.label, formals: access list, stackSize: int ref}
    type register = string

    val FP = Temp.newtemp()
    val SP = Temp.newtemp()
    val RA = Temp.newtemp()
    (* Global pointer *)
    val GP = Temp.newtemp()
    val ZERO = Temp.newtemp()
    (* Reserved for assembler *)
    val AT = Temp.newtemp()
    (* First and second return values *)
    val RV = Temp.newtemp()
    val V1 = Temp.newtemp()
    (* First four arguments to functions *)
    val A0 = Temp.newtemp()
    val A1 = Temp.newtemp()
    val A2 = Temp.newtemp()
    val A3 = Temp.newtemp()
    (* Temporary registers (caller saves) *)
    val T0 = Temp.newtemp()
    val T1 = Temp.newtemp()
    val T2 = Temp.newtemp()
    val T3 = Temp.newtemp()
    val T4 = Temp.newtemp()
    val T5 = Temp.newtemp()
    val T6 = Temp.newtemp()
    val T7 = Temp.newtemp()
    (* Saved registers (callee saves) *)
    val S0 = Temp.newtemp()
    val S1 = Temp.newtemp()
    val S2 = Temp.newtemp()
    val S3 = Temp.newtemp()
    val S4 = Temp.newtemp()
    val S5 = Temp.newtemp()
    val S6 = Temp.newtemp()
    val S7 = Temp.newtemp()
    (* More temporary registers *)
    val T8 = Temp.newtemp()
    val T9 = Temp.newtemp()
    (* Reserved for kernel (operating system) *)
    val K0 = Temp.newtemp()
    val K1 = Temp.newtemp() 
    

    val specialregs: Temp.temp list = [ZERO, AT, FP, SP, RA, RV, V1, K0, K1, GP] (* 10 *)
    val argregs: Temp.temp list = [A0, A1, A2, A3] (* 4 *)
    val calleesaves: Temp.temp list = [S0, S1, S2, S3, S4, S5, S6, S7] (* 8 *)
    val callersaves: Temp.temp list = [T0, T1, T2, T3, T4, T5, T6, T7, T8, T9] (* 10 *)

    val wordSize = 4
    val kDefaultRegSize = 4 (* MIPS has 4 registers for function arguments *)

    datatype frag = PROC of {body: Tree.stm, frame: frame} 
                | STRING of Temp.label * string

    val tempMap: register Temp.Table.table = 
        let 
            val baseRegs = [
                (FP, "%fp"), (SP, "%sp"), (RA, "%ra"),(ZERO, "%zero"), (AT, "%at"),  (RV, "%rv"), (V1, "%v1"), 
                (A0, "%a0"), (A1, "%a1"), (A2, "%a2"), (A3, "%a3"), (T0, "%t0"), (T1, "%t1"), (T2, "%t2"), 
                (T3, "%t3"), (T4, "%t4"), (T5, "%t5"), (T6, "%t6"), (T7, "%t7"), (S0, "%s0"), (S1, "%s1"), 
                (S2, "%s2"), (S3, "%s3"), (S4, "%s4"), (S5, "%s5"), (S6, "%s6"), (S7, "%s7"), (T8, "%t8"), 
                (T9, "%t9"), (K0, "%k0"), (K1, "%k1"), (GP, "%gp")
            ]
        in
             foldr (fn ((s, t), acc) => Temp.Table.enter(acc, s, t)) Temp.Table.empty baseRegs 
        end 

    fun string(label, str) = Symbol.name label ^ " : .ascii "^ str ^ " \n"

    fun tempToString (t: Temp.temp): string = 
        case Temp.Table.look(tempMap, t) of 
            SOME (str) => str
            | NONE => Temp.makestring t
      

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
            fun allocFormal (escape) : access = 
                if !curParams < kDefaultRegSize 
                then (curParams := !curParams + 1; InReg(Temp.newtemp()))
                else 
                    if escape
                    then (curSize := !curSize + wordSize; InFrame(~(!curSize)))
                    else InReg(Temp.newtemp())
        in
            {name = name, formals = map allocFormal formals , stackSize = curSize}
        end


    fun name(frame: frame): Temp.label = #name frame
    fun formals(frame: frame): access list = #formals frame

    fun allocLocal ({name, formals, stackSize}: frame) (escape:bool) : access = 
        if escape then
            let
                val size = !stackSize
            in
                stackSize := size + wordSize;
                InFrame(~size)
            end
        else
            InReg(Temp.newtemp())

    fun exp(InFrame offset) fp = Tree.MEM(Tree.BINOP(Tree.PLUS, fp, Tree.CONST offset))
      | exp(InReg reg) fp = Tree.TEMP reg

    (* View Shift: 
    4: Arguments conventional passing loc -> expected callee-view loc
    5: save callee saved regs. 
    8: restore callee-saves *)
    fun procEntryExit1(frame,body) = body

    (* Append sink instruction, mark regs still live at exit, prevent allocator from reuse *)
    fun procEntryExit2(frame, body) = 
        body @ [Assem.OPER{assem="", src =[ZERO,RA,SP]@calleesaves, dst=[], jump=SOME[]}]

    (* Rest of prologue / epilogue 
    1: peudo-announce start 2: function name label 3: adjust SP 
    9: reset SP 10: jump to return addr 11:peudo-announce end
    *)
    fun procEntryExit3({name,formals,stackSize}: frame, body) = 
        {prolog = "PROCEDURE " ^ Symbol.name name ^ "\n",
        body = body,
        epilog = "END " ^ Symbol.name name ^ "\n"}

    fun externalCall(name: string, args: Tree.exp list): Tree.exp = 
        Tree.CALL(Tree.NAME(Temp.namedlabel name), args)
end

structure Frame : FRAME = MipsFrame