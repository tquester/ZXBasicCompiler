
CBASIC_START
compiledBasic:
	call ZXHeapClear
	LD (runtimeSaveSP),SP
ZX_LINE_10:
ZX_LINE_15:
; 15  REM float af bf cf
ZX_LINE_17:
; 17  LET af=123.4{87 76 cc cc cd }: LET bf=3.14{82 48 f5 c2 8f }
	LD HL,FLOAT_1
	CALL runtimePushFloatVar
	LD HL,ZXBASIC_VAR_af
	CALL runtimeStoreFloat
	LD HL,FLOAT_2
	CALL runtimePushFloatVar
	LD HL,ZXBASIC_VAR_bf
	CALL runtimeStoreFloat
ZX_LINE_18:
; 18  LET cf=af+bf
	LD HL,ZXBASIC_VAR_af
	CALL runtimePushFloatVar
	LD HL,ZXBASIC_VAR_bf
	CALL runtimePushFloatVar
	CALL runtimePlusFloat
	LD HL,ZXBASIC_VAR_cf
	CALL runtimeStoreFloat
ZX_LINE_19:
; 19  PRINT af,bf,cf
	LD HL,ZXBASIC_VAR_af
	CALL runtimePushFloatVar
	CALL runtimePrintFloat
	CALL runtimePrintTab
	LD HL,ZXBASIC_VAR_bf
	CALL runtimePushFloatVar
	CALL runtimePrintFloat
	CALL runtimePrintTab
	LD HL,ZXBASIC_VAR_cf
	CALL runtimePushFloatVar
	CALL runtimePrintFloat
	CALL runtimePrintNewline
ZX_LINE_20:
; 20  LET a=1{00 00 01 00 00 }
	LD HL,1
	LD (ZXBASIC_VAR_a),HL
ZX_LINE_30:
; 30  LET a=a+1{00 00 01 00 00 }
	LD HL,(ZXBASIC_VAR_a)
	INC HL
	LD (ZXBASIC_VAR_a),HL
ZX_LINE_40:
; 40  LET a=a-1{00 00 01 00 00 }
	LD HL,(ZXBASIC_VAR_a)
	DEC HL
	LD (ZXBASIC_VAR_a),HL
ZX_LINE_100:
; 100  PAPER 6 {00 00 06 00 00 }: INK 1{00 00 01 00 00 }
	LD HL,6 
	CALL runtimePaper
	LD HL,1
	CALL runtimeInk
ZX_LINE_105:
; 105  CLS 
	CALL runtimeCls
ZX_LINE_106:
; 106  GOTO 3300{00 00 e4 0c 00 }
	JP ZX_LINE_3300
ZX_LINE_110:
; 110  LET a$="1234"
	LD HL,STRING_0	;1234
	PUSH HL
	POP DE
	LD HL,ZXBASIC_VAR_a_string
	CALL runtimeStoreString
ZX_LINE_120:
; 120  PRINT a$(1{00 00 01 00 00 } TO 2{00 00 02 00 00 })
	LD HL,(ZXBASIC_VAR_a_string)
	PUSH HL
	LD DE,1
	LD HL,2
	POP BC
	CALL runtimeSubstring
	CALL runtimePrintString
	CALL runtimePrintNewline
	CALL ZXFreeTempCompact
ZX_LINE_130:
; 130  DIM b$(10{00 00 0a 00 00 })
ZX_LINE_135:
; 135  LET b$(1{00 00 01 00 00 })="Hallo"
	LD HL,1
	ADD HL,HL
	PUSH HL
	LD HL,STRING_1	;Hallo
	PUSH HL
	POP DE
	POP HL
	LD BC,ZXBASIC_VAR_b_string
	ADD HL,BC
	LD (HL),DE
ZX_LINE_140:
; 140  PRINT b$(1{00 00 01 00 00 })(2{00 00 02 00 00 } TO )(1{00 00 01 00 00 } TO )
	LD HL,1
	ADD HL,HL
	LD DE, ZXBASIC_VAR_b_string
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD DE,2
	LD HL,-1
	POP BC
	CALL runtimeSubstring
	PUSH HL
	LD DE,1
	LD HL,-1
	POP BC
	CALL runtimeSubstring
	CALL runtimePrintString
	CALL runtimePrintNewline
	CALL ZXFreeTempCompact
ZX_LINE_1000:
; 1000  LET x=1{00 00 01 00 00 }: LET y=21{00 00 15 00 00 }: LET dx=1{00 00 01 00 00 }: LET dy=1{00 00 01 00 00 }
	LD HL,1
	LD (ZXBASIC_VAR_x),HL
	LD HL,21
	LD (ZXBASIC_VAR_y),HL
	LD HL,1
	LD (ZXBASIC_VAR_dx),HL
	LD HL,1
	LD (ZXBASIC_VAR_dy),HL
ZX_LINE_1005:
; 1005  FOR i=1{00 00 01 00 00 } TO 5000{00 00 88 13 00 }
	LD HL,1
	LD (ZXBASIC_VAR_i),HL
	LD HL,5000
	LD (ZXBASIC_VAR_for_i),HL
	LD HL,1
	LD (ZXBASIC_VAR_for_i_step),HL
FOR_0:
ZX_LINE_1010:
; 1010  PLOT  OVER 1{00 00 01 00 00 }; INK 3{00 00 03 00 00 };x,y
	LD HL,1
	CALL runtimeLocalOver
	LD HL,3
	CALL runtimeLocalInk
	LD DE,(ZXBASIC_VAR_x)
	LD HL,(ZXBASIC_VAR_y)
	CALL runtimePlot
ZX_LINE_1020:
; 1020  LET x=x+dx
	LD DE,(ZXBASIC_VAR_x)
	LD HL,(ZXBASIC_VAR_dx)
	ADD HL,DE
	LD (ZXBASIC_VAR_x),HL
ZX_LINE_1030:
; 1030  LET y=y+dy
	LD DE,(ZXBASIC_VAR_y)
	LD HL,(ZXBASIC_VAR_dy)
	ADD HL,DE
	LD (ZXBASIC_VAR_y),HL
ZX_LINE_1040:
; 1040  IF x <= 1{00 00 01 00 00 } ORX x >= 250{00 00 fa 00 00 } THEN  LET dx=0{00 00 00 00 00 }-dx
	LD DE,(ZXBASIC_VAR_x)
	LD HL,1
	SUB HL,DE
	LD HL,0
	call nc,HL1
	call z,HL1
	PUSH HL
	LD DE,(ZXBASIC_VAR_x)
	LD HL,250
	SUB HL,DE
	LD HL,0
	call c,HL1
	call z,HL1
	POP DE
	LD A,L
	OR E
	LD L,A
	LD H,0
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_1
	LD HL,0
	LD DE,(ZXBASIC_VAR_dx)
	SUB HL,DE
	LD (ZXBASIC_VAR_dx),HL
ZXB_LABEL_1:
ZX_LINE_1050:
; 1050  IF y <= 20{00 00 14 00 00 } ORX y >= 160{00 00 a0 00 00 } THEN  LET dy=0{00 00 00 00 00 }-dy
	LD DE,(ZXBASIC_VAR_y)
	LD HL,20
	SUB HL,DE
	LD HL,0
	call nc,HL1
	call z,HL1
	PUSH HL
	LD DE,(ZXBASIC_VAR_y)
	LD HL,160
	SUB HL,DE
	LD HL,0
	call c,HL1
	call z,HL1
	POP DE
	LD A,L
	OR E
	LD L,A
	LD H,0
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_2
	LD HL,0
	LD DE,(ZXBASIC_VAR_dy)
	SUB HL,DE
	LD (ZXBASIC_VAR_dy),HL
ZXB_LABEL_2:
ZX_LINE_1060:
; 1060  NEXT i
	LD HL,(ZXBASIC_VAR_i)
	LD BC,(ZXBASIC_VAR_for_i_step)
	ADD HL,BC
	LD (ZXBASIC_VAR_i),HL
	LD DE,(ZXBASIC_VAR_for_i)
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_0
ZX_LINE_1070:
; 1070  RETURN 
	RET
ZX_LINE_1100:
; 1100  REM 
ZX_LINE_1120:
; 1120  FOR i=0{00 00 00 00 00 } TO 255{00 00 ff 00 00 } STEP 3{00 00 03 00 00 }
	LD HL,0
	LD (ZXBASIC_VAR_i),HL
	LD HL,255
	LD (ZXBASIC_VAR_for_i),HL
	LD HL,3
	LD (ZXBASIC_VAR_for_i_step),HL
FOR_1:
ZX_LINE_1130:
; 1130  PLOT  INK 1{00 00 01 00 00 };i,0{00 00 00 00 00 }
	LD HL,1
	CALL runtimeLocalInk
	LD DE,(ZXBASIC_VAR_i)
	LD HL,0
	CALL runtimePlot
ZX_LINE_1140:
; 1140  DRAW  INK 1{00 00 01 00 00 };255{00 00 ff 00 00 }-i,170{00 00 aa 00 00 }
	LD HL,1
	CALL runtimeLocalInk
	LD HL,255
	LD DE,(ZXBASIC_VAR_i)
	SUB HL,DE
	LD DE,HL
	LD HL,170
	LD B,L
	LD C,E
	CALL runtimeDraw
