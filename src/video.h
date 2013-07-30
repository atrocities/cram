#ifndef _CVIDEO
#define _CVIDEO

extern byte bgp[4];
extern byte sgp1[4];
extern byte sgp2[4];

extern word pal[4];
byte oamInt();
byte hblankInt();
byte vblankInt();
byte lycInt();
void setLycFlag(byte lyc);

byte lcdEnable();

void writeMode(byte mode);
extern byte MODE;

void blitScreen();
void initVideo();
void stepVideo();
byte getSpriteSize();

#endif
