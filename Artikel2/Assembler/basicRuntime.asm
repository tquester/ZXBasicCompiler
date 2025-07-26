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


; ---------------------- 16bit maath -------------
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

runtimeAbsInt:  ld a,h  
                and $80
                ret z
                ld de,0
                ex hl,de
                sub hl,de
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


; ---------------------- Display --------------------
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
;    ld a,$16
;    rst $10
;    ld a,l
;    rst $10
;    ret
    
    ld a, (ZX_ATTR_T)
    and 0b11111000
    or l
    ld (ZX_ATTR_T), a
    ret

runtimeLocalPaper:
;    ld a,$17
;    rst $10
;    ld a,l
;    rst $10
;    ret
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

; ======================================================================
; ATTR
; hl = x
; de = y
; returns hl=Attr
; ======================================================================
runtimeAttr:
    push hl
    ld   hl,de
    add  hl,hl          ; * 2
    add  hl,hl          ; * 4 
    add  hl,hl          ; * 8
    add  hl,hl          ; * 16
    add  hl,hl          ; * 32   
    pop  bc
    add  hl,bc
    ld   bc,$4000+6144
    add  hl,bc          ; hl = $4000 + 6144 + x + y*32
    ld   a,(hl)         ; get the attribute
    ld   l,a
    ld   h,0
    ret 


; -----------------------------------------------------------------------
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
    ld  a,b
    or  c
    ret z               ; empty string
    inc hl
    inc hl
runtimePrintFixString:
runtimePrntString1:
    ld a,b
    or c
    ret z
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
    ld b,e
    ld c,l
    ld a,24
    sub b
    jr  c,runtinePrintAtErr
    ld b,a
    ld a,33
    sub c
    jr  c,runtinePrintAtErr
    ld c,a
    call zxromClSet
    ret

runtinePrintAtErr:
    ld e,0
    ld l,0
    jp runtimePrintAt
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
    inc hl
    inc hl
    ld a,(hl)
    call zxromAlpha
    ret nc
    and %01011111
      ; Convert to upper case
    sub 65              ; subtract A
    ret c               ; out of range
    cp  20
    ret nc               ; out of range
    add a,a
    add a,a
    add a,a             ; *8 
    LD BC,(ZX_UDG)      ; UDG address
    ld  l,a
    ld  h,0
    add hl,bc
    ret 

runtimeAndFloat:
    RST $28
    db zxcalc_no_and_no
    db zxcalc_end_calc
    ret
runtimeInkey:
    call rtGetKey
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

runtimeSetStream:
    ret    

runtimePauseAbs
    halt    
    dec hl
    ld  a,h
    or  l
    jr  nz,runtimePauseAbs
    ret
    

runtimePause:
    ld   BC,HL
    jp   $1F3D;     PAUsE

    call rtGetKey
    cp 0
    jr z, runtimePause1
    dec hl
    ld a,h
    or l
    ret z
    jr runtimePause
runtimePause1:
    call rtGetKey
    cp 0
    ret nz 
    jr runtimePause1    

runtimeSgnInt:
    ld a,l
    or h
    jr z, runtimeSgnInt0
    ld a,h
    and $80
    jr z, runtimeSgnIntNeg
    ld hl,-1
    ret
runtimeSgnInt0:
    ld hl,0
    ret
runtimeSgnIntNeg:
    ld hl,1    
    ret

         


HL1: LD HL,1
     ret
CTOB:
    ld b,c
    ret

runtimeCheckBreak:      call    $1F54
                        ret     c
                        ld     sp,(runtimeSaveSP)
                        ret

runtimeCheckBreakDebug: call    $1F54
                        ret c
                        if DEBUGGER=1
                        ld a,1
                        ld (rtStopped),a
                        endif
                        ret

runtimeClearArray:
    ld (hl),0
    inc hl
    dec bc
    ld a,b
    or c
    jr nz, runtimeClearArray
    ret



; -----------------------------
; Stringverarbeitung
; -----------------------------


; HL = String Array
; BC = Anzahl der Strings
runtimeClearStringArray:
    ld a,32:
    ld (hl),a
    inc hl
    dec bc
    ld a,b
    or c
    jr nz, runtimeClearStringArray
    ret

; ============================================================================================
; Store a partial string
; HL = Source String (BASIC-String with length)
; IX = Variable contianing the Target String (BASIC-String with length)
; BC = Start position in target string (1 = first position)
; DE = End Position in target string (-1 = end of string)
; ============================================================================================
    
runtimeStoreSubstringVarVar:  
    call runtimeCopyStringStringVarIXToHeap ; copy the target string to the heap, if not already in heap
    ld a,e
    cp $FF 
    call z, runtimeStoreSubstringSetEnd
 ; no BC holds the start, DE holds the end inside the target string (1=fist positon)
    push hl
    ld   hl,de
    sub  hl,bc
    push hl
    ld   hl,(ix)
    ld   ix,hl
    pop  hl
    dec  bc
    add  ix,bc
    inc  ix     ; skip length
    inc  ix
    ld   bc,hl
    inc  bc
    pop  hl
    inc  hl     ; skip length
    inc  hl
; now bc contains the length, ix points to the start of the target string, hl points to the source string
; we do not need to allocate a string, it is already existing (or has been allocated at the start of this function)
runtimeStoreSubStringVarVarLoop:
    ld   a,(hl)              ; get the next character from the source string
    ld   (ix),a              ; store it in the target string
    inc  hl                  ; next character in source string
    inc  ix                  ; next character in target string
    dec  bc                  ; one less character to copy
    ld   a,b
    or   c                   ; check if we are done
    jr   nz, runtimeStoreSubStringVarVarLoop ; loop until done
    ret