ZX_LINE_1150:
; 1150  NEXT i
	LD HL,(ZXBASIC_VAR_i)
	LD BC,(ZXBASIC_VAR_for_i_step)
	ADD HL,BC
	LD (ZXBASIC_VAR_i),HL
	LD DE,(ZXBASIC_VAR_for_i)
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_1
ZX_LINE_1155:
; 1155  RETURN 
	RET
ZX_LINE_1160:
; 1160  FOR i=1{00 00 01 00 00 } TO 170{00 00 aa 00 00 } STEP 3{00 00 03 00 00 }
	LD HL,1
	LD (ZXBASIC_VAR_i),HL
	LD HL,170
	LD (ZXBASIC_VAR_for_i),HL
	LD HL,3
	LD (ZXBASIC_VAR_for_i_step),HL
FOR_2:
ZX_LINE_1170:
; 1170  PLOT  INK 2{00 00 02 00 00 };0{00 00 00 00 00 },i
	LD HL,2
	CALL runtimeLocalInk
	LD DE,0
	LD HL,(ZXBASIC_VAR_i)
	CALL runtimePlot
ZX_LINE_1180:
; 1180  DRAW  INK 2{00 00 02 00 00 };255{00 00 ff 00 00 },170{00 00 aa 00 00 }-i
	LD HL,2
	CALL runtimeLocalInk
	LD HL,255
	PUSH HL
	LD HL,170
	LD DE,(ZXBASIC_VAR_i)
	SUB HL,DE
	POP DE
	LD B,L
	LD C,E
	CALL runtimeDraw
ZX_LINE_1190:
; 1190  NEXT i
	LD HL,(ZXBASIC_VAR_i)
	LD BC,(ZXBASIC_VAR_for_i_step)
	ADD HL,BC
	LD (ZXBASIC_VAR_i),HL
	LD DE,(ZXBASIC_VAR_for_i)
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_2
ZX_LINE_1195:
; 1195  RETURN 
	RET
ZX_LINE_1200:
; 1200  REM Scroll left
ZX_LINE_1210:
; 1210  LET adr=16384{00 00 00 40 00 }
	LD HL,16384
	LD (ZXBASIC_VAR_adr),HL
ZX_LINE_1220:
; 1220  FOR l=1{00 00 01 00 00 } TO 192{00 00 c0 00 00 }
	LD HL,1
	LD (ZXBASIC_VAR_l),HL
	LD HL,192
	LD (ZXBASIC_VAR_for_l),HL
	LD HL,1
	LD (ZXBASIC_VAR_for_l_step),HL
FOR_3:
ZX_LINE_1225:
; 1225  LET adrl=adr
	LD HL,(ZXBASIC_VAR_adr)
	LD (ZXBASIC_VAR_adrl),HL
ZX_LINE_1230:
; 1230  FOR p=0{00 00 00 00 00 } TO 30{00 00 1e 00 00 }
	LD HL,0
	LD (ZXBASIC_VAR_p),HL
	LD HL,30
	LD (ZXBASIC_VAR_for_p),HL
	LD HL,1
	LD (ZXBASIC_VAR_for_p_step),HL
FOR_4:
ZX_LINE_1240:
; 1240  POKE adrl, PEEK (adrl+1{00 00 01 00 00 })
	LD HL,(ZXBASIC_VAR_adrl)
	PUSH HL
	LD DE,(ZXBASIC_VAR_adrl)
	LD HL,1
	ADD HL,DE
	LD L,(HL)
	LD H,0
	POP DE
	EX HL,DE
	LD (HL),E
ZX_LINE_1241:
; 1241  LET adrl=adrl+1{00 00 01 00 00 }
	LD HL,(ZXBASIC_VAR_adrl)
	INC HL
	LD (ZXBASIC_VAR_adrl),HL
ZX_LINE_1250:
; 1250  NEXT p
	LD HL,(ZXBASIC_VAR_p)
	LD BC,(ZXBASIC_VAR_for_p_step)
	ADD HL,BC
	LD (ZXBASIC_VAR_p),HL
	LD DE,(ZXBASIC_VAR_for_p)
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_4
ZX_LINE_1260:
; 1260  POKE adr+31{00 00 1f 00 00 },0{00 00 00 00 00 }
	LD DE,(ZXBASIC_VAR_adr)
	LD HL,31
	ADD HL,DE
	LD DE,0
	LD (HL),E
ZX_LINE_1270:
; 1270  LET adr=adr+32{00 00 20 00 00 }
	LD DE,(ZXBASIC_VAR_adr)
	LD HL,32
	ADD HL,DE
	LD (ZXBASIC_VAR_adr),HL
ZX_LINE_1280:
; 1280  NEXT l
	LD HL,(ZXBASIC_VAR_l)
	LD BC,(ZXBASIC_VAR_for_l_step)
	ADD HL,BC
	LD (ZXBASIC_VAR_l),HL
	LD DE,(ZXBASIC_VAR_for_l)
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_3
ZX_LINE_1290:
; 1290  RETURN 
	RET
ZX_LINE_1400:
; 1400  CLS : PRINT "Scroll in Assembler";
	CALL runtimeCls
	LD HL,STRING_2	;Scroll in Assembler
	CALL runtimePrintString
ZX_LINE_1410:
; 1410  GOSUB 1100{00 00 4c 04 00 }
	CALL ZX_LINE_1100:
ZX_LINE_1420:
; 1420  FOR i=1{00 00 01 00 00 } TO 32{00 00 20 00 00 }
	LD HL,1
	LD (ZXBASIC_VAR_i),HL
	LD HL,32
	LD (ZXBASIC_VAR_for_i),HL
	LD HL,1
	LD (ZXBASIC_VAR_for_i_step),HL
FOR_5:
ZX_LINE_1430:
; 1430  REM asm call sidescroll
	 call sidescroll
ZX_LINE_1440:
; 1440  NEXT i
	LD HL,(ZXBASIC_VAR_i)
	LD BC,(ZXBASIC_VAR_for_i_step)
	ADD HL,BC
	LD (ZXBASIC_VAR_i),HL
	LD DE,(ZXBASIC_VAR_for_i)
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_5
ZX_LINE_1450:
; 1450  GOSUB 3600{00 00 10 0e 00 }
	CALL ZX_LINE_3600:
ZX_LINE_1460:
; 1460  RETURN 
	RET
ZX_LINE_1470:
; 1470  REM asm include "demo.asm"
	 include "demo.asm"
ZX_LINE_3000:
; 3000  DATA 24{00 00 18 00 00 },60{00 00 3c 00 00 },126{00 00 7e 00 00 },219{00 00 db 00 00 },255{00 00 ff 00 00 },36{00 00 24 00 00 },90{00 00 5a 00 00 },165{00 00 a5 00 00 }
ZX_LINE_3010:
; 3010  DATA 60{00 00 3c 00 00 },66{00 00 42 00 00 },102{00 00 66 00 00 },153{00 00 99 00 00 },129{00 00 81 00 00 },90{00 00 5a 00 00 },66{00 00 42 00 00 },60{00 00 3c 00 00 }
ZX_LINE_3020:
; 3020  DATA 0{00 00 00 00 00 },0{00 00 00 00 00 },255{00 00 ff 00 00 },153{00 00 99 00 00 },255{00 00 ff 00 00 },129{00 00 81 00 00 },255{00 00 ff 00 00 },36{00 00 24 00 00 }
ZX_LINE_3100:
; 3100  LET pos= USR "A"
	LD HL,STRING_3	;A
	CALL runtimeUsrUDG
	LD (ZXBASIC_VAR_pos),HL
ZX_LINE_3110:
; 3110  RESTORE 3000{00 00 b8 0b 00 }
	LD HL,DATA_3000
	LD (DATAPTR),HL
ZX_LINE_3120:
; 3120  LET pos=65368{00 00 58 ff 00 }
	LD HL,65368
	LD (ZXBASIC_VAR_pos),HL
ZX_LINE_3130:
; 3130  FOR i=1{00 00 01 00 00 } TO 3{00 00 03 00 00 }
	LD HL,1
	LD (ZXBASIC_VAR_i),HL
	LD HL,3
	LD (ZXBASIC_VAR_for_i),HL
	LD HL,1
	LD (ZXBASIC_VAR_for_i_step),HL
FOR_6:
ZX_LINE_3140:
; 3140  FOR j=1{00 00 01 00 00 } TO 8{00 00 08 00 00 }
	LD HL,1
	LD (ZXBASIC_VAR_j),HL
	LD HL,8
	LD (ZXBASIC_VAR_for_j),HL
	LD HL,1
	LD (ZXBASIC_VAR_for_j_step),HL
FOR_7:
ZX_LINE_3150:
; 3150  READ a
	LD HL,(DATAPTR)
	LD DE,(HL)
	INC HL
	INC HL
	LD (DATAPTR),HL
	LD (ZXBASIC_VAR_a),DE
