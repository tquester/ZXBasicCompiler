
CBASIC_START
compiledBasic:
	call ZXHeapClear
	LD (runtimeSaveSP),SP
	LD (DATAPTR),HL
	LD HL,DATA_2180
; 1010.1  DIM b(5)
	LD HL,ZXBASIC_VAR_b_array
	LD BC,12
	CALL runtimeClearArray
; 1020.1  DIM c(5)
	LD HL,ZXBASIC_VAR_c_array
	LD BC,12
	CALL runtimeClearArray
; 1030.1  DIM d(5)
	LD HL,ZXBASIC_VAR_d_array
	LD BC,12
	CALL runtimeClearArray
; 1040.1  DIM e(5)
	LD HL,ZXBASIC_VAR_e_array
	LD BC,12
	CALL runtimeClearArray
; 1050.1  DIM f(5)
	LD HL,ZXBASIC_VAR_f_array
	LD BC,12
	CALL runtimeClearArray
; 		1000.1  RESTORE 2180{00 00 84 08 00 }
	LD DE,2180
	LD HL,ZXDATA
	CALL runtimeFindLine
	EX HL,DE
	LD (DATAPTR),DE
ZXBASIC_LINE_1010:
; 1010  DIM b(5)
; 		1010.1  DIM b(5{00 00 05 00 00 })
	LD HL,ZXBASIC_VAR_b_array
	LD BC,12
	CALL runtimeClearArray
ZXBASIC_LINE_1020:
; 1020  DIM c(5)
; 		1020.1  DIM c(5{00 00 05 00 00 })
	LD HL,ZXBASIC_VAR_c_array
	LD BC,12
	CALL runtimeClearArray
ZXBASIC_LINE_1030:
; 1030  DIM d(5)
; 		1030.1  DIM d(5{00 00 05 00 00 })
	LD HL,ZXBASIC_VAR_d_array
	LD BC,12
	CALL runtimeClearArray
ZXBASIC_LINE_1040:
; 1040  DIM e(5)
; 		1040.1  DIM e(5{00 00 05 00 00 })
	LD HL,ZXBASIC_VAR_e_array
	LD BC,12
	CALL runtimeClearArray
ZXBASIC_LINE_1050:
; 1050  DIM f(5)
; 		1050.1  DIM f(5{00 00 05 00 00 })
	LD HL,ZXBASIC_VAR_f_array
	LD BC,12
	CALL runtimeClearArray
ZXBASIC_LINE_1060:
; 1060  LET PROCreadudg0=10: GO SUB 1770
; 		1060.1  LET PROCreadudg0=10{00 00 0a 00 00 }
	LD HL,10
	LD (ZXBASIC_VAR_PROCreadudg0),HL
; 		1060.2  GO SUB 1770{00 00 ea 06 00 }
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_1770
ZXBASIC_LINE_1070:
; 1070  GO SUB 1850
; 		1070.1  GO SUB 1850{00 00 3a 07 00 }
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_1850
ZXBASIC_LINE_1080:
; 1080  LET playerInputSelect=1
; 		1080.1  LET playerInputSelect=1{00 00 01 00 00 }
	LD HL,1
	LD (ZXBASIC_VAR_playerInputSelect),HL
ZXBASIC_LINE_1090:
; 1090  GO SUB 1140
; 		1090.1  GO SUB 1140{00 00 74 04 00 }
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_1140
ZXBASIC_LINE_1100:
; 1100  PRINT "\144\145\146\147\148\149\150\151\152"
; 		1100.1  PRINT "\144\145\146\147\148\149\150\151\152"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_0	;\144\145\146\147\148\149\150\151\152
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1110:
; 1110  PAUSE 0
; 		1110.1  PAUSE 0{00 00 00 00 00 }
	LD HL,0
	CALL runtimePause
ZXBASIC_LINE_1120:
; 1120  REM  SUB game
ZXBASIC_LINE_1130:
; 1130  REM  ---------
ZXBASIC_LINE_1140:
; 1140  GO SUB 1320
; 		1140.1  GO SUB 1320{00 00 28 05 00 }
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_1320
ZXBASIC_LINE_1150:
; 1150  PAPER 1
; 		1150.1  PAPER 1{00 00 01 00 00 }
	LD HL,1
	CALL runtimePaper
ZXBASIC_LINE_1160:
; 1160  INK 7
; 		1160.1  INK 7{00 00 07 00 00 }
	LD HL,7
	CALL runtimeInk
ZXBASIC_LINE_1170:
; 1170  LET playerx=0
; 		1170.1  LET playerx=0{00 00 00 00 00 }
	LD HL,0
	LD (ZXBASIC_VAR_playerx),HL
ZXBASIC_LINE_1180:
; 1180  LET playery=17
; 		1180.1  LET playery=17{00 00 11 00 00 }
	LD HL,17
	LD (ZXBASIC_VAR_playery),HL
ZXBASIC_LINE_1190:
; 1190  CLS 
; 		1190.1  CLS 
	CALL runtimeCls
ZXBASIC_LINE_1200:
; 1200  GO SUB 1370
; 		1200.1  GO SUB 1370{00 00 5a 05 00 }
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_1370
ZXBASIC_LINE_1210:
; 1210  PRINT  AT playery,playerx;"\145";
; 		1210.1  PRINT  AT playery,playerx;"\145";
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,(ZXBASIC_VAR_playery)
	LD HL,(ZXBASIC_VAR_playerx)
	CALL runtimePrintAt
	LD HL,STRING_1	;\145
	CALL runtimePrintString
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1220:
; 1220  GO SUB 1880
; 		1220.1  GO SUB 1880{00 00 58 07 00 }
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_1880
ZXBASIC_LINE_1230:
; 1230  PAUSE 3
; 		1230.1  PAUSE 3{00 00 03 00 00 }
	LD HL,3
	CALL runtimePause
ZXBASIC_LINE_1240:
; 1240  GO SUB 1630
; 		1240.1  GO SUB 1630{00 00 5e 06 00 }
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_1630
ZXBASIC_LINE_1250:
; 1250  GO SUB 1460
; 		1250.1  GO SUB 1460{00 00 b4 05 00 }
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_1460
ZXBASIC_LINE_1260:
; 1260  IF playerfire THEN  LET PROCshoot0=playerx: GO SUB 1550: LET playerfire=0
; 		1260.1  IF playerfire THEN  LET PROCshoot0=playerx
	LD HL,(ZXBASIC_VAR_playerfire)
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_1
; 		1260.2  LET PROCshoot0=playerx
	LD HL,(ZXBASIC_VAR_playerx)
	LD (ZXBASIC_VAR_PROCshoot0),HL
; 		1260.3  GO SUB 1550{00 00 0e 06 00 }
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_1550
; 		1260.4  LET playerfire=0{00 00 00 00 00 }
	LD HL,0
	LD (ZXBASIC_VAR_playerfire),HL
ZXB_LABEL_1:
ZXBASIC_LINE_1270:
; 1270  IF playermoved THEN  PRINT  AT playeryold,playerxold;" "; AT playery,playerx;"\145";: GOTO 1220
; 		1270.1  IF playermoved THEN  PRINT  AT playeryold,playerxold;" "; AT playery,playerx;"\145";
	LD HL,(ZXBASIC_VAR_playermoved)
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_2
; 		1270.2  PRINT  AT playeryold,playerxold;" "; AT playery,playerx;"\145";
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,(ZXBASIC_VAR_playeryold)
	LD HL,(ZXBASIC_VAR_playerxold)
	CALL runtimePrintAt
	LD HL,STRING_2	; 
	CALL runtimePrintString
	LD DE,(ZXBASIC_VAR_playery)
	LD HL,(ZXBASIC_VAR_playerx)
	CALL runtimePrintAt
	LD HL,STRING_1	;\145
	CALL runtimePrintString
	POP AF
	LD (ZX_P_FLAG),A
