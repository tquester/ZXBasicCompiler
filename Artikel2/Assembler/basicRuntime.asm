zxromCl         equ $0D6B
zxromPlot:      equ $22DC+3
zxromClSet:     equ $0DD9 ; b = B	Line number C	Column number
zxromAlpha:     equ $2C8D
; * 128 If the character position is flashing, 0 if it is steady 
;	64 if the character position is bright, 0 if it is normal 
;	8* the code for the paper colour 
;	the code for the ink colour

PRINTA:                 macro
                        if DEBUG=1
                        call printA
                        else
                        call $09F4
                    ;   rst $10
                        endif
                        endm
runtimeCls:             ld      e,0
                        ld      h,0
                        call    runtimePrintAt
                        LD		HL,$4000
                        LD		BC,6144
rt_cls1:
                        LD		A,$00
                        LD		(HL),A
                        INC		HL
                        DEC		BC
                        LD    A,B
                        OR    C
                        JP		NZ, rt_cls1
                        LD		BC,768
rt_cls2:
                        LD		A,(ZX_ATTR_P)
                        and     0b000111111
                        LD		(HL),A
                        INC		HL
                        DEC		BC
                        LD    A,B
                        OR    C
                        JP		NZ, rt_cls2
                        ld    bc,0
                        call  runtimePrintAt
                        RET
    ret
runtimeLocalInk:
    ld a, (ZX_ATTR_T)
    and 0b11111000
    or l
    ld (ZX_ATTR_T), a
    ret

runtimeLocalPaper:
    ld a,l
    and a,7
    add a,a
    add a,a
    add a,a
    ld l,a
    ld a, (ZX_ATTR_T)
    and 0b11000111
    or l
    ld (ZX_ATTR_T), a
    ret 

runtimeLocalFlash:
    LD  bc,0x0080
    ld  a,l
    cp  1
    call z, CTOB
    ld a, (ZX_ATTR_T)
    and 0b01111111
    or b
    ld (ZX_ATTR_T), a
    ret
runtimeLocalBright:
    ld bc,$0040
    ld a,l
    cp 1
    call z, CTOB
    ld a, (ZX_ATTR_T)
    and 0b10111111
    or b
    ld (ZX_ATTR_T), a
    ret

runtimeFlash:
    LD  bc,0x0080
    ld  a,l
    cp  1
    call z, CTOB
    ld a, (ZX_ATTR_P)
    and 0b01111111
    or b
    ld (ZX_ATTR_T), a
    ld (ZX_ATTR_P), a
    ret
runtimeBright:
    ld bc,$0040
    ld a,l
    cp 1
    call z, CTOB
    ld a, (ZX_ATTR_P)
    and 0b10111111
    or b
    ld (ZX_ATTR_T), a
    ld (ZX_ATTR_P), a
    ret

runtimeLocalOver:
    ld a,l
    ld bc,0x0001
    cp 1
    call z, CTOB
    ld   a, (ZX_P_FLAG)
    and 0b11111110
    or  b
    ld (ZX_P_FLAG), a
    ret
runtimeOver:
    ld a,l
    ld bc,0x0002
    cp 1
    call z, CTOB
    ld   a, (ZX_P_FLAG)
    and 0b11111101
    or  b
    ld (ZX_P_FLAG), a
    ret

runtimeInverse:
    ld a,l
    ld bc,0x000C
    cp 1
    call z, CTOB
    ld   a, (ZX_P_FLAG)
    and 0b11100111
    or  b
    ld (ZX_P_FLAG), a
    ret
runtimeLocalInverse:
    ld a,l
    ld bc,0x0004
    cp 1
    call z, CTOB
    ld   a, (ZX_P_FLAG)
    and 0b11111011
    or  b
    ld (ZX_P_FLAG), a
    ret

runtimeInk:
    ld a,l
    AND 7
    ld l,a
    ld a, (ZX_ATTR_P)
    and 0b11111000
    or l
    ld (ZX_ATTR_T), a
    ld (ZX_ATTR_P), a
    ret

runtimePaper:
    ld a,l
    and a,7
    add a,a
    add a,a
    add a,a
    ld l,a
    ld a, (ZX_ATTR_P)
    and 0b11000111
    or l
    ld (ZX_ATTR_T), a
    ld (ZX_ATTR_P), a
    ret   

runtimePlot:  
	LD B,L
	LD C,E

    call zxromPlot
    ret