ZX_LINE_3160:
; 3160  POKE pos,a
	LD HL,(ZXBASIC_VAR_pos)
	LD DE,(ZXBASIC_VAR_a)
	LD (HL),E
ZX_LINE_3170:
; 3170  LET pos=pos+1{00 00 01 00 00 }
	LD HL,(ZXBASIC_VAR_pos)
	INC HL
	LD (ZXBASIC_VAR_pos),HL
ZX_LINE_3180:
; 3180  NEXT j
	LD HL,(ZXBASIC_VAR_j)
	LD BC,(ZXBASIC_VAR_for_j_step)
	ADD HL,BC
	LD (ZXBASIC_VAR_j),HL
	LD DE,(ZXBASIC_VAR_for_j)
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_7
ZX_LINE_3190:
; 3190  NEXT i
	LD HL,(ZXBASIC_VAR_i)
	LD BC,(ZXBASIC_VAR_for_i_step)
	ADD HL,BC
	LD (ZXBASIC_VAR_i),HL
	LD DE,(ZXBASIC_VAR_for_i)
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_6
ZX_LINE_3200:
; 3200  PRINT  INK 1{00 00 01 00 00 }; AT 0{00 00 00 00 00 },0{00 00 00 00 00 };"UDG:";
	LD HL,1
	CALL runtimeLocalInk
	LD DE,0
	LD HL,0
	CALL runtimePrintAt
	LD HL,STRING_4	;UDG:\90\91\92
	CALL runtimePrintString
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
ZX_LINE_3210:
; 3210  RETURN 
	RET
ZX_LINE_3300:
; 3300  CLS 
	CALL runtimeCls
ZX_LINE_3310:
; 3310  PRINT  AT 4{00 00 04 00 00 },0{00 00 00 00 00 };"Menu"
	LD DE,4
	LD HL,0
	CALL runtimePrintAt
	LD HL,STRING_5	;Menu
	CALL runtimePrintString
	CALL runtimePrintNewline
ZX_LINE_3320:
; 3320  PRINT " 1 Plot"
	LD HL,STRING_6	; 1 Plot
	CALL runtimePrintString
	CALL runtimePrintNewline
ZX_LINE_3330:
; 3330  PRINT " 2 Array Test"
	LD HL,STRING_7	; 2 Array Test
	CALL runtimePrintString
	CALL runtimePrintNewline
ZX_LINE_3340:
; 3340  PRINT " 3 Scroll in Basic"
	LD HL,STRING_8	; 3 Scroll in Basic
	CALL runtimePrintString
	CALL runtimePrintNewline
ZX_LINE_3345:
; 3345  PRINT " 4 Data+UDG"
	LD HL,STRING_9	; 4 Data+UDG
	CALL runtimePrintString
	CALL runtimePrintNewline
ZX_LINE_3350:
; 3350  PRINT " 5 Mult+Div"
	LD HL,STRING_10	; 5 Mult+Div
	CALL runtimePrintString
	CALL runtimePrintNewline
ZX_LINE_3360:
; 3360  PRINT " 6 Strings"
	LD HL,STRING_11	; 6 Strings
	CALL runtimePrintString
	CALL runtimePrintNewline
ZX_LINE_3365:
; 3365  PRINT " 7 Float"
	LD HL,STRING_12	; 7 Float
	CALL runtimePrintString
	CALL runtimePrintNewline
ZX_LINE_3366:
; 3366  PRINT " 8 SIN/COS"
	LD HL,STRING_13	; 8 SIN/COS
	CALL runtimePrintString
	CALL runtimePrintNewline
ZX_LINE_3367:
; 3367  PRINT " 9 Mandelbrot"
	LD HL,STRING_14	; 9 Mandelbrot
	CALL runtimePrintString
	CALL runtimePrintNewline
ZX_LINE_3400:
; 3400  LET k= CODE  INKEY 
	CALL runtimeInkey
	CALL runtimeCode
	LD (ZXBASIC_VAR_k),HL
	CALL ZXFreeTempCompact
ZX_LINE_3410:
; 3410  PRINT  AT 0{00 00 00 00 00 },20{00 00 14 00 00 };k;"  "
	LD DE,0
	LD HL,20
	CALL runtimePrintAt
	LD HL,(ZXBASIC_VAR_k)
	CALL runtimePrintInt
	LD HL,STRING_15	;  
	CALL runtimePrintString
	CALL runtimePrintNewline
ZX_LINE_3420:
; 3420  IF k=49{00 00 31 00 00 } THEN  CLS : PRINT "Zeichne 5000 Punkte": GOSUB 1000{00 00 e8 03 00 }: GOSUB 3600{00 00 10 0e 00 }: GOTO 3300{00 00 e4 0c 00 }
	LD DE,(ZXBASIC_VAR_k)
	LD HL,49
	SUB HL,DE
	LD HL,0
	CALL Z,HL1
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_3
	CALL runtimeCls
	LD HL,STRING_16	;Zeichne 5000 Punkte
	CALL runtimePrintString
	CALL runtimePrintNewline
	CALL ZX_LINE_1000:
	CALL ZX_LINE_3600:
	JP ZX_LINE_3300
ZXB_LABEL_3:
ZX_LINE_3425:
; 3425  IF k=50{00 00 32 00 00 } THEN  CLS : GOSUB 4000{00 00 a0 0f 00 }: GOSUB 3600{00 00 10 0e 00 }: GOTO 3300{00 00 e4 0c 00 }
	LD DE,(ZXBASIC_VAR_k)
	LD HL,50
	SUB HL,DE
	LD HL,0
	CALL Z,HL1
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_4
	CALL runtimeCls
	CALL ZX_LINE_4000:
	CALL ZX_LINE_3600:
	JP ZX_LINE_3300
ZXB_LABEL_4:
ZX_LINE_3430:
; 3430  IF k=51{00 00 33 00 00 } THEN  CLS : PRINT "Screen Scroll": PRINT "in Basic": GOSUB 1100{00 00 4c 04 00 }: FOR i=1{00 00 01 00 00 } TO 32{00 00 20 00 00 }: GOSUB 1200{00 00 b0 04 00 }: NEXT i: GOSUB 3600{00 00 10 0e 00 }: GOTO 1400{00 00 78 05 00 }: GOTO 3300{00 00 e4 0c 00 }
	LD DE,(ZXBASIC_VAR_k)
	LD HL,51
	SUB HL,DE
	LD HL,0
	CALL Z,HL1
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_5
	CALL runtimeCls
	LD HL,STRING_17	;Screen Scroll
	CALL runtimePrintString
	CALL runtimePrintNewline
	LD HL,STRING_18	;in Basic
	CALL runtimePrintString
	CALL runtimePrintNewline
	CALL ZX_LINE_1100:
	LD HL,1
	LD (ZXBASIC_VAR_i),HL
	LD HL,32
	LD (ZXBASIC_VAR_for_i),HL
	LD HL,1
	LD (ZXBASIC_VAR_for_i_step),HL
FOR_8:
	CALL ZX_LINE_1200:
	LD HL,(ZXBASIC_VAR_i)
	LD BC,(ZXBASIC_VAR_for_i_step)
	ADD HL,BC
	LD (ZXBASIC_VAR_i),HL
	LD DE,(ZXBASIC_VAR_for_i)
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_8
	CALL ZX_LINE_3600:
	JP ZX_LINE_1400
	JP ZX_LINE_3300
ZXB_LABEL_5:
ZX_LINE_3440:
; 3440  IF k=52{00 00 34 00 00 } THEN  CLS : GOSUB 3000{00 00 b8 0b 00 }: GOSUB 3600{00 00 10 0e 00 }: GOTO 3300{00 00 e4 0c 00 }
	LD DE,(ZXBASIC_VAR_k)
	LD HL,52
	SUB HL,DE
	LD HL,0
	CALL Z,HL1
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_6
	CALL runtimeCls
	CALL ZX_LINE_3000:
	CALL ZX_LINE_3600:
	JP ZX_LINE_3300
ZXB_LABEL_6:
ZX_LINE_3450:
; 3450  IF k=53{00 00 35 00 00 } THEN  GOSUB 4200{00 00 68 10 00 }: GOTO 3300{00 00 e4 0c 00 }
	LD DE,(ZXBASIC_VAR_k)
	LD HL,53
	SUB HL,DE
	LD HL,0
	CALL Z,HL1
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_7
	CALL ZX_LINE_4200:
	JP ZX_LINE_3300
ZXB_LABEL_7:
ZX_LINE_3460:
; 3460  IF k=54{00 00 36 00 00 } THEN  GOSUB 4300{00 00 cc 10 00 }: GOTO 3300{00 00 e4 0c 00 }
	LD DE,(ZXBASIC_VAR_k)
	LD HL,54
	SUB HL,DE
	LD HL,0
	CALL Z,HL1
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_8
	CALL ZX_LINE_4300:
	JP ZX_LINE_3300
