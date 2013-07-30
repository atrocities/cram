#include<stdio.h>
#include<string.h>
#include "cram.h"
#include "mem.h"
#include "opcode.h"
#include "cpu.h"

// Mappings
byte* rmap[9]; 

void* map8[0x100] = 
// 0    1     2     3     4     5     6     7     8     9     A     B     C     D     E     F   
{ &NOP,&LDBC,&LDRR,&INCH, &INC, &DEC,&LDRN, &RLC,&LSHN,&ADDH,&LDRR,&DECH, &INC, &DEC,&LDRN, &RRC, // 0
 &STOP,&LDDE,&LDRR,&INCH, &INC, &DEC,&LDRN, &ROL,  &JR,&ADDH,&LDRR,&DECH, &INC, &DEC,&LDRN, &ROR, // 1
 &JRNZ,&LDHL, &LDI,&INCH, &INC, &DEC,&LDRN, &DAA, &JRZ,&ADDH, &LDI,&DECH, &INC, &DEC,&LDRN, &CPL, // 2
 &JRNC,&LDSP, &LDD,&INCH, &INC, &DEC,&LDRN, &SCF, &JRC,&ADDH, &LDD,&DECH, &INC, &DEC,&LDRN, &CCF, // 3
 &LDRR,&LDRR,&LDRR,&LDRR,&LDRR,&LDRR,&LDRR,&LDRR,&LDRR,&LDRR,&LDRR,&LDRR,&LDRR,&LDRR,&LDRR,&LDRR, // 4
 &LDRR,&LDRR,&LDRR,&LDRR,&LDRR,&LDRR,&LDRR,&LDRR,&LDRR,&LDRR,&LDRR,&LDRR,&LDRR,&LDRR,&LDRR,&LDRR, // 5
 &LDRR,&LDRR,&LDRR,&LDRR,&LDRR,&LDRR,&LDRR,&LDRR,&LDRR,&LDRR,&LDRR,&LDRR,&LDRR,&LDRR,&LDRR,&LDRR, // 6
 &LDRR,&LDRR,&LDRR,&LDRR,&LDRR,&LDRR,&HALT,&LDRR,&LDRR,&LDRR,&LDRR,&LDRR,&LDRR,&LDRR,&LDRR,&LDRR, // 7
  &ADD, &ADD, &ADD, &ADD, &ADD, &ADD, &ADD, &ADD, &ADC, &ADC, &ADC, &ADC, &ADC, &ADC, &ADC, &ADC, // 8
  &SUB, &SUB, &SUB, &SUB, &SUB, &SUB, &SUB, &SUB, &SBC, &SBC, &SBC, &SBC, &SBC, &SBC, &SBC, &SBC, // 9
  &AND, &AND, &AND, &AND, &AND, &AND, &AND, &AND, &XOR, &XOR, &XOR, &XOR, &XOR, &XOR, &XOR, &XOR, // A
   &OR,  &OR,  &OR,  &OR,  &OR,  &OR,  &OR,  &OR,  &CP,  &CP,  &CP,  &CP,  &CP,  &CP,  &CP,  &CP, // B
  &RNZ, &POP,&JPNZ,  &JP, &CNZ,&PUSH,&ADDI, &RST, &REZ, &RET, &JPZ,&CBCO,  &CZ,&CALL,&ADCI, &RST, // C
  &RNC, &POP,&JPNC, &NOP, &CNC,&PUSH,&SUBI, &RST, &REC, &REI, &JPC, &NOP,  &CC, &NOP,&SBCI, &RST, // D
  &LDH, &POP,&LDCA, &NOP, &NOP,&PUSH,&ANDI, &RST,&ADDS,&JPHL,&LDIA, &NOP, &NOP, &NOP,&XORI, &RST, // E
 &LDHR, &POP,&LDAC,  &DI, &NOP,&PUSH, &ORI, &RST,&LSHL,&LDSH,&LDAI,  &EI, &NOP, &NOP, &CPI, &RST};// F

