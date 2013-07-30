#include "cram.h"
#ifndef _ccpu
#define _ccpu

typedef struct {
	byte A;
	byte B;
	byte C;
	byte D;
	byte E;
	byte F;
	byte H;
	byte L;
	word SPR;
	word PCR;
} registers;

extern registers* REG;
extern unsigned long CLK;
extern byte ICLK;
extern byte ICLKE;
extern unsigned int TIMERCNT;
extern byte STOPPED;
extern byte HALTED;
extern byte IEMASTER;
extern byte IEMASTERR;
extern byte DMADELAY;
extern byte OLDDIV;
extern byte dstate;
extern word breakpoint;
extern word meml;
extern int ICS;
extern byte TENABLE;

int initCpu();
int boot();
void decode();

void hexdump(word, word, int);
inline byte doInterrupts();
inline void step();
inline void intRequest(int num);
inline void debug();

inline void clocks();
inline void intRequest(int num);
inline void incrPC(int num);

void write16bit(char hi, char lo, word newval);

#endif
