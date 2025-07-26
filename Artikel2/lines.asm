NumVars EQU 9

   CALL AllocateVars

Line1000:                              ; GO SUB 3700
Line1000_1:                            ; LET x=1
   LD   DE,256
   CALL StackShortInt                  ; Stack Signed Word (1)

   LD   DE,(Var_x)                     ; Address the var in VARS area
   CALL UpdateNumVar


Line1000_2:                            ; LET y=21
   LD   DE,5376
   CALL StackShortInt                  ; Stack Signed Word (21)

   LD   DE,(Var_y)                     ; Address the var in VARS area
   CALL UpdateNumVar


Line1000_3:                            ; LET dx=1
   LD   DE,256
   CALL StackShortInt                  ; Stack Signed Word (1)

   LD   DE,(Var_dx)                    ; Address the var in VARS area
   CALL UpdateNumVar


Line1000_4:                            ; LET dy=1
   LD   DE,256
   CALL StackShortInt                  ; Stack Signed Word (1)

   LD   DE,(Var_dy)                    ; Address the var in VARS area
   CALL UpdateNumVar


Line1005:                              ; FOR i=1 TO 5000
   LD   DE,256                         ; STEP not present - assume 1.
   CALL StackShortInt

   LD   A,0
   LD   DE,34816
   LD   BC,19
   CALL $2AB6                          ; [ROM] STACK-STORE (5000)

   LD   DE,256
   CALL StackShortInt                  ; Stack Signed Word (1)

   LD   DE,(Var_i)                     ; Address the var in VARS area
   LD   BC,Line1010                    ; Store the address of the next line
   CALL UpdateFORVar


Line1010:                              ; PLOT OVER 1; INK 3;x,y
Line1020:                              ; LET x=x+dx
   LD   HL,(Var_x)                     ; Address the var in VARS area
   CALL StackNumericVar

   LD   HL,(Var_dx)                    ; Address the var in VARS area
   CALL StackNumericVar

   CALL GetTwoStackedNumbers
   CALL $3014                          ; [ROM] Call the Addition routine.
   CALL ReclaimStackItem

   LD   DE,(Var_x)                     ; Address the var in VARS area
   CALL UpdateNumVar


Line1030:                              ; LET y=y+dy
   LD   HL,(Var_y)                     ; Address the var in VARS area
   CALL StackNumericVar

   LD   HL,(Var_dy)                    ; Address the var in VARS area
   CALL StackNumericVar

   CALL GetTwoStackedNumbers
   CALL $3014                          ; [ROM] Call the Addition routine.
   CALL ReclaimStackItem

   LD   DE,(Var_y)                     ; Address the var in VARS area
   CALL UpdateNumVar


Line1040:                              ; IF x<=1 OR x>=250 THEN LET dx=0-dx
   LD   DE,0
   CALL StackShortInt                  ; Stack Signed Word (0)

   LD   HL,(Var_dx)                    ; Address the var in VARS area
   CALL StackNumericVar

   CALL GetTwoStackedNumbers
   CALL $300F                          ; [ROM] Call the Subtraction routine.
   CALL ReclaimStackItem

   LD   DE,(Var_dx)                    ; Address the var in VARS area
   CALL UpdateNumVar


Line1050:                              ; IF y<=20 OR y>=160 THEN LET dy=0-dy
   LD   DE,0
   CALL StackShortInt                  ; Stack Signed Word (0)

   LD   HL,(Var_dy)                    ; Address the var in VARS area
   CALL StackNumericVar

   CALL GetTwoStackedNumbers
   CALL $300F                          ; [ROM] Call the Subtraction routine.
   CALL ReclaimStackItem

   LD   DE,(Var_dy)                    ; Address the var in VARS area
   CALL UpdateNumVar


Line1060:                              ; NEXT i
   LD   HL,(Var_i)                     ; Address the var in VARS area
   CALL DoNext                         ; And sort out the loop where necessary.