byte map8arg1[0x100] = 
// 0  1   2   3   4   5   6   7   8   9   A   B   C   D   E   F
{ 00, 00, BC, BC, RB, RB, RB, RA, 00, BC, RA, BC, RC, RC, RC, RA, // 0
  00, 00, DE, DE, RD, RD, RD, RA, 00, DE, RA, DE, RE, RE, RE, RA, // 1
  00, 00, HL, HL, RH, RH, RH, 00, 00, HL, RA, HL, RL, RL, RL, 00, // 2
  00, 00, HL, SP, HL, HL, HL, 00, 00, SP, RA, SP, RA, RA, RA, 00, // 3
  RB, RB, RB, RB, RB, RB, RB, RB, RC, RC, RC, RC, RC, RC, RC, RC, // 4
  RD, RD, RD, RD, RD, RD, RD, RD, RE, RE, RE, RE, RE, RE, RE, RE, // 5
  RH, RH, RH, RH, RH, RH, RH, RH, RL, RL, RL, RL, RL, RL, RL, RL, // 6
  HL, HL, HL, HL, HL, HL, 00, HL, RA, RA, RA, RA, RA, RA, RA, RA, // 7
  RB, RC, RD, RE, RH, RL, HL, RA, RB, RC, RD, RE, RH, RL, HL, RA, // 8
  RB, RC, RD, RE, RH, RL, HL, RA, RB, RC, RD, RE, RH, RL, HL, RA, // 9
  RB, RC, RD, RE, RH, RL, HL, RA, RB, RC, RD, RE, RH, RL, HL, RA, // A
  RB, RC, RD, RE, RH, RL, HL, RA, RB, RC, RD, RE, RH, RL, HL, RA, // B
  00, BC, 00, 00, 00, BC, 00, 00, 00, 00, 00, 00, 00, 00, 00,  8, // C
  00, DE, 00, 00, 00, DE, 00, 16, 00, 00, 00, 00, 00, 00, 00, 24, // D
  00, HL, 00, 00, 00, HL, 00, 32, 00, 00, 00, 00, 00, 00, 00, 40, // E
  00, AF, 00, 00, 00, AF, 00, 48, 00, 00, 00, 00, 00, 00, 00, 56 }; // F


byte map8arg2[0x100] =
// 0  1   2   3   4   5   6   7   8   9   A   B   C   D   E   F
{ 00, 00, RA, 00, 00, 00, 00, 00, 00, 00, BC, 00, 00, 00, 00, 00, // 0
  00, 00, RA, 00, 00, 00, 00, 00, 00, 00, DE, 00, 00, 00, 00, 00, // 1
  00, 00, RA, 00, 00, 00, 00, 00, 00, 00, HL, 00, 00, 00, 00, 00, // 2
  00, 00, RA, 00, 00, 00, 00, 00, 00, 00, HL, 00, 00, 00, 00, 00, // 3
  RB, RC, RD, RE, RH, RL, HL, RA, RB, RC, RD, RE, RH, RL, HL, RA, // 4
  RB, RC, RD, RE, RH, RL, HL, RA, RB, RC, RD, RE, RH, RL, HL, RA, // 5
  RB, RC, RD, RE, RH, RL, HL, RA, RB, RC, RD, RE, RH, RL, HL, RA, // 6
  RB, RC, RD, RE, RH, RL, 00, RA, RB, RC, RD, RE, RH, RL, HL, RA, // 7
  00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, // 8
  00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, // 9
  00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, // A
  00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, // B
  00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, // C
  00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, // D
  00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, // E
  00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00 }; // F


byte map8icount[0x100] =
//0  1  2  3  4  5  6  7  8  9  A  B  C  D  E  F
{ 0, 2, 0, 0, 0, 0, 1, 0, 2, 0, 0, 0, 0, 0, 1, 0, // 0
  1, 2, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1, 0, // 1
  1, 2, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1, 0, // 2
  1, 2, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1, 0, // 3
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, // 4
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, // 5
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, // 6
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, // 7
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, // 8
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, // 9
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, // A
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, // B
  0, 0, 2, 2, 2, 0, 1, 0, 0, 0, 2, 1, 2, 2, 1, 0, // C
  0, 0, 2, 0, 2, 0, 1, 0, 0, 0, 2, 0, 2, 0, 1, 0, // D
  1, 0, 0, 0, 0, 0, 1, 0, 1, 0, 2, 0, 0, 0, 1, 0, // E
  1, 0, 0, 0, 0, 0, 1, 0, 1, 0, 2, 0, 0, 0, 1, 0};// F


byte map8timing[0x100] =
//0  1  2  3  4  5  6  7  8  9  A  B  C  D  E  F
{ 0,12, 8, 8, 0, 0, 8, 0,20, 8, 8, 8, 0, 0, 8, 0, // 0
  0,12, 8, 8, 0, 0, 8, 0, 8, 8, 8, 8, 0, 0, 8, 0, // 1
  8,12, 8, 8, 0, 0, 8, 0, 8, 8, 8, 8, 0, 0, 8, 0, // 2
  8,12, 8, 8,12,12,12, 0, 8, 8, 8, 8, 0, 0, 8, 0, // 3
  0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 8, 0, // 4
  0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 8, 0, // 5
  0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 8, 0, // 6
  8, 8, 8, 8, 8, 8, 0, 8, 0, 0, 0, 0, 0, 0, 8, 0, // 7
  0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 8, 0, // 8
  0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, // 9
  0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 8, 0, // A
  0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 8, 0, // B
  8,12,12,12,12,16, 8,32, 8, 8,12, 8,12,12, 8,32, // C
  8,12,12, 0,12,16, 8,32, 8, 8,12, 0,12, 0, 0,32, // D
 12,12, 8, 0, 0,16, 8,32,16, 0,16, 0, 0, 0, 8,32, // E
 12,12, 8, 0, 0,16, 8,32,12, 8,16, 0, 0, 0, 8,32};// F


