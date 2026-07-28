List p=18f4520
    #include<p18f4520.inc>
    CONFIG OSC = INTIO67
    CONFIG WDT = OFF
    org 0x00
    
    ; [0x000] = 10000001 / [0x010] = 0x05
    MOVLW b'10000001'
    MOVWF 0x000
    MOVLW 0x05
    MOVWF 0x010 
    MOVLW 0x08
    MOVWF 0x030
    
    
    ; W = 0x05
    loop_check1:
        BTFSS 0x000, 0 ; check? 0 ???? 1 (? 1 ?????)
	BTFSC 0x000, 1 ; check? 1 ???? 0 (? 0 ?????)
	GOTO check2
	INCF 0x010
	INCF 0x010
	GOTO rotate
	
    check2:
        BTFSS 0x000, 0 ; check? 0 ???? 1 (? 1 ??????)
	GOTO check2_add
	GOTO check2_sub
	
    check2_add:
        INCF 0x010
	GOTO rotate
	
    check2_sub:
        DECF 0x010
        GOTO rotate
	
    rotate:
        RRNCF 0x000
	DECFSZ 0x030
	GOTO loop_check1
	
    end
	
	
	
	
	
    