runtimeStoreSubstringSetEnd:        ; set de to the lengh of the string in case DE is $FFFF
    ld a,D                          ; check if D is $$ also (we checked e prior)
    cp $FF  
    ret nz              
    push hl
    ld  hl,(ix)
    ld  de,(hl)
    pop hl
    inc de                          ; the first position in BASIC is one, so increment
    ret
; -------------------------------------------------------------------------------------------- 

; ============================================================================================
; runtimeCopyStringToHeap. 
; check if the String HL is already in the heap, if not copy it to the heap 
; ============================================================================================

runtimeCopyStringStringVarIXToHeap:
; ix holds the variable
        push hl
        ld   hl,(ix)                     ; get the string from the variable
        call runtimeCopyStringToHeap
        ld   (ix),hl
        pop  hl 
        ret


runtimeCopyStringToHeap:
        push bc
        push de
        push hl
        call ZXCheckIfHlisHeapBlock         ; if HL is alread in heap, return
        pop  hl
        cp   a,1
        jr   z,runtimeCopyStringToHeapEnd
        push hl
        ld   bc,(hl)                        ; get length of string
        inc  bc
        inc  bc                             ; plus 2 bytes for length
        call ZXAlloc                        ; alloc
        ld   de,hl                          ; de = target 
        pop  hl                             ; hl = source
        push de
        ldir                                ; copy the string to the heap
        pop  hl                             ; the new
runtimeCopyStringToHeapEnd:        
        pop  de
        pop  bc
        ret


; -------------------------------------------------------------------------------------------- 

 
; HL = Adress of variable
; DE = Adress of string to store
runtimeStoreString:
    push hl
    push de
    call ZXFreeStringVar ; Free old string if it is a heap string
    pop de
    pop hl
    push hl
  ;  ld   l,e
  ;  ld   h,d
    ex hl,de
    ld   bc,(hl)
    ld   a,b
    or   c
    jr   z,runtimeStoreEmptyString
    call ZXClaim ; Claim memory for the string
    ex hl,de
    pop  hl
    ld   (hl),de
    call ZXFreeTemp
    call ZXHeapCompactFree
    ret
runtimeStoreEmptyString:
    ex hl,de
    ld bc,0
    ld (hl),0
    pop hl
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


; ============================================================================================
; runtimeStoreStringVarFix. 
; Store a BASIC String to a Fixed Length string
; BC = length of target string
; DE = Target String
; HL = Source String
; ============================================================================================

runtimeStoreStringVarFix:
    push ix
    push hl
    pop ix
    LD HL,(ix)
    inc ix
    inc ix
runtimeStoreStringVarFixLoop:
    ld  a,h
    or  l
    jr  z,runtimeStoreStringVarFixEnd
    ld  a,b
    or  c
    jr  z,runtimeStoreStringVarFixEnd
    ld  a,(ix)
    ld  (de),a
    inc ix
    inc de
    dec hl
    dec bc
    jr runtimeStoreStringVarFixLoop
runtimeStoreStringVarFixEnd:
    pop ix
    ret

runtimeSetFixedString:
; ============================================================================================
; runtimeSetFixedString.
; copy a fixed string to another fixed string
; (ix+4) = Len Source
; (ix+6) = Len Target
; (ix+8) = Source String
; (ix+10) = Target String
; 

; todo: implement
    push hl
    ld hl,0
    add hl,sp
    ld ix,hl
    ld  hl,(ix+4)   ; get length of source string
    ld  de,(ix+6)   ; get length of target string
    call runtimeMinHlDl
    ld  bc,hl       ; bc length to copy (minimum of both)
    pop  hl
    ld  a,b
    or  c
    jr  z,runtimeSetFixedStringEnd           ; nothing to copy, return
    ld  hl,(ix+10)
    ld  de,(ix+8)   ; de = target string
runtimeSetFixedStringLoop:
    ld a,(de)
    ld (hl),a
    inc hl
    inc de
    dec bc
    ld a,b
    or c
    jr nz,runtimeSetFixedStringLoop
runtimeSetFixedStringEnd:
    pop hl      ; return address
    pop bc
    pop bc
    pop bc
    pop bc
    jp (hl);

; ============================================================================================
; runtimeMinHlDl.
; Compare HL and DE and return the minimum in HL
; ============================================================================================

runtimeMinHlDl:
    push hl
    sub hl,de
    jr  c, runtimeMinHlDlHl
    pop hl
    ld hl,de
    ret

runtimeMinHlDlHl:
    pop hl
    ret


; ============================================================================================
; runtimeStoreFixedStringWithRangeFromBstr. 
; Store a BASIC String to a Fixed Length string
; HL = Source String 
; Source Str, start, end pushed on stack
; (ix+8) = Target String
; (ix+4) = end position
; (ix+6) = start pos
; ============================================================================================

runtimeStoreFixedStringWithRangeFromBstr: 
    push hl
    ld hl,0
    add hl,sp
    ld ix,hl
    ld hl,(ix+6)
    dec hl
    ld (ix+6),hl



    ld  hl,(ix+4)
    ld  de,(ix+6)           ; de = end position
    sub hl,de               ; length
    ld  a,l
    or  h
    call z,HL1
    ld  bc,hl
    ld  hl,(ix+6)
    ld  de,(ix+8)           ; de = start position
    add hl,de               ; hl = start position in target string
    ex  hl,de
    pop hl
    inc hl
    inc hl
