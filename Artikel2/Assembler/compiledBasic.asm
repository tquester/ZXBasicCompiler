
CBASIC_START
compiledBasic:
	call ZXHeapClear
	LD (runtimeSaveSP),SP
; 		1000.1  PAPER 1{00 00 01 00 00 }
	LD HL,1
	CALL runtimePaper
ZXBASIC_LINE_1010:
; 1010  INK 7
; 		1010.1  INK 7{00 00 07 00 00 }
	LD HL,7
	CALL runtimeInk
ZXBASIC_LINE_1020:
; 1020  CLS 
; 		1020.1  CLS 
	CALL runtimeCls
ZXBASIC_LINE_1030:
; 1030  PRINT "The IDE allows to create control codes like Paper and INK by"
; 		1030.1  PRINT "The IDE allows to create control codes like Paper and INK by"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_0	;The IDE allows to create control codes like Paper and INK by
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1040:
; 1040  PRINT "using the backslash"
; 		1040.1  PRINT "using the backslash"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_1	;using the backslash
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1050:
; 1050  PRINT "you can even use AT and TAB or add UDG characters by its code"
; 		1050.1  PRINT "you can even use AT and TAB or add UDG characters by its code"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_2	;you can even use AT and TAB or add UDG characters by its code
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1060:
; 1060  PRINT 
; 		1060.1  PRINT 
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1070:
; 1070  PRINT 
; 		1070.1  PRINT 
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1080:
; 1080  PRINT "\016\002This is red\016\007 and \016\004this green\016\007"
; 		1080.1  PRINT "\016\002This is red\016\007 and \016\004this green\016\007"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_3	;\016\002This is red\016\007 and \016\004this green\016\007
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1090:
; 1090  GO SUB 2980
; 		1090.1  GO SUB 2980{00 00 a4 0b 00 }
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_2980
ZXBASIC_LINE_1100:
; 1100  REM  int16 i
ZXBASIC_LINE_1110:
; 1110  REM  float f g
ZXBASIC_LINE_1120:
; 1120  CLS : PRINT "Line numbers are not needed"
; 		1120.1  CLS 
	CALL runtimeCls
; 		1120.2  PRINT "Line numbers are not needed"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_4	;Line numbers are not needed
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1130:
; 1130  PRINT "use labels instead:"
; 		1130.1  PRINT "use labels instead
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_5	;use labels instead:
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1140:
; 1140  PRINT 
; 		1140.1  PRINT 
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1150:
; 1150  PRINT "\016\006FOR i = 1 TO 10"
; 		1150.1  PRINT "\016\006FOR i = 1 TO 10"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_6	;\016\006FOR i = 1 TO 10
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1160:
; 1160  PRINT "\016\006    IF i = 5 THEN GOTO #forexit"
; 		1160.1  PRINT "\016\006    IF i = 5 THEN GOTO #forexit"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_7	;\016\006    IF i = 5 THEN GOTO #forexit
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1170:
; 1170  PRINT "\016\006    PRINT i"
; 		1170.1  PRINT "\016\006    PRINT i"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_8	;\016\006    PRINT i
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1180:
; 1180  PRINT "\016\006NEXT i"
; 		1180.1  PRINT "\016\006NEXT i"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_9	;\016\006NEXT i
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1190:
; 1190  PRINT "\016\006#forexit"
; 		1190.1  PRINT "\016\006#forexit"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_10	;\016\006#forexit
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1200:
; 1200  PRINT "\016\006PRINT "; CHR$ (34);"#forexit=;"; CHR$ (34);"#forexit"
; 		1200.1  PRINT "\016\006PRINT "; CHR$ (34{00 00 22 00 00 });"#forexit=;"; CHR$ (34{00 00 22 00 00 });"#forexit"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_11	;\016\006PRINT 
	CALL runtimePrintString
; CHR$
	LD HL,34
	CALL runtimeChr
	CALL runtimePrintString
	LD HL,STRING_12	;#forexit=;
	CALL runtimePrintString
; CHR$
	LD HL,34
	CALL runtimeChr
	CALL runtimePrintString
	LD HL,STRING_13	;#forexit
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
	CALL ZXFreeTempCompact
ZXBASIC_LINE_1210:
; 1210  PRINT "-----------------"
; 		1210.1  PRINT "-----------------"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_14	;-----------------
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1220:
; 1220  FOR i=1 TO 10
; 		1220.1  FOR i=1{00 00 01 00 00 } TO 10{00 00 0a 00 00 }
	CALL runtimeCheckBreak
	LD HL,1
	LD (ZXBASIC_VAR_i),HL
	LD HL,10
	LD (ZXBASIC_VAR_for_i),HL
FOR_0:
ZXBASIC_LINE_1230:
; 1230  IF i=5 THEN  GOTO 1260
; 		1230.1  IF i=5{00 00 05 00 00 } THEN  GOTO 1260{00 00 ec 04 00 }
	LD DE,(ZXBASIC_VAR_i)
	LD HL,5
; =
	CALL runtimeCmpHLEqDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_1
