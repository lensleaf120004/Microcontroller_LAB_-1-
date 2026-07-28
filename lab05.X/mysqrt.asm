#include "xc.inc"
GLOBAL _mysqrt
PSECT nytext,local,class=CODE,reloc=2
    
    
    
    
    
_mysqrt:
    MOVFF WREG, 0x010 
    
    MOVLW 0x00
    MOVWF 0x020 // [0x020] = 0x00 => check_value
    
    loop:
        INCF 0x020
        MOVFF 0x020, WREG
	MULWF 0x020
	MOVFF PRODL, WREG
	
    check_e:
	CPFSEQ 0x010
	GOTO check_g
	GOTO finish
    check_g:
        CPFSLT 0x010
	GOTO loop
	GOTO finish
	
    finish:
        MOVFF 0x020, WREG
        RETURN
        
    
    
    
    
    
    