Line1070:                              ; LET ticks=PEEK 23672+PEEK 23673*256
   LD   A,0
   LD   DE,30720
   LD   BC,92
   CALL $2AB6                          ; [ROM] STACK-STORE (23672)

   CALL $1E99                          ; [ROM] puts address of next stacked integer in BC.
   LD   A,(BC)                         ; load contents into A register.
   LD   D,A
   LD   E,0
   CALL StackShortInt

   LD   A,0
   LD   DE,30976
   LD   BC,92
   CALL $2AB6                          ; [ROM] STACK-STORE (23673)

   CALL $1E99                          ; [ROM] puts address of next stacked integer in BC.
   LD   A,(BC)                         ; load contents into A register.
   LD   D,A
   LD   E,0
   CALL StackShortInt

   LD   A,0
   LD   DE,0
   LD   BC,1
   CALL $2AB6                          ; [ROM] STACK-STORE (256)

   CALL GetTwoStackedNumbers
   CALL $30CA                          ; [ROM] Call the Multiplication routine.
   CALL ReclaimStackItem

   CALL GetTwoStackedNumbers
   CALL $3014                          ; [ROM] Call the Addition routine.
   CALL ReclaimStackItem

   LD   DE,(Var_ticks)                 ; Address the var in VARS area
   CALL UpdateNumVar


Line1070_1:                            ; LET tsec=INT (ticks/50)
   LD   HL,(Var_ticks)                 ; Address the var in VARS area
   CALL StackNumericVar

   LD   DE,12800
   CALL StackShortInt                  ; Stack Signed Word (50)

   CALL GetTwoStackedNumbers
   CALL $31AF                          ; [ROM] Call the Division routine.
   CALL ReclaimStackItem

   CALL GetStackedNumber
   CALL $36AF                          ; [ROM] Call the INT routine.

   LD   DE,(Var_tsec)                  ; Address the var in VARS area
   CALL UpdateNumVar


Line1070_2:                            ; LET min=INT (tsec/60)
   LD   HL,(Var_tsec)                  ; Address the var in VARS area
   CALL StackNumericVar

   LD   DE,15360
   CALL StackShortInt                  ; Stack Signed Word (60)

   CALL GetTwoStackedNumbers
   CALL $31AF                          ; [ROM] Call the Division routine.
   CALL ReclaimStackItem

   CALL GetStackedNumber
   CALL $36AF                          ; [ROM] Call the INT routine.

   LD   DE,(Var_min)                   ; Address the var in VARS area
   CALL UpdateNumVar


Line1070_3:                            ; LET sec=tsec-min*60
   LD   HL,(Var_tsec)                  ; Address the var in VARS area
   CALL StackNumericVar

   LD   HL,(Var_min)                   ; Address the var in VARS area
   CALL StackNumericVar

   LD   DE,15360
   CALL StackShortInt                  ; Stack Signed Word (60)

   CALL GetTwoStackedNumbers
   CALL $30CA                          ; [ROM] Call the Multiplication routine.
   CALL ReclaimStackItem

   CALL GetTwoStackedNumbers
   CALL $300F                          ; [ROM] Call the Subtraction routine.
   CALL ReclaimStackItem

   LD   DE,(Var_sec)                   ; Address the var in VARS area
   CALL UpdateNumVar


Line1080:                              ; PRINT AT 21,0;ticks;" ticks ";min;":";sec;" Press a key";
Line1090:                              ; PAUSE 0
   LD   DE,0
   CALL StackShortInt                  ; Stack Signed Word (0)

   CALL $1F3A                          ; [ROM] PAUSE Command


Line1100:                              ; RETURN
Line3700:                              ; POKE 23672,0
   LD   A,0
   LD   DE,30720
   LD   BC,92
   CALL $2AB6                          ; [ROM] STACK-STORE (23672)

   LD   DE,0
   CALL StackShortInt                  ; Stack Signed Word (0)

   CALL $1E80                          ; [ROM] POKE Command


