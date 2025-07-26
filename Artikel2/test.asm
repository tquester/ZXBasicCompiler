NumVars EQU 51

   CALL AllocateVars

Line1:                                 ; DEF FN t(a,b)=a+b
Line1_1:                               ; DEF FN u(a,b)=FN t(a,a)+FN t(b,b)
Line10:                                ; REM floatsecf1ff1f2f3
Line15:                                ; REM floatafbfcfdf
Line16:                                ; REM int16aibicidi
Line17:                                ; LET af=123.4
   LD   A,135
   LD   DE,52342
   LD   BC,52684
   CALL $2AB6                          ; [ROM] STACK-STORE (123.4)

   LD   DE,(Var_af)                    ; Address the var in VARS area
   CALL UpdateNumVar


Line17_1:                              ; LET bf=3.14
   LD   A,130
   LD   DE,62792
   LD   BC,36802
   CALL $2AB6                          ; [ROM] STACK-STORE (3.14)

   LD   DE,(Var_bf)                    ; Address the var in VARS area
   CALL UpdateNumVar


Line17_2:                              ; LET cf=5.0
   LD   DE,1280
   CALL StackShortInt                  ; Stack Signed Word (5)

   LD   DE,(Var_cf)                    ; Address the var in VARS area
   CALL UpdateNumVar


Line18:                                ; LET ai=123
   LD   DE,31488
   CALL StackShortInt                  ; Stack Signed Word (123)

   LD   DE,(Var_ai)                    ; Address the var in VARS area
   CALL UpdateNumVar


Line18_1:                              ; LET bi=3
   LD   DE,768
   CALL StackShortInt                  ; Stack Signed Word (3)

   LD   DE,(Var_bi)                    ; Address the var in VARS area
   CALL UpdateNumVar


Line18_2:                              ; LET ci=5
   LD   DE,1280
   CALL StackShortInt                  ; Stack Signed Word (5)

   LD   DE,(Var_ci)                    ; Address the var in VARS area
   CALL UpdateNumVar


Line19:                                ; LET df=af+bf*cf
   LD   HL,(Var_af)                    ; Address the var in VARS area
   CALL StackNumericVar

   LD   HL,(Var_bf)                    ; Address the var in VARS area
   CALL StackNumericVar

   LD   HL,(Var_cf)                    ; Address the var in VARS area
   CALL StackNumericVar

   CALL GetTwoStackedNumbers
   CALL $30CA                          ; [ROM] Call the Multiplication routine.
   CALL ReclaimStackItem

   CALL GetTwoStackedNumbers
   CALL $3014                          ; [ROM] Call the Addition routine.
   CALL ReclaimStackItem

   LD   DE,(Var_df)                    ; Address the var in VARS area
   CALL UpdateNumVar


Line20:                                ; LET di=ai+bi*ci
   LD   HL,(Var_ai)                    ; Address the var in VARS area
   CALL StackNumericVar

   LD   HL,(Var_bi)                    ; Address the var in VARS area
   CALL StackNumericVar

   LD   HL,(Var_ci)                    ; Address the var in VARS area
   CALL StackNumericVar

   CALL GetTwoStackedNumbers
   CALL $30CA                          ; [ROM] Call the Multiplication routine.
   CALL ReclaimStackItem

   CALL GetTwoStackedNumbers
   CALL $3014                          ; [ROM] Call the Addition routine.
   CALL ReclaimStackItem

   LD   DE,(Var_di)                    ; Address the var in VARS area
   CALL UpdateNumVar


Line30:                                ; LET df=af*af+bf*bf/cf
   LD   HL,(Var_af)                    ; Address the var in VARS area
   CALL StackNumericVar

   LD   HL,(Var_af)                    ; Address the var in VARS area
   CALL StackNumericVar

   CALL GetTwoStackedNumbers
   CALL $30CA                          ; [ROM] Call the Multiplication routine.
   CALL ReclaimStackItem

   LD   HL,(Var_bf)                    ; Address the var in VARS area
   CALL StackNumericVar

   LD   HL,(Var_bf)                    ; Address the var in VARS area
   CALL StackNumericVar

   LD   HL,(Var_cf)                    ; Address the var in VARS area
   CALL StackNumericVar

   CALL GetTwoStackedNumbers
   CALL $31AF                          ; [ROM] Call the Division routine.
   CALL ReclaimStackItem

   CALL GetTwoStackedNumbers
   CALL $30CA                          ; [ROM] Call the Multiplication routine.
   CALL ReclaimStackItem

   CALL GetTwoStackedNumbers
   CALL $3014                          ; [ROM] Call the Addition routine.
   CALL ReclaimStackItem

   LD   DE,(Var_df)                    ; Address the var in VARS area
   CALL UpdateNumVar


Line31:                                ; LET di=ai*ai+bi*bi/ci
   LD   HL,(Var_ai)                    ; Address the var in VARS area
   CALL StackNumericVar

   LD   HL,(Var_ai)                    ; Address the var in VARS area
   CALL StackNumericVar

   CALL GetTwoStackedNumbers
   CALL $30CA                          ; [ROM] Call the Multiplication routine.
   CALL ReclaimStackItem

   LD   HL,(Var_bi)                    ; Address the var in VARS area
   CALL StackNumericVar

   LD   HL,(Var_bi)                    ; Address the var in VARS area
   CALL StackNumericVar

   LD   HL,(Var_ci)                    ; Address the var in VARS area
   CALL StackNumericVar

   CALL GetTwoStackedNumbers
   CALL $31AF                          ; [ROM] Call the Division routine.
   CALL ReclaimStackItem

   CALL GetTwoStackedNumbers
   CALL $30CA                          ; [ROM] Call the Multiplication routine.
   CALL ReclaimStackItem

   CALL GetTwoStackedNumbers
   CALL $3014                          ; [ROM] Call the Addition routine.
   CALL ReclaimStackItem

   LD   DE,(Var_di)                    ; Address the var in VARS area
   CALL UpdateNumVar


Line100:                               ; PAPER 6
Line100_1:                             ; INK 1
Line105:                               ; CLS
Line106:                               ; GO TO 3300
   JP Line228

Line110:                               ; LET a$="1234"
   LD   HL,String0
   CALL StackStringVar                 ; Stack String Const ("1234")

   LD   DE,(Var_a_str)                 ; Address the var in VARS area
   LD   BC,Var_a_str
   PUSH BC
   CALL UpdateStrVar


Line120:                               ; PRINT a$(1 TO 2)
Line130:                               ; DIM b$(10)
   LD   HL,(Var_b_str)                 ; Address the var in VARS area
   CALL StackStringVar

   LD   DE,2560
   CALL StackShortInt                  ; Stack Signed Word (10)

   CALL PerformDIM


Line135:                               ; LET b$(1)="Hallo"
   LD   DE,256
   CALL StackShortInt                  ; Stack Signed Word (1)

   LD   DE,(Var_b_str)                 ; Address the var in VARS area
   LD   BC,Var_b_str
   PUSH BC
   CALL UpdateStrVar


Line140:                               ; PRINT b$(1)(2 TO )(1 TO )
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


Line1070:                              ; GO TO 3710
   JP Line126

Line1100:                              ; GO SUB 3700
Line1120:                              ; FOR i=0 TO 255 STEP 3
   LD   DE,768
   CALL StackShortInt                  ; Stack Signed Word (3)

   LD   DE,65280
   CALL StackShortInt                  ; Stack Signed Word (255)

   LD   DE,0
   CALL StackShortInt                  ; Stack Signed Word (0)

   LD   DE,(Var_i)                     ; Address the var in VARS area
   LD   BC,Line1130                    ; Store the address of the next line
   CALL UpdateFORVar


Line1130:                              ; PLOT INK 1;i,0
Line1140:                              ; DRAW INK 1;255-i,170
Line1150:                              ; NEXT i
   LD   HL,(Var_i)                     ; Address the var in VARS area
   CALL DoNext                         ; And sort out the loop where necessary.


Line1155:                              ; RETURN
Line1160:                              ; FOR i=1 TO 170 STEP 3
   LD   DE,768
   CALL StackShortInt                  ; Stack Signed Word (3)

   LD   DE,43520
   CALL StackShortInt                  ; Stack Signed Word (170)

   LD   DE,256
   CALL StackShortInt                  ; Stack Signed Word (1)

   LD   DE,(Var_i)                     ; Address the var in VARS area
   LD   BC,Line1170                    ; Store the address of the next line
   CALL UpdateFORVar


Line1170:                              ; PLOT INK 2;0,i
Line1180:                              ; DRAW INK 2;255,170-i
Line1190:                              ; NEXT i
   LD   HL,(Var_i)                     ; Address the var in VARS area
   CALL DoNext                         ; And sort out the loop where necessary.


Line1195:                              ; RETURN
Line1200:                              ; REM scrollleft
Line1210:                              ; LET adr=16384
   LD   A,0
   LD   DE,0
   LD   BC,64
   CALL $2AB6                          ; [ROM] STACK-STORE (16384)

   LD   DE,(Var_adr)                   ; Address the var in VARS area
   CALL UpdateNumVar


Line1220:                              ; FOR l=1 TO 192
   LD   DE,256                         ; STEP not present - assume 1.
   CALL StackShortInt

   LD   DE,49152
   CALL StackShortInt                  ; Stack Signed Word (192)

   LD   DE,256
   CALL StackShortInt                  ; Stack Signed Word (1)

   LD   DE,(Var_l)                     ; Address the var in VARS area
   LD   BC,Line1225                    ; Store the address of the next line
   CALL UpdateFORVar


Line1225:                              ; LET adrl=adr
   LD   HL,(Var_adr)                   ; Address the var in VARS area
   CALL StackNumericVar

   LD   DE,(Var_adrl)                  ; Address the var in VARS area
   CALL UpdateNumVar


Line1230:                              ; FOR p=0 TO 30
   LD   DE,256                         ; STEP not present - assume 1.
   CALL StackShortInt

   LD   DE,7680
   CALL StackShortInt                  ; Stack Signed Word (30)

   LD   DE,0
   CALL StackShortInt                  ; Stack Signed Word (0)

   LD   DE,(Var_p)                     ; Address the var in VARS area
   LD   BC,Line1240                    ; Store the address of the next line
   CALL UpdateFORVar


Line1240:                              ; POKE adrl,PEEK (adrl+1)
   LD   HL,(Var_adrl)                  ; Address the var in VARS area
   CALL StackNumericVar

   LD   HL,(Var_adrl)                  ; Address the var in VARS area
   CALL StackNumericVar

   LD   DE,256
   CALL StackShortInt                  ; Stack Signed Word (1)

   CALL GetTwoStackedNumbers
   CALL $3014                          ; [ROM] Call the Addition routine.
   CALL ReclaimStackItem

   CALL $1E99                          ; [ROM] puts address of next stacked integer in BC.
   LD   A,(BC)                         ; load contents into A register.
   LD   D,A
   LD   E,0
   CALL StackShortInt

   CALL $1E80                          ; [ROM] POKE Command


Line1241:                              ; LET adrl=adrl+1
   LD   HL,(Var_adrl)                  ; Address the var in VARS area
   CALL StackNumericVar

   LD   DE,256
   CALL StackShortInt                  ; Stack Signed Word (1)

   CALL GetTwoStackedNumbers
   CALL $3014                          ; [ROM] Call the Addition routine.
   CALL ReclaimStackItem

   LD   DE,(Var_adrl)                  ; Address the var in VARS area
   CALL UpdateNumVar


Line1250:                              ; NEXT p
   LD   HL,(Var_p)                     ; Address the var in VARS area
   CALL DoNext                         ; And sort out the loop where necessary.


Line1260:                              ; POKE adr+31,0
   LD   HL,(Var_adr)                   ; Address the var in VARS area
   CALL StackNumericVar

   LD   DE,7936
   CALL StackShortInt                  ; Stack Signed Word (31)

   CALL GetTwoStackedNumbers
   CALL $3014                          ; [ROM] Call the Addition routine.
   CALL ReclaimStackItem

   LD   DE,0
   CALL StackShortInt                  ; Stack Signed Word (0)

   CALL $1E80                          ; [ROM] POKE Command


Line1270:                              ; LET adr=adr+32
   LD   HL,(Var_adr)                   ; Address the var in VARS area
   CALL StackNumericVar

   LD   DE,8192
   CALL StackShortInt                  ; Stack Signed Word (32)

   CALL GetTwoStackedNumbers
   CALL $3014                          ; [ROM] Call the Addition routine.
   CALL ReclaimStackItem

   LD   DE,(Var_adr)                   ; Address the var in VARS area
   CALL UpdateNumVar


