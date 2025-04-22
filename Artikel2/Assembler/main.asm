;===========================================================================
; main.asm
;===========================================================================
DEBUG                       equ 1
; Prepared Sprites werden in 8 Shift-Positionen gespeichert. Für 16bit Sprites braucht es 
; 6 Characters also 8*6*32 = 384 Bytes
; Wenn das Sprite mit *DATA angelegt wird, wird das 16x16bit Image einfach um 1, 2, ,..7 
; pixel nach rechts verschoben. Wenn man mehr Bewegung haben möchte kann man die Daten
; auch überschreiben und dann z.B. mit Save Code abspeichern
PREPARED_SPRITE_COUNT       equ 5
; Slow sprites are not shifted, they occupy 32 Bytes (4 Characters). A slow sprite gets
; shifted right before it is displayed
SLOW_SPRITE_COUNT           equ 5



    include "macros.asm"
    ORG 0x8000

    SLDOPT COMMENT WPMEM, LOGPOINT, ASSERTION

max_x:  equ 200
max_y:  equ 100

NEX:    equ 1   ;  1=Create nex file, 0=create sna file

    IF NEX == 0
        ;DEVICE ZXSPECTRUM128
        DEVICE ZXSPECTRUM48
        ;DEVICE NOSLOT64K
    ELSE
        DEVICE ZXSPECTRUMNEXT
    ENDIF

    

START:
        RELOCATE_START 
main:  
        jp debugDemo
;        jp relocator_code
scroll: ret
;===========================================================================
; Persistent watchpoint.
; Change WPMEMx (remove the 'x' from WPMEMx) below to activate.
; If you do so the program will hit a breakpoint when it tries to
; write to the first byte of the 3rd line.
; When program breaks in the fill_memory sub routine please hover over hl
; to see that it contains 0x5804 or COLOR_SCREEN+64.
;===========================================================================

; WPMEMx 0x5840, 1, w


;===========================================================================
; Include modules
;===========================================================================
    include "ZXLibrary/zxspectrum.asm"
    include "ZXLibrary/graphics.asm"
    include "ZXLibrary/heap.asm"
    if DEBUG=1
    include "ZXLibrary/print.asm"
    endif
    include "ZXLibrary/math.asm"
    include "compiledBasic.asm"
    
    




debugDemo:
    if DEBUG=1
    ; Disable interrupts
    di
    ld sp,stack_top

        ld a, ZX_YELLOW*PAPER+ZX_BLUE
        ld hl, ZX_ATTR_P
        ld (hl),a

    call        ZXHeapTest

    ; CLS
    call        ClearScreen
    ld          h,1
    ld          l,2
    call        compiledBasic
    ret

HL1: LD HL,1
     ret

RuntimePlot:
    ld  b,e
    ld  c,l
    ld  h,0
    call plot
    ret     
sprite1:
                db 0, 0, 0, 0, 15, 248, 1, 128, 65, 128, 255, 248, 255, 252, 255, 228 
                db 95, 252, 15, 252, 7, 248, 1, 32, 1, 32, 15, 252, 0,0, 0, 0             
sprite2:        db 0,0,0,0,0,0,0,0,15,240,15,248,28,204,28,204 
                db 254,127,254,127,254,63,252,24,24,60,60,60,60,24,24 

        endif


;===========================================================================
; Stack.
;===========================================================================

    if DEBUG=1

; Stack: this area is reserved for the stack
STACK_SIZE: equ 400    ; in words


; Reserve stack space
    defw 0  ; WPMEM, 2
stack_bottom:
    defs    STACK_SIZE*2, 0
stack_top:
    ;defw 0
    defw 0  ; WPMEM, 2
    endif
main_end:
relocator_table:
    RELOCATE_TABLE


code_size   EQU     $ - main
    DISPLAY "Code size = ", /D, code_size,  " bytes"
	MakeTape "compiled.tap", "compled", START, code_size
        RELOCATE_END
relocate_count equ (code_size-relocator_table)/2
    IF NEX == 0
        SAVESNA "z80-sample-program.sna", main
    ELSE
        SAVENEX OPEN "z80-sample-program.nex", main, main_end
        SAVENEX CORE 3, 1, 5
        SAVENEX CFG 7   ; Border color
        SAVENEX AUTO
        SAVENEX CLOSE
    ENDIF