; 		1270.3  GOTO 1220{00 00 c4 04 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_1220
ZXB_LABEL_2:
ZXBASIC_LINE_1280:
; 1280  GOTO 1220
; 		1280.1  GOTO 1220{00 00 c4 04 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_1220
ZXBASIC_LINE_1290:
; 1290  RETURN 
; 		1290.1  RETURN 
	CALL runtimeCheckBreak
	RET
ZXBASIC_LINE_1300:
; 1300  REM  SUB clearbullets
ZXBASIC_LINE_1310:
; 1310  REM  -----------------
ZXBASIC_LINE_1320:
; 1320  FOR i=1 TO 5: LET b(i)=100
; 		1320.1  FOR i=1{00 00 01 00 00 } TO 5{00 00 05 00 00 }
	CALL runtimeCheckBreak
	LD HL,1
	LD (ZXBASIC_VAR_i),HL
	LD HL,5
	LD (ZXBASIC_VAR_for_i),HL
FOR_0:
; 		1320.2  LET b(i)=100{00 00 64 00 00 }
	LD HL,(ZXBASIC_VAR_i)
	LD DE,5
	CALL runtimeMult16bit
	ADD HL,HL
	PUSH HL
	LD DE,100
	POP HL
	LD BC,ZXBASIC_VAR_b_array
	ADD HL,BC
	LD (HL),DE
ZXBASIC_LINE_1330:
; 1330  NEXT i
; 		1330.1  NEXT i
	CALL runtimeCheckBreak
	LD HL,(ZXBASIC_VAR_i)
	INC HL
	LD (ZXBASIC_VAR_i),HL
	LD DE,(ZXBASIC_VAR_for_i)
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_0
ZXBASIC_LINE_1340:
; 1340  RETURN 
; 		1340.1  RETURN 
	CALL runtimeCheckBreak
	RET
ZXBASIC_LINE_1350:
; 1350  REM  SUB initaliens
ZXBASIC_LINE_1360:
; 1360  REM  ---------------
ZXBASIC_LINE_1370:
; 1370  FOR i=1 TO 5
; 		1370.1  FOR i=1{00 00 01 00 00 } TO 5{00 00 05 00 00 }
	CALL runtimeCheckBreak
	LD HL,1
	LD (ZXBASIC_VAR_i),HL
	LD HL,5
	LD (ZXBASIC_VAR_for_i),HL
FOR_1:
ZXBASIC_LINE_1380:
; 1380  LET d(i)= RND *32
; 		1380.1  LET d(i)= RND *32{00 00 20 00 00 }
	LD HL,(ZXBASIC_VAR_i)
	LD DE,5
	CALL runtimeMult16bit
	ADD HL,HL
	PUSH HL
; RND
	CALL runtimeRND
	LD HL,32
; *
	CALL runtimeIntToFloat
	RST $28
	DB $04	;MULT
	DB $38	;END CALC
	CALL runtimeFloatToInt
	LD DE,HL
	POP HL
	LD BC,ZXBASIC_VAR_d_array
	ADD HL,BC
	LD (HL),DE
ZXBASIC_LINE_1390:
; 1390  LET e(i)= RND *5
; 		1390.1  LET e(i)= RND *5{00 00 05 00 00 }
	LD HL,(ZXBASIC_VAR_i)
	LD DE,5
	CALL runtimeMult16bit
	ADD HL,HL
	PUSH HL
; RND
	CALL runtimeRND
	LD HL,5
; *
	CALL runtimeIntToFloat
	RST $28
	DB $04	;MULT
	DB $38	;END CALC
	CALL runtimeFloatToInt
	LD DE,HL
	POP HL
	LD BC,ZXBASIC_VAR_e_array
	ADD HL,BC
	LD (HL),DE
ZXBASIC_LINE_1400:
; 1400  LET f(i)=1
; 		1400.1  LET f(i)=1{00 00 01 00 00 }
	LD HL,(ZXBASIC_VAR_i)
	LD DE,5
	CALL runtimeMult16bit
	ADD HL,HL
	PUSH HL
	LD DE,1
	POP HL
	LD BC,ZXBASIC_VAR_f_array
	ADD HL,BC
	LD (HL),DE
ZXBASIC_LINE_1410:
; 1410  PRINT  AT e(i),d(i);"\146";
; 		1410.1  PRINT  AT e(i),d(i);"\146";
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
; Array-Access
	LD HL,(ZXBASIC_VAR_i)
	LD DE,5
	CALL runtimeMult16bit
	ADD HL,HL
	LD DE, ZXBASIC_VAR_e_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
; Array-Access
	LD HL,(ZXBASIC_VAR_i)
	LD DE,5
	CALL runtimeMult16bit
	ADD HL,HL
	LD DE, ZXBASIC_VAR_d_array
	ADD HL,DE
	LD DE,(HL)
	LD HL,DE
	POP DE
	CALL runtimePrintAt
	LD HL,STRING_3	;\146
	CALL runtimePrintString
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1420:
; 1420  NEXT i
; 		1420.1  NEXT i
	CALL runtimeCheckBreak
	LD HL,(ZXBASIC_VAR_i)
	INC HL
	LD (ZXBASIC_VAR_i),HL
	LD DE,(ZXBASIC_VAR_for_i)
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_1
ZXBASIC_LINE_1430:
; 1430  RETURN 
; 		1430.1  RETURN 
	CALL runtimeCheckBreak
	RET
ZXBASIC_LINE_1440:
; 1440  REM  SUB movealiens
ZXBASIC_LINE_1450:
; 1450  REM  ---------------
ZXBASIC_LINE_1460:
; 1460  FOR i=1 TO 5
; 		1460.1  FOR i=1{00 00 01 00 00 } TO 5{00 00 05 00 00 }
	CALL runtimeCheckBreak
	LD HL,1
	LD (ZXBASIC_VAR_i),HL
	LD HL,5
	LD (ZXBASIC_VAR_for_i),HL
FOR_2:
ZXBASIC_LINE_1470:
; 1470  PRINT  AT e(i),d(i);" ";
; 		1470.1  PRINT  AT e(i),d(i);" ";
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
; Array-Access
	LD HL,(ZXBASIC_VAR_i)
	LD DE,5
	CALL runtimeMult16bit
	ADD HL,HL
	LD DE, ZXBASIC_VAR_e_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
; Array-Access
	LD HL,(ZXBASIC_VAR_i)
	LD DE,5
	CALL runtimeMult16bit
	ADD HL,HL
	LD DE, ZXBASIC_VAR_d_array
	ADD HL,DE
	LD DE,(HL)
	LD HL,DE
	POP DE
	CALL runtimePrintAt
	LD HL,STRING_2	; 
	CALL runtimePrintString
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1480:
; 1480  LET d(i)=d(i)+f(i)
; 		1480.1  LET d(i)=d(i)+f(i)
	LD HL,(ZXBASIC_VAR_i)
	LD DE,5
	CALL runtimeMult16bit
	ADD HL,HL
	PUSH HL
; Array-Access
	LD HL,(ZXBASIC_VAR_i)
	LD DE,5
	CALL runtimeMult16bit
	ADD HL,HL
	LD DE, ZXBASIC_VAR_d_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
; Array-Access
	LD HL,(ZXBASIC_VAR_i)
	LD DE,5
	CALL runtimeMult16bit
	ADD HL,HL
	LD DE, ZXBASIC_VAR_f_array
	ADD HL,DE
	LD DE,(HL)
	LD HL,DE
; +
	POP DE
	ADD HL,DE
	LD DE,HL
	POP HL
	LD BC,ZXBASIC_VAR_d_array
	ADD HL,BC
	LD (HL),DE
ZXBASIC_LINE_1490:
; 1490  PRINT  AT e(i),d(i);"\146";
; 		1490.1  PRINT  AT e(i),d(i);"\146";
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
; Array-Access
	LD HL,(ZXBASIC_VAR_i)
	LD DE,5
	CALL runtimeMult16bit
	ADD HL,HL
	LD DE, ZXBASIC_VAR_e_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
; Array-Access
	LD HL,(ZXBASIC_VAR_i)
	LD DE,5
	CALL runtimeMult16bit
	ADD HL,HL
	LD DE, ZXBASIC_VAR_d_array
	ADD HL,DE
	LD DE,(HL)
	LD HL,DE
	POP DE
	CALL runtimePrintAt
	LD HL,STRING_3	;\146
	CALL runtimePrintString
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1500:
; 1500  IF d(i)<1 OR d(i)>30 THEN  LET f(i)=f(i)*-1: PRINT  AT e(i),d(i);" ";: LET e(i)=e(i)+1: IF e(i)=17 THEN  LET e(i)=1
; 		1500.1  IF d(i)<1{00 00 01 00 00 } OR d(i)>30{00 00 1e 00 00 } THEN  LET f(i)=f(i)*-1{00 00 01 00 00 }
; Array-Access
	LD HL,(ZXBASIC_VAR_i)
	LD DE,5
	CALL runtimeMult16bit
	ADD HL,HL
	LD DE, ZXBASIC_VAR_d_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,1
; <
	POP DE
	CALL runtimeCmpHLltDE
	PUSH HL
; Array-Access
	LD HL,(ZXBASIC_VAR_i)
	LD DE,5
	CALL runtimeMult16bit
	ADD HL,HL
	LD DE, ZXBASIC_VAR_d_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,30
; >
	POP DE
	CALL runtimeCmpHlGtDE
; OR
	POP DE
	call runtimeOrHLDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_3
; 		1500.2  LET f(i)=f(i)*-1{00 00 01 00 00 }
	LD HL,(ZXBASIC_VAR_i)
	LD DE,5
	CALL runtimeMult16bit
	ADD HL,HL
	PUSH HL
; Array-Access
	LD HL,(ZXBASIC_VAR_i)
	LD DE,5
	CALL runtimeMult16bit
	ADD HL,HL
	LD DE, ZXBASIC_VAR_f_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD BC,1
; -
	LD HL,0
	SUB HL,BC
; *
	POP DE
	call runtimeMult16bit
	LD DE,HL
	POP HL
	LD BC,ZXBASIC_VAR_f_array
	ADD HL,BC
	LD (HL),DE
; 		1500.3  PRINT  AT e(i),d(i);" ";
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
; Array-Access
	LD HL,(ZXBASIC_VAR_i)
	LD DE,5
	CALL runtimeMult16bit
	ADD HL,HL
	LD DE, ZXBASIC_VAR_e_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
; Array-Access
	LD HL,(ZXBASIC_VAR_i)
	LD DE,5
	CALL runtimeMult16bit
	ADD HL,HL
	LD DE, ZXBASIC_VAR_d_array
	ADD HL,DE
	LD DE,(HL)
	LD HL,DE
	POP DE
	CALL runtimePrintAt
	LD HL,STRING_2	; 
	CALL runtimePrintString
	POP AF
	LD (ZX_P_FLAG),A
; 		1500.4  LET e(i)=e(i)+1{00 00 01 00 00 }
	LD HL,(ZXBASIC_VAR_i)
	LD DE,5
	CALL runtimeMult16bit
	ADD HL,HL
	PUSH HL
; Array-Access
	LD HL,(ZXBASIC_VAR_i)
	LD DE,5
	CALL runtimeMult16bit
	ADD HL,HL
	LD DE, ZXBASIC_VAR_e_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,1
; +
	POP DE
	ADD HL,DE
	LD DE,HL
	POP HL
	LD BC,ZXBASIC_VAR_e_array
	ADD HL,BC
	LD (HL),DE
; 		1500.5  IF e(i)=17{00 00 11 00 00 } THEN  LET e(i)=1{00 00 01 00 00 }
; Array-Access
	LD HL,(ZXBASIC_VAR_i)
	LD DE,5
	CALL runtimeMult16bit
	ADD HL,HL
	LD DE, ZXBASIC_VAR_e_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,17
; =
	POP DE
	CALL runtimeCmpHLEqDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_4
; 		1500.6  LET e(i)=1{00 00 01 00 00 }
	LD HL,(ZXBASIC_VAR_i)
	LD DE,5
	CALL runtimeMult16bit
	ADD HL,HL
	PUSH HL
	LD DE,1
	POP HL
	LD BC,ZXBASIC_VAR_e_array
	ADD HL,BC
	LD (HL),DE
ZXB_LABEL_4:
ZXB_LABEL_3:
ZXBASIC_LINE_1510:
; 1510  NEXT i
; 		1510.1  NEXT i
	CALL runtimeCheckBreak
	LD HL,(ZXBASIC_VAR_i)
	INC HL
	LD (ZXBASIC_VAR_i),HL
	LD DE,(ZXBASIC_VAR_for_i)
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_2
ZXBASIC_LINE_1520:
; 1520  RETURN 
; 		1520.1  RETURN 
	CALL runtimeCheckBreak
	RET
ZXBASIC_LINE_1530:
; 1530  REM  SUB shoot(0=column)
ZXBASIC_LINE_1540:
; 1540  REM  --------------------
ZXBASIC_LINE_1550:
; 1550  LET i=1
; 		1550.1  LET i=1{00 00 01 00 00 }
	LD HL,1
	LD (ZXBASIC_VAR_i),HL
ZXBASIC_LINE_1560:
; 1560  IF b(i)=100 THEN  LET b(i)=PROCshoot0: LET c(i)=16: RETURN 
; 		1560.1  IF b(i)=100{00 00 64 00 00 } THEN  LET b(i)=PROCshoot0
; Array-Access
	LD HL,(ZXBASIC_VAR_i)
	LD DE,5
	CALL runtimeMult16bit
	ADD HL,HL
	LD DE, ZXBASIC_VAR_b_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,100
; =
	POP DE
	CALL runtimeCmpHLEqDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_5
; 		1560.2  LET b(i)=PROCshoot0
	LD HL,(ZXBASIC_VAR_i)
	LD DE,5
	CALL runtimeMult16bit
	ADD HL,HL
	PUSH HL
	LD DE,(ZXBASIC_VAR_PROCshoot0)
	POP HL
	LD BC,ZXBASIC_VAR_b_array
	ADD HL,BC
	LD (HL),DE
; 		1560.3  LET c(i)=16{00 00 10 00 00 }
	LD HL,(ZXBASIC_VAR_i)
	LD DE,5
	CALL runtimeMult16bit
	ADD HL,HL
	PUSH HL
	LD DE,16
	POP HL
	LD BC,ZXBASIC_VAR_c_array
	ADD HL,BC
	LD (HL),DE
; 		1560.4  RETURN 
	CALL runtimeCheckBreak
	RET
ZXB_LABEL_5:
ZXBASIC_LINE_1570:
; 1570  LET i=i+1
; 		1570.1  LET i=i+1{00 00 01 00 00 }
	LD HL,(ZXBASIC_VAR_i)
	INC HL
; +
	LD (ZXBASIC_VAR_i),HL
ZXBASIC_LINE_1580:
; 1580  IF i>5 THEN  GOTO 1600
; 		1580.1  IF i>5{00 00 05 00 00 } THEN  GOTO 1600{00 00 40 06 00 }
	LD DE,(ZXBASIC_VAR_i)
	LD HL,5
; >
	CALL runtimeCmpHlGtDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_6
; 		1580.2  GOTO 1600{00 00 40 06 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_1600
ZXB_LABEL_6:
ZXBASIC_LINE_1590:
; 1590  GOTO 1560
; 		1590.1  GOTO 1560{00 00 18 06 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_1560
ZXBASIC_LINE_1600:
; 1600  RETURN 
; 		1600.1  RETURN 
	CALL runtimeCheckBreak
	RET
ZXBASIC_LINE_1610:
; 1610  REM  SUB movebullets
ZXBASIC_LINE_1620:
; 1620  REM  ----------------
ZXBASIC_LINE_1630:
; 1630  LET i=1
; 		1630.1  LET i=1{00 00 01 00 00 }
	LD HL,1
	LD (ZXBASIC_VAR_i),HL
ZXBASIC_LINE_1640:
; 1640  IF  NOT (b(i) <> 100) THEN  GOTO 1700
; 		1640.1  IF  NOT (b(i) <> 100{00 00 64 00 00 }) THEN  GOTO 1700{00 00 a4 06 00 }
; NOT
; Array-Access
	LD HL,(ZXBASIC_VAR_i)
	LD DE,5
	CALL runtimeMult16bit
	ADD HL,HL
	LD DE, ZXBASIC_VAR_b_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,100
; <>
	POP DE
	CALL runtimeCmpHlNeDE
	CALL runtimeNotHL
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_7
; 		1640.2  GOTO 1700{00 00 a4 06 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_1700
ZXB_LABEL_7:
ZXBASIC_LINE_1650:
; 1650  PRINT  AT c(i),b(i);" "; AT c(i)-1,b(i);"\144";: LET x=b(i): LET y=c(i)
; 		1650.1  PRINT  AT c(i),b(i);" "; AT c(i)-1{00 00 01 00 00 },b(i);"\144";
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
; Array-Access
	LD HL,(ZXBASIC_VAR_i)
	LD DE,5
	CALL runtimeMult16bit
	ADD HL,HL
	LD DE, ZXBASIC_VAR_c_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
; Array-Access
	LD HL,(ZXBASIC_VAR_i)
	LD DE,5
	CALL runtimeMult16bit
	ADD HL,HL
	LD DE, ZXBASIC_VAR_b_array
	ADD HL,DE
	LD DE,(HL)
	LD HL,DE
	POP DE
	CALL runtimePrintAt
	LD HL,STRING_2	; 
	CALL runtimePrintString
; Array-Access
	LD HL,(ZXBASIC_VAR_i)
	LD DE,5
	CALL runtimeMult16bit
	ADD HL,HL
	LD DE, ZXBASIC_VAR_c_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,1
; -
	POP DE
	EX HL,DE
	SUB HL,DE
	PUSH HL
; Array-Access
	LD HL,(ZXBASIC_VAR_i)
	LD DE,5
	CALL runtimeMult16bit
	ADD HL,HL
	LD DE, ZXBASIC_VAR_b_array
	ADD HL,DE
	LD DE,(HL)
	LD HL,DE
	POP DE
	CALL runtimePrintAt
	LD HL,STRING_4	;\144
	CALL runtimePrintString
	POP AF
	LD (ZX_P_FLAG),A
; 		1650.2  LET x=b(i)
; Array-Access
	LD HL,(ZXBASIC_VAR_i)
	LD DE,5
	CALL runtimeMult16bit
	ADD HL,HL
	LD DE, ZXBASIC_VAR_b_array
	ADD HL,DE
	LD DE,(HL)
	LD HL,DE
	LD (ZXBASIC_VAR_x),HL
; 		1650.3  LET y=c(i)
; Array-Access
	LD HL,(ZXBASIC_VAR_i)
	LD DE,5
	CALL runtimeMult16bit
	ADD HL,HL
	LD DE, ZXBASIC_VAR_c_array
	ADD HL,DE
	LD DE,(HL)
	LD HL,DE
	LD (ZXBASIC_VAR_y),HL
ZXBASIC_LINE_1660:
; 1660  FOR j=1 TO 5
; 		1660.1  FOR j=1{00 00 01 00 00 } TO 5{00 00 05 00 00 }
	CALL runtimeCheckBreak
	LD HL,1
	LD (ZXBASIC_VAR_j),HL
	LD HL,5
	LD (ZXBASIC_VAR_for_j),HL
FOR_3:
ZXBASIC_LINE_1670:
; 1670  IF x=d(j) AND y=e(j) THEN  LET d(j)=100
; 		1670.1  IF x=d(j) AND y=e(j) THEN  LET d(j)=100{00 00 64 00 00 }
	LD HL,(ZXBASIC_VAR_x)
	PUSH HL
; Array-Access
	LD HL,(ZXBASIC_VAR_j)
	LD DE,5
	CALL runtimeMult16bit
	ADD HL,HL
	LD DE, ZXBASIC_VAR_d_array
	ADD HL,DE
	LD DE,(HL)
	LD HL,DE
; =
	POP DE
	CALL runtimeCmpHLEqDE
	PUSH HL
	LD HL,(ZXBASIC_VAR_y)
	PUSH HL
; Array-Access
	LD HL,(ZXBASIC_VAR_j)
	LD DE,5
	CALL runtimeMult16bit
	ADD HL,HL
	LD DE, ZXBASIC_VAR_e_array
	ADD HL,DE
	LD DE,(HL)
	LD HL,DE
; =
	POP DE
	CALL runtimeCmpHLEqDE
; AND
	POP DE
	call runtimeAndHLDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_8
; 		1670.2  LET d(j)=100{00 00 64 00 00 }
	LD HL,(ZXBASIC_VAR_j)
	LD DE,5
	CALL runtimeMult16bit
	ADD HL,HL
	PUSH HL
	LD DE,100
	POP HL
	LD BC,ZXBASIC_VAR_d_array
	ADD HL,BC
	LD (HL),DE
ZXB_LABEL_8:
ZXBASIC_LINE_1680:
; 1680  NEXT j
; 		1680.1  NEXT j
	CALL runtimeCheckBreak
	LD HL,(ZXBASIC_VAR_j)
	INC HL
	LD (ZXBASIC_VAR_j),HL
	LD DE,(ZXBASIC_VAR_for_j)
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_3
ZXBASIC_LINE_1690:
; 1690  LET c(i)=c(i)-1: IF c(i)=1 THEN  PRINT  AT c(i),b(i);" ";: LET b(i)=100
; 		1690.1  LET c(i)=c(i)-1{00 00 01 00 00 }
	LD HL,(ZXBASIC_VAR_i)
	LD DE,5
	CALL runtimeMult16bit
	ADD HL,HL
	PUSH HL
; Array-Access
	LD HL,(ZXBASIC_VAR_i)
	LD DE,5
	CALL runtimeMult16bit
	ADD HL,HL
	LD DE, ZXBASIC_VAR_c_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,1
; -
	POP DE
	EX HL,DE
	SUB HL,DE
	LD DE,HL
	POP HL
	LD BC,ZXBASIC_VAR_c_array
	ADD HL,BC
	LD (HL),DE
; 		1690.2  IF c(i)=1{00 00 01 00 00 } THEN  PRINT  AT c(i),b(i);" ";
; Array-Access
	LD HL,(ZXBASIC_VAR_i)
	LD DE,5
	CALL runtimeMult16bit
	ADD HL,HL
	LD DE, ZXBASIC_VAR_c_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,1
; =
	POP DE
	CALL runtimeCmpHLEqDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_9
; 		1690.3  PRINT  AT c(i),b(i);" ";
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
; Array-Access
	LD HL,(ZXBASIC_VAR_i)
	LD DE,5
	CALL runtimeMult16bit
	ADD HL,HL
	LD DE, ZXBASIC_VAR_c_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
; Array-Access
	LD HL,(ZXBASIC_VAR_i)
	LD DE,5
	CALL runtimeMult16bit
	ADD HL,HL
	LD DE, ZXBASIC_VAR_b_array
	ADD HL,DE
	LD DE,(HL)
	LD HL,DE
	POP DE
	CALL runtimePrintAt
	LD HL,STRING_2	; 
	CALL runtimePrintString
	POP AF
	LD (ZX_P_FLAG),A
; 		1690.4  LET b(i)=100{00 00 64 00 00 }
	LD HL,(ZXBASIC_VAR_i)
	LD DE,5
	CALL runtimeMult16bit
	ADD HL,HL
	PUSH HL
	LD DE,100
	POP HL
	LD BC,ZXBASIC_VAR_b_array
	ADD HL,BC
	LD (HL),DE
ZXB_LABEL_9:
ZXBASIC_LINE_1700:
; 1700  LET i=i+1
; 		1700.1  LET i=i+1{00 00 01 00 00 }
	LD HL,(ZXBASIC_VAR_i)
	INC HL
; +
	LD (ZXBASIC_VAR_i),HL
ZXBASIC_LINE_1710:
; 1710  IF i>5 THEN  GOTO 1730
; 		1710.1  IF i>5{00 00 05 00 00 } THEN  GOTO 1730{00 00 c2 06 00 }
	LD DE,(ZXBASIC_VAR_i)
	LD HL,5
; >
	CALL runtimeCmpHlGtDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_10
; 		1710.2  GOTO 1730{00 00 c2 06 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_1730
ZXB_LABEL_10:
ZXBASIC_LINE_1720:
; 1720  GOTO 1640
; 		1720.1  GOTO 1640{00 00 68 06 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_1640
ZXBASIC_LINE_1730:
; 1730  RETURN 
; 		1730.1  RETURN 
	CALL runtimeCheckBreak
	RET
ZXBASIC_LINE_1740:
; 1740  REM  graphics library
ZXBASIC_LINE_1750:
; 1750  REM  SUB readudg(0=count)
ZXBASIC_LINE_1760:
; 1760  REM  ---------------------
ZXBASIC_LINE_1770:
; 1770  LET a= USR "A"
; 		1770.1  LET a= USR "A"
; USR
	LD HL,STRING_5	;A
	CALL runtimeUsrUDG
	LD (ZXBASIC_VAR_a),HL
ZXBASIC_LINE_1780:
; 1780  LET last=a+PROCreadudg0*8
; 		1780.1  LET last=a+PROCreadudg0*8{00 00 08 00 00 }
	LD HL,(ZXBASIC_VAR_a)
	PUSH HL
	LD DE,(ZXBASIC_VAR_PROCreadudg0)
	LD HL,8
; *
	call runtimeMult16bit
; +
	POP DE
	ADD HL,DE
	LD (ZXBASIC_VAR_last),HL
ZXBASIC_LINE_1790:
; 1790  IF  NOT (a<last) THEN  GOTO 1820
; 		1790.1  IF  NOT (a<last) THEN  GOTO 1820{00 00 1c 07 00 }
; NOT
	LD DE,(ZXBASIC_VAR_a)
	LD HL,(ZXBASIC_VAR_last)
; <
	CALL runtimeCmpHLltDE
	CALL runtimeNotHL
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_11
; 		1790.2  GOTO 1820{00 00 1c 07 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_1820
ZXB_LABEL_11:
ZXBASIC_LINE_1800:
; 1800  READ b: POKE a,b: LET a=a+1
; 		1800.1  READ b
	LD HL,(DATAPTR)
	LD DE,(HL)
	INC HL
	INC HL
	LD (DATAPTR),HL
	LD (ZXBASIC_VAR_b),DE
; 		1800.2  POKE a,b
	LD HL,(ZXBASIC_VAR_a)
	LD DE,(ZXBASIC_VAR_b)
	LD (HL),E
; 		1800.3  LET a=a+1{00 00 01 00 00 }
	LD HL,(ZXBASIC_VAR_a)
	INC HL
; +
	LD (ZXBASIC_VAR_a),HL
ZXBASIC_LINE_1810:
; 1810  GOTO 1790
; 		1810.1  GOTO 1790{00 00 fe 06 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_1790
ZXBASIC_LINE_1820:
; 1820  RETURN 
; 		1820.1  RETURN 
	CALL runtimeCheckBreak
	RET
ZXBASIC_LINE_1830:
; 1830  REM  SUB initmovement
ZXBASIC_LINE_1840:
; 1840  REM  -----------------
ZXBASIC_LINE_1850:
; 1850  LET playerx=0: LET playery=0: LET playerxold=0: LET playeryold=0: LET playerfire=0: LET playerstep=2: LET playermoved=0: LET singleKey=0: LET playerleft=0: LET playerright=31: LET playerup=0: LET playerdown=21: LET playerKeyMoveLeft=111: LET playerKeyMoveRight=112: LET playerKeyMoveUp=113: LET playerKeyMoveDown=97: LET playerKeyFire=13: LET playerKeyFire2=32: LET playerInputSelect=2: LET playerWaitKeyRelease=0: LET playerWaitKeyPause=13: RETURN 
; 		1850.1  LET playerx=0{00 00 00 00 00 }
	LD HL,0
	LD (ZXBASIC_VAR_playerx),HL
; 		1850.2  LET playery=0{00 00 00 00 00 }
	LD (ZXBASIC_VAR_playery),HL
; 		1850.3  LET playerxold=0{00 00 00 00 00 }
	LD HL,0
	LD (ZXBASIC_VAR_playerxold),HL
; 		1850.4  LET playeryold=0{00 00 00 00 00 }
	LD (ZXBASIC_VAR_playeryold),HL
; 		1850.5  LET playerfire=0{00 00 00 00 00 }
	LD HL,0
	LD (ZXBASIC_VAR_playerfire),HL
; 		1850.6  LET playerstep=2{00 00 02 00 00 }
	LD HL,2
	LD (ZXBASIC_VAR_playerstep),HL
; 		1850.7  LET playermoved=0{00 00 00 00 00 }
	LD HL,0
	LD (ZXBASIC_VAR_playermoved),HL
; 		1850.8  LET singleKey=0{00 00 00 00 00 }
	LD (ZXBASIC_VAR_singleKey),HL
; 		1850.9  LET playerleft=0{00 00 00 00 00 }
	LD HL,0
	LD (ZXBASIC_VAR_playerleft),HL
; 		1850.10  LET playerright=31{00 00 1f 00 00 }
	LD HL,31
	LD (ZXBASIC_VAR_playerright),HL
; 		1850.11  LET playerup=0{00 00 00 00 00 }
	LD HL,0
	LD (ZXBASIC_VAR_playerup),HL
; 		1850.12  LET playerdown=21{00 00 15 00 00 }
	LD HL,21
	LD (ZXBASIC_VAR_playerdown),HL
; 		1850.13  LET playerKeyMoveLeft=111{00 00 6f 00 00 }
	LD HL,111
	LD (ZXBASIC_VAR_playerKeyMoveLeft),HL
; 		1850.14  LET playerKeyMoveRight=112{00 00 70 00 00 }
	LD HL,112
	LD (ZXBASIC_VAR_playerKeyMoveRight),HL
; 		1850.15  LET playerKeyMoveUp=113{00 00 71 00 00 }
	LD HL,113
	LD (ZXBASIC_VAR_playerKeyMoveUp),HL
; 		1850.16  LET playerKeyMoveDown=97{00 00 61 00 00 }
	LD HL,97
	LD (ZXBASIC_VAR_playerKeyMoveDown),HL
; 		1850.17  LET playerKeyFire=13{00 00 0d 00 00 }
	LD HL,13
	LD (ZXBASIC_VAR_playerKeyFire),HL
; 		1850.18  LET playerKeyFire2=32{00 00 20 00 00 }
	LD HL,32
	LD (ZXBASIC_VAR_playerKeyFire2),HL
; 		1850.19  LET playerInputSelect=2{00 00 02 00 00 }
	LD HL,2
	LD (ZXBASIC_VAR_playerInputSelect),HL
; 		1850.20  LET playerWaitKeyRelease=0{00 00 00 00 00 }
	LD HL,0
	LD (ZXBASIC_VAR_playerWaitKeyRelease),HL
; 		1850.21  LET playerWaitKeyPause=13{00 00 0d 00 00 }
	LD HL,13
	LD (ZXBASIC_VAR_playerWaitKeyPause),HL
; 		1850.22  RETURN 
	CALL runtimeCheckBreak
	RET
ZXBASIC_LINE_1860:
; 1860  REM  SUB playermovement
ZXBASIC_LINE_1870:
; 1870  REM  -------------------
ZXBASIC_LINE_1880:
; 1880  IF playerInputSelect=1 THEN  GO SUB 2050
; 		1880.1  IF playerInputSelect=1{00 00 01 00 00 } THEN  GO SUB 2050{00 00 02 08 00 }
	LD DE,(ZXBASIC_VAR_playerInputSelect)
	LD HL,1
; =
	CALL runtimeCmpHLEqDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_12
; 		1880.2  GO SUB 2050{00 00 02 08 00 }
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_2050
ZXB_LABEL_12:
ZXBASIC_LINE_1890:
; 1890  IF playerInputSelect=2 THEN  GO SUB 1940
; 		1890.1  IF playerInputSelect=2{00 00 02 00 00 } THEN  GO SUB 1940{00 00 94 07 00 }
	LD DE,(ZXBASIC_VAR_playerInputSelect)
	LD HL,2
; =
	CALL runtimeCmpHLEqDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_13
; 		1890.2  GO SUB 1940{00 00 94 07 00 }
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_1940
ZXB_LABEL_13:
ZXBASIC_LINE_1900:
; 1900  IF playerInputSelect=3 THEN  GO SUB 2000
; 		1900.1  IF playerInputSelect=3{00 00 03 00 00 } THEN  GO SUB 2000{00 00 d0 07 00 }
	LD DE,(ZXBASIC_VAR_playerInputSelect)
	LD HL,3
; =
	CALL runtimeCmpHLEqDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_14
; 		1900.2  GO SUB 2000{00 00 d0 07 00 }
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_2000
ZXB_LABEL_14:
ZXBASIC_LINE_1910:
; 1910  RETURN 
; 		1910.1  RETURN 
	CALL runtimeCheckBreak
	RET
ZXBASIC_LINE_1920:
; 1920  REM  SUB kempstonjoystick
ZXBASIC_LINE_1930:
; 1930  REM  ---------------------
ZXBASIC_LINE_1940:
; 1940  LET playerfire=0: LET playermoved=0: LET singleKey= CODE  INKEY$ : LET port1= IN 31: IF port1=0 THEN  RETURN 
; 		1940.1  LET playerfire=0{00 00 00 00 00 }
	LD HL,0
	LD (ZXBASIC_VAR_playerfire),HL
; 		1940.2  LET playermoved=0{00 00 00 00 00 }
	LD (ZXBASIC_VAR_playermoved),HL
; 		1940.3  LET singleKey= CODE  INKEY$ 
; CODE
; INKEY$
	CALL runtimeInkey
	CALL runtimeCode
	LD (ZXBASIC_VAR_singleKey),HL
	CALL ZXFreeTempCompact
; 		1940.4  LET port1= IN 31{00 00 1f 00 00 }
; IN
	LD BC,31
	IN A,(C)
	LD L,A
	LD H,0
	LD (ZXBASIC_VAR_port1),HL
; 		1940.5  IF port1=0{00 00 00 00 00 } THEN  RETURN 
	LD DE,(ZXBASIC_VAR_port1)
	LD HL,0
; =
	CALL runtimeCmpHLEqDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_15
; 		1940.6  RETURN 
	CALL runtimeCheckBreak
	RET
ZXB_LABEL_15:
ZXBASIC_LINE_1950:
; 1950  IF port1>15 THEN  LET playerfire=1: LET port1=port1-16
; 		1950.1  IF port1>15{00 00 0f 00 00 } THEN  LET playerfire=1{00 00 01 00 00 }
	LD DE,(ZXBASIC_VAR_port1)
	LD HL,15
; >
	CALL runtimeCmpHlGtDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_16
; 		1950.2  LET playerfire=1{00 00 01 00 00 }
	LD HL,1
	LD (ZXBASIC_VAR_playerfire),HL
; 		1950.3  LET port1=port1-16{00 00 10 00 00 }
	LD HL,(ZXBASIC_VAR_port1)
	LD DE,16
; -
	SUB HL,DE
	LD (ZXBASIC_VAR_port1),HL
ZXB_LABEL_16:
ZXBASIC_LINE_1960:
; 1960  LET playerxold=playerx: LET playeryold=playery: LET playerx=playerx-((port1=2 OR port1=10 OR port1=6) AND playerx>playerleft)+((port1=1 OR port1=5 OR port1=9) AND playerx<playerright): LET playery=playery-((port1=8 OR port1=9 OR port1=10) AND playery>playerup)+((port1=4 OR port1=5 OR port1=6) AND playery<playerdown): LET playermoved=1
; 		1960.1  LET playerxold=playerx
	LD HL,(ZXBASIC_VAR_playerx)
	LD (ZXBASIC_VAR_playerxold),HL
; 		1960.2  LET playeryold=playery
	LD HL,(ZXBASIC_VAR_playery)
	LD (ZXBASIC_VAR_playeryold),HL
; 		1960.3  LET playerx=playerx-((port1=2{00 00 02 00 00 } OR port1=10{00 00 0a 00 00 } OR port1=6{00 00 06 00 00 }) AND playerx>playerleft)+((port1=1{00 00 01 00 00 } OR port1=5{00 00 05 00 00 } OR port1=9{00 00 09 00 00 }) AND playerx<playerright)
	LD HL,(ZXBASIC_VAR_playerx)
	PUSH HL
; (
; (
	LD DE,(ZXBASIC_VAR_port1)
	LD HL,2
; =
	CALL runtimeCmpHLEqDE
	PUSH HL
	LD DE,(ZXBASIC_VAR_port1)
	LD HL,10
; =
	CALL runtimeCmpHLEqDE
; OR
	POP DE
	call runtimeOrHLDE
	PUSH HL
	LD DE,(ZXBASIC_VAR_port1)
	LD HL,6
; =
	CALL runtimeCmpHLEqDE
; OR
	POP DE
	call runtimeOrHLDE
	PUSH HL
; )
	LD DE,(ZXBASIC_VAR_playerx)
	LD HL,(ZXBASIC_VAR_playerleft)
; >
	CALL runtimeCmpHlGtDE
; AND
	POP DE
	call runtimeAndHLDE
; )
; -
	POP DE
	EX HL,DE
	SUB HL,DE
	PUSH HL
; (
; (
	LD DE,(ZXBASIC_VAR_port1)
	LD HL,1
; =
	CALL runtimeCmpHLEqDE
	PUSH HL
	LD DE,(ZXBASIC_VAR_port1)
	LD HL,5
; =
	CALL runtimeCmpHLEqDE
; OR
	POP DE
	call runtimeOrHLDE
	PUSH HL
	LD DE,(ZXBASIC_VAR_port1)
	LD HL,9
; =
	CALL runtimeCmpHLEqDE
; OR
	POP DE
	call runtimeOrHLDE
	PUSH HL
; )
	LD DE,(ZXBASIC_VAR_playerx)
	LD HL,(ZXBASIC_VAR_playerright)
; <
	CALL runtimeCmpHLltDE
; AND
	POP DE
	call runtimeAndHLDE
; )
; +
	POP DE
	ADD HL,DE
	LD (ZXBASIC_VAR_playerx),HL
; 		1960.4  LET playery=playery-((port1=8{00 00 08 00 00 } OR port1=9{00 00 09 00 00 } OR port1=10{00 00 0a 00 00 }) AND playery>playerup)+((port1=4{00 00 04 00 00 } OR port1=5{00 00 05 00 00 } OR port1=6{00 00 06 00 00 }) AND playery<playerdown)
	LD HL,(ZXBASIC_VAR_playery)
	PUSH HL
; (
; (
	LD DE,(ZXBASIC_VAR_port1)
	LD HL,8
; =
	CALL runtimeCmpHLEqDE
	PUSH HL
	LD DE,(ZXBASIC_VAR_port1)
	LD HL,9
; =
	CALL runtimeCmpHLEqDE
; OR
	POP DE
	call runtimeOrHLDE
	PUSH HL
	LD DE,(ZXBASIC_VAR_port1)
	LD HL,10
; =
	CALL runtimeCmpHLEqDE
; OR
	POP DE
	call runtimeOrHLDE
	PUSH HL
; )
	LD DE,(ZXBASIC_VAR_playery)
	LD HL,(ZXBASIC_VAR_playerup)
; >
	CALL runtimeCmpHlGtDE
; AND
	POP DE
	call runtimeAndHLDE
; )
; -
	POP DE
	EX HL,DE
	SUB HL,DE
	PUSH HL
; (
; (
	LD DE,(ZXBASIC_VAR_port1)
	LD HL,4
; =
	CALL runtimeCmpHLEqDE
	PUSH HL
	LD DE,(ZXBASIC_VAR_port1)
	LD HL,5
; =
	CALL runtimeCmpHLEqDE
; OR
	POP DE
	call runtimeOrHLDE
	PUSH HL
	LD DE,(ZXBASIC_VAR_port1)
	LD HL,6
; =
	CALL runtimeCmpHLEqDE
; OR
	POP DE
	call runtimeOrHLDE
	PUSH HL
; )
	LD DE,(ZXBASIC_VAR_playery)
	LD HL,(ZXBASIC_VAR_playerdown)
; <
	CALL runtimeCmpHLltDE
; AND
	POP DE
	call runtimeAndHLDE
; )
; +
	POP DE
	ADD HL,DE
	LD (ZXBASIC_VAR_playery),HL
; 		1960.5  LET playermoved=1{00 00 01 00 00 }
	LD HL,1
	LD (ZXBASIC_VAR_playermoved),HL
ZXBASIC_LINE_1970:
; 1970  RETURN 
; 		1970.1  RETURN 
	CALL runtimeCheckBreak
	RET
ZXBASIC_LINE_1980:
; 1980  REM  SUB sinclairjoystick
ZXBASIC_LINE_1990:
; 1990  REM  ---------------------
ZXBASIC_LINE_2000:
; 2000  LET playerfire=0: LET playermoved=0: LET singleKey= CODE  INKEY$ : LET playerxold=playerx: LET playeryold=playery: LET port1= IN 61438: IF port1=191 THEN  RETURN 
; 		2000.1  LET playerfire=0{00 00 00 00 00 }
	LD HL,0
	LD (ZXBASIC_VAR_playerfire),HL
; 		2000.2  LET playermoved=0{00 00 00 00 00 }
	LD (ZXBASIC_VAR_playermoved),HL
; 		2000.3  LET singleKey= CODE  INKEY$ 
; CODE
; INKEY$
	CALL runtimeInkey
	CALL runtimeCode
	LD (ZXBASIC_VAR_singleKey),HL
	CALL ZXFreeTempCompact
; 		2000.4  LET playerxold=playerx
	LD HL,(ZXBASIC_VAR_playerx)
	LD (ZXBASIC_VAR_playerxold),HL
; 		2000.5  LET playeryold=playery
	LD HL,(ZXBASIC_VAR_playery)
	LD (ZXBASIC_VAR_playeryold),HL
; 		2000.6  LET port1= IN 61438{00 00 fe ef 00 }
; IN
	LD BC,61438
	IN A,(C)
	LD L,A
	LD H,0
	LD (ZXBASIC_VAR_port1),HL
; 		2000.7  IF port1=191{00 00 bf 00 00 } THEN  RETURN 
	LD DE,(ZXBASIC_VAR_port1)
	LD HL,191
; =
	CALL runtimeCmpHLEqDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_17
; 		2000.8  RETURN 
	CALL runtimeCheckBreak
	RET
ZXB_LABEL_17:
ZXBASIC_LINE_2010:
; 2010  LET p1= INT (port1/2): LET playerfire=(port1-p1*2)=0: LET playerx=playerx-((p1=85 OR p1=86 OR p1=87) AND playerx>playerleft)+((p1=89 OR p1=90 OR p1=91) AND playerx<playerright): LET playery=playery-((p1=86 OR p1=90 OR p1=94) AND playery>playerup)+((p1=85 OR p1=93 OR p1=89) AND playery<playerdown): IF playerxold <> playerx OR playeryold <> playery THEN  LET playermoved=1
; 		2010.1  LET p1= INT (port1/2{00 00 02 00 00 })
; INT
	LD DE,(ZXBASIC_VAR_port1)
	LD HL,2
; /
	call runtimeDiv16bit
	LD (ZXBASIC_VAR_p1),HL
; 		2010.2  LET playerfire=(port1-p1*2{00 00 02 00 00 })=0{00 00 00 00 00 }
; (
	LD HL,(ZXBASIC_VAR_port1)
	PUSH HL
	LD DE,(ZXBASIC_VAR_p1)
	LD HL,2
; *
	call runtimeMult16bit
; -
	POP DE
	EX HL,DE
	SUB HL,DE
	LD DE,HL
; )
	LD HL,0
; =
	CALL runtimeCmpHLEqDE
	LD (ZXBASIC_VAR_playerfire),HL
; 		2010.3  LET playerx=playerx-((p1=85{00 00 55 00 00 } OR p1=86{00 00 56 00 00 } OR p1=87{00 00 57 00 00 }) AND playerx>playerleft)+((p1=89{00 00 59 00 00 } OR p1=90{00 00 5a 00 00 } OR p1=91{00 00 5b 00 00 }) AND playerx<playerright)
	LD HL,(ZXBASIC_VAR_playerx)
	PUSH HL
; (
; (
	LD DE,(ZXBASIC_VAR_p1)
	LD HL,85
; =
	CALL runtimeCmpHLEqDE
	PUSH HL
	LD DE,(ZXBASIC_VAR_p1)
	LD HL,86
; =
	CALL runtimeCmpHLEqDE
; OR
	POP DE
	call runtimeOrHLDE
	PUSH HL
	LD DE,(ZXBASIC_VAR_p1)
	LD HL,87
; =
	CALL runtimeCmpHLEqDE
; OR
	POP DE
	call runtimeOrHLDE
	PUSH HL
; )
	LD DE,(ZXBASIC_VAR_playerx)
	LD HL,(ZXBASIC_VAR_playerleft)
; >
	CALL runtimeCmpHlGtDE
; AND
	POP DE
	call runtimeAndHLDE
; )
; -
	POP DE
	EX HL,DE
	SUB HL,DE
	PUSH HL
; (
; (
	LD DE,(ZXBASIC_VAR_p1)
	LD HL,89
; =
	CALL runtimeCmpHLEqDE
	PUSH HL
	LD DE,(ZXBASIC_VAR_p1)
	LD HL,90
; =
	CALL runtimeCmpHLEqDE
; OR
	POP DE
	call runtimeOrHLDE
	PUSH HL
	LD DE,(ZXBASIC_VAR_p1)
	LD HL,91
; =
	CALL runtimeCmpHLEqDE
; OR
	POP DE
	call runtimeOrHLDE
	PUSH HL
; )
	LD DE,(ZXBASIC_VAR_playerx)
	LD HL,(ZXBASIC_VAR_playerright)
; <
	CALL runtimeCmpHLltDE
; AND
	POP DE
	call runtimeAndHLDE
; )
; +
	POP DE
	ADD HL,DE
	LD (ZXBASIC_VAR_playerx),HL
; 		2010.4  LET playery=playery-((p1=86{00 00 56 00 00 } OR p1=90{00 00 5a 00 00 } OR p1=94{00 00 5e 00 00 }) AND playery>playerup)+((p1=85{00 00 55 00 00 } OR p1=93{00 00 5d 00 00 } OR p1=89{00 00 59 00 00 }) AND playery<playerdown)
	LD HL,(ZXBASIC_VAR_playery)
	PUSH HL
; (
; (
	LD DE,(ZXBASIC_VAR_p1)
	LD HL,86
; =
	CALL runtimeCmpHLEqDE
	PUSH HL
	LD DE,(ZXBASIC_VAR_p1)
	LD HL,90
; =
	CALL runtimeCmpHLEqDE
; OR
	POP DE
	call runtimeOrHLDE
	PUSH HL
	LD DE,(ZXBASIC_VAR_p1)
	LD HL,94
; =
	CALL runtimeCmpHLEqDE
; OR
	POP DE
	call runtimeOrHLDE
	PUSH HL
; )
	LD DE,(ZXBASIC_VAR_playery)
	LD HL,(ZXBASIC_VAR_playerup)
; >
	CALL runtimeCmpHlGtDE
; AND
	POP DE
	call runtimeAndHLDE
; )
; -
	POP DE
	EX HL,DE
	SUB HL,DE
	PUSH HL
; (
; (
	LD DE,(ZXBASIC_VAR_p1)
	LD HL,85
; =
	CALL runtimeCmpHLEqDE
	PUSH HL
	LD DE,(ZXBASIC_VAR_p1)
	LD HL,93
; =
	CALL runtimeCmpHLEqDE
; OR
	POP DE
	call runtimeOrHLDE
	PUSH HL
	LD DE,(ZXBASIC_VAR_p1)
	LD HL,89
; =
	CALL runtimeCmpHLEqDE
; OR
	POP DE
	call runtimeOrHLDE
	PUSH HL
; )
	LD DE,(ZXBASIC_VAR_playery)
	LD HL,(ZXBASIC_VAR_playerdown)
; <
	CALL runtimeCmpHLltDE
; AND
	POP DE
	call runtimeAndHLDE
; )
; +
	POP DE
	ADD HL,DE
	LD (ZXBASIC_VAR_playery),HL
; 		2010.5  IF playerxold <> playerx OR playeryold <> playery THEN  LET playermoved=1{00 00 01 00 00 }
	LD DE,(ZXBASIC_VAR_playerxold)
	LD HL,(ZXBASIC_VAR_playerx)
; <>
	CALL runtimeCmpHlNeDE
	PUSH HL
	LD DE,(ZXBASIC_VAR_playeryold)
	LD HL,(ZXBASIC_VAR_playery)
; <>
	CALL runtimeCmpHlNeDE
; OR
	POP DE
	call runtimeOrHLDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_18
; 		2010.6  LET playermoved=1{00 00 01 00 00 }
	LD HL,1
	LD (ZXBASIC_VAR_playermoved),HL
ZXB_LABEL_18:
ZXBASIC_LINE_2020:
; 2020  RETURN 
; 		2020.1  RETURN 
	CALL runtimeCheckBreak
	RET
ZXBASIC_LINE_2030:
; 2030  REM  SUB keyboard
ZXBASIC_LINE_2040:
; 2040  REM  -------------
ZXBASIC_LINE_2050:
; 2050  LET singleKey= CODE  INKEY$ : IF singleKey=0 THEN  LET playermoved=0: LET playerfire=0: RETURN 
; 		2050.1  LET singleKey= CODE  INKEY$ 
; CODE
; INKEY$
	CALL runtimeInkey
	CALL runtimeCode
	LD (ZXBASIC_VAR_singleKey),HL
	CALL ZXFreeTempCompact
; 		2050.2  IF singleKey=0{00 00 00 00 00 } THEN  LET playermoved=0{00 00 00 00 00 }
	LD DE,(ZXBASIC_VAR_singleKey)
	LD HL,0
; =
	CALL runtimeCmpHLEqDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_19
; 		2050.3  LET playermoved=0{00 00 00 00 00 }
	LD HL,0
	LD (ZXBASIC_VAR_playermoved),HL
; 		2050.4  LET playerfire=0{00 00 00 00 00 }
	LD (ZXBASIC_VAR_playerfire),HL
; 		2050.5  RETURN 
	CALL runtimeCheckBreak
	RET
ZXB_LABEL_19:
ZXBASIC_LINE_2060:
; 2060  LET playerxold=playerx: LET playeryold=playery: LET playermoved=1: LET a=singleKey
; 		2060.1  LET playerxold=playerx
	LD HL,(ZXBASIC_VAR_playerx)
	LD (ZXBASIC_VAR_playerxold),HL
; 		2060.2  LET playeryold=playery
	LD HL,(ZXBASIC_VAR_playery)
	LD (ZXBASIC_VAR_playeryold),HL
; 		2060.3  LET playermoved=1{00 00 01 00 00 }
	LD HL,1
	LD (ZXBASIC_VAR_playermoved),HL
; 		2060.4  LET a=singleKey
	LD HL,(ZXBASIC_VAR_singleKey)
	LD (ZXBASIC_VAR_a),HL
ZXBASIC_LINE_2070:
; 2070  LET playerfire=a=13: LET playerx=playerx+((a=playerKeyMoveRight OR a=9) AND playerx<playerright)-((a=playerKeyMoveLeft OR a=8) AND playerx>playerleft): LET playery=playery+((a=playerKeyMoveDown OR a=10) AND playery<playerdown)-((a=playerKeyMoveUp OR a=11) AND playery>playerup)
; 		2070.1  LET playerfire=a=13{00 00 0d 00 00 }
	LD DE,(ZXBASIC_VAR_a)
	LD HL,13
; =
	CALL runtimeCmpHLEqDE
	LD (ZXBASIC_VAR_playerfire),HL
; 		2070.2  LET playerx=playerx+((a=playerKeyMoveRight OR a=9{00 00 09 00 00 }) AND playerx<playerright)-((a=playerKeyMoveLeft OR a=8{00 00 08 00 00 }) AND playerx>playerleft)
	LD HL,(ZXBASIC_VAR_playerx)
	PUSH HL
; (
; (
	LD DE,(ZXBASIC_VAR_a)
	LD HL,(ZXBASIC_VAR_playerKeyMoveRight)
; =
	CALL runtimeCmpHLEqDE
	PUSH HL
	LD DE,(ZXBASIC_VAR_a)
	LD HL,9
; =
	CALL runtimeCmpHLEqDE
; OR
	POP DE
	call runtimeOrHLDE
	PUSH HL
; )
	LD DE,(ZXBASIC_VAR_playerx)
	LD HL,(ZXBASIC_VAR_playerright)
; <
	CALL runtimeCmpHLltDE
; AND
	POP DE
	call runtimeAndHLDE
; )
; +
	POP DE
	ADD HL,DE
	PUSH HL
; (
; (
	LD DE,(ZXBASIC_VAR_a)
	LD HL,(ZXBASIC_VAR_playerKeyMoveLeft)
; =
	CALL runtimeCmpHLEqDE
	PUSH HL
	LD DE,(ZXBASIC_VAR_a)
	LD HL,8
; =
	CALL runtimeCmpHLEqDE
; OR
	POP DE
	call runtimeOrHLDE
	PUSH HL
; )
	LD DE,(ZXBASIC_VAR_playerx)
	LD HL,(ZXBASIC_VAR_playerleft)
; >
	CALL runtimeCmpHlGtDE
; AND
	POP DE
	call runtimeAndHLDE
; )
; -
	POP DE
	EX HL,DE
	SUB HL,DE
	LD (ZXBASIC_VAR_playerx),HL
; 		2070.3  LET playery=playery+((a=playerKeyMoveDown OR a=10{00 00 0a 00 00 }) AND playery<playerdown)-((a=playerKeyMoveUp OR a=11{00 00 0b 00 00 }) AND playery>playerup)
	LD HL,(ZXBASIC_VAR_playery)
	PUSH HL
; (
; (
	LD DE,(ZXBASIC_VAR_a)
	LD HL,(ZXBASIC_VAR_playerKeyMoveDown)
; =
	CALL runtimeCmpHLEqDE
	PUSH HL
	LD DE,(ZXBASIC_VAR_a)
	LD HL,10
; =
	CALL runtimeCmpHLEqDE
; OR
	POP DE
	call runtimeOrHLDE
	PUSH HL
; )
	LD DE,(ZXBASIC_VAR_playery)
	LD HL,(ZXBASIC_VAR_playerdown)
; <
	CALL runtimeCmpHLltDE
; AND
	POP DE
	call runtimeAndHLDE
; )
; +
	POP DE
	ADD HL,DE
	PUSH HL
; (
; (
	LD DE,(ZXBASIC_VAR_a)
	LD HL,(ZXBASIC_VAR_playerKeyMoveUp)
; =
	CALL runtimeCmpHLEqDE
	PUSH HL
	LD DE,(ZXBASIC_VAR_a)
	LD HL,11
; =
	CALL runtimeCmpHLEqDE
; OR
	POP DE
	call runtimeOrHLDE
	PUSH HL
; )
	LD DE,(ZXBASIC_VAR_playery)
	LD HL,(ZXBASIC_VAR_playerup)
; >
	CALL runtimeCmpHlGtDE
; AND
	POP DE
	call runtimeAndHLDE
; )
; -
	POP DE
	EX HL,DE
	SUB HL,DE
	LD (ZXBASIC_VAR_playery),HL
ZXBASIC_LINE_2080:
; 2080  IF playerxold <> playerx OR playeryold <> playery THEN  LET playermoved=1
; 		2080.1  IF playerxold <> playerx OR playeryold <> playery THEN  LET playermoved=1{00 00 01 00 00 }
	LD DE,(ZXBASIC_VAR_playerxold)
	LD HL,(ZXBASIC_VAR_playerx)
; <>
	CALL runtimeCmpHlNeDE
	PUSH HL
	LD DE,(ZXBASIC_VAR_playeryold)
	LD HL,(ZXBASIC_VAR_playery)
; <>
	CALL runtimeCmpHlNeDE
; OR
	POP DE
	call runtimeOrHLDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_20
; 		2080.2  LET playermoved=1{00 00 01 00 00 }
	LD HL,1
	LD (ZXBASIC_VAR_playermoved),HL
ZXB_LABEL_20:
ZXBASIC_LINE_2090:
; 2090  IF playerWaitKeyRelease=1 THEN  GO SUB 2140
; 		2090.1  IF playerWaitKeyRelease=1{00 00 01 00 00 } THEN  GO SUB 2140{00 00 5c 08 00 }
	LD DE,(ZXBASIC_VAR_playerWaitKeyRelease)
	LD HL,1
; =
	CALL runtimeCmpHLEqDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_21
; 		2090.2  GO SUB 2140{00 00 5c 08 00 }
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_2140
ZXB_LABEL_21:
ZXBASIC_LINE_2100:
; 2100  IF playerWaitKeyPause>0 THEN  PAUSE playerWaitKeyPause
; 		2100.1  IF playerWaitKeyPause>0{00 00 00 00 00 } THEN  PAUSE playerWaitKeyPause
	LD DE,(ZXBASIC_VAR_playerWaitKeyPause)
	LD HL,0
; >
	CALL runtimeCmpHlGtDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_22
; 		2100.2  PAUSE playerWaitKeyPause
	LD HL,(ZXBASIC_VAR_playerWaitKeyPause)
	CALL runtimePause
ZXB_LABEL_22:
ZXBASIC_LINE_2110:
; 2110  RETURN 
; 		2110.1  RETURN 
	CALL runtimeCheckBreak
	RET
ZXBASIC_LINE_2120:
; 2120  REM  SUB waitkeyrelease
ZXBASIC_LINE_2130:
; 2130  REM  -------------------
ZXBASIC_LINE_2140:
; 2140  LET PROCwaitkeyreleasea= CODE  INKEY$ 
; 		2140.1  LET PROCwaitkeyreleasea= CODE  INKEY$ 
; CODE
; INKEY$
	CALL runtimeInkey
	CALL runtimeCode
	LD (ZXBASIC_VAR_PROCwaitkeyreleasea),HL
	CALL ZXFreeTempCompact
ZXBASIC_LINE_2150:
; 2150  IF PROCwaitkeyreleasea=0 THEN  GOTO 2170
; 		2150.1  IF PROCwaitkeyreleasea=0{00 00 00 00 00 } THEN  GOTO 2170{00 00 7a 08 00 }
	LD DE,(ZXBASIC_VAR_PROCwaitkeyreleasea)
	LD HL,0
; =
	CALL runtimeCmpHLEqDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_23
; 		2150.2  GOTO 2170{00 00 7a 08 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_2170
ZXB_LABEL_23:
ZXBASIC_LINE_2160:
; 2160  GOTO 2140
; 		2160.1  GOTO 2140{00 00 5c 08 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_2140
ZXBASIC_LINE_2170:
; 2170  RETURN 
; 		2170.1  RETURN 
	CALL runtimeCheckBreak
	RET
ZXBASIC_LINE_2180:
; 2180  DATA 16,56,56,56,56,56,56,0
; 		2180.1  DATA 16{00 00 10 00 00 },56{00 00 38 00 00 },56{00 00 38 00 00 },56{00 00 38 00 00 },56{00 00 38 00 00 },56{00 00 38 00 00 },56{00 00 38 00 00 },0{00 00 00 00 00 }
ZXBASIC_LINE_2190:
; 2190  DATA 0,24,24,60,60,126,255,219
; 		2190.1  DATA 0{00 00 00 00 00 },24{00 00 18 00 00 },24{00 00 18 00 00 },60{00 00 3c 00 00 },60{00 00 3c 00 00 },126{00 00 7e 00 00 },255{00 00 ff 00 00 },219{00 00 db 00 00 }
ZXBASIC_LINE_2200:
; 2200  DATA 0,0,153,153,153,126,60,24
; 		2200.1  DATA 0{00 00 00 00 00 },0{00 00 00 00 00 },153{00 00 99 00 00 },153{00 00 99 00 00 },153{00 00 99 00 00 },126{00 00 7e 00 00 },60{00 00 3c 00 00 },24{00 00 18 00 00 }
ZXBASIC_LINE_2210:
; 2210  DATA 0,24,24,24,90,60,24,0
; 		2210.1  DATA 0{00 00 00 00 00 },24{00 00 18 00 00 },24{00 00 18 00 00 },24{00 00 18 00 00 },90{00 00 5a 00 00 },60{00 00 3c 00 00 },24{00 00 18 00 00 },0{00 00 00 00 00 }
ZXBASIC_LINE_2220:
; 2220  DATA 24,60,102,219,255,126,0,0
; 		2220.1  DATA 24{00 00 18 00 00 },60{00 00 3c 00 00 },102{00 00 66 00 00 },219{00 00 db 00 00 },255{00 00 ff 00 00 },126{00 00 7e 00 00 },0{00 00 00 00 00 },0{00 00 00 00 00 }
ZXBASIC_LINE_2230:
; 2230  DATA 0,0,0,0,255,255,255,255
; 		2230.1  DATA 0{00 00 00 00 00 },0{00 00 00 00 00 },0{00 00 00 00 00 },0{00 00 00 00 00 },255{00 00 ff 00 00 },255{00 00 ff 00 00 },255{00 00 ff 00 00 },255{00 00 ff 00 00 }
ZXBASIC_LINE_2240:
; 2240  DATA 0,0,0,0,239,187,247,223
; 		2240.1  DATA 0{00 00 00 00 00 },0{00 00 00 00 00 },0{00 00 00 00 00 },0{00 00 00 00 00 },239{00 00 ef 00 00 },187{00 00 bb 00 00 },247{00 00 f7 00 00 },223{00 00 df 00 00 }
ZXBASIC_LINE_2250:
; 2250  DATA 0,0,0,0,223,205,185,255
; 		2250.1  DATA 0{00 00 00 00 00 },0{00 00 00 00 00 },0{00 00 00 00 00 },0{00 00 00 00 00 },223{00 00 df 00 00 },205{00 00 cd 00 00 },185{00 00 b9 00 00 },255{00 00 ff 00 00 }
ZXBASIC_LINE_2260:
; 2260  DATA 0,0,0,0,171,150,197,125
; 		2260.1  DATA 0{00 00 00 00 00 },0{00 00 00 00 00 },0{00 00 00 00 00 },0{00 00 00 00 00 },171{00 00 ab 00 00 },150{00 00 96 00 00 },197{00 00 c5 00 00 },125{00 00 7d 00 00 }
ZXBASIC_LINE_2270:
; 2270  DATA 0,0,0,0,0,66,40,129
; 		2270.1  DATA 0{00 00 00 00 00 },0{00 00 00 00 00 },0{00 00 00 00 00 },0{00 00 00 00 00 },0{00 00 00 00 00 },66{00 00 42 00 00 },40{00 00 28 00 00 },129{00 00 81 00 00 }
ZXBASIC_LINE_2280:
; 2280  DATA 0,0,0,0,0,0,0,0
; 		2280.1  DATA 0{00 00 00 00 00 },0{00 00 00 00 00 },0{00 00 00 00 00 },0{00 00 00 00 00 },0{00 00 00 00 00 },0{00 00 00 00 00 },0{00 00 00 00 00 },0{00 00 00 00 00 }
ZXBASIC_LINE_2290:
; 2290  DATA 0,0,0,0,0,0,0,0
; 		2290.1  DATA 0{00 00 00 00 00 },0{00 00 00 00 00 },0{00 00 00 00 00 },0{00 00 00 00 00 },0{00 00 00 00 00 },0{00 00 00 00 00 },0{00 00 00 00 00 },0{00 00 00 00 00 }
ZXBASIC_LINE_2300:
; 2300  DATA 0,0,0,0,0,0,0,0
; 		2300.1  DATA 0{00 00 00 00 00 },0{00 00 00 00 00 },0{00 00 00 00 00 },0{00 00 00 00 00 },0{00 00 00 00 00 },0{00 00 00 00 00 },0{00 00 00 00 00 },0{00 00 00 00 00 }
ZXBASIC_LINE_2310:
; 2310  DATA 0,0,0,0,0,0,0,0
; 		2310.1  DATA 0{00 00 00 00 00 },0{00 00 00 00 00 },0{00 00 00 00 00 },0{00 00 00 00 00 },0{00 00 00 00 00 },0{00 00 00 00 00 },0{00 00 00 00 00 },0{00 00 00 00 00 }
ZXBASIC_LINE_2320:
; 2320  STOP 
ZXBASIC_VAR_PROCreadudg0:	dw 0
ZXBASIC_VAR_PROCshoot0:	dw 0
ZXBASIC_VAR_PROCwaitkeyreleasea:	dw 0
ZXBASIC_VAR_a:	dw 0
ZXBASIC_VAR_b:	dw 0
ZXBASIC_VAR_b_array:	defs 12
ZXBASIC_VAR_c_array:	defs 12
ZXBASIC_VAR_d_array:	defs 12
ZXBASIC_VAR_e_array:	defs 12
ZXBASIC_VAR_f_array:	defs 12
ZXBASIC_VAR_for_i:	dw 0
ZXBASIC_VAR_for_j:	dw 0
ZXBASIC_VAR_i:	dw 0
ZXBASIC_VAR_j:	dw 0
ZXBASIC_VAR_last:	dw 0
ZXBASIC_VAR_p1:	dw 0
ZXBASIC_VAR_playerInputSelect:	dw 0
ZXBASIC_VAR_playerKeyFire:	dw 0
ZXBASIC_VAR_playerKeyFire2:	dw 0
ZXBASIC_VAR_playerKeyMoveDown:	dw 0
ZXBASIC_VAR_playerKeyMoveLeft:	dw 0
ZXBASIC_VAR_playerKeyMoveRight:	dw 0
ZXBASIC_VAR_playerKeyMoveUp:	dw 0
ZXBASIC_VAR_playerWaitKeyPause:	dw 0
ZXBASIC_VAR_playerWaitKeyRelease:	dw 0
ZXBASIC_VAR_playerdown:	dw 0
ZXBASIC_VAR_playerfire:	dw 0
ZXBASIC_VAR_playerleft:	dw 0
ZXBASIC_VAR_playermoved:	dw 0
ZXBASIC_VAR_playerright:	dw 0
ZXBASIC_VAR_playerstep:	dw 0
ZXBASIC_VAR_playerup:	dw 0
ZXBASIC_VAR_playerx:	dw 0
ZXBASIC_VAR_playerxold:	dw 0
ZXBASIC_VAR_playery:	dw 0
ZXBASIC_VAR_playeryold:	dw 0
ZXBASIC_VAR_port1:	dw 0
ZXBASIC_VAR_singleKey:	dw 0
ZXBASIC_VAR_x:	dw 0
ZXBASIC_VAR_y:	dw 0
STRING_0:	dw 9
	db	144, 145, 146, 147, 148, 149, 150, 151, 152
STRING_1:	dw 1
	db	145
STRING_2:	dw 1
	db	" "
STRING_3:	dw 1
	db	146
STRING_4:	dw 1
	db	144
STRING_5:	dw 1
	db	"A"
ZXDATA:
	dw 2180, DATA_2180
	dw 2190, DATA_2190
	dw 2200, DATA_2200
	dw 2210, DATA_2210
	dw 2220, DATA_2220
	dw 2230, DATA_2230
	dw 2240, DATA_2240
	dw 2250, DATA_2250
	dw 2260, DATA_2260
	dw 2270, DATA_2270
	dw 2280, DATA_2280
	dw 2290, DATA_2290
	dw 2300, DATA_2300
	dw 2310, DATA_2310
	dw 0, 0
DATAPTR:	DW 0
DATA_2180:
	dw 16
	dw 56
	dw 56
	dw 56
	dw 56
	dw 56
	dw 56
	dw 0
DATA_2190:
	dw 0
	dw 24
	dw 24
	dw 60
	dw 60
	dw 126
	dw 255
	dw 219
DATA_2200:
	dw 0
	dw 0
	dw 153
	dw 153
	dw 153
	dw 126
	dw 60
	dw 24
DATA_2210:
	dw 0
	dw 24
	dw 24
	dw 24
	dw 90
	dw 60
	dw 24
	dw 0
DATA_2220:
	dw 24
	dw 60
	dw 102
	dw 219
	dw 255
	dw 126
	dw 0
	dw 0
DATA_2230:
	dw 0
	dw 0
	dw 0
	dw 0
	dw 255
	dw 255
	dw 255
	dw 255
DATA_2240:
	dw 0
	dw 0
	dw 0
	dw 0
	dw 239
	dw 187
	dw 247
	dw 223
DATA_2250:
	dw 0
	dw 0
	dw 0
	dw 0
	dw 223
	dw 205
	dw 185
	dw 255
DATA_2260:
	dw 0
	dw 0
	dw 0
	dw 0
	dw 171
	dw 150
	dw 197
	dw 125
DATA_2270:
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 66
	dw 40
	dw 129
DATA_2280:
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
DATA_2290:
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
DATA_2300:
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
DATA_2310:
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0

ZX_VARIABLES:
	db 0

    DISPLAY "Compiled Basic = ", /D, $-CBASIC_START,  " bytes"