Line1280:                              ; NEXT l
   LD   HL,(Var_l)                     ; Address the var in VARS area
   CALL DoNext                         ; And sort out the loop where necessary.


Line1290:                              ; RETURN
Line1400:                              ; CLS
Line1400_1:                            ; PRINT "Scroll in Assembler";
Line1410:                              ; GO SUB 1100
Line1420:                              ; FOR i=1 TO 32
   LD   DE,256                         ; STEP not present - assume 1.
   CALL StackShortInt

   LD   DE,8192
   CALL StackShortInt                  ; Stack Signed Word (32)

   LD   DE,256
   CALL StackShortInt                  ; Stack Signed Word (1)

   LD   DE,(Var_i)                     ; Address the var in VARS area
   LD   BC,Line1430                    ; Store the address of the next line
   CALL UpdateFORVar


Line1430:                              ; REM asmcallsidescroll
Line1440:                              ; NEXT i
   LD   HL,(Var_i)                     ; Address the var in VARS area
   CALL DoNext                         ; And sort out the loop where necessary.


Line1450:                              ; GO SUB 3600
Line1460:                              ; RETURN
Line1470:                              ; REM asminclude"demo.asm"
Line3000:                              ; DATA 24,60,126,219,255,36,90,165
Line3010:                              ; DATA 60,66,102,153,129,90,66,60
Line3020:                              ; DATA 0,0,255,153,255,129,255,36
Line3100:                              ; LET pos=USR "A"
   LD   DE,(Var_pos)                   ; Address the var in VARS area
   CALL UpdateNumVar


Line3110:                              ; RESTORE 3000
Line3120:                              ; LET pos=65368
   LD   A,0
   LD   DE,22528
   LD   BC,255
   CALL $2AB6                          ; [ROM] STACK-STORE (65368)

   LD   DE,(Var_pos)                   ; Address the var in VARS area
   CALL UpdateNumVar


Line3130:                              ; FOR i=1 TO 3
   LD   DE,256                         ; STEP not present - assume 1.
   CALL StackShortInt

   LD   DE,768
   CALL StackShortInt                  ; Stack Signed Word (3)

   LD   DE,256
   CALL StackShortInt                  ; Stack Signed Word (1)

   LD   DE,(Var_i)                     ; Address the var in VARS area
   LD   BC,Line3140                    ; Store the address of the next line
   CALL UpdateFORVar


Line3140:                              ; FOR j=1 TO 8
   LD   DE,256                         ; STEP not present - assume 1.
   CALL StackShortInt

   LD   DE,2048
   CALL StackShortInt                  ; Stack Signed Word (8)

   LD   DE,256
   CALL StackShortInt                  ; Stack Signed Word (1)

   LD   DE,(Var_j)                     ; Address the var in VARS area
   LD   BC,Line3150                    ; Store the address of the next line
   CALL UpdateFORVar


Line3150:                              ; READ a
Line3160:                              ; POKE pos,a
   LD   HL,(Var_pos)                   ; Address the var in VARS area
   CALL StackNumericVar

   LD   HL,(Var_a)                     ; Address the var in VARS area
   CALL StackNumericVar

   CALL $1E80                          ; [ROM] POKE Command


Line3170:                              ; LET pos=pos+1
   LD   HL,(Var_pos)                   ; Address the var in VARS area
   CALL StackNumericVar

   LD   DE,256
   CALL StackShortInt                  ; Stack Signed Word (1)

   CALL GetTwoStackedNumbers
   CALL $3014                          ; [ROM] Call the Addition routine.
   CALL ReclaimStackItem

   LD   DE,(Var_pos)                   ; Address the var in VARS area
   CALL UpdateNumVar


Line3180:                              ; NEXT j
   LD   HL,(Var_j)                     ; Address the var in VARS area
   CALL DoNext                         ; And sort out the loop where necessary.


Line3190:                              ; NEXT i
   LD   HL,(Var_i)                     ; Address the var in VARS area
   CALL DoNext                         ; And sort out the loop where necessary.


Line3200:                              ; PRINT INK 1;AT 0,0;"UDG:êëí";
Line3210:                              ; RETURN
Line3300:                              ; CLS
Line3310:                              ; PRINT AT 1,0;"Menu"
Line3320:                              ; PRINT " 1 Plot"
Line3330:                              ; PRINT " 2 Array Test"
Line3340:                              ; PRINT " 3 Scroll in Basic"
Line3345:                              ; PRINT " 4 Data+UDG"
Line3350:                              ; PRINT " 5 Mult+Div"
Line3360:                              ; PRINT " 6 Strings"
Line3365:                              ; PRINT " 7 Float"
Line3366:                              ; PRINT " 8 SIN/COS"
Line3367:                              ; PRINT " 9 Mandelbrot"
Line3370:                              ; PRINT " 0 FOR TO STEP"
Line3375:                              ; PRINT " A Input"
Line3376:                              ; PRINT " B String to Float"
Line3377:                              ; PRINT " C Beep and Border"
Line3378:                              ; PRINT " D RND"
Line3379:                              ; PRINT " E Vergleiche"
Line3380:                              ; PRINT " F DEF FN"
Line3390:                              ; PRINT AT 4,20;"H Heapwalk";
Line3400:                              ; LET k= CODE INKEY$
   LD   DE,(Var_k)                     ; Address the var in VARS area
   CALL UpdateNumVar


Line3410:                              ; PRINT AT 0,20;k;"  "
Line3420:                              ; IF k=49 THEN CLS
Line3420_1:                            ; PRINT "Zeichne 5000 Punkte"
Line3420_2:                            ; GO SUB 1000
Line3420_3:                            ; GO TO 3300
   JP Line228

Line3425:                              ; IF k=50 THEN CLS
Line3425_1:                            ; GO SUB 4000
Line3425_2:                            ; GO SUB 3600
Line3425_3:                            ; GO TO 3300
   JP Line228

Line3430:                              ; IF k=51 THEN CLS
Line3430_1:                            ; PRINT "Screen Scroll"
Line3430_2:                            ; PRINT "in Basic"
Line3430_3:                            ; GO SUB 1100
Line3430_4:                            ; FOR i=1 TO 32
   LD   DE,256                         ; STEP not present - assume 1.
   CALL StackShortInt

   LD   DE,8192
   CALL StackShortInt                  ; Stack Signed Word (32)

   LD   DE,256
   CALL StackShortInt                  ; Stack Signed Word (1)

   LD   DE,(Var_i)                     ; Address the var in VARS area
   LD   BC,Line3430_5                  ; Store the address of the next line
   CALL UpdateFORVar


Line3430_5:                            ; GO SUB 1200
Line3430_6:                            ; NEXT i
   LD   HL,(Var_i)                     ; Address the var in VARS area
   CALL DoNext                         ; And sort out the loop where necessary.


Line3430_7:                            ; GO SUB 3600
Line3430_8:                            ; GO SUB 1400
Line3430_9:                            ; GO TO 3300
   JP Line228

Line3440:                              ; IF k=52 THEN CLS
Line3440_1:                            ; GO SUB 3000
Line3440_2:                            ; GO SUB 3600
Line3440_3:                            ; GO TO 3300
   JP Line228

Line3450:                              ; IF k=53 THEN GO SUB 4200
Line3450_1:                            ; GO TO 3300
   JP Line228

Line3460:                              ; IF k=54 THEN GO SUB 4300
Line3460_1:                            ; GO TO 3300
   JP Line228

Line3465:                              ; IF k=55 THEN GO SUB 4500
Line3465_1:                            ; GO TO 3300
   JP Line228

Line3470:                              ; IF k=56 THEN GO SUB 4800
Line3470_1:                            ; GO TO 3300
   JP Line228

Line3480:                              ; IF k=57 THEN GO SUB 5000
Line3480_1:                            ; GO TO 3300
   JP Line228

Line3485:                              ; IF k=48 THEN GO SUB 5200
Line3485_1:                            ; GO TO 3300
   JP Line228

Line3486:                              ; IF k=104 OR k=72 THEN GO SUB 5300
Line3486_1:                            ; GO TO 3300
   JP Line228

Line3487:                              ; IF k=97 OR k=65 THEN GO SUB 5500
Line3487_1:                            ; GO TO 3300
   JP Line228

Line3488:                              ; IF k=98 OR k=66 THEN GO SUB 5600
Line3488_1:                            ; GO TO 3300
   JP Line228

Line3489:                              ; IF k=99 OR k=67 THEN GO SUB 5900
Line3489_1:                            ; GO TO 3300
   JP Line228

Line3490:                              ; IF k=100 OR k=68 THEN GO SUB 6000
Line3490_1:                            ; GO TO 3300
   JP Line228

Line3491:                              ; IF k= CODE "e" OR k= CODE "E" THEN GO SUB 6100
Line3491_1:                            ; GO TO 3300
   JP Line228

Line3492:                              ; IF k= CODE "f" OR k= CODE "F" THEN GO SUB 7000
Line3492_1:                            ; GO TO 3300
   JP Line228

Line3499:                              ; GO TO 3400
   JP Line72

Line3600:                              ; REM presskeytocontinue
Line3610:                              ; PRINT AT 21,0;"Weiter mit Tastendruck";
Line3620:                              ; LET k= CODE INKEY$
   LD   DE,(Var_k)                     ; Address the var in VARS area
   CALL UpdateNumVar


Line3630:                              ; IF k=0 THEN GO TO 3620
   JP Line36

Line3640:                              ; PAUSE 0
   LD   DE,0
   CALL StackShortInt                  ; Stack Signed Word (0)

   CALL $1F3A                          ; [ROM] PAUSE Command


Line3650:                              ; RETURN
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
Line3710:                              ; LET ticks=PEEK 23672+PEEK 23673*256
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


Line3710_1:                            ; LET tsec=INT (ticks/50)
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


Line3710_2:                            ; LET min=INT (tsec/60)
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


Line3710_3:                            ; LET sec=tsec-min*60
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


Line3720:                              ; PRINT AT 21,0;ticks;" ticks ";min;":";sec;" Press a key";
Line3730:                              ; PAUSE 0
   LD   DE,0
   CALL StackShortInt                  ; Stack Signed Word (0)

   CALL $1F3A                          ; [ROM] PAUSE Command


Line3730_1:                            ; RETURN
Line3740:                              ; PRINT AT 0,0;PEEK 23672;" ";PEEK 23673;" ";PEEK 23674;" ";
Line3740_1:                            ; GO TO 3740
   JP Line156

Line4000:                              ; DIM a(8,8)
   LD   HL,(Var_a_array)               ; Address the var in VARS area
   CALL StackNumericVar

   LD   DE,2048
   CALL StackShortInt                  ; Stack Signed Word (8)

   LD   DE,2048
   CALL StackShortInt                  ; Stack Signed Word (8)

   CALL PerformDIM


Line4010:                              ; LET x=1
   LD   DE,256
   CALL StackShortInt                  ; Stack Signed Word (1)

   LD   DE,(Var_x)                     ; Address the var in VARS area
   CALL UpdateNumVar


Line4020:                              ; FOR i=1 TO 8
   LD   DE,256                         ; STEP not present - assume 1.
   CALL StackShortInt

   LD   DE,2048
   CALL StackShortInt                  ; Stack Signed Word (8)

   LD   DE,256
   CALL StackShortInt                  ; Stack Signed Word (1)

   LD   DE,(Var_i)                     ; Address the var in VARS area
   LD   BC,Line4030                    ; Store the address of the next line
   CALL UpdateFORVar


Line4030:                              ; FOR j=1 TO 8
   LD   DE,256                         ; STEP not present - assume 1.
   CALL StackShortInt

   LD   DE,2048
   CALL StackShortInt                  ; Stack Signed Word (8)

   LD   DE,256
   CALL StackShortInt                  ; Stack Signed Word (1)

   LD   DE,(Var_j)                     ; Address the var in VARS area
   LD   BC,Line4040                    ; Store the address of the next line
   CALL UpdateFORVar


Line4040:                              ; LET a(i,j)=x
   LD   HL,(Var_i)                     ; Address the var in VARS area
   CALL StackNumericVar

   LD   DE,(Var_a_array)               ; Address the var in VARS area
   CALL UpdateNumVar