//Mapping for 16 bit CB instructions
void* map16[0x100] = 
// 0    1     2     3     4     5     6     7     8     9     A     B     C     D     E     F
{ &RLC, &RLC, &RLC, &RLC, &RLC, &RLC, &RLC, &RLC, &RRC, &RRC, &RRC, &RRC, &RRC, &RRC, &RRC, &RRC, // 0
  &ROL, &ROL, &ROL, &ROL, &ROL, &ROL, &ROL, &ROL, &ROR, &ROR, &ROR, &ROR, &ROR, &ROR, &ROR, &ROR, // 1
  &SLA, &SLA, &SLA, &SLA, &SLA, &SLA, &SLA, &SLA, &SRA, &SRA, &SRA, &SRA, &SRA, &SRA, &SRA, &SRA, // 2
 &SWAP,&SWAP,&SWAP,&SWAP,&SWAP,&SWAP,&SWAP,&SWAP, &SRL, &SRL, &SRL, &SRL, &SRL, &SRL, &SRL, &SRL, // 3
  &BIT, &BIT, &BIT, &BIT, &BIT, &BIT, &BIT, &BIT, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, // 4
  &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, // 5
  &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, // 6
  &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, // 7
  &RES, &RES, &RES, &RES, &RES, &RES, &RES, &RES, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, // 8
  &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, // 9
  &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, // A
  &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, // B 
  &SET, &SET, &SET, &SET, &SET, &SET, &SET, &SET, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, // C
  &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, // D
  &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, // E
  &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP, &NOP  // F
};

//Mapping for 16 bit CB instruction arguments
byte map16arg[0x100] = 
// 0  1   2   3   4   5   6   7   8   9   A   B   C   D   E   F
{ RB, RC, RD, RE, RH, RL, HL, RA, RB, RC, RD, RE, RH, RL, HL, RA, // 0
  RB, RC, RD, RE, RH, RL, HL, RA, RB, RC, RD, RE, RH, RL, HL, RA, // 1
  RB, RC, RD, RE, RH, RL, HL, RA, RB, RC, RD, RE, RH, RL, HL, RA, // 2
  RB, RC, RD, RE, RH, RL, HL, RA, RB, RC, RD, RE, RH, RL, HL, RA, // 3
  RB, RC, RD, RE, RH, RL, HL, RA, 00, 00, 00, 00, 00, 00, 00, 00, // 4
  00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, // 5
  00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, // 6
  00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, // 7
  RB, RC, RD, RE, RH, RL, HL, RA, 00, 00, 00, 00, 00, 00, 00, 00, // 8
  00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, // 9
  00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, // A
  00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, // B
  RB, RC, RD, RE, RH, RL, HL, RA, 00, 00, 00, 00, 00, 00, 00, 00, // C
  00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, // D
  00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, // E
  00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, // F
};

// Mapping for 16 bit timings
byte map16timing[0x100] = 
// 0  1   2   3   4   5   6   7   8   9   A   B   C   D   E   F
{  8,  8,  8,  8,  8,  8, 16,  8,  8,  8,  8,  8,  8,  8, 16,  8, // 0
   8,  8,  8,  8,  8,  8, 16,  8,  8,  8,  8,  8,  8,  8, 16,  8, // 1
   8,  8,  8,  8,  8,  8, 16,  8,  8,  8,  8,  8,  8,  8, 16,  8, // 2
  00, 00, 00, 00, 00, 00, 00, 00,  8,  8,  8,  8,  8,  8, 16,  8, // 3
   8,  8,  8,  8,  8,  8, 16,  8, 00, 00, 00, 00, 00, 00, 00, 00, // 4
  00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, // 5
  00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, // 6
  00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, // 7
   8,  8,  8,  8,  8,  8, 16,  8, 00, 00, 00, 00, 00, 00, 00, 00, // 8
  00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, // 9
  00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, // A
  00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, // B
   8,  8,  8,  8,  8,  8, 16,  8, 00, 00, 00, 00, 00, 00, 00, 00, // C
  00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, // D
  00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, // E
  00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, // F
};

inline void setZ() {
	REG->F = REG->F | 0x80;
}

inline void setN() {
	REG->F = REG->F | 0x40;
}

inline void setH() {
	REG->F = REG->F | 0x20;
}

inline void setC() {
	REG->F = REG->F | 0x10;
}

inline void resetZ() {
	REG->F = REG->F & 0x7F;
}

inline void resetN() {
	REG->F = REG->F & 0xBF;
}

inline void resetH() {
	REG->F = REG->F & 0xDF;
}

inline void resetC() {
	REG->F = REG->F & 0xEF;
}

inline byte getZ() {
	return (REG->F & 0x80) >> 7;
}

inline byte getN() {
	return (REG->F & 0x40) >> 6;
}

inline byte getH() {
	return (REG->F & 0x20) >> 5;
}

