#INCLUDE <p18f4520.inc> 
 CONFIG OSC = INTIO67
 CONFIG WDT = OFF 
 org 0x00 ;PC = 0x00 

 start:
    MOVLW 0x08 
    MOVLB 0x1 ; BSR = 1
    MOVWF 0x00, 1 ; [0x100] = 0x08
    MOVLW 0x7C
    MOVWF 0x01, 1 ; [0x101] = 0x7c    
    MOVLW 0x78
    MOVWF 0x02, 1 ; [0x102] = 0x78 
    MOVLW 0xFE
    MOVWF 0x03, 1 ; [0x103] = 0xFE    
    MOVLW 0x34
    MOVWF 0x04, 1 ; [0x104] = 0x34
    MOVLW 0x7A
    MOVWF 0x05, 1 ; [0x105] = 0x7A    
    MOVLW 0x0D
    MOVWF 0x06, 1 ; [0x106] = 0x0D
    
    
    MOVLW 0x6 ; 0~5 (loop_i count )
    MOVWF 0x0F0 ; [0x0F0] = 0x06 = i_count

    
    LFSR 0, 0x101 ; 0 : j
    LFSR 1, 0x100 ; 1 : j+1

    
loop_i:
    ; MOVF 0x0F0, W
    ; BZ end_tag
    MOVLW 0x06
    MOVWF 0x0F2

    LFSR 0, 0x100 ; 0 : j
    LFSR 1, 0x101 ; 1 : j+1
    
    
loop_j_check:
    ; MOVF 0x0F2, W 
    ; BZ i_update ; j_value check

    MOVF INDF0, W
    MOVFF INDF1, 0x1D0
    CPFSGT 0x1D0 ; if f > [Wreg] skip next line => no change
    GOTO change
    GOTO nochange
    

change: ; if FSR0 > FSR1
    MOVF INDF0, W
    MOVWF 0x1E0 ; [0x1E0] = [INDF0]
    MOVF INDF1, W ; [Wreg] = [INDF1]
    MOVWF INDF0 ; [INDF0'] = [INDF1]
    MOVF 0x1E0, W
    MOVWF INDF1 ; [INDF1'] = [INDF0]

    
nochange:
    INCF FSR0L, F ; [FSR0+1]
    INCF FSR1L, F ; [FSR1+1]
    GOTO j_count_check
    
j_count_check:
    DECFSZ 0x0F2 ; check if [0x0F2] (j) is 0 or not
    GOTO loop_j_check

i_update:    
    DECFSZ 0x0F0
    GOTO loop_i
    
end_tag:
    
    NOP
    end