Line4040_1:                            ; LET x=x+1
   LD   HL,(Var_x)                     ; Address the var in VARS area
   CALL StackNumericVar

   LD   DE,256
   CALL StackShortInt                  ; Stack Signed Word (1)

   CALL GetTwoStackedNumbers
   CALL $3014                          ; [ROM] Call the Addition routine.
   CALL ReclaimStackItem

   LD   DE,(Var_x)                     ; Address the var in VARS area
   CALL UpdateNumVar


Line4050:                              ; NEXT j
   LD   HL,(Var_j)                     ; Address the var in VARS area
   CALL DoNext                         ; And sort out the loop where necessary.


Line4060:                              ; NEXT i
   LD   HL,(Var_i)                     ; Address the var in VARS area
   CALL DoNext                         ; And sort out the loop where necessary.


Line4070:                              ; FOR i=1 TO 8
   LD   DE,256                         ; STEP not present - assume 1.
   CALL StackShortInt

   LD   DE,2048
   CALL StackShortInt                  ; Stack Signed Word (8)

   LD   DE,256
   CALL StackShortInt                  ; Stack Signed Word (1)

   LD   DE,(Var_i)                     ; Address the var in VARS area
   LD   BC,Line4075                    ; Store the address of the next line
   CALL UpdateFORVar


Line4075:                              ; PRINT "Zeile ";i
Line4080:                              ; FOR j=1 TO 8
   LD   DE,256                         ; STEP not present - assume 1.
   CALL StackShortInt

   LD   DE,2048
   CALL StackShortInt                  ; Stack Signed Word (8)

   LD   DE,256
   CALL StackShortInt                  ; Stack Signed Word (1)

   LD   DE,(Var_j)                     ; Address the var in VARS area
   LD   BC,Line4090                    ; Store the address of the next line
   CALL UpdateFORVar


Line4090:                              ; PRINT " ";a(i,j);
Line4100:                              ; NEXT j
   LD   HL,(Var_j)                     ; Address the var in VARS area
   CALL DoNext                         ; And sort out the loop where necessary.


Line4110:                              ; PRINT
Line4120:                              ; NEXT i
   LD   HL,(Var_i)                     ; Address the var in VARS area
   CALL DoNext                         ; And sort out the loop where necessary.


Line4130:                              ; RETURN
Line4200:                              ; REM malunddurch
Line4210:                              ; CLS
Line4210_1:                            ; PRINT AT 0,0;"Multiplizieren, Dividieren"
Line4220:                              ; FOR i=2 TO 9
   LD   DE,256                         ; STEP not present - assume 1.
   CALL StackShortInt

   LD   DE,2304
   CALL StackShortInt                  ; Stack Signed Word (9)

   LD   DE,512
   CALL StackShortInt                  ; Stack Signed Word (2)

   LD   DE,(Var_i)                     ; Address the var in VARS area
   LD   BC,Line4224                    ; Store the address of the next line
   CALL UpdateFORVar


Line4224:                              ; IF i>2 THEN PRINT
Line4225:                              ; PRINT "x*";i;"=";
Line4230:                              ; FOR j=2 TO 9
   LD   DE,256                         ; STEP not present - assume 1.
   CALL StackShortInt

   LD   DE,2304
   CALL StackShortInt                  ; Stack Signed Word (9)

   LD   DE,512
   CALL StackShortInt                  ; Stack Signed Word (2)

   LD   DE,(Var_j)                     ; Address the var in VARS area
   LD   BC,Line4240                    ; Store the address of the next line
   CALL UpdateFORVar


Line4240:                              ; PRINT i*j;" ";
Line4250:                              ; NEXT j
   LD   HL,(Var_j)                     ; Address the var in VARS area
   CALL DoNext                         ; And sort out the loop where necessary.


Line4255:                              ; NEXT i
   LD   HL,(Var_i)                     ; Address the var in VARS area
   CALL DoNext                         ; And sort out the loop where necessary.


Line4256:                              ; PRINT
Line4257:                              ; PRINT "Mult/Div signed"
Line4270:                              ; LET z=30000
   LD   A,0
   LD   DE,12288
   LD   BC,117
   CALL $2AB6                          ; [ROM] STACK-STORE (30000)

   LD   DE,(Var_z)                     ; Address the var in VARS area
   CALL UpdateNumVar


Line4270_1:                            ; LET x=3
   LD   DE,768
   CALL StackShortInt                  ; Stack Signed Word (3)

   LD   DE,(Var_x)                     ; Address the var in VARS area
   CALL UpdateNumVar


Line4280:                              ; FOR i=1 TO 5
   LD   DE,256                         ; STEP not present - assume 1.
   CALL StackShortInt

   LD   DE,1280
   CALL StackShortInt                  ; Stack Signed Word (5)

   LD   DE,256
   CALL StackShortInt                  ; Stack Signed Word (1)

   LD   DE,(Var_i)                     ; Address the var in VARS area
   LD   BC,Line4280_1                  ; Store the address of the next line
   CALL UpdateFORVar


Line4280_1:                            ; PRINT z,x
Line4280_2:                            ; LET z=z/10
   LD   HL,(Var_z)                     ; Address the var in VARS area
   CALL StackNumericVar

   LD   DE,2560
   CALL StackShortInt                  ; Stack Signed Word (10)

   CALL GetTwoStackedNumbers
   CALL $31AF                          ; [ROM] Call the Division routine.
   CALL ReclaimStackItem

   LD   DE,(Var_z)                     ; Address the var in VARS area
   CALL UpdateNumVar


Line4280_3:                            ; LET x=x*10
   LD   HL,(Var_x)                     ; Address the var in VARS area
   CALL StackNumericVar

   LD   DE,2560
   CALL StackShortInt                  ; Stack Signed Word (10)

   CALL GetTwoStackedNumbers
   CALL $30CA                          ; [ROM] Call the Multiplication routine.
   CALL ReclaimStackItem

   LD   DE,(Var_x)                     ; Address the var in VARS area
   CALL UpdateNumVar


Line4280_4:                            ; NEXT i
   LD   HL,(Var_i)                     ; Address the var in VARS area
   CALL DoNext                         ; And sort out the loop where necessary.


Line4285:                              ; LET z=0-30000
   LD   DE,0
   CALL StackShortInt                  ; Stack Signed Word (0)

   LD   A,0
   LD   DE,12288
   LD   BC,117
   CALL $2AB6                          ; [ROM] STACK-STORE (30000)

   CALL GetTwoStackedNumbers
   CALL $300F                          ; [ROM] Call the Subtraction routine.
   CALL ReclaimStackItem

   LD   DE,(Var_z)                     ; Address the var in VARS area
   CALL UpdateNumVar


Line4285_1:                            ; LET x=0-3
   LD   DE,0
   CALL StackShortInt                  ; Stack Signed Word (0)

   LD   DE,768
   CALL StackShortInt                  ; Stack Signed Word (3)

   CALL GetTwoStackedNumbers
   CALL $300F                          ; [ROM] Call the Subtraction routine.
   CALL ReclaimStackItem

   LD   DE,(Var_x)                     ; Address the var in VARS area
   CALL UpdateNumVar


Line4286:                              ; FOR i=1 TO 5
   LD   DE,256                         ; STEP not present - assume 1.
   CALL StackShortInt

   LD   DE,1280
   CALL StackShortInt                  ; Stack Signed Word (5)

   LD   DE,256
   CALL StackShortInt                  ; Stack Signed Word (1)

   LD   DE,(Var_i)                     ; Address the var in VARS area
   LD   BC,Line4286_1                  ; Store the address of the next line
   CALL UpdateFORVar


Line4286_1:                            ; PRINT z,x
Line4286_2:                            ; LET z=z/10
   LD   HL,(Var_z)                     ; Address the var in VARS area
   CALL StackNumericVar

   LD   DE,2560
   CALL StackShortInt                  ; Stack Signed Word (10)

   CALL GetTwoStackedNumbers
   CALL $31AF                          ; [ROM] Call the Division routine.
   CALL ReclaimStackItem

   LD   DE,(Var_z)                     ; Address the var in VARS area
   CALL UpdateNumVar


Line4286_3:                            ; LET x=x*10
   LD   HL,(Var_x)                     ; Address the var in VARS area
   CALL StackNumericVar

   LD   DE,2560
   CALL StackShortInt                  ; Stack Signed Word (10)

   CALL GetTwoStackedNumbers
   CALL $30CA                          ; [ROM] Call the Multiplication routine.
   CALL ReclaimStackItem

   LD   DE,(Var_x)                     ; Address the var in VARS area
   CALL UpdateNumVar


Line4286_4:                            ; NEXT i
   LD   HL,(Var_i)                     ; Address the var in VARS area
   CALL DoNext                         ; And sort out the loop where necessary.


Line4290:                              ; GO SUB 3600
Line4290_1:                            ; RETURN
Line4300:                              ; REM strings
Line4301:                              ; CLS
Line4310:                              ; LET a$="1234"
   LD   HL,String0
   CALL StackStringVar                 ; Stack String Const ("1234")

   LD   DE,(Var_a_str)                 ; Address the var in VARS area
   LD   BC,Var_a_str
   PUSH BC
   CALL UpdateStrVar


Line4320:                              ; PRINT "a$=";a$
Line4330:                              ; PRINT "val a$=";VAL a$
Line4340:                              ; PRINT "start=";a$( TO 2)
Line4350:                              ; PRINT "ende=";a$(2 TO )
Line4360:                              ; PRINT "mitte=";a$(1 TO 2)
Line4370:                              ; PRINT "2.Byte=";a$(2)
Line4380:                              ; LET x$=""
   LD   HL,String5
   CALL StackStringVar                 ; Stack String Const ("UDG:êëí")

   LD   DE,(Var_x_str)                 ; Address the var in VARS area
   LD   BC,Var_x_str
   PUSH BC
   CALL UpdateStrVar


Line4380_1:                            ; FOR i=32 TO 255
   LD   DE,256                         ; STEP not present - assume 1.
   CALL StackShortInt

   LD   DE,65280
   CALL StackShortInt                  ; Stack Signed Word (255)

   LD   DE,8192
   CALL StackShortInt                  ; Stack Signed Word (32)

   LD   DE,(Var_i)                     ; Address the var in VARS area
   LD   BC,Line4380_2                  ; Store the address of the next line
   CALL UpdateFORVar


Line4380_2:                            ; LET x$=x$+CHR$ i
   LD   HL,(Var_x_str)                 ; Address the var in VARS area
   CALL StackStringVar

   LD   HL,(Var_i)                     ; Address the var in VARS area
   CALL StackNumericVar

   CALL $35C9                          ; [ROM] Call the CHR$ routine.

   CALL $359C                          ; [ROM] Perform the Addition.

   LD   DE,(Var_x_str)                 ; Address the var in VARS area
   LD   BC,Var_x_str
   PUSH BC
   CALL UpdateStrVar


Line4380_3:                            ; NEXT i
   LD   HL,(Var_i)                     ; Address the var in VARS area
   CALL DoNext                         ; And sort out the loop where necessary.


Line4380_4:                            ; PRINT x$
Line4499:                              ; GO SUB 3600
Line4499_1:                            ; RETURN
Line4500:                              ; CLS
Line4500_1:                            ; PRINT "test float und float mit int"
Line4501:                              ; GO SUB 4600
Line4503:                              ; PRINT "pi=";PI
Line4504:                              ; LET pi=PI
   LD   A,130                          ; Prepare PI for stacking
   LD   DE,3913
   LD   BC,41946
   CALL $2AB6                          ; [ROM] STACK-STORE (PI)

   LD   DE,(Var_pi)                    ; Address the var in VARS area
   CALL UpdateNumVar


Line4505:                              ; PRINT "var pi=";pi
Line4507:                              ; LET zz=10.0
   LD   DE,2560
   CALL StackShortInt                  ; Stack Signed Word (10)

   LD   DE,(Var_zz)                    ; Address the var in VARS area
   CALL UpdateNumVar


Line4507_1:                            ; PRINT "zz=";zz
Line4510:                              ; LET f1=1
   LD   DE,256
   CALL StackShortInt                  ; Stack Signed Word (1)

   LD   DE,(Var_f1)                    ; Address the var in VARS area
   CALL UpdateNumVar


Line4510_1:                            ; LET f2=7
   LD   DE,1792
   CALL StackShortInt                  ; Stack Signed Word (7)

   LD   DE,(Var_f2)                    ; Address the var in VARS area
   CALL UpdateNumVar


Line4515:                              ; LET i1=INT f1
   LD   HL,(Var_f1)                    ; Address the var in VARS area
   CALL StackNumericVar

   CALL GetStackedNumber
   CALL $36AF                          ; [ROM] Call the INT routine.

   LD   DE,(Var_i1)                    ; Address the var in VARS area
   CALL UpdateNumVar