runtimeStoreFixedStringWithRangeFromBstrLoop:    
    ld  a,(hl)
    ld  (de),a
    inc de
    inc hl
    dec bc
    ld  a,b
    or  c
    jr  nz,runtimeStoreFixedStringWithRangeFromBstrLoop
    ld  hl,0
    pop  hl
    pop  bc
    pop  bc
    pop  bc
    jp  (hl)

    ret
    add hl,sp
    ld  de,8
    add hl,de
    ld  sp,hl
    ret

; ============================================================================================
; runtimeStoreSubstringVarFix. 
; Store a fixed length string into a BASIC String with range
; HL = Source String 
; BC = Length of source String
; Source Str, start, end pushed on stack
; (ix+4) = Target String
; (ix+6) = Ende     - Länge
; (ix+8) = Anfang
; ============================================================================================


runtimeStoreSubstringVarFix:
    push hl                  ; save source string
    ld hl,0                  ; setup ix to point to stack
    add hl,sp
    ld ix,hl
    push bc

    ld  hl,(ix+6)
    ld  a,h
    cp  $ff
    call z,runtimeStoreSubstringVarFixFindEnd
    ld   hl,(ix+6)
    ld   de,(ix+8)           ; de = start position
    sub  hl,de               ; length
    ld   (ix+6),hl      
    push de
    ld   hl,(ix+4)           ; hl = target string
    ld   de,(hl)
    ex   hl,de
    pop  de
    add  hl,de               ; hl = start position in target string
    inc  hl                  ; dec 1 and skip two bytes

    pop  bc
    pop  de
runtimeStoreSubstringVarFixLoop:
    ld  a,(hl)
    ld  (de),a
    dec bc
    ld  a,b
    or  c
    jr  z,runtimeStoreSubstringVarFixEnd2
    push hl
    ld hl,(ix+6)
    dec hl
    ld (ix+6),hl
    ld  a,h
    or  l
    jr  z,runtimeStoreSubstringVarFixEnd
    pop hl
    jr  runtimeStoreSubstringVarFixLoop
runtimeStoreSubstringVarFixEnd:
    pop hl
runtimeStoreSubstringVarFixEnd2:    
    pop hl              ; return address
    pop bc              ; pop length
    pop bc              ; pop source string
    pop bc              ; pop target string
    jp (hl)


runtimeStoreSubstringVarFixFindEnd:
    ld a,l  	        ; check if to pos is -1 
    cp $ff
    ret nz              ; return if not
    ld  hl,(ix+4)       ; hl = target string
    ld  de,(hl)         ; length of target string
    ex hl,de
    ld  de,(hl)
    inc de              ; +p (First pos in BASIC is 1)
    ld  (ix+6),de       ; store the length in ix+6
    ret

; ============================================================================================
; runtimePushFixedSubString. 
; Store a fixed length string into a BASIC String with range
; HL = String
; BC = Ende
; DE = Start
; ============================================================================================
runtimePushFixedSubString:
    push hl
    ld   hl,bc
    sub  hl,de
    inc hl
    ld   a,h
    or   l
    call z,HL1
    ld   bc,hl          ; bc = length
    pop  hl
    add  hl,de          ; hl = start
    dec  hl
    ld   de,hl          ; de = start, bc = length
    push bc
    push de
    inc  bc
    inc  bc
    ld   a,ZXHeapTypeTemp
    call ZXAlloc        ; allocate memory for the string
    ;call ZXHeapWalk
    pop  de
    pop  bc
    push hl
    ld   (hl),bc
    inc  hl
    inc  hl
runtimePushFixedSubStringLoop:
    ld   a,(de)         ; get the next character from the source string
    ld   (hl),a         ; store it in the target string
    inc  hl             ; next character in source string
    inc  de             ; next character in target string
    dec  bc             ; one less character to copy
    ld   a,b
    or   c              ; check if we are done
    jr   nz, runtimePushFixedSubStringLoop ; loop until done
    pop hl
    ret


; ============================================================================================
; runtimeVarStrAndInt. 
; if number is zero, replace return empty string, otherwise return string
; HL = String
; DE = integer
; ============================================================================================

runtimeVarStrAndInt:
    ld a,d
    or e
    ret nz
    ld hl,constEmptyString
    ret

constEmptyString: dw 0






; HL = second string
; DE = first String
runtimeStringAdd:
    push ix
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
    push bc
    inc  bc
    inc  bc
    ld   a,ZXHeapTypeTemp

    call ZXAlloc
    push hl
    pop  ix             ; ix = holds result string
    pop  bc
    ld   (hl),bc
    inc  hl
    inc  hl             ; hl = new BASIC string with combinded length

    pop  de
    ex   hl,de
    ld   bc,(hl)
    ex   hl,de          ; bc = length of first string
    inc  de
    inc  de             ; de = points to first character of first string
    ex   hl,de
    call ldirnotzero
    ex  hl,de

    pop  de
    ex   hl,de
    ld   bc,(hl)
    ex   hl,de          ; bc = length of first string
    inc  de
    inc  de             ; de = points to first character of first string
    ex   hl,de
    call ldirnotzero
    ex   hl,de


    push  ix
    pop   hl
    pop   ix
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
    ld   A,1
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
    ld      A,H
    AND     $80
    JR      NZ,runtimeIntToFloatNeg
    LD      BC,HL
    call    $2D2B               ;  2D2B: THE 'STACK-BC' SUBROUTINE
    ret
runtimeIntToFloatNeg:
    ld     DE,0
    EX     HL,DE
    SUB    HL,DE
    LD    BC,HL
    call    $2D2B               ;  2D2B: THE 'STACK-BC' SUBROUTINE
    RST    $28
    db     zxcalc_negate        ; Negate the value on the calculator stack
    db  zxcalc_end_calc ; End the calculation
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


