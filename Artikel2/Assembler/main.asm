
;===========================================================================
; main.asm
;===========================================================================
DEBUG                       equ 0			; Enables debug mode. Used to test so new functions. Compiled BASIC runs with custom PRINT command
DEBUGBASIC                  equ 0		; Initializes the ZX Spectrum using a copy of the startup, then starts the compiled BASIC program.
											; Rom routines are allowed
DEBUGSAVESCREEN				equ 0			; Heep Walk saves and restores the screen (costs 6144+768 Bytes )
DEBUGMATH                   equ 0			; Calls the Math Debug code on run	
DEBUGHEAP                   equ 0			; Calls the Heap Debug code on run
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
    ORG 27000
PROGSTART:

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


START:RELOCATE_START 

main:   ld sp,stack_top
		if DEBUGBASIC=1
         call InitSpectrum
        endif 
        if DEBUGHEAP=1
        call ZXHeapTest
        endif
        call compiledBasic
        ret
        jp debugDemo
;        jp relocator_code
scroll: ret
		if DEBUGBASIC=1
InitSpectrum:
        LD A,$07                ;	Make the border white in colour.
        OUT ($FE),A
        LD A,$3F	            ; Set the I register to hold the value of +3F.
        LD I,A
        IM 1	                ; Interrupt mode 1 is used.
        LD IY,$5C3A	            ; IY holds +ERR-NR always.
        EI
	    ld de,PROGSTART-1
        ld ($5CB0),de
        ld ($5CB2),de
        ld HL,$ffff
        ld ($5CB4),HL       ; phys ramtop
        ld HL, 20
        ld ($5C36),HL       ; RASP
        ld HL, PROGSTART-21*8
        ld ($5C78), HL      ; UDG
;        CALL $11B7
        call NEW




        jp  $12a2
   
        ret
		endif
BASIC:  LINE
        DB      zxb_print,ZXB_USR,ZXB_VAL, '"32771"'
        db 13,$80
        LEND
BASIC_END: EQU $    

BASIC_LEN EQU $ - BASIC

		if DEBUGBASIC=1
NEW:
	DI	; Disable the maskable interrupt.
	LD A,$FF	; The NEW flag.
	LD DE,($5CB2)	; The existing value of RAMTOP is preserved.
	EXX		; Load the alternate registers with the following system variables (P-RAMT, RASP, PIP, UDG). All of which will also be preserved.
	LD BC,($5CB4)
	LD DE,($5C38)
	LD HL,($5C7B)
	EXX
;This entry point is used by the routine at START.
;The main entry point.
START_NEW:	LD B,A	; Save the flag for later.
	LD A,$07	; Make the border white in colour.
	OUT ($FE),A
	LD A,$3F	; Set the I register to hold the value of +3F.
	LD I,A
	NOP	; Wait 24 T states.
	NOP
	NOP
	NOP
	NOP
	NOP
;Now the memory is checked.
	LD H,D	; Transfer the value in DE (START=+FFFF, NEW=RAMTOP).
	LD L,E
RAM_FILL:	LD (HL),$02	; Enter the value of +02 into every location above +3FFF.
	DEC HL
	CP H
	JR NZ,RAM_FILL
RAM_READ:	AND A	; Prepare for true subtraction.
	SBC HL,DE	; The carry flag will become reset when the top is reached.
	ADD HL,DE
	INC HL	; Update the pointer.
	JR NC,RAM_DONE	; Jump when at top.
	DEC (HL)	; +02 goes to +01.
	JR Z,RAM_DONE	; But if zero then RAM is faulty. Use current HL as top.
	DEC (HL)	; +01 goes to +00.
	JR Z,RAM_READ	; Step to the next test unless it fails.
RAM_DONE:	
	DEC HL          ;	HL points to the last actual location in working order.
                    ;   Next restore the 'preserved' system variables. (Meaningless when coming from START.)
	EXX	            ; Restore  P-RAMT, RASP, PIP and UDG.
	LD ($5CB4),BC
	LD ($5C38),DE
	LD ($5C7B),HL
	EXX
	INC B	; Test the START/NEW flag.
	JR Z,RAM_SET	; Jump forward if coming from the NEW command routine.
;Overwrite the system variables when coming from START and initialise the user-defined graphics area.
	LD ($5CB4),HL	; Top of physical RAM (P-RAMT).
	LD DE,$3EAF	; Last byte of 'U' in character set.
	LD BC,$00A8	; There are this number of bytes in twenty one letters.
	EX DE,HL	; Switch the pointers.
	LDDR	; Now copy the character forms of the letters 'A' to 'U'.
	EX DE,HL	; Switch the pointers back.
	INC HL	; Point to the first byte.
	LD ($5C7B),HL	; Now set UDG.
	DEC HL	; Down one location.
	LD BC,$0040	; Set the system variables RASP and PIP.
	LD ($5C38),BC
;The remainder of the routine is common to both the START and the NEW operations.
RAM_SET	LD ($5CB2),HL	; Set RAMTOP.
	LD HL,$3C00	; Initialise the system variable CHARS.
	LD ($5C36),HL