Line4515_1:                            ; LET i2=INT f2
   LD   HL,(Var_f2)                    ; Address the var in VARS area
   CALL StackNumericVar

   CALL GetStackedNumber
   CALL $36AF                          ; [ROM] Call the INT routine.

   LD   DE,(Var_i2)                    ; Address the var in VARS area
   CALL UpdateNumVar


Line4516:                              ; PRINT "f1=";f1;" f2=";f2
Line4516_1:                            ; PRINT "i1=";i1;" i2=";i2
Line4520:                              ; LET f3=f1/f2
   LD   HL,(Var_f1)                    ; Address the var in VARS area
   CALL StackNumericVar

   LD   HL,(Var_f2)                    ; Address the var in VARS area
   CALL StackNumericVar

   CALL GetTwoStackedNumbers
   CALL $31AF                          ; [ROM] Call the Division routine.
   CALL ReclaimStackItem

   LD   DE,(Var_f3)                    ; Address the var in VARS area
   CALL UpdateNumVar


Line4530:                              ; PRINT "f1/f2=";f3
Line4540:                              ; PRINT "10-f3=";10-f3
Line4540_1:                            ; PRINT "f3-10=";f3-10
Line4599:                              ; GO TO 3600
   JP Line16

Line4600:                              ; PRINT "STKBOT=";PEEK (23651)+PEEK (23652)*256,
Line4620:                              ; PRINT "STKEND=";PEEK 23653+PEEK 23654*256
Line4630:                              ; RETURN
Line4800:                              ; REM graph
Line4801:                              ; REM floatxfyf
Line4802:                              ; GO SUB 3700
Line4802_1:                            ; CLS
Line4802_2:                            ; PRINT AT 0,15;"SIN und COS"
Line4805:                              ; PLOT 0,80
Line4805_1:                            ; DRAW 255,0
Line4809:                              ; LET c=0
   LD   DE,0
   CALL StackShortInt                  ; Stack Signed Word (0)

   LD   DE,(Var_c)                     ; Address the var in VARS area
   CALL UpdateNumVar


Line4810:                              ; FOR x=0 TO 250
   LD   DE,256                         ; STEP not present - assume 1.
   CALL StackShortInt

   LD   DE,64000
   CALL StackShortInt                  ; Stack Signed Word (250)

   LD   DE,0
   CALL StackShortInt                  ; Stack Signed Word (0)

   LD   DE,(Var_x)                     ; Address the var in VARS area
   LD   BC,Line4820                    ; Store the address of the next line
   CALL UpdateFORVar


Line4820:                              ; LET xf=x*PI/50
   LD   HL,(Var_x)                     ; Address the var in VARS area
   CALL StackNumericVar

   LD   A,130                          ; Prepare PI for stacking
   LD   DE,3913
   LD   BC,41946
   CALL $2AB6                          ; [ROM] STACK-STORE (PI)

   LD   DE,12800
   CALL StackShortInt                  ; Stack Signed Word (50)

   CALL GetTwoStackedNumbers
   CALL $31AF                          ; [ROM] Call the Division routine.
   CALL ReclaimStackItem

   CALL GetTwoStackedNumbers
   CALL $30CA                          ; [ROM] Call the Multiplication routine.
   CALL ReclaimStackItem

   LD   DE,(Var_xf)                    ; Address the var in VARS area
   CALL UpdateNumVar


Line4830:                              ; LET yf=80+(80*SIN xf)
   LD   DE,20480
   CALL StackShortInt                  ; Stack Signed Word (80)

   LD   DE,20480
   CALL StackShortInt                  ; Stack Signed Word (80)

   CALL GetTwoStackedNumbers
   CALL $30CA                          ; [ROM] Call the Multiplication routine.
   CALL ReclaimStackItem

   LD   DE,(Var_yf)                    ; Address the var in VARS area
   CALL UpdateNumVar


Line4835:                              ; PLOT x,yf
Line4840:                              ; LET yf=80+(80*COS xf)
   LD   DE,20480
   CALL StackShortInt                  ; Stack Signed Word (80)

   LD   DE,20480
   CALL StackShortInt                  ; Stack Signed Word (80)

   CALL GetTwoStackedNumbers
   CALL $30CA                          ; [ROM] Call the Multiplication routine.
   CALL ReclaimStackItem

   LD   DE,(Var_yf)                    ; Address the var in VARS area
   CALL UpdateNumVar


Line4844:                              ; IF c=0 THEN GO SUB 4900
Line4844_1:                            ; LET c=51
   LD   DE,13056
   CALL StackShortInt                  ; Stack Signed Word (51)

   LD   DE,(Var_c)                     ; Address the var in VARS area
   CALL UpdateNumVar


Line4845:                              ; PLOT x,yf
Line4846:                              ; IF c=0 THEN LET c=51
   LD   DE,13056
   CALL StackShortInt                  ; Stack Signed Word (51)

   LD   DE,(Var_c)                     ; Address the var in VARS area
   CALL UpdateNumVar


Line4846_1:                            ; GO SUB 4900
Line4847:                              ; LET c=c-1
   LD   HL,(Var_c)                     ; Address the var in VARS area
   CALL StackNumericVar

   LD   DE,256
   CALL StackShortInt                  ; Stack Signed Word (1)

   CALL GetTwoStackedNumbers
   CALL $300F                          ; [ROM] Call the Subtraction routine.
   CALL ReclaimStackItem

   LD   DE,(Var_c)                     ; Address the var in VARS area
   CALL UpdateNumVar


Line4850:                              ; NEXT x
   LD   HL,(Var_x)                     ; Address the var in VARS area
   CALL DoNext                         ; And sort out the loop where necessary.


Line4890:                              ; GO TO 3710
   JP Line126

Line4900:                              ; LET x$=STR$ xf
   LD   DE,(Var_x_str)                 ; Address the var in VARS area
   LD   BC,Var_x_str
   PUSH BC
   CALL UpdateStrVar


Line4910:                              ; LET ix=x/8
   LD   HL,(Var_x)                     ; Address the var in VARS area
   CALL StackNumericVar

   LD   DE,2048
   CALL StackShortInt                  ; Stack Signed Word (8)

   CALL GetTwoStackedNumbers
   CALL $31AF                          ; [ROM] Call the Division routine.
   CALL ReclaimStackItem

   LD   DE,(Var_ix)                    ; Address the var in VARS area
   CALL UpdateNumVar


Line4910_1:                            ; IF ix>=31 THEN LET ix=31
   LD   DE,7936
   CALL StackShortInt                  ; Stack Signed Word (31)

   LD   DE,(Var_ix)                    ; Address the var in VARS area
   CALL UpdateNumVar


Line4920:                              ; FOR i=1 TO LEN x$
   LD   DE,256                         ; STEP not present - assume 1.
   CALL StackShortInt

   LD   DE,256
   CALL StackShortInt                  ; Stack Signed Word (1)

   LD   DE,(Var_i)                     ; Address the var in VARS area
   LD   BC,Line4930                    ; Store the address of the next line
   CALL UpdateFORVar


Line4930:                              ; PRINT AT i+5,ix;x$(i)
Line4940:                              ; NEXT i
   LD   HL,(Var_i)                     ; Address the var in VARS area
   CALL DoNext                         ; And sort out the loop where necessary.


Line4950:                              ; RETURN
Line5000:                              ; CLS
Line5000_1:                            ; GO SUB 5450
Line5000_2:                            ; PRINT AT 0,20;"Mandelbrot"
Line5001:                              ; REM floatxfz1zzzfztziznf
Line5002:                              ; LET nf=0.0
   LD   DE,0
   CALL StackShortInt                  ; Stack Signed Word (0)

   LD   DE,(Var_nf)                    ; Address the var in VARS area
   CALL UpdateNumVar


Line5005:                              ; LET my=0
   LD   DE,0
   CALL StackShortInt                  ; Stack Signed Word (0)

   LD   DE,(Var_my)                    ; Address the var in VARS area
   CALL UpdateNumVar


Line5010:                              ; LET xf=nf-2.0
   LD   HL,(Var_nf)                    ; Address the var in VARS area
   CALL StackNumericVar

   LD   DE,512
   CALL StackShortInt                  ; Stack Signed Word (2)

   CALL GetTwoStackedNumbers
   CALL $300F                          ; [ROM] Call the Subtraction routine.
   CALL ReclaimStackItem

   LD   DE,(Var_xf)                    ; Address the var in VARS area
   CALL UpdateNumVar


Line5015:                              ; LET mx=0
   LD   DE,0
   CALL StackShortInt                  ; Stack Signed Word (0)

   LD   DE,(Var_mx)                    ; Address the var in VARS area
   CALL UpdateNumVar


Line5016:                              ; GO SUB 5400
Line5016_1:                            ; PRINT AT 21,0;"x=";xf;"    ";AT 21,20;"time=";sec
Line5017:                              ; LET my=my+1
   LD   HL,(Var_my)                    ; Address the var in VARS area
   CALL StackNumericVar

   LD   DE,256
   CALL StackShortInt                  ; Stack Signed Word (1)

   CALL GetTwoStackedNumbers
   CALL $3014                          ; [ROM] Call the Addition routine.
   CALL ReclaimStackItem

   LD   DE,(Var_my)                    ; Address the var in VARS area
   CALL UpdateNumVar


Line5020:                              ; LET yf=nf-1.0
   LD   HL,(Var_nf)                    ; Address the var in VARS area
   CALL StackNumericVar

   LD   DE,256
   CALL StackShortInt                  ; Stack Signed Word (1)

   CALL GetTwoStackedNumbers
   CALL $300F                          ; [ROM] Call the Subtraction routine.
   CALL ReclaimStackItem

   LD   DE,(Var_yf)                    ; Address the var in VARS area
   CALL UpdateNumVar


Line5025:                              ; LET mx=mx+1
   LD   HL,(Var_mx)                    ; Address the var in VARS area
   CALL StackNumericVar

   LD   DE,256
   CALL StackShortInt                  ; Stack Signed Word (1)

   CALL GetTwoStackedNumbers
   CALL $3014                          ; [ROM] Call the Addition routine.
   CALL ReclaimStackItem

   LD   DE,(Var_mx)                    ; Address the var in VARS area
   CALL UpdateNumVar


Line5030:                              ; LET zz=0.0
   LD   DE,0
   CALL StackShortInt                  ; Stack Signed Word (0)

   LD   DE,(Var_zz)                    ; Address the var in VARS area
   CALL UpdateNumVar


Line5035:                              ; LET zi=0.0
   LD   DE,0
   CALL StackShortInt                  ; Stack Signed Word (0)

   LD   DE,(Var_zi)                    ; Address the var in VARS area
   CALL UpdateNumVar


Line5040:                              ; FOR i=1 TO 100
   LD   DE,256                         ; STEP not present - assume 1.
   CALL StackShortInt

   LD   DE,25600
   CALL StackShortInt                  ; Stack Signed Word (100)

   LD   DE,256
   CALL StackShortInt                  ; Stack Signed Word (1)

   LD   DE,(Var_i)                     ; Address the var in VARS area
   LD   BC,Line5045                    ; Store the address of the next line
   CALL UpdateFORVar


Line5045:                              ; IF zz>1000.0 OR zi>1000.0 THEN GO TO 5100
   JP Line236

Line5050:                              ; LET zt=zz*zz-zi*zi+xf
   LD   HL,(Var_zz)                    ; Address the var in VARS area
   CALL StackNumericVar

   LD   HL,(Var_zz)                    ; Address the var in VARS area
   CALL StackNumericVar

   CALL GetTwoStackedNumbers
   CALL $30CA                          ; [ROM] Call the Multiplication routine.
   CALL ReclaimStackItem

   LD   HL,(Var_zi)                    ; Address the var in VARS area
   CALL StackNumericVar

   LD   HL,(Var_zi)                    ; Address the var in VARS area
   CALL StackNumericVar

   CALL GetTwoStackedNumbers
   CALL $30CA                          ; [ROM] Call the Multiplication routine.
   CALL ReclaimStackItem

   LD   HL,(Var_xf)                    ; Address the var in VARS area
   CALL StackNumericVar

   CALL GetTwoStackedNumbers
   CALL $3014                          ; [ROM] Call the Addition routine.
   CALL ReclaimStackItem

   CALL GetTwoStackedNumbers
   CALL $300F                          ; [ROM] Call the Subtraction routine.
   CALL ReclaimStackItem

   LD   DE,(Var_zt)                    ; Address the var in VARS area
   CALL UpdateNumVar


