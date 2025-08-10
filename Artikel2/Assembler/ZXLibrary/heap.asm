HEAPSTART:            
ZXHeapStart:            dw  $F000
ZXHeapTop:             dw  $F000
ZXHeapEnd:             dw  $FFF0
ZXHeapFreeBlock:        dw 0
ZXHeapFreeBlockSize:    dw 0
ZXHeapTempNumOfByts:    dw 0
ZXHeapResult:            dw 0
ZXHeapNewType:          dw 1


; Memory block

; --------------------------------------------------
; -- Clear the heap. Write 0 to all positions     --
; --------------------------------------------------

ZXHeapClear:            push hl
                        push de
                        push bc
                        ld hl,(ZXHeapStart)
                        ld (ZXHeapTop),hl
                        ld de,(ZXHeapEnd)
                        push hl
                        ex  hl,de
                        sub hl,de
                        ld  bc,hl
                        pop hl
ZXHeapClearLooop:       ld   (hl),$0
                        inc  hl
                        dec bc
                        ld  a,c
                        or  b
                        jr  nz,ZXHeapClearLooop
                        pop bc
                        pop de
                        pop hl
                        call ZXClearHeap
                        ret

ZXBlockType:            equ 0          ; 1 Byte typ
ZXBLockBacklink:        equ 1          ; 2 Byte backlink
ZXBlockSize:            equ 3          ; 2 Byte size of block
ZXBlockMemory:          equ 5          ; Memory starts here, so the first 5 bytes are used for the header
ZXHeapHeaderSize:      equ 5          ; Size of the header in bytes
ZXHeapWalkStart:        equ 0          ; Start of the heap walk

ZXHeapTypeEmpty         equ 0          ; Empty heap element
ZXHeapTypeUsed          equ 1          ; Used heap element 
ZXHeapTypeTemp           equ 2         ; Temporary heap element (used in eval() for temp result)

ZXHeapBlockFirst:       ld       ix, (ZXHeapStart)
                        ret
ZXHeapBlockNext:        push hl
                        push de
                        ld de,(ZXHeapEnd)
                        ld hl,ix
                        sub hl,de
                        jr  nc, ZXHeapBlockNextEnd
                        jr   z, ZXHeapBlockNextEnd
                        ld hl,ix
                        ld  de,(ix+ZXBlockSize) ; Get the size of the current block
                        add hl,de               ; Add the size of the current block to the pointer
                        LD  DE,5
                        add HL,DE
                        ld   ix,hl              ; Set the new pointer to the next block

                        pop  de
                        pop  hl
                        LD   A,1
                        cp   0
                        ret
ZXHeapBlockNextEnd:     pop  de
                        pop  hl
                        LD   A,0
                        cp   0
                        ret    
; IX = current heap block
; DE = prev Heap block or 0
; Check if Block IX is free
; Check if Block DE is free
; if both are free, combine the blocks and set IX to DE






ZXFreeTemp:             call     ZXHeapBlockFirst
ZXFreeTempLoop:         LD       a,(ix+ZXBlockType)
                        cp       ZXHeapTypeTemp
                        jr       nz,ZXFreeTempLoop1
                        ld       a,ZXHeapTypeEmpty
                        ld       (ix+ZXBlockType),a ; Mark as empty
ZXFreeTempLoop1:      
                        push     ix
                        pop      de
                        call     ZXHeapBlockNext
                        ret     z
                        jr       ZXFreeTempLoop

ZXFreeTempCompact:      call ZXFreeTemp                        
ZXHeapCompactFree:      ; Compact the heap by combining empty blocks to bigger blocks
                        LD IX, (ZXHeapStart)
                        LD BC, (ZXHeapEnd)
ZXHeapCompactFree1:     ld    a,(ix+ZXBlockType) ; Get the type of the current block
                        cp    ZXHeapTypeEmpty
                        jr    nz,ZXHeapCompactFreeNext ; If empty, combine with next block
; the block at ix is a free block.
; lets see if the next block is also free
; if the next block is the heap end, return                        
                        ld    hl,ix
                        ld    DE,(ix+ZXBlockSize)
                        add   hl,de
                        LD    DE,5
                        add   hl,de                        
                        push  hl
                        sub   hl,bc
                        jr    nz, ZXHeapFreeCompact2 ; If not at the end of the heap, continue
                        pop   hl
                        ret