runtimeStrTemp:
     defs 7    

runtimeStrInt:
    ld a,h
    and $80
    jr  z,runtimeStrIntU
    call neghl
    ld ix,runtimeStrTemp
    ld de,0 ; len
    ld a,1
    push af
    jr runtimeStrIntUIntLoop

runtimeStrIntU:
; convert an integer to a string
        ld ix,runtimeStrTemp
        ld de,0 ; len
        ld a,0
        push af
        ld  a,h
        or  l
        jr  nz,runtimeStrIntUIntLoop
        ld  a,'0'
        ld (ix),a
        inc ix
        inc de
        jr runtimeStrIntUIntEnd
runtimeStrIntUIntLoop:        
        ld a,h
        or l
        jr z,runtimeStrIntUIntEnd
        ld c,10
        call DivHlCRest
        add a,48
        ld (ix),a
        inc ix
        inc de
        jr  runtimeStrIntUIntLoop
runtimeStrIntUIntEnd:
        pop af
        cp  0
        jr  z,runtimeStrIntUIntEnd2
        ld  a,'-'
        ld  (ix),a
        inc ix
        inc de
runtimeStrIntUIntEnd2:        
        ld  bc,de
        inc bc
        inc bc
        ld  a,ZXHeapTypeTemp
        call ZXAlloc            ; allocate memory for the string
        push hl
        ld   (hl),de
        inc  hl
        inc  hl
runtimeStrIntUIntLoop2:
        dec ix
        ld a,(ix)
        ld (hl),a
        inc hl
        dec de
        ld a,b
        or e
        jr nz,runtimeStrIntUIntLoop2
        pop hl
        ret        





; input HL an integer
; output HL as string (allocated on heap)


runtimeValInt:
    ld hl,0
    ld  a,(de)
    inc de
    cp  '-'
    jr  z, runtimeValIntNeg
runtimeValIntLoop
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
    jr   runtimeValIntLoop
runtimeValIntNeg:
    ld  a,(de)
    inc de
    call runtimeValIntLoop
    ld   de,0
    sub  hl,de
    ex   hl,de
    ret  
runtimeInputInt:
    ld   a,1
    ld   (rtInputFlags),a
    call rtInput
    ld   de,rtInputBuffer
    call runtimeValInt
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

runtimeOrHLDE:
    call runtime01HL
    call runtime01DE 
    ld   A,E
    or   L
    ld   L,A
    LD   h,0
    ret
runtimeAndHLDE:
    call runtime01HL
    call runtime01DE 
    ld   A,E
    and  L
    ld   L,A
    LD   h,0
    ret


runtime01HL:
    ld  a,H
    or  l
    jr  z,runtime0HL
runtime1HL;.    
    ld  hl,1
    ret

runtimeNotHL:
    ld  a,H
    or  l
    jr  z,runtime1HL
runtime0HL:
    ld hl,0
    ret

runtime01DE:
    ld  a,E
    or  D
    jr  z,runtime0DE
    ld  DE,1
    ret
runtime0DE:
    ld DE,0
    ret

runtimeVarCall:

    jp (hl)
; HL points to the line table (first word = line number, second word = label)
; DE contains the number we want
; if the entry is 0 it is the end of the table
runtimeFindLine:
    LD BC,DE
runtimeFindLineLoop:
    ld DE,(hl)
    inc hl
    inc hl
    ld  a,d
    or  e
    jr  z,runtimeFindLineEnd
    ex  de,hl
    or a,a
    sbc hl,bc
    ex  hl,de
    jr  z,runtimeFindLineFound
    jr  nc,runtimeFindLineFound
    inc hl
    inc hl
    jr  runtimeFindLineLoop
    ; found
runtimeFindLineFound: 
    ld de,(hl)
    ex hl,de
    ret

runtimeFindLineEnd:
; return to BASIC if not found
    push de
    ld     hl,errLineNoFoundEnd
    call   runtimePrintString
    pop hl
    call   runtimePrintInt

    ld     sp,(runtimeSaveSP)
    ret
errLineNotFound:
    dw errLineNoFoundEnd-$
    db "Line not found "
errLineNoFoundEnd:




    

runtimeRND:
	LD BC,($5C76)	; Fetch the current value of SEED.
	CALL $2D2B	; Put it on the calculator stack.
	RST $28		; Now use the calculator.
	DEFB $A1	; stk_one
	DEFB $0F	; addition: The 'last value' is now SEED+1.
	DEFB $34	; stk_data: Put the number 75 on the calculator stack.
	DEFB $37,$16
	DEFB $04	; multiply: 'las1t value' (SEED+1)*75.
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

runtimeJoystickmap:    db 8, 9, 10, 11, 32,0
runtimeJoystickBits:   db 1,2,4,8,16,0
runtimeUseJoystick:     db 0

rtGetKey:       ld a,(runtimeUseJoystick)
                cp 0
                jr z,rtGetKeyNoStick
                ld bc,31
                in (c)
                cp 0
                jr z,rtGetKeyNoStick
                ld hl,runtimeJoystickBits
                ld de,runtimeJoystickmap
                ld b,a
rtGetKeyStick:  ld  a,(hl)
                cp  0
                jr  z,rtGetKeyRetJoystick
                cp  b
                jr  z,rtGetKeyRetJoystickMap
                inc hl
                inc de
                jr rtGetKeyStick


rtGetKeyRetJoystickMap:
                ld   a,b
                ret
rtGetKeyRetJoystick:
                ld   a,(de)
                ret

rtGetKeyNoStick:                
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


runtimeNegFloat:
                ret

