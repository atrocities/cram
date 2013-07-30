#include <stdio.h>
#include <string.h>

#include "cram.h"
#include "mem.h"
#include "loader.h"
#include "opcode.h"
#include "cpu.h"
#include "video.h"
#include "mbc.h"

registers* REG;
unsigned long CLK;

int ICS;
byte TENABLE;
byte ICLK;
byte ICLKE;
word bi;

unsigned int TIMERCNT;
byte OLDDIV;
byte STOPPED;
byte HALTED;
byte IEMASTER;
byte IEMASTERR;

byte DMADELAY;

word breakpoint;
word meml;
byte dstate;

int initCpu() {
	REG = (registers*) malloc(sizeof(registers));
	if (REG == NULL)
		return -1;
        rmap[0] = &(REG->A);
        rmap[1] = &(REG->A);
        rmap[2] = &(REG->B);
        rmap[3] = &(REG->C);
        rmap[4] = &(REG->D);
        rmap[5] = &(REG->E);
        rmap[6] = &(REG->F);
        rmap[7] = &(REG->H);
        rmap[8] = &(REG->L);
	ICS = 4096;
	TENABLE = 0;
	return 0;
}

int boot() {
	char* buf;
	/* Set default values for regs and IO memory section */
	write16r(AF, 0x01B0);
	write16r(BC, 0x0013);
	write16r(DE, 0x00D8);
	write16r(HL, 0x014D);
	write16r(SP, 0xFFFE);
	writebyte(0xFF05, 0x00);
	writebyte(0xFF06, 0x00);
	writebyte(0xFF07, 0x00);
	writebyte(0xFF10, 0x80);
	writebyte(0xFF11, 0xBF);
	writebyte(0xFF12, 0xF3);
	writebyte(0xFF14, 0xBF);
	writebyte(0xFF16, 0x3F);
	writebyte(0xFF17, 0x00);
	writebyte(0xFF19, 0xBF);
	writebyte(0xFF1A, 0x7F);
	writebyte(0xFF1B, 0xFF);
	writebyte(0xFF1C, 0x9F);
	writebyte(0xFF1E, 0xBF);
	writebyte(0xFF20, 0xFF);
	writebyte(0xFF21, 0x00);
	writebyte(0xFF22, 0x00);
	writebyte(0xFF23, 0xBF);
	writebyte(0xFF24, 0x77);
	writebyte(0xFF25, 0xF3);
	writebyte(0xFF26, 0xF1);
	writebyte(0xFF40, 0x91);
	writebyte(0xFF42, 0x00);
	writebyte(0xFF43, 0x00);
	writebyte(0xFF45, 0x00);
	writebyte(0xFF47, 0xFC);
	writebyte(0xFF48, 0xFF);
	writebyte(0xFF49, 0xFF);
	writebyte(0xFF4A, 0xFF);
	writebyte(0xFF4B, 0x00);
	writebyte(0xFFFF, 0x00);
	/* Begin execution at 0x100 */
	write16bit('P','C', 0x100);
	ICLK = 0;
	ICLKE = 0;
	STOPPED = 0;
	HALTED = 0;
	IEMASTER = 1;
	OLDDIV = 0;
	DMADELAY = 0;
	initVideo();
	bi = 0x1;
	//while(1) 
	//	step();
	dstate = 0;
	breakpoint = 0x0100;
	//debug();
	//dstate = 1;
	doVideoLoop();
}

void hexdump(word addr, word length, int desc) {
	fprintf(desc, "Hex dump for address %04X\n", addr);
	int i = 0;
	int j = 0;
	byte *buf;
	buf = (byte*)malloc(length * sizeof(byte));
	map(addr, buf, length, 'r');
	fprintf(desc, "       ");
	for (i = 0; i < 16; i ++) {
		fprintf(desc, "%01X  ", i);
	}
	fprintf(desc, "\n");
	for (i = 0; i < 18; i ++) {
		fprintf(desc, "---", i);
	}
	fprintf(desc, "\n");
	i = 0;
	while (i < length) {
		if (j == 0) 
			fprintf(desc, "%04X | ", addr + i);
		fprintf(desc, "%02X ", buf[i]);
		i ++;
		j ++;
		if (j == 16) {
			fprintf(desc, "\n");
			j = 0;
		}
	}
	free(buf);
}

