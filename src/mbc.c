#include <string.h>
#include <stdio.h>

#include "cram.h"
#include "mem.h"
#include "loader.h"
#include "cpu.h"
#include "mbc.h"

int rompage, rampage, mbcmode, ramenable;
int romoffset = 0, ramoffset = 0;

byte romr(word addr) {
	return ROM[addr];
}

void romw(word addr, word val, byte len) {
}

byte mbc1r(word addr) {
	if (addr >= 0x4000 && addr <= 0x7FFF) {
		int faddr;
		//fprintf(stderr, "Reading from flippable ROM\n");
		faddr = (0x4000 * rompage) + (addr - 0x4000);
		return ROM[faddr];
	} 
	else if (addr >= 0 && addr <= 0x3FFF)
		return ROM[addr];
	else if (addr >= 0xA000 && addr <= 0xBFFF)
		return ERAM[(addr - 0xA000) + (0x2000 * rampage)];
}

void mbc1w(word addr, word val, byte len) {
	if (addr >= 0x2000 && addr <= 0x3FFF) {
		rompage = (val & 0x1F) | (rompage & 0x60);
		if (rompage == 0)
			rompage = 1;
		romoffset = 0x4000 * (rompage - 1);
	}
	if (addr >= 0x0 && addr <= 0x1FFF) {
		if ((val & 0xF) == 0xA)
			ramenable = 1;
		else
			ramenable = 0;
	}
	if (addr >= 0x4000 && addr <= 0x5FFF) {
		if (mbcmode == 1) {
			rampage = val & 0x3;
			ramoffset = rampage * 0x2000;
		}
		else {
			rompage = (rompage & 0x1F) | ((val & 0x3) << 5);
			romoffset = 0x4000 * (rompage - 1);
		}
	}
	if (addr >= 0x6000 && addr <= 0x7FFF) {
		mbcmode = addr & 0x1;
		if (mbcmode == 0) {
			rampage = 0;
			ramoffset = rampage * 0x2000;
		}
		if (mbcmode == 1) {
			rompage = rompage & 0x1F;
			romoffset = (rompage - 1) * 0x4000;
		}
	}
	if (addr >= 0xA000 && addr <= 0xBFFF) {
		ERAM[(addr - 0xA000) + (0x2000 * rampage)] = val & 0xFF;
		if (len == 2)
			ERAM[addr + 1 + (0x2000 * rampage)] = val & 0xFF00;
	}
	
}


byte mbc3r(word addr) {
	if (addr >= 0x4000 && addr <= 0x7FFF) {
		int faddr;
		//fprintf(stderr, "Reading from flippable ROM\n");
		faddr = (0x4000 * rompage) + (addr - 0x4000);
		return ROM[faddr];
	} 
	else if (addr >= 0 && addr <= 0x3FFF)
		return ROM[addr];
	else if (addr >= 0xA000 && addr <= 0xBFFF)
		return ERAM[(addr - 0xA000) + (0x2000 * rampage)];
}

void mbc3w(word addr, word val, byte len) {
	if (addr >= 0x2000 && addr <= 0x3FFF) {
		rompage = val;
		if (rompage == 0)
			rompage = 1;
	}
	if (addr >= 0x0 && addr <= 0x1FFF) {
		if ((val & 0xF) == 0xA)
			ramenable = 1;
		else
			ramenable = 0;
	}
	if (addr >= 0x4000 && addr <= 0x5FFF) {
		rampage = val & 0x3;
	}
	if (addr >= 0x6000 && addr <= 0x7FFF) {
		mbcmode = val;
	}
	if (addr >= 0xA000 && addr <= 0xBFFF) {
		ERAM[(addr - 0xA000) + (0x2000 *rampage)] = val & 0xFF;
		if (len == 2)
			ERAM[addr + 1 + (0x2000 * rampage)] = val & 0xFF00;
	}
	
}


