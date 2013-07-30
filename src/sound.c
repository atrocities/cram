#include <stdlib.h>
#include <string.h>
#include <stdio.h>

#include "cram.h"
#include "mem.h"
#include "cpu.h"
#include "SDL.h"
#include "sdlvideo.h"
#include "sound.h"

#define FREQ 44100
#define SSTEP 95
#define SBUFSIZE 1024
#define SLSTEP 689

#define bsweep 344

byte* channels[4];
int bufleft[4];
unsigned int mflags[4];
int soundlen[4];
byte envelopes[4];
static int sweep = 0;

FILE* OUTDESC;

long SCOUNTER;
long LSCOUNTER;
long SCLK;

const int MAXVOL = SDL_MIX_MAXVOLUME / 2;

const byte sqwave[4][8] = {{ 0xFF, 0 ,0 ,0 , 0, 0, 0, 0 },
			   { 0xFF, 0xFF, 0, 0, 0, 0, 0, 0},
			   { 0xFF, 0xFF, 0xFF, 0xFF, 0, 0, 0, 0},
			   { 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0, 0}};

//const int sweeptime[8] = {0, 47, 95, 141, 188, 235, 282, 329};
const int sweeptime[8] = {0, bsweep, bsweep * 2, bsweep * 3, bsweep * 4, bsweep * 5, bsweep * 6, bsweep * 7};

int getFreq(word hi, word lo) {
	int freq = IOBUF[lo] | ((IOBUF[hi] & 0x7) << 8);
	return 131072 / (2048 - freq);
}

int getWaveDuty(word addr) {
	return (IOBUF[addr] & 0xC0) >> 6;
}

int getSoundLen(word addr) {
	return (IOBUF[addr] & 0x1F);
}

void sounddump() {
	int desc = stderr;
	int length = 512;
        fprintf(desc, "Sound buffer dump\n");
        int i = 0;
        int j = 0;
        byte* buf = channels[0];
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
                        fprintf(desc, "%04X | ", i);
                fprintf(desc, "%02X ", buf[i]);
                i ++;
                j ++;
                if (j == 16) {
                        fprintf(desc, "\n");
                        j = 0;
                }
        }
}

void mixi(byte* dest, byte* src, int len) {
	int i;
	for (i = 0; i < len; i++) {
		dest[i] += src[i];
	}
}

void openDump() {
	OUTDESC = fopen("sdump.wav", "w");
	fwrite("RIFF", sizeof(byte), 4, OUTDESC);
	char buf[4] = {0xFF, 0xFF, 0x00, 0x00};
	fwrite(buf, sizeof(byte), 4, OUTDESC);
	fwrite("WAVE", sizeof(byte), 4, OUTDESC);
	fwrite("fmt ", sizeof(byte), 4, OUTDESC);
	// 16 bytes of formatting
	char buf2[4] = {16, 0x00, 0x00, 0x00};
	fwrite(buf2, sizeof(byte), 4, OUTDESC);
	// No compression (mode 1)
	char buf3[2] = {1, 0x00};
	fwrite(buf3, sizeof(byte), 2, OUTDESC);
	// 1 channel
	char buf4[2] = {1, 0x00};
	fwrite(buf4, sizeof(byte), 2, OUTDESC);
	// Sample Rate
	char buf5[4] = {0x44, 0xAC, 0x00, 0x00};
	fwrite(buf5, sizeof(byte), 4, OUTDESC);
	// Average bytes per second
	char buf6[4] = {0x44, 0xAC, 0x00, 0x00};
	fwrite(buf6, sizeof(byte), 4, OUTDESC);
	// Block align
	char buf7[2] = {0x01, 0x00};
	fwrite(buf7, sizeof(byte), 2, OUTDESC);
	// Significant bits per sample
	char buf8[2] = {0x08, 0x00};
	fwrite(buf8, sizeof(byte), 2, OUTDESC);

	// Data begins
	fwrite("data", sizeof(byte), 4, OUTDESC);
	fwrite("aaaa", sizeof(byte), 4, OUTDESC);
}

void dumpstream(byte* src, int len) {
	if (dosounddump)
	fwrite(src, sizeof(byte), len, OUTDESC);
}

