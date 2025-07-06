RUNTIME_START: 

zxromCl         equ $0D6B
zxromPlot:      equ $22DC+3
zxromClSet:     equ $0DD9 ; b = B	Line number C	Column number
zxromAlpha:     equ $2C8D
zxMult16bit:    equ $30A9
zxromStackA     equ $2D28
zxromStackBC    equ $2D2B

zxcalc_jump_true:		equ $00 
zxcalc_tan:		        equ $21 
zxcalc_exchange:		equ $01 
zxcalc_asn:		        equ $22 
zxcalc_delete:		    equ $02 
zxcalc_acs:		        equ $23 
zxcalc_subtract:		equ $03 
zxcalc_atn:		        equ $24 
zxcalc_multiply:		equ $04 
zxcalc_ln:		        equ $25 
zxcalc_division:		equ $05 
zxcalc_exp:		        equ $26 
zxcalc_to_power:		equ $06 
zxcalc_int:		        equ $27 
zxcalc_or:		        equ $07 
zxcalc_sqr:		        equ $28 
zxcalc_no_and_no:		equ $08 
zxcalc_sgn:		        equ $29 
zxcalc_no_l_eql:		equ $09 
zxcalc_abs:		        equ $2A 
zxcalc_no_gr_eq:		equ $0A 
zxcalc_peek:		    equ $2B 
zxcalc_nos_neql:		equ $0B 
zxcalc_in:		        equ $2C 
zxcalc_no_grtr:		    equ $0C 
zxcalc_usr_no:		    equ $2D 
zxcalc_no_less:		    equ $0D 
zxcalc_st:		        equ $2E 
zxcalc_nos_eql:		    equ $0E 
zxcalc_ch:		        equ $2F 
zxcalc_addition:		equ $0F 
zxcalc_not:		        equ $30 
zxcalc_str_and_no:		equ $10 
zxcalc_duplicate:		equ $31 
zxcalc_str_l_eql:		equ $11 
zxcalc_n_mod_m:		    equ $32 
zxcalc_str_gr_eq:		equ $12 
zxcalc_jump:		    equ $33 
zxcalc_strs_neql:		equ $13 
zxcalc_stk_data:		equ $34 
zxcalc_str_grtr:		equ $14 
zxcalc_dec_jr_nz:		equ $35 
zxcalc_str_less:		equ $15 
zxcalc_less_0:		    equ $36 
zxcalc_strs_eql:		equ $16 
zxcalc_greater_0:		equ $37 
zxcalc_strs_add:		equ $17 
zxcalc_end_calc:		equ $38 
zxcalc_valstr:		    equ $18 
zxcalc_get_argt:		equ $39 
zxcalc_usr_str:		    equ $19 
zxcalc_truncate:		equ $3A 
zxcalc_read_in:		    equ $1A 
zxcalc_fp_calc_2:		equ $3B 
zxcalc_negate:		    equ $1B 
zxcalc_e_to_fp:		    equ $3C 
zxcalc_code:		    equ $1C 
zxcalc_re_stack:		equ $3D 
zxcalc_val:		        equ $1D 
zxcalc_series_06:		equ $3E 
zxcalc_len:		        equ $1E 
zxcalc_stk_zero:		equ $3F 
zxcalc_sin:		        equ $1F 
zxcalc_st_mem_0:		equ $40 
zxcalc_cos:		        equ $20 
zxcalc_get_mem_0:		equ $41 

zxcalc_stack_zero       equ $A0
zxcalc_stack_one        equ $A1
zxclc_stack_half        equ $A2
zxclc_stack_pi_half     equ $A3
zxclc_stack_ten         equ $A4

zxcalc_store_mem0       equ $C0
zxcalc_store_mem1       equ $C1
zxcalc_store_mem2       equ $C2
zxcalc_store_mem3       equ $C3
zxcalc_store_mem4       equ $C4
zxcalc_store_mem5       equ $C5
zxcalc_get_mem0         equ $E0
zxcalc_get_mem1         equ $E1
zxcalc_get_mem2         equ $E2
zxcalc_get_mem3         equ $E3
zxcalc_get_mem4         equ $E4
zxcalc_get_mem5         equ $E5