void debug() {
	if (dstate == 1) {
		if (read16r(PC) != breakpoint)
			return;
		else {
			printf("At breakpoint %04X\n", breakpoint);
			dstate = 0;
		}
	}
	char buf[256];
	buf[0] = 0;
	printf("\nDEBUG %0000X> ", read16r(PC));
	scanf("%s", &buf);
	if(strlen(buf) == 0)
		return;
	if(strcmp(buf, "s") == 0) {
		dstate = 0;
		return;
	}
	if(strcmp(buf, "b") == 0) {
		printf("New breakpoint: ");
		scanf("%x", &breakpoint);
		dstate = 1;
	}
	if(strcmp(buf, "i") == 0) {
		printf("New instruction break: ");
		scanf("%x", &bi);
	}
	if(strcmp(buf, "r") == 0) {
		printf("Resuming\n");
		dstate = 1;
	}
	if(strcmp(buf, "t") == 0) {
		byte val;
		printf("Tape buttons to what?");
		scanf("%x", &val);
		IOBUF[0] = val;
		
	}
	if(strcmp(buf, "l") == 0) {
		word val;
		printf("Break on write to what location?");
		scanf("%x", &val);
		meml = val;
	}
	if(strcmp(buf, "d") == 0) {
		int addr;
		int len;
		printf("Specify an address: ");
		scanf("%X", &addr);
		printf("Specify a lengh: ");
		scanf("%X", &len);
		fprintf(stdout, "Hex dump for address %04X\n", addr);
		hexdump(addr, len, stdout);
	}
	if(strcmp(buf, "m") == 0) {
		word addr;
		byte val;
		printf("Byte address: ");
		scanf("%x", &addr);
		val = readbyte(addr);
		printf("%02X\n", val);
		debug();
		return;
	}
	if(strcmp(buf, "r") == 0) {
		printf("Forcing a redraw \n");
		blitScreen();
	}
	if(strcmp(buf, "save") == 0) {
		printf("Enter filename: ");
		scanf("%s", &buf);
		saveState(buf);
	}
	if(strcmp(buf, "load") == 0) {
		printf("Enter filename: ");
		scanf("%s", &buf);
		loadState(buf);
	}
        if(strcmp(buf, "debugon") == 0) {
                fprintf(stderr, "Debug on\n");
                dstate = 1;
        }
        if(strcmp(buf, "debugoff") == 0) {
                fprintf(stderr, "Debug off\n");
                dstate = 2;
        }

}

void step() {
	// Do interrupts first?	
	byte icalled = 0;
	stepVideo();

	if (CLK % 95 == 0)
		stepSound();

	// TODO: Reimplement these calls later
	/*	
	if (STOPPED || HALTED) {
		if (icalled == 0)
			return;
		if (icalled == 4)
			HALTED = 0;
		if (icalled > 0)
			STOPPED = 0;
	}*/

	// Execute an instruction if ICLKE = ICLK
	if (ICLKE == ICLK) {
		if (IEMASTER)
			icalled = doInterrupts();	
		//if (HALTED) {
		//	if (icalled == 0)
		//		return;
		//	else
		//		HALTED = 0;
		//}
		ICLKE = 0;
		decode();	
	
	}
	clocks();	

	ICLKE ++;
	CLK ++;
}

