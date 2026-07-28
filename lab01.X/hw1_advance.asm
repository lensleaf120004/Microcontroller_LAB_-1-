    List p=18f4520
    #include<p18f4520.inc>
    CONFIG OSC = INTIO67
    CONFIG WDT = OFF
    org 0x00
    
    
    MOVLW 0xF7  ; A
    MOVWF 0x000  ; [0x000] = A
    MOVLW 0x9F  ; B
    MOVWF 0x001  ; [0x001] = B

    ; ??? A ??4? 
    MOVF 0x000, W  ; W = [0x000] (A)
    ANDLW 0xF0  ; W = A ??4?  (AND 0x0F)
    MOVWF 0x002  

    ; ??? B ??4? 
    MOVF 0x001, W  ; W = [0x001] (B)
    ANDLW 0x0F  ; W = B ??4?

    ; OR
    IORWF 0x002, F  ; [0x002] = A ??4?? B ??4? OR

    ; ?? [0x002] ????0 
    CLRF 0x003  ; [0x003] = 0
    MOVF 0x002, W  ; W = [0x002]
    MOVWF 0x004  ; W = [0x002] = [0x004]
    MOVLW 0x08  ;???8?
    MOVWF 0x005  ; [0x005] = 8

count_zeros:
    BTFSS 0x004, 0   ; ??[0x004]??0????1 (?1?????)
    INCF 0x003   ; ?0?? [0x003] + 1
    RRNCF 0x004, F   ; [0x004] ??
    GOTO check_if_8
    
check_if_8:    
    DECFSZ 0x005  ; ????8?????0??????????
    GOTO count_zeros      

    
    end

    
    
    