xorb1:          ld a,1
                xor b
                ld b,a
                ret
neghl:          ex hl,de
                xor a
                ld l,a
                ld h,a
                sbc hl,de
                ret                
runtimeMult16bit:
                ld b,0
                call sgnabs
                cp $ff
                call z,xorb1
                ex hl,de
                call sgnabs
                cp $ff
                call z,xorb1
                push bc
                ld bc,hl
                call zxMult16bit
                pop bc
                ld  a,b
                cp  $1
                call z,neghl
                 ret

runtimeDiv16bit: 
                ld b,0
                call sgnabs
                cp $ff
                call z,xorb1
                ex hl,de
                call sgnabs
                cp $ff
                call z,xorb1
                push bc
                ld bc,hl
                call Div16                
                ld hl,bc
                pop bc
                ld  a,b
                cp  $1
                call z,neghl
                 ret

; * 128 If the character position is flashing, 0 if it is steady 
;	64 if the character position is bright, 0 if it is normal 
;	8* the code for the paper colour 
;	the code for the ink colour

PRINTA:                 macro
;                        if DEBUG=1
;                        call printA
;                        else
                        PUSH HL
                        call $09F4
                        POP HL                    ;   rst $10
;                        endif
                        endm
runtimeCls:             xor a,a
                        ld (ZX_TV_FLAG),a
                         ld      e,0
                        ld      l,0
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
    ld a,0
    ld (iy+2),a
;    if DEBUG=1
;    ld a,l
;    ld (charX),a

;    ld a,e
;    ld (charY),a
;    else
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
 ;   endif
    ret

runtimePrintNewline:
    ld a,13
    PRINTA
    ret    

runtimePrintTab:
    ld a,6
    PRINTA
    ret    

runtimePrintInt:   call sgnabs
                   cp a,$ff
                   jr nz,runtimePrintPos
                   ld a,"-"
                   PRINTA
runtimePrintPos:                    
                   push    ix
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
    jr z, runtimePause1
    dec hl
    ld a,h
    or l
    ret z
    jr runtimePause
runtimePause1:
    call rtReadKeyboard
    ret nz 
    jr runtimePause1    


         


HL1: LD HL,1
     ret
CTOB:
    ld b,c
    ret

runtimeCheckBreak:      call    $1F54
                        ret     c
                        ld     sp,(runtimeSaveSP)
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

rtGetKeyx:               call    rtReadKeyboard
                        cp      0
                        jr      z,rtGetKeyx

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

; -----------------------------
; Stringverarbeitung
; -----------------------------

; HL = Adress of variable
; DE = Adress of string to store
runtimeStoreString:
    call ZXFreeStringVar ; Free old string if it is a heap string
    push hl
    ld   l,e
    ld   h,d
    call ZXClaim ; Claim memory for the string
    pop  hl
    ld   (hl),de
    call ZXFreeTemp
    call ZXHeapCompactFree

    ret
; BC = String
; DE = von                  ;   1 = erste Position
; HL = bis    
runtimeSubstring:
            dec de
            
            push bc
            push hl
            pop  bc
            pop  hl
            ld   a,b
            and  c
            cp   $ff
            call z, runtimeSubstringEnd
           ; dec  bc
; jetzt: hl = String
    ;        de = start
    ;        bc = ende    
            push hl
            ld hl,bc
            sub hl,de
            ld  bc,hl              ; bc = länge
            pop hl
            add hl,de              ; hl = Start des Strings
            push  hl
            ld   a,ZXHeapTypeTemp
            inc  bc
            inc  bc                 ; 2 bytes for length
            call ZXAlloc           ; hl = Ziel
            pop  de                ; de = Quelle, bc = Länge
            push hl
            dec  bc
            dec  bc
            ld   (hl),bc
            inc  hl
            inc  hl
            inc  de
            inc  de
            ex  de,hl
            ldir 
            pop  hl
            ret
    ret