void mixstreams(void *unused, byte* stream, int len) {
	//printf("Mixing stream: len %d\n", len);
	SCOUNTER += len;
	if (bufleft[0] != 0) {
		int slen = len > bufleft[0] ? bufleft[0] : len;
		//SDL_MixAudio(stream, channels[0], slen, SDL_MIX_MAXVOLUME);
		mixi(stream, channels[0], len);
		bufleft[0] -= slen;
	}
	if (bufleft[1] != 0) {
		int slen = len > bufleft[1] ? bufleft[1] : len;
		mixi(stream, channels[1], len);
		bufleft[1] -= slen;
	}
	if (bufleft[2] != 0) {
		int slen = len > bufleft[2] ? bufleft[2] : len;
		mixi(stream, channels[2], len);
		dumpstream(channels[2], len);
		bufleft[2] -= slen;
	}
}

int initSound() {
	int i;
	SDL_AudioSpec fmt;
	fmt.freq = FREQ;
	fmt.format = AUDIO_U8;
	fmt.channels = 1;
	fmt.samples = SBUFSIZE;
	fmt.silence = 0;
	fmt.callback = mixstreams;
	fmt.userdata = NULL;
	openDump();

	LSCOUNTER = 0;
	SCOUNTER = 0;
	SCLK = 0;

	if ( SDL_OpenAudio(&fmt, NULL) < 0 ) {
		fprintf(stderr, "Unable to open audio stream: %s\n", SDL_GetError());
		return -1;
	}
	
	for (i = 0; i < 4; i++) {
		channels[i] = (byte*) malloc(sizeof(byte) * SBUFSIZE);
		mflags[i] = 0;
		envelopes[i] = 0xF0;
		bufleft[i] = 0;
		soundlen[i] = 0;
	}
	for (i = 0; i < SBUFSIZE; i++) {
		channels[0][i] = 0;
	}
	SDL_PauseAudio(0);
	return 0;
}

void stepSound() {
	// Decrement counters and end certain sounds. 
	SCLK++;
	stepMode1();
	stepMode2();
	stepMode3();
	LSCOUNTER = SCOUNTER;
}

void stepMode1() {
	// Mode 1 - 
	// TODO: implement sweep, envelope, length
	if ((IOBUF[0x14] >> 7) & 0x1) {
		IOBUF[0x14] &= 0x7F;
		sweep = 0;
		envelopes[0] = IOBUF[0x12] >> 4;
	} 
	byte sends = 0;
	if ((IOBUF[0x14] >> 6) & 0x1 ) {
		if ((IOBUF[0x11] & 0x1F) == 0)
			return;
		sends = 1;
	}
	
	int emodulo = SLSTEP * (IOBUF[0x12] & 0x7);
	if (emodulo != 0) {
		if ( !(SCLK % emodulo)) {
			if (sends) {
			byte len = (IOBUF[0x11] & 0x1F) - 1;
				IOBUF[0x11] = len | (IOBUF[0x11] & 0xC0);
			}
			envelopes[0] += ((IOBUF[0x12] >> 3) & 0x1) ? 1 : -1;
			if (envelopes[0] > 0x4F)
				envelopes[0] = 0;
			if (envelopes[0] > 0xF)
				envelopes[0] = 0xF;
		}
	}
	if (envelopes[0] == 0)
		sweep = 0;
	else {
		//envelopes[0] = IOBUF[0x12] >> 4;
	}
	int smodulo = sweeptime[(IOBUF[0x10] & 0x70) >> 4];
	if (smodulo != 0) {
		if ( !(SCLK % smodulo)) {
			if (sweep == 0) {
				sweep = IOBUF[0x13] | ((IOBUF[0x14] & 0x7) << 8);
			} else {
				if (IOBUF[0x10] & 0x8) 
					sweep -= sweep / (2 << (IOBUF[0x10] & 0x7));
				else
					sweep += sweep / (2 << (IOBUF[0x10] & 0x7));
				if (sweep <= 0) {
					sweep = 0;
					envelopes[0] = 0;
;				}
				if (sweep > 0x7FF) {
					sweep = 0;
					envelopes[0] = 0;
				}
				IOBUF[0x13] = sweep & 0xFF;
				IOBUF[0x14] = (sweep & 0x700) >> 8;
			}
			//printf("Sweep is at: %d\n", sweep);
		}
	} else {
		sweep = 0;
	}

	int freq = getFreq(0x14, 0x13);
	int wduty = (IOBUF[0x11] >> 6);
	//int fmodulo = (FREQ / (freq > FREQ ? FREQ : freq)) / 2;
	int i;
	//printf("Ch1freq: %d Mflags: %d\n", freq, (mflags[0] / 5525) & 0x7);
	SDL_LockAudio();
	if (SCOUNTER != LSCOUNTER) { 
		for (i = 0; i < SBUFSIZE; i++) {
			channels[0][i] = sqwave[wduty][((int)(mflags[0] / 5525)) & 0x7] & envelopes[0];
			mflags[0] += freq;
		}
		bufleft[0] = SBUFSIZE;
	}
	SDL_UnlockAudio();
}