; 		1230.2  GOTO 1260{00 00 ec 04 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_1260
ZXB_LABEL_1:
ZXBASIC_LINE_1240:
; 1240  PRINT i
; 		1240.1  PRINT i
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,(ZXBASIC_VAR_i)
	CALL runtimePrintInt
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1250:
; 1250  NEXT i
; 		1250.1  NEXT i
	CALL runtimeCheckBreak
	LD HL,(ZXBASIC_VAR_i)
	INC HL
	LD (ZXBASIC_VAR_i),HL
	LD DE,(ZXBASIC_VAR_for_i)
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_0
ZXBASIC_LINE_1260:
; 1260  PRINT "#forexit=";1260
; 		1260.1  PRINT "#forexit=";1260{00 00 ec 04 00 }
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_15	;#forexit=
	CALL runtimePrintString
	LD HL,1260
	CALL runtimePrintInt
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1270:
; 1270  PRINT "Press any key";
; 		1270.1  PRINT "Press any key";
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_16	;Press any key
	CALL runtimePrintString
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1280:
; 1280  PAUSE 0
; 		1280.1  PAUSE 0{00 00 00 00 00 }
	LD HL,0
	CALL runtimePause
ZXBASIC_LINE_1290:
; 1290  CLS 
; 		1290.1  CLS 
	CALL runtimeCls
ZXBASIC_LINE_1300:
; 1300  REM  ------------- Drawing WITH REPEAT AND WHILE   ------
ZXBASIC_LINE_1310:
; 1310  REM  ----------------------------------------------------
ZXBASIC_LINE_1320:
; 1320  PRINT "Drawing WITH REPEAT AND WHILE"
; 		1320.1  PRINT "Drawing WITH REPEAT AND WHILE"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_17	;Drawing WITH REPEAT AND WHILE
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1330:
; 1330  LET x=10: LET y=10
; 		1330.1  LET x=10{00 00 0a 00 00 }
	LD HL,10
	LD (ZXBASIC_VAR_x),HL
; 		1330.2  LET y=10{00 00 0a 00 00 }
	LD (ZXBASIC_VAR_y),HL
ZXBASIC_LINE_1340:
; 1340  IF  NOT (x<200) THEN  GOTO 1420
; 		1340.1  IF  NOT (x<200{00 00 c8 00 00 }) THEN  GOTO 1420{00 00 8c 05 00 }
; NOT
	LD DE,(ZXBASIC_VAR_x)
	LD HL,200
; <
	CALL runtimeCmpHLltDE
	CALL runtimeNotHL
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_2
; 		1340.2  GOTO 1420{00 00 8c 05 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_1420
ZXB_LABEL_2:
ZXBASIC_LINE_1350:
; 1350  PLOT x,y: DRAW 5,0: DRAW 0,5: DRAW -5,0: DRAW 0,-5
; 		1350.1  PLOT x,y
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,(ZXBASIC_VAR_x)
	LD HL,(ZXBASIC_VAR_y)
	CALL runtimePlot
	POP AF
	LD (ZX_P_FLAG),A
; 		1350.2  DRAW 5{00 00 05 00 00 },0{00 00 00 00 00 }
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,5
	LD HL,0
	LD B,L
	LD C,E
	CALL runtimeDraw
	POP AF
	LD (ZX_P_FLAG),A
; 		1350.3  DRAW 0{00 00 00 00 00 },5{00 00 05 00 00 }
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,0
	LD HL,5
	LD B,L
	LD C,E
	CALL runtimeDraw
	POP AF
	LD (ZX_P_FLAG),A
; 		1350.4  DRAW -5{00 00 05 00 00 },0{00 00 00 00 00 }
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD BC,5
; -
	LD HL,0
	SUB HL,BC
	LD DE,HL
	LD HL,0
	LD B,L
	LD C,E
	CALL runtimeDraw
	POP AF
	LD (ZX_P_FLAG),A
; 		1350.5  DRAW 0{00 00 00 00 00 },-5{00 00 05 00 00 }
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,0
	PUSH HL
	LD BC,5
; -
	LD HL,0
	SUB HL,BC
	POP DE
	LD B,L
	LD C,E
	CALL runtimeDraw
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1360:
; 1360  LET y=y+10
; 		1360.1  LET y=y+10{00 00 0a 00 00 }
	LD DE,(ZXBASIC_VAR_y)
	LD HL,10
; +
	ADD HL,DE
	LD (ZXBASIC_VAR_y),HL
ZXBASIC_LINE_1370:
; 1370  IF y>100 THEN  GOTO 1390
; 		1370.1  IF y>100{00 00 64 00 00 } THEN  GOTO 1390{00 00 6e 05 00 }
	LD DE,(ZXBASIC_VAR_y)
	LD HL,100
; >
	CALL runtimeCmpHlGtDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_3
; 		1370.2  GOTO 1390{00 00 6e 05 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_1390
ZXB_LABEL_3:
ZXBASIC_LINE_1380:
; 1380  GOTO 1350
; 		1380.1  GOTO 1350{00 00 46 05 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_1350
ZXBASIC_LINE_1390:
; 1390  LET y=10
; 		1390.1  LET y=10{00 00 0a 00 00 }
	LD HL,10
	LD (ZXBASIC_VAR_y),HL
ZXBASIC_LINE_1400:
; 1400  LET x=x+10
; 		1400.1  LET x=x+10{00 00 0a 00 00 }
	LD DE,(ZXBASIC_VAR_x)
	LD HL,10
; +
	ADD HL,DE
	LD (ZXBASIC_VAR_x),HL
ZXBASIC_LINE_1410:
; 1410  GOTO 1340
; 		1410.1  GOTO 1340{00 00 3c 05 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_1340
ZXBASIC_LINE_1420:
; 1420  REM  ----------------------------------------------------
ZXBASIC_LINE_1430:
; 1430  PRINT "Press any key"
; 		1430.1  PRINT "Press any key"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_16	;Press any key
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1440:
; 1440  PAUSE 0
; 		1440.1  PAUSE 0{00 00 00 00 00 }
	LD HL,0
	CALL runtimePause
ZXBASIC_LINE_1450:
; 1450  CLS 
; 		1450.1  CLS 
	CALL runtimeCls
ZXBASIC_LINE_1460:
; 1460  PRINT "The CODE used FOR the drawing is:"
; 		1460.1  PRINT "The CODE used FOR the drawing is
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_18	;The CODE used FOR the drawing is:
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1470:
; 1470  PRINT 
; 		1470.1  PRINT 
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1480:
; 1480  INK 6
; 		1480.1  INK 6{00 00 06 00 00 }
	LD HL,6
	CALL runtimeInk
ZXBASIC_LINE_1490:
; 1490  PRINT "x = 10: y = 10"
; 		1490.1  PRINT "x = 10
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_19	;x = 10: y = 10
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1500:
; 1500  PRINT "WHILE x < 200"
; 		1500.1  PRINT "WHILE x < 200"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_20	;WHILE x < 200
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1510:
; 1510  PRINT "   REPEAT "
; 		1510.1  PRINT "   REPEAT "
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_21	;   REPEAT 
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1520:
; 1520  PRINT "      PLOT x,y: DRAW 5,0: DRAW 0,5: DRAW -5,0: DRAW 0,-5"
; 		1520.1  PRINT "      PLOT x,y
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_22	;      PLOT x,y: DRAW 5,0: DRAW 0,5: DRAW -5,0: DRAW 0,-5
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1530:
; 1530  PRINT "      y = y + 10"
; 		1530.1  PRINT "      y = y + 10"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_23	;      y = y + 10
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1540:
; 1540  PRINT "    UNTIL y > 100"
; 		1540.1  PRINT "    UNTIL y > 100"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_24	;    UNTIL y > 100
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1550:
; 1550  PRINT "    y = 10"
; 		1550.1  PRINT "    y = 10"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_25	;    y = 10
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1560:
; 1560  PRINT "    x = x + 10"
; 		1560.1  PRINT "    x = x + 10"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_26	;    x = x + 10
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1570:
; 1570  PRINT "WEND"
; 		1570.1  PRINT "WEND"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_27	;WEND
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1580:
; 1580  GO SUB 2980
; 		1580.1  GO SUB 2980{00 00 a4 0b 00 }
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_2980
ZXBASIC_LINE_1590:
; 1590  CLS 
; 		1590.1  CLS 
	CALL runtimeCls
ZXBASIC_LINE_1600:
; 1600  PRINT "The CODE gets converted TO ": PRINT 
; 		1600.1  PRINT "The CODE gets converted TO "
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_28	;The CODE gets converted TO 
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
; 		1600.2  PRINT 
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1610:
; 1610  INK 6
; 		1610.1  INK 6{00 00 06 00 00 }
	LD HL,6
	CALL runtimeInk
ZXBASIC_LINE_1620:
; 1620  PRINT "1130 LET x = 10"
; 		1620.1  PRINT "1130 LET x = 10"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_29	;1130 LET x = 10
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1630:
; 1630  PRINT "1140 LET y = 10"
; 		1630.1  PRINT "1140 LET y = 10"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_30	;1140 LET y = 10
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1640:
; 1640  PRINT "1150 IF NOT(x < 200) THEN GOTO 1230"
; 		1640.1  PRINT "1150 IF NOT(x < 200) THEN GOTO 1230"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_31	;1150 IF NOT(x < 200) THEN GOTO 1230
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1650:
; 1650  PRINT "1160 PLOT x,y: DRAW 5,0: DRAW 0,5: DRAW -5,0: DRAW 0,-5"
; 		1650.1  PRINT "1160 PLOT x,y
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_32	;1160 PLOT x,y: DRAW 5,0: DRAW 0,5: DRAW -5,0: DRAW 0,-5
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1660:
; 1660  PRINT "1170 LET y = y + 10"
; 		1660.1  PRINT "1170 LET y = y + 10"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_33	;1170 LET y = y + 10
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1670:
; 1670  PRINT "1180 IF y > 100 THEN GOTO 1200"
; 		1670.1  PRINT "1180 IF y > 100 THEN GOTO 1200"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_34	;1180 IF y > 100 THEN GOTO 1200
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1680:
; 1680  PRINT "1190 GOTO 1160"
; 		1680.1  PRINT "1190 GOTO 1160"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_35	;1190 GOTO 1160
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1690:
; 1690  PRINT "1200 LET y = 10"
; 		1690.1  PRINT "1200 LET y = 10"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_36	;1200 LET y = 10
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1700:
; 1700  PRINT "1210 LET x = x + 10"
; 		1700.1  PRINT "1210 LET x = x + 10"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_37	;1210 LET x = x + 10
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1710:
; 1710  PRINT "1220 GOTO 1150"
; 		1710.1  PRINT "1220 GOTO 1150"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_38	;1220 GOTO 1150
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1720:
; 1720  GO SUB 2980
; 		1720.1  GO SUB 2980{00 00 a4 0b 00 }
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_2980
ZXBASIC_LINE_1730:
; 1730  REM  ----------------------------------------------------
ZXBASIC_LINE_1740:
; 1740  PRINT "You can use SELECT instead of IF"
; 		1740.1  PRINT "You can use SELECT instead of IF"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_39	;You can use SELECT instead of IF
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1750:
; 1750  INK 6
; 		1750.1  INK 6{00 00 06 00 00 }
	LD HL,6
	CALL runtimeInk
ZXBASIC_LINE_1760:
; 1760  PRINT "SELECT a"
; 		1760.1  PRINT "SELECT a"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_40	;SELECT a
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1770:
; 1770  PRINT " CASE 49:PRINT "; CHR$ (34);"1 pressed"; CHR$ (34);":BREAK"
; 		1770.1  PRINT " CASE 49
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_41	; CASE 49:PRINT 
	CALL runtimePrintString
; CHR$
	LD HL,34
	CALL runtimeChr
	CALL runtimePrintString
	LD HL,STRING_42	;1 pressed
	CALL runtimePrintString
; CHR$
	LD HL,34
	CALL runtimeChr
	CALL runtimePrintString
	LD HL,STRING_43	;:BREAK
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
	CALL ZXFreeTempCompact
ZXBASIC_LINE_1780:
; 1780  PRINT " CASE 50:PRINT "; CHR$ (34);"2 pressed"; CHR$ (34);":BREAK"
; 		1780.1  PRINT " CASE 50
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_44	; CASE 50:PRINT 
	CALL runtimePrintString
; CHR$
	LD HL,34
	CALL runtimeChr
	CALL runtimePrintString
	LD HL,STRING_45	;2 pressed
	CALL runtimePrintString
; CHR$
	LD HL,34
	CALL runtimeChr
	CALL runtimePrintString
	LD HL,STRING_43	;:BREAK
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
	CALL ZXFreeTempCompact
ZXBASIC_LINE_1790:
; 1790  PRINT " CASE 51:PRINT "; CHR$ (34);"3 pressed"; CHR$ (34);":BREAK"
; 		1790.1  PRINT " CASE 51
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_46	; CASE 51:PRINT 
	CALL runtimePrintString
; CHR$
	LD HL,34
	CALL runtimeChr
	CALL runtimePrintString
	LD HL,STRING_47	;3 pressed
	CALL runtimePrintString
; CHR$
	LD HL,34
	CALL runtimeChr
	CALL runtimePrintString
	LD HL,STRING_43	;:BREAK
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
	CALL ZXFreeTempCompact
ZXBASIC_LINE_1800:
; 1800  PRINT " CASE 52:PRINT "; CHR$ (34);"4 pressed"; CHR$ (34);":BREAK"
; 		1800.1  PRINT " CASE 52
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_48	; CASE 52:PRINT 
	CALL runtimePrintString
; CHR$
	LD HL,34
	CALL runtimeChr
	CALL runtimePrintString
	LD HL,STRING_49	;4 pressed
	CALL runtimePrintString
; CHR$
	LD HL,34
	CALL runtimeChr
	CALL runtimePrintString
	LD HL,STRING_43	;:BREAK
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
	CALL ZXFreeTempCompact
ZXBASIC_LINE_1810:
; 1810  PRINT " CASE 120:PRINT "; CHR$ (34);"you pressed x"; CHR$ (3);":BREAK"
; 		1810.1  PRINT " CASE 120
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_50	; CASE 120:PRINT 
	CALL runtimePrintString
; CHR$
	LD HL,34
	CALL runtimeChr
	CALL runtimePrintString
	LD HL,STRING_51	;you pressed x
	CALL runtimePrintString
; CHR$
	LD HL,3
	CALL runtimeChr
	CALL runtimePrintString
	LD HL,STRING_43	;:BREAK
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
	CALL ZXFreeTempCompact
ZXBASIC_LINE_1820:
; 1820  PRINT "  DEFAULT:"
; 		1820.1  PRINT "  DEFAULT
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_52	;  DEFAULT:
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1830:
; 1830  PRINT "  PRINT "; CHR$ (34);"you pressed something ELSE"; CHR$ (34)
; 		1830.1  PRINT "  PRINT "; CHR$ (34{00 00 22 00 00 });"you pressed something ELSE"; CHR$ (34{00 00 22 00 00 })
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_53	;  PRINT 
	CALL runtimePrintString
; CHR$
	LD HL,34
	CALL runtimeChr
	CALL runtimePrintString
	LD HL,STRING_54	;you pressed something ELSE
	CALL runtimePrintString
; CHR$
	LD HL,34
	CALL runtimeChr
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
	CALL ZXFreeTempCompact
ZXBASIC_LINE_1840:
; 1840  PRINT "END"
; 		1840.1  PRINT "END"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_55	;END
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1850:
; 1850  GO SUB 2980
; 		1850.1  GO SUB 2980{00 00 a4 0b 00 }
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_2980
ZXBASIC_LINE_1860:
; 1860  PRINT "This will be converted into"
; 		1860.1  PRINT "This will be converted into"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_56	;This will be converted into
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1870:
; 1870  INK 6
; 		1870.1  INK 6{00 00 06 00 00 }
	LD HL,6
	CALL runtimeInk
ZXBASIC_LINE_1880:
; 1880  PRINT "1810 IF a <> 49 THEN GOTO 1830"
; 		1880.1  PRINT "1810 IF a <> 49 THEN GOTO 1830"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_57	;1810 IF a <> 49 THEN GOTO 1830
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1890:
; 1890  PRINT "1820 PRINT "; CHR$ (34);"1 pressed"; CHR$ (34);": GOTO 1960"
; 		1890.1  PRINT "1820 PRINT "; CHR$ (34{00 00 22 00 00 });"1 pressed"; CHR$ (34{00 00 22 00 00 });"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_58	;1820 PRINT 
	CALL runtimePrintString
; CHR$
	LD HL,34
	CALL runtimeChr
	CALL runtimePrintString
	LD HL,STRING_42	;1 pressed
	CALL runtimePrintString
; CHR$
	LD HL,34
	CALL runtimeChr
	CALL runtimePrintString
	LD HL,STRING_59	;: GOTO 1960
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
	CALL ZXFreeTempCompact
ZXBASIC_LINE_1900:
; 1900  PRINT "1830 IF a <> 50 THEN GOTO 1850"
; 		1900.1  PRINT "1830 IF a <> 50 THEN GOTO 1850"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_60	;1830 IF a <> 50 THEN GOTO 1850
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1910:
; 1910  PRINT "1840 PRINT "; CHR$ (34);"2 pressed"; CHR$ (34);": GOTO 1960"
; 		1910.1  PRINT "1840 PRINT "; CHR$ (34{00 00 22 00 00 });"2 pressed"; CHR$ (34{00 00 22 00 00 });"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_61	;1840 PRINT 
	CALL runtimePrintString
; CHR$
	LD HL,34
	CALL runtimeChr
	CALL runtimePrintString
	LD HL,STRING_45	;2 pressed
	CALL runtimePrintString
; CHR$
	LD HL,34
	CALL runtimeChr
	CALL runtimePrintString
	LD HL,STRING_59	;: GOTO 1960
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
	CALL ZXFreeTempCompact
ZXBASIC_LINE_1920:
; 1920  PRINT "1850 IF a <> 51 THEN GOTO 1870"
; 		1920.1  PRINT "1850 IF a <> 51 THEN GOTO 1870"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_62	;1850 IF a <> 51 THEN GOTO 1870
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1930:
; 1930  PRINT "1860 PRINT "; CHR$ (34);"3 pressed"; CHR$ (34);": GOTO 1960"
; 		1930.1  PRINT "1860 PRINT "; CHR$ (34{00 00 22 00 00 });"3 pressed"; CHR$ (34{00 00 22 00 00 });"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_63	;1860 PRINT 
	CALL runtimePrintString
; CHR$
	LD HL,34
	CALL runtimeChr
	CALL runtimePrintString
	LD HL,STRING_47	;3 pressed
	CALL runtimePrintString
; CHR$
	LD HL,34
	CALL runtimeChr
	CALL runtimePrintString
	LD HL,STRING_59	;: GOTO 1960
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
	CALL ZXFreeTempCompact
ZXBASIC_LINE_1940:
; 1940  PRINT "1870 IF a <> 52 THEN GOTO 1890"
; 		1940.1  PRINT "1870 IF a <> 52 THEN GOTO 1890"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_64	;1870 IF a <> 52 THEN GOTO 1890
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1950:
; 1950  PRINT "1880 PRINT "; CHR$ (34);"4 pressed"; CHR$ (34);": GOTO 1960"
; 		1950.1  PRINT "1880 PRINT "; CHR$ (34{00 00 22 00 00 });"4 pressed"; CHR$ (34{00 00 22 00 00 });"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_65	;1880 PRINT 
	CALL runtimePrintString
; CHR$
	LD HL,34
	CALL runtimeChr
	CALL runtimePrintString
	LD HL,STRING_49	;4 pressed
	CALL runtimePrintString
; CHR$
	LD HL,34
	CALL runtimeChr
	CALL runtimePrintString
	LD HL,STRING_59	;: GOTO 1960
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
	CALL ZXFreeTempCompact
ZXBASIC_LINE_1960:
; 1960  PRINT "1890 IF a <> 53 THEN GOTO 1910"
; 		1960.1  PRINT "1890 IF a <> 53 THEN GOTO 1910"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_66	;1890 IF a <> 53 THEN GOTO 1910
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1970:
; 1970  PRINT 
; 		1970.1  PRINT 
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1980:
; 1980  INK 7
; 		1980.1  INK 7{00 00 07 00 00 }
	LD HL,7
	CALL runtimeInk
ZXBASIC_LINE_1990:
; 1990  PRINT "though it is not faster but"
; 		1990.1  PRINT "though it is not faster but"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_67	;though it is not faster but
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_2000:
; 2000  PRINT "easier to read"
; 		2000.1  PRINT "easier to read"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_68	;easier to read
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_2010:
; 2010  PRINT 
; 		2010.1  PRINT 
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_2020:
; 2020  PRINT "Lets try it"
; 		2020.1  PRINT "Lets try it"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_69	;Lets try it
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_2030:
; 2030  GO SUB 2980
; 		2030.1  GO SUB 2980{00 00 a4 0b 00 }
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_2980
ZXBASIC_LINE_2040:
; 2040  PRINT "Press any number between 1 AND 6, x TO EXIT"
; 		2040.1  PRINT "Press any number between 1 AND 6, x TO EXIT"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_70	;Press any number between 1 AND 6, x TO EXIT
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_2050:
; 2050  LET a= CODE  INKEY$ 
; 		2050.1  LET a= CODE  INKEY$ 
; CODE
; INKEY$
	CALL runtimeInkey
	CALL runtimeCode
	LD (ZXBASIC_VAR_a),HL
	CALL ZXFreeTempCompact
ZXBASIC_LINE_2060:
; 2060  IF a <> 0 THEN  GOTO 2080
; 		2060.1  IF a <> 0{00 00 00 00 00 } THEN  GOTO 2080{00 00 20 08 00 }
	LD DE,(ZXBASIC_VAR_a)
	LD HL,0
; <>
	CALL runtimeCmpHlNeDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_4
; 		2060.2  GOTO 2080{00 00 20 08 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_2080
ZXB_LABEL_4:
ZXBASIC_LINE_2070:
; 2070  GOTO 2050
; 		2070.1  GOTO 2050{00 00 02 08 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_2050
ZXBASIC_LINE_2080:
; 2080  IF  NOT ( CODE  INKEY$  <> 0) THEN  GOTO 2100
; 		2080.1  IF  NOT ( CODE  INKEY$  <> 0{00 00 00 00 00 }) THEN  GOTO 2100{00 00 34 08 00 }
; NOT
; CODE
; INKEY$
	CALL runtimeInkey
	CALL runtimeCode
	LD DE,HL
	LD HL,0
; <>
	CALL runtimeCmpHlNeDE
	CALL runtimeNotHL
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_5
; 		2080.2  GOTO 2100{00 00 34 08 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_2100
ZXB_LABEL_5:
ZXBASIC_LINE_2090:
; 2090  GOTO 2080
; 		2090.1  GOTO 2080{00 00 20 08 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_2080
ZXBASIC_LINE_2100:
; 2100  IF a <> 49 THEN  GOTO 2120
; 		2100.1  IF a <> 49{00 00 31 00 00 } THEN  GOTO 2120{00 00 48 08 00 }
	LD DE,(ZXBASIC_VAR_a)
	LD HL,49
; <>
	CALL runtimeCmpHlNeDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_6
; 		2100.2  GOTO 2120{00 00 48 08 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_2120
ZXB_LABEL_6:
ZXBASIC_LINE_2110:
; 2110  PRINT "1 pressed": GOTO 2250
; 		2110.1  PRINT "1 pressed"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_42	;1 pressed
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
; 		2110.2  GOTO 2250{00 00 ca 08 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_2250
ZXBASIC_LINE_2120:
; 2120  IF a <> 50 THEN  GOTO 2140
; 		2120.1  IF a <> 50{00 00 32 00 00 } THEN  GOTO 2140{00 00 5c 08 00 }
	LD DE,(ZXBASIC_VAR_a)
	LD HL,50
; <>
	CALL runtimeCmpHlNeDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_7
; 		2120.2  GOTO 2140{00 00 5c 08 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_2140
ZXB_LABEL_7:
ZXBASIC_LINE_2130:
; 2130  PRINT "2 pressed": GOTO 2250
; 		2130.1  PRINT "2 pressed"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_45	;2 pressed
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
; 		2130.2  GOTO 2250{00 00 ca 08 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_2250
ZXBASIC_LINE_2140:
; 2140  IF a <> 51 THEN  GOTO 2160
; 		2140.1  IF a <> 51{00 00 33 00 00 } THEN  GOTO 2160{00 00 70 08 00 }
	LD DE,(ZXBASIC_VAR_a)
	LD HL,51
; <>
	CALL runtimeCmpHlNeDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_8
; 		2140.2  GOTO 2160{00 00 70 08 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_2160
ZXB_LABEL_8:
ZXBASIC_LINE_2150:
; 2150  PRINT "3 pressed": GOTO 2250
; 		2150.1  PRINT "3 pressed"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_47	;3 pressed
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
; 		2150.2  GOTO 2250{00 00 ca 08 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_2250
ZXBASIC_LINE_2160:
; 2160  IF a <> 52 THEN  GOTO 2180
; 		2160.1  IF a <> 52{00 00 34 00 00 } THEN  GOTO 2180{00 00 84 08 00 }
	LD DE,(ZXBASIC_VAR_a)
	LD HL,52
; <>
	CALL runtimeCmpHlNeDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_9
; 		2160.2  GOTO 2180{00 00 84 08 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_2180
ZXB_LABEL_9:
ZXBASIC_LINE_2170:
; 2170  PRINT "4 pressed": GOTO 2250
; 		2170.1  PRINT "4 pressed"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_49	;4 pressed
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
; 		2170.2  GOTO 2250{00 00 ca 08 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_2250
ZXBASIC_LINE_2180:
; 2180  IF a <> 53 THEN  GOTO 2200
; 		2180.1  IF a <> 53{00 00 35 00 00 } THEN  GOTO 2200{00 00 98 08 00 }
	LD DE,(ZXBASIC_VAR_a)
	LD HL,53
; <>
	CALL runtimeCmpHlNeDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_10
; 		2180.2  GOTO 2200{00 00 98 08 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_2200
ZXB_LABEL_10:
ZXBASIC_LINE_2190:
; 2190  PRINT "5 pressed": GOTO 2250
; 		2190.1  PRINT "5 pressed"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_71	;5 pressed
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
; 		2190.2  GOTO 2250{00 00 ca 08 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_2250
ZXBASIC_LINE_2200:
; 2200  IF a <> 54 THEN  GOTO 2220
; 		2200.1  IF a <> 54{00 00 36 00 00 } THEN  GOTO 2220{00 00 ac 08 00 }
	LD DE,(ZXBASIC_VAR_a)
	LD HL,54
; <>
	CALL runtimeCmpHlNeDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_11
; 		2200.2  GOTO 2220{00 00 ac 08 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_2220
ZXB_LABEL_11:
ZXBASIC_LINE_2210:
; 2210  PRINT "6 pressed": GOTO 2250
; 		2210.1  PRINT "6 pressed"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_72	;6 pressed
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
; 		2210.2  GOTO 2250{00 00 ca 08 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_2250
ZXBASIC_LINE_2220:
; 2220  IF a <> 120 THEN  GOTO 2240
; 		2220.1  IF a <> 120{00 00 78 00 00 } THEN  GOTO 2240{00 00 c0 08 00 }
	LD DE,(ZXBASIC_VAR_a)
	LD HL,120
; <>
	CALL runtimeCmpHlNeDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_12
; 		2220.2  GOTO 2240{00 00 c0 08 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_2240
ZXB_LABEL_12:
ZXBASIC_LINE_2230:
; 2230  PRINT "you pressed x": GOTO 2250
; 		2230.1  PRINT "you pressed x"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_51	;you pressed x
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
; 		2230.2  GOTO 2250{00 00 ca 08 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_2250
ZXBASIC_LINE_2240:
; 2240  PRINT "you pressed something ELSE"
; 		2240.1  PRINT "you pressed something ELSE"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_54	;you pressed something ELSE
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_2250:
; 2250  IF a= CODE "x" THEN  GOTO 2270
; 		2250.1  IF a= CODE "x" THEN  GOTO 2270{00 00 de 08 00 }
	LD HL,(ZXBASIC_VAR_a)
	PUSH HL
; CODE
	LD HL,STRING_73	;x
	CALL runtimeCode
; =
	POP DE
	CALL runtimeCmpHLEqDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_13
; 		2250.2  GOTO 2270{00 00 de 08 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_2270
ZXB_LABEL_13:
ZXBASIC_LINE_2260:
; 2260  GOTO 2050
; 		2260.1  GOTO 2050{00 00 02 08 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_2050
ZXBASIC_LINE_2270:
; 2270  GO SUB 2980
; 		2270.1  GO SUB 2980{00 00 a4 0b 00 }
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_2980
ZXBASIC_LINE_2280:
; 2280  REM  ----------------------------------------------------
ZXBASIC_LINE_2290:
; 2290  PRINT "instead of GOSUB you can"
; 		2290.1  PRINT "instead of GOSUB you can"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_74	;instead of GOSUB you can
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_2300:
; 2300  PRINT "define subs with parameters"
; 		2300.1  PRINT "define subs with parameters"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_75	;define subs with parameters
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_2310:
; 2310  PRINT 
; 		2310.1  PRINT 
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_2320:
; 2320  INK 6
; 		2320.1  INK 6{00 00 06 00 00 }
	LD HL,6
	CALL runtimeInk
ZXBASIC_LINE_2330:
; 2330  PRINT "SUB box(x,y,w)"
; 		2330.1  PRINT "SUB box(x,y,w)"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_76	;SUB box(x,y,w)
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_2340:
; 2340  PRINT "    PLOT x,y:"
; 		2340.1  PRINT "    PLOT x,y
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_77	;    PLOT x,y:
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_2350:
; 2350  PRINT "    DRAW 0,w: DRAW w,0: DRAW 0,-w: DRAW -w,0"
; 		2350.1  PRINT "    DRAW 0,w
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_78	;    DRAW 0,w: DRAW w,0: DRAW 0,-w: DRAW -w,0
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_2360:
; 2360  PRINT "END"
; 		2360.1  PRINT "END"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_55	;END
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_2370:
; 2370  INK 7
; 		2370.1  INK 7{00 00 07 00 00 }
	LD HL,7
	CALL runtimeInk
ZXBASIC_LINE_2380:
; 2380  PRINT 
; 		2380.1  PRINT 
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_2390:
; 2390  PRINT "and call it with"
; 		2390.1  PRINT "and call it with"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_79	;and call it with
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_2400:
; 2400  INK 6
; 		2400.1  INK 6{00 00 06 00 00 }
	LD HL,6
	CALL runtimeInk
ZXBASIC_LINE_2410:
; 2410  PRINT "call box(x,y,10)"
; 		2410.1  PRINT "call box(x,y,10)"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_80	;call box(x,y,10)
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_2420:
; 2420  PRINT 
; 		2420.1  PRINT 
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_2430:
; 2430  INK 7
; 		2430.1  INK 7{00 00 07 00 00 }
	LD HL,7
	CALL runtimeInk
ZXBASIC_LINE_2440:
; 2440  PRINT "lets try it"
; 		2440.1  PRINT "lets try it"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_81	;lets try it
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_2450:
; 2450  GO SUB 2980
; 		2450.1  GO SUB 2980{00 00 a4 0b 00 }
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_2980
ZXBASIC_LINE_2460:
; 2460  PRINT "call will be translated to GOSUB"
; 		2460.1  PRINT "call will be translated to GOSUB"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_82	;call will be translated to GOSUB
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_2470:
; 2470  INK 6
; 		2470.1  INK 6{00 00 06 00 00 }
	LD HL,6
	CALL runtimeInk
ZXBASIC_LINE_2480:
; 2480  PRINT "FOR x = 1 TO 100 STEP 10"
; 		2480.1  PRINT "FOR x = 1 TO 100 STEP 10"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_83	;FOR x = 1 TO 100 STEP 10
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_2490:
; 2490  PRINT "FOR y = 50 TO 100 STEP 10"
; 		2490.1  PRINT "FOR y = 50 TO 100 STEP 10"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_84	;FOR y = 50 TO 100 STEP 10
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_2500:
; 2500  PRINT "LET PROCbox0=x:LET PROCbox1=y:LET PROCbox2=9:GO SUB 2590"
; 		2500.1  PRINT "LET PROCbox0=x
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_85	;LET PROCbox0=x:LET PROCbox1=y:LET PROCbox2=9:GO SUB 2590
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_2510:
; 2510  PRINT "NEXT y:NEXT x"
; 		2510.1  PRINT "NEXT y
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_86	;NEXT y:NEXT x
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_2520:
; 2520  INK 7
; 		2520.1  INK 7{00 00 07 00 00 }
	LD HL,7
	CALL runtimeInk
ZXBASIC_LINE_2530:
; 2530  FOR x=1 TO 100 STEP 10: FOR y=50 TO 100 STEP 10: LET PROCbox0=x: LET PROCbox1=y: LET PROCbox2=9: GO SUB 2860: NEXT y: NEXT x: GO SUB 2980: PRINT "Though a call is slower than using"
; 		2530.1  FOR x=1{00 00 01 00 00 } TO 100{00 00 64 00 00 } STEP 10{00 00 0a 00 00 }
	CALL runtimeCheckBreak
	LD HL,1
	LD (ZXBASIC_VAR_x),HL
	LD HL,100
	LD (ZXBASIC_VAR_for_x),HL
	LD HL,10
	LD (ZXBASIC_VAR_for_x_step),HL
FOR_1:
; 		2530.2  FOR y=50{00 00 32 00 00 } TO 100{00 00 64 00 00 } STEP 10{00 00 0a 00 00 }
	CALL runtimeCheckBreak
	LD HL,50
	LD (ZXBASIC_VAR_y),HL
	LD HL,100
	LD (ZXBASIC_VAR_for_y),HL
	LD HL,10
	LD (ZXBASIC_VAR_for_y_step),HL
FOR_2:
; 		2530.3  LET PROCbox0=x
	LD HL,(ZXBASIC_VAR_x)
	LD (ZXBASIC_VAR_PROCbox0),HL
; 		2530.4  LET PROCbox1=y
	LD HL,(ZXBASIC_VAR_y)
	LD (ZXBASIC_VAR_PROCbox1),HL
; 		2530.5  LET PROCbox2=9{00 00 09 00 00 }
	LD HL,9
	LD (ZXBASIC_VAR_PROCbox2),HL
; 		2530.6  GO SUB 2860{00 00 2c 0b 00 }
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_2860
; 		2530.7  NEXT y
	CALL runtimeCheckBreak
	LD HL,(ZXBASIC_VAR_y)
	LD BC,(ZXBASIC_VAR_for_y_step)
	LD A,B
	ADD HL,BC
	LD (ZXBASIC_VAR_y),HL
	LD DE,(ZXBASIC_VAR_for_y)
	AND $80
	JR Z,FOR_2_1
	SUB HL,DE
	JP Z,FOR_2_2
	JP NC,FOR_2
	JR FOR_2_2
FOR_2_1:
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_2
FOR_2_2:
; 		2530.8  NEXT x
	CALL runtimeCheckBreak
	LD HL,(ZXBASIC_VAR_x)
	LD BC,(ZXBASIC_VAR_for_x_step)
	LD A,B
	ADD HL,BC
	LD (ZXBASIC_VAR_x),HL
	LD DE,(ZXBASIC_VAR_for_x)
	AND $80
	JR Z,FOR_1_1
	SUB HL,DE
	JP Z,FOR_1_2
	JP NC,FOR_1
	JR FOR_1_2
FOR_1_1:
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_1
FOR_1_2:
; 		2530.9  GO SUB 2980{00 00 a4 0b 00 }
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_2980
; 		2530.10  PRINT "Though a call is slower than using"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_87	;Though a call is slower than using
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_2540:
; 2540  PRINT "GOSUB with global variables"
; 		2540.1  PRINT "GOSUB with global variables"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_88	;GOSUB with global variables
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_2550:
; 2550  PRINT "it is easier and the compiler"
; 		2550.1  PRINT "it is easier and the compiler"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_89	;it is easier and the compiler
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_2560:
; 2560  PRINT "will automatically remove all"
; 		2560.1  PRINT "will automatically remove all"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_90	;will automatically remove all
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_2570:
; 2570  PRINT "unused subs"
; 		2570.1  PRINT "unused subs"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_91	;unused subs
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_2580:
; 2580  PRINT 
; 		2580.1  PRINT 
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_2590:
; 2590  PRINT "Calling a PROCEDURE WITH local  variables:": LET PROCtest0=5: GO SUB 2900
; 		2590.1  PRINT "Calling a PROCEDURE WITH local  variables
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_92	;Calling a PROCEDURE WITH local  variables:
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
; 		2590.2  LET PROCtest0=5{00 00 05 00 00 }
	LD HL,5
	LD (ZXBASIC_VAR_PROCtest0),HL
; 		2590.3  GO SUB 2900{00 00 54 0b 00 }
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_2900
ZXBASIC_LINE_2600:
; 2600  GO SUB 2980
; 		2600.1  GO SUB 2980{00 00 a4 0b 00 }
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_2980
ZXBASIC_LINE_2610:
; 2610  PRINT "You can us multi line IF with"
; 		2610.1  PRINT "You can us multi line IF with"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_93	;You can us multi line IF with
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_2620:
; 2620  PRINT "ELSE"
; 		2620.1  PRINT "ELSE"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_94	;ELSE
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_2630:
; 2630  PRINT 
; 		2630.1  PRINT 
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_2640:
; 2640  INK 6
; 		2640.1  INK 6{00 00 06 00 00 }
	LD HL,6
	CALL runtimeInk
ZXBASIC_LINE_2650:
; 2650  PRINT "FOR i = 1 TO 4"
; 		2650.1  PRINT "FOR i = 1 TO 4"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_95	;FOR i = 1 TO 4
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_2660:
; 2660  PRINT "    WHEN i=3"
; 		2660.1  PRINT "    WHEN i=3"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_96	;    WHEN i=3
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_2670:
; 2670  PRINT "        PRINT i"
; 		2670.1  PRINT "        PRINT i"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_97	;        PRINT i
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_2680:
; 2680  PRINT "    ELSE"
; 		2680.1  PRINT "    ELSE"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_98	;    ELSE
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_2690:
; 2690  PRINT "        PRINT "; CHR$ (34);"i is NOT 3"
; 		2690.1  PRINT "        PRINT "; CHR$ (34{00 00 22 00 00 });"i is NOT 3"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_99	;        PRINT 
	CALL runtimePrintString
; CHR$
	LD HL,34
	CALL runtimeChr
	CALL runtimePrintString
	LD HL,STRING_100	;i is NOT 3
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
	CALL ZXFreeTempCompact
ZXBASIC_LINE_2700:
; 2700  PRINT "    END"
; 		2700.1  PRINT "    END"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_101	;    END
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_2710:
; 2710  PRINT "NEXT i"
; 		2710.1  PRINT "NEXT i"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_102	;NEXT i
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_2720:
; 2720  INK 7
; 		2720.1  INK 7{00 00 07 00 00 }
	LD HL,7
	CALL runtimeInk
ZXBASIC_LINE_2730:
; 2730  PRINT "The compiler will also trans-": PRINT "late it with GOTO"
; 		2730.1  PRINT "The compiler will also trans-"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_103	;The compiler will also trans-
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
; 		2730.2  PRINT "late it with GOTO"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_104	;late it with GOTO
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_2740:
; 2740  PRINT 
; 		2740.1  PRINT 
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_2750:
; 2750  PRINT "Lets try it"
; 		2750.1  PRINT "Lets try it"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_69	;Lets try it
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_2760:
; 2760  FOR i=1 TO 4
; 		2760.1  FOR i=1{00 00 01 00 00 } TO 4{00 00 04 00 00 }
	CALL runtimeCheckBreak
	LD HL,1
	LD (ZXBASIC_VAR_i),HL
	LD HL,4
	LD (ZXBASIC_VAR_for_i),HL
FOR_3:
ZXBASIC_LINE_2770:
; 2770  IF  NOT (i=3) THEN  GOTO 2800
; 		2770.1  IF  NOT (i=3{00 00 03 00 00 }) THEN  GOTO 2800{00 00 f0 0a 00 }
; NOT
	LD DE,(ZXBASIC_VAR_i)
	LD HL,3
; =
	CALL runtimeCmpHLEqDE
	CALL runtimeNotHL
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_14
; 		2770.2  GOTO 2800{00 00 f0 0a 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_2800
ZXB_LABEL_14:
ZXBASIC_LINE_2780:
; 2780  PRINT "i ist 3"
; 		2780.1  PRINT "i ist 3"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_105	;i ist 3
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_2790:
; 2790  GOTO 2810
; 		2790.1  GOTO 2810{00 00 fa 0a 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_2810
ZXBASIC_LINE_2800:
; 2800  PRINT "i is NOT 3, it is ";i
; 		2800.1  PRINT "i is NOT 3, it is ";i
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_106	;i is NOT 3, it is 
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_i)
	CALL runtimePrintInt
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_2810:
; 2810  NEXT i
; 		2810.1  NEXT i
	CALL runtimeCheckBreak
	LD HL,(ZXBASIC_VAR_i)
	INC HL
	LD (ZXBASIC_VAR_i),HL
	LD DE,(ZXBASIC_VAR_for_i)
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_3
ZXBASIC_LINE_2820:
; 2820  GO SUB 2980
; 		2820.1  GO SUB 2980{00 00 a4 0b 00 }
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_2980
ZXBASIC_LINE_2830:
; 2830  GOTO 3030
; 		2830.1  GOTO 3030{00 00 d6 0b 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_3030
ZXBASIC_LINE_2840:
; 2840  REM  SUB box(0=x, 1=y, 2=w)
ZXBASIC_LINE_2850:
; 2850  REM  -----------------------
ZXBASIC_LINE_2860:
; 2860  PLOT PROCbox0,PROCbox1: DRAW 0,PROCbox2: DRAW PROCbox2,0: DRAW 0,-PROCbox2: DRAW -PROCbox2,0
; 		2860.1  PLOT PROCbox0,PROCbox1
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,(ZXBASIC_VAR_PROCbox0)
	LD HL,(ZXBASIC_VAR_PROCbox1)
	CALL runtimePlot
	POP AF
	LD (ZX_P_FLAG),A
; 		2860.2  DRAW 0{00 00 00 00 00 },PROCbox2
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,0
	LD HL,(ZXBASIC_VAR_PROCbox2)
	LD B,L
	LD C,E
	CALL runtimeDraw
	POP AF
	LD (ZX_P_FLAG),A
; 		2860.3  DRAW PROCbox2,0{00 00 00 00 00 }
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,(ZXBASIC_VAR_PROCbox2)
	LD HL,0
	LD B,L
	LD C,E
	CALL runtimeDraw
	POP AF
	LD (ZX_P_FLAG),A
; 		2860.4  DRAW 0{00 00 00 00 00 },-PROCbox2
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,0
	PUSH HL
	LD BC,(ZXBASIC_VAR_PROCbox2)
; -
	LD HL,0
	SUB HL,BC
	POP DE
	LD B,L
	LD C,E
	CALL runtimeDraw
	POP AF
	LD (ZX_P_FLAG),A
; 		2860.5  DRAW -PROCbox2,0{00 00 00 00 00 }
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD BC,(ZXBASIC_VAR_PROCbox2)
; -
	LD HL,0
	SUB HL,BC
	LD DE,HL
	LD HL,0
	LD B,L
	LD C,E
	CALL runtimeDraw
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_2870:
; 2870  RETURN 
; 		2870.1  RETURN 
	CALL runtimeCheckBreak
	RET
ZXBASIC_LINE_2880:
; 2880  REM  SUB test(0=count)
ZXBASIC_LINE_2890:
; 2890  REM  ------------------
ZXBASIC_LINE_2900:
; 2900  LET PROCtesti=1
; 		2900.1  LET PROCtesti=1{00 00 01 00 00 }
	LD HL,1
	LD (ZXBASIC_VAR_PROCtesti),HL
ZXBASIC_LINE_2910:
; 2910  PRINT "i=";PROCtesti
; 		2910.1  PRINT "i=";PROCtesti
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_107	;i=
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_PROCtesti)
	CALL runtimePrintInt
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_2920:
; 2920  LET PROCtesti=PROCtesti+1
; 		2920.1  LET PROCtesti=PROCtesti+1{00 00 01 00 00 }
	LD HL,(ZXBASIC_VAR_PROCtesti)
	INC HL
; +
	LD (ZXBASIC_VAR_PROCtesti),HL
ZXBASIC_LINE_2930:
; 2930  IF PROCtesti>PROCtest0 THEN  GOTO 2950
; 		2930.1  IF PROCtesti>PROCtest0 THEN  GOTO 2950{00 00 86 0b 00 }
	LD DE,(ZXBASIC_VAR_PROCtesti)
	LD HL,(ZXBASIC_VAR_PROCtest0)
; >
	CALL runtimeCmpHlGtDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_15
; 		2930.2  GOTO 2950{00 00 86 0b 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_2950
ZXB_LABEL_15:
ZXBASIC_LINE_2940:
; 2940  GOTO 2910
; 		2940.1  GOTO 2910{00 00 5e 0b 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_2910
ZXBASIC_LINE_2950:
; 2950  RETURN 
; 		2950.1  RETURN 
	CALL runtimeCheckBreak
	RET
ZXBASIC_LINE_2960:
; 2960  REM  SUB anykey
ZXBASIC_LINE_2970:
; 2970  REM  -----------
ZXBASIC_LINE_2980:
; 2980  INK 7
; 		2980.1  INK 7{00 00 07 00 00 }
	LD HL,7
	CALL runtimeInk
ZXBASIC_LINE_2990:
; 2990  PRINT  AT 21,0;"Press any key";
; 		2990.1  PRINT  AT 21{00 00 15 00 00 },0{00 00 00 00 00 };"Press any key";
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,21
	LD HL,0
	CALL runtimePrintAt
	LD HL,STRING_16	;Press any key
	CALL runtimePrintString
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_3000:
; 3000  PAUSE 0
; 		3000.1  PAUSE 0{00 00 00 00 00 }
	LD HL,0
	CALL runtimePause
ZXBASIC_LINE_3010:
; 3010  CLS 
; 		3010.1  CLS 
	CALL runtimeCls
ZXBASIC_LINE_3020:
; 3020  RETURN 
; 		3020.1  RETURN 
	CALL runtimeCheckBreak
	RET
ZXBASIC_LINE_3030:
; 3030  CLS 
; 		3030.1  CLS 
	CALL runtimeCls
ZXBASIC_LINE_3040:
; 3040  PRINT "If the program ends in the compiler. ZX Spectrum will reset or halt"
; 		3040.1  PRINT "If the program ends in the compiler. ZX Spectrum will reset or halt"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_108	;If the program ends in the compiler. ZX Spectrum will reset or halt
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_3050:
; 3050  PAUSE 0
; 		3050.1  PAUSE 0{00 00 00 00 00 }
	LD HL,0
	CALL runtimePause
ZXBASIC_LINE_3060:
; 3060  STOP 
ZXBASIC_VAR_PROCbox0:	dw 0
ZXBASIC_VAR_PROCbox1:	dw 0
ZXBASIC_VAR_PROCbox2:	dw 0
ZXBASIC_VAR_PROCtest0:	dw 0
ZXBASIC_VAR_PROCtesti:	dw 0
ZXBASIC_VAR_a:	dw 0
ZXBASIC_VAR_f:	defs 5
ZXBASIC_VAR_for_i:	dw 0
ZXBASIC_VAR_for_x:	dw 0
ZXBASIC_VAR_for_x_step:	dw 0
ZXBASIC_VAR_for_y:	dw 0
ZXBASIC_VAR_for_y_step:	dw 0
ZXBASIC_VAR_g:	defs 5
ZXBASIC_VAR_i:	dw 0
ZXBASIC_VAR_x:	dw 0
ZXBASIC_VAR_y:	dw 0
STRING_0:	dw 60
	db	"The IDE allows to create control codes like Paper and INK by"
STRING_1:	dw 19
	db	"using the backslash"
STRING_10:	dw 10
	db	16, 6, "#forexit"
STRING_100:	dw 10
	db	"i is NOT 3"
STRING_101:	dw 7
	db	"    END"
STRING_102:	dw 6
	db	"NEXT i"
STRING_103:	dw 29
	db	"The compiler will also trans-"
STRING_104:	dw 17
	db	"late it with GOTO"
STRING_105:	dw 7
	db	"i ist 3"
STRING_106:	dw 18
	db	"i is NOT 3, it is "
STRING_107:	dw 2
	db	"i="
STRING_108:	dw 67
	db	"If the program ends in the compiler. ZX Spectrum will reset or halt"
STRING_11:	dw 8
	db	16, 6, "PRINT "
STRING_12:	dw 10
	db	"#forexit=;"
STRING_13:	dw 8
	db	"#forexit"
STRING_14:	dw 17
	db	"-----------------"
STRING_15:	dw 9
	db	"#forexit="
STRING_16:	dw 13
	db	"Press any key"
STRING_17:	dw 29
	db	"Drawing WITH REPEAT AND WHILE"
STRING_18:	dw 33
	db	"The CODE used FOR the drawing is:"
STRING_19:	dw 14
	db	"x = 10: y = 10"
STRING_2:	dw 61
	db	"you can even use AT and TAB or add UDG characters by its code"
STRING_20:	dw 13
	db	"WHILE x < 200"
STRING_21:	dw 10
	db	"   REPEAT "
STRING_22:	dw 56
	db	"      PLOT x,y: DRAW 5,0: DRAW 0,5: DRAW -5,0: DRAW 0,-5"
STRING_23:	dw 16
	db	"      y = y + 10"
STRING_24:	dw 17
	db	"    UNTIL y > 100"
STRING_25:	dw 10
	db	"    y = 10"
STRING_26:	dw 14
	db	"    x = x + 10"
STRING_27:	dw 4
	db	"WEND"
STRING_28:	dw 27
	db	"The CODE gets converted TO "
STRING_29:	dw 15
	db	"1130 LET x = 10"
STRING_3:	dw 34
	db	16, 2, "This is red", 16, 7, " and ", 16, 4, "this green", 16, 7
STRING_30:	dw 15
	db	"1140 LET y = 10"
STRING_31:	dw 35
	db	"1150 IF NOT(x < 200) THEN GOTO 1230"
STRING_32:	dw 55
	db	"1160 PLOT x,y: DRAW 5,0: DRAW 0,5: DRAW -5,0: DRAW 0,-5"
STRING_33:	dw 19
	db	"1170 LET y = y + 10"
STRING_34:	dw 30
	db	"1180 IF y > 100 THEN GOTO 1200"
STRING_35:	dw 14
	db	"1190 GOTO 1160"
STRING_36:	dw 15
	db	"1200 LET y = 10"
STRING_37:	dw 19
	db	"1210 LET x = x + 10"
STRING_38:	dw 14
	db	"1220 GOTO 1150"
STRING_39:	dw 32
	db	"You can use SELECT instead of IF"
STRING_4:	dw 27
	db	"Line numbers are not needed"
STRING_40:	dw 8
	db	"SELECT a"
STRING_41:	dw 15
	db	" CASE 49:PRINT "
STRING_42:	dw 9
	db	"1 pressed"
STRING_43:	dw 6
	db	":BREAK"
STRING_44:	dw 15
	db	" CASE 50:PRINT "
STRING_45:	dw 9
	db	"2 pressed"
STRING_46:	dw 15
	db	" CASE 51:PRINT "
STRING_47:	dw 9
	db	"3 pressed"
STRING_48:	dw 15
	db	" CASE 52:PRINT "
STRING_49:	dw 9
	db	"4 pressed"
STRING_5:	dw 19
	db	"use labels instead:"
STRING_50:	dw 16
	db	" CASE 120:PRINT "
STRING_51:	dw 13
	db	"you pressed x"
STRING_52:	dw 10
	db	"  DEFAULT:"
STRING_53:	dw 8
	db	"  PRINT "
STRING_54:	dw 26
	db	"you pressed something ELSE"
STRING_55:	dw 3
	db	"END"
STRING_56:	dw 27
	db	"This will be converted into"
STRING_57:	dw 30
	db	"1810 IF a <> 49 THEN GOTO 1830"
STRING_58:	dw 11
	db	"1820 PRINT "
STRING_59:	dw 11
	db	": GOTO 1960"
STRING_6:	dw 17
	db	16, 6, "FOR i = 1 TO 10"
STRING_60:	dw 30
	db	"1830 IF a <> 50 THEN GOTO 1850"
STRING_61:	dw 11
	db	"1840 PRINT "
STRING_62:	dw 30
	db	"1850 IF a <> 51 THEN GOTO 1870"
STRING_63:	dw 11
	db	"1860 PRINT "
STRING_64:	dw 30
	db	"1870 IF a <> 52 THEN GOTO 1890"
STRING_65:	dw 11
	db	"1880 PRINT "
STRING_66:	dw 30
	db	"1890 IF a <> 53 THEN GOTO 1910"
STRING_67:	dw 27
	db	"though it is not faster but"
STRING_68:	dw 14
	db	"easier to read"
STRING_69:	dw 11
	db	"Lets try it"
STRING_7:	dw 33
	db	16, 6, "    IF i = 5 THEN GOTO #forexit"
STRING_70:	dw 43
	db	"Press any number between 1 AND 6, x TO EXIT"
STRING_71:	dw 9
	db	"5 pressed"
STRING_72:	dw 9
	db	"6 pressed"
STRING_73:	dw 1
	db	"x"
STRING_74:	dw 24
	db	"instead of GOSUB you can"
STRING_75:	dw 27
	db	"define subs with parameters"
STRING_76:	dw 14
	db	"SUB box(x,y,w)"
STRING_77:	dw 13
	db	"    PLOT x,y:"
STRING_78:	dw 44
	db	"    DRAW 0,w: DRAW w,0: DRAW 0,-w: DRAW -w,0"
STRING_79:	dw 16
	db	"and call it with"
STRING_8:	dw 13
	db	16, 6, "    PRINT i"
STRING_80:	dw 16
	db	"call box(x,y,10)"
STRING_81:	dw 11
	db	"lets try it"
STRING_82:	dw 32
	db	"call will be translated to GOSUB"
STRING_83:	dw 24
	db	"FOR x = 1 TO 100 STEP 10"
STRING_84:	dw 25
	db	"FOR y = 50 TO 100 STEP 10"
STRING_85:	dw 56
	db	"LET PROCbox0=x:LET PROCbox1=y:LET PROCbox2=9:GO SUB 2590"
STRING_86:	dw 13
	db	"NEXT y:NEXT x"
STRING_87:	dw 34
	db	"Though a call is slower than using"
STRING_88:	dw 27
	db	"GOSUB with global variables"
STRING_89:	dw 29
	db	"it is easier and the compiler"
STRING_9:	dw 8
	db	16, 6, "NEXT i"
STRING_90:	dw 29
	db	"will automatically remove all"
STRING_91:	dw 11
	db	"unused subs"
STRING_92:	dw 42
	db	"Calling a PROCEDURE WITH local  variables:"
STRING_93:	dw 29
	db	"You can us multi line IF with"
STRING_94:	dw 4
	db	"ELSE"
STRING_95:	dw 14
	db	"FOR i = 1 TO 4"
STRING_96:	dw 12
	db	"    WHEN i=3"
STRING_97:	dw 15
	db	"        PRINT i"
STRING_98:	dw 8
	db	"    ELSE"
STRING_99:	dw 14
	db	"        PRINT "

ZX_VARIABLES:
	db 0

    DISPLAY "Compiled Basic = ", /D, $-CBASIC_START,  " bytes"