runtimeDraw:  
; hl = y (16 bit, may be negative)
; de = x (16 bit, may be negative)
; 

    ld  a,h         ; h = sgn y -> d
    ld  h,1 
    LD  B,L
    and $80
    JR Z, runtimeDraw1  ; if positive, skip
    LD  A,L
    neg 
    LD  B,A
    ld  h,255
runtimeDraw1:

    LD A,D
    LD L,1        ; l = sgn x -> E
    LD C,E
    and $80
    jr Z, runtimeDraw2 
    LD L,255
    LD A,E
    NEG
    LD C,A
runtimeDraw2:    
    LD A,L
    LD E,A
    LD A,H
    LD D,H



    call $24BA ; call zxromDraw
    ret

; compiled strings start with the length (2 bytes) followed by the string without terminating 0
runtimePrintString:
    ld bc,(hl)
    inc hl
    inc hl
runtimePrntString1:
    ld a,(hl)
    
    PUSH BC
    PUSH HL
    ;rst $10
    PRINTA
    POP HL
    POP BC
    inc hl
    dec bc
    ld  a,b
    or c
    jp nz,runtimePrntString1
    ret

runtimePrintAt:
    if DEBUG=1
    ld a,l
    ld (charX),a

    ld a,e
    ld (charY),a
    else
    ld b,e
    ld c,l
    ld a,24
    sub b
    ld b,a
    ld a,32
    sub c
    ld c,a
;    ld (ZX_S_POSN_COL),bc
    call zxromClSet
    endif
    ret

runtimePrintNewline:
    ld a,13
    PRINTA
    ret    

runtimePrintInt:    push    ix
                    push    iy
                    push    hl
                    push    de
                    push    bc
					LAlloc  10
                    ld      (ix),0
                    inc     ix
runtimePrintIntLoop:     
                    ld      d,10
                    push    hl                          ; stack = hl
                    call    DivHLxD
                    
                    push    hl                          
                    pop     bc
                    ld      de,10
                    call    Mul16BCxDE
                    pop     de                          ; de = zahl, z.b. 1234
                                                        ; hl = zahl/10*10 z.b. 1230                    
                    ex      hl,de
                    sub     hl,de
                    ld      a,l
                    add     48
                    ld      (ix),a
                    inc     ix
                    ld      hl,bc
                    ld      a,h
                    cp      0
                    jr      nz, runtimePrintIntLoop
                    ld      a,l
                    cp      0
                    jr      nz, runtimePrintIntLoop

                    dec     ix
runtimePrintIntLoop2:      ld      a,(ix)
                    cp      0
                    jr      z,runtimePrintIntEnd
                    PRINTA
                    dec     ix
                    jr      runtimePrintIntLoop2
runtimePrintIntEnd:      LRelease 10	

                    pop     bc
                    pop     de
                    pop     hl
                    pop     iy
                    pop     ix
 
                    ret                    




runtimeUsrUDG:
    ld bc,(hl)
    dec bc
    ld  a,b
    or c
    ret nz
runtimeUsrUDG1:
    ld a,(hl)
    call zxromAlpha
    ret nc
    and 0b00111111      ; Convert to upper case
    sub 65              ; subtract A
    ret c               ; out of range
    cp  20
    ret c               ; out of range
    add a,a
    add a,a
    add a,a             ; *8 
    LD BC,($5C7B)       ; UDG address
    ld  l,a
    ld  h,0
    add hl,bc
    ret 

runtimeInkey:
    call rtReadKeyboard 
    cp   0
    jr   z,runtimeInkeyNoKey
    ld   (rtInkeyChar),a
    ld   hl,1
    ld   (rtInkeyString),hl
    ld   hl,rtInkeyString
    ret
runtimeInkeyNoKey:  
    ld   hl,0
    ld   (rtInkeyString),hl
    ld   a,0
    ld   (rtInkeyChar),a
    ld   hl,rtInkeyString
    ret

runtimeCode:
    ld de,(hl)
    ld a,e
    or d
    jr nz, runtimeCode1
    ld hl,0
    ret
runtimeCode1:
    inc hl
    inc hl
    ld  l,(hl)
    ld  h,0
    ret

runtimePause:
    call rtReadKeyboard
    ret z
    dec hl
    ld a,h
    or l
    ret z
    jr runtimePause



         


HL1: LD HL,1
     ret
CTOB:
    ld b,c
    ret

rtGetKeyOrJoystick		call	ReadKeyboard
						cp		0
						jr		nz, rtGetKeyOrJoystick2
						ld 		bc,31
						in 		a,(c)
						and		31
						ld		b,a
						cp		0
						jr		z, rtGetKeyOrJoystick
						ld		a,$ff
						ret