void stepMode2() {
	// Mode 2 - 
	// TODO: implement sweep, envelope, length
	if ((IOBUF[0x19] >> 7) & 0x1) {
		IOBUF[0x19] &= 0x7F;
		envelopes[1] = IOBUF[0x17] >> 4;
	} 
	byte sends = 0;
	if ((IOBUF[0x19] >> 6) & 0x1 ) {
		if ((IOBUF[0x16] & 0x1F) == 0)
			return;
		sends = 1;
	}

	int emodulo = SLSTEP * (IOBUF[0x17] & 0x7);
	if (emodulo != 0) {
		if ( !(SCLK % emodulo)) {
			if (sends) {
			byte len = (IOBUF[0x16] & 0x1F) - 1;
				IOBUF[0x11] = len | (IOBUF[0x16] & 0xC0);
			}
			envelopes[1] += ((IOBUF[0x17] >> 3) & 0x1) ? 1 : -1;
			if (envelopes[1] > 0x4F)
				envelopes[1] = 0;
			if (envelopes[1] > 0xF)
				envelopes[1] = 0xF;
		}
	}
	else {
		//envelopes[1] = IOBUF[0x17] >> 4;
	}

	int freq = getFreq(0x19, 0x18);
	int wduty = (IOBUF[0x16] >> 6);
	//int fmodulo = (FREQ / (freq > FREQ ? FREQ : freq)) / 2;
	int i;
	SDL_LockAudio();
	if (LSCOUNTER != SCOUNTER) {
		for (i = 0; i < SBUFSIZE; i++) {
			channels[1][i] = sqwave[wduty][((int)(mflags[1] / 5525)) & 0x7] & envelopes[1];
			mflags[1] += freq;
		}
		bufleft[1] = SBUFSIZE;
	}
	SDL_UnlockAudio();
}

void stepMode3() {
	int i;
	if (IOBUF[0x1A] >> 7 == 0)
		return;
	if (IOBUF[0x1E] >> 7) {
		IOBUF[0x1E] &= 0x7F;
		mflags[2] = 0;
		soundlen[2] = 256 - IOBUF[0x1D];
	} 
	if (IOBUF[0x1E] >> 6 & 0x1 && !soundlen[2])
		return;
	if (IOBUF[0x1E] >> 6 & 0x1 && !(SCLK % SLSTEP)) {
		soundlen[2] --;
		if (!soundlen[2])
			return;
	}
	int freq = 65536 / (2048 - (IOBUF[0x1D] | ((IOBUF[0x1E] & 0x7) << 8))); 
	SDL_LockAudio();
	if (LSCOUNTER != SCOUNTER) {
		for (i = 0; i < SBUFSIZE; i++) {
			int index = (int)(mflags[2] / 1378) & 0x1F;
			int bshift = (4 * !(index & 0x1));
			int olevel = ((IOBUF[0x1C] >> 5 & 0x3) - 1);
			index = (index >> 1) - 1;
			if (olevel < 0)
				channels[2][i] = 0;
			else {
				channels[2][i] = ((IOBUF[0x30 + index] >> bshift) & 0xF);
				if (olevel > 0)
					channels[2][i] = channels[2][i] >> olevel;
			}
			mflags[2] += freq;
		}
		bufleft[2] = SBUFSIZE;
	}
	SDL_UnlockAudio();
}
