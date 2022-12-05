//=== -- RISCVInstrInfoB.td RISCV-V thead-extension ba,bb,bc instructions


// Operand definitions.

class ImmAsmOperand<string prefix, int width, string suffix> : AsmOperandClass {
	let Name = prefix # "Imm" # width # suffix;
	let RenderMethod = "addImmOperands";
	let DiagnosticType = !strconcat("Invalid", Name);
}

class UImmAsmOperand<int width, string suffix = "">
	: ImmAsmOperand<"U", width, suffix>{
}

class SImmAsmOperand<int width, string suffix = "">
	: ImmAsmOperand<"S", width, suffix>{
}

def uimm2 : Operand<XLenVT> {
	let ParserMatchClass = UImmAsmOperand<2>;
	let DecoderMethod = "decodeUImmOperand<2>"; 
	let OperandType = "OPERAND_UIMM2";
	let OperandNamespace = "RISCVOp";
}

let hasSideEffects = 0, mayLoad = 0, mayStore = 0 in
class addsl_ir<bits<7> imm7,string opcodestr> // TODO ADD RISCVOpcode 
			: addsl<imm7, opcode, (outs GPR:$rd),
			(ins GPR:$rs1, GPR:$rs2, uimm2:$imm), opcodestr,
			"$rd, $rs1, $rs2, $imm">


let hasSideEffects = 0, mayLoad = 0, mayStore = 0 in
class sign_extend_ir<bits<7> funct7, string opcodestr>
    : th_ext<funct7, opcode, (outs GPR:$rd),
    (ins GPR:$rs1, uimm6:$imm1, uimm6:$imm2), opcodestr,
    "$rd, $rs1, $imm1, $imm2">"

def ADDSL : addsl_ir<0b0000001, "addsl">

def SIGNEXTEND : sign_extend_ir<0b0000010, "th_ext"> 

// Predicates



def Pat<(add GPR:$rs1, (shl GPR:$rs2, uimm2:$imm) ) , ADDSL>

def Pat<