ZXB_LABEL_8:
ZX_LINE_3465:
; 3465  IF k=55{00 00 37 00 00 } THEN  GOSUB 4500{00 00 94 11 00 }: GOTO 3300{00 00 e4 0c 00 }
	LD DE,(ZXBASIC_VAR_k)
	LD HL,55
	SUB HL,DE
	LD HL,0
	CALL Z,HL1
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_9
	CALL ZX_LINE_4500:
	JP ZX_LINE_3300
ZXB_LABEL_9:
ZX_LINE_3470:
; 3470  IF k=56{00 00 38 00 00 } THEN  GOSUB 4800{00 00 c0 12 00 }: GOTO 3300{00 00 e4 0c 00 }
	LD DE,(ZXBASIC_VAR_k)
	LD HL,56
	SUB HL,DE
	LD HL,0
	CALL Z,HL1
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_10
	CALL ZX_LINE_4800:
	JP ZX_LINE_3300
ZXB_LABEL_10:
ZX_LINE_3480:
; 3480  IF k=57{00 00 39 00 00 } THEN  GOSUB 5000{00 00 88 13 00 }: GOTO 3300{00 00 e4 0c 00 }
	LD DE,(ZXBASIC_VAR_k)
	LD HL,57
	SUB HL,DE
	LD HL,0
	CALL Z,HL1
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_11
	CALL ZX_LINE_5000:
	JP ZX_LINE_3300
ZXB_LABEL_11:
ZX_LINE_3499:
; 3499  GOTO 3400{00 00 48 0d 00 }
	JP ZX_LINE_3400
ZX_LINE_3600:
; 3600  REM Press Key to continue
ZX_LINE_3610:
; 3610  PRINT  AT 21{00 00 15 00 00 },0{00 00 00 00 00 };"Weiter mit Tastendruck";
	LD DE,21
	LD HL,0
	CALL runtimePrintAt
	LD HL,STRING_19	;Weiter mit Tastendruck
	CALL runtimePrintString
ZX_LINE_3620:
; 3620  LET k= CODE  INKEY 
	CALL runtimeInkey
	CALL runtimeCode
	LD (ZXBASIC_VAR_k),HL
	CALL ZXFreeTempCompact
ZX_LINE_3630:
; 3630  IF k=0{00 00 00 00 00 } THEN  GOTO 3620{00 00 24 0e 00 }
	LD DE,(ZXBASIC_VAR_k)
	LD HL,0
	SUB HL,DE
	LD HL,0
	CALL Z,HL1
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_12
	JP ZX_LINE_3620
ZXB_LABEL_12:
ZX_LINE_3640:
; 3640  PAUSE 0{00 00 00 00 00 }
	LD HL,0
	CALL runtimePause
ZX_LINE_3650:
; 3650  RETURN 
	RET
ZX_LINE_4000:
; 4000  DIM a(8{00 00 08 00 00 },8{00 00 08 00 00 })
ZX_LINE_4010:
; 4010  LET x=1{00 00 01 00 00 }
	LD HL,1
	LD (ZXBASIC_VAR_x),HL
ZX_LINE_4020:
; 4020  FOR i=1{00 00 01 00 00 } TO 8{00 00 08 00 00 }
	LD HL,1
	LD (ZXBASIC_VAR_i),HL
	LD HL,8
	LD (ZXBASIC_VAR_for_i),HL
	LD HL,1
	LD (ZXBASIC_VAR_for_i_step),HL
FOR_9:
ZX_LINE_4030:
; 4030  FOR j=1{00 00 01 00 00 } TO 8{00 00 08 00 00 }
	LD HL,1
	LD (ZXBASIC_VAR_j),HL
	LD HL,8
	LD (ZXBASIC_VAR_for_j),HL
	LD HL,1
	LD (ZXBASIC_VAR_for_j_step),HL
FOR_10:
ZX_LINE_4040:
; 4040  LET a(i,j)=x: LET x=x+1{00 00 01 00 00 }
	LD HL,(ZXBASIC_VAR_i)
	ADD HL,HL
	ADD HL,HL
	ADD HL,HL
	LD DE,HL
	LD HL,(ZXBASIC_VAR_j)
	ADD HL,DE
	ADD HL,HL
	PUSH HL
	LD HL,(ZXBASIC_VAR_x)
	PUSH HL
	POP DE
	POP HL
	LD BC,ZXBASIC_VAR_a
	ADD HL,BC
	LD (HL),DE
	LD HL,(ZXBASIC_VAR_x)
	INC HL
	LD (ZXBASIC_VAR_x),HL
ZX_LINE_4050:
; 4050  NEXT j
	LD HL,(ZXBASIC_VAR_j)
	LD BC,(ZXBASIC_VAR_for_j_step)
	ADD HL,BC
	LD (ZXBASIC_VAR_j),HL
	LD DE,(ZXBASIC_VAR_for_j)
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_10
ZX_LINE_4060:
; 4060  NEXT i
	LD HL,(ZXBASIC_VAR_i)
	LD BC,(ZXBASIC_VAR_for_i_step)
	ADD HL,BC
	LD (ZXBASIC_VAR_i),HL
	LD DE,(ZXBASIC_VAR_for_i)
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_9
ZX_LINE_4070:
; 4070  FOR i=1{00 00 01 00 00 } TO 8{00 00 08 00 00 }
	LD HL,1
	LD (ZXBASIC_VAR_i),HL
	LD HL,8
	LD (ZXBASIC_VAR_for_i),HL
	LD HL,1
	LD (ZXBASIC_VAR_for_i_step),HL
FOR_11:
ZX_LINE_4075:
; 4075  PRINT "Zeile ";i
	LD HL,STRING_20	;Zeile 
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_i)
	CALL runtimePrintInt
	CALL runtimePrintNewline
ZX_LINE_4080:
; 4080  FOR j=1{00 00 01 00 00 } TO 8{00 00 08 00 00 }
	LD HL,1
	LD (ZXBASIC_VAR_j),HL
	LD HL,8
	LD (ZXBASIC_VAR_for_j),HL
	LD HL,1
	LD (ZXBASIC_VAR_for_j_step),HL
FOR_12:
ZX_LINE_4090:
; 4090  PRINT " ";a(i,j);
	LD HL,STRING_21	; 
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_i)
	ADD HL,HL
	ADD HL,HL
	ADD HL,HL
	LD DE,HL
	LD HL,(ZXBASIC_VAR_j)
	ADD HL,DE
	ADD HL,HL
	LD DE, ZXBASIC_VAR_a
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	POP HL
	CALL runtimePrintInt
ZX_LINE_4100:
; 4100  NEXT j
	LD HL,(ZXBASIC_VAR_j)
	LD BC,(ZXBASIC_VAR_for_j_step)
	ADD HL,BC
	LD (ZXBASIC_VAR_j),HL
	LD DE,(ZXBASIC_VAR_for_j)
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_12
ZX_LINE_4110:
; 4110  PRINT 
	CALL runtimePrintNewline
ZX_LINE_4120:
; 4120  NEXT i
	LD HL,(ZXBASIC_VAR_i)
	LD BC,(ZXBASIC_VAR_for_i_step)
	ADD HL,BC
	LD (ZXBASIC_VAR_i),HL
	LD DE,(ZXBASIC_VAR_for_i)
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_11
ZX_LINE_4130:
; 4130  RETURN 
	RET
ZX_LINE_4200:
; 4200  REM Mal und Durch
ZX_LINE_4210:
; 4210  CLS : PRINT  AT 0{00 00 00 00 00 },0{00 00 00 00 00 };"Multiplizieren, Dividieren"
	CALL runtimeCls
	LD DE,0
	LD HL,0
	CALL runtimePrintAt
	LD HL,STRING_22	;Multiplizieren, Dividieren
	CALL runtimePrintString
	CALL runtimePrintNewline
ZX_LINE_4220:
; 4220  FOR i=2{00 00 02 00 00 } TO 9{00 00 09 00 00 }
	LD HL,2
	LD (ZXBASIC_VAR_i),HL
	LD HL,9
	LD (ZXBASIC_VAR_for_i),HL
	LD HL,1
	LD (ZXBASIC_VAR_for_i_step),HL
FOR_13:
ZX_LINE_4224:
; 4224  IF i>2{00 00 02 00 00 } THEN  PRINT 
	LD DE,(ZXBASIC_VAR_i)
	LD HL,2
	SUB HL,DE
	LD HL,0
	call c,HL1
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_13
	CALL runtimePrintNewline
ZXB_LABEL_13:
ZX_LINE_4225:
; 4225  PRINT "x*";i;"=";
	LD HL,STRING_23	;x*
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_i)
	CALL runtimePrintInt
	LD HL,STRING_24	;=
	CALL runtimePrintString
ZX_LINE_4230:
; 4230  FOR j=2{00 00 02 00 00 } TO 9{00 00 09 00 00 }
	LD HL,2
	LD (ZXBASIC_VAR_j),HL
	LD HL,9
	LD (ZXBASIC_VAR_for_j),HL
	LD HL,1
	LD (ZXBASIC_VAR_for_j_step),HL