runtimeSubstringEnd
    ld  c,(hl)              ; Lade die Länge nach Bc
    inc hl
    ld  b,(hl)
    dec hl
    ret    

; HL = second string
; DE = first String
runtimeStringAdd:
    push hl
    push de
    ld   bc,(hl)
    ld   hl,bc
    ld   a,(de)
    ld   c,a
    inc  de
    ld   a,(de)
    ld   b,a
    dec  de
    add  hl,bc          ; Länge beider Strings
    ld   bc,hl
    inc  bc
    inc  bc
    ld   a,ZXHeapTypeTemp
    call ZXAlloc
    push hl
    pop  ix
    dec  bc
    dec  bc
    ld   (hl),bc
    inc  hl
    inc  hl
    ld   de,hl          ; Ziel
    pop  hl
    ld   c,(hl)
    inc  hl
    ld   b,(hl)
    inc  hl
    call ldirnotzero
    pop  hl
    ld   bc,(hl)
    inc  hl
    inc  hl
    call ldirnotzero
    push ix
    pop  hl
    ret

ldirnotzero:
    ld   a,b
    or   c
    ret  z
    ldir
    ret
runtimeChr:
    push hl
    ld bc,3
    ld  a,ZXHeapTypeTemp
    call ZXAlloc    
    ld   bc,1
    ld   (hl),bc
    inc  hl
    inc  hl
    pop  bc
    ld   (hl),c
    dec  hl
    dec hl
    ret
    



; BC = String (2 bytes length + string)
; HL = Char Position + 1
runtimeCharAt:
    push hl
    push bc
    ld   bc, 3      ; 1 Byte String + 2 Byte Len
    LD   a,ZXHeapTypeTemp
    call ZXAlloc
    dec  bc
    dec  bc
    ld   (hl),bc
    inc  hl
    inc  hl
    pop  de
    pop  bc
    push hl
    dec  bc         ; bc = char position, de = string, hl = new String
    inc  de
    inc  de
    ex   de,hl
    add  hl,bc
    ld   a,(hl)
    ld   (de),a
    pop  hl
    dec  hl
    dec  hl
    ret

runtimeHeapwalk:
    if DEBUG=1
    call ZXHeapWalk
    endif
    ret

runtimePrintFloat:
 
    ld hl,(ZX_STKEND) ; Fetch the 'old' STKEND.
    push hl
    call $2DE3;    2DE3: THE 'PRINT A FLOATING-POINT NUMBER' SUBROUTINE 
    pop hl
    ld bc,5
    sub hl,bc
    ld (ZX_STKEND),hl ; Store the new STKEND.
    ret

runtimeSwapFloat:
    ; Swap the top two floats on the calculator stack
    RST $28
    db $01 ; zxcalc_exchange
    db $38 ; zxcalc_end_calc
    ret

runtimeSin:
    ; Swap the top two floats on the calculator stack
    RST $28
    db zxcalc_sin
    db zxcalc_end_calc
    ret

runtimeCos:
    ; Swap the top two floats on the calculator stack
    RST $28
    db zxcalc_cos
    db zxcalc_end_calc
    ret

runtimeTan:
    ; Swap the top two floats on the calculator stack
    RST $28
    db zxcalc_tan
    db zxcalc_end_calc
    ret

runtimeSqr:
    ; Swap the top two floats on the calculator stack
    RST $28
    db zxcalc_sqr
    db zxcalc_end_calc
    ret