ZXHeapFreeCompact2:         ; now hl points to a free block which is next to ix
                        pop   hl
                        ld    a,(HL)
                        cp    ZXHeapTypeEmpty
                        jr    nz,ZXHeapCompactFreeNext ; If not empty, continue with next block
                        ; Combine the two blocks
                        ld    de,ZXBlockSize
                        add   hl,de
                        ld    de,(hl)              ; de contains size of next block
                        ld    hl,(ix+ZXBlockSize) ; hl contains size of current block
                        add   hl,de
                        ld    de,5
                        add   hl,de
                        ld   (ix+ZXBlockSize),hl  ; Store the new size of the combined block
                        jr   ZXHeapCompactFree1
ZXHeapCompactFreeNext:      ld    DE,(ix+ZXBlockSize)
                        add   ix,de
                        LD    DE,5
                        add   ix,de
                        ld    hl,ix
                        sub   hl,bc
                        jr    nz,ZXHeapCompactFree1 ; If not at the end of the heap, continue
                        ret

                        
; --------------------------------------------------------
; heap walk. Displays the heap (Debug only)
; --------------------------------------------------------
ZXHeapWalk:         if DEBUG=1
                    PUSHA
                    ;CALL ZXFreeTempCompact

                    call saveScreen 
                    call runtimeCls
                    call ZXHeapWalkPrint
                    if DEBUGSAVESCREEN
                    call GetKey
                    call restoreScreen
                    endif 
                    POPA
                    endif
                    ret

ZXHeapWalkPrint:
                    if DEBUG=1
                    PUSHA
                    ld a,0
                    ld (charX),a
                    ld (charY),a
                    call printf
                    db    "----------- heap ----------/n"
                    db    "addr ty back back size/n",0
                    ld ix, (ZXHeapStart)
ZXHeapWalk1:       call ZXHeapWalkCls 
                   ld hl, ix
                    call printHex4Hl
                    ld   a,' '
                    call printA
                    ld   a,(ix+ZXBlockType)
                    call printHex2
                    ld   a,' '
                    call printA
                    ld   hl,(ix+ZXBLockBacklink)  
                    call printBacklinkHL                  
                    ;call printHex4Hl
                    ld   a,' '
                    call printA
                    ld   a,h
                    or   l
                    jr   z,ZXHeapWalk2
                    ld   bc,(HL)
                    call printHex4
                    jr   ZXHeapWalk3
ZXHeapWalk2:        ld   a,' '
                    call   printA                    
                    call   printA                    
                    call   printA                    
                    call   printA                    
ZXHeapWalk3:        ld   a,' '
                    call printA
                    ld   hl,(ix+ZXBlockSize)
                    call printDezHL
                    ld   a,(ix)
                    cp   ZXHeapTypeEmpty
                    jr   z,ZXHeapPrintContents3
                    ld   a,23
                    ld   (charX),a 

                    ld   hl,ix
                    ld   bc,5
                    add  hl,bc
                    ld   bc,(ix+ZXBlockSize)
                    ld   a,c
                    and  $7f
                    cp   0
                    jr   z,ZXHeapPrintContents3
                    cp   8
                    jr   c,ZXHeapPrintContents2
                    ld   a,8
ZXHeapPrintContents2:  
                    ld   bc,(hl)
                    ld   d,a
                    ld   a,b
                    or   c
                    jr  z,ZXHeapPrintContents3
                    ld  b,c
                    ld  a,d
                    inc  hl
                    inc  hl
                    cp   a
                    jr   nc,ZXHeapPrintContents                  
                    ld   b,a
ZXHeapPrintContents:ld     a,(hl)
                    inc    hl
                    cp     32
                    jr     nc, ZXHeapPrintContents4      
                    push   af
                    ld     a,'$'
                    call   printA
                    pop    af
                    call   printHex2
                    jr  ZXHeapPrintContents5
ZXHeapPrintContents4:                    
                    call   printA
ZXHeapPrintContents5:                                
                    djnz   ZXHeapPrintContents