Line5060:                              ; LET zi=2.0*zz*zi+yf
   LD   DE,512
   CALL StackShortInt                  ; Stack Signed Word (2)

   LD   HL,(Var_zz)                    ; Address the var in VARS area
   CALL StackNumericVar

   LD   HL,(Var_zi)                    ; Address the var in VARS area
   CALL StackNumericVar

   CALL GetTwoStackedNumbers
   CALL $30CA                          ; [ROM] Call the Multiplication routine.
   CALL ReclaimStackItem

   CALL GetTwoStackedNumbers
   CALL $30CA                          ; [ROM] Call the Multiplication routine.
   CALL ReclaimStackItem

   LD   HL,(Var_yf)                    ; Address the var in VARS area
   CALL StackNumericVar

   CALL GetTwoStackedNumbers
   CALL $3014                          ; [ROM] Call the Addition routine.
   CALL ReclaimStackItem

   LD   DE,(Var_zi)                    ; Address the var in VARS area
   CALL UpdateNumVar


Line5070:                              ; LET zz=zt
   LD   HL,(Var_zt)                    ; Address the var in VARS area
   CALL StackNumericVar

   LD   DE,(Var_zz)                    ; Address the var in VARS area
   CALL UpdateNumVar


Line5080:                              ; NEXT i
   LD   HL,(Var_i)                     ; Address the var in VARS area
   CALL DoNext                         ; And sort out the loop where necessary.


Line5090:                              ; IF zz<2.0 THEN PLOT my,mx
Line5100:                              ; LET yf=yf+0.0156
   LD   HL,(Var_yf)                    ; Address the var in VARS area
   CALL StackNumericVar

   LD   A,122
   LD   DE,38783
   LD   BC,29732
   CALL $2AB6                          ; [ROM] STACK-STORE (0.0156)

   CALL GetTwoStackedNumbers
   CALL $3014                          ; [ROM] Call the Addition routine.
   CALL ReclaimStackItem

   LD   DE,(Var_yf)                    ; Address the var in VARS area
   CALL UpdateNumVar


Line5100_1:                            ; IF yf<1.0 THEN GO TO 5025
   JP Line161

Line5110:                              ; LET xf=xf+0.0156
   LD   HL,(Var_xf)                    ; Address the var in VARS area
   CALL StackNumericVar

   LD   A,122
   LD   DE,38783
   LD   BC,29732
   CALL $2AB6                          ; [ROM] STACK-STORE (0.0156)

   CALL GetTwoStackedNumbers
   CALL $3014                          ; [ROM] Call the Addition routine.
   CALL ReclaimStackItem

   LD   DE,(Var_xf)                    ; Address the var in VARS area
   CALL UpdateNumVar


Line5110_1:                            ; IF xf<2.0 THEN GO TO 5015
   JP Line151

Line5120:                              ; GO TO 3600
   JP Line16

Line5200:                              ; CLS
Line5200_1:                            ; PRINT "FOR .. STEP"
Line5220:                              ; PRINT "Integer"
Line5230:                              ; FOR i=1 TO 10
   LD   DE,256                         ; STEP not present - assume 1.
   CALL StackShortInt

   LD   DE,2560
   CALL StackShortInt                  ; Stack Signed Word (10)

   LD   DE,256
   CALL StackShortInt                  ; Stack Signed Word (1)

   LD   DE,(Var_i)                     ; Address the var in VARS area
   LD   BC,Line5230_1                  ; Store the address of the next line
   CALL UpdateFORVar


Line5230_1:                            ; PRINT i;", ";
Line5230_2:                            ; NEXT i
   LD   HL,(Var_i)                     ; Address the var in VARS area
   CALL DoNext                         ; And sort out the loop where necessary.


Line5230_3:                            ; PRINT
Line5235:                              ; PRINT "for mit int"
Line5235_1:                            ; FOR i=1 TO 10 STEP 2
   LD   DE,512
   CALL StackShortInt                  ; Stack Signed Word (2)

   LD   DE,2560
   CALL StackShortInt                  ; Stack Signed Word (10)

   LD   DE,256
   CALL StackShortInt                  ; Stack Signed Word (1)

   LD   DE,(Var_i)                     ; Address the var in VARS area
   LD   BC,Line5235_2                  ; Store the address of the next line
   CALL UpdateFORVar


Line5235_2:                            ; PRINT i;", ";
Line5235_3:                            ; NEXT i
   LD   HL,(Var_i)                     ; Address the var in VARS area
   CALL DoNext                         ; And sort out the loop where necessary.


Line5235_4:                            ; PRINT
Line5240:                              ; PRINT "for int step -1"
Line5250:                              ; FOR i=10 TO 1 STEP 0-1
   LD   DE,0
   CALL StackShortInt                  ; Stack Signed Word (0)

   LD   DE,256
   CALL StackShortInt                  ; Stack Signed Word (1)

   CALL GetTwoStackedNumbers
   CALL $300F                          ; [ROM] Call the Subtraction routine.
   CALL ReclaimStackItem

   LD   DE,256
   CALL StackShortInt                  ; Stack Signed Word (1)

   LD   DE,2560
   CALL StackShortInt                  ; Stack Signed Word (10)

   LD   DE,(Var_i)                     ; Address the var in VARS area
   LD   BC,Line5250_1                  ; Store the address of the next line
   CALL UpdateFORVar


Line5250_1:                            ; PRINT i;", ";
Line5250_2:                            ; NEXT i
   LD   HL,(Var_i)                     ; Address the var in VARS area
   CALL DoNext                         ; And sort out the loop where necessary.


Line5250_3:                            ; PRINT
Line5255:                              ; PRINT "for int. fp param convert to int"
Line5255_1:                            ; FOR i=PI TO 3*PI STEP PI
   LD   A,130                          ; Prepare PI for stacking
   LD   DE,3913
   LD   BC,41946
   CALL $2AB6                          ; [ROM] STACK-STORE (PI)

   LD   DE,768
   CALL StackShortInt                  ; Stack Signed Word (3)

   LD   A,130                          ; Prepare PI for stacking
   LD   DE,3913
   LD   BC,41946
   CALL $2AB6                          ; [ROM] STACK-STORE (PI)

   CALL GetTwoStackedNumbers
   CALL $30CA                          ; [ROM] Call the Multiplication routine.
   CALL ReclaimStackItem

   LD   A,130                          ; Prepare PI for stacking
   LD   DE,3913
   LD   BC,41946
   CALL $2AB6                          ; [ROM] STACK-STORE (PI)

   LD   DE,(Var_i)                     ; Address the var in VARS area
   LD   BC,Line5255_2                  ; Store the address of the next line
   CALL UpdateFORVar


Line5255_2:                            ; PRINT i;" ";
Line5255_3:                            ; NEXT i
   LD   HL,(Var_i)                     ; Address the var in VARS area
   CALL DoNext                         ; And sort out the loop where necessary.


Line5255_4:                            ; PRINT
Line5260:                              ; PRINT "for mit fp"
Line5260_1:                            ; FOR f=PI TO 3*PI
   LD   DE,256                         ; STEP not present - assume 1.
   CALL StackShortInt

   LD   DE,768
   CALL StackShortInt                  ; Stack Signed Word (3)

   LD   A,130                          ; Prepare PI for stacking
   LD   DE,3913
   LD   BC,41946
   CALL $2AB6                          ; [ROM] STACK-STORE (PI)

   CALL GetTwoStackedNumbers
   CALL $30CA                          ; [ROM] Call the Multiplication routine.
   CALL ReclaimStackItem

   LD   A,130                          ; Prepare PI for stacking
   LD   DE,3913
   LD   BC,41946
   CALL $2AB6                          ; [ROM] STACK-STORE (PI)

   LD   DE,(Var_f)                     ; Address the var in VARS area
   LD   BC,Line5260_2                  ; Store the address of the next line
   CALL UpdateFORVar


Line5260_2:                            ; PRINT f;" ";
Line5260_3:                            ; NEXT f
   LD   HL,(Var_f)                     ; Address the var in VARS area
   CALL DoNext                         ; And sort out the loop where necessary.


Line5260_4:                            ; PRINT
Line5265:                              ; PRINT "for fp step"
Line5265_1:                            ; FOR f=PI TO 10*PI STEP PI
   LD   A,130                          ; Prepare PI for stacking
   LD   DE,3913
   LD   BC,41946
   CALL $2AB6                          ; [ROM] STACK-STORE (PI)

   LD   DE,2560
   CALL StackShortInt                  ; Stack Signed Word (10)

   LD   A,130                          ; Prepare PI for stacking
   LD   DE,3913
   LD   BC,41946
   CALL $2AB6                          ; [ROM] STACK-STORE (PI)

   CALL GetTwoStackedNumbers
   CALL $30CA                          ; [ROM] Call the Multiplication routine.
   CALL ReclaimStackItem

   LD   A,130                          ; Prepare PI for stacking
   LD   DE,3913
   LD   BC,41946
   CALL $2AB6                          ; [ROM] STACK-STORE (PI)

   LD   DE,(Var_f)                     ; Address the var in VARS area
   LD   BC,Line5265_2                  ; Store the address of the next line
   CALL UpdateFORVar


Line5265_2:                            ; PRINT f;" ";
Line5265_3:                            ; NEXT f
   LD   HL,(Var_f)                     ; Address the var in VARS area
   CALL DoNext                         ; And sort out the loop where necessary.


Line5265_4:                            ; PRINT
Line5270:                              ; PRINT "for fp step"
Line5270_1:                            ; FOR f=10*PI TO PI STEP 0-PI
   LD   DE,0
   CALL StackShortInt                  ; Stack Signed Word (0)

   LD   A,130                          ; Prepare PI for stacking
   LD   DE,3913
   LD   BC,41946
   CALL $2AB6                          ; [ROM] STACK-STORE (PI)

   CALL GetTwoStackedNumbers
   CALL $300F                          ; [ROM] Call the Subtraction routine.
   CALL ReclaimStackItem

   LD   A,130                          ; Prepare PI for stacking
   LD   DE,3913
   LD   BC,41946
   CALL $2AB6                          ; [ROM] STACK-STORE (PI)

   LD   DE,2560
   CALL StackShortInt                  ; Stack Signed Word (10)

   LD   A,130                          ; Prepare PI for stacking
   LD   DE,3913
   LD   BC,41946
   CALL $2AB6                          ; [ROM] STACK-STORE (PI)

   CALL GetTwoStackedNumbers
   CALL $30CA                          ; [ROM] Call the Multiplication routine.
   CALL ReclaimStackItem

   LD   DE,(Var_f)                     ; Address the var in VARS area
   LD   BC,Line5270_2                  ; Store the address of the next line
   CALL UpdateFORVar


Line5270_2:                            ; PRINT f;" ";
Line5270_3:                            ; NEXT f
   LD   HL,(Var_f)                     ; Address the var in VARS area
   CALL DoNext                         ; And sort out the loop where necessary.


Line5270_4:                            ; PRINT
Line5299:                              ; GO TO 3600
   JP Line16

Line5300:                              ; CLS
Line5310:                              ; REM asmcallruntimeheapwalk
Line5320:                              ; GO TO 3600
   JP Line16

Line5400:                              ; LET time=PEEK 23672+PEEK 23673*256
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

   LD   DE,(Var_time)                  ; Address the var in VARS area
   CALL UpdateNumVar


Line5410:                              ; LET sec=(time-timestart)/50
   LD   HL,(Var_time)                  ; Address the var in VARS area
   CALL StackNumericVar

   LD   HL,(Var_timestart)             ; Address the var in VARS area
   CALL StackNumericVar

   CALL GetTwoStackedNumbers
   CALL $300F                          ; [ROM] Call the Subtraction routine.
   CALL ReclaimStackItem

   LD   DE,12800
   CALL StackShortInt                  ; Stack Signed Word (50)

   CALL GetTwoStackedNumbers
   CALL $31AF                          ; [ROM] Call the Division routine.
   CALL ReclaimStackItem

   LD   DE,(Var_sec)                   ; Address the var in VARS area
   CALL UpdateNumVar


Line5420:                              ; RETURN
Line5450:                              ; LET timestart=0
   LD   DE,0
   CALL StackShortInt                  ; Stack Signed Word (0)

   LD   DE,(Var_timestart)             ; Address the var in VARS area
   CALL UpdateNumVar


