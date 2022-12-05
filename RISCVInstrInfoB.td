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
class addsl_ir<bits<7> imm7, bits<5> funct5, RISCVOpcode opcode,
										string opcodestr>
			: addsl<imm7, funct5, opcode, (outs GPR:$rd),
			(ins GPR:$rs1, GPR:$rs2, uimm2:$imm), opcodestr,
			"$rd, $rs1, $rs2, $imm">


def ADDSL : addsl_ir<0b0000001, "addsl">

// Predicates

def Pat<(add GPR:$rs1, (shl GPR:$rs2, uimm2:$imm) ) , ADDSL>
				 
let hasSideEffects = 0, mayLoad = 0, mayStore = 0 in
class sign_extend_ir<
