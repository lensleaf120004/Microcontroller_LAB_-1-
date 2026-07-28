#INCLUDE <p18f4520.inc>
 CONFIG OSC = INTIO67
 CONFIG WDT = OFF 
 org 0x00 ;PC = 0x00
 
    MOVLW 0x2A
    MOVWF 0x000
    MOVLW 0x41
    MOVWF 0x001
    
    MOVLW 0x08
    MOVWF 0x00A
 
check_high: ; check high part is 0 or not
    TSTFSZ 0x000
    GOTO high_loop
    GOTO check_low ; high part is 0

high_loop:
    BTFSS 0x000, 7 ; check is 1 or not
    BTFSC 0x000, 7 ; the bit is 0
    GOTO total_h
    RLNCF 0x000
    DECFSZ 0x00A

    GOTO high_loop
    GOTO check_low
    
check_low: ; check low part is 0 or not
    MOVLW 0x07
    MOVWF 0x00A
    TSTFSZ 0x001
    GOTO low_loop
    GOTO end_tag

low_loop:
    BTFSS 0x001, 7
    BTFSC 0x001, 7
    GOTO total_l
    RLNCF 0x001
    DECFSZ 0x00A
    
    GOTO low_loop
    GOTO end_tag
    
    
    
total_h:
    MOVLW 0x07
    ADDWF 0x00A, W
    MOVWF 0x002
    ;BCF STATUS, C
    RLCF 0x000
    MOVF 0x000, W
    XORWF 0x001, F
    MOVLW 0x00
    CPFSEQ 0x001
    INCF 0x002
    GOTO end_tag
    
    
total_l:
    MOVF 0x00A, W
    MOVWF 0x002
    ;BCF STATUS, C
    RLCF 0x001
    MOVLW 0x00
    CPFSEQ 0x001
    INCF 0x002
    GOTO end_tag
    
end_tag:    
    end
    
 
 
 

 