; =============================================================================
; Int16-Vergleiche
; vergleiche hl-de, ergebnis hl=1 oder hl=0
; ============================================================================

runtimeReturnFalse:
    ld hl,0
    ret

runtimeReturnTrue:
    ld hl,1
    ret

; --- HL < DE ---
runtimeCmpHLltDE:
    ex hl,de
    or a
    sbc hl,de
    jr c, runtimeReturnTrue
    jr runtimeReturnFalse

; --- HL <= DE ---
runtimeCmpHLLeDE:
    ex hl,de
    or a
    sbc hl,de
    jr z, runtimeReturnTrue
    jr c, runtimeReturnTrue
    jr runtimeReturnFalse

; --- HL > DE ---
runtimeCmpHlGtDE:
    ex hl,de
    or a
    sbc hl,de
    jr nc, .check
    jr runtimeReturnFalse
.check:
    jr z, runtimeReturnFalse
    jr runtimeReturnTrue

; --- HL >= DE ---
runtimeCmpHLGeDE:
    ex hl,de
    or a
    sbc hl,de
    jr nc, runtimeReturnTrue
    jr runtimeReturnFalse

; --- HL = DE ---
runtimeCmpHLEqDE:
    or a
    sbc hl,de
    jr z, runtimeReturnTrue
    ld hl,0
    ret

; --- HL ≠ DE ---
runtimeCmpHlNeDE:
    or a
    sbc hl,de
    jr nz, runtimeReturnTrue
    jr runtimeReturnFalse

; =======================================================================
; String compare fixed string convention
; HL = String 1
; IX = String 2
; BC = Length String 1
; DE = Length String 2
; Basic String convention
; HL = String1 (BC / HL will get created from String info)
; IX = String2 
; =======================================================================

runtimeCompareStringBCBigger:
    ld  bc,de
    ret
runtimeCompareString:
    ld  a,b
    or  c
    jr  nz, runtimeCompareStringNZBC
    ld  a,d
    or  e
    jr  nz, runtimeCompareStringCont
    ld  a,0                             ; Strings sind gleich (beide leer)
    ret
runtimeCompareStringNeg:
    ld a,-1
    ret

runtimeCompareStringPos:
    ld a,1
    ret


runtimeCompareStringNZBC:               ; BC > 0, wenn DE > 0 dann a=-1
    ld   a,d
    or   e
    jr   z, runtimeCompareStringNeg    

runtimeCompareStringCont:
    push hl                             ; Ermitteln der Länge DE-BC oder BC-DE
    ld   hl,de
    sub  hl,bc
    call c,runtimeCompareStringBCBigger
    pop  hl             
    dec  ix
    dec  hl
runtimeCompareStringLoop:
    inc  ix
    inc  hl
    ld   a,(hl)                         ; Ermitteln der Zeichen
    cp   a,(ix)
    jr   z, runtimeCompareStringLoop2
    jr   c, runtimeCompareStringPos     ; String1 > String2
    jr   runtimeCompareStringNeg         ; String1 < String2        
runtimeCompareStringLoop2:
    dec bc
    ld  a,b
    or  c
    jr  nz, runtimeCompareStringLoop
    ld  a,0
    ret
    ; Strings sind gleich
runtimeEqualStringFixFix:
    call runtimeCompareString
    cp 0
    jp z, runtimeReturn1
    jp runtimeReturn0

runtimeUnequalStringFixFix
    call runtimeCompareString
    cp 0
    jp nz, runtimeReturn1
    jp runtimeReturn0

runtimeBiggerStringFixFix
    call runtimeCompareString
    cp 1
    jp z, runtimeReturn1
    jp runtimeReturn0
runtimeSmallerStringFixFix:
    call runtimeCompareString
    cp -1
    jp z, runtimeReturn1
    jp runtimeReturn0

runtimeSmallerEqualStringFixFix
    call runtimeCompareString
    cp -1
    jp z, runtimeReturn1
    cp 0
    jp z, runtimeReturn1
    
    jp runtimeReturn0
runtimeBiggerEqualStringFixFix
    call runtimeCompareString
    cp 1
    jp z, runtimeReturn1
    cp 0
    jp z, runtimeReturn1    
    jp runtimeReturn0


runtimeVar1ToFix:
    ld   bc,(hl)
    inc hl
    inc hl
    ret
runtimeVar2ToFix:
    ld ix,de
    ld   de,(ix)
    inc ix
    inc ix
    ret
runtimeEqualStringVarFix:
    call runtimeVar1ToFix
    jr  runtimeEqualStringX
runtimeUnequalStringVarFix:
    call runtimeVar2ToFix
    jr   runtimeUnequalStringX

runtimeBiggerStringVarFix:
    call runtimeVar1ToFix
    jr   runtimeBiggerStringX
runtimeSmallerStringVarFix:
    call runtimeVar1ToFix
    jr   runtimeSmallerStringX
runtimeSmallerEqualStringVarFix:
    call runtimeVar1ToFix
    jr   runtimeSmallerEqualStringX

runtimeBiggerEqualStringVarFix:    
    call runtimeVar1ToFix
    jr  runtimeBiggerEqualStringX

runtimeEqualStringFixVar:
    call runtimeVar2ToFix
runtimeEqualStringX:    
    call runtimeCompareString
    cp 0
    jp z, runtimeReturn1
    jp runtimeReturn0
runtimeUnequalStringFixVar:
    call runtimeVar2ToFix
runtimeUnequalStringX:    
    call runtimeCompareString
    cp 0
    jp nz, runtimeReturn1
    jp runtimeReturn0
runtimeBiggerStringFixVar:
    call runtimeVar2ToFix
