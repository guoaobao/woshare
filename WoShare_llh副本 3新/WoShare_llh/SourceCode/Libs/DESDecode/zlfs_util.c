#include "zlfs_util.h"
#include <dirent.h>

static const char nybble_chars[] = "0123456789abcdef";
#define ASCII2HEX(data)  (data >= '0' && data <= '9')? (data - '0') : ((data >= 'A' && data <= 'F')? (data - 'A' + 10) : ((data >= 'a' && data <= 'f')? (data - 'a' + 10) : 0))

void hex2ascii(unsigned char b, char *ch1, char *ch2) 
{
	*ch1 = nybble_chars[ ( b >> 4 ) & 0x0F ];
	*ch2 = nybble_chars[ b & 0x0F ];
}

unsigned char ascii2hex(unsigned char *buffer)
{
	unsigned char temp;
	unsigned char c;

	c = *buffer++;
	temp = ((unsigned char)ASCII2HEX(c)) << 4;
	c = *buffer;
	temp += ASCII2HEX(c);

	return temp;
}


