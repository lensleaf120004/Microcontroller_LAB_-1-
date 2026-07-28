#INCLUDE <p18f4520.inc>
 CONFIG OSC = INTIO67
 CONFIG WDT = OFF 
 org 0x00 ;PC = 0x00
 
start: 
    MOVLW 0x03
    MOVWF 0x000 ; a1
    MOVLW 0x04
    MOVWF 0x001 ; a2
    MOVLW 0x07
    MOVWF 0x002 ; a3
    
    MOVLW 0x05
    MOVWF 0x010 ; b1
    MOVLW 0x05
    MOVWF 0x011 ; b2
    MOVLW 0x03
    MOVWF 0x012 ; b3
    
    rcall cross
    GOTO finish
    
cross:
    MOVF 0x001, W
    MULWF 0x012 ; a2 * b3
    MOVFF PRODH, 0x060
    MOVFF PRODL, 0x061
    MOVF 0x002, W
    MULWF 0x011 ; a3 * b2
    MOVFF PRODH, 0x070
    MOVFF PRODL, 0x071
    MOVF 0x071, W
    SUBWF 0x061, W ; a2 * b3(low) - a3 * b2(low) / simply focus on low part
    MOVWF 0x020
    
    MOVF 0x002, W
    MULWF 0x010 ; a3 * b1
    MOVFF PRODH, 0x060
    MOVFF PRODL, 0x061
    MOVF 0x000, W
    MULWF 0x012 ; a1 * b3
    MOVFF PRODH, 0x070
    MOVFF PRODL, 0x071
    MOVF 0x071, W
    SUBWF 0x061, W ; a3 * b1 - a1 * b3 / simply focus on low part
    MOVWF 0x021
    
    MOVF 0x000, W
    MULWF 0x011
    MOVFF PRODH, 0x060
    MOVFF PRODL, 0x061
    MOVF 0x001, W
    MULWF 0x010
    MOVFF PRODH, 0x070
    MOVFF PRODL, 0x071
    MOVF 0x071, W
    SUBWF 0x061, W ; a1 * b2 - a2 * b1 / simply focus on low part
    MOVWF 0x022 
    
    RETURN

finish:
    end
 


