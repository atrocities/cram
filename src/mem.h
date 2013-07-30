#ifndef _cmem
#define _cmem

#include "sdlvideo.h"

#define CPAD 0xFF00
#define SERIAL 0xFF01
#define SERIALC 0xFF02
#define DIV 0xFF04
#define TIMA 0xFF05
#define TMA 0xFF06
#define TAC 0xFF07
#define INTF 0xFF0F
#define LCDC 0xFF40
#define LSTAT 0xFF41
#define SCROLLY 0xFF42
#define SCROLLX 0xFF43
#define LCDY 0xFF44
#define LCDYC 0xFF45
#define DMA 0xFF46
#define BGP 0xFF47
#define OBP0 0xFF48
#define OBP1 0xFF49
#define WINDOWY 0xFF4A
#define WINDOWX 0xFF4B
#define INTE 0xFFFF

extern SDL_Surface* tiles;

extern byte IEREG;
extern byte* HRAM;
extern byte* IOBUF;
extern byte* VRAM;
extern byte* ERAM;
extern byte* WRAM1;
extern byte* WRAM2;
extern byte* OAM;
extern byte* MEM;

extern byte (*mreader)();
extern void (*mwriter)();

inline byte fastread(word address);
inline word fastwrite(word address, byte val);
inline word fastmap(word address, byte val, char rw);
int map(unsigned int address, byte* buffer, int length, char rw);
inline byte readbyte(word address);
inline int writebyte(word address, byte val);
inline word readword(word address);
inline int writeword(word address, word val);

void changeJpRegs();
byte jpDirections();
byte jpButtons();
void writejpReg(byte inp);
void setJpButton(byte num);
void resetJpButton(byte num);
void saveState(char* filename);
void loadState(char* filename);

#endif
