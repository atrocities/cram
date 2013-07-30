#ifndef _COPCODE
#define _COPCODE

#define RA 1
#define RB 2
#define RC 3
#define RD 4
#define RE 5
#define RF 6
#define RH 7
#define RL 8
#define SP 9
#define PC 10
#define AF 11
#define BC 12
#define DE 13
#define HL 14

void* map8[0x100];
byte map8arg1[0x100];
byte map8arg2[0x100];
byte map8icount[0x100];
byte map8timing[0x100];
void* map16[0x100];
byte map16arg[0x100];
byte map16timing[0x100];
byte* rmap[9];

void setZ();
void setN();
void setH();
void setC();

void resetZ();
void resetN();
void resetH();
void resetC();

byte getZ();
byte getN();
byte getH();
byte getC();

byte read8r(char reg);
void write8r(char reg, byte val);
word read16r(char reg);
void write16r(char reg, word val);

void radd(char reg, byte imm, char doflag);
void rsub(char reg, byte imm, char doflag, char ncp);

// Loads
void LDRR(byte r1, byte r2);	// Load reg2 -> reg1
void LDRN(byte r, byte n);	// Load n -> reg
void LDAI(byte n1, byte n2);	// Load (nn) -> A
void LDIA(byte n1, byte n2);	// Load A -> (nn)

void LDAC(byte y, byte z);	// Load (0xFF00+C)->A
void LDCA(byte y, byte z);	// Load A->(0xFF00+C)
void LDD(byte r1, byte r2);	// (HL)->A, HL-- OR A->(HL), HL--
void LDI(byte r1, byte r2);	// (HL)->A, HL++ OR A->(HL), HL++
void LDH(byte n, byte z);	// A->(0xFF00+n)
void LDHR(byte n, byte z);	// (0xFF00+n)->A
void LDBC(byte n1, byte n2);
void LDDE(byte n1, byte n2);
void LDHL(byte n1, byte n2);
void LDSP(byte n1, byte n2);
void LDSH(byte y, byte z);	// HL->SP
void LSHL(byte n, byte z);	// SP+n->HL
void LSHN(byte n1, byte n2); 	// SP->(nn)
void PUSH(byte r, byte z);
void POP(byte r, byte z);

// 8 bit ALU
void ADD(byte r, byte z);
void ADDI(byte n, byte z);
void ADC(byte r, byte z);
void ADCI(byte n, byte z);
void SUB(byte r, byte z);
void SUBI(byte n, byte z);
void SBC(byte r, byte z);
void SBCI(byte n, byte z);
void AND(byte r, byte z);
void ANDI(byte n, byte z);
void OR(byte r, byte z);
void ORI(byte n, byte z);
void XOR(byte r, byte z);
void XORI(byte n, byte z);
void CP(byte r, byte z);
void CPI(byte n, byte z);
void INCH(byte r, byte z);
void INC(byte r, byte z);
void DECH(byte y, byte z);
void DEC(byte r, byte z);

// 16 bit ALU
void ADDH(byte r, byte z);
void ADDS(byte n, byte z);

// CB instruction handler
void CBCO(byte c, byte z);

// Misc
void SWAP(byte r, byte z);
void DAA(byte y, byte z);
void CPL(byte y, byte z);
void CCF(byte y, byte z);
void SCF(byte y, byte z);
void NOP(byte y, byte z);
void HALT(byte y, byte z);
void STOP(byte y, byte z);
void DI(byte y, byte z);
void EI(byte y, byte z);

// Rotates/shifts
void RLC(byte r, byte z);
void ROL(byte r, byte z);
void RRC(byte r, byte z);
void ROR(byte r, byte z);
void SLA(byte r, byte z);
void SRA(byte r, byte z);
void SRL(byte r, byte z);

// Bit opcodes
void BIT(byte b, byte r);
void SET(byte b, byte r);
void RES(byte b, byte r);

// Jumps
void JP(byte n1, byte n2);
void JPNZ(byte n1, byte n2);
void JPZ(byte n1, byte n2);
void JPNC(byte n1, byte n2);
void JPC(byte n1, byte n2);
void JPHL(byte y, byte z);
void JR(byte n, byte z);
void JRNZ(byte n, byte z);
void JRZ(byte n, byte z);
void JRNC(byte n, byte z);
void JRC(byte n, byte z);

// Calls
void CALL(byte n1, byte n2);
void CNZ(byte n1, byte n2);
void CZ(byte n1, byte n2);
void CNC(byte n1, byte n2);
void CC(byte n1, byte n2);

// Resets
void RST(byte n1, byte n2);
void RET(byte y, byte z);
void RNZ(byte y, byte z);
void REZ(byte y, byte z);
void RNC(byte y, byte z);
void REC(byte y, byte z);
void REI(byte y, byte z);

#endif