byte doInterrupts() {
	byte enabled = readbyte(INTE);
	byte request = readbyte(INTF);
	
	byte willdo = enabled & request;
	// VBlank
	if (willdo & 0x1) {
		doVideoUpdate();
		request = request & 0xFE;
		writebyte(INTF, request);
		CALL(0x40, 0x0);
		IEMASTER = 0;
		return 1;
	}
	// LCD STAT
	if (willdo & 0x2) {
		request = request & 0xFD;
		writebyte(INTF, request);
		CALL(0x48, 0x0);
		return 2;
	}
	// Timer
	if (willdo & 0x4) {
		request = request & 0xFB;
		writebyte(INTF, request);
		CALL(0x50, 0x0);
		IEMASTER = 0;
		return 3;
	}
	// Serial
	if (willdo & 0x8) {
		request = request & 0xF7;
		writebyte(INTF, request);
		CALL(0x58, 0x0);
		IEMASTER = 0;
		return 4;
	}
	// Joypad
	if (willdo & 0x10) {
		request = request & 0xEF;
		writebyte(INTF, request);
		CALL(0x60, 0x0);
		IEMASTER = 0;
		return 5;
	}
	return 0;
}

void decode() {
	//if (dstate < 2)
	//	debug();
	if (IEMASTERR != IEMASTER)
		IEMASTER = IEMASTERR;
	word pc = read16r(PC);
	byte inst = readbyte(pc);
	void (*instf)() = map8[inst];
	int PCincr = 1;
	byte arg1 = map8arg1[inst];
	byte arg2 = map8arg2[inst];
	byte iargs = map8icount[inst];
	
	if (iargs == 1) {
		if(arg1 == 0) {
			arg1 = readbyte(pc + 1);
		} else {
			arg2 = readbyte(pc + 1);
		}
		PCincr ++;
	} else if (iargs == 2) {
		arg1 = readbyte(pc + 1);
		arg2 = readbyte(pc + 2);
		PCincr += 2;
	}
		
	/*if (dstate < 2) {
		printf("STEP CLK=%d PC=%04X SP=%04X HL=%04X AF=%04X BC=%04X DE=%04X ROM:%02X RAM:%02X\n", CLK, read16r(PC), read16r(SP), read16r(HL), read16r(AF), read16r(BC), read16r(DE), rompage, rampage);
		printf(">>Exec opcode: %02X args: %d %d\n", inst, arg1, arg2);
	}*/

	incrPC(PCincr);
	ICLK = map8timing[inst];
	if (ICLK == 0)
		ICLK = 4;
	(*instf)(arg1, arg2);
	return;
}

inline void clocks() {
	byte divr = IOBUF[4];
	if (divr != OLDDIV)
		IOBUF[4] = 0;
	if (CLK % 256 == 0) {
		IOBUF[4] = divr + 1;
		OLDDIV = IOBUF[4];
	}

	byte tac = IOBUF[7];
	if (tac >> 2 == 1) {
		/*
		switch (ics) {
			case 0:
				comp = 4096;
			case 1:
				comp = 262144;
			case 2:
				comp = 65536;
			case 3:
				comp = 16384;
		}*/
		if (CLK % ICS == 0) {
			byte tima = IOBUF[5];
			if (tima == 0xFF) {
				intRequest(2);
				tima = IOBUF[6];
			} else
				tima ++;
			IOBUF[5] = tima;
		}
	}
}

void intRequest(int num) {
	byte intf = readbyte(INTF);
	byte intr = 0x1 << num;
	intf = intf | intr;
	writebyte(INTF, intf);
}

void incrPC(int num) {
	REG->PCR += num;
}

void sync() {

}

void write16bit(char hi, char lo, word newval) {
	if (hi == 'A' && lo == 'F') {
		REG->A = (newval >> 4);
		REG->F = (newval & 0x0F);
	}
	else if (hi == 'B' && lo == 'C') {
		REG->B = (newval >> 4);
		REG->C = (newval & 0x0F);
	}
	else if (hi == 'D' && lo == 'E') {
		REG->D = (newval >> 4);
		REG->E = (newval & 0x0F);
	}
	else if (hi == 'H' && lo == 'L') {
		REG->H = (newval >> 4);
		REG->L = (newval & 0x0F);
	}
	else if (hi == 'S' || lo == 'P') {
		REG->SPR = newval;
	}
	else if (hi == 'P' || lo == 'C') {
		REG->PCR = newval;
	}
}	