Line5450_1:                            ; GO SUB 5400
Line5450_2:                            ; LET timestart=time
   LD   HL,(Var_time)                  ; Address the var in VARS area
   CALL StackNumericVar

   LD   DE,(Var_timestart)             ; Address the var in VARS area
   CALL UpdateNumVar


Line5450_3:                            ; RETURN
Line5500:                              ; CLS
Line5500_1:                            ; PRINT "Eingabe Integer"
Line5500_2:                            ; INPUT 1000+123;" x=";x
Line5520:                              ; PRINT "Ausgabe int Eingabe int"
Line5520_1:                            ; INPUT "x=";(x);" y=";y
Line5530:                              ; PRINT "Eingabe String"
Line5530_1:                            ; INPUT INK 5;"text:";t$
Line5540:                              ; PRINT "Eingabe String"
Line5540_1:                            ; INPUT (t$);" name="; LINE n$
Line5550:                              ; PRINT "Eingabe Float"
Line5550_1:                            ; INPUT "pi=";zz
Line5560:                              ; PRINT "x=";x,"y=";y
Line5570:                              ; PRINT "t$=";t$
Line5570_1:                            ; PRINT "n$=";n$
Line5580:                              ; PRINT "zz=";zz
Line5599:                              ; GO TO 3600
   JP Line16

Line5600:                              ; CLS
Line5600_1:                            ; PRINT "string to float"
Line5610:                              ; LET f1=0
   LD   DE,0
   CALL StackShortInt                  ; Stack Signed Word (0)

   LD   DE,(Var_f1)                    ; Address the var in VARS area
   CALL UpdateNumVar


Line5610_1:                            ; LET f2=0.1
   LD   A,125
   LD   DE,52300
   LD   BC,52684
   CALL $2AB6                          ; [ROM] STACK-STORE (0.1)

   LD   DE,(Var_f2)                    ; Address the var in VARS area
   CALL UpdateNumVar


Line5620:                              ; LET a$="123.456"
   LD   HL,String1
   CALL StackStringVar                 ; Stack String Const ("Hallo")

   LD   DE,(Var_a_str)                 ; Address the var in VARS area
   LD   BC,Var_a_str
   PUSH BC
   CALL UpdateStrVar


Line5630:                              ; LET i=1
   LD   DE,256
   CALL StackShortInt                  ; Stack Signed Word (1)

   LD   DE,(Var_i)                     ; Address the var in VARS area
   CALL UpdateNumVar


Line5640:                              ; IF i>LEN a$ THEN GO TO 5800
   JP Line168

Line5641:                              ; LET char= CODE a$(i)
   LD   DE,(Var_char)                  ; Address the var in VARS area
   CALL UpdateNumVar


Line5645:                              ; IF char=46 THEN GO TO 5700
   JP Line68

Line5650:                              ; IF char<48 OR char>58 THEN GO TO 5800
   JP Line168

Line5660:                              ; LET f1=f1*10+(char-48)
   LD   HL,(Var_f1)                    ; Address the var in VARS area
   CALL StackNumericVar

   LD   DE,2560
   CALL StackShortInt                  ; Stack Signed Word (10)

   CALL GetTwoStackedNumbers
   CALL $30CA                          ; [ROM] Call the Multiplication routine.
   CALL ReclaimStackItem

   LD   HL,(Var_char)                  ; Address the var in VARS area
   CALL StackNumericVar

   LD   DE,12288
   CALL StackShortInt                  ; Stack Signed Word (48)

   CALL GetTwoStackedNumbers
   CALL $300F                          ; [ROM] Call the Subtraction routine.
   CALL ReclaimStackItem

   CALL GetTwoStackedNumbers
   CALL $3014                          ; [ROM] Call the Addition routine.
   CALL ReclaimStackItem

   LD   DE,(Var_f1)                    ; Address the var in VARS area
   CALL UpdateNumVar


Line5670:                              ; LET i=i+1
   LD   HL,(Var_i)                     ; Address the var in VARS area
   CALL StackNumericVar

   LD   DE,256
   CALL StackShortInt                  ; Stack Signed Word (1)

   CALL GetTwoStackedNumbers
   CALL $3014                          ; [ROM] Call the Addition routine.
   CALL ReclaimStackItem

   LD   DE,(Var_i)                     ; Address the var in VARS area
   CALL UpdateNumVar


Line5670_1:                            ; GO TO 5640
   JP Line8

Line5700:                              ; LET i=i+1
   LD   HL,(Var_i)                     ; Address the var in VARS area
   CALL StackNumericVar

   LD   DE,256
   CALL StackShortInt                  ; Stack Signed Word (1)

   CALL GetTwoStackedNumbers
   CALL $3014                          ; [ROM] Call the Addition routine.
   CALL ReclaimStackItem

   LD   DE,(Var_i)                     ; Address the var in VARS area
   CALL UpdateNumVar


Line5705:                              ; IF i>LEN a$ THEN GO TO 5800
   JP Line168

Line5710:                              ; LET char= CODE a$(i)
   LD   DE,(Var_char)                  ; Address the var in VARS area
   CALL UpdateNumVar


Line5720:                              ; LET f1=f1+f2*(char-48)
   LD   HL,(Var_f1)                    ; Address the var in VARS area
   CALL StackNumericVar

   LD   HL,(Var_f2)                    ; Address the var in VARS area
   CALL StackNumericVar

   LD   HL,(Var_char)                  ; Address the var in VARS area
   CALL StackNumericVar

   LD   DE,12288
   CALL StackShortInt                  ; Stack Signed Word (48)

   CALL GetTwoStackedNumbers
   CALL $300F                          ; [ROM] Call the Subtraction routine.
   CALL ReclaimStackItem

   CALL GetTwoStackedNumbers
   CALL $30CA                          ; [ROM] Call the Multiplication routine.
   CALL ReclaimStackItem

   CALL GetTwoStackedNumbers
   CALL $3014                          ; [ROM] Call the Addition routine.
   CALL ReclaimStackItem

   LD   DE,(Var_f1)                    ; Address the var in VARS area
   CALL UpdateNumVar


Line5735:                              ; LET f2=f2/10
   LD   HL,(Var_f2)                    ; Address the var in VARS area
   CALL StackNumericVar

   LD   DE,2560
   CALL StackShortInt                  ; Stack Signed Word (10)

   CALL GetTwoStackedNumbers
   CALL $31AF                          ; [ROM] Call the Division routine.
   CALL ReclaimStackItem

   LD   DE,(Var_f2)                    ; Address the var in VARS area
   CALL UpdateNumVar


Line5740:                              ; GO TO 5700
   JP Line68

Line5800:                              ; PRINT a$;" = ";f1
Line5810:                              ; GO TO 3600
   JP Line16

Line5900:                              ; CLS
Line5900_1:                            ; PRINT "beep and border"
Line5910:                              ; BEEP 1,0
Line5910_1:                            ; BEEP 1,2
Line5910_2:                            ; BEEP 0.5,3
Line5910_3:                            ; BEEP 0.5,2
Line5910_4:                            ; BEEP 1,0
Line5920:                              ; BEEP 1,0
Line5920_1:                            ; BEEP 1,2
Line5920_2:                            ; BEEP 0.5,3
Line5920_3:                            ; BEEP 0.5,2
Line5920_4:                            ; BEEP 1,0
Line5930:                              ; BEEP 1,3
Line5930_1:                            ; BEEP 1,5
Line5930_2:                            ; BEEP 2,7
Line5940:                              ; BEEP 1,3
Line5940_1:                            ; BEEP 1,5
Line5940_2:                            ; BEEP 2,7
Line5950:                              ; BEEP 0.75,7
Line5950_1:                            ; BEEP 0.25,8
Line5950_2:                            ; BEEP 0.5,7
Line5950_3:                            ; BEEP 0.5,5
Line5950_4:                            ; BEEP 0.5,3
Line5950_5:                            ; BEEP 1,0
Line5960:                              ; BEEP 0.75,7
Line5960_1:                            ; BEEP 0.25,8
Line5960_2:                            ; BEEP 0.5,7
Line5960_3:                            ; BEEP 0.5,5
Line5960_4:                            ; BEEP 0.5,3
Line5960_5:                            ; BEEP 0.5,2
Line5960_6:                            ; BEEP 1,0
Line5970:                              ; BEEP 1,0
Line5970_1:                            ; BEEP 1,0.0-5.0
Line5970_2:                            ; BEEP 2,0
Line5980:                              ; BEEP 1,0
Line5980_1:                            ; BEEP 1,0.0-5.0
Line5980_2:                            ; BEEP 2,0
Line5990:                              ; FOR i=1 TO 5000
   LD   DE,256                         ; STEP not present - assume 1.
   CALL StackShortInt

   LD   A,0
   LD   DE,34816
   LD   BC,19
   CALL $2AB6                          ; [ROM] STACK-STORE (5000)

   LD   DE,256
   CALL StackShortInt                  ; Stack Signed Word (1)

   LD   DE,(Var_i)                     ; Address the var in VARS area
   LD   BC,Line5990_1                  ; Store the address of the next line
   CALL UpdateFORVar


Line5990_1:                            ; FOR j=0 TO 7
   LD   DE,256                         ; STEP not present - assume 1.
   CALL StackShortInt

   LD   DE,1792
   CALL StackShortInt                  ; Stack Signed Word (7)

   LD   DE,0
   CALL StackShortInt                  ; Stack Signed Word (0)

   LD   DE,(Var_j)                     ; Address the var in VARS area
   LD   BC,Line5990_2                  ; Store the address of the next line
   CALL UpdateFORVar


Line5990_2:                            ; BORDER j
   LD   HL,(Var_j)                     ; Address the var in VARS area
   CALL StackNumericVar

   CALL $2DA2                          ; [ROM] Unstack to BC
   OUT  ($FE),A                        ; Set BORDER colour


Line5990_3:                            ; NEXT j
   LD   HL,(Var_j)                     ; Address the var in VARS area
   CALL DoNext                         ; And sort out the loop where necessary.


Line5990_4:                            ; NEXT i
   LD   HL,(Var_i)                     ; Address the var in VARS area
   CALL DoNext                         ; And sort out the loop where necessary.


Line5995:                              ; GO TO 3600
   JP Line16

Line6000:                              ; CLS
Line6000_1:                            ; PRINT "rnd and randomize"
Line6010:                              ; FOR i=1 TO 10000
   LD   DE,256                         ; STEP not present - assume 1.
   CALL StackShortInt

   LD   A,0
   LD   DE,4096
   LD   BC,39
   CALL $2AB6                          ; [ROM] STACK-STORE (10000)

   LD   DE,256
   CALL StackShortInt                  ; Stack Signed Word (1)

   LD   DE,(Var_i)                     ; Address the var in VARS area
   LD   BC,Line6020                    ; Store the address of the next line
   CALL UpdateFORVar


Line6020:                              ; LET x=RND*255.0
   CALL RNDReplacement                 ; Call the new RND Function.

   LD   DE,65280
   CALL StackShortInt                  ; Stack Signed Word (255)

   CALL GetTwoStackedNumbers
   CALL $30CA                          ; [ROM] Call the Multiplication routine.
   CALL ReclaimStackItem

   LD   DE,(Var_x)                     ; Address the var in VARS area
   CALL UpdateNumVar


Line6030:                              ; LET y=RND*150.0
   CALL RNDReplacement                 ; Call the new RND Function.

   LD   DE,38400
   CALL StackShortInt                  ; Stack Signed Word (150)

   CALL GetTwoStackedNumbers
   CALL $30CA                          ; [ROM] Call the Multiplication routine.
   CALL ReclaimStackItem

   LD   DE,(Var_y)                     ; Address the var in VARS area
   CALL UpdateNumVar


Line6040:                              ; PLOT x,y
Line6050:                              ; NEXT i
   LD   HL,(Var_i)                     ; Address the var in VARS area
   CALL DoNext                         ; And sort out the loop where necessary.


Line6060:                              ; GO TO 3600
   JP Line16

Line6100:                              ; CLS
Line6100_1:                            ; PRINT "Vergleiche: float"
Line6110:                              ; LET f1=10
   LD   DE,2560
   CALL StackShortInt                  ; Stack Signed Word (10)

   LD   DE,(Var_f1)                    ; Address the var in VARS area
   CALL UpdateNumVar


Line6110_1:                            ; LET f2=0
   LD   DE,0
   CALL StackShortInt                  ; Stack Signed Word (0)

   LD   DE,(Var_f2)                    ; Address the var in VARS area
   CALL UpdateNumVar


