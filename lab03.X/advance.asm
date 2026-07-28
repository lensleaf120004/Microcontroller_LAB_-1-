#INCLUDE <p18f4520.inc>
 CONFIG OSC = INTIO67
 CONFIG WDT = OFF 
 org 0x00 ;PC = 0x00
 
 MOVLW 0x77 
 MOVWF 0x000
 MOVLW 0x77
 MOVWF 0x001 ; insert 1st data 

 MOVLW 0x56
 MOVWF 0x010
 MOVLW 0x78
 MOVWF 0x011 ; insert 2nd data
 
 ; clear 0x020 0x021 0x022 0x023
 CLRF 0x020              
 CLRF 0x021
 CLRF 0x022
 CLRF 0x023

 ; Low1 * Low2 
 MOVF 0x001, W ; low part of 1st data -> WREG
 MULWF 0x011 ; WREG * low part of 2nd data
 MOVFF PRODL, 0x023 ; temp ans's low -> lowest part of result
 MOVFF PRODH, 0x022 ; temp ans's high -> 2nd lowest part of result

 
 ; Low1 * High2 
 MOVF 0x010, W ; high part of 2nd data ->  WREG
 MULWF 0x001 ; WREG * low part of 1st data
 MOVF PRODL, W ; PRODL -> WREG
 ADDWF 0x022, F ; add into 2nd lowest of result
 MOVF PRODH, W ; PRODH -> WREG
 ADDWFC 0x021, F ; add into 2nd highest of result (with carry)

 
 ; High1 * Low2 
 MOVF 0x000, W ; high part of 1st data -> WREG
 MULWF 0x011 ; WREG *low part of 2nd data
 MOVF PRODL, W ; PRODL -> WREG
 ADDWF 0x022, F ; add low part of temp ans into 2nd lowest result
 MOVF PRODH, W ; PRODH -> WREG
 ADDWFC 0x021, F ;  add high part of temp ans into 2nd highest result (with carry)

 
 ; High1 * High2
 MOVF 0x000, W           ; high part of 1st data -> WREG
 MULWF 0x010             ; WREG * high part of 2nd data
 MOVF PRODL, W           ; PRODH -> WREG
 ADDWF 0x021, F         ; add high part of temp ans into the highest of result (with carry)
 MOVF PRODH, W           ; PRODL -> WREG
 ADDWFC 0x020, F          ; add low part of temp ans into the 2nd high of result

 
 

end
    
    
    
 
 