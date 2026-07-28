List p=18f4520
    #include<p18f4520.inc>
    CONFIG OSC = INTIO67
    CONFIG WDT = OFF
    org 0x00

     
    MOVLW 0x11 ; A
    MOVWF 0x000 ; [0x000] = 0x01 = A
    MOVLW 0xA1 ; B
    MOVWF 0x001 ; [0x001] = 0x02 = B

    
    MOVF 0x000, W ; W = [0x000] = A
    ADDWF 0x001, W ; W = [0x000] + [0x001] (A + B)
    MOVWF 0x002 ; [0x002] = A + B

    
    MOVLW 0xC5 ; C
    MOVWF 0x010 ; [0x010] = 0x04 = C
    MOVLW 0xB7 ; D
    MOVWF 0x011 ; [0x011] = 0x03 = D

    
    MOVF 0x011, W ; W = [0x011] = D
    SUBWF 0x010, W ; W = [0x010] - W (C - D)
    MOVWF 0x012 ; [0x012] = C - D


start:
    MOVF 0x012, W ; W = [0x012]
    CPFSEQ 0x002 ;  ?? A1 (0x002) ? A2(0x012)(W)
    GOTO check_if_greater ; ?? A1 > A2 ?
    MOVLW 0xBB ; A1 = A2
    MOVWF 0x020 ; [0x020] = 0xBB
    GOTO End_if

check_if_greater:
    CPFSGT 0x002 ; ? A1(0x002) > A2(0x012)(W)
    GOTO smaller
    MOVLW 0xAA ; A1 > A2
    MOVWF 0x020 ; [0x020] = 0xAA
    GOTO End_if

smaller:
    MOVLW 0xCC ; A1 < A2
    MOVWF 0x020 ; [0x020] = 0xCC

End_if:
    NOP

    end

	