ZXHeapPrintContents3:                    
                    call newline
                    call ZXHeapWalkCls
                    ld   hl,(ix+ZXBlockSize)
                    ld   bc,5
                    add  hl,bc
                    ld   bc,ix
                    add  hl,bc
                    ld   ix,hl
                    ld de,(ZXHeapEnd)
                    ld hl,ix
                    sub hl,de
                    jr  nc, ZXHeapWalk4
                    jr   z, ZXHeapWalk4
                    jp  ZXHeapWalk1
ZXHeapWalkCls:
                   ld   a,(charY)
                   cp   19
                   ret  c
ZXHeapWalkCls0:
                  call rtGetKey
                  cp   0
                  jr   nz, ZXHeapWalkCls0
ZXHeapWalkCls1:      call rtGetKey
                  cp   0
                  jr   z, ZXHeapWalkCls1               
                  ld   a,0
                  ld   (charX),a
                  ld   (charY),a
                  jp   runtimeCls
ZXHeapWalk4:        ld  hl,ix
                    call printHex4Hl
                    call newline                    
                    endif
                    POPA
                    ret
                  if DEBUG=1
printBacklinkHL:   push hl    
                   push ix
                   ld   de,hl
                   ld   hl,ZX_VARIABLES
printBackLinkLoop:
                   push hl
                   pop  ix                ; ix points to the start of the block                   
                   ld   a,(hl)                    
                   cp   0
                   jr   z,printBackLinkLoopNotFound
                   ld   c,a
                   ld   b,0
                   add  hl,bc
                   inc  hl
                   inc  hl
                   ld   c,(hl)            ; number of types
                   add  hl,bc         
                   inc  hl    ; skip type
                   push hl                ; hl now points to the variable
                   push de
                   ld   de,(hl)
                   ld   hl,de
                   pop  de
                   sub  hl,de             
                   jr   z,printBackLinkFound
                   pop  hl
                   inc  hl
                   inc  hl
                   jr   printBackLinkLoop
printBackLinkLoopNotFound:
                  pop  ix
                  pop hl
                  call printHex4Hl
                  ret
printBackLinkFound: POP HL
                  push ix
                  pop hl
                  ld c,(hl)
                  ld b,0
                  inc  hl
                  call rtDebugPrintFixString
                  pop ix
                  pop hl
                  ret   
                  endif               


ZXHeapTest:        if DEBUG=1 
                   call cls                
                   call ZXClearHeap
                   call ZXHeapWalk
                   ld  HL,$0
                   call ZXCheckIfHlisHeapBlock
                   ld  HL,$3000
                   call ZXCheckIfHlisHeapBlock
                   ld  HL,$fffe
                   call ZXCheckIfHlisHeapBlock
                   ld  hl,(ZXHeapStart)   
                   call ZXCheckIfHlisHeapBlock
                  ld hl,$f0f0
                   call ZXCheckIfHlisHeapBlock
                   ld   hl, TestString1
                   ld   de, ZXVariableAStr
                   ld   bc, TestString1Len
                   call ZXSaveString
                   ld   a,1
                   ld   bc,100
                   ld   hl,ZXHeapTestM1
                   call ZXAllocWithBacklink

                   ld   bc,30
                   ld   a,2
                   ld   hl,ZXHeapTestM2
                   call ZXAllocWithBacklink

                   ld   a,1
                   ld   bc,256
                   ld   hl,ZXHeapTestM3
                   call ZXAllocWithBacklink

                   call ZXHeapWalk
                   call GetKey
                   call cls

                   ld   hl,(ZXHeapTestM2)
                   call ZXFree
                   call ZXHeapWalk
                   ld   a,1
                   ld   bc,15
                   call ZXAlloc
                   ld   a,1
                   ld   bc,4
                   call ZXAlloc
                   call restoreScreen
                   call ZXHeapWalk
                   call GetKey
                   endif
                   ret

                   if DEBUG=1
saveScreen:       if DEBUGSAVESCREEN=1
                  push hl
                  push de
                  push bc
                  call GetKey
                  ld  de,saveSreenData
                  ld  hl,$4000
                  ld  bc,6144+768
                  ldir
                  call cls
                  pop  bc
                  pop  de
                  pop hl
                  endif
                  ret