inline byte getC() {
	return (REG->F & 0x10) >> 4;
}

inline char getRegType(char reg) {
	if (reg == SP || reg == PC || reg == AF || reg == BC || reg == DE || reg == HL)
		return 16;
	else
		return 8;
}

inline void radd(char reg, byte imm, char doflag) {
	if (doflag) 
		resetN();
	if (getRegType(reg) == 16) {
		word val = read16r(reg);
		byte hin = val >> 8;
		byte lon = val & 0xFF;
		byte carry = 0;
		
		// Lower byte carry 
		if ((int) lon + (int) imm > 0xFF) 
			carry = 1;
		lon += imm;
		
		if (doflag) {
			if ((hin & 0xF + carry) > 0xF)
				setH();
			else
				resetH();
			if ((int) hin + (int) carry > 0xFF)
				setC();
			else
				resetC();
		}
		hin += carry;
		val = (hin << 8) | lon;
		if (val == 0 && doflag)
			setZ();
		if (val != 0 && doflag)
			resetZ();
		write16r(reg, val);
		return;
	} 
	byte val  = read8r(reg);
	if (doflag) {
		if ((val & 0xF) + (imm & 0xF) > 0xF)
			setH();
		else
			resetH();
		if ((int) val + (int) imm > 0xFF)
			setC();
		else
			resetC();
	}
	val += imm;
	if (val == 0 && doflag)
		setZ();
	else if (doflag)
		resetZ();
	write8r(reg, val);
}

inline void rsub(char reg, byte imm, char doflag, char ncp) {
	if (doflag)
		setN();
	// Only used in decrementing - no flag setting
	if (getRegType(reg) == 16) {
		word val = read16r(reg);
		val -= imm;
		write16r(reg, val);
		return;
	}
	byte val = read8r(reg);
	if (doflag) {
		// Set if borrow
		if ((val & 0xF) < (imm & 0xF)) {
			setH();
		} else
			resetH();
		if (val < imm) {
			setC();
		} else
			resetC();
	}
	val -= imm;
	if (val == 0 && doflag)
		setZ();
	else if(doflag)
		resetZ();
	if (ncp)
		write8r(reg, val);
}

void radd16i(char r1, byte n) {
	resetN();
	word val1 = read16r(r1);
	word tval = val1;
	signed char val2 = n;
	word v111 = val1 & 0xFFF;
	signed char v211 = val2;
	val1 += val2;
	if (val2 > 0) {
		if (v111 + v211 > 0xFFF)
			setH();
		else
			resetH();
		if ( (int) val1 + (int) val2 > 0xFFFF) 
			setC();
		else
			resetC();
	} else {
		if ((val1 & 0xF) < (tval & 0xF))
			setH();
		else
			resetH();
		if ((val1 & 0xFF) < (tval & 0xFF))
			setC();
		else
			resetC();
	}
	if (val1 == 0)
		setZ();
	else
		resetZ();
	write16r(r1, val1);
}

void radd16(char r1, char r2) {
	resetN();
	word val1 = read16r(r1);
	word val2 = read16r(r2);
	word v111 = val1 & 0xFFF;
	word v211 = val2 & 0xFFFF;
	if (v111 + v211 > 0xFFF)
		setH();
	else
		resetH();
	if ( (int) val1 + (int) val2 > 0xFFFF) 
		setC();
	else
		resetC();
	val1 += val2;
	write16r(r1, val1);
}

byte read8r(char reg) {
	/*
	switch (reg) {
		case RA:
			return REG->A;
		case RB:
			return REG->B;
		case RC:
			return REG->C;
		case RD:
			return REG->D;
		case RE:
			return REG->E;
		case RF:
			return REG->F;
		case RH:
			return REG->H;
		case RL:
			return REG->L;
	}*/
	return *(rmap[reg]);
}

word read16r(char reg) {
	switch (reg) {
		case SP:
			return REG->SPR;
		case PC:
			return REG->PCR;
		case AF:
			return (REG->A << 8) | REG->F;
		case BC:
			return (REG->B << 8) | REG->C;
		case DE:
			return (REG->D << 8) | REG->E;
		case HL:
			return (REG->H << 8) | REG->L;
	}	
}


void write8r(char reg, byte val) {
	/*
	switch (reg) {
		case RA:
			REG->A = val; return;
		case RB:
			REG->B = val; return;
		case RC:
			REG->C = val; return;
		case RD:
			REG->D = val; return;
		case RE:
			REG->E = val; return;
		case RF:
			REG->F = val; return;
		case RH:
			REG->H = val; return;
		case RL:
			REG->L = val; return;
	}*/

	*(rmap[reg]) = val;

	return;
}

