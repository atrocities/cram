// Test loader for gb roms

#include <stdio.h>
#include <string.h>
#include "cram.h"
#include "mem.h" 
#include "loader.h"
#include "cpu.h"
#include "mbc.h"
#include "sound.h"

#include "SDL.h"

char* title;
long ROMSIZE;
unsigned char* ROM;
rominfo* ROMINFO;

int loadFile(char* filename) {
	FILE* desc; 
	size_t bytesread;

	desc = fopen(filename, "r");
	ROMSIZE = getFileSize(desc);
	if (ROMSIZE == -1)
		return -1;
	
	ROM = (unsigned char*) malloc(sizeof(char) * ROMSIZE);
	if (ROM == NULL) {
		printf("Can't allocate enough memory for ROM of size %d\n", ROMSIZE);
	}
	
	printf("Reading file into memory\n");
	bytesread = fread(ROM, sizeof(char), ROMSIZE, desc);
	printf("Read %d bytes from file\n", bytesread);
	
	return 0;	
}

long getFileSize(FILE* desc) {
	long cp, ep;
	if (desc == NULL)
		return -1;
	cp = ftell(desc);
	fseek(desc, 0, 2);
	ep = ftell(desc);
	fseek(desc, cp, 0);
	return ep;
}

int readHeaderInfo() {
	char* buf;
	unsigned char uca;
	ROMINFO = (rominfo*) malloc(sizeof(rominfo));
	printf("Nintendo logo:\n");
	memcpy(ROMINFO->nlogo, (ROM + 0x104), 0x30);
	blitHexOnScreen(ROMINFO->nlogo, 0x30);
	memcpy(ROMINFO->title, (ROM + 0x134), 16);
	printf("Rom title:\n");
	blitHexOnScreen(ROMINFO->title, 16);
	blitAsciiOnScreen(ROMINFO->title, 16);
	memcpy(&ROMINFO->cgb, (ROM+0x143), 1);
	memcpy(ROMINFO->nlcode, (ROM+0x144), 2);
	memcpy(&ROMINFO->sgb, (ROM+0x146), 1);
	memcpy(&ROMINFO->ctype, (ROM+0x147), 1);
	memcpy(&ROMINFO->romsize, (ROM+0x148), 1);
	memcpy(&ROMINFO->ramsize, (ROM+0x149), 1);
	memcpy(&ROMINFO->dcode, (ROM+0x14A), 1);
	memcpy(&ROMINFO->olcode, (ROM+0x14B), 1);
	memcpy(&ROMINFO->mrver, (ROM+0x14C), 1);
	memcpy(&ROMINFO->hchecksum, (ROM+0x14D), 1);
	memcpy(ROMINFO->gchecksum, (ROM+0x14E), 2);	

	uca = ROMINFO->ctype;
	buf = getCType(ROMINFO->ctype);
	printf("Cart type: %s\n", buf);
	printf("ROM Size: %s\n", getRomSize(ROMINFO->romsize));
	printf("RAM Size: %s\n", getRamSize(ROMINFO->ramsize));
	if (checkChecksum(ROMINFO->hchecksum))
		printf("Header checksum good\n");
	else
		printf("Header checksum failed\n");
	return 0;
}

