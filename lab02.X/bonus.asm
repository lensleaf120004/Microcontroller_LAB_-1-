#INCLUDE <p18f4520.inc>
 CONFIG OSC = INTIO67
 CONFIG WDT = OFF 
 org 0x00 ;PC = 0x00 

    MOVLW 0x28
    MOVWF 0x000
    MOVLW 0x34
    MOVWF 0x001
    MOVLW 0x7A
    MOVWF 0x002
    MOVLW 0x80
    MOVWF 0x003
    MOVLW 0xA7
    MOVWF 0x004
    MOVLW 0xD1
    MOVWF 0x005
    MOVLW 0xFE
    MOVWF 0x006
    
    MOVLW 0xFE ; target_value
    MOVWF 0x020 ; [0x020] = target_value
    
    LFSR 0, 0x000 ; array_low
    LFSR 1, 0x006 ; array_high
    LFSR 2, 0x000 ; mid
    
loop:   
    MOVF FSR0L, W     ; W = FSR0L
    ADDWF FSR1L, W    ; W = FSR0L + FSR1L   
    RRCF WREG, F     ; TEMP_L >> 1 ; [Wreg] = new mid address 
    MOVWF FSR2L ; new mid
    
check:
    MOVF INDF2, W 
    CPFSEQ 0x020 ; if tar == arr[mid], skip
    GOTO check_2b 
    GOTO find

check_2b:
    MOVF INDF2, W
    CPFSGT 0x020 ; if tar > arr[mid], skip
    GOTO small
    INCF FSR2L, F
    MOVF FSR2L, W
    MOVWF FSR0L ; new address of FSR0
    GOTO ftwocheck

small:
    DECF FSR2L, F
    MOVF FSR2L, W
    MOVWF FSR1L ; new address of FSR1
    GOTO ftwocheck
    
ftwocheck:
    MOVF FSR1L, W
    CPFSGT FSR0L ; if F0 > F1 then skip
    GOTO loop
    GOTO not_find
    

find:
    MOVLW 0xFF
    MOVWF 0x011
    GOTO end_tag
 
not_find:
    MOVLW 0x00
    MOVWF 0x011
    GOTO end_tag

end_tag:
    NOP
    end