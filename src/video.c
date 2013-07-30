#include <string.h>
#include <stdio.h>
#include "cram.h"
#include "mem.h"
#include "cpu.h"
#include "video.h"
#include "sdlvideo.h"

byte MODE;
int mcelapsed;
int mctotal;
int hline;

byte bgp[4] = {0, 1, 2, 3};
byte sgp1[4] = {0, 1, 2, 3};
byte sgp2[4] = {0, 1, 2, 3};

SDL_Surface* temptile;

word pal[4];

const int mode2clks = 80;
const int mode3clks = 172;
const int mode0clks = 204;
const int mode1clks = 456;
const int vblankclks = 4560;
const int FRAMESKIP = 1;

int fskip;

byte setHline(byte line) {
	writebyte(LCDY, line);
	hline = line;
	if (hline == IOBUF[0x45])
		setLycFlag(1);
	else
		setLycFlag(0);
}

byte lcdOn() {
	return (IOBUF[0x40] >> 7) & 0x1;
}

byte oamInt() {
	return (IOBUF[0x41] >> 5) & 0x1;
}

byte hblankInt() {
	return (IOBUF[0x41] >> 3) & 0x1;
}

byte vblankInt() {
	return (IOBUF[0x41] >> 4) & 0x1;
}

byte lycInt() {
	return (IOBUF[0x41] >> 6) & 0x1;
}

byte setBit(byte val, byte bit, byte set) {
	if (set) {
		byte mask = 0x1 << bit;
		return (val | mask);
	} else {
		byte mask = 0x1 << bit;
		mask = ~mask;
		return (val & mask);
	}
}

void setLycFlag(byte lyc) {
	byte stat = IOBUF[0x41];
	stat = setBit(stat, 2, lyc);
	IOBUF[0x41] = stat;
	//writebyte(LSTAT, setBit(stat, 2, lyc));
}

void writeMode(byte mode) {
	IOBUF[0x41] = (IOBUF[0x41] & 0xFC) | (mode & 0x3);
	MODE = mode;
}

void initVideo() {
	MODE = 1;
	mcelapsed = 0;
	mctotal = 80;
	hline = 0;
	// Black
	pal[3] = SDL_MapRGB(background->format, 0, 0, 0);
	// Dark gray
	pal[2] = SDL_MapRGB(background->format, 90, 90, 90);
	// Light gray
	pal[1] = SDL_MapRGB(background->format, 180, 180, 180);
	// White
	pal[0] = SDL_MapRGB(background->format, 255, 255, 255); 
	temptile = SDL_CreateRGBSurface(SDL_SWSURFACE, 8, 8, 16, 0, 0, 0, 0);
	fskip = 1;
}

void checkStatInts() {
	if (oamInt() && MODE == 2)
		intRequest(1);
	if (hblankInt() && MODE == 0)
		intRequest(1);
	if (vblankInt() && MODE == 1)
		intRequest(1);
	if (lycInt() && hline == IOBUF[0x45]) {
		intRequest(1);
	}
}

void doVblankInt() {
	intRequest(0);
}

void drawTile(SDL_Surface *layer, word addr, byte x, byte y) {
	SDL_LockSurface(temptile);
	word* pix = temptile->pixels;
	int i, j;
	byte buf[16];
	map(addr, buf, 16, 'r');
	for (i = 0; i < 16; i++) {
		for (j=0; j < 4; j++) {
			word* tpix;
			tpix = (word*)pix + (4*i + j);
			byte bpix = (buf[i] >> (2*(3-j))) & 0x3; 
			*tpix = pal[bgp[bpix]];
		}
	}
	SDL_UnlockSurface(temptile);
	SDL_LockSurface(layer);
	apply_surface(0, 0, temptile, layer);
	SDL_UnlockSurface(layer);	
}

byte getTileDataMode() {
	byte lcdc = readbyte(LCDC);
	return (lcdc>>4) & 0x1;
}

void drawSprite(SDL_Surface* layer, int tilenum, byte x, byte y) {
	SDL_UnlockSurface(layer);
	SDL_UnlockSurface(tiles);
	int tx = (tilenum & 0xF) * 8;
	int ty = ((tilenum & 0xF0) >> 4) * 8;
	apply_tile(x, y, tx, ty, tiles, layer);
}

void drawTileDirect(SDL_Surface* layer, int tilenum, byte x, byte y) {
	SDL_UnlockSurface(layer);
	SDL_UnlockSurface(tiles);
	int tx;
	int ty;
	if (getTileDataMode() == 1) {
		tx = (tilenum & 0xF) * 8;
		ty = ((tilenum & 0xF0) >> 4) * 8;
	}
	else {
		signed char tms = ((signed char) tilenum);
		word tm = 0x100 + tms;
		tx = (tm & 0xF) * 8;
		ty = ((tm & 0xFF0) >> 4) * 8;
	}
	apply_tile(x*8, y*8, tx, ty, tiles, layer);
	//SDL_LockSurface(layer);
}