FOR_14:
ZX_LINE_4240:
; 4240  PRINT i*j;" ";
	LD DE,(ZXBASIC_VAR_i)
	LD HL,(ZXBASIC_VAR_j)
	call runtimeMult16bit
	CALL runtimePrintInt
	LD HL,STRING_21	; 
	CALL runtimePrintString
ZX_LINE_4250:
; 4250  NEXT j
	LD HL,(ZXBASIC_VAR_j)
	LD BC,(ZXBASIC_VAR_for_j_step)
	ADD HL,BC
	LD (ZXBASIC_VAR_j),HL
	LD DE,(ZXBASIC_VAR_for_j)
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_14
ZX_LINE_4255:
; 4255  NEXT i
	LD HL,(ZXBASIC_VAR_i)
	LD BC,(ZXBASIC_VAR_for_i_step)
	ADD HL,BC
	LD (ZXBASIC_VAR_i),HL
	LD DE,(ZXBASIC_VAR_for_i)
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_13
ZX_LINE_4256:
; 4256  PRINT 
	CALL runtimePrintNewline
ZX_LINE_4257:
; 4257  PRINT "Mult/Div signed"
	LD HL,STRING_25	;Mult/Div signed
	CALL runtimePrintString
	CALL runtimePrintNewline
ZX_LINE_4270:
; 4270  LET z=30000{00 00 30 75 00 }: LET x=3{00 00 03 00 00 }
	LD HL,30000
	LD (ZXBASIC_VAR_z),HL
	LD HL,3
	LD (ZXBASIC_VAR_x),HL
ZX_LINE_4280:
; 4280  FOR i=1{00 00 01 00 00 } TO 5{00 00 05 00 00 }: PRINT z,x: LET z=z/10{00 00 0a 00 00 }: LET x=x*10{00 00 0a 00 00 }: NEXT i
	LD HL,1
	LD (ZXBASIC_VAR_i),HL
	LD HL,5
	LD (ZXBASIC_VAR_for_i),HL
	LD HL,1
	LD (ZXBASIC_VAR_for_i_step),HL
FOR_15:
	LD HL,(ZXBASIC_VAR_z)
	CALL runtimePrintInt
	CALL runtimePrintTab
	LD HL,(ZXBASIC_VAR_x)
	CALL runtimePrintInt
	CALL runtimePrintNewline
	LD DE,(ZXBASIC_VAR_z)
	LD HL,10
	call runtimeDiv16bit
	LD (ZXBASIC_VAR_z),HL
	LD DE,(ZXBASIC_VAR_x)
	LD HL,10
	call runtimeMult16bit
	LD (ZXBASIC_VAR_x),HL
	LD HL,(ZXBASIC_VAR_i)
	LD BC,(ZXBASIC_VAR_for_i_step)
	ADD HL,BC
	LD (ZXBASIC_VAR_i),HL
	LD DE,(ZXBASIC_VAR_for_i)
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_15
ZX_LINE_4285:
; 4285  LET z=0{00 00 00 00 00 }-30000{00 00 30 75 00 }: LET x=0{00 00 00 00 00 }-3{00 00 03 00 00 }
	LD HL,0
	LD DE,30000
	SUB HL,DE
	LD (ZXBASIC_VAR_z),HL
	LD HL,0
	LD DE,3
	SUB HL,DE
	LD (ZXBASIC_VAR_x),HL
ZX_LINE_4286:
; 4286  FOR i=1{00 00 01 00 00 } TO 5{00 00 05 00 00 }: PRINT z,x: LET z=z/10{00 00 0a 00 00 }: LET x=x*10{00 00 0a 00 00 }: NEXT i
	LD HL,1
	LD (ZXBASIC_VAR_i),HL
	LD HL,5
	LD (ZXBASIC_VAR_for_i),HL
	LD HL,1
	LD (ZXBASIC_VAR_for_i_step),HL
FOR_16:
	LD HL,(ZXBASIC_VAR_z)
	CALL runtimePrintInt
	CALL runtimePrintTab
	LD HL,(ZXBASIC_VAR_x)
	CALL runtimePrintInt
	CALL runtimePrintNewline
	LD DE,(ZXBASIC_VAR_z)
	LD HL,10
	call runtimeDiv16bit
	LD (ZXBASIC_VAR_z),HL
	LD DE,(ZXBASIC_VAR_x)
	LD HL,10
	call runtimeMult16bit
	LD (ZXBASIC_VAR_x),HL
	LD HL,(ZXBASIC_VAR_i)
	LD BC,(ZXBASIC_VAR_for_i_step)
	ADD HL,BC
	LD (ZXBASIC_VAR_i),HL
	LD DE,(ZXBASIC_VAR_for_i)
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_16
ZX_LINE_4290:
; 4290  GOSUB 3600{00 00 10 0e 00 }: RETURN 
	CALL ZX_LINE_3600:
	RET
ZX_LINE_4300:
; 4300  REM Strings
ZX_LINE_4301:
; 4301  CLS 
	CALL runtimeCls
ZX_LINE_4310:
; 4310  LET a$="1234"
	LD HL,STRING_0	;1234
	PUSH HL
	POP DE
	LD HL,ZXBASIC_VAR_a_string
	CALL runtimeStoreString
ZX_LINE_4320:
; 4320  PRINT "a$=";a$
	LD HL,STRING_26	;a$=
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_a_string)
	CALL runtimePrintString
	CALL runtimePrintNewline
	CALL ZXFreeTempCompact
ZX_LINE_4330:
; 4330  PRINT "val a$="; VAL a$
	LD HL,STRING_27	;val a$=
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_a_string)
	CALL runtimeVal
	CALL runtimePrintFloat
	CALL runtimePrintNewline
	CALL ZXFreeTempCompact
ZX_LINE_4340:
; 4340  PRINT "start=";a$( TO 2{00 00 02 00 00 })
	LD HL,STRING_28	;start=
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_a_string)
	PUSH HL
	LD DE,1
	LD HL,2
	POP BC
	CALL runtimeSubstring
	CALL runtimePrintString
	CALL runtimePrintNewline
	CALL ZXFreeTempCompact
ZX_LINE_4350:
; 4350  PRINT "ende=";a$(2{00 00 02 00 00 } TO )
	LD HL,STRING_29	;ende=
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_a_string)
	PUSH HL
	LD DE,2
	LD HL,-1
	POP BC
	CALL runtimeSubstring
	CALL runtimePrintString
	CALL runtimePrintNewline
	CALL ZXFreeTempCompact
ZX_LINE_4360:
; 4360  PRINT "mitte=";a$(1{00 00 01 00 00 } TO 2{00 00 02 00 00 })
	LD HL,STRING_30	;mitte=
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_a_string)
	PUSH HL
	LD DE,1
	LD HL,2
	POP BC
	CALL runtimeSubstring
	CALL runtimePrintString
	CALL runtimePrintNewline
	CALL ZXFreeTempCompact
ZX_LINE_4370:
; 4370  PRINT "2.Byte=";a$(2{00 00 02 00 00 })
	LD HL,STRING_31	;2.Byte=
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_a_string)
	PUSH HL
	LD HL,2
	POP BC
	CALL runtimeCharAt
	CALL runtimePrintString
	CALL runtimePrintNewline
	CALL ZXFreeTempCompact
ZX_LINE_4380:
; 4380  LET x$="": FOR i=32{00 00 20 00 00 } TO 255{00 00 ff 00 00 }: LET x$=x$+ CHR i: NEXT i: PRINT x$
	LD HL,STRING_32	;
	PUSH HL
	POP DE
	LD HL,ZXBASIC_VAR_x_string
	CALL runtimeStoreString
	LD HL,32
	LD (ZXBASIC_VAR_i),HL
	LD HL,255
	LD (ZXBASIC_VAR_for_i),HL
	LD HL,1
	LD (ZXBASIC_VAR_for_i_step),HL
FOR_17:
	LD HL,(ZXBASIC_VAR_x_string)
	PUSH HL
	LD HL,(ZXBASIC_VAR_i)
	CALL runtimeChr
	POP DE
	CALL runtimeStringAdd
	PUSH HL
	POP DE
	LD HL,ZXBASIC_VAR_x_string
	CALL runtimeStoreString
	LD HL,(ZXBASIC_VAR_i)
	LD BC,(ZXBASIC_VAR_for_i_step)
	ADD HL,BC
	LD (ZXBASIC_VAR_i),HL
	LD DE,(ZXBASIC_VAR_for_i)
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_17
	LD HL,(ZXBASIC_VAR_x_string)
	CALL runtimePrintString
	CALL runtimePrintNewline
	CALL ZXFreeTempCompact
ZX_LINE_4499:
; 4499  GOSUB 3600{00 00 10 0e 00 }: RETURN 
	CALL ZX_LINE_3600:
	RET
ZX_LINE_4500:
; 4500  CLS : PRINT "test float und float mit int"
	CALL runtimeCls
	LD HL,STRING_33	;test float und float mit int
	CALL runtimePrintString
	CALL runtimePrintNewline
ZX_LINE_4501:
; 4501  GOSUB 4600{00 00 f8 11 00 }
	CALL ZX_LINE_4600:
