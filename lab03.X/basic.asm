 #INCLUDE <p18f4520.inc>
 CONFIG OSC = INTIO67
 CONFIG WDT = OFF 
 org 0x00 ;PC = 0x00
 
 
 MOVLW 0xC8
 MOVWF TRISA
 BCF STATUS, C
 RLCF TRISA, F ; logic leftmove
 
 
 CLRF 0x000 ; clear [0x000]
 BTFSC TRISA, 7 ; check 7th bit is 0 or not
 BTFSS TRISA, 7
 INCF 0x000 ; 7th bit is 0
 
 
 RRNCF TRISA, F
 BTFSC 0x000, 0 ; if it's 0 means negative
 BTFSS 0x000, 0 ; if it's 1 means positive
 BSF TRISA, 7
 
 
 
 end
 
 


