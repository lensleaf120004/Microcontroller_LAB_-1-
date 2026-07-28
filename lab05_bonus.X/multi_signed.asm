#include "xc.inc"
GLOBAL _multi_signed
PSECT nytext,local,class=CODE,reloc=2
 
;a(8bits) * b(8bits but range only 4 bits) -> signed multiplication 
_multi_signed:
    ; a -> WREG  b -> 0x001
    MOVFF WREG, 0x020 ; [0x020] = a        
    MOVFF 0x001, 0x021 ; [0x021] = b

    check_b:
        BTFSS 0x021, 3
        GOTO check_a
        COMF 0x021, F ; if b is negative
        INCF 0x021
        INCF 0x040 ; [0x040] = MSB of b

    check_a:
        BTFSS 0x020, 7
        GOTO mult_loop
    
        COMF 0x020, F
        INCF 0x020
        INCF 0x050 ; [0x050] = MSB of a

    mult_loop:
        MOVFF 0x020, WREG
        MULWF 0x021
        MOVFF PRODL, 0x060
        MOVFF PRODH, 0x061
    
        MOVFF 0x050, WREG
        XORWF 0x040, W
        MOVFF WREG, 0x070
        BTFSC 0x070, 0
        GOTO amend
        GOTO finish
    
    amend:
        COMF 0x060, F
        COMF 0x061, F
        MOVFF 0x060, WREG
	ADDLW 1
	MOVWF 0x060
        BTFSC STATUS, 0
        INCF 0x061
        
    
    finish:
        MOVFF 0x060, 0x001 ; store result_low in retun place
        MOVFF 0x061, 0x002 ; store result_high in return place
        RETURN ; RETURN result to main.c