ZX_LINE_4503:
; 4503  PRINT "pi="; PI 
	LD HL,STRING_34	;pi=
	CALL runtimePrintString
	CALL runtimePushPi
	CALL runtimePrintFloat
	CALL runtimePrintNewline
ZX_LINE_4504:
; 4504  LET pi= PI 
	CALL runtimePushPi
	LD HL,ZXBASIC_VAR_pi
	CALL runtimeStoreFloat
ZX_LINE_4505:
; 4505  PRINT "var pi=";pi
	LD HL,STRING_35	;var pi=
	CALL runtimePrintString
	LD HL,ZXBASIC_VAR_pi
	CALL runtimePushFloatVar
	CALL runtimePrintFloat
	CALL runtimePrintNewline
ZX_LINE_4510:
; 4510  LET f1=1{00 00 01 00 00 }: LET f2=7{00 00 07 00 00 }
	LD HL,1
	CALL runtimeIntToFloat
	LD HL,ZXBASIC_VAR_f1
	CALL runtimeStoreFloat
	LD HL,7
	CALL runtimeIntToFloat
	LD HL,ZXBASIC_VAR_f2
	CALL runtimeStoreFloat
ZX_LINE_4515:
; 4515  LET i1= INT f1: LET i2= INT f2
	LD HL,ZXBASIC_VAR_f1
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD (ZXBASIC_VAR_i1),HL
	LD HL,ZXBASIC_VAR_f2
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD (ZXBASIC_VAR_i2),HL
ZX_LINE_4516:
; 4516  PRINT "f1=";f1;" f2=";f2: PRINT "i1=";i1;" i2=";i2
	LD HL,STRING_36	;f1=
	CALL runtimePrintString
	LD HL,ZXBASIC_VAR_f1
	CALL runtimePushFloatVar
	CALL runtimePrintFloat
	LD HL,STRING_37	; f2=
	CALL runtimePrintString
	LD HL,ZXBASIC_VAR_f2
	CALL runtimePushFloatVar
	CALL runtimePrintFloat
	CALL runtimePrintNewline
	LD HL,STRING_38	;i1=
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_i1)
	CALL runtimePrintInt
	LD HL,STRING_39	; i2=
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_i2)
	CALL runtimePrintInt
	CALL runtimePrintNewline
ZX_LINE_4520:
; 4520  LET f3=f1/f2
	LD HL,ZXBASIC_VAR_f1
	CALL runtimePushFloatVar
	LD HL,ZXBASIC_VAR_f2
	CALL runtimePushFloatVar
	CALL runtimeDivFloat
	LD HL,ZXBASIC_VAR_f3
	CALL runtimeStoreFloat
ZX_LINE_4530:
; 4530  PRINT "f1/f2=";f3
	LD HL,STRING_40	;f1/f2=
	CALL runtimePrintString
	LD HL,ZXBASIC_VAR_f3
	CALL runtimePushFloatVar
	CALL runtimePrintFloat
	CALL runtimePrintNewline
ZX_LINE_4540:
; 4540  PRINT "10-f3=";10{00 00 0a 00 00 }-f3: PRINT "f3-10=";f3-10{00 00 0a 00 00 }
	LD HL,STRING_41	;10-f3=
	CALL runtimePrintString
	LD HL,10
	PUSH HL
	LD HL,ZXBASIC_VAR_f3
	CALL runtimePushFloatVar
	POP HL
	CALL runtimeIntToFloat
	CALL runtimeSwapFloat
	CALL runtimeMinusFloat
	CALL runtimePrintFloat
	CALL runtimePrintNewline
	LD HL,STRING_42	;f3-10=
	CALL runtimePrintString
	LD HL,ZXBASIC_VAR_f3
	CALL runtimePushFloatVar
	LD HL,10
	CALL runtimeIntToFloat
	CALL runtimeMinusFloat
	CALL runtimePrintFloat
	CALL runtimePrintNewline
ZX_LINE_4599:
; 4599  GOTO 3600{00 00 10 0e 00 }
	JP ZX_LINE_3600
ZX_LINE_4600:
; 4600  PRINT "STKBOT="; PEEK (23651{00 00 63 5c 00 })+ PEEK (23652{00 00 64 5c 00 })*256{00 00 00 01 00 },
	LD HL,STRING_43	;STKBOT=
	CALL runtimePrintString
	LD A,(23651)
	LD L,A
	LD H,0
	PUSH HL
	LD A,(23652)
	LD H,A
	LD L,0
	POP DE
	ADD HL,DE
	CALL runtimePrintInt
	CALL runtimePrintTab
ZX_LINE_4620:
; 4620  PRINT "STKEND="; PEEK 23653{00 00 65 5c 00 }+ PEEK 23654{00 00 66 5c 00 }*256{00 00 00 01 00 }
	LD HL,STRING_44	;STKEND=
	CALL runtimePrintString
	LD A,(23653)
	LD L,A
	LD H,0
	PUSH HL
	LD A,(23654)
	LD H,A
	LD L,0
	POP DE
	ADD HL,DE
	CALL runtimePrintInt
	CALL runtimePrintNewline
ZX_LINE_4630:
; 4630  RETURN 
	RET
ZX_LINE_4800:
; 4800  REM graph
ZX_LINE_4801:
; 4801  REM float xf yf
ZX_LINE_4802:
; 4802  CLS : PRINT  AT 0{00 00 00 00 00 },15{00 00 0f 00 00 };"SIN und COS"
	CALL runtimeCls
	LD DE,0
	LD HL,15
	CALL runtimePrintAt
	LD HL,STRING_45	;SIN und COS
	CALL runtimePrintString
	CALL runtimePrintNewline
ZX_LINE_4805:
; 4805  PLOT 0{00 00 00 00 00 },80{00 00 50 00 00 }: DRAW 255{00 00 ff 00 00 },0{00 00 00 00 00 }
	LD DE,0
	LD HL,80
	CALL runtimePlot
	LD DE,255
	LD HL,0
	LD B,L
	LD C,E
	CALL runtimeDraw
ZX_LINE_4809:
; 4809  LET c=0{00 00 00 00 00 }
	LD HL,0
	LD (ZXBASIC_VAR_c),HL
ZX_LINE_4810:
; 4810  FOR x=0{00 00 00 00 00 } TO 250{00 00 fa 00 00 }
	LD HL,0
	LD (ZXBASIC_VAR_x),HL
	LD HL,250
	LD (ZXBASIC_VAR_for_x),HL
	LD HL,1
	LD (ZXBASIC_VAR_for_x_step),HL
FOR_18:
ZX_LINE_4820:
; 4820  LET xf=x* PI /50{00 00 32 00 00 }
	LD HL,(ZXBASIC_VAR_x)
	PUSH HL
	CALL runtimePushPi
	POP HL
	CALL runtimeIntToFloat
	CALL runtimeMultFloat
	LD HL,50
	CALL runtimeIntToFloat
	CALL runtimeDivFloat
	LD HL,ZXBASIC_VAR_xf
	CALL runtimeStoreFloat
ZX_LINE_4830:
; 4830  LET yf=80{00 00 50 00 00 }+(80{00 00 50 00 00 }* SIN xf)
	LD HL,80
	PUSH HL
	LD HL,80
	PUSH HL
	LD HL,ZXBASIC_VAR_xf
	CALL runtimePushFloatVar
	CALL runtimeSin
	POP HL
	CALL runtimeIntToFloat
	CALL runtimeMultFloat
	POP HL
	CALL runtimeIntToFloat
	CALL runtimePlusFloat
	LD HL,ZXBASIC_VAR_yf
	CALL runtimeStoreFloat
ZX_LINE_4835:
; 4835  PLOT x,yf
	LD HL,(ZXBASIC_VAR_x)
	PUSH HL
	LD HL,ZXBASIC_VAR_yf
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	POP DE
	CALL runtimePlot
ZX_LINE_4840:
; 4840  LET yf=80{00 00 50 00 00 }+(80{00 00 50 00 00 }* COS xf)
	LD HL,80
	PUSH HL
	LD HL,80
	PUSH HL
	LD HL,ZXBASIC_VAR_xf
	CALL runtimePushFloatVar
	CALL runtimeCos
	POP HL
	CALL runtimeIntToFloat
	CALL runtimeMultFloat
	POP HL
	CALL runtimeIntToFloat
	CALL runtimePlusFloat
	LD HL,ZXBASIC_VAR_yf
	CALL runtimeStoreFloat
ZX_LINE_4844:
; 4844  IF c=0{00 00 00 00 00 } THEN  GOSUB 4900{00 00 24 13 00 }: LET c=51{00 00 33 00 00 }
	LD DE,(ZXBASIC_VAR_c)
	LD HL,0
	SUB HL,DE
	LD HL,0
	CALL Z,HL1
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_14
	CALL ZX_LINE_4900:
	LD HL,51
	LD (ZXBASIC_VAR_c),HL
ZXB_LABEL_14:
ZX_LINE_4845:
; 4845  PLOT x,yf
	LD HL,(ZXBASIC_VAR_x)
	PUSH HL
	LD HL,ZXBASIC_VAR_yf
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	POP DE
	CALL runtimePlot
