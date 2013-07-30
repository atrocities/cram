#include "cram.h"

#ifndef _CSOUNDH
#define _CSOUNDH

extern byte* channels[4];

void sounddump();
int initSound();
void stepSound();
void stepMode1();
void stepMode2();
void stepMode3();
void stepMode4();
void mixSound();

#endif