runtimeStr:
    LD BC,$0001	            ; One space is made in the work space and its address is copied to K-CUR, the address of the cursor.
	RST $30
	LD ($5C5B),HL
	PUSH HL	                ; This address is saved on the stack too.
	LD HL,($5C51)	        ; The current channel address (CURCHL) is saved on the machine stack.
	PUSH HL
	LD A,$FF	            ; Channel 'R' is opened, allowing the string to be 'printed' out into the work space.
	CALL $1601; CHAN_OPEN
	CALL $2DE3; PRINT_FP	; The 'last value', X, is now printed out in the work space and the work space is expanded with each character.
	POP HL	                ; Restore CURCHL to HL and restore the flags that are appropriate to it.
	CALL $1615; CHAN_FLAG
	POP DE	                ; Restore the start address of the string.
	LD HL,($5C5B)	        ; Now the cursor address is one past the end of the string and hence the difference is the length.
	AND A
	SBC HL,DE
	LD B,H	                ; Transfer the length to BC.
	LD C,L
    LD  A,ZXHeapTypeTemp    ; The string is stored in the temporary heap.
    inc  bc
    inc  bc
    CALL ZXAlloc            ; Allocate memory for the string. Return to BASIC if no memory available
    dec  bc
    dec bc
    PUSH HL                 ; Save the address
    LD  (HL),BC             ; Store length of String
    INC HL                  ; Increment HL to point to the first character of the string.
    INC HL
    ex hl,de
    ld a,b
    or c
    jr z, runtimeStrExit
    LDIR                    ; Copy the string 
runtimeStrExit:    
    POP HL
	RET

runtimeStr1:
    db 0



; input HL
; Output HL, A
;   if HL is a negative number, a positive number is returned and A is 255 (-1)
;   if HL is null, A = 0
;   if HL is positive A = 1

sgnabs:    
    ld  a,h
    or  l
    jr  z, sgnabszero
    ld  a,h
    and $80
    jr  nz,sgnabs1
    ld  a,1
    ret
sgnabs1:
    push de
    ex   hl,de
    xor  a
    ld   h,a
    ld   l,a
    sbc hl,de
    pop  de
    ld   a,255
    ret
		
sgnabszero:
    ld a,0
    ret

runtimeIntToFloat:
    LD      BC,HL
    call    $2D2B               ;  2D2B: THE 'STACK-BC' SUBROUTINE
    ret

runtimeFloatToInt:
    call    $2DA2;              ; FTP-TO-BC    
    LD      HL,BC
    ret
; Store a float in the variable (hl), remove from calculator stack
runtimeStoreFloat:
    ex hl,de                    ; Save Pointer to Var to DE
    LD HL,($5C65)	            ; Fetch the 'old' STKEND.
	LD BC,$05	
    sub HL,BC
    LD ($5C65),HL          ; Fetch the 'old' STKEND.

    ldir                        ; Copy varable to stack
    
    ret

; Store the variable (hl) on the calculator stack
runtimePushFloatVar:
; 2AB1: THE 'STK-STORE' SUBROUTINE
; A	First byte (when entering at STK_STO or STK_STORE)
; E	Second byte
; D	Third byte
; C	Fourth byte
; B	Fifth byte
; 
    ld A,(HL)
    inc hl
    ld E,(HL)
    inc hl
    ld D,(hl)
    inc hl
    ld c,(hl)
    inc hl
    ld b,(hl)
    call $2AB6 ; 2AB6: THE 'STK-STORE' SUBROUTINE
    RET

runtimePushPi:
		RST $28	                ; Now use the calculator.
        db $A3	                ; stk_pi_2: The value of π/2 is put on the calculator stack as the 'last value'.
    	db zxcalc_end_calc      ; end_calc
	    INC (HL)	            ; The exponent is incremented thereby doubling the 'last value' giving π.
        ret

runtimePlusFloat:
    RST $28
    db  $0F                     ; ADD
    db  $38                     ; end calc
    ret    

; 09 = <=
; 0a = gleich
; 0b = >= 
; 0c = =
; 0d = =
runtimeBiggerFloat:
    RST $28
    db  zxcalc_subtract
    db  zxcalc_greater_0
    db zxcalc_jump_true
    db runtimeBiggerFloatTrue-$
    db zxcalc_end_calc
    ld hl,0
    ret
