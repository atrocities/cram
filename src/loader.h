#ifndef _CLOADER
#define _CLOADER

typedef struct {
        unsigned char nlogo[0x30];      /* 0x104-0x133 nintendo logo */
        unsigned char title[16];        /* 0x134-0x143 game title  */
        unsigned char mcode[3];         /* 0x13F-0x142 manufacturer code  */
        unsigned char cgb;              /* 0x143 CGB flag */
        unsigned char nlcode[2];        /* 0x144-0x145 new licensee code */
        unsigned char sgb;              /* 0x146 SGB flag */
        unsigned char ctype;            /* 0x147 cart type */
        unsigned char romsize;          /* 0x148 rom size */
        unsigned char ramsize;          /* 0x149 ram size */
        unsigned char dcode;            /* 0x14A dest code */
        unsigned char olcode;           /* 0x14B old license code */
        unsigned char mrver;            /* 0x14C mask rom version number */
        unsigned char hchecksum;        /* 0x14D header checksum */
        unsigned char gchecksum[2];     /* 0x14E-0x14F gloabl checksum */
} rominfo;

extern char* title;
extern long ROMSIZE;
extern unsigned char* ROM;
extern rominfo* ROMINFO;

int loadFile(char* filename);
long getFileSize(FILE* desc);
int readHeaderInfo();
void blitHexOnScreen(char* buf, int count);
void blitAsciiOnScreen(char* buf, int count);
char* getCType(unsigned char ccode);
char* getRomSize(unsigned char rcode);
char* getRamSize(unsigned char rcode);
int checkChecksum(unsigned char cksum);

#endif
