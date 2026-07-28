#INCLUDE <p18f4520.inc>
CONFIG OSC = INTIO67
CONFIG WDT = OFF
org 0x00 ;PC = 0x00

start: 
    
    CLRF 0x032         
    CLRF 0x033 ; Fn-2
    
    CLRF 0x030
    CLRF 0x031 ; Fn-1
    
    MOVLW 0x01
    MOVWF 0x031 ; F1
    
    ; n = 9 
    MOVLW 0x09
    MOVWF 0x020 ; [0x020] = n
    
    DECF 0x020 ; n-1
    
     
loop: ; because F1 = 1, F9 : F2 ~ F9 (total 8 times)
    rcall fib 
    DECFSZ 0x020 

    GOTO loop 
    GOTO finish 

fib:
    ; Fn = Fn-1 + Fn-2
    ; low part
    MOVF 0x033, W ; Fn-2 (low)
    ADDWF 0x031, W ; Fn-1 = Fn-2(low) + Fn-1(low) 
    MOVWF 0x035 ; [0x035] = result(low)
    
    
    ; high part
    MOVF 0x032, W ; Fn-2 (high)
    ADDWFC 0x030, W ; Fn-1 = Fn-2(high) + Fn-1(high) + lowpart_carry(if carry happen)
    MOVWF 0x034 ;  [0x034] = result(high)
    
    ; update result to [0x000] and [0x001]
    MOVFF 0x035, 0x001 
    MOVFF 0x034, 0x000 
    
    ; update: Fn-2 = Fn-1
    MOVFF 0x031, 0x033 
    MOVFF 0x030, 0x032 
    
    ; update: Fn-1 = Fn
    MOVFF 0x035, 0x031 
    MOVFF 0x034, 0x030 
    
    RETURN

finish:
    NOP
    end