runtimeBiggerFloatTrue:
    db zxcalc_end_calc
    ld hl,1
    ret



runtimeSmallerFloat:
    RST $28
    db  zxcalc_subtract
    db  zxcalc_less_0
    db zxcalc_jump_true
    db runtimeSmallerFloatTrue-$
    db zxcalc_end_calc
    ld hl,0
    ret
runtimeSmallerFloatTrue:    
    db zxcalc_end_calc
    ld hl,1
    ret



runtimeBiggerEqualFloat:
    call runtimeSmallerFloat
    jr   runtimeCalcFloatNegative2

runtimeEqualFloat:
    RST $28
    db  zxcalc_subtract
    db  zxcalc_end_calc
    call runtimeFloatToInt
    ld a,l
    or h
    jr z, runtimeReturn1
    ld hl,0
    ret

runtimeUnequalFloat:
    RST $28
    db  zxcalc_subtract
    db  zxcalc_end_calc
    call runtimeFloatToInt
    ld a,l
    or h
    jr nz, runtimeReturn1
runtimeReturn0:
    ld hl,0
    ret
runtimeReturn1:
    ld hl,1
    ret
runtimeCalcFloatNegative:    
    call runtimeFloatToInt
runtimeCalcFloatNegative2:    
    ld  a,l
    ld  b,1
    xor b
    ld  l,a
    ret

runtimeSmallerEqualFloat:
    RST $28
    db  zxcalc_no_l_eql
    db  zxcalc_end_calc
    jp  runtimeFloatToInt

runtimeNextFloat:	
; calculator stack:
; 1: to-(step+f)
; 2: step				
; returns: hl = 1 - for continues
;          hl = 0 - for ends			
	rst $28
	db  zxcalc_less_0				; check if step is negative
	db  zxcalc_jump_true			; jump to step -x 
	db  runtimeNextNeg-$
	db  zxcalc_less_0
	db  zxcalc_jump_true
	db  runtimeNext1-$
	db  zxcalc_stack_zero
	db  zxcalc_end_calc
	call runtimeFloatToInt
	ld  a,l
	ret
runtimeNextNeg:	
	db  zxcalc_greater_0
	db  zxcalc_jump_true
	db  runtimeNext1-$
	db  zxcalc_stack_zero
	db  zxcalc_end_calc
	call runtimeFloatToInt
	ld  a,l

	ret
runtimeNext1:
	db  zxcalc_stack_one
	db  zxcalc_end_calc
	call runtimeFloatToInt
	ld  a,l
	ret



runtimeOrFloat:
    RST $28
    db  zxcalc_or
    db  zxcalc_end_calc
    call runtimeFloatToInt
    ret    
runtimeMinusFloat:
    RST $28
    db  $03                     ; SUB
    db  $38                     ; end calc
    ret    

runtimeMultFloat:
    RST $28
    db  $04                     ; NULT
    db  $38                     ; end calc
    ret
runtimeDivFloat:
    RST $28
    db  $05                     ; DIV
    db  $38                     ; end calc
    ret

runtimeLen:
    ld bc,(hl)
    ld hl,bc
    ret     


    if DEBUG=1
printFloat:
    ld  b,5
printFloat1:
    ld   a,(hl)
    inc  hl
    call printHex2  
    ld   a,' '
    call printA  
    djnz printFloat1
    call newline
    ret
    endif    

runtimeStrInt:
    ld hl,0
    ld  a,(de)
    inc de
    cp  '-'
    jr  z, runtimeStrIntNeg
runtimeStrIntLoop
    cp  '0'-1
    ret  c
    cp  '9'+1
    ret  nc
    sub '0'
    ld   c,a
    ld   b,0
    push bc
    add  hl, hl ; * 2
    ld   bc, hl
    add  hl, hl ; * 4
    add  hl, hl ; * 8
    add  hl, bc ; * 10
    pop  bc
    add  hl,bc
    ld   a,(de)
    inc  de
    jr   runtimeStrIntLoop