restoreScreen:   if DEBUGSAVESCREEN=1
                  push hl
                  push de
                  push bc
                  ld  hl,saveSreenData
                  ld  de,$4000
                  ld  bc,6144+768
                  ldir
                  pop  bc
                  pop  de
                  pop hl
                  endif              
                  ret

saveSreenData:    if DEBUGSAVESCREEN=1
                  defs 6144+768
                  endif
                  endif

ZXHeapTestM1:      dw 0                   
ZXHeapTestM2:      dw 0                   
ZXHeapTestM3:      dw 0   
ZXVariableAStr:    dw 0
TestString1:      db 'Hallo Welt'
TestString1Len:   equ 10




; --------------------------------------------------------
; We "delete" all memory blocks by creating a single heap
; entry which contains the whole memory size
; --------------------------------------------------------
ZXClearHeap:         push   ix
                     push   hl
                     push   de
                     ld ix,(ZXHeapStart)
                     ld de,ix
                     ld hl,(ZXHeapEnd)
                     sub  hl,de
                     ld   de,5
                     sub  hl,de
                     ld   (ix+ZXBlockType),ZXHeapTypeEmpty ; Mark as empty
                     ld   (ix+ZXBlockSize),hl
                     ld   (ix+ZXBLockBacklink),0
                     pop  de
                     pop  hl
                     pop  ix
                     ret

; --------------------------------------------------------
; Allocate memory
; BC = Number of Bytes
; A  = Type of Block
; Returns: HL = Memory block
; A = 0 : Failed
; A = 1 : OK
; --------------------------------------------------------

zxAllocSize:             dw 0
ZXAlloc:                push ix
                        push bc
                        push de
                        push af
                        ld   (zxAllocSize),bc
                        
;                        CALL ZXFreeTempCompact
                        pop af
                        pop de
                        pop bc
                        pop ix
                        push ix
                        push bc
                        push de                        
                        ld (ZXHeapNewType),a
                        ld (ZXHeapTempNumOfByts),bc
                        ld ix,(ZXHeapStart)
                        ld hl,5                 ; in order to divde a block in two
                        add hl,bc               ; we need 5 additonal bytes, so look
                        ld  bc,hl               ; a block 5 bytes bigger
ZXAllocLoop1:           ld de,(ZXHeapEnd)
                        ld hl,ix
                        sub hl,de
                        jp  nc,ZXAllocNotFound   ; we moved past the end of the known heap, return with error
                        jp  z,ZXAllocNotFound
                        ld de,(ix+ZXBlockSize)    
                        ld A,(ix)
                        cp 0
                        jp nz, ZXAllocLoopNextBlock
                        ld HL,de
                        sub hl,bc
                        jp  c,ZXAllocLoopNextBlock ; block too small

; we found a heap block with the size that fits, de is the block size of the free entry
; bc is the blocksize we want to allocate + 5
                        push bc
                        ld   hl,bc                      ; The block size is bc - 5
                        ld   bc,5
                        sub  hl,bc
                        ld   a,(ZXHeapNewType)
                        ld   (ix+ZXBlockType),A         ; Mark as empty
                        ld   (ix+ZXBlockSize),hl        ; Store block size
                        ld   (ZXHeapResult),ix          ; Store the result (we must add 5 to point to the memory)
                        pop  bc
                        add  ix,bc                      ; ix now points to the next block
                        ld   (ix+ZXBlockType),0         ; Mark as empty
                        ld   (ix+ZXBLockBacklink),0     ; No back link for this empty block
                        ld   hl,de                      ; the original free block size
                        sub  hl,bc                      ; subtract required size + 5
                        ld   (ix+ZXBlockSize),hl        ; store block size

                        ld   hl,(ZXHeapResult)
                        ld   bc,5
                        add  hl,bc
                        ld   a,0
                        pop  de
                        pop  bc
                        pop ix
                        ret
; A = Block type
; BC = Block Size
; HL = Pointer to Variable
ZXAllocWithBacklink:    push  hl
                        call ZXAlloc                           ; HL points to the new memory
                        cp   0                                 ; if a = 0
                        jr   z, ZXAllocWithBacklink2
                        call ZXGarbage2                        ; If no memory left, try garbage collection
                        call ZXAlloc                           ; and allocate again
                        cp   0
                        jr   z,ZXAllocWithBacklink2
                        pop hl                                 ; return with error
                        ret