Line3700_1:                            ; POKE 23673,0
   LD   A,0
   LD   DE,30976
   LD   BC,92
   CALL $2AB6                          ; [ROM] STACK-STORE (23673)

   LD   DE,0
   CALL StackShortInt                  ; Stack Signed Word (0)

   CALL $1E80                          ; [ROM] POKE Command


Line3700_2:                            ; POKE 23674,0
   LD   A,0
   LD   DE,31232
   LD   BC,92
   CALL $2AB6                          ; [ROM] STACK-STORE (23674)

   LD   DE,0
   CALL StackShortInt                  ; Stack Signed Word (0)

   CALL $1E80                          ; [ROM] POKE Command


Line3700_3:                            ; RETURN
   RET                                 ; END OF PROGRAM

DoNext:
   LD      ($5C68),HL                  ; Set MEM to point to the three 5-byte values
                                       ; value, limit, step.
   RST  28H                            ;; FP-CALC      add step and re-store
   DEFB $E0                            ;; get-mem-0    v.
   DEFB $E2                            ;; get-mem-2    v,s.
   DEFB $0F                            ;; addition     v+s.
   DEFB $C0                            ;; st-mem-0     v+s.
   DEFB $02                            ;; delete       .
   DEFB $38                            ;; end-calc

   CALL $1DDA                          ; [ROM] routine NEXT-LOOP tests against limit.
   RET  C                              ; return if no more iterations possible.

   LD   HL,($5C68)                     ; find start of variable contents from MEM.
   LD   DE,$F                          ; add 3*5 to
   ADD  HL,DE                          ; address the looping address
   LD   E,(HL)
   INC  HL
   LD   D,(HL)
   EX   DE,HL
   JP   (HL)                           ; and go there

UpdateFORVar:
   PUSH BC
   CALL UpdateNumVar                   ; UnStack the STEP
   CALL UpdateNumVar                   ; and the LIMIT
   CALL UpdateNumVar                   ; and the START, or CURRENT Value
   POP  BC
   EX   DE,HL
   LD   (HL),C                         ; so now just store the address
   INC  HL                             ; of the line to jump to when we loop
   LD   (HL),B
   RET

StackNumericVar:
   LD   A,(HL)
   INC  HL
   LD   E,(HL)
   INC  HL
   LD   D,(HL)
   INC  HL
   LD   C,(HL)
   INC  HL
   LD   B,(HL)
   CALL $2AB6                          ; [ROM] STACK-STORE (Variable)
   RET

UpdateNumVar:
   LD   HL,($5C65)                     ; Address STKEND
   LD   BC,$FFFB                       ; Prepare to step back 5 bytes
   ADD  HL,BC                          ; Address the last item on the stack
   LDI                                 ; Copy 5 bytes
   LDI
   LDI
   LDI
   LDI
   CALL ReclaimStackItem
   RET

GetStackedNumber:
   LD   HL,($5C65)                     ; HL = STKEND
   LD   BC,$FFFB                       ; Numbers are (-)5 Bytes
   ADD  HL,BC                          ; (HL) = Last Number
   RET

GetTwoStackedNumbers:
   LD   HL,($5C65)                     ; HL = STKEND
   LD   BC,$FFFB                       ; Numbers are (-)5 Bytes
   ADD  HL,BC                          ; (HL) = Last Number
   LD   D,H
   LD   E,L                            ; (DE) = Last Number
   ADD  HL,BC                          ; (HL) = First Number
   RET

ReclaimStackItem:
   LD   HL,($5C65)                     ; Address STKEND
   LD   BC,$FFFB                       ; Prepare to reclaim 5 Bytes
   ADD  HL,BC                          ; Move (HL) Back 5 bytes to reclaim old value
   LD   ($5C65),HL                     ; Update STKEND to reflect the change
   RET