runtimeBiggerStringX:
    call runtimeCompareString
    cp 1
    jp z, runtimeReturn1
    jp runtimeReturn0
runtimeBiggerEqualStringFixVar:
    call runtimeVar2ToFix
runtimeBiggerEqualStringX:    
    call runtimeCompareString
    cp 1
    jp z, runtimeReturn1
    cp 0
    jp z, runtimeReturn1    
    jp runtimeReturn0

runtimeSmallerStringFixVar:
    call runtimeVar2ToFix
runtimeSmallerStringX:
    call runtimeCompareString
    cp -1
    jp z, runtimeReturn1
    jp runtimeReturn0
runtimeSmallerEqualStringFixVar:
    call runtimeVar2ToFix
runtimeSmallerEqualStringX:
    call runtimeCompareString
    cp -1
    jp z, runtimeReturn1
    cp 0
    jp z, runtimeReturn1
    jp runtimeReturn0

runtimeEqualString:
    call runtimeVar1ToFix
    call runtimeVar2ToFix
    jr   runtimeEqualStringX

runtimeUnequalString:
    call runtimeVar1ToFix
    call runtimeVar2ToFix
    jr   runtimeUnequalStringX

runtimeSmallerString:
    call runtimeVar1ToFix
    call runtimeVar2ToFix
    jr   runtimeSmallerStringX
runtimeSmallerEqualString:
    call runtimeVar1ToFix
    call runtimeVar2ToFix
    jr   runtimeSmallerEqualStringX
runtimeBiggerString:
    call runtimeVar1ToFix
    call runtimeVar2ToFix
    jr   runtimeBiggerStringX
runtimeBiggerEqualString
    call runtimeVar1ToFix
    call runtimeVar2ToFix
    jr   runtimeBiggerEqualStringX



runtimePoint

	LD B,L
	LD C,E
    CALL $22AA      ; PIXEL_ADD	Pixel address to HL.
	LD B,A	        ; B will count A+1 loops to get the wanted bit of (HL) to location 0.
	INC B
	LD A,(HL)
POINT_LP	
	RLCA	        ; The shifts.
	DJNZ POINT_LP
	AND $01
    LD  L,A
    LD  H,0
    ret
runtimeScreen
    ld B,L
    LD C,E
	LD HL,($5C36)	;CHARS plus +0100 gives HL pointing to the character set.
	LD DE,$0100
	ADD HL,DE
	LD A,C	        ;x is copied to A.
	RRCA	        ;The number 32*(x mod 8)+y is formed in A and copied to E. This is the low byte of the required screen address.
	RRCA
	RRCA
	AND $E0
	XOR B
	LD E,A
	LD A,C	        ;x is copied to A again.
	AND $18	        ;Now the number 64+8*INT (x/8) is inserted into D. DE now holds the screen address.
	XOR $40
	LD D,A
	LD B,$60	    ;B counts the 96 characters.
S_SCRN_LP		    
    PUSH BC	        ;Save the count.
	PUSH DE	        ;And the screen pointer.
	PUSH HL	        ;And the character set pointer.
	LD A,(DE)	    ;Get first row of screen character.
	XOR (HL)	    ;Match with row from character set.
	JR Z,S_SC_MTCH	;Jump if direct match found.
	INC A	        ;Now test for match with inverse character (get +00 in A from +FF).
	JR NZ,S_SCR_NXT	;Jump if neither match found.
	DEC A	        ;Restore +FF to A.
S_SC_MTCH		
    LD C,A	        ;Inverse status (+00 or +FF) to C.
	LD B,$07	    ;B counts through the other 7 rows.
S_SC_ROWS		
    INC D	        ;Move DE to next row (add +0100).
	INC HL	        ;Move HL to next row (i.e. next byte).
	LD A,(DE)	    ;Get the screen row.
	XOR (HL)	    ;Match with row from the ROM.
	XOR C       	;Include the inverse status.
	JR NZ,S_SCR_NXT	;Jump if row fails to match.
	DJNZ S_SC_ROWS	;Jump back till all rows done.
	POP BC	        ;Discard character set pointer.
	POP BC	        ;And screen pointer.
	POP BC	        ;Final count to BC.
	LD A,$80	    ;Last character code in set plus one.
	SUB B	        ;A now holds required code.
    LD  BC,3        ;We want to store 1 Character + Length
    LD  D,A         ;The character
    LD  A,ZXHeapTypeTemp
    CALL ZXAlloc
    DEC  BC
    DEC  BC
    LD  (HL),BC
    inc HL
    inc hl
    LD (HL),D
    dec HL
    DEC HL
    
    ret
S_SCR_NXT		
    POP HL	        ;Restore character set pointer.
	LD DE,$0008	    ;Move it on 8 bytes, to the next character in the set.
	ADD HL,DE
	POP DE	        ;Restore the screen pointer.
	POP BC	        ;And the counter.
	DJNZ S_SCRN_LP	;Loop back for the 96 characters.
	LD   HL,0       ;Nothing found, String is empty
    ret

runtimeTab
    ld a,0
    ld (iy+2),a
    ld b,($5C88)
    ld c,l
    ld a,24
    sub b
    jp  c,runtinePrintAtErr
    ld b,a
    ld a,33
    sub c
    jp  c,runtinePrintAtErr
    ld c,a
    call zxromClSet
    
runtimeTabLoop:    
    ret
runtimeDebug:   
    if DEBUGGER=0
    ret
    endif

    if DEBUGGER=1
    call runtimeCheckBreakDebug
    ld (rtDebugStmt),a
    ld (rtDebugLine),hl


    ld   bc,(rtBreakpoint)
    or   a,a
    sbc  hl,bc
    call z,rtDebugSetStop

    ;call rtDebugShowLine
    ld   a,(rtStopped)
    cp   0
    jr   z,rtDebugContinue
        ld a,5*8
    ld (charAttrib),a
    call rtDebugShowLine
    call rtDebugSaveScreen
