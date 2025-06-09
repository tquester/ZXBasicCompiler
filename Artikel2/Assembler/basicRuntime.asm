zxromCl         equ $0D6B
zxromPlot:      equ $22DC+3
zxromClSet:     equ $0DD9 ; b = B	Line number C	Column number
zxromAlpha:     equ $2C8D
; * 128 If the character position is flashing, 0 if it is steady 
;	64 if the character position is bright, 0 if it is normal 
;	8* the code for the paper colour 
;	the code for the ink colour

runtimeCls:             
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
    or 7
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
p
    call zxromPlot
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
    call $09F4
    POP HL
    POP BC
    inc hl
    dec bc
    ld  a,b
    or c
    jp nz,runtimePrntString1
    ret

runtimePrintAt:
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
    ret

runtimePrintNewline:
    ld a,13
    rst $10
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

HL1: LD HL,1
     ret
CTOB:
    ld b,c
    ret



 
