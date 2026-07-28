#INCLUDE <p18f4520.inc>
 CONFIG OSC = INTIO67
 CONFIG WDT = OFF 
 org 0x00 ;PC = 0x00 
 
Sub_Mul macro F1, F2, F3, F4
     
     MOVF F4, W
     SUBWF F2, W ; [Wreg] = X_low - Y_low
     MOVWF 0x001
     
     ;BTFSS STATUS, C ; check carry bit
     ;DECF F1
     
     MOVF F3, W
     SUBWFB F1, W ; [Wreg] = X_high - Y_high ; late version : subwf -> subwfb
     MOVWF 0x000
     
     
     MOVF 0x000, W
     MULWF 0x001 ; [0x000] * [0x001]
    
     MOVFF PRODH, 0x010
     MOVFF PRODL, 0x011

     endm 
     
MOVLW 0x0A
MOVWF 0x030 ; X_high
MOVLW 0x04 
MOVWF 0x031 ; X_low
 
MOVLW 0x04
MOVWF 0x032 ; Y_high
MOVLW 0x02
MOVWF 0x033 ; Y_low
     
Sub_Mul 0x030, 0x031, 0x032, 0x033

end