; Next the machine stack is set up.
	LD HL,($5CB2)	; The top location (RAMTOP) is made to hold +3E.
	LD (HL),$3E
	DEC HL	; The next location is left holding zero.
	LD SP,HL	; These two locations represent the 'last entry'.
	DEC HL	; Step down two locations to find the correct value for ERR-SP.
	DEC HL
	LD ($5C3D),HL
;The initialisation routine continues with:
	IM 1	; Interrupt mode 1 is used.
	LD IY ,$5C3A	        ; IY holds +ERR-NR always.
	EI	; The maskable interrupt can now be enabled. The real-time clock will be updated and the keyboard scanned every 1/50th of a second.
	LD HL,$5CB6	; The system variable CHANS is set to the base address of the channel information area.
	LD ($5C4F),HL
	LD DE,$15AF	; The initial channel data is moved from the table (CHANINFO) to the channel information area.
	LD BC,$0015
	EX DE,HL
	LDIR
	EX DE,HL	; The system variable DATADD is made to point to the last location of the channel data.
	DEC HL
	LD ($5C57),HL
	INC HL	; And PROG and VARS to the the location after that.
	LD ($5C53),HL
	LD ($5C4B),HL
	LD (HL),$80	; The end-marker of the variables area.
	INC HL	; Move on one location to find the value for E-LINE.
	LD ($5C59),HL
	LD (HL),$0D	; Make the edit-line be a single 'carriage return' character.
	INC HL
	LD (HL),$80	; Now enter an end marker.
	INC HL	; Move on one location to find the value for WORKSP, STKBOT and STKEND.
	LD ($5C61),HL
	LD ($5C63),HL
	LD ($5C65),HL
	LD A,$38	; Initialise the colour system variables (ATTR-P, ATTR-T, BORDCR) to FLASH 0, BRIGHT 0, PAPER 7, INK 0, BORDER 7.
	LD ($5C8D),A
	LD ($5C8F),A
	LD ($5C48),A
	LD HL,$0523	; Initialise the system variables REPDEL and REPPER.
	LD ($5C09),HL
	DEC (IY-$3A)	; Make KSTATE0 hold +FF.
	DEC (IY-$36)	; Make KSTATE4 hold +FF.
	LD HL,$15C6	; Next move the initial stream data from its table to the streams area.
	LD DE,$5C10
	LD BC,$000E
	LDIR
	SET 1,(IY+$01)	; Signal 'printer in use' (set bit 1 of FLAGS) and clear the printer buffer.
	CALL $0ECD; CLEAR_PRB
	LD (IY+$31),$02	; Set the size of the lower part of the display (DF-SZ) and clear the whole display.
	CALL $0D6B; CLS
	XOR A	; Now print the message '© 1982 Sinclair Research Ltd' on the bottom line.
	LD DE,$1538
	CALL $0BDB; PO_MSG
	ld  A,(IY+$02)
	and $fe	; Clear bit 0 of TV-FLAG.
	ld (IY+$02),A
	SET 5,(IY+$02)	; Signal 'the lower part will required to be cleared' (set bit 5 of TV-FLAG).
	LD  HL,32000
	ld  (23651),HL
	LD  (23653),HL

	LD (IY+$31),$02 ;	The lower part of the screen is to be two lines in size (see DF-SZ).
	CALL $1795	; AUTO_LIST ;	Produce an automatic listing.
	CALL $16B0	; SET_MIN	All the areas from E-LINE onwards are given their minimum configurations.

	LD A,$00	; Channel 'K' is opened before calling the EDITOR.
	CALL $1601	; CHAN_OPEN
	CALL $0F2C	; EDITOR	
	ld   A,(IY+$02)	; TV Flag
	and $fe	; Clear bit 0 of TV-FLAG.
	ld   (IY+$02),A	; Clear the TV-FLAG.
	ld   HL,localudb
	ld  (ZX_UDG),HL

	call compiledBasic

 	jp  $12a2
	RET     
	endif

	if DEBUGBASIC=1
localudb: defs 8*21
	endif 
	
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
    include "ZXLibrary/heap.asm"
    if DEBUG=1
	include "unittest.asm"
    include "ZXLibrary/print.asm"
    include "ZXLibrary/graphics.asm"
    endif
    include "ZXLibrary/math.asm"
    include "basicRuntime.asm"
    include "compiledBasic.asm"
    
    




debugDemo:
    if DEBUG=1
    ld          a,WHITE*PAPER+BLACK
    ld          (ZX_ATTR_P),a   
    ld          (ZX_ATTR_T),a
    endif
    call        compiledBasic

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
    endif
stack_top:
    if DEBUG=1
    ;defw 0
    defw 0  ; WPMEM, 2
    endif
main_end:
relocator_table:
;    RELOCATE_TABLE


code_size   EQU     $ - main
    DISPLAY "Code size = ", /D, code_size,  " bytes"
	MakeTape "compiled.tap", "compiled", START, code_size
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