runtimeStrIntNeg:
    ld  a,(de)
    inc de
    call runtimeStrIntLoop
    ld   de,0
    sub  hl,de
    ex   hl,de
    ret  
runtimeInputInt:
    ld   a,1
    ld   (rtInputFlags),a
    call rtInput
    ld   de,rtInputBuffer
    call runtimeStrInt
    ret 
runtimeInputString:
    ld   a,0
    ld   (rtInputFlags),a
    call rtInput
    ld  hl,rtInputBuffer
    ld  bc,2
runtimeInputString1:
    ld a,(hl)
    cp 13
    jr z, runtimeInputString2
    inc hl 
    inc bc
    jr runtimeInputString1
runtimeInputString2:
    push bc
    call ZXAlloc
    pop bc
    dec bc	
    dec bc
    ld (hl),bc
    push hl
    inc hl

    ld  de,rtInputBuffer
runtimeInputString3:
    ld a,(de)
    cp 13
    jr z, runtimeInputString4
    inc de
    inc hl
    ld (hl),a
    jr runtimeInputString3
runtimeInputString4:
    pop hl
    ret
runtimeInputFloat:
   ld   a,2
   ld   (rtInputFlags),a 
   call rtInput
   call rtCountInputBuf
   ld   hl,rtInputBufferSize
   call rtAscciToUFloat
    ret

runtimeRND:
	LD BC,($5C76)	; Fetch the current value of SEED.
	CALL $2D2B	; Put it on the calculator stack.
	RST $28		; Now use the calculator.
	DEFB $A1	; stk_one
	DEFB $0F	; addition: The 'last value' is now SEED+1.
	DEFB $34	; stk_data: Put the number 75 on the calculator stack.
	DEFB $37,$16
	DEFB $04	; multiply: 'last value' (SEED+1)*75.
	DEFB $34	; stk_data: Put the number 65537 on the calculator stack.
	DEFB $80,$41,$00,$00,$80
	DEFB $32	; n_mod_m: Divide (SEED+1)*75 by 65537 to give a 'remainder' and an 'answer'.
	DEFB $02	; delete: Discard the 'answer'.
	DEFB $A1	; stk_one
	DEFB $03	; subtract: The 'last value' is now 'remainder' - 1.
	DEFB $31	; duplicate: Make a copy of the 'last value'.
	DEFB $38	; end_calc: The calculation is finished.
	CALL $2DA2	; Use the 'last value' to give the new value for SEED.
	LD ($5C76),BC
	LD A,(HL)	; Fetch the exponent of 'last value'.
	AND A	; Jump forward if the exponent is zero.
	ret z
	SUB $10	; Reduce the exponent, i.e. divide 'last value' by 65536 to give the required 'last value'.
	LD (HL),A

	ret    
; Input something.
ZX_PRINT_FLASHING_CHAR: equ $18C1
ZX_KTEST: equ $031E
ZX_SCANKEY: equ $028E
ZX_K_DECODE: equ $0333

rtGetKey:
                LD HL,$5C3B	;This is FLAGS.
            	RES 6,(HL)	;Reset bit 6 for a string result.
                call ZX_SCANKEY
                ld  c,0
                push de
;jr  z,rtGetNoKey; too many keys pressed
                call ZX_KTEST
                pop de
                jr  nc,rtGetNoKey; no key pressed
                ;dec d
                ld e,a
            	CALL ZX_K_DECODE
                ret
rtGetNoKey:    ld  a,0
                ret

rtWaitKey:      call rtGetKey
                cp  0
                jr  z,rtWaitKey
                push af  
rtWaitKey1:     call ZX_SCANKEY
                ld  a,e
                cp $ff
                jr nz,rtWaitKey1
                pop af
                ret
rtInputEnd:     
                ret
rtInputCheckFloat:
                ld a,b
                cp '.'
                jr  z,rtInputAcceptKey