char* getCType(unsigned char ccode) {
	mwriter = NULL;
	mreader = NULL;
	switch (ccode) {
		case 0x00:
			return "ROM ONLY";
		case 0x01:
			mreader = &mbc1r;
			mwriter = &mbc1w;
			return "MBC1";
		case 0x02:
			mreader = &mbc1r;
			mwriter = &mbc1w;
			return "MBC1+RAM";
		case 0x03:
			mreader = &mbc1r;
			mwriter = &mbc1w;
			return "MBC1+RAM+BATTERY";
		case 0x05:
			return "MBC2";
		case 0x06:
			return "MBC2+BATTERY";
		case 0x08:
			return "ROM+RAM";
		case 0x09:
			return "ROM+RAM+BATTERY";
		case 0x0B:
			return "MMM01";
		case 0x0C:
			return "MMM01+RAM";
		case 0x0D:
			return "MMM01+RAM+BATTERY";
		case 0x0F:
			mreader = &mbc3r;
			mwriter = &mbc3w;
			return "MBC3+TIMER+BATTERY";
		case 0x10:
			mreader = &mbc3r;
			mwriter = &mbc3w;
			return "MBC3+TIMER+RAM+BATTERY";
		case 0x11:
			mreader = &mbc3r;
			mwriter = &mbc3w;
			return "MBC3";
		case 0x12:
			mreader = &mbc3r;
			mwriter = &mbc3w;
			return "MBC3+RAM";
		case 0x13:
			mreader = &mbc3r;
			mwriter = &mbc3w;
			return "MBC3+RAM+BATTERY";
		case 0x15:
			return "MBC4";
		case 0x16:
			return "MBC4+RAM";
		case 0x17:
			return "MBC4+RAM+BATTERY";
		case 0x19:
			return "MBC5";
		case 0x1A:
			return "MBC5+RAM";
		case 0x1B:
			return "MBC5+RAM+BATTERY";
		case 0x1C:
			return "MBC5+RUMBLE";
		case 0x1D:
			return "MBC5+RUMBLE+RAM";
		case 0x1E:
			return "MBC5+RUMBLE+RAM+BATTERY";
		case 0xFC:
			return "POCKET CAMERA";
		case 0xFD:
			return "BANDA TAMA5";
		case 0xFE:
			return "HuC3";
		case 0xFF:
			return "HuC1+RAM+BATTERY";
	}
	return "INVALID TYPE";
}

char* getRomSize(unsigned char rcode) {
	switch(rcode) {
		case 0x00:
			return "32KByte";
		case 0x01:
			return "64KByte";
		case 0x02:
			return "128KByte";
		case 0x03:
			return "256KByte";
		case 0x04:
			return "512KByte";
		case 0x05:
			return "1MByte";
		case 0x06:
			return "2MByte";
		case 0x07:
			return "4MByte";
		case 0x52:
			return "1.1MByte";
		case 0x53:
			return "1.2MByte";
		case 0x54:
			return "1.5MByte";
	}
	return "INVALID ROM TYPE";
}

char* getRamSize(unsigned char rcode) {
	switch(rcode) {
		case 0x00:
			return "None";
		case 0x01:
			return "2KBytes";
		case 0x02:
			return "8KBytes";
		case 0x03:
			return "32KBytes";
	}
	return "INVALID RAM TYPE";
}

int checkChecksum(unsigned char cksum) {
	unsigned char sum = 0x0;
	int i;
	for (i = 0x134; i < 0x14C ; i++) {
		sum -= ROM[i] - 1;
	}
	if ((sum ^ cksum) == 0)
		return 1;
	else
		return 0;
}

void blitHexOnScreen(char* buf, int count) {
	int i;
	printf("-----------------------------------------------\n");
	for (i=0; i<count; i++) {
		printf("%02X ", (unsigned char) *(buf + i));
		if ((i+1) % 16 == 0 && (i+1) < count)
			printf("\n");
	}
	printf("\n-----------------------------------------------\n");
}

void blitAsciiOnScreen(char* buf, int count) {
	int i;
	printf("-----------------------------------------------\n");
	for (i=0; i<count; i++) {
		printf("%c", (unsigned char) *(buf + i));
		if ((i+1) % 32 == 0 && (i+1) < count)
			printf("\n");
	}
	printf("\n-----------------------------------------------\n");
}	

int blitData(FILE* desc) {

	return 0;
}

int main(int argc, char** argv) {
	if (argc < 2) {
		printf("No filename specified\n");
		return 0;
	}
	printf("Loading %s\n", argv[1]);
	if (loadFile(argv[1]) < 0) {
		printf("Problem loading file. Exiting\n");
		return 1;
	}
	if (readHeaderInfo() < 0) {
		printf("Invalid or corrupted header");
		return 1;
	}
	printf("Initializing emulated memory\n");
	if (initMem() < 0) {
		printf("Init mem failed. Exiting\n");
		return 1;
	}
	printf("Initializing video system\n");
	if (initSdlVideo() == 0) {
		printf("Init video failed. Exiting\n");
		return 1;
	}

	if (initSound() < 0) {
		printf("Init sound failed. EXiting\n");
		return 1;
	}

	printf("Initializing registers\n");
	if (initCpu() < 0 || boot() < 0) {
		printf("Init cpu failed. Exiting\n");
		return 1;
	}
	return 0;	
}
