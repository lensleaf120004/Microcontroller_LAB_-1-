#include <xc.h>
extern unsigned char mysqrt(unsigned char a);

void main(void) {
    volatile unsigned int result = mysqrt(144);
    while(1);
    return;
}