ZX_LINE_4846:
; 4846  IF c=0{00 00 00 00 00 } THEN  LET c=51{00 00 33 00 00 }: GOSUB 4900{00 00 24 13 00 }
	LD DE,(ZXBASIC_VAR_c)
	LD HL,0
	SUB HL,DE
	LD HL,0
	CALL Z,HL1
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_15
	LD HL,51
	LD (ZXBASIC_VAR_c),HL
	CALL ZX_LINE_4900:
ZXB_LABEL_15:
ZX_LINE_4847:
; 4847  LET c=c-1{00 00 01 00 00 }
	LD HL,(ZXBASIC_VAR_c)
	DEC HL
	LD (ZXBASIC_VAR_c),HL
ZX_LINE_4850:
; 4850  NEXT x
	LD HL,(ZXBASIC_VAR_x)
	LD BC,(ZXBASIC_VAR_for_x_step)
	ADD HL,BC
	LD (ZXBASIC_VAR_x),HL
	LD DE,(ZXBASIC_VAR_for_x)
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_18
ZX_LINE_4890:
; 4890  GOSUB 3600{00 00 10 0e 00 }: RETURN 
	CALL ZX_LINE_3600:
	RET
ZX_LINE_4900:
; 4900  LET x$= STR xf
	LD HL,ZXBASIC_VAR_xf
	CALL runtimePushFloatVar
	CALL runtimeStr
	PUSH HL
	POP DE
	LD HL,ZXBASIC_VAR_x_string
	CALL runtimeStoreString
ZX_LINE_4910:
; 4910  LET ix=x/8{00 00 08 00 00 }: IF ix >= 31{00 00 1f 00 00 } THEN  LET ix=31{00 00 1f 00 00 }
	LD DE,(ZXBASIC_VAR_x)
	LD HL,8
	call runtimeDiv16bit
	LD (ZXBASIC_VAR_ix),HL
	LD DE,(ZXBASIC_VAR_ix)
	LD HL,31
	SUB HL,DE
	LD HL,0
	call c,HL1
	call z,HL1
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_16
	LD HL,31
	LD (ZXBASIC_VAR_ix),HL
ZXB_LABEL_16:
ZX_LINE_4920:
; 4920  FOR i=1{00 00 01 00 00 } TO  LEN x$
	LD HL,1
	LD (ZXBASIC_VAR_i),HL
	LD HL,(ZXBASIC_VAR_x_string)
	CALL runtimeLen
	LD (ZXBASIC_VAR_for_i),HL
	LD HL,1
	LD (ZXBASIC_VAR_for_i_step),HL
FOR_19:
	CALL ZXFreeTempCompact
ZX_LINE_4930:
; 4930  PRINT  AT i+5{00 00 05 00 00 },ix;x$(i)
	LD DE,(ZXBASIC_VAR_i)
	LD HL,5
	ADD HL,DE
	LD DE,HL
	LD HL,(ZXBASIC_VAR_ix)
	CALL runtimePrintAt
	LD HL,(ZXBASIC_VAR_x_string)
	PUSH HL
	LD HL,(ZXBASIC_VAR_i)
	POP BC
	CALL runtimeCharAt
	CALL runtimePrintString
	CALL runtimePrintNewline
	CALL ZXFreeTempCompact
ZX_LINE_4940:
; 4940  NEXT i
	LD HL,(ZXBASIC_VAR_i)
	LD BC,(ZXBASIC_VAR_for_i_step)
	ADD HL,BC
	LD (ZXBASIC_VAR_i),HL
	LD DE,(ZXBASIC_VAR_for_i)
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_19
ZX_LINE_4950:
; 4950  RETURN 
	RET
ZX_LINE_5000:
; 5000  CLS : PRINT  AT 0{00 00 00 00 00 },20{00 00 14 00 00 };"Mandelbrot"
	CALL runtimeCls
	LD DE,0
	LD HL,20
	CALL runtimePrintAt
	LD HL,STRING_46	;Mandelbrot
	CALL runtimePrintString
	CALL runtimePrintNewline
ZX_LINE_5001:
; 5001  REM float xf zz zf zt zi z nf
ZX_LINE_5002:
; 5002  LET nf=0{00 00 00 00 00 }
	LD HL,0
	CALL runtimeIntToFloat
	LD HL,ZXBASIC_VAR_nf
	CALL runtimeStoreFloat
ZX_LINE_5005:
; 5005  LET my=0{00 00 00 00 00 }
	LD HL,0
	LD (ZXBASIC_VAR_my),HL
ZX_LINE_5010:
; 5010  LET xf=nf-2{00 00 02 00 00 }
	LD HL,ZXBASIC_VAR_nf
	CALL runtimePushFloatVar
	LD HL,2
	CALL runtimeIntToFloat
	CALL runtimeMinusFloat
	LD HL,ZXBASIC_VAR_xf
	CALL runtimeStoreFloat
ZX_LINE_5015:
; 5015  LET mx=0{00 00 00 00 00 }
	LD HL,0
	LD (ZXBASIC_VAR_mx),HL
ZX_LINE_5016:
; 5016  PRINT  AT 21{00 00 15 00 00 },0{00 00 00 00 00 };"x=";xf;"    ";
	LD DE,21
	LD HL,0
	CALL runtimePrintAt
	LD HL,STRING_47	;x=
	CALL runtimePrintString
	LD HL,ZXBASIC_VAR_xf
	CALL runtimePushFloatVar
	CALL runtimePrintFloat
	LD HL,STRING_48	;    
	CALL runtimePrintString
ZX_LINE_5017:
; 5017  LET my=my+1{00 00 01 00 00 }
	LD HL,(ZXBASIC_VAR_my)
	INC HL
	LD (ZXBASIC_VAR_my),HL
ZX_LINE_5020:
; 5020  LET yf=nf-1{00 00 01 00 00 }
	LD HL,ZXBASIC_VAR_nf
	CALL runtimePushFloatVar
	LD HL,1
	CALL runtimeIntToFloat
	CALL runtimeMinusFloat
	LD HL,ZXBASIC_VAR_yf
	CALL runtimeStoreFloat
ZX_LINE_5025:
; 5025  LET mx=mx+1{00 00 01 00 00 }
	LD HL,(ZXBASIC_VAR_mx)
	INC HL
	LD (ZXBASIC_VAR_mx),HL
ZX_LINE_5030:
; 5030  LET zz=0{00 00 00 00 00 }
	LD HL,0
	CALL runtimeIntToFloat
	LD HL,ZXBASIC_VAR_zz
	CALL runtimeStoreFloat
ZX_LINE_5035:
; 5035  LET zi=0{00 00 00 00 00 }
	LD HL,0
	CALL runtimeIntToFloat
	LD HL,ZXBASIC_VAR_zi
	CALL runtimeStoreFloat
ZX_LINE_5040:
; 5040  FOR i=1{00 00 01 00 00 } TO 100{00 00 64 00 00 }
	LD HL,1
	LD (ZXBASIC_VAR_i),HL
	LD HL,100
	LD (ZXBASIC_VAR_for_i),HL
	LD HL,1
	LD (ZXBASIC_VAR_for_i_step),HL
FOR_20:
ZX_LINE_5045:
; 5045  IF zz>1000{00 00 e8 03 00 } ORX zi>1000{00 00 e8 03 00 } THEN  GOTO 5100{00 00 ec 13 00 }
	LD HL,ZXBASIC_VAR_zz
	CALL runtimePushFloatVar
	LD HL,1000
	CALL runtimeIntToFloat
	CALL runtimeBiggerFloat
	PUSH HL
	LD HL,ZXBASIC_VAR_zi
	CALL runtimePushFloatVar
	LD HL,1000
	CALL runtimeIntToFloat
	CALL runtimeBiggerFloat
	POP DE
	LD A,L
	OR E
	LD L,A
	LD H,0
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_17
	JP ZX_LINE_5100
ZXB_LABEL_17:
ZX_LINE_5050:
; 5050  LET zt=zz*zz-zi*zi+xf
	LD HL,ZXBASIC_VAR_zz
	CALL runtimePushFloatVar
	LD HL,ZXBASIC_VAR_zz
	CALL runtimePushFloatVar
	CALL runtimeMultFloat
	LD HL,ZXBASIC_VAR_zi
	CALL runtimePushFloatVar
	LD HL,ZXBASIC_VAR_zi
	CALL runtimePushFloatVar
	CALL runtimeMultFloat
	CALL runtimeMinusFloat
	LD HL,ZXBASIC_VAR_xf
	CALL runtimePushFloatVar
	CALL runtimePlusFloat
	LD HL,ZXBASIC_VAR_zt
	CALL runtimeStoreFloat
ZX_LINE_5060:
; 5060  LET zi=2{00 00 02 00 00 }*zz*zi+yf
	LD HL,2
	PUSH HL
	LD HL,ZXBASIC_VAR_zz
	CALL runtimePushFloatVar
	POP HL
	CALL runtimeIntToFloat
	CALL runtimeMultFloat
	LD HL,ZXBASIC_VAR_zi
	CALL runtimePushFloatVar
	CALL runtimeMultFloat
	LD HL,ZXBASIC_VAR_yf
	CALL runtimePushFloatVar
	CALL runtimePlusFloat
	LD HL,ZXBASIC_VAR_zi
	CALL runtimeStoreFloat