void write16r(char reg, word val) {
	switch (reg) {
		case SP: 
			REG->SPR = val; return;
		case PC:
			REG->PCR = val; return;
		case AF:
			REG->A = (byte) (val >> 8); REG->F = (byte) (val & 0xF0); return;
		case BC:
			REG->B = (byte) (val >> 8); REG->C = (byte) (val & 0xFF); return;
		case DE:
			REG->D = (byte) (val >> 8); REG->E = (byte) (val & 0xFF); return;
		case HL:
			REG->H = (byte) (val >> 8); REG->L = (byte) (val & 0xFF); return;
	}	
}

// Loads
void LDRR(byte r1, byte r2)	// Load reg2 -> reg1
{
	word addr;
	byte val;
	// 16 bit r1 - load into addy
	if (getRegType(r1) == 16) {
		addr = read16r(r1);
		val = read8r(r2);
		writebyte(addr, val);
		return;
	}
	// 16 bit r2 - load from addy
	if (getRegType(r2) == 16) {
		addr = read16r(r2);
		val = readbyte(addr);
		write8r(r1, val);
		return;
	}
	// regular load
	write8r(r1, read8r(r2));
}

void LDRN(byte r1, byte n)	// Load n -> reg
{
	// 16 bit addr - load into addy pointed to
	if (getRegType(r1) == 16) {
		word addr = read16r(r1);
		writebyte(addr, n);
		return;
	}
	// 8 bit addr - load into reg
	write8r(r1, n);
}
void LDAI(byte n1, byte n2)	// Load (nn) -> A 
{
	word addr = (n2 << 8) | n1;
	byte val = readbyte(addr);
	write8r(RA, val);
}

void LDIA(byte n1, byte n2)	// Load A -> (nn)
{
	word addr = (n2 << 8) | n1;
	byte val = read8r(RA);
	writebyte(addr, val);
}

void LDAC(byte y, byte z)	// Load (0xFF00+C)->A 
{
	word cv = 0xFF00 + read8r(RC);
	write8r(RA, readbyte(cv));
}

void LDCA(byte y, byte z)	// Load A->(0xFF00+C)
{
	word cv = 0xFF00 + read8r(RC);
	writebyte(cv, read8r(RA));
}

// TODO: optimize incrementing and decrementing
void LDD(byte r1, byte r2)	// (HL)->A, HL-- OR A->(HL), HL--
{
	if (r1 != HL) {
		word addr = read16r(HL);
		write8r(RA, readbyte(addr));
	} else {
		word addr = read16r(HL);
		writebyte(addr, read8r(RA));
	}
	rsub(HL, 1, 0, 1);
}

void LDI(byte r1, byte r2)	// (HL)->A, HL++ OR A->(HL), HL++
{
	if (r2 == HL) {
		word addr = read16r(HL);
		write8r(RA, readbyte(addr));
	} else {
		word addr = read16r(HL);
		writebyte(addr, read8r(RA));
	}
	radd(HL, 1, 0);
}

void LDH(byte n, byte z)	// A->(0xFF00+n)
{
	word addr = 0xFF00 + n;
	writebyte(addr, read8r(RA));
}

void LDHR(byte n, byte z)	// (0xFF00+n)->A
{
	word addr = 0xFF00 + n;
	byte val = readbyte(addr);
	write8r(RA, val);
}

void LDBC(byte n1, byte n2) {
	word val = n1 | (n2 << 8);
	write16r(BC, val);
}

void LDDE(byte n1, byte n2) {
	word val = n1 | (n2 << 8);
	write16r(DE, val);
}

void LDHL(byte n1, byte n2) {
	word val = n1 | (n2 << 8);
	write16r(HL, val);
}

void LDSP(byte n1, byte n2) {
	word val = n1 | (n2 << 8);
	write16r(SP, val);
}

void LDSH(byte y, byte z) {	// HL->SP
	write16r(SP, read16r(HL));
}

void LSHL(byte n, byte z) {	// SP+n->HL
	write16r(HL, read16r(SP));
	radd16i(HL, n);
}

void LSHN(byte n1, byte n2) { 	// SP->(nn)
	word addr = (n2 << 8) | n1;
	word sp = read16r(SP);
	writeword(addr, sp);
}

void PUSH(byte r, byte z) {	// Push r onto stack, decr sp x2
	word val = read16r(r);
	rsub(SP, 2, 0, 1);
	word addr = read16r(SP);
	//if (dstate == 0)
	//	printf("Pushing - Pushed value is : %d, SP is now %D\n", val, addr);
	writeword(addr, val);
}

void POP(byte r, byte z) {	// Pop word off stack, incr sp x2
	word addr = read16r(SP);
	word val = readword(addr);
	radd(SP, 2, 0);
	write16r(r, val);
	//if (dstate == 0)
	//	printf("Popping - popped value is : %d, SP is now %D\n", val, addr);
}

// 8 bit ALU
void ADD(byte r, byte z) {
	byte val;
	if (getRegType(r) == 16) {
		word addr = read16r(r);
		val = readbyte(addr);
	}
	else
		val = read8r(r);
	radd(RA, val, 1);
}