rtDebugLoop:
    ld  a,0
    ld (charX),a
    ld a,1
    ld (charY),a
    ld   hl,rtDebugMsg
    call rtPrintString0
    ld a,0
    ld (charX),a
    ld (charY),a
    ld  hl,rtDebugMsgBp
    call rtPrintString0
    ld  hl,(rtBreakpoint)
    call printDezHL
    call rtDebugPrintWatch
    call rtDebugWaitKey
    and %01011111;      convert to upper case
    cp   'B'
    jr   z,rtDebugSetBreakpoint
    cp   'R'
    jr   z,rtDebugRun
    cp   'S'
    jr   z,rtDebugContinue
    cp   'W'
    jp   z,rtDebugWatch
rtDebugContinueExit
    call rtDebugRestoreScreen

rtDebugContinue:
    
    ret    

rtDebugShowLine:

    ld a,0
    ld (charY),a
    ld  a,24
    ld (charX),a
    ld  hl,(rtDebugLine)
    call printDezHL
    ld   bc,(rtBreakpoint)
    or   a,a
    sbc  hl,bc
    call z,rtDebugSetStop
    ld   a,':'
    call printA
    ld   a,(rtDebugStmt)
    call printDezA
    ld   a,' '
    call printA
    call printA
    ret

rtDebugRun:
    ld a,0
    ld (rtStopped),a
    jr rtDebugContinueExit

rtDebugSetBreakpoint:
    call rtDebugInput
    ld  de,rtDebugInputBuf
    call runtimeValInt
    ld  (rtBreakpoint),hl
    jr rtDebugContinueExit

rtDebugWaitKey:
    call rtGetKey
    cp 0
    jr z,rtDebugWaitKey
    push af
rtDebugWaitKey1
    call rtGetKey
    cp 0
    jr nz, rtDebugWaitKey1
    pop af
    ret

rtDebugSetStop:

    ld a,1
    ld (rtStopped),a
    ret

rtDebugWatch:
    call rtDebugInput
    ld   hl,rtDebugInputBuf
    ld   de,rtDebugWatchBuf
    ld   bc,32
    ldir

    jp rtDebugLoop    

rtPrintString0:
    ld   a,(hl)
    or   a
    ret  z
    call printA
    inc  hl
    jr   rtPrintString0

rtDebugInput:
    ld ix,rtDebugInputBuf
    ld (ix),0
rtDebugInputPrint:    
    ld HL,rtDebugInputBuf
    ld a,0
    ld (charX),a
    ld (charY),a
rtDebugInputPrintLoop:
    ld  a,(hl)
    cp  0
    jr  z,rtDebugInputPrintEnd
    call printA
    inc  hl
    jp   rtDebugInputPrintLoop
rtDebugInputPrintEnd:
    ld a,'*'
    call printA
rtDebugInputPrintLoop2
    ld a,(charX)
    cp 31
    jr z,rtDebugInputPrintEnd2
    ld a,'_'
    call printA
    jr  rtDebugInputPrintLoop2
rtDebugInputPrintEnd2:
    push hl
    call rtDebugWaitKey
    pop hl
    cp  12
    jr  z,rtDebugBackspace
    cp  13
    ret z
    ld (hl),a
    inc hl
    ld  a,0
    ld (hl),a
    jr  rtDebugInputPrint
rtDebugBackspace:
    ld  bc,rtDebugInputBuf
    ld  a,h
    cp  b
    jr  nz,rtDebugBackspace1
    ld  a,l
    cp  c
    jr  z,rtDebugInputPrintEnd2
rtDebugBackspace1:
    dec hl
    ld  (hl),0
    jp  rtDebugInputPrint

rtDebugPrintWatch:
    ld a,0
    ld (charX),a
    ld a,3
    ld (charY),a
    ld hl, rtDebugWatchBuf
    ld b,0
rtDebugPrintWatch0:
    ld de,hl
    ld a,(hl)
    cp 0
    ret z
    cp a,32
    jr nz,rtDebugPrintWatch1
    inc hl
    jr  rtDebugPrintWatch0
rtDebugPrintWatch1
    ld a,(hl)
    cp 0
    jr z,rtDebugWatchPrintVar
    cp a,32
    jr z,rtDebugWatchPrintVar
    call printA
    inc hl
    inc b
    jr  rtDebugPrintWatch1

rtDebugWatchPrintVar:
    ld (rtDebugNextVar),hl
    ld hl,de
    ld ix,ZX_VARIABLES
rtDebugWatchPrintFindVarLoop:

    ld a,(ix)
    cp 0
    jr z,rtDebugVarPrintNotFound
    ld  c,a
    inc ix
    call debugCompareHlIx
    cp  a,0
    jr  z,rtDebugVarPrintFound
    ld  e,(ix-1)
    push hl
    push ix
    pop  hl
    ld  d,0
    add hl,de
    ld  a,(hl)  ; /type
    inc hl
    ld  a,(hl)  ; Anzahl dimns
    inc hl
    ld  e,a
    ld  d,0
    add hl,de
    inc hl
    inc hl
    push hl
    pop  ix
    pop  hl
    jr   rtDebugWatchPrintFindVarLoop

rtDebugVarPrintNotFound:
        ld  hl,(rtDebugNextVar)
    jp rtDebugPrintWatch0