rtInputCheckNumber:
                ld a,b
                cp '-'
                jr  z,rtInputAcceptKey
                cp '0'-1
                jr  c,rtInputEdit
                cp '9'+1
                jr  c,rtInputAcceptKey
                jr  rtInputEdit
                
rtInput:        ld a,0
                ld (rtInputCursor),a
                ld a,13
                ld (rtInputBuffer),a

rtInputEdit:    call rtInputPrint
rtInputWaitKey: call rtWaitKey
                ld  (rtInputKey),a
                cp  8
                jr  z,rtInputLeft
                cp  9
                jr  z,rtInputRight
                cp  12
                jr  z,rtInputBackspace
                cp  13
                jp  z,rtInputEnd
                ld  b,a
                ld  a,(rtInputFlags)
                cp  0
                jr  z,rtInputAcceptKey
                cp  1
                jr  z,rtInputCheckNumber
                cp  2
                jr  z,rtInputCheckFloat

rtInputAcceptKey:
                ld  hl,rtInputBuffer
                ld  a,(rtInputCursor)
                ld  b,a
                ld  a,rtInputBufferLen
                sub b
                cp 0
                jr z,rtInputInsert1
                ld b,a
                ld  de,rtInputBufferEnd-1
                ld  hl,rtInputBufferEnd
rtInputInsert:  ld  a,(de)
                ld  (hl),a
                dec  hl
                dec  de
                djnz rtInputInsert                
rtInputInsert1:                
                ld  hl,rtInputBuffer
                ld  a,(rtInputCursor)
                ld  c,a
                ld  b,0
                add hl,bc
                inc a
                ld (rtInputCursor),a
                ld a,(rtInputKey)
                ld  (hl),a      ; insert character
rtInputFull:    jr  rtInputEdit       
rtInputLeft:    ld a,(rtInputCursor)
                cp  0
                jr  z,rtInputEdit 
                dec a
                ld (rtInputCursor),a
                jr rtInputEdit
rtInputRight:   ld a,(rtInputCursor)    
                ld hl,rtInputBuffer
                ld c,a
                ld b,0
                add hl,bc
                ld  a,(hl)
                ld  b,a
                cp 13
                jr  z,rtInputEdit 
                inc hl
                ld  a,(hl)
                cp 13
                jr  z,rtInputEdit
                ld  a,b
                ld  a,(rtInputCursor)
                inc a
                ld (rtInputCursor),a
                jp rtInputEdit 
rtInputBackspace:
                ld a,(rtInputCursor)
                cp  0
                jp  z,rtInputEdit    
                dec a
                ld (rtInputCursor),a
                ld hl,rtInputBuffer
                ld c,a
                ld b,0
                add hl,bc
                ld  de,hl
                inc hl
rtInputBackspaceLoop:
                ld  a,(de)
                cp  13
                jp  z,rtInputEdit
                ld  a,(hl)
                ld (de),a
                inc hl
                inc de
                jr rtInputBackspaceLoop

                

rtInputReturn:  
                ret           

rtInputPrint:   ld hl,(ZX_DFCCL)
                push hl
                ld HL,(ZX_SPOSNL)
                push hl
                ld   hl,rtInputBuffer
                ld   a,(rtInputCursor)
                ld   b,a
                ld   c,0
rtInputPrintLoop:      
                ld a,b      ; is this the cursor position?
                cp c            
                jr nz, rtInputPrintLoop2
                ld A,'C'
                call ZX_PRINT_FLASHING_CHAR
rtInputPrintLoop2:
                ld a,(hl)   ; get the character
                inc hl
                cp 13       ; end of string?
                jr z, rtInputPrintEnd
                RST $10
                inc c      ; increment cursor position
                jr rtInputPrintLoop
rtInputPrintEnd:   
                ld  a,' '
                RST $10

                pop hl
                ld (ZX_SPOSNL),hl ; restore cursor position
                pop hl
                ld (ZX_DFCCL),hl
                ret

rtCountInputBuf: ld bc,0
                 ld hl,rtInputBuffer
