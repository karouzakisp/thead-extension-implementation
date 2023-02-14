//=== -- RISCVInstrInfoB.td RISCV-V thead-extension ba,bb,bs instructions

def OPC_CUSTOM1   : RISCVOpcode<"CUSTOM1", 0b0001011>;

def uimm2_node : Operand<XLenVT>, ImmLeaf<XLenVT, [{return isUint<2>(Imm);}]> {
  let ParserMatchClass = UImmAsmOperand<2>;
  let DecoderMethod = "decodeUImmOperand<2>";
  let OperandType = "OPERAND_UIMM2";
  let OperandNamespace = "RISCVOp";
}


let hasSideEffects = 0, mayLoad = 0, mayStore = 0 in
class addsl_ir<bits<3> funct3,string opcodestr> // TODO ADD RISCVOpcode 
			: RVInstR<0, funct3, OPC_CUSTOM1, (outs GPR:$rd),
			(ins GPR:$rs1, GPR:$rs2, uimm2:$uimm2), opcodestr,
			"$rd, $rs1, $rs2, $uimm2">{
  bits<2> uimm2;
  let Inst{31-27} = 0;
  let Inst{26-25} = uimm2;
}


let hasSideEffects = 0, mayLoad = 0, mayStore = 0 in
class ext_ir<bits<3> funct3, string opcodestr>
    : RVInstI<funct3, OPC_CUSTOM1, (outs GPR:$rd),
    (ins GPR:$rs1, uimmlog2xlen:$msb, uimmlog2xlen:$lsb), opcodestr,
    "$rd, $rs1, $msb, $lsb">{
    bits<6> msb;
    bits<6> lsb;
    let Inst{31-26} = msb;
    let Inst{25-20} = lsb;

}

class rev_ir<bits<5> funct5, bits<2> funct2, string opcodestr>
  : RVInstrR4<funct2, 0b001, OPC_CUSTOM1, (outs GPR:$rd), (ins GPR:$rs1),
  opcodestr, "$rd, $rs1">{
  let rs3 = funct5;
  let rs2 = 0;
}


// Predicates


  def ADDSL : addsl_ir<0b001, "addsl">;
  def EXT : ext_ir<0b010, "ext">;
  def EXTU : ext_ir<0b011, "extu">;
  def FF0 : rev_ir<0b100, "ff0">;
  def FF1 : rev_ir<0b101, "ff1">;
  def REV : rev_ir<0b110, "rev">;
  def REVW : rev_ir<0b111, "rev">;
  

  def : Pat<(add GPR:$rs1, (shl GPR:$rs2, uimm2_node:$uimm2) ) ,
         (ADDSL GPR:$rs1, GPR:$rs2, uimm2_node:$uimm2)>;

    
  def : Pat<(sext_inreg GPR:$rs1,  i8) , (EXT GPR:$rs1, 7, 0)>;
  def : Pat<(sext_inreg GPR:$rs1,  i16) , (EXT GPR:$rs1, 15, 0)>;
  def : Pat<(sext_inreg GPR:$rs1,  i32) , (EXT GPR:$rs1, 31, 0)>;


  def : Pat<(and GPR:$rs1, 1), (EXTU GPR:$rs1, 0, 0)>;
  def : Pat<(and GPR:$rs1, 0xff), (EXTU GPR:$rs1, 7, 0)>;
  def : Pat<(and GPR:$rs1, 0xffff), (EXTU GPR:$rs1, 15, 0)>;
  def : Pat<(and GPR:$rs1, 0xffffffff), (EXTU GPR:$rs1, 31, 0)>;
  def : Pat<(and GPR:$rs1, 0xffffffffffffffff, (EXTU GPR:$rs1, 61, 0)>;

 
  def : Pat<(ctlz GPR:$rs1), (FF1 GPR:$rs1)>;
  def : Pat<(ctlz (xor GPR:$rs1, 1), FF0 GPr:$rs0 )>;
     
  def : Pat<(bswap GPR:$rs1, REV GPR:$rs1 ) >;

// which one ?? 1's at the start or 0's ??
  def : Pat<(srl (bswap GPR:$rs1), (i64 32) , REVW GPR:$rs1 )>;

  def : Pat<(sra (bswap GPR:$rs1), (i64 32) , REVW GPR:$rs1 )>;

  