StackShortInt:
   XOR  A
   LD   B,A
   LD   C,A
   CALL $2AB6                          ; [ROM] STACK-STORE
   RET

AllocateVars:
   LD   BC,($5CB2)
   LD   DE,($5C4B)
   LD   HL,($5C59)
   DEC  HL
   CALL $19E5                          ; Clear any current variables

   LD   IX,Var_x                       ; set IX up to point at the jump table
   LD   BC,88                          ; Allocate space for Variables
   LD   HL,($5C59)                     ; fetch E_LINE to HL.
   DEC  HL                             ; point to location before, the variables
                                       ; end-marker.
   CALL $1655                          ; routine MAKE-ROOM creates BC spaces
                                       ; for name and numeric value.
   INC  HL                             ; advance to first new location.

   EX   DE,HL                          ; set DE=Start of space in VARS area
   LD   HL,VarNames                    ; set HL to the first var in the table
   LD   A,NumVars
VarLoop:
   LD   C,(HL)
   INC  HL
   LD   B,(HL)                         ; BC now holds the length of the vars data
   INC  HL
   PUSH BC                             ; preserve length of vars data
   LD   C,(HL)
   INC  HL
   LD   B,(HL)                         ; BC now holds the length of the var name
   INC  HL                             ; HL now points to the var name
   LDIR                                ; Copy var name to VARS area,
                                       ; advancing DE to point to the vars value and,
                                       ; advancing HL to point to the Filler Bytes (0s) in "VarNames" table
   LD   (IX+0),E                       ; Store pointer to vars value in jump table
   LD   (IX+1),D
   INC   IX
   INC   IX
   POP   BC                            ; BC = length of vars data (from "VarNames")
   LDIR                                ; Copy the filler bytes.
                                       ; DE now points to the next var,
                                       ; HL points to the next var in "VarNames" table
   DEC  A
   JR   NZ,VarLoop
   RET

VarNames:                              ; Here follows the Variable Names Table

   DEFB 5,0,1,0
   DEFB 120                            ; x
   DEFB 0,0,0,0,0                      ; Initial filler bytes
   DEFB 5,0,1,0
   DEFB 121                            ; y
   DEFB 0,0,0,0,0                      ; Initial filler bytes
   DEFB 5,0,2,0
   DEFB 164,"x"+$80                    ; dx
   DEFB 0,0,0,0,0                      ; Initial filler bytes
   DEFB 5,0,2,0
   DEFB 164,"y"+$80                    ; dy
   DEFB 0,0,0,0,0                      ; Initial filler bytes
   DEFB 18,0,1,0
   DEFB 105                            ; i
   DEFB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Initial filler bytes
   DEFB 5,0,5,0
   DEFB 180,"ick","s"+$80              ; ticks
   DEFB 0,0,0,0,0                      ; Initial filler bytes
   DEFB 5,0,4,0
   DEFB 180,"se","c"+$80               ; tsec
   DEFB 0,0,0,0,0                      ; Initial filler bytes
   DEFB 5,0,3,0
   DEFB 173,"i","n"+$80                ; min
   DEFB 0,0,0,0,0                      ; Initial filler bytes
   DEFB 5,0,3,0
   DEFB 179,"e","c"+$80                ; sec
   DEFB 0,0,0,0,0                      ; Initial filler bytes

                                       ; Here follows the Variables jump table
Var_x:
   DEFB 0,0
Var_y:
   DEFB 0,0
Var_dx:
   DEFB 0,0
Var_dy:
   DEFB 0,0
Var_i:
   DEFB 0,0
Var_ticks:
   DEFB 0,0
Var_tsec:
   DEFB 0,0
Var_min:
   DEFB 0,0
Var_sec:
   DEFB 0,0
EndOfVars:
   DEFB 255,255

                                       ; String Constants Follow

String0:
   DEFB 7,0," ticks "
String1:
   DEFB 1,0,":"
String2:
   DEFB 12,0," Press a key"