rtCountInputBuf1:   ld a,(hl)
                    cp 13
                    jr z,rtCountInputBuf2
                    inc hl
                    inc bc
                    jr rtCountInputBuf1
rtCountInputBuf2:   ld (rtInputBufferSize),bc
                    ret



; HL points to a string, first two bytes is len
; let result=0
; before the "." we calc 
; let result = result*10 + digit
; after the . we calc
; let frac = 0.1
; let result = result + frac*digit
; let frac = frac / 10
runtimeVal:

rtAscciToUFloat:    ld  bc,(hl)
                    inc hl
                    inc hl
                    push hl
                    push bc
                    rst $28
                    db zxcalc_stack_zero
                    db zxcalc_end_calc
                    ld   hl,rtConstant1div10
                    ld   de,rtVarFrac
                    ld   bc,5
                    ldir
                    pop bc
                    pop hl
rtAscciiToFloatLoop:
                    ld  a,b
                    or  c
                    jr  z,rtAscciiToFloatEnd
                    ld  a,(hl)          ; get the next character
                    inc hl
                    dec bc
                    cp  '.'
                    jr  z,rtAscciToFloatFrac
                    cp  '0'-1
                    jr  c,rtAscciiToFloatEnd
                    cp  '9'+1
                    jr  nc,rtAscciiToFloatEnd
                    sub '0'
                    push bc
                    push hl
                    push af
                    ld   hl,10
                    call runtimeIntToFloat ; (result) (10)
                    rst $28
                    db zxcalc_multiply                  ; (result*10)
                    db zxcalc_end_calc
                    pop af
                    call zxromStackA                    ; (result*10) (digit)
                    rst $28
                    db zxcalc_addition                  ; (result*10+digit)
                    db zxcalc_end_calc

                    pop hl
                    pop bc
                    jr rtAscciiToFloatLoop
rtAscciToFloatFrac:
rtAsciiToFloatFracLoop:
                    ld  a,b
                    or  c
                    jr  z,rtAscciiToFloatEnd
                    ld  a,(hl)          ; get the next character
                    inc hl
                    dec bc
                    cp  '0'-1
                    jr  c,rtAscciiToFloatEnd
                    cp  '9'+1
                    jr  nc,rtAscciiToFloatEnd
                    sub '0'
                    push hl
                    push bc

                    call zxromStackA                    ; (result) (digit)
                    ld   hl,rtVarFrac
                    call runtimePushFloatVar ; store the fraction in mem1
                    rst $28
                    db zxcalc_multiply                  ; (result) (digit*faction)
                    db zxcalc_addition                  ; (result + digit*faction)
                    db zxcalc_end_calc
                    ld   hl, rtVarFrac
                    call runtimePushFloatVar ; store the fraction in mem1
                    ld  hl,  10
                    call runtimeIntToFloat ; (result) (fraction) (10)
                    rst $28
                    db zxcalc_division                  ; (result) (fraction/10)
                    db zxcalc_end_calc
                    ld  hl,rtVarFrac
                    call runtimeStoreFloat

                    pop bc
                    pop hl
                    jr  rtAsciiToFloatFracLoop
rtAscciiToFloatEnd: ret 







rtConstant1div10:	    db $7d, $4c, $cc, $cc, $cc  ; 0.1
rtVarFrac:	            db $7d, $4c, $cc, $cc, $cc  ; 0.1





rtReadKeyboardPressedKeys:defs 5*8+1,0	
rtInputFlags:           db 0
                        ; 1 = numeric
                        ; 0 = string
rtInputCursor:          db 0
rtInputKey:             db 0
rtInputBufferSize:       dw 0            ; in order to make it look like a compiled string
rtInputBuffer:          defs 64,0
rtInputBufferEnd:       equ $
rtInputBufferLen:       equ rtInputBufferEnd-rtInputBuffer

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

runtimeSaveSP:          dw 0

 DISPLAY "Runtime Size =",/D, $-RUNTIME_START, " bytes"
