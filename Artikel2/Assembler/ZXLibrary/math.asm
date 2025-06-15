
MathStart:
MulHleqDExA:
Mul8:  push         bc
        push        af
                                         ; this routine performs the operation HL=DE*A
        ld hl,0                        ; HL is used to accumulate the result
        ld b,8                         ; the multiplier (A) is 8 bits wide
Mul8Loop:
        rrca                           ; putting the next bit into the carry
        jp nc,Mul8Skip                 ; if zero, we skip the addition (jp is used for speed)
        add hl,de                      ; adding to the product if necessary
Mul8Skip:
        sla e                          ; calculating the next auxiliary product by shifting
        rl d                           ; DE one bit leftwards (refer to the shift instructions!)
        djnz Mul8Loop
        pop     af
        pop     bc
        ret

MulHxD:                           ; this routine performs the operation HL=H*E
        ld d,0                         ; clearing D and L
        ld l,d
        ld b,8                         ; we have 8 bits
Mul8bLoop:
        add hl,hl                      ; advancing a bit
        jp nc,Mul8bSkip                ; if zero, we skip the addition (jp is used for speed)
        add hl,de                      ; adding to the product if necessary
Mul8bSkip:
        djnz Mul8bLoop
        ret
// ----------------------------------------------------
// The following routine divides ac by de and places the quotient in ac and the remainder in hl
// ----------------------------------------------------
div_ac_de:
   push bc
   ld	hl, 0
   ld	b, 16

_loopdiv_ac_de:
   sll	c
   rla
   adc	hl, hl
   sbc	hl, de
   jr	nc, $+4
   add	hl, de
   dec	c
_div_ac_de2:
   djnz	_loopdiv_ac_de:
   pop bc
   
   ret

;
; Divide 16-bit values (with 16-bit result)
; In: Divide BC by divider DE
; Out: BC = result, HL = rest
;
Div16:
    ld hl,0
    ld a,b
    ld b,8
Div16_Loop1:
    rla
    adc hl,hl
    sbc hl,de
    jr nc,Div16_NoAdd1
    add hl,de
Div16_NoAdd1:
    djnz Div16_Loop1
    rla
    cpl
    ld b,a
    ld a,c
    ld c,b
    ld b,8
Div16_Loop2:
    rla
    adc hl,hl
    sbc hl,de
    jr nc,Div16_NoAdd2
    add hl,de
Div16_NoAdd2:
    djnz Div16_Loop2
    rla
    cpl
    ld b,c
    ld c,a
    ret   
; ----------------------------------------------------
; The following routine divides hl by c and places the quotient in hl and the remainder in a
DivHlCRest: 
   xor	a
   ld	b, 16

_loop:
   add	hl, hl
   rla
   jr	c, $+5
   cp	c
   jr	c, $+4

   sub	c
   inc	l
   
   djnz	_loop
   
   ret        

; --------------------------------------------------------
; calculates hl=hl/d
DivHLxD:push af                        ; this routine performs the operation HL=HL/D
        push bc
        xor a                          ; clearing the upper 8 bits of AHL
        ld b,16                        ; the length of the dividend (16 bits)
Div8Loop:
        add hl,hl                      ; advancing a bit
        rla
        cp d                           ; checking if the divisor divides the digits chosen (in A)
        jp c,Div8NextBit               ; if not, advancing without subtraction
        sub d                          ; subtracting the divisor
        inc l                          ; and setting the next digit of the quotient
Div8NextBit:
        djnz Div8Loop
        pop  bc
        pop  af
        ret

Mul16BCxDE:                           ; This routine performs the operation DEHL=BC*DE
        ld hl,0
        ld a,16
Mul16Loop:
        add hl,hl
        rl e
        rl d
        jp nc,NoMul16
        add hl,bc
        jp nc,NoMul16
        inc de                         ; This instruction (with the jump) is like an "ADC DE,0"
NoMul16:
        dec a
        jp nz,Mul16Loop
        ret

; ----------------------------------------------------
; sgnA 
; returns 0 if A is 0
;         1 if A is positive
;        -1 if A is negative
; ----------------------------------------------------
sgnA:     cp    0
          ret   z
          and   $80
          jr    z, sgnAPos
          ld    a,-1
          ret
sgnAPos:  ld    a,1
          ret

sgnHL:    ld    a,h
          cp    0
          jr    nz, sgnHL_1
          ld    a,l
          cp    0
          ret   z
sgnHL_1:  ld    a,h
          and   $80
          
          jr    z,sgnHL_2
          ld    a,-1
          ret
sgnHL_2:  ld    a,1
          ret


; ----------------------------------------------------
; absA 
; returns 0 if A is 0
;         A if A is positive
;        -A if A is negative
; it always returns a positive number
; ----------------------------------------------------

absA:   cp      0
        ret     z
        push    af
        and     $80
        jr      z, absAPos
        pop     af
        neg
        ret
absAPos:    
        pop     af
        ret

absHL:  push    af
        ld      a,h
        and     $80
        cp      0
        jr      z,absHL_1
        push    de
        ld      de,hl
        ld      hl,0
        sbc     hl,de
        pop     de

absHL_1: pop    af
         ret

xrnd:
   
  ld hl,1       ; seed must not be 0

  ld a,h
  rra
  ld a,l
  rra
  xor h
  ld h,a
  ld a,l
  rra
  ld a,h
  rra
  xor l
  ld l,a
  xor h
  ld h,a

  ld (xrnd+1),hl

  ret         
; ----------------------------------------------------
       DISPLAY "Math Size =",/D, $-MathStart, " bytes"
       