Line6110_2:                            ; GO SUB 6150
Line6115:                              ; LET f1=10
   LD   DE,2560
   CALL StackShortInt                  ; Stack Signed Word (10)

   LD   DE,(Var_f1)                    ; Address the var in VARS area
   CALL UpdateNumVar


Line6115_1:                            ; LET f2=10
   LD   DE,2560
   CALL StackShortInt                  ; Stack Signed Word (10)

   LD   DE,(Var_f2)                    ; Address the var in VARS area
   CALL UpdateNumVar


Line6115_2:                            ; GO SUB 6150
Line6120:                              ; LET f1=20
   LD   DE,5120
   CALL StackShortInt                  ; Stack Signed Word (20)

   LD   DE,(Var_f1)                    ; Address the var in VARS area
   CALL UpdateNumVar


Line6120_1:                            ; LET f2=10
   LD   DE,2560
   CALL StackShortInt                  ; Stack Signed Word (10)

   LD   DE,(Var_f2)                    ; Address the var in VARS area
   CALL UpdateNumVar


Line6120_2:                            ; GO SUB 6150
Line6125:                              ; LET f1=10
   LD   DE,2560
   CALL StackShortInt                  ; Stack Signed Word (10)

   LD   DE,(Var_f1)                    ; Address the var in VARS area
   CALL UpdateNumVar


Line6125_1:                            ; LET f2=20
   LD   DE,5120
   CALL StackShortInt                  ; Stack Signed Word (20)

   LD   DE,(Var_f2)                    ; Address the var in VARS area
   CALL UpdateNumVar


Line6125_2:                            ; GO SUB 6150
Line6130:                              ; GO TO 3600
   JP Line16

Line6140:                              ; PRINT "f1=";f1;" f2=";f2;" f3=";f3
Line6150:                              ; PRINT "-------"
Line6170:                              ; PRINT f1=f2;":";f1;"=";f2;" ";
Line6170_1:                            ; IF f1=f2 THEN PRINT "ja";
Line6175:                              ; PRINT ,
Line6180:                              ; PRINT f1<>f2;":";f1;"…";f2;" ";
Line6180_1:                            ; IF f1<>f2 THEN PRINT "ja";
Line6185:                              ; PRINT
Line6190:                              ; PRINT f1<=f2;":";f1;"«";f2;" ";
Line6190_1:                            ; IF f1<=f2 THEN PRINT "ja";
Line6195:                              ; PRINT ,
Line6200:                              ; PRINT f1>=f2;":";f1;"»";f2;" ";
Line6200_1:                            ; IF f1>=f2 THEN PRINT "ja";
Line6205:                              ; PRINT
Line6210:                              ; PRINT f1<f2;":";f1;"<";f2;" ";
Line6210_1:                            ; IF f1<f2 THEN PRINT "ja";
Line6215:                              ; PRINT ,
Line6220:                              ; PRINT f1>f2;":";f1;">";f2;" ";
Line6220_1:                            ; IF f1>f2 THEN PRINT "ja";
Line6225:                              ; PRINT
Line6230:                              ; RETURN
Line7000:                              ; CLS
Line7000_1:                            ; PRINT "Funktionen"
Line7000_2:                            ; PRINT
Line7005:                              ; PRINT "Œt(a,b)=a+b:Œu(a,b)=®t(a,a)+®t(b,b)"
Line7007:                              ; PRINT
Line7007_1:                            ; PRINT
Line7010:                              ; PRINT "®u(2,2)=";FN u(2,2)
Line7010_1:                            ; PRINT "®u(3,3)=";FN u(3,3)
Line7030:                              ; PRINT "®t(2,3)=";FN t(2,3)
Line7050:                              ; GO TO 3600
   JP Line16

Line9990:                              ; STOP
Line9991:                              ; ERASE "m";1;"run"
Line9992:                              ; SAVE *"m";1;"run" LINE 10
Line9999:                              ; SAVE "comptest11"
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

StackStringVar:
   LD   C,(HL)
   INC  HL
   LD   B,(HL)
   INC  HL
   PUSH HL                             ; Store the start of the string
   PUSH BC

   RST  30h                            ; Reserve BC Spaces at [WORKSP]
   POP  BC
   CALL $2AB6                          ; [ROM] STACK-STORE (String)

   POP  HL                             ; Restore the address of the source string
   LDIR                                ; and copy the source to [WORKSP]

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

UpdateStrVar:
   POP  BC                             ; Save the return address
   POP  IX                             ; Save the address of the Jump table entry that will be affected
   PUSH BC                             ; Restack the return address
   PUSH DE                             ; Store the VARS Address for later

   CALL $2BF1                          ; [ROM] Get the string parameters from the calculator stack

   POP  HL                             ; And get the address of the VARS space back.
   PUSH BC                             ; Store the length of the stacked var
   LD   E,(HL)                         ; Grab the current Var Length into DE, and...
   LD   (HL),C                         ; ...Update the variable length marker
   INC  HL
   LD   D,(HL)
   LD   (HL),B
   INC  HL                             ; HL now points at the start of the string
   PUSH HL                             ; and we'll need it later, so store it.

   PUSH BC
   LD   B,D                            ; Prepare to reclaim the old string - length to BC
   LD   C,E
   CALL $19E8                          ; [ROM] routine RECLAIM-2 to reclaim the old string.
   POP  BC
   INC  IX
   INC  IX                             ; This variables jump table entry does not need updating,
                                       ; But all subsequent vars do.
   EX   DE, HL                         ; Now Test - is the new string smaller than the old?
   AND  A
   SBC  HL, BC
   EX   DE, HL
   JR   NC, UpdateVarStringLarger      ; If it isnt then just carry on

   PUSH BC                             ; Store BC before it gets modified
   CALL UpdateJumpTableDec             ; Otherwise, jump into the next routine early to invert BC
   POP  BC                             ; and Restore BC for the actual MAKE-ROOM process
   JP   UpdateStrVarCont

UpdateVarStringLarger:
   CALL UpdateJumpTableAdd

UpdateStrVarCont:
   POP  HL

   CALL $1655                          ; [ROM] routine MAKE-ROOM creates BC spaces for new string
   LD   DE,($5C61)                     ; Get WORKSP into DE - the start of the string

   INC  HL                             ; advance to first new location.
   EX   DE,HL
   POP  BC                             ; Set up for LDIR - BC is length, DE is destination
   LDIR                                ; and HL is the source string to copy from

   CALL CleanWorkspace                 ; and... tidy up.
   RET

UpdateJumpTableDec:                    ; Adjust BC to move Backwards in memory
   LD   A,B
   CPL
   LD   B,A
   LD   A,C
   CPL
   LD   C,A
   INC  BC
UpdateJumpTableAdd:
   LD   A,$FF
   LD   L,(IX+0)                       ; Get the location from the table
   LD   H,(IX+1)
   CP   H                              ; Test with A (Is it $FF?)
   RET  Z                              ; Bail out if so
   ADD  HL,BC                          ; Otherwise, add the offset, and
   LD   (IX+0),L                       ; Update the table.
   LD   (IX+1),H
   INC  IX
   INC  IX
   JP   UpdateJumpTableAdd             ; Go back and do the next one

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

RNDReplacement:
   LD   BC,($5C76)                     ; fetch system variable SEED
   CALL $2D2B                          ; routine STACK-BC places on calculator stack
   RST  28H                            ;; FP-CALC            ;s.
   DEFB $A1                            ;; stk-one            ;s,1.
   DEFB $0F                            ;; addition           ;s+1.
   DEFB $34                            ;; stk-data           ;
   DEFB $37                            ;; Exponent: $87,
                                       ;; Bytes: 1
   DEFB $16                            ;; (+00,+00,+00)      ;s+1,75.
   DEFB $04                            ;; multiply           ;(s+1)*75 = v
   DEFB $34                            ;; stk-data           ;v.
   DEFB $80                            ;; Bytes: 3
   DEFB $41                            ;; Exponent $91
   DEFB $00,$00,$80                    ;; (+00)              ;v,65537.
   DEFB $32                            ;; n-mod-m            ;remainder, result.
   DEFB $02                            ;; delete             ;remainder.
   DEFB $A1                            ;; stk-one            ;remainder, 1.
   DEFB $03                            ;; subtract           ;remainder - 1. = rnd
   DEFB $31                            ;; duplicate          ;rnd,rnd.
   DEFB $38                            ;; end-calc

   CALL $2DA2                          ; routine FP-TO-BC
   LD   ($5C76),BC                     ; store in SEED for next starting point.
   LD   A,(HL)                         ; fetch exponent
   AND  A                              ; is it zero ?
   RET  Z                              ; exit if so.

   SUB  $10                            ; reduce exponent by 2^16
   LD   (HL),A                         ; place back
   RET

CleanWorkspace:
   LD   HL,($5C63)                     ; Fetch STKBOT
   LD   DE,($5C61)                     ; Fetch start of Workspace
   CALL $19E5                          ; [ROM] Reclaim the Workspace
   RET

AllocateVars:
   LD   BC,($5CB2)
   LD   DE,($5C4B)
   LD   HL,($5C59)
   DEC  HL
   CALL $19E5                          ; Clear any current variables

   LD   IX,Var_af                      ; set IX up to point at the jump table
   LD   BC,484                         ; Allocate space for Variables
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

   DEFB 5,0,2,0
   DEFB 161,"f"+$80                    ; af
   DEFB 0,0,0,0,0                      ; Initial filler bytes
   DEFB 5,0,2,0
   DEFB 162,"f"+$80                    ; bf
   DEFB 0,0,0,0,0                      ; Initial filler bytes
   DEFB 5,0,2,0
   DEFB 163,"f"+$80                    ; cf
   DEFB 0,0,0,0,0                      ; Initial filler bytes
   DEFB 5,0,2,0
   DEFB 161,"i"+$80                    ; ai
   DEFB 0,0,0,0,0                      ; Initial filler bytes
   DEFB 5,0,2,0
   DEFB 162,"i"+$80                    ; bi
   DEFB 0,0,0,0,0                      ; Initial filler bytes
   DEFB 5,0,2,0
   DEFB 163,"i"+$80                    ; ci
   DEFB 0,0,0,0,0                      ; Initial filler bytes
   DEFB 5,0,2,0
   DEFB 164,"f"+$80                    ; df
   DEFB 0,0,0,0,0                      ; Initial filler bytes
   DEFB 5,0,2,0
   DEFB 164,"i"+$80                    ; di
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
   DEFB 5,0,3,0
   DEFB 161,"d","r"+$80                ; adr
   DEFB 0,0,0,0,0                      ; Initial filler bytes
   DEFB 18,0,1,0
   DEFB 108                            ; l
   DEFB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Initial filler bytes
   DEFB 5,0,4,0
   DEFB 161,"dr","l"+$80               ; adrl
   DEFB 0,0,0,0,0                      ; Initial filler bytes
   DEFB 18,0,1,0
   DEFB 112                            ; p
   DEFB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Initial filler bytes
   DEFB 5,0,3,0
   DEFB 176,"o","s"+$80                ; pos
   DEFB 0,0,0,0,0                      ; Initial filler bytes
   DEFB 18,0,1,0
   DEFB 106                            ; j
   DEFB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Initial filler bytes
   DEFB 5,0,1,0
   DEFB 107                            ; k
   DEFB 0,0,0,0,0                      ; Initial filler bytes
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
   DEFB 10,0,7,0
   DEFB 161,"_arra","y"+$80            ; a_array
   DEFB 0,0,0,0,0,0,0,0,0,0            ; Initial filler bytes
   DEFB 5,0,7,0
   DEFB 161,"_arra","y"+$80            ; a_array
   DEFB 0,0,0,0,0                      ; Initial filler bytes
   DEFB 5,0,1,0
   DEFB 122                            ; z
   DEFB 0,0,0,0,0                      ; Initial filler bytes
   DEFB 5,0,2,0
   DEFB 176,"i"+$80                    ; pi
   DEFB 0,0,0,0,0                      ; Initial filler bytes
   DEFB 5,0,2,0
   DEFB 186,"z"+$80                    ; zz
   DEFB 0,0,0,0,0                      ; Initial filler bytes
   DEFB 5,0,2,0
   DEFB 166,"1"+$80                    ; f1
   DEFB 0,0,0,0,0                      ; Initial filler bytes
   DEFB 5,0,2,0
   DEFB 166,"2"+$80                    ; f2
   DEFB 0,0,0,0,0                      ; Initial filler bytes
   DEFB 5,0,2,0
   DEFB 169,"1"+$80                    ; i1
   DEFB 0,0,0,0,0                      ; Initial filler bytes
   DEFB 5,0,2,0
   DEFB 169,"2"+$80                    ; i2
   DEFB 0,0,0,0,0                      ; Initial filler bytes
   DEFB 5,0,2,0
   DEFB 166,"3"+$80                    ; f3
   DEFB 0,0,0,0,0                      ; Initial filler bytes
   DEFB 5,0,1,0
   DEFB 99                             ; c
   DEFB 0,0,0,0,0                      ; Initial filler bytes
   DEFB 18,0,1,0
   DEFB 120                            ; x
   DEFB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Initial filler bytes
   DEFB 5,0,2,0
   DEFB 184,"f"+$80                    ; xf
   DEFB 0,0,0,0,0                      ; Initial filler bytes
   DEFB 5,0,2,0
   DEFB 185,"f"+$80                    ; yf
   DEFB 0,0,0,0,0                      ; Initial filler bytes
   DEFB 5,0,2,0
   DEFB 169,"x"+$80                    ; ix
   DEFB 0,0,0,0,0                      ; Initial filler bytes
   DEFB 5,0,2,0
   DEFB 174,"f"+$80                    ; nf
   DEFB 0,0,0,0,0                      ; Initial filler bytes
   DEFB 5,0,2,0
   DEFB 173,"y"+$80                    ; my
   DEFB 0,0,0,0,0                      ; Initial filler bytes
   DEFB 5,0,2,0
   DEFB 173,"x"+$80                    ; mx
   DEFB 0,0,0,0,0                      ; Initial filler bytes
   DEFB 5,0,2,0
   DEFB 186,"i"+$80                    ; zi
   DEFB 0,0,0,0,0                      ; Initial filler bytes
   DEFB 5,0,2,0
   DEFB 186,"t"+$80                    ; zt
   DEFB 0,0,0,0,0                      ; Initial filler bytes
   DEFB 18,0,1,0
   DEFB 102                            ; f
   DEFB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Initial filler bytes
   DEFB 5,0,4,0
   DEFB 180,"im","e"+$80               ; time
   DEFB 0,0,0,0,0                      ; Initial filler bytes
   DEFB 5,0,9,0
   DEFB 180,"imestar","t"+$80          ; timestart
   DEFB 0,0,0,0,0                      ; Initial filler bytes
   DEFB 5,0,4,0
   DEFB 163,"ha","r"+$80               ; char
   DEFB 0,0,0,0,0                      ; Initial filler bytes
   DEFB 2,0,1,0
   DEFB 65                             ; a_str
   DEFB 0,0                            ; Initial filler bytes
   DEFB 2,0,1,0
   DEFB 66                             ; b_str
   DEFB 0,0,0,0,0,0                    ; Initial filler bytes
   DEFB 2,0,1,0
   DEFB 66                             ; b_str
   DEFB 0,0                            ; Initial filler bytes
   DEFB 2,0,1,0
   DEFB 88                             ; x_str
   DEFB 0,0                            ; Initial filler bytes

                                       ; Here follows the Variables jump table
