#INCLUDE <p18f4520.inc>
 CONFIG OSC = INTIO67
 CONFIG WDT = OFF 
 org 0x00 ;PC = 0x00 

    MOVLW 0x01
    MOVLB 0x1 ; BSR = 1
    MOVWF 0x00, 1
    
    MOVLW 0x00
    MOVWF 0x16, 1
    
    MOVLW 0x0C
    MOVWF 0x50 ; total loop times

    LFSR 0, 0x100 ; FSR0 point to 0x100
    LFSR 1, 0x116 ; FSR1 point to 0x116
    
loop_select:
    
    BTFSS 0x50, 0 ; check even or odd
    GOTO even_loop
    GOTO odd_loop
        
even_loop:
    MOVF INDF0, W ; [Wreg] = [FSR0] = 0x00
    MOVWF 0x030 ; [0x030] = [Wreg] = 0x00
    MOVF INDF1, W ; [Wreg] = [FSR1] = 0x01
    ADDWF 0x030, W ; temp answer stored in Wreg [Wreg] = [0x030] + [Wreg] = 0x01
    MOVWF PREINC0 ; [FSR0+1] = [Wreg]
    GOTO check

odd_loop:
    MOVF INDF0, W
    MOVWF 0x030
    MOVF POSTDEC1, W
    ADDWF 0x030, W ; temp answer stored in Wreg
    MOVWF INDF1
    GOTO check
    
check:
    DECFSZ 0x50
    GOTO loop_select


end
    