ZXAllocWithBacklink2:   pop  de
                        push de
                        push hl                                ; HL = newly created memory
                        ld   bc,5                              ; sub 5 -> go to header
                        sub  hl,bc
                        ld   bc,ZXBLockBacklink                ; go to backlink address
                        add  hl,bc
                        ld   (hl),de
                        pop de
                        pop  hl
                        ld   (hl),de
                        ret 

; hl = String
; bc = Length of String
; de = Variable
ZXSaveString:          push hl
                        push bc
                        ex   de,hl
                        push hl
                        call ZXAllocWithBacklink
                        pop hl
                        pop  bc
                        ld   de,(hl)
                        pop  hl
                        ldir 
                        ret






ZXAllocLoopNextBlock:   add ix,de
                        ld DE,5
                        add ix,de
                        jp  ZXAllocLoop1

ZXCheckIfHlisHeapBlock:
                        push de
                        push hl
                        ex   hl,de
                        ld   hl,(ZXHeapStart)
                        sub  hl,de
                        jr  z,ZXIsHeapBlock
                        jr  nc,ZXNotHeapBlock              ; If hl is negative, we are not in the heap
                        ld  hl,(ZXHeapEnd)
                        sub hl,de
                        jr  z,ZXIsHeapBlock
                        jr  c,ZXNotHeapBlock            
ZXIsHeapBlock:
                        ld  a,1
                        cp 0
                        pop hl
                        pop de  ; If hl is negative, we are not in the heap
                        ret                                   ; Otherwise return with z reset                        
ZXNotHeapBlock:         ld   a,0
                        cp   0
                        pop  hl
                        pop  de
                        ret
ZXFreeStringVar:        push hl
                        push de
                        ld   de,(hl)
                        ld   hl,de
                        ld   a,h
                        or   l
                        jr   z,ZXFreeStringVar1
                        call ZXFree
ZXFreeStringVar1:                        
                        pop  de
                        pop  hl
                        ret                        
ZXFree:                
                         call ZXCheckIfHlisHeapBlock
                        ret  z
                        push bc
                        ld   bc,5                       ; Subtract block size
                        sub  hl,bc
                        ld   (hl),0                     ; Mark block as free
                        ld   bc,ZXBLockBacklink
                        add  hl,bc
                        ld   bc,0
                        ld   (hl),bc                    ; clear backlink
                        pop bc                        
                        ret

; HL points to a memory block. If the block is in the heap, set the type to used
; HL = Address in Heap (or not in heap, than we do nothing)
; DE = Address of Variable (Backlink)
ZXClaim:                call ZXCheckIfHlisHeapBlock
                        ret  z
                        push hl
                        push de
                        push bc
                        ld  bc,ZXHeapHeaderSize
                        sub  hl,bc
                        ld   (hl),ZXHeapTypeUsed ; Mark as used
                        inc  hl 
                        ld   (hl),de            ; Store backlink
              
                        pop  bc
                        pop  de
                        pop  hl
                        ret
; We did not find any memory block with the required size (or did not find any block at all)
; now create a new block at the end of the memory.
ZXAllocNotFound:        if DEBUG=1
                        call runtimeCls
;                        call ZXHeapWalk
                        endif
                        
                        ld   hl,error_no_heap
                        call runtimePrintString
                        ld   hl,(zxAllocSize)
                        call runtimePrintInt
                        ld  hl,0
                        call runtimePause
                        call ZXHeapWalk
ZXAllocNotFoundEndless: jr ZXAllocNotFoundEndless                                               
                        ld   sp,(runtimeSaveSP)
                        ret
                        ld   hl,0
                        ld   a,$ff

                        pop  de
                        pop  bc
                        pop ix
                        ret
;------------------------------------------------------------
; Garbage Collector für ZX Spectrum Heap
;------------------------------------------------------------
; Header pro Block:
;   +0: Typ (1 Byte)
;   +1: Backlink Low
;   +2: Backlink High
;   +3: Größe Low   (nur Nutzdaten)
;   +4: Größe High
;------------------------------------------------------------

ZXGarbageCollect:
    LD   HL,(ZXHeapStart)        ; HL = Ziel (kompakte Front)