debugCompareHlIx:
    ld  a,b
    cp  c
    jr  nz,debugCompareHlIxFalse
    push hl
    push ix
    push bc
debugCompareHlIxLoop:
    ld a,(hl)
    inc hl
    cp  (ix)
    jr  nz,debugCompareHlIxFalsePop
    inc ix
    dec b
    jr  nz,debugCompareHlIxLoop
debugCompareHlIxTrue:
    pop bc
    pop ix
    pop hl
    ld a,0
    ret


debugCompareHlIxFalsePop:
    pop bc
    pop ix
    pop hl
debugCompareHlIxFalse:
    ld a,1
    ret


rtDebugVarPrintFound:
    
    ld a,":"
    call printA
    ld b,0
    push ix
    pop  hl
    add hl,bc
    ld  c,(hl)      ; type
    inc hl
    ld a,(hl)      ; Anzahl dimns
    cp 0
    jr  z,rtDebugVarPrintFound0
    ld b,a
    
    push hl
    pop ix
    inc ix
    ld hl,0
    ld (rtDebugDim),hl
    ld hl,1
rtDebugVarPrintFoundDimLoop:
    ld e,(ix)
    ld d,0
    push bc
    call runtimeMult16bit
    pop bc
    inc ix
    djnz rtDebugVarPrintFoundDimLoop
    ld (rtDebugDim),hl
    ld de,(ix)
    jr rtDebugVarPrintFound1:
rtDebugVarPrintFound0:    
    inc hl
    ld de,(hl)

rtDebugVarPrintFound1:
    ex  hl,de
    ld  a,c
    cp  1
    jr  z,rtDebugPrintInt
    cp  2
    jr  z,rtDebugPrintFloat2
    cp  3
    jr  z,rtDebugPrintString
    ret 
rtDebugPrintInt:
    ld   de,(hl)
    ex   hl,de
    call printDezHL
    ld  hl,(rtDebugNextVar)
    ld a,32
    call printA
    jp   rtDebugPrintWatch0

rtDebugPrintFloat2:
    call runtimePushFloatVar
    call runtimeStr
    call rtDebugPrintString
    
    ld  hl,(rtDebugNextVar)
    jp rtDebugPrintWatch0

rtDebugPrintString:
    ld   bc,(rtDebugDim)
    ld   a,b
    or   c
    jr   z,rtDebugPrintStringBasic
    call  rtDebugPrintFixString
    jp  rtDebugPrintWatch0

rtDebugPrintStringBasic:
    call rtDebugPrintBASICString
    jp  rtDebugPrintWatch0


rtDebugVarPrintFoundArray:
    ret




rtDebugDim: dw 0  
rtDebugStmt: db 0
rtDebugLine: dw 0
rtDebugScreenLines equ 3
rtDebugNextVar: dw 0
rtBreakpoint: dw -1
rtStopped:    db 1
rtDebugMsgBp: db "BP:",0
rtDebugMsg:  db "(B)reakpt (R)un (S)tep (W)atch",0
rtDebugInputBuf: defs 32,0
rtDebugWatchBuf: db "y$",0
                defs 32,0

rtSaveScreen:
        defs 2048
rtSaveAttr:
        defs 256

rtDebugSaveScreen:
    ld   HL,$4000
    ld   DE,rtSaveScreen
    ld   BC,2048
    ldir
    ld   hl,$4000+6144
    ld   de,rtSaveAttr
    ld   bc,256
    push hl
    ldir 
    pop hl
    
    ld  bc,256
rtDebugSaveScreenLoop:
    ld  a,5*8
    ld (hl),a
    inc hl
    dec bc
    ld  a,b
    or  c
    jr  nz,rtDebugSaveScreenLoop
    ld   HL,rtSaveScreen
    ld   BC,2048
rtDebugSaveScreenLoop2:
    ld a,0
    ld (hl),a
    inc hl
    dec bc
    ld a,b
    or c
    jr nz, rtDebugSaveScreenLoop2

    ret

rtDebugRestoreScreen:
    ld   DE,$4000
    ld   HL,rtSaveScreen
    ld   BC,2048
    ldir
    ld   de,$4000+6144
    ld   hl,rtSaveAttr
    ld   bc,256
    ldir 

    ret

rtDebugPrintBASICString:
    PUSHA
    push hl
    call printf
    db  "LEN=",0
    pop  hl
    push hl
    ld   de,(hl)
    ex   hl,de
    call printDezHL
    ld   a,h
    or   l
    jr   z,rtDebugPrintBasicStringEmpty
    ld   a,32
    call printA
    pop  hl
    ld   bc,(hl)
    inc  hl
    inc  hl
    call rtDebugPrintFixString    
    POPA
    ret
rtDebugPrintBasicStringEmpty:
    pop hl
    POPA 
    ret


    endif

    if DEBUG=1
rtDebugPrintAHex:
    ld a,'$'
    call printA
    ld   a,b
    call printHex2
    pop  bc
    ret    
rtDebugPrintFixString
    PUSHA
rtDebugPrintFixStringLoop:
    ld   a,(hl)
    inc  hl
    call rtDebugPrintA
    dec  bc
    ld   a,b
    or   c
    jr   nz,rtDebugPrintFixStringLoop
    ld  a,13
    call printA

    POPA
    ret

rtDebugPrintA:
    push bc
    ld   b,a
    ld   c,32
    cp   a,31
    jr   c,rtDebugPrintAHex
    cp   164
    jr   nc,rtDebugPrintAHex
    ld   a,b
    call printA
    pop bc
    ret
    endif



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
runtimeSaveSP:          dw 0

 DISPLAY "Runtime Size =",/D, $-RUNTIME_START, " bytes"