void ADDI(byte n, byte z) {
	radd(RA, n, 1);
}

void ADC(byte r, byte z) {
	byte val;
	if (getRegType(r) == 16) {
		word addr = read16r(r);
		val = readbyte(addr);
	}
	else
		val = read8r(r);
	if (getC())
		val ++;
	radd(RA, val, 1);
}

void ADCI(byte n, byte z) {
	if (getC())
		n ++;
	radd(RA, n, 1);
}

void SUB(byte r, byte z) {
	byte val;
	if (getRegType(r) == 16) {
		word addr = read16r(r);
		val = readbyte(addr);
	}
	else
		val = read8r(r);
	rsub(RA, val, 1, 1);
}

void SUBI(byte n, byte z) {
	rsub(RA, n, 1, 1);
}

void SBC(byte r, byte z) {	
	byte val;
	if (getRegType(r) == 16) {
		word addr = read16r(r);
		val = readbyte(addr);
	}
	else
		val = read8r(r);
	if (getC())
		val++;
	rsub(RA, val, 1, 1);
}

void SBCI(byte n, byte z) {
	if (getC())
		n++;
	rsub(RA, n, 1, 1);
}

void AND(byte r, byte z) {
	byte val;
	byte ra = read8r(RA);
	if (getRegType(r) == 16) {
		word addr = read16r(r);
		val = readbyte(addr);
	}
	else
		val = read8r(r);
	val = val & ra;
	write8r(RA, val);
	if (val == 0)
		setZ();
	else
		resetZ();
	resetN();
	setH();
	resetC();
}

void ANDI(byte n, byte z) {
	byte ra = read8r(RA);
	ra = ra & n;
	write8r(RA, ra);
	if (ra == 0)
		setZ();
	else
		resetZ();
	resetN();
	setH();
	resetC();
}

void OR(byte r, byte z) {
	byte val;
	byte ra = read8r(RA);
	if (getRegType(r) == 16) {
		word addr = read16r(r);
		val = readbyte(addr);
	}
	else
		val = read8r(r);
	val = val | ra;
	write8r(RA, val);
	if (val == 0)
		setZ();
	else
		resetZ();
	resetN();
	resetH();
	resetC();
}

void ORI(byte n, byte z) {
	byte ra = read8r(RA);
	ra = ra | n;
	write8r(RA, ra);
	if (ra == 0)
		setZ();
	else
		resetZ();
	resetN();
	resetH();
	resetC();
}

void XOR(byte r, byte z) {
	byte val;
	byte ra = read8r(RA);
	if (getRegType(r) == 16) {
		word addr = read16r(r);
		val = readbyte(addr);
	}
	else
		val = read8r(r);
	val = val ^ ra;
	write8r(RA, val);
	if (val == 0)
		setZ();
	else
		resetZ();
	resetN();
	resetH();
	resetC();
}

void XORI(byte n, byte z) {
	byte ra = read8r(RA);
	ra = ra ^ n;
	write8r(RA, ra);
	if (ra == 0)
		setZ();
	else
		resetZ();
	resetN();
	resetH();
	resetC();
}

void CP(byte r, byte z) {
	byte val;
	if (getRegType(r) == 16) {
		word addr = read16r(r);
		val = readbyte(addr);
	}
	else
		val = read8r(r);
	rsub(RA, val, 1, 0);
}

void CPI(byte n, byte z) {
	rsub(RA, n, 1, 0);
}

void INCH(byte r, byte z) {
	write16r(r, read16r(r) + 1);
}

void INC(byte r, byte z) {
	byte val;
	byte cflag = getC();
	if (r == HL) {
		word addr = read16r(r);
		val = readbyte(addr);
		val ++;
		if ((val & 0xF) == 0)
			setH();
		else
			resetH();
		resetN();
		if (val == 0)
			setZ();
		else
			resetZ();
		writebyte(addr, val);
	}
	else if (getRegType(r) == 16) {
		radd(r, 1, 0);
	}

	else {
		radd(r, 1, 1);
	}
	if (cflag)
		setC();
	else
		resetC();
}

void DECH(byte r, byte z) {
	rsub(r, 1, 0, 1);
}

void DEC(byte r, byte z) {	
	byte val;
	byte cflag = getC();
	if (getRegType(r) == 16) {
		word addr = read16r(r);
		val = readbyte(addr);
		val --;
		if ((val & 0xF) == 0xF)
			setH();
		else
			resetH();
		setN();
		if (val == 0)
			setZ();	
		else
			resetZ();
		writebyte(addr, val);
	}

	else {
		rsub(r, 1, 1, 1);
	}
	if (cflag)
		setC();
	else
		resetC();
}

// 16 bit ALU
void ADDH(byte r, byte z) {
	radd16(HL, r);
}

void ADDS(byte n, byte z) {
	radd16i(SP, n);
}

