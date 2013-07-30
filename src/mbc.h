#ifndef _cmbch
#define _cmbch

#include "cram.h"
extern int rompage;
extern int rampage;
extern int mbcmode;
extern int ramenable;

extern int ramoffset;
extern int romoffset;

byte mbc1r(word addr);
void mbc1w(word addr, word val, byte len);

byte mbc3r(word addr);
void mbc3w(word addr, word val, byte len);
#endif