rtGetKeyOrJoystick2:	push 	af
rtGetKeyOrJoystick3:	call    rtReadKeyboard
                        cp      0
                        jr      nz,rtGetKeyOrJoystick3
                        pop     af
                        ret				

rtGetKey:               call    rtReadKeyboard
                        cp      0
                        jr      z,rtGetKey

rtWaitKeyRelease:       push af
rtWaitKeyRelease1:      call    rtReadKeyboard
                        cp      0
                        jr      nz,rtWaitKeyRelease1
                        pop     af
                        ret
rtReadKeyboard:         PUSH    HL
                        PUSH    DE
                        PUSH    BC    
                        LD HL,rtKeyboard_Map                      ; Point HL at the keyboard list
                        LD D,8                                  ; This is the number of ports (rows) to check
                        LD C,$FE                                ; C is always FEh for reading keyboard ports
rtRead_Keyboard_0:      LD B,(HL)                               ; Get the keyboard port address from table
                        INC HL                                  ; Increment to list of keys
                        IN A,(C)                                ; Read the row of keys in
                        AND $1F                                 ; We are only interested in the first five bits
                        LD E,5                                  ; This is the number of keys in the row
rtRead_Keyboard_1:      SRL A                                   ; Shift A right; bit 0 sets carry bit
                        JR NC,rtRead_Keyboard_2                   ; If the bit is 0, we've found our key
                        INC HL                                  ; Go to next table address
                        DEC E                                   ; Decrement key loop counter
                        JR NZ,rtRead_Keyboard_1                   ; Loop around until this row finished
                        DEC D                                   ; Decrement row loop counter
                        JR NZ,rtRead_Keyboard_0                   ; Loop around until we are done
                        AND A                                   ; Clear A (no key found)
                        POP     BC
                        POP     DE
                        POP     HL
                        RET
rtRead_Keyboard_2:		
                        LD A,(HL)                               ; We've found a key at this point; fetch the character code!
                        POP     BC
                        POP     DE
                        POP     HL
                        RET

rtReadMKeyboard:        PUSH    HL
                        PUSH    DE
                        PUSH    BC    
						PUSH	IX
;						ld		bc,$0112
;						call	printSetAt  						
;						ld      a,$12*8
;						call    clearTextLine						

						ld		ix,rtReadKeyboardPressedKeys
						ld		(ix),0
                        LD HL,rtKeyboard_Map                      ; Point HL at the keyboard list
                        LD D,8                                  ; This is the number of ports (rows) to check
                        LD C,$FE                                ; C is always FEh for reading keyboard ports
rtReadMKeyboard_0:      LD B,(HL)                               ; Get the keyboard port address from table
                        INC HL                                  ; Increment to list of keys
                        IN A,(C)                                ; Read the row of keys in
                        AND $1F                                 ; We are only interested in the first five bits
;						call	printHex2
;						push	af
;						ld		a,32
;						call	printA
;						pop 	af
                        LD E,5                                  ; This is the number of keys in the row
rtReadMKeyboard_1:      SRL A                                   ; Shift A right; bit 0 sets carry bit
                        JR C,rtReadMKeyboard_2                   ; If the bit is 0, we've found our key
						push	af
						ld		a,(hl)
						ld		(ix),a
						inc		ix
						ld		(ix),0
						pop		af
rtReadMKeyboard_2:	    INC HL                                  ; Go to next table address
                        DEC E                                   ; Decrement key loop counter
                        JR NZ,rtReadMKeyboard_1                   ; Loop around until this row finished
                        DEC D                                   ; Decrement row loop counter
                        JR NZ,rtReadMKeyboard_0                   ; Loop around until we are done
                        AND A                                   ; Clear A (no key found)
						ld		hl,rtReadKeyboardPressedKeys
;						ld		bc,$0014
;						call	printSetAt
;						call	printHL
						POP		IX
                        POP     BC
                        POP     DE
                        POP     HL
                        RET

		

rtReadKeyboardPressedKeys:defs 5*8+1,0						

rtInkeyString:          dw 0
rtInkeyChar             db 0
rtKEY_SHIFT:              equ     1
rtKEY_SYMBOL_SHIFT:		equ		2	
rtKeyboard_Map:         DB $FE, 1,"Z","X","C","V"
                        DB $FD,"A","S","D","F","G"
                        DB $FB,"Q","W","E","R","T"
                        DB $F7,"1","2","3","4","5"
                        DB $EF,"0","9","8","7","6"
                        DB $DF,"P","O","I","U","Y"
                        DB $BF,13,"L","K","J","H"
                        DB $7F," ",2,"M","N","B"   



 