GC_Scan:
    LD   IX,HL                   ; IX = Scanquelle

GC_FindBlock:
    ; Ende erreicht?
    LD   DE,(ZXHeapEnd)
    OR   A
    SBC  HL,DE
    JP   NC,GC_FillEmpty         ; HL >= ZXHeapEnd -> fertig
    ADD  HL,DE

    ; Typ des aktuellen Blocks lesen
    LD   A,(IX+0)
    CP   ZXHeapTypeEmpty
    JR   Z,GC_SkipEmpty
    CP   ZXHeapTypeTemp
    JR   Z,GC_KeepTemp
    JR   GC_MoveUsed             ; Typ 1 -> verschieben

;------------------------------------------------------------
; Leeren Block überspringen (Typ 0)
;------------------------------------------------------------
GC_SkipEmpty:
    ; Größe lesen
    LD   E,(IX+3)
    LD   D,(IX+4)
    LD   BC,5
    ADD  DE,BC
    ADD  IX,DE                   ; IX = nächster Block
    JR   GC_FindBlock

;------------------------------------------------------------
; Temporären Block (Typ 2) unverändert belassen
;------------------------------------------------------------
GC_KeepTemp:
    ; Wenn IX != HL, dann bis zu diesem Block mit Leerblock auffüllen
    LD   A,IXH
    CP   H
    LD   A,IXL
    SBC  A,L
    JR   Z,GC_TempInPlace

    ; Lücke zwischen HL und IX als leer markieren
    LD   A,ZXHeapTypeEmpty
    LD   (HL),A
    push hl
    inc  hl
    inc  hl
    inc  hl
    push af
    xor  a,a
    LD   (HL),a
    inc  hl
    LD   (HL),a
    pop af
    pop  hl

GC_TempInPlace:
    ; HL auf Ende des Temp-Blocks setzen
    LD   E,(IX+3)
    LD   D,(IX+4)
    LD   BC,5
    ADD  DE,BC
    ADD  HL,DE
    ADD  IX,DE
    JR   GC_FindBlock

;------------------------------------------------------------
; Benutzten Block verschieben (Typ 1)
;------------------------------------------------------------
GC_MoveUsed:
    ; Größe lesen
    LD   E,(IX+3)
    LD   D,(IX+4)
    LD   BC,5
    ADD  DE,BC                  ; DE = Blockgröße inkl. Header

    ; Wenn IX == HL -> Block schon richtig
    LD   A,IXH
    CP   H
    LD   A,IXL
    SBC  A,L
    JR   Z,GC_BlockInPlace

    ; Block verschieben: DE Bytes von IX -> HL kopieren
    PUSH DE
GC_CopyLoop:
    LD   A,(IX)
    LD   (HL),A
    INC  IX
    INC  HL
    DEC  DE
    LD   A,D
    OR   E
    JR   NZ,GC_CopyLoop
    POP  DE

    ; HL zurück zum Start des verschobenen Blocks (HL - Größe)
    SBC  HL,DE

    ; Backlink aktualisieren
    push hl
    inc  hl
    LD   E,(HL)
    inc  hl
    LD   D,(HL)
    pop  hl
    ld   a,l
    LD   (DE),a
    inc  de
    ld  a,h
    LD   (DE),a
    dec  de

    ; HL ans Ende setzen
    ADD  HL,DE
    JR   GC_AfterBlock

GC_BlockInPlace:
    ; Block steht schon richtig: HL einfach ans Ende setzen
    ADD  HL,DE

GC_AfterBlock:
    ; IX ebenfalls ans Ende setzen
    ADD  IX,DE
    JP   GC_FindBlock

;------------------------------------------------------------
; Rest leer machen
;------------------------------------------------------------
GC_FillEmpty:
    LD   A,ZXHeapTypeEmpty
    LD   (HL),A
    push hl
    inc hl
    inc hl
    inc hl
    xor a,a
    LD   (HL),a
    inc hl
    LD   (HL),a
    pop hl
    RET

                   
error_no_heap:          dw error_no_heap1-$-2
                        db "No memory left in heap alloc size="
error_no_heap1          equ $                        


ZXGarbage2:             ret



      DISPLAY "Heap Size =",/D, $-HEAPSTART, " bytes"