word getBgAddr() {
	byte lcdc = readbyte(LCDC);
	lcdc = (lcdc >> 3) & 0x1;
	if (!lcdc)
		return 0x9800;
	else
		return 0x9C00;
}

word getWinAddr() {
	byte lcdc = readbyte(LCDC);
	lcdc = (lcdc >> 6) & 0x1;
	if (!lcdc)
		return 0x9800;
	else
		return 0x9C00;
}

byte windowOn() {
	byte lcdc = readbyte(LCDC);
	return (lcdc>>5) & 0x1;
}

byte getTileBank() {
	return 0;
}

byte getScy() {
	return readbyte(SCROLLY);
}

byte getScx() {
	return readbyte(SCROLLX);
}

byte getWinX() {
	return readbyte(WINDOWX) - 6;
}

byte getWinY() {
	return readbyte(WINDOWY);
}

byte spritesOn() {
	return (readbyte(LCDC) >> 1) & 0x1;
}

byte getSpriteSize() {
	if ((readbyte(LCDC) >> 2) & 0x1) 
		return 16;
	else
		return 8;
}

byte bgOn() {
	return (readbyte(LCDC) & 0x1);
}

void drawSprites() {
	int i;
	byte x, y, tile, attr;
	for (i = 0; i < 0xA0; i += 4) {
		y = OAM[i];
		x = OAM[i+1];
		tile = OAM[i+2];
		attr = OAM[i+3];

		// Blit directly on screen?
		// TODO: IMPLEMENT FLIPPING, PRIORITY, PALETTE
		if (getSpriteSize() == 16) {
			drawSprite(screen, (tile & 0xFE) + 1, x - 8, y - 8);
			drawSprite(screen, tile & 0xFE, x - 8, y - 16);
		} 
		else 
			drawSprite(screen, tile, x - 8, y - 16);
	}
}

void blitScreen() {
	if (fskip != FRAMESKIP) {
		fskip ++;
		return;
	} else {
		fskip = 1;
	}
	int i, j;
	byte buf[1024];
	map(getBgAddr(), buf, 1024, 'r');
	if (bgOn()) {
		for (i = 0; i < 32; i++) {	
			for (j = 0; j < 32; j++) {
				byte tilenum = buf[(i*32) + j];
				drawTileDirect(background, tilenum, j, i);
			}
		}
		byte scx = getScx();
		byte scy = getScy();
		if (scx > 96)
			apply_surface(256 - scx, (-1) * getScy(), background, screen);
		if (scy > 112)
			apply_surface((-1) * scx, 256 - scy, background, screen);
		if (scx > 96 && scy > 112)
			apply_surface(256 - scx, 256 - scy, background, screen);
		apply_surface((-1) * scx, (-1) * scy, background, screen);
	}
	if (windowOn()) {
		map(getWinAddr(), buf, 1024, 'r');
		for (i = 0; i < 32; i++) {	
			for (j = 0; j < 32; j++) {
				byte tilenum = buf[(i*32) + j];
				drawTileDirect(window, tilenum, j, i);
			}
		}
		apply_surface(getWinX(), getWinY(), window, screen);
		//apply_surface(0, 0, window, screen);
	}

	if (spritesOn()) {
		drawSprites();
	}
	SDL_Flip(screen);
}

// Simulates 1 clock cycle for the video controller
void stepVideo() {
	mcelapsed++;
	if (mcelapsed >= mctotal) {
		int doints = 1;
		if (!lcdOn()) {
			doints = 0;
		}
		if (MODE == 2) {
			if (doints)
				checkStatInts();
			writeMode(3);
			mctotal = mode3clks;
		}
		else if (MODE == 3) {
			if (doints)
				checkStatInts();
			writeMode(0);
			mctotal = mode0clks;
		}
		else if (MODE == 0) {
			if (doints)
				checkStatInts();
			writeMode(2);
			mctotal = mode2clks;
			setHline(hline + 1);
			if (hline > 144) {
				writeMode(1);
				mctotal = mode1clks;
				if (doints)
					doVblankInt();
			}
		}
		else if (MODE == 1) {
			if (doints)
				checkStatInts();
			setHline(hline + 1);
			if (hline > 153) {
				blitScreen();
				setHline(0);
				writeMode(2);
				mctotal = mode2clks;
			}
		}
		mcelapsed = 0;
	}
}