// CB instruction handler
void CBCO(byte c, byte z) {
	//if (dstate == 0)
	//	printf("Running inst %00X\n", c);
	byte disp = (c & 0x38) >> 3;
	byte inst = c & 0xC7;
	void (*instf)();
	byte arg1;
	byte arg2;
	if ((inst >= 0x40 && inst <= 0x47) || 
	    (inst >= 0xC0 && inst <= 0xC7) ||
	    (inst >= 0x80 && inst <= 0x87) ) {
		instf = map16[inst];
		arg1 = map16arg[inst];
		arg2 = disp;
	} else {
		instf = map16[c];
		arg1 = map16arg[c];
		arg2 = 0;
	}
	//TODO: Add onto timing for CB instructions
	(*instf)(arg1, arg2);
	return;
}

// Misc
void SWAP(byte r, byte z) {
	resetN();
	resetH();
	resetC();
	byte val;
	word addr;
        if (r == HL) {
                addr = read16r(r);
                val = readbyte(addr);
        }
        else
                val = read8r(r);	
	byte newval = ((val & 0xF) << 4) | (val >> 4);
	if (r == HL) 
		writebyte(addr, newval);
	else
		write8r(r, newval);
	
	if (newval == 0)
		setZ();
	else
		resetZ();
}

void DAA(byte y, byte z) {
	//fprintf(stderr, "DAA is being called\n");
	byte val = read8r(RA);
	if ((val & 0xF) > 9) {
		setH();
		val += 0x06;
	} else
		resetH();
	// TODO: Check to see if the GB cares if carry flag is set	
	if (val >> 4 > 9) {
		setC();
		val += 0x60;
	} else
		resetC();
	write8r(RA, val);
}

/*
void DAA(byte y, byte z) {
	byte val = read8r(RA);
	int eflags;
	printf("DAA: Input: %02X\n", val);
	asm("das; pushfd; pop %%ecx"
		:"=a" (val), "=c" (eflags)
		:"a" (val) );
	printf("Outputs: %02X %0X\n", val, eflags);
	
	if (eflags & 0x1) 
		setC();
	else
		resetC();
	
	if (eflags >> 4 & 0x1)
		setH();
	else
		resetH();

	write8r(RA, val);
}*/

void CPL(byte y, byte z) {
	setN();
	setH();
	write8r(RA, ~(read8r(RA)));
}

void CCF(byte y, byte z) {
	resetN();
	resetH();
	if (getC())
		resetC();
	else
		setC();
}

void SCF(byte y, byte z) {
	resetN();
	resetH();
	setC();
}

void NOP(byte y, byte z) {

}

void HALT(byte y, byte z) {
	HALTED = 1;
}

void STOP(byte y, byte z) {
	fprintf(stderr, "Stopping.\n");
	STOPPED = 1;
}

void DI(byte y, byte z) {
	IEMASTERR = 0;
}

void EI(byte y, byte z) {
	//if (dstate == 0)
	//	printf("Next opcode: %02X\n", readbyte(read16r(PC)));
	//if (readbyte(read16r(PC)) == 0xF3)
	//	writebyte(0xFFF0, 0);
	//else
	IEMASTERR = 1;
}

// Rotates/shifts
void RLC(byte r, byte z) {
	resetN();
	resetH();
	byte val;
	if (r == HL) 
		val = readbyte(read16r(HL));
	else
		val = read8r(r);
	byte carry = val >> 7;
	val = val << 1;
	val = val | carry;
	if (carry)
		setC();
	else
		resetC();
	if (val == 0) {
		setZ();
	}
	else
		resetZ();
	if (r == HL)
		writebyte(read16r(HL), val);
	else
		write8r(r, val);
}

void ROL(byte r, byte z) {
	resetN();
	resetH();
	byte val;
	if (r == HL) 
		val = readbyte(read16r(HL));
	else
		val = read8r(r);
	byte carry = val >> 7;
	val = val << 1;
	if (getC())
		val = val | 1;
	if (carry)
		setC();
	else
		resetC();
	if (val == 0)
		setZ();
	else
		resetZ();
	if (r == HL)
		writebyte(read16r(HL), val);
	else
		write8r(r, val);
}

void RRC(byte r, byte z) {
	resetN();
	resetH();
	byte val;
	if (r == HL) 
		val = readbyte(read16r(HL));
	else
		val = read8r(r);
	byte carry = val & 0x1;
	val = val >> 1;
	val = val | (carry << 7);
	if (carry)
		setC();
	else
		resetC();
	if (val == 0) {
		setZ();
	}
	else
		resetZ();
	if (r == HL)
		writebyte(read16r(HL), val);
	else
		write8r(r, val);
}

void ROR(byte r, byte z) {
	resetN();
	resetH();
	byte val;
	if (r == HL) 
		val = readbyte(read16r(HL));
	else
		val = read8r(r);
	byte carry = val & 0x1;
	val = val >> 1;
	if (getC())
		val = val | 0x80;
	if (carry)
		setC();
	else
		resetC();
	if (val == 0)
		setZ();
	else
		resetZ();
	if (r == HL)
		writebyte(read16r(HL), val);
	else
		write8r(r, val);
}

