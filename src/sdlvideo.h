#ifndef _CRAMSDL
#define _CRAMSDL

#include "SDL.h"

#if SDL_BYTEORDER == SDL_BIG_ENDIAN
    #define rmask 0xff000000
    #define gmask 0x00ff0000
    #define bmask 0x0000ff00
    #define amask 0x000000ff
#else
    #define rmask 0x000000ff
    #define gmask 0x0000ff00
    #define bmask 0x00ff0000
    #define amask 0xff000000
#endif

extern SDL_Surface *background;
extern SDL_Surface *window;
extern SDL_Surface *screen;

extern SDL_Surface *sprites[40];
extern int dosounddump;

extern SDL_Color textColor;

void apply_tile(int x, int y, int tx, int ty, SDL_Surface* source, SDL_Surface* destination);
void apply_surface( int x, int y, SDL_Surface* source, SDL_Surface* destination );

int initSdlVideo();
void doVideoUpdate();
void doVideoLoop();

#endif