Var_af:
   DEFB 0,0
Var_bf:
   DEFB 0,0
Var_cf:
   DEFB 0,0
Var_ai:
   DEFB 0,0
Var_bi:
   DEFB 0,0
Var_ci:
   DEFB 0,0
Var_df:
   DEFB 0,0
Var_di:
   DEFB 0,0
Var_y:
   DEFB 0,0
Var_dx:
   DEFB 0,0
Var_dy:
   DEFB 0,0
Var_i:
   DEFB 0,0
Var_adr:
   DEFB 0,0
Var_l:
   DEFB 0,0
Var_adrl:
   DEFB 0,0
Var_p:
   DEFB 0,0
Var_pos:
   DEFB 0,0
Var_j:
   DEFB 0,0
Var_k:
   DEFB 0,0
Var_ticks:
   DEFB 0,0
Var_tsec:
   DEFB 0,0
Var_min:
   DEFB 0,0
Var_sec:
   DEFB 0,0
Var_a_array:
   DEFB 0,0
Var_a_array:
   DEFB 0,0
Var_z:
   DEFB 0,0
Var_pi:
   DEFB 0,0
Var_zz:
   DEFB 0,0
Var_f1:
   DEFB 0,0
Var_f2:
   DEFB 0,0
Var_i1:
   DEFB 0,0
Var_i2:
   DEFB 0,0
Var_f3:
   DEFB 0,0
Var_c:
   DEFB 0,0
Var_x:
   DEFB 0,0
Var_xf:
   DEFB 0,0
Var_yf:
   DEFB 0,0
Var_ix:
   DEFB 0,0
Var_nf:
   DEFB 0,0
Var_my:
   DEFB 0,0
Var_mx:
   DEFB 0,0
Var_zi:
   DEFB 0,0
Var_zt:
   DEFB 0,0
Var_f:
   DEFB 0,0
Var_time:
   DEFB 0,0
Var_timestart:
   DEFB 0,0
Var_char:
   DEFB 0,0
Var_a_str:
   DEFB 0,0
Var_b_str:
   DEFB 0,0
Var_b_str:
   DEFB 0,0
Var_x_str:
   DEFB 0,0
EndOfVars:
   DEFB 255,255

                                       ; String Constants Follow

String0:
   DEFB 4,0,"1234"
String1:
   DEFB 5,0,"Hallo"
String2:
   DEFB 19,0,"Scroll in Assembler"
String3:
   DEFB 8,0,"demo.asm"
String4:
   DEFB 1,0,"A"
String5:
   DEFB 7,0,"UDG:êëí"
String6:
   DEFB 4,0,"Menu"
String7:
   DEFB 7,0," 1 Plot"
String8:
   DEFB 13,0," 2 Array Test"
String9:
   DEFB 18,0," 3 Scroll in Basic"
String10:
   DEFB 11,0," 4 Data+UDG"
String11:
   DEFB 11,0," 5 Mult+Div"
String12:
   DEFB 10,0," 6 Strings"
String13:
   DEFB 8,0," 7 Float"
String14:
   DEFB 10,0," 8 SIN/COS"
String15:
   DEFB 13,0," 9 Mandelbrot"
String16:
   DEFB 14,0," 0 FOR TO STEP"
String17:
   DEFB 8,0," A Input"
String18:
   DEFB 18,0," B String to Float"
String19:
   DEFB 18,0," C Beep and Border"
String20:
   DEFB 6,0," D RND"
String21:
   DEFB 13,0," E Vergleiche"
String22:
   DEFB 9,0," F DEF FN"
String23:
   DEFB 10,0,"H Heapwalk"
String24:
   DEFB 2,0,"  "
String25:
   DEFB 19,0,"Zeichne 5000 Punkte"
String26:
   DEFB 13,0,"Screen Scroll"
String27:
   DEFB 8,0,"in Basic"
String28:
   DEFB 1,0,"e"
String29:
   DEFB 1,0,"E"
String30:
   DEFB 1,0,"f"
String31:
   DEFB 1,0,"F"
String32:
   DEFB 22,0,"Weiter mit Tastendruck"
String33:
   DEFB 7,0," ticks "
String34:
   DEFB 1,0,":"
String35:
   DEFB 12,0," Press a key"
String36:
   DEFB 1,0," "
String37:
   DEFB 1,0," "
String38:
   DEFB 1,0," "
String39:
   DEFB 6,0,"Zeile "
String40:
   DEFB 1,0," "
String41:
   DEFB 26,0,"Multiplizieren, Dividieren"
String42:
   DEFB 2,0,"x*"
String43:
   DEFB 1,0,"="
String44:
   DEFB 1,0," "
String45:
   DEFB 15,0,"Mult/Div signed"
String46:
   DEFB 4,0,"1234"
String47:
   DEFB 3,0,"a$="
String48:
   DEFB 7,0,"val a$="
String49:
   DEFB 6,0,"start="
String50:
   DEFB 5,0,"ende="
String51:
   DEFB 6,0,"mitte="
String52:
   DEFB 7,0,"2.Byte="
String53:
   DEFB 0,0,""
String54:
   DEFB 28,0,"test float und float mit int"
String55:
   DEFB 3,0,"pi="
String56:
   DEFB 7,0,"var pi="
String57:
   DEFB 3,0,"zz="
String58:
   DEFB 3,0,"f1="
String59:
   DEFB 4,0," f2="
String60:
   DEFB 3,0,"i1="
String61:
   DEFB 4,0," i2="
String62:
   DEFB 6,0,"f1/f2="
String63:
   DEFB 6,0,"10-f3="
String64:
   DEFB 6,0,"f3-10="
String65:
   DEFB 7,0,"STKBOT="
String66:
   DEFB 7,0,"STKEND="
String67:
   DEFB 11,0,"SIN und COS"
String68:
   DEFB 10,0,"Mandelbrot"
String69:
   DEFB 2,0,"x="
String70:
   DEFB 4,0,"    "
String71:
   DEFB 5,0,"time="
String72:
   DEFB 11,0,"FOR .. STEP"
String73:
   DEFB 7,0,"Integer"
String74:
   DEFB 2,0,", "
String75:
   DEFB 11,0,"for mit int"
String76:
   DEFB 2,0,", "
String77:
   DEFB 15,0,"for int step -1"
String78:
   DEFB 2,0,", "
String79:
   DEFB 32,0,"for int. fp param convert to int"
String80:
   DEFB 1,0," "
String81:
   DEFB 10,0,"for mit fp"
String82:
   DEFB 1,0," "
String83:
   DEFB 11,0,"for fp step"
String84:
   DEFB 1,0," "
String85:
   DEFB 11,0,"for fp step"
String86:
   DEFB 1,0," "
String87:
   DEFB 15,0,"Eingabe Integer"
String88:
   DEFB 3,0," x="
String89:
   DEFB 23,0,"Ausgabe int Eingabe int"
String90:
   DEFB 2,0,"x="
String91:
   DEFB 3,0," y="
String92:
   DEFB 14,0,"Eingabe String"
String93:
   DEFB 5,0,"text:"
String94:
   DEFB 14,0,"Eingabe String"
String95:
   DEFB 6,0," name="
String96:
   DEFB 13,0,"Eingabe Float"
String97:
   DEFB 3,0,"pi="
String98:
   DEFB 2,0,"x="
String99:
   DEFB 2,0,"y="
String100:
   DEFB 3,0,"t$="
String101:
   DEFB 3,0,"n$="
String102:
   DEFB 3,0,"zz="
String103:
   DEFB 15,0,"string to float"
String104:
   DEFB 7,0,"123.456"
String105:
   DEFB 3,0," = "
String106:
   DEFB 15,0,"beep and border"
String107:
   DEFB 17,0,"rnd and randomize"
String108:
   DEFB 17,0,"Vergleiche: float"
String109:
   DEFB 3,0,"f1="
String110:
   DEFB 4,0," f2="
String111:
   DEFB 4,0," f3="
String112:
   DEFB 7,0,"-------"
String113:
   DEFB 1,0,":"
String114:
   DEFB 1,0,"="
String115:
   DEFB 1,0," "
String116:
   DEFB 2,0,"ja"
String117:
   DEFB 1,0,":"
String118:
   DEFB 1,0,"…"
String119:
   DEFB 1,0," "
String120:
   DEFB 2,0,"ja"
String121:
   DEFB 1,0,":"
String122:
   DEFB 1,0,"«"
String123:
   DEFB 1,0," "
String124:
   DEFB 2,0,"ja"
String125:
   DEFB 1,0,":"
String126:
   DEFB 1,0,"»"
String127:
   DEFB 1,0," "
String128:
   DEFB 2,0,"ja"
String129:
   DEFB 1,0,":"
String130:
   DEFB 1,0,"<"
String131:
   DEFB 1,0," "
String132:
   DEFB 2,0,"ja"
String133:
   DEFB 1,0,":"
String134:
   DEFB 1,0,">"
String135:
   DEFB 1,0," "
String136:
   DEFB 2,0,"ja"
String137:
   DEFB 10,0,"Funktionen"
String138:
   DEFB 35,0,"Œt(a,b)=a+b:Œu(a,b)=®t(a,a)+®t(b,b)"
String139:
   DEFB 8,0,"®u(2,2)="
String140:
   DEFB 8,0,"®u(3,3)="
String141:
   DEFB 8,0,"®t(2,3)="
String142:
   DEFB 1,0,"m"
String143:
   DEFB 3,0,"run"
String144:
   DEFB 1,0,"m"
String145:
   DEFB 3,0,"run"
String146:
   DEFB 10,0,"comptest11"