ZX_LINE_5070:
; 5070  LET zz=zt
	LD HL,ZXBASIC_VAR_zt
	CALL runtimePushFloatVar
	LD HL,ZXBASIC_VAR_zz
	CALL runtimeStoreFloat
ZX_LINE_5080:
; 5080  NEXT i
	LD HL,(ZXBASIC_VAR_i)
	LD BC,(ZXBASIC_VAR_for_i_step)
	ADD HL,BC
	LD (ZXBASIC_VAR_i),HL
	LD DE,(ZXBASIC_VAR_for_i)
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_20
ZX_LINE_5090:
; 5090  IF zz<2{00 00 02 00 00 } THEN  PLOT my,mx
	LD HL,ZXBASIC_VAR_zz
	CALL runtimePushFloatVar
	LD HL,2
	CALL runtimeIntToFloat
	CALL runtimeSmallerFloat
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_18
	LD DE,(ZXBASIC_VAR_my)
	LD HL,(ZXBASIC_VAR_mx)
	CALL runtimePlot
ZXB_LABEL_18:
ZX_LINE_5100:
; 5100  LET yf=yf+0.0156{7a 7f 97 24 74 }: IF yf<1{00 00 01 00 00 } THEN  GOTO 5025{00 00 a1 13 00 }
	LD HL,ZXBASIC_VAR_yf
	CALL runtimePushFloatVar
	LD HL,FLOAT_3
	CALL runtimePushFloatVar
	CALL runtimePlusFloat
	LD HL,ZXBASIC_VAR_yf
	CALL runtimeStoreFloat
	LD HL,ZXBASIC_VAR_yf
	CALL runtimePushFloatVar
	LD HL,1
	CALL runtimeIntToFloat
	CALL runtimeSmallerFloat
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_19
	JP ZX_LINE_5025
ZXB_LABEL_19:
ZX_LINE_5110:
; 5110  LET xf=xf+0.0156{7a 7f 97 24 74 }: IF xf<2{00 00 02 00 00 } THEN  GOTO 5015{00 00 97 13 00 }
	LD HL,ZXBASIC_VAR_xf
	CALL runtimePushFloatVar
	LD HL,FLOAT_3
	CALL runtimePushFloatVar
	CALL runtimePlusFloat
	LD HL,ZXBASIC_VAR_xf
	CALL runtimeStoreFloat
	LD HL,ZXBASIC_VAR_xf
	CALL runtimePushFloatVar
	LD HL,2
	CALL runtimeIntToFloat
	CALL runtimeSmallerFloat
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_20
	JP ZX_LINE_5015
ZXB_LABEL_20:
ZX_LINE_5120:
; 5120  GOTO 3600{00 00 10 0e 00 }
	JP ZX_LINE_3600
ZX_LINE_9998:
; 9998  STOP 
ZXBASIC_VAR_a:	defs 162
ZXBASIC_VAR_a_string:	dw 0
ZXBASIC_VAR_adr:	dw 0
ZXBASIC_VAR_adrl:	dw 0
ZXBASIC_VAR_af:	defs 5
ZXBASIC_VAR_b_string:	defs 22
ZXBASIC_VAR_bf:	defs 5
ZXBASIC_VAR_c:	dw 0
ZXBASIC_VAR_cf:	defs 5
ZXBASIC_VAR_dx:	dw 0
ZXBASIC_VAR_dy:	dw 0
ZXBASIC_VAR_f1:	defs 5
ZXBASIC_VAR_f2:	defs 5
ZXBASIC_VAR_f3:	defs 5
ZXBASIC_VAR_for_i:	dw 0
ZXBASIC_VAR_for_i_step:	dw 0
ZXBASIC_VAR_for_j:	dw 0
ZXBASIC_VAR_for_j_step:	dw 0
ZXBASIC_VAR_for_l:	dw 0
ZXBASIC_VAR_for_l_step:	dw 0
ZXBASIC_VAR_for_p:	dw 0
ZXBASIC_VAR_for_p_step:	dw 0
ZXBASIC_VAR_for_x:	dw 0
ZXBASIC_VAR_for_x_step:	dw 0
ZXBASIC_VAR_i:	dw 0
ZXBASIC_VAR_i1:	dw 0
ZXBASIC_VAR_i2:	dw 0
ZXBASIC_VAR_ix:	dw 0
ZXBASIC_VAR_j:	dw 0
ZXBASIC_VAR_k:	dw 0
ZXBASIC_VAR_l:	dw 0
ZXBASIC_VAR_mx:	dw 0
ZXBASIC_VAR_my:	dw 0
ZXBASIC_VAR_nf:	defs 5
ZXBASIC_VAR_p:	dw 0
ZXBASIC_VAR_pi:	defs 5
ZXBASIC_VAR_pos:	dw 0
ZXBASIC_VAR_x:	dw 0
ZXBASIC_VAR_x_string:	dw 0
ZXBASIC_VAR_xf:	defs 5
ZXBASIC_VAR_y:	dw 0
ZXBASIC_VAR_yf:	defs 5
ZXBASIC_VAR_z:	dw 0
ZXBASIC_VAR_zf:	defs 5
ZXBASIC_VAR_zi:	defs 5
ZXBASIC_VAR_zt:	defs 5
ZXBASIC_VAR_zz:	defs 5
FLOAT_1:	db $87, $76, $cc, $cc, $cd
FLOAT_2:	db $82, $48, $f5, $c2, $8f
FLOAT_3:	db $7a, $7f, $97, $24, $74
STRING_0:	dw 4
	db	"1234"
STRING_1:	dw 5
	db	"Hallo"
STRING_10:	dw 11
	db	" 5 Mult+Div"
STRING_11:	dw 10
	db	" 6 Strings"
STRING_12:	dw 8
	db	" 7 Float"
STRING_13:	dw 10
	db	" 8 SIN/COS"
STRING_14:	dw 13
	db	" 9 Mandelbrot"
STRING_15:	dw 2
	db	"  "
STRING_16:	dw 19
	db	"Zeichne 5000 Punkte"
STRING_17:	dw 13
	db	"Screen Scroll"
STRING_18:	dw 8
	db	"in Basic"
STRING_19:	dw 22
	db	"Weiter mit Tastendruck"
STRING_2:	dw 19
	db	"Scroll in Assembler"
STRING_20:	dw 6
	db	"Zeile "
STRING_21:	dw 1
	db	" "
STRING_22:	dw 26
	db	"Multiplizieren, Dividieren"
STRING_23:	dw 2
	db	"x*"
STRING_24:	dw 1
	db	"="
STRING_25:	dw 15
	db	"Mult/Div signed"
STRING_26:	dw 3
	db	"a$="
STRING_27:	dw 7
	db	"val a$="
STRING_28:	dw 6
	db	"start="
STRING_29:	dw 5
	db	"ende="
STRING_3:	dw 1
	db	"A"
STRING_30:	dw 6
	db	"mitte="
STRING_31:	dw 7
	db	"2.Byte="
STRING_32:	dw 0
STRING_33:	dw 28
	db	"test float und float mit int"
STRING_34:	dw 3
	db	"pi="
STRING_35:	dw 7
	db	"var pi="
STRING_36:	dw 3
	db	"f1="
STRING_37:	dw 4
	db	" f2="
STRING_38:	dw 3
	db	"i1="
STRING_39:	dw 4
	db	" i2="
STRING_4:	dw 13
	db	"UDG:", $90, $91, $92
STRING_40:	dw 6
	db	"f1/f2="
STRING_41:	dw 6
	db	"10-f3="
STRING_42:	dw 6
	db	"f3-10="
STRING_43:	dw 7
	db	"STKBOT="
STRING_44:	dw 7
	db	"STKEND="
STRING_45:	dw 11
	db	"SIN und COS"
STRING_46:	dw 10
	db	"Mandelbrot"
STRING_47:	dw 2
	db	"x="
STRING_48:	dw 4
	db	"    "
STRING_5:	dw 4
	db	"Menu"
STRING_6:	dw 7
	db	" 1 Plot"
STRING_7:	dw 13
	db	" 2 Array Test"
STRING_8:	dw 18
	db	" 3 Scroll in Basic"
STRING_9:	dw 11
	db	" 4 Data+UDG"
DATAPTR:	DW 0
DATA_3000:
	dw 24
	dw 60
	dw 126
	dw 219
	dw 255
	dw 36
	dw 90
	dw 165
DATA_3010:
	dw 60
	dw 66
	dw 102
	dw 153
	dw 129
	dw 90
	dw 66
	dw 60
DATA_3020:
	dw 0
	dw 0
	dw 255
	dw 153
	dw 255
	dw 129
	dw 255
	dw 36


    DISPLAY "Compiled Basic = ", /D, $-CBASIC_START,  " bytes"
