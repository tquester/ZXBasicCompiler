
utTest:               call utTestCompare
                      ret 
utTestCompare:        ld   hl,utStrEqual
                      call utPrintString
                      call utpushNumbers100x200
                      call rtDebugPrintFpStack
                      call runtimeEqualFloat
                      call utTestPrintResult

                      call utpushNumbers100x100
                      call rtDebugPrintFpStack
                      call runtimeEqualFloat
                      call utTestPrintResult

                      ld   hl,utStrBigger
                      call utPrintString
                      call utpushNumbers100x200
                      call rtDebugPrintFpStack
                      call runtimeBiggerFloat
                      call utTestPrintResult

                      ld   hl,utStrBigger
                      call utPrintString
                      call utpushNumbers200x100
                      call rtDebugPrintFpStack
                      call runtimeBiggerFloat
                      call utTestPrintResult

                      call utpushNumbers100x100
                      call rtDebugPrintFpStack
                      call runtimeBiggerFloat
                      call utTestPrintResult

                      ld   hl,utStrSmaller
                      call utPrintString
                      call utpushNumbers100x200
                      call rtDebugPrintFpStack
                      call runtimeSmallerFloat
                      call utTestPrintResult

                      call utpushNumbers100x100
                      call rtDebugPrintFpStack
                      call runtimeSmallerFloat
                      call utTestPrintResult

                      call runtimeCls
                      ld   hl,utStrBiggerEQ
                      call utPrintString
                      call utpushNumbers100x200
                      call rtDebugPrintFpStack
                      call runtimeBiggerEqualFloat
                      call utTestPrintResult

                      call utpushNumbers100x100
                      call rtDebugPrintFpStack
                      call runtimeBiggerEqualFloat
                      call utTestPrintResult

                      ld   hl,utStrSmallerEQ
                      call utPrintString
                      call utpushNumbers100x200
                      call rtDebugPrintFpStack
                      call runtimeSmallerEqualFloat
                      call utTestPrintResult

                      call utpushNumbers100x100
                      call rtDebugPrintFpStack
                      call runtimeSmallerEqualFloat
                      call utTestPrintResult

                      ld   hl,utStrNEqual
                      call utPrintString
                      call utpushNumbers100x200
                      call rtDebugPrintFpStack
                      call runtimeUnequalFloat
                      call utTestPrintResult
8
                      call utpushNumbers100x100
                      call rtDebugPrintFpStack
                      call runtimeUnequalFloat
                      call utTestPrintResult

                       ret 

PRINTFPSTACK            MACRO
                        call rtDebugPrintFpStack
                        endm
PRINTFLOAT:            MACRO text, var
                        call utPrintf
                        db text,0
                        ld hl,var 
                        
                       call runtimePushFloatVar
                       call runtimePrintFloat
                       ld a,13
                       RST $10
                       endm

utPrintf:              ld		hl,0
		               add		hl,sp
		               pop		hl			; hl points to text following the command
utPrintfLoop:          ld a,(hl)            ; read first character
                        inc hl
                       or a                 ; check if it is zero
                       jr  z,utPrintfEx   ; if so, return
                       RST $10              ;  print character
                       jr utPrintfLoop      ; repeat                      
utPrintfEx:            jp (hl)
                        ret

utPrintFloat:          call runtimePushFloatVar
                       call runtimePrintFloat
                       ld a,13
                       RST $10
                       ret
utPrintString:    ld a,(hl)
                        or a
                        ret z
                        RST $10
                        inc hl
                        jr utPrintString

utTestPrintResult:    ld a,l
                      cp 1
                      jr z,utTestPrintResultTrue
                      ld hl,utStrFalse
                      jp utPrintString
utTestPrintResultTrue: ld hl,utStrTrue
                       jp utPrintString                      

utStrNEqual:        db "Test auf Ungleichheit",13,0
utStrEqual:        db "Test auf Gleichheit",13,0
utStrBigger:        db "Test auf >",13,0
utStrSmaller:        db "Test auf <",13,0
utStrBiggerEQ:        db "Test auf >=",13,0
utStrSmallerEQ:        db "Test auf <=",13,0
utStrTrue:   db "Egebnis = true",13,0
utStrFalse:   db "Egebnis = false",13,0

utpushNumbers100x200: ld hl,1
                      call runtimeIntToFloat
                      ld hl,2
                      call runtimeIntToFloat
                      ret

utpushNumbers200x100: ld hl,2
                      call runtimeIntToFloat
                      ld hl,1
                      call runtimeIntToFloat
                      ret

utpushNumbers100x100: ld hl,1
                      call runtimeIntToFloat
                      ld hl,1
                      call runtimeIntToFloat
                      ret

rtDebugStackEnd:    dw 0
rtDebugPrintFpStack:
                    push af
                    push bc
                    push de
                    push hl
                    call  utPrintf
                    db "FP-Stack:",0
                    ld   hl,(ZX_STKEND) ; Fetch the 'old' STKEND.
                    ld   (rtDebugStackEnd),hl
rtDebugPrintFtStackLoop:
                    ld hl,(rtDebugStackEnd)
                    ld de,(ZX_STKBOT)
                    ld a,l
                    cp e
                    jr nz,rtDebugPrintStack1
                    ld a,h
                    cp d
                    jr z,rtDebugPrintStackEnd
rtDebugPrintStack1:
                    ld  de,5
                    sub hl,de
                    ld (rtDebugStackEnd),hl ; Store the new STKEND.
                    call runtimePushFloatVar
                    call runtimePrintFloat
                    ld a,','
                    rst $10
                    ld a,' '
                    rst $10
                    jr  rtDebugPrintFtStackLoop
rtDebugPrintStackEnd:
                    pop hl
                    pop de
                    pop bc
                    pop af
                    ret


rtDebugPrintFloat:  if DEBUG=1
                    push af
                    push bc
                    push de
                    push hl
                    RST $28
                    db zxcalc_duplicate
                    db zxcalc_end_calc
                    call runtimePrintFloat
                    ld a,13
                    RST $10
                    pop hl
                    pop de
                    pop bc
                    pop af
                    endif
                    ret
