#include <stdio.h>
#include <stdlib.h>

#include "SDL.h"

#include "cram.h"
#include "mem.h"
#include "cpu.h"
#include "video.h"
#include "opcode.h"
#include "sdlvideo.h"
#include "sound.h"

SDL_Surface *background;
SDL_Surface *window;
SDL_Surface *window2;

SDL_Surface *sprites[40];

SDL_Surface *screen;
SDL_Surface *textl;
int dosounddump;

SDL_Color textColor = {255, 255, 255};

// Blatently ripped from lazyfoo.net
void apply_surface( int x, int y, SDL_Surface* source, SDL_Surface* destination )
{
    //Make a temporary rectangle to hold the offsets
    SDL_Rect offset;
    
    //Give the offsets to the rectangle
    offset.x = x;
    offset.y = y;
	SDL_BlitSurface(source, NULL, destination, &offset);
}

void apply_tile(int x, int y, int tx, int ty, SDL_Surface* source, SDL_Surface* destination) {
	SDL_Rect offset;
	SDL_Rect clip;
	offset.x = x;
	offset.y = y;
	clip.x = tx + 1;
	clip.y = ty;
	clip.w = 8; 
	clip.h = 8;
	SDL_BlitSurface(source, &clip, destination, &offset);
}

int load_font() {
	return true;
}

int initSdlVideo() {
	int flags = SDL_SWSURFACE;
	if (SDL_Init(SDL_INIT_EVERYTHING ^ SDL_INIT_CDROM) != 0) {
		fprintf(stderr, "Unable to initialize SDL: %s\n", SDL_GetError());
		return false;
	}
	atexit(SDL_Quit);

	screen = SDL_SetVideoMode(160, 144, 16, flags);
	//screen = SDL_SetVideoMode(255, 255, 16, flags);
	background = SDL_CreateRGBSurface(SDL_SWSURFACE, 256, 256, 16, 0, 0, 0, 0);	
	window = SDL_CreateRGBSurface(SDL_SWSURFACE, 256, 256, 16, 0, 0, 0, 0);		

	textl = 0;
	if (!screen) {
		fprintf(stderr, "Unable to set video mode: %s\n", SDL_GetError());
		return false;
	}

	if (!load_font()) {
		fprintf(stderr, "Can't load default font\n");
		return false;
	}

	SDL_WM_SetCaption("cram", NULL);
	SDL_EnableKeyRepeat(0, 0);
	dosounddump = 0;
	return true;
}

int deinitSdlVideo() {
	SDL_FreeSurface(screen);
	SDL_Quit();
	exit(0);
}

void doVideoUpdate() {
	//SDL_Flip(screen);
}

void sdebug() {
        char buf[256];
        buf[0] = 0;
	fprintf(stderr, "STEP CLK=%d PC=%04X SP=%04X HL=%04X AF=%04X BC=%04X DE=%04X\n", CLK, read16r(PC), read16r(SP), read16r(HL), read16r(AF), read16r(BC), read16r(DE));
        fprintf(stderr, "\nDEBUG %0000X> ", read16r(PC));
        scanf("%s", &buf);
        if(strlen(buf) == 0)
                return;
        if(strcmp(buf, "s") == 0)
                return;
        if(strcmp(buf, "b") == 0) {
                fprintf(stderr, "New breakpoint: ");
                scanf("%x", &breakpoint);
        }
        if(strcmp(buf, "r") == 0) {
                fprintf(stderr, "Resuming\n");
        }
        if(strcmp(buf, "t") == 0) {
                byte val;
                fprintf(stderr, "Tape buttons to what?");
                scanf("%x", &val);
                IOBUF[0] = val;
        }
        if(strcmp(buf, "m") == 0) {
                word addr;
                byte val;
                fprintf(stderr, "Byte address: ");
                scanf("%x", &addr);
                val = readbyte(addr);
                fprintf(stderr, "%02X\n", val);
                sdebug();
                return;
        }
        if(strcmp(buf, "l") == 0) {
                word val;
                printf("Break on write to what location?");
                scanf("%x", &val);
                meml = val;
        }
        if(strcmp(buf, "d") == 0) {
                int addr, len;
                fprintf(stderr, "Specify an address: ");
                scanf("%X", &addr);
                fprintf(stderr, "Specify a lengh: ");
                scanf("%X", &len);
                hexdump(addr, len, stderr);
		sdebug();
        }
        if(strcmp(buf, "save") == 0) {
                printf("Enter filename: ");
                scanf("%s", &buf);
                saveState(buf);
        }
	if(strcmp(buf, "sdump") == 0) {
		sounddump();
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

// TODO: support configurable input
void keyDown(SDL_KeyboardEvent ke) {
	int key = (int) ke.keysym.sym;
	switch(key) {
		case 306:
			setJpButton(0);
			return;
		case 310:
			setJpButton(1);
			return;
		case 303:
			setJpButton(2);
			return;
		case 13:
			setJpButton(3);
			return;
		case 275:
			setJpButton(4);
			return;
		case 276:
			setJpButton(5);
			return;
		case 273:
			setJpButton(6);
			return;
		case 274:
			setJpButton(7);
			return;
		case SDLK_d:
			dosounddump = 1;
			printf("Starting sound dump\n");
			return;
		case SDLK_ESCAPE:
			sdebug();
	}
}

void keyUp(SDL_KeyboardEvent ke) {
	int key = (int) ke.keysym.sym;
	switch(key) {
		case 306:
			resetJpButton(0);
			return;
		case 310:
			resetJpButton(1);
			return;
		case 303:
			resetJpButton(2);
			return;
		case 13:
			resetJpButton(3);
			return;
		case 275:
			resetJpButton(4);
			return;
		case 276:
			resetJpButton(5);
			return;
		case 273:
			resetJpButton(6);
			return;
		case 274:
			resetJpButton(7);
			return;
	}
}

void doVideoLoop() {
	SDL_Event event;
	char buf[256];
	while (1) {
		step(); /*


		if (textl != 0) {
			SDL_FreeSurface(textl);
		}
		sprintf(buf, "PC:%04X", read16r(PC));
		apply_surface(0,10, textl, screen);
		SDL_FreeSurface(textl);
		textl = TTF_RenderText_Solid( font, buf, textColor);
		apply_surface(0,10, textl, screen);
		*/
		if (CLK % 10000 == 0) {
			while (SDL_PollEvent(&event)) {
				if (event.type == SDL_QUIT) {
					deinitSdlVideo();
				}
				else if (event.type == SDL_KEYDOWN) {
					keyDown(event.key);
				}
				else if (event.type == SDL_KEYUP) {
					keyUp(event.key);
				}
				else {
					//fprintf(stderr, "Clk:%d\n", CLK);
				}
			}
		}
	}
}	