void SLA(byte r, byte z) {
	resetN();
	resetH();
	byte val;
	if (r == HL)
		val = readbyte(read16r(HL));
	else
		val = read8r(r);
	byte carry = val >> 7;
	if (carry)
		setC();
	else
		resetC();
	val = val << 1;
	if (val == 0)
		setZ();
	else
		resetZ();
	if (r == HL)
		writebyte(read16r(HL), val);
	else
		write8r(r, val);
}

void SRA(byte r, byte z) {
	resetN();
	resetH();
	byte val;
	if (r == HL)
		val = readbyte(read16r(HL));
	else
		val = read8r(r);
	byte carry = val & 0x1;
	byte msb = val & 0x80;
	if (carry)
		setC();
	else
		resetC();
	val = val >> 1;
	val = val | msb;
	if (val == 0)
		setZ();
	else
		resetZ();
	if (r == HL)
		writebyte(read16r(HL), val);
	else
		write8r(r, val);
}

void SRL(byte r, byte z) {
	resetN();
	resetH();
	byte val;
	if (r == HL)
		val = readbyte(read16r(HL));
	else
		val = read8r(r);
	byte carry = val & 0x1;
	if (carry)
		setC();
	else
		resetC();
	val = val >> 1;
	if (val == 0)
		setZ();
	else
		resetZ();
	if (r == HL)
		writebyte(read16r(HL), val);
	else
		write8r(r, val);
}

// Bit opcodes
void BIT(byte r, byte b) {
	resetN();
	setH();
	byte val;
	if (r == HL) 
		val = readbyte(read16r(HL));
	else
		val = read8r(r);
	
	val = (val >> b) & 0x1;
	if (!val)
		setZ();
	else
		resetZ();
}

void SET(byte r, byte b) {
	byte val;
	if (r == HL)
		val = readbyte(read16r(HL));
	else
		val = read8r(r);
	byte bit = 0x1 << b;
	val = val | bit;
	if (r == HL)
		val = writebyte(read16r(HL), val);
	else
		write8r(r, val);
}


void RES(byte r, byte b) {
	byte val;
	if (r == HL)
		val = readbyte(read16r(HL));
	else
		val = read8r(r);
	byte bit = 0x0; 
	bit = (~(((byte)0x01) << b));
	val = val & bit;
	if (r == HL)
		val = writebyte(read16r(HL), val);
	else
		write8r(r, val);
}

// Jumps
void JP(byte n1, byte n2) {
	write16r(PC, (n2 << 8) | n1);
}

void JPNZ(byte n1, byte n2) {
	if (!getZ())
		JP(n1, n2);
}

void JPZ(byte n1, byte n2) {
	if (getZ())
		JP(n1, n2);
}

void JPNC(byte n1, byte n2) {
	if (!getC())
		JP(n1, n2);
}

void JPC(byte n1, byte n2) {
	if (getC())
		JP(n1, n2);
}

void JPHL(byte y, byte z) {
	word address = read16r(HL);
	write16r(PC, address);
}

void JR(byte n, byte z) {
	word address = read16r(PC);
	signed char disp = n;
	//if (dstate == 0)
	//	printf("JR: displacement:%d\n",disp);
	address += disp;
	write16r(PC, address);
}

void JRNZ(byte n, byte z) {
	if (!getZ())
		JR(n, z);
}

void JRZ(byte n, byte z) {
	if (getZ())
		JR(n, z);
}

void JRNC(byte n, byte z) {
	if (!getC())
		JR(n, z);
}

void JRC(byte n, byte z) {
	if (getC())
		JR(n, z);
}

// Calls
void CALL(byte n1, byte n2) {
	//write16r(PC, read16r(PC) + 3);
	PUSH(PC, 0);
	JP(n1, n2);
}

void CNZ(byte n1, byte n2) {
	if (!getZ())
		CALL(n1, n2);
}

void CZ(byte n1, byte n2) {
	if (getZ())
		CALL(n1, n2);
}

void CNC(byte n1, byte n2) {
	if (!getC())
		CALL(n1, n2);
}

void CC(byte n1, byte n2) {
	if (getC())
		CALL(n1, n2);
}

// Resets
void RST(byte n1, byte n2) {
	CALL(n1, n2);
}

// Pop directly onto PC
void RET(byte y, byte z) {
	POP(PC, 0);
}

void RNZ(byte y, byte z) {
	if (!getZ())
		RET(0,0);
}

void REZ(byte y, byte z) {
	if (getZ())
		RET(0,0);
}

void RNC(byte y, byte z) {
	if (!getC())
		RET(0,0);
}

void REC(byte y, byte z) {
	if (getC())
		RET(0,0);
}

void REI(byte y, byte z) {
	RET(0,0);
	EI(0,0);
}
