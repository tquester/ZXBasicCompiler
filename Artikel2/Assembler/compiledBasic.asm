
CBASIC_START
compiledBasic:
	call ZXHeapClear
	LD (runtimeSaveSP),SP
	LD HL,DATA_900
	LD (DATAPTR),HL
; 760.1  DIM a$(32)
	LD HL,ZXBASIC_VAR_a_string
	LD BC,33
	CALL runtimeClearStringArray
; 760.1  DIM d$(32)
	LD HL,ZXBASIC_VAR_d_string
	LD BC,33
	CALL runtimeClearStringArray
; 760.1  DIM e$(32)
	LD HL,ZXBASIC_VAR_e_string
	LD BC,33
	CALL runtimeClearStringArray
; 900.1 
; 920.1 
; 950.1 
; 970.1 
; 990.1 
; 1010.1 
ZXBASIC_LINE_10:
; 10  REM *** ZAP ***
	LD HL,10
	LD (23621),HL
	LD A,1
	LD (23623),a
	LD HL,10
	LD A,1
	CALL runtimeDebug
ZXBASIC_LINE_20:
; 20  GOSUB 560: REM UDG
	LD HL,20
	LD (23621),HL
; 		20.1  GOSUB 560{00 00 30 02 00 }
	LD A,1
	LD (23623),a
	LD HL,20
	LD A,1
	CALL runtimeDebug
	CALL runtimeCheckBreakDebug
	CALL ZXBASIC_LINE_560
	LD A,2
	LD (23623),a
	LD HL,20
	LD A,2
	CALL runtimeDebug
ZXBASIC_LINE_30:
; 30  PAPER 0: BORDER 0: CLS 
	LD HL,30
	LD (23621),HL
; 		30.1  PAPER 0{00 00 00 00 00 }
	LD A,1
	LD (23623),a
	LD HL,30
	LD A,1
	CALL runtimeDebug
	LD HL,0
	CALL runtimePaper
; 		30.2  BORDER 0{00 00 00 00 00 }
	LD A,2
	LD (23623),a
	LD HL,30
	LD A,2
	CALL runtimeDebug
	LD HL,0
	LD A,L
	call $2297
; 		30.3  CLS 
	LD A,3
	LD (23623),a
	LD HL,30
	LD A,3
	CALL runtimeDebug
	CALL runtimeCls
ZXBASIC_LINE_40:
; 40  LET hs=0
	LD HL,40
	LD (23621),HL
; 		40.1  LET hs=0{00 00 00 00 00 }
	LD A,1
	LD (23623),a
	LD HL,40
	LD A,1
	CALL runtimeDebug
	LD HL,0
	LD (ZXBASIC_VAR_hs),HL
ZXBASIC_LINE_50:
; 50  GOSUB 700
	LD HL,50
	LD (23621),HL
; 		50.1  GOSUB 700{00 00 bc 02 00 }
	LD A,1
	LD (23623),a
	LD HL,50
	LD A,1
	CALL runtimeDebug
	CALL runtimeCheckBreakDebug
	CALL ZXBASIC_LINE_700
ZXBASIC_LINE_170:
; 170  REM *** GAME LOOP ***
	LD HL,170
	LD (23621),HL
	LD A,1
	LD (23623),a
	LD HL,170
	LD A,1
	CALL runtimeDebug
ZXBASIC_LINE_180:
; 180  LET k= IN 57342: LET j= IN 31
	LD HL,180
	LD (23621),HL
; 		180.1  LET k= IN 57342{00 00 fe df 00 }
	LD A,1
	LD (23623),a
	LD HL,180
	LD A,1
	CALL runtimeDebug
; IN
	LD HL,57342
	LD BC,HL
	IN A,(C)
	LD L,A
	LD H,0
	LD (ZXBASIC_VAR_k),HL
; 		180.2  LET j= IN 31{00 00 1f 00 00 }
	LD A,2
	LD (23623),a
	LD HL,180
	LD A,2
	CALL runtimeDebug
; IN
	LD HL,31
	LD BC,HL
	IN A,(C)
	LD L,A
	LD H,0
	LD (ZXBASIC_VAR_j),HL
ZXBASIC_LINE_185:
; 185  IF j>16 THEN  LET j=j-16: GOSUB f
	LD HL,185
	LD (23621),HL
; 		185.1  IF j>16{00 00 10 00 00 } THEN  LET j=j-16{00 00 10 00 00 }
	LD A,1
	LD (23623),a
	LD HL,185
	LD A,1
	CALL runtimeDebug
	LD DE,(ZXBASIC_VAR_j)
	LD HL,16
; >
	CALL runtimeCmpHlGtDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_1
; 		185.2  LET j=j-16{00 00 10 00 00 }
	LD A,2
	LD (23623),a
	LD HL,185
	LD A,2
	CALL runtimeDebug
	LD HL,(ZXBASIC_VAR_j)
	LD DE,16
; -
	SUB HL,DE
	LD (ZXBASIC_VAR_j),HL
; 		185.3  GOSUB f
	LD A,3
	LD (23623),a
	LD HL,185
	LD A,3
	CALL runtimeDebug
	CALL runtimeCheckBreakDebug
	LD DE,(ZXBASIC_VAR_f)
	LD HL,ZXLINES
	CALL runtimeFindLine
	CALL runtimeVarCall
ZXB_LABEL_1:
ZXBASIC_LINE_190:
; 190  INK 0
	LD HL,190
	LD (23621),HL
; 		190.1  INK 0{00 00 00 00 00 }
	LD A,1
	LD (23623),a
	LD HL,190
	LD A,1
	CALL runtimeDebug
	LD HL,0
	CALL runtimeInk
ZXBASIC_LINE_200:
; 200   LET a$=a$(32)+a$( TO 31)
	LD HL,200
	LD (23621),HL
; 		200.1  LET a$=a$(32{00 00 20 00 00 })+a$( TO 31{00 00 1f 00 00 })
	LD A,1
	LD (23623),a
	LD HL,200
	LD A,1
	CALL runtimeDebug
	LD HL,ZXBASIC_VAR_a_string
	PUSH HL
	LD HL,ZXBASIC_VAR_a_string
	PUSH HL
	LD HL,32
	PUSH HL
	LD BC,HL
	POP DE
	POP HL
	CALL runtimePushFixedSubString
	PUSH HL
	LD HL,ZXBASIC_VAR_a_string
	PUSH HL
	LD HL,1
	PUSH HL
	LD HL,31
	LD BC,HL
	POP DE
	POP HL
	CALL runtimePushFixedSubString
; +
	POP DE
	CALL runtimeStringAdd
	POP DE
	LD BC,32
	CALL runtimeStoreStringVarFix
ZXBASIC_LINE_202:
; 202  REM PRINT AT 2,0; INK 3;a$;
	LD HL,202
	LD (23621),HL
	LD A,1
	LD (23623),a
	LD HL,202
	LD A,1
	CALL runtimeDebug
ZXBASIC_LINE_203:
; 203  
	LD HL,203
	LD (23621),HL
ZXBASIC_LINE_205:
; 205   IF l >= 4 THEN  LET e$=e$(32)+e$( TO 31)
	LD HL,205
	LD (23621),HL
; 		205.1  IF l >= 4{00 00 04 00 00 } THEN  LET e$=e$(32{00 00 20 00 00 })+e$( TO 31{00 00 1f 00 00 })
	LD A,1
	LD (23623),a
	LD HL,205
	LD A,1
	CALL runtimeDebug
	LD DE,(ZXBASIC_VAR_l)
	LD HL,4
; >=
	CALL runtimeCmpHLGeDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_2
; 		205.2  LET e$=e$(32{00 00 20 00 00 })+e$( TO 31{00 00 1f 00 00 })
	LD A,2
	LD (23623),a
	LD HL,205
	LD A,2
	CALL runtimeDebug
	LD HL,ZXBASIC_VAR_e_string
	PUSH HL
	LD HL,ZXBASIC_VAR_e_string
	PUSH HL
	LD HL,32
	PUSH HL
	LD BC,HL
	POP DE
	POP HL
	CALL runtimePushFixedSubString
	PUSH HL
	LD HL,ZXBASIC_VAR_e_string
	PUSH HL
	LD HL,1
	PUSH HL
	LD HL,31
	LD BC,HL
	POP DE
	POP HL
	CALL runtimePushFixedSubString
; +
	POP DE
	CALL runtimeStringAdd
	POP DE
	LD BC,32
	CALL runtimeStoreStringVarFix
ZXB_LABEL_2:
ZXBASIC_LINE_210:
; 210  IF a>18 THEN  LET a=2: LET b=0: PRINT  AT 18,0; PAPER 0;,,: LET i= INT ( RND *7)+1: LET h=h+5: PLOT 255,3: DRAW  INK 2;-h,0: BEEP 0.05,-20.0
	LD HL,210
	LD (23621),HL
; 		210.1  IF a>18{00 00 12 00 00 } THEN  LET a=2{00 00 02 00 00 }
	LD A,1
	LD (23623),a
	LD HL,210
	LD A,1
	CALL runtimeDebug
	LD DE,(ZXBASIC_VAR_a)
	LD HL,18
; >
	CALL runtimeCmpHlGtDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_3
; 		210.2  LET a=2{00 00 02 00 00 }
	LD A,2
	LD (23623),a
	LD HL,210
	LD A,2
	CALL runtimeDebug
	LD HL,2
	LD (ZXBASIC_VAR_a),HL
; 		210.3  LET b=0{00 00 00 00 00 }
	LD A,3
	LD (23623),a
	LD HL,210
	LD A,3
	CALL runtimeDebug
	LD HL,0
	LD (ZXBASIC_VAR_b),HL
; 		210.4  PRINT  AT 18{00 00 12 00 00 },0{00 00 00 00 00 }; PAPER 0{00 00 00 00 00 };,,
	LD A,4
	LD (23623),a
	LD HL,210
	LD A,4
	CALL runtimeDebug
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,18
	LD HL,0
	CALL runtimePrintAt
	LD HL,0
	CALL runtimeLocalPaper
	CALL runtimePrintTab
	CALL runtimePrintTab
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
; 		210.5  LET i= INT ( RND *7{00 00 07 00 00 })+1{00 00 01 00 00 }
	LD A,5
	LD (23623),a
	LD HL,210
	LD A,5
	CALL runtimeDebug
; INT
; RND
	CALL runtimeRND
	LD HL,7
; *
	CALL runtimeIntToFloat
	RST $28
	DB $04	;MULT
	DB $38	;END CALC
	CALL runtimeFloatToInt
	INC HL
; +
	LD (ZXBASIC_VAR_i),HL
; 		210.6  LET h=h+5{00 00 05 00 00 }
	LD A,6
	LD (23623),a
	LD HL,210
	LD A,6
	CALL runtimeDebug
	LD DE,(ZXBASIC_VAR_h)
	LD HL,5
; +
	ADD HL,DE
	LD (ZXBASIC_VAR_h),HL
; 		210.7  PLOT 255{00 00 ff 00 00 },3{00 00 03 00 00 }
	LD A,7
	LD (23623),a
	LD HL,210
	LD A,7
	CALL runtimeDebug
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,255
	LD HL,3
	CALL runtimePlot
	POP AF
	LD (ZX_P_FLAG),A
; 		210.8  DRAW  INK 2{00 00 02 00 00 };-h,0{00 00 00 00 00 }
	LD A,8
	LD (23623),a
	LD HL,210
	LD A,8
	CALL runtimeDebug
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,2
	CALL runtimeLocalInk
	LD HL,(ZXBASIC_VAR_h)
	LD BC,HL
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
; 		210.9  BEEP 0.05{7c 4c cc cc cc },-20.0{00 00 14 00 00 }
	LD A,9
	LD (23623),a
	LD HL,210
	LD A,9
	CALL runtimeDebug
	LD HL,FLOAT_1	;0.05
	CALL runtimePushFloatVar
	LD HL,FLOAT_2	;20.0
	CALL runtimePushFloatVar
; -
	CALL runtimeNegFloat
	CALL $03F8
ZXB_LABEL_3:
ZXBASIC_LINE_230:
; 230  LET x=x-(k=189 OR j=2)+(k=190 OR j=1)
	LD HL,230
	LD (23621),HL
; 		230.1  LET x=x-(k=189{00 00 bd 00 00 } OR j=2{00 00 02 00 00 })+(k=190{00 00 be 00 00 } OR j=1{00 00 01 00 00 })
	LD A,1
	LD (23623),a
	LD HL,230
	LD A,1
	CALL runtimeDebug
	LD HL,(ZXBASIC_VAR_x)
	PUSH HL
; (
	LD DE,(ZXBASIC_VAR_k)
	LD HL,189
; =
	CALL runtimeCmpHLEqDE
	PUSH HL
	LD DE,(ZXBASIC_VAR_j)
	LD HL,2
; =
	CALL runtimeCmpHLEqDE
; OR
	POP DE
	call runtimeOrHLDE
; )
; -
	POP DE
	EX HL,DE
	SUB HL,DE
	PUSH HL
; (
	LD DE,(ZXBASIC_VAR_k)
	LD HL,190
; =
	CALL runtimeCmpHLEqDE
	PUSH HL
	LD DE,(ZXBASIC_VAR_j)
	LD HL,1
; =
	CALL runtimeCmpHLEqDE
; OR
	POP DE
	call runtimeOrHLDE
; )
; +
	POP DE
	ADD HL,DE
	LD (ZXBASIC_VAR_x),HL
ZXBASIC_LINE_240:
; 240  IF x<0 THEN  LET x=31
	LD HL,240
	LD (23621),HL
; 		240.1  IF x<0{00 00 00 00 00 } THEN  LET x=31{00 00 1f 00 00 }
	LD A,1
	LD (23623),a
	LD HL,240
	LD A,1
	CALL runtimeDebug
	LD DE,(ZXBASIC_VAR_x)
	LD HL,0
; <
	CALL runtimeCmpHLltDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_4
; 		240.2  LET x=31{00 00 1f 00 00 }
	LD A,2
	LD (23623),a
	LD HL,240
	LD A,2
	CALL runtimeDebug
	LD HL,31
	LD (ZXBASIC_VAR_x),HL
ZXB_LABEL_4:
ZXBASIC_LINE_250:
; 250  IF x>31 THEN  LET x=1
	LD HL,250
	LD (23621),HL
; 		250.1  IF x>31{00 00 1f 00 00 } THEN  LET x=1{00 00 01 00 00 }
	LD A,1
	LD (23623),a
	LD HL,250
	LD A,1
	CALL runtimeDebug
	LD DE,(ZXBASIC_VAR_x)
	LD HL,31
; >
	CALL runtimeCmpHlGtDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_5
; 		250.2  LET x=1{00 00 01 00 00 }
	LD A,2
	LD (23623),a
	LD HL,250
	LD A,2
	CALL runtimeDebug
	LD HL,1
	LD (ZXBASIC_VAR_x),HL
ZXB_LABEL_5:
ZXBASIC_LINE_260:
; 260  PRINT  AT a-1,b;d$;
	LD HL,260
	LD (23621),HL
; 		260.1  PRINT  AT a-1{00 00 01 00 00 },b;d$;
	LD A,1
	LD (23623),a
	LD HL,260
	LD A,1
	CALL runtimeDebug
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,(ZXBASIC_VAR_a)
	LD DE,1
; -
	SUB HL,DE
	LD DE,HL
	LD HL,(ZXBASIC_VAR_b)
	CALL runtimePrintAt
	LD HL,ZXBASIC_VAR_d_string
	LD BC,32
	CALL runtimePrintFixString
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_265:
; 265  IF l >= 4 THEN  LET sp=1: PRINT  AT 0,0; BRIGHT 1; INK 6;e$; BRIGHT 0
	LD HL,265
	LD (23621),HL
; 		265.1  IF l >= 4{00 00 04 00 00 } THEN  LET sp=1{00 00 01 00 00 }
	LD A,1
	LD (23623),a
	LD HL,265
	LD A,1
	CALL runtimeDebug
	LD DE,(ZXBASIC_VAR_l)
	LD HL,4
; >=
	CALL runtimeCmpHLGeDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_6
; 		265.2  LET sp=1{00 00 01 00 00 }
	LD A,2
	LD (23623),a
	LD HL,265
	LD A,2
	CALL runtimeDebug
	LD HL,1
	LD (ZXBASIC_VAR_sp),HL
; 		265.3  PRINT  AT 0{00 00 00 00 00 },0{00 00 00 00 00 }; BRIGHT 1{00 00 01 00 00 }; INK 6{00 00 06 00 00 };e$; BRIGHT 0{00 00 00 00 00 }
	LD A,3
	LD (23623),a
	LD HL,265
	LD A,3
	CALL runtimeDebug
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,0
	LD HL,0
	CALL runtimePrintAt
	LD HL,1
	CALL runtimeLocalBright
	LD HL,6
	CALL runtimeLocalInk
	LD HL,ZXBASIC_VAR_e_string
	LD BC,32
	CALL runtimePrintFixString
	LD HL,0
	CALL runtimeLocalBright
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
ZXB_LABEL_6:
ZXBASIC_LINE_270:
; 270  PRINT  AT a,b; INK i;a$; AT y,z;" " AND z <> x; AT y,x; INK 7;c$;
	LD HL,270
	LD (23621),HL
; 		270.1  PRINT  AT a,b; INK i;a$; AT y,z;" " AND z <> x; AT y,x; INK 7{00 00 07 00 00 };c$;
	LD A,1
	LD (23623),a
	LD HL,270
	LD A,1
	CALL runtimeDebug
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,(ZXBASIC_VAR_a)
	LD HL,(ZXBASIC_VAR_b)
	CALL runtimePrintAt
	LD HL,(ZXBASIC_VAR_i)
	CALL runtimeLocalInk
	LD HL,ZXBASIC_VAR_a_string
	LD BC,32
	CALL runtimePrintFixString
	LD DE,(ZXBASIC_VAR_y)
	LD HL,(ZXBASIC_VAR_z)
	CALL runtimePrintAt
	LD HL,STRING_0	; 
	PUSH HL
	LD DE,(ZXBASIC_VAR_z)
	LD HL,(ZXBASIC_VAR_x)
; <>
	CALL runtimeCmpHlNeDE
	LD DE,HL
; AND
	POP HL
	CALL runtimeVarStrAndInt
	CALL runtimePrintString
	LD DE,(ZXBASIC_VAR_y)
	LD HL,(ZXBASIC_VAR_x)
	CALL runtimePrintAt
	LD HL,7
	CALL runtimeLocalInk
	LD HL,(ZXBASIC_VAR_c_string)
	CALL runtimePrintString
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
	CALL ZXFreeTempCompact
ZXBASIC_LINE_280:
; 280  IF ( IN 32766=187 OR j=16) THEN  GOSUB f
	LD HL,280
	LD (23621),HL
; 		280.1  IF ( IN 32766{00 00 fe 7f 00 }=187{00 00 bb 00 00 } OR j=16{00 00 10 00 00 }) THEN  GOSUB f
	LD A,1
	LD (23623),a
	LD HL,280
	LD A,1
	CALL runtimeDebug
; (
; IN
	LD HL,32766
	LD BC,HL
	IN A,(C)
	LD L,A
	LD H,0
	LD DE,HL
	LD HL,187
; =
	CALL runtimeCmpHLEqDE
	PUSH HL
	LD DE,(ZXBASIC_VAR_j)
	LD HL,16
; =
	CALL runtimeCmpHLEqDE
; OR
	POP DE
	call runtimeOrHLDE
; )
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_7
; 		280.2  GOSUB f
	LD A,2
	LD (23623),a
	LD HL,280
	LD A,2
	CALL runtimeDebug
	CALL runtimeCheckBreakDebug
	LD DE,(ZXBASIC_VAR_f)
	LD HL,ZXLINES
	CALL runtimeFindLine
	CALL runtimeVarCall
ZXB_LABEL_7:
ZXBASIC_LINE_290:
; 290  LET z=x: LET a=a+0.725
	LD HL,290
	LD (23621),HL
; 		290.1  LET z=x
	LD A,1
	LD (23623),a
	LD HL,290
	LD A,1
	CALL runtimeDebug
	LD HL,(ZXBASIC_VAR_x)
	LD (ZXBASIC_VAR_z),HL
; 		290.2  LET a=a+0.725{80 39 99 99 99 }
	LD A,2
	LD (23623),a
	LD HL,290
	LD A,2
	CALL runtimeDebug
	LD HL,(ZXBASIC_VAR_a)
	PUSH HL
	LD HL,FLOAT_3	;0.725
	CALL runtimePushFloatVar
; +
	POP HL
	CALL runtimeIntToFloat
	CALL runtimePlusFloat
	CALL runtimeFloatToInt
	LD (ZXBASIC_VAR_a),HL
ZXBASIC_LINE_300:
; 300  IF p/3= INT (p/3) THEN  GOSUB 440
	LD HL,300
	LD (23621),HL
; 		300.1  IF p/3{00 00 03 00 00 }= INT (p/3{00 00 03 00 00 }) THEN  GOSUB 440{00 00 b8 01 00 }
	LD A,1
	LD (23623),a
	LD HL,300
	LD A,1
	CALL runtimeDebug
	LD DE,(ZXBASIC_VAR_p)
	LD HL,3
; /
	call runtimeDiv16bit
	PUSH HL
; INT
	LD DE,(ZXBASIC_VAR_p)
	LD HL,3
; /
	call runtimeDiv16bit
; =
	POP DE
	CALL runtimeCmpHLEqDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_8
; 		300.2  GOSUB 440{00 00 b8 01 00 }
	LD A,2
	LD (23623),a
	LD HL,300
	LD A,2
	CALL runtimeDebug
	CALL runtimeCheckBreakDebug
	CALL ZXBASIC_LINE_440
ZXB_LABEL_8:
ZXBASIC_LINE_310:
; 310  PRINT  AT pp,p1;"   " AND (p1 <> p); AT pp,p; INK 5;f$;
	LD HL,310
	LD (23621),HL
; 		310.1  PRINT  AT pp,p1;"   " AND (p1 <> p); AT pp,p; INK 5{00 00 05 00 00 };f$;
	LD A,1
	LD (23623),a
	LD HL,310
	LD A,1
	CALL runtimeDebug
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,(ZXBASIC_VAR_pp)
	LD HL,(ZXBASIC_VAR_p1)
	CALL runtimePrintAt
	LD HL,STRING_1	;   
	PUSH HL
; (
	LD DE,(ZXBASIC_VAR_p1)
	LD HL,(ZXBASIC_VAR_p)
; <>
	CALL runtimeCmpHlNeDE
	LD DE,HL
; )
; AND
	POP HL
	CALL runtimeVarStrAndInt
	CALL runtimePrintString
	LD DE,(ZXBASIC_VAR_pp)
	LD HL,(ZXBASIC_VAR_p)
	CALL runtimePrintAt
	LD HL,5
	CALL runtimeLocalInk
	LD HL,(ZXBASIC_VAR_f_string)
	CALL runtimePrintString
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
	CALL ZXFreeTempCompact
ZXBASIC_LINE_320:
; 320  LET p1=p: LET p=p+iv
	LD HL,320
	LD (23621),HL
; 		320.1  LET p1=p
	LD A,1
	LD (23623),a
	LD HL,320
	LD A,1
	CALL runtimeDebug
	LD HL,(ZXBASIC_VAR_p)
	LD (ZXBASIC_VAR_p1),HL
; 		320.2  LET p=p+iv
	LD A,2
	LD (23623),a
	LD HL,320
	LD A,2
	CALL runtimeDebug
	LD DE,(ZXBASIC_VAR_p)
	LD HL,(ZXBASIC_VAR_iv)
; +
	ADD HL,DE
	LD (ZXBASIC_VAR_p),HL
ZXBASIC_LINE_330:
; 330  LET iv=iv+(p<2)-(p>28)
	LD HL,330
	LD (23621),HL
; 		330.1  LET iv=iv+(p<2{00 00 02 00 00 })-(p>28{00 00 1c 00 00 })
	LD A,1
	LD (23623),a
	LD HL,330
	LD A,1
	CALL runtimeDebug
	LD HL,(ZXBASIC_VAR_iv)
	PUSH HL
; (
	LD DE,(ZXBASIC_VAR_p)
	LD HL,2
; <
	CALL runtimeCmpHLltDE
; )
; +
	POP DE
	ADD HL,DE
	PUSH HL
; (
	LD DE,(ZXBASIC_VAR_p)
	LD HL,28
; >
	CALL runtimeCmpHlGtDE
; )
; -
	POP DE
	EX HL,DE
	SUB HL,DE
	LD (ZXBASIC_VAR_iv),HL
ZXBASIC_LINE_348:
; 348  GOTO 180
	LD HL,348
	LD (23621),HL
; 		348.1  GOTO 180{00 00 b4 00 00 }
	LD A,1
	LD (23623),a
	LD HL,348
	LD A,1
	CALL runtimeDebug
	CALL runtimeCheckBreakDebug
	JP ZXBASIC_LINE_180
ZXBASIC_LINE_350:
; 350  REM *** SHOOT ***
	LD HL,350
	LD (23621),HL
	LD A,1
	LD (23623),a
	LD HL,350
	LD A,1
	CALL runtimeDebug
ZXBASIC_LINE_360:
; 360  IF a$(x+1)="\148" THEN  FOR u=1 TO 4: BEEP 0.002,35-u: NEXT u: LET sc=sc+5: LET l=l+1
	LD HL,360
	LD (23621),HL
; 		360.1  IF a$(x+1{00 00 01 00 00 })="\148" THEN  FOR u=1{00 00 01 00 00 } TO 4{00 00 04 00 00 }
	LD A,1
	LD (23623),a
	LD HL,360
	LD A,1
	CALL runtimeDebug
	LD HL,ZXBASIC_VAR_a_string
	PUSH HL
	LD DE,(ZXBASIC_VAR_x)
	LD HL,1
; +
	ADD HL,DE
	PUSH HL
	LD BC,HL
	POP DE
	POP HL
	CALL runtimePushFixedSubString
	LD DE,HL
	LD HL,STRING_2	;\94
; =
	CALL runtimeEqualString
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_9
; 		360.2  FOR u=1{00 00 01 00 00 } TO 4{00 00 04 00 00 }
	LD A,2
	LD (23623),a
	LD HL,360
	LD A,2
	CALL runtimeDebug
	CALL runtimeCheckBreakDebug
	LD HL,1
	LD (ZXBASIC_VAR_u),HL
	LD HL,4
	LD (ZXBASIC_VAR_for_u),HL
FOR_0:
; 		360.3  BEEP 0.002{78 03 12 6e 97 },35{00 00 23 00 00 }-u
	LD A,3
	LD (23623),a
	LD HL,360
	LD A,3
	CALL runtimeDebug
	LD HL,FLOAT_4	;0.002
	CALL runtimePushFloatVar
	LD HL,35
	LD DE,(ZXBASIC_VAR_u)
; -
	SUB HL,DE
	CALL runtimeIntToFloat
	CALL $03F8
; 		360.4  NEXT u
	LD A,4
	LD (23623),a
	LD HL,360
	LD A,4
	CALL runtimeDebug
	CALL runtimeCheckBreakDebug
	LD HL,(ZXBASIC_VAR_u)
	INC HL
	LD (ZXBASIC_VAR_u),HL
	LD DE,(ZXBASIC_VAR_for_u)
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_0
; 		360.5  LET sc=sc+5{00 00 05 00 00 }
	LD A,5
	LD (23623),a
	LD HL,360
	LD A,5
	CALL runtimeDebug
	LD DE,(ZXBASIC_VAR_sc)
	LD HL,5
; +
	ADD HL,DE
	LD (ZXBASIC_VAR_sc),HL
; 		360.6  LET l=l+1{00 00 01 00 00 }
	LD A,6
	LD (23623),a
	LD HL,360
	LD A,6
	CALL runtimeDebug
	LD HL,(ZXBASIC_VAR_l)
	INC HL
; +
	LD (ZXBASIC_VAR_l),HL
ZXB_LABEL_9:
ZXBASIC_LINE_365:
; 365  IF e$(x+1)="\144" THEN  FOR u=1 TO 4: BEEP 0.02,35+u: NEXT u: LET sc=sc+20: LET sh=sh+1
	LD HL,365
	LD (23621),HL
; 		365.1  IF e$(x+1{00 00 01 00 00 })="\144" THEN  FOR u=1{00 00 01 00 00 } TO 4{00 00 04 00 00 }
	LD A,1
	LD (23623),a
	LD HL,365
	LD A,1
	CALL runtimeDebug
	LD HL,ZXBASIC_VAR_e_string
	PUSH HL
	LD DE,(ZXBASIC_VAR_x)
	LD HL,1
; +
	ADD HL,DE
	PUSH HL
	LD BC,HL
	POP DE
	POP HL
	CALL runtimePushFixedSubString
	LD DE,HL
	LD HL,STRING_3	;\90
; =
	CALL runtimeEqualString
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_10
; 		365.2  FOR u=1{00 00 01 00 00 } TO 4{00 00 04 00 00 }
	LD A,2
	LD (23623),a
	LD HL,365
	LD A,2
	CALL runtimeDebug
	CALL runtimeCheckBreakDebug
	LD HL,1
	LD (ZXBASIC_VAR_u),HL
	LD HL,4
	LD (ZXBASIC_VAR_for_u),HL
FOR_1:
; 		365.3  BEEP 0.02{7b 23 d7 0a 3d },35{00 00 23 00 00 }+u
	LD A,3
	LD (23623),a
	LD HL,365
	LD A,3
	CALL runtimeDebug
	LD HL,FLOAT_5	;0.02
	CALL runtimePushFloatVar
	LD DE,35
	LD HL,(ZXBASIC_VAR_u)
; +
	ADD HL,DE
	CALL runtimeIntToFloat
	CALL $03F8
; 		365.4  NEXT u
	LD A,4
	LD (23623),a
	LD HL,365
	LD A,4
	CALL runtimeDebug
	CALL runtimeCheckBreakDebug
	LD HL,(ZXBASIC_VAR_u)
	INC HL
	LD (ZXBASIC_VAR_u),HL
	LD DE,(ZXBASIC_VAR_for_u)
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_1
; 		365.5  LET sc=sc+20{00 00 14 00 00 }
	LD A,5
	LD (23623),a
	LD HL,365
	LD A,5
	CALL runtimeDebug
	LD DE,(ZXBASIC_VAR_sc)
	LD HL,20
; +
	ADD HL,DE
	LD (ZXBASIC_VAR_sc),HL
; 		365.6  LET sh=sh+1{00 00 01 00 00 }
	LD A,6
	LD (23623),a
	LD HL,365
	LD A,6
	CALL runtimeDebug
	LD HL,(ZXBASIC_VAR_sh)
	INC HL
; +
	LD (ZXBASIC_VAR_sh),HL
ZXB_LABEL_10:
ZXBASIC_LINE_366:
; 366  IF sh=6 AND h >= 175 THEN  BEEP 0.2,25: PLOT 50,3: DRAW  INK 4;75,0: LET sh=0: LET h=120
	LD HL,366
	LD (23621),HL
; 		366.1  IF sh=6{00 00 06 00 00 } AND h >= 175{00 00 af 00 00 } THEN  BEEP 0.2{7e 4c cc cc cc },25{00 00 19 00 00 }
	LD A,1
	LD (23623),a
	LD HL,366
	LD A,1
	CALL runtimeDebug
	LD DE,(ZXBASIC_VAR_sh)
	LD HL,6
; =
	CALL runtimeCmpHLEqDE
	PUSH HL
	LD DE,(ZXBASIC_VAR_h)
	LD HL,175
; >=
	CALL runtimeCmpHLGeDE
; AND
	POP DE
	call runtimeAndHLDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_11
; 		366.2  BEEP 0.2{7e 4c cc cc cc },25{00 00 19 00 00 }
	LD A,2
	LD (23623),a
	LD HL,366
	LD A,2
	CALL runtimeDebug
	LD HL,FLOAT_6	;0.2
	CALL runtimePushFloatVar
	LD HL,25
	CALL runtimeIntToFloat
	CALL $03F8
; 		366.3  PLOT 50{00 00 32 00 00 },3{00 00 03 00 00 }
	LD A,3
	LD (23623),a
	LD HL,366
	LD A,3
	CALL runtimeDebug
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,50
	LD HL,3
	CALL runtimePlot
	POP AF
	LD (ZX_P_FLAG),A
; 		366.4  DRAW  INK 4{00 00 04 00 00 };75{00 00 4b 00 00 },0{00 00 00 00 00 }
	LD A,4
	LD (23623),a
	LD HL,366
	LD A,4
	CALL runtimeDebug
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,4
	CALL runtimeLocalInk
	LD DE,75
	LD HL,0
	LD B,L
	LD C,E
	CALL runtimeDraw
	POP AF
	LD (ZX_P_FLAG),A
; 		366.5  LET sh=0{00 00 00 00 00 }
	LD A,5
	LD (23623),a
	LD HL,366
	LD A,5
	CALL runtimeDebug
	LD HL,0
	LD (ZXBASIC_VAR_sh),HL
; 		366.6  LET h=120{00 00 78 00 00 }
	LD A,6
	LD (23623),a
	LD HL,366
	LD A,6
	CALL runtimeDebug
	LD HL,120
	LD (ZXBASIC_VAR_h),HL
ZXB_LABEL_11:
ZXBASIC_LINE_370:
; 370  PLOT x*8+4,49: DRAW  OVER 1; INK 4;0,125: DRAW  OVER 1; INK 0;0,-125
	LD HL,370
	LD (23621),HL
; 		370.1  PLOT x*8{00 00 08 00 00 }+4{00 00 04 00 00 },49{00 00 31 00 00 }
	LD A,1
	LD (23623),a
	LD HL,370
	LD A,1
	CALL runtimeDebug
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,(ZXBASIC_VAR_x)
	LD HL,8
; *
	call runtimeMult16bit
	LD DE,HL
	LD HL,4
; +
	ADD HL,DE
	LD DE,HL
	LD HL,49
	CALL runtimePlot
	POP AF
	LD (ZX_P_FLAG),A
; 		370.2  DRAW  OVER 1{00 00 01 00 00 }; INK 4{00 00 04 00 00 };0{00 00 00 00 00 },125{00 00 7d 00 00 }
	LD A,2
	LD (23623),a
	LD HL,370
	LD A,2
	CALL runtimeDebug
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,1
	CALL runtimeLocalOver
	LD HL,4
	CALL runtimeLocalInk
	LD DE,0
	LD HL,125
	LD B,L
	LD C,E
	CALL runtimeDraw
	POP AF
	LD (ZX_P_FLAG),A
; 		370.3  DRAW  OVER 1{00 00 01 00 00 }; INK 0{00 00 00 00 00 };0{00 00 00 00 00 },-125{00 00 7d 00 00 }
	LD A,3
	LD (23623),a
	LD HL,370
	LD A,3
	CALL runtimeDebug
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,1
	CALL runtimeLocalOver
	LD HL,0
	CALL runtimeLocalInk
	LD HL,0
	PUSH HL
	LD HL,125
	LD BC,HL
; -
	LD HL,0
	SUB HL,BC
	POP DE
	LD B,L
	LD C,E
	CALL runtimeDraw
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_375:
; 375  IF  ATTR (pp,p1+1)=0 OR  ATTR (pp,p1)=0 OR  ATTR (pp,p1+2)=0 THEN  FOR w=1 TO 2: LET i= INT ( RND *7)+1: BEEP 0.01,45-w: NEXT w: LET sc=sc+15: LET sh=sh+1
	LD HL,375
	LD (23621),HL
; 		375.1  IF  ATTR (pp,p1+1{00 00 01 00 00 })=0{00 00 00 00 00 } OR  ATTR (pp,p1)=0{00 00 00 00 00 } OR  ATTR (pp,p1+2{00 00 02 00 00 })=0{00 00 00 00 00 } THEN  FOR w=1{00 00 01 00 00 } TO 2{00 00 02 00 00 }
	LD A,1
	LD (23623),a
	LD HL,375
	LD A,1
	CALL runtimeDebug
; ATTR
	LD HL,(ZXBASIC_VAR_pp)
	PUSH HL
	LD DE,(ZXBASIC_VAR_p1)
	LD HL,1
; +
	ADD HL,DE
	POP DE
	CALL runtimeAttr
	LD DE,HL
	LD HL,0
; =
	CALL runtimeCmpHLEqDE
	PUSH HL
; ATTR
	LD DE,(ZXBASIC_VAR_pp)
	LD HL,(ZXBASIC_VAR_p1)
	CALL runtimeAttr
	LD DE,HL
	LD HL,0
; =
	CALL runtimeCmpHLEqDE
; OR
	POP DE
	call runtimeOrHLDE
	PUSH HL
; ATTR
	LD HL,(ZXBASIC_VAR_pp)
	PUSH HL
	LD DE,(ZXBASIC_VAR_p1)
	LD HL,2
; +
	ADD HL,DE
	POP DE
	CALL runtimeAttr
	LD DE,HL
	LD HL,0
; =
	CALL runtimeCmpHLEqDE
; OR
	POP DE
	call runtimeOrHLDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_12
; 		375.2  FOR w=1{00 00 01 00 00 } TO 2{00 00 02 00 00 }
	LD A,2
	LD (23623),a
	LD HL,375
	LD A,2
	CALL runtimeDebug
	CALL runtimeCheckBreakDebug
	LD HL,1
	LD (ZXBASIC_VAR_w),HL
	LD HL,2
	LD (ZXBASIC_VAR_for_w),HL
FOR_2:
; 		375.3  LET i= INT ( RND *7{00 00 07 00 00 })+1{00 00 01 00 00 }
	LD A,3
	LD (23623),a
	LD HL,375
	LD A,3
	CALL runtimeDebug
; INT
; RND
	CALL runtimeRND
	LD HL,7
; *
	CALL runtimeIntToFloat
	RST $28
	DB $04	;MULT
	DB $38	;END CALC
	CALL runtimeFloatToInt
	INC HL
; +
	LD (ZXBASIC_VAR_i),HL
; 		375.4  BEEP 0.01{7a 23 d7 0a 3d },45{00 00 2d 00 00 }-w
	LD A,4
	LD (23623),a
	LD HL,375
	LD A,4
	CALL runtimeDebug
	LD HL,FLOAT_7	;0.01
	CALL runtimePushFloatVar
	LD HL,45
	LD DE,(ZXBASIC_VAR_w)
; -
	SUB HL,DE
	CALL runtimeIntToFloat
	CALL $03F8
; 		375.5  NEXT w
	LD A,5
	LD (23623),a
	LD HL,375
	LD A,5
	CALL runtimeDebug
	CALL runtimeCheckBreakDebug
	LD HL,(ZXBASIC_VAR_w)
	INC HL
	LD (ZXBASIC_VAR_w),HL
	LD DE,(ZXBASIC_VAR_for_w)
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_2
; 		375.6  LET sc=sc+15{00 00 0f 00 00 }
	LD A,6
	LD (23623),a
	LD HL,375
	LD A,6
	CALL runtimeDebug
	LD DE,(ZXBASIC_VAR_sc)
	LD HL,15
; +
	ADD HL,DE
	LD (ZXBASIC_VAR_sc),HL
; 		375.7  LET sh=sh+1{00 00 01 00 00 }
	LD A,7
	LD (23623),a
	LD HL,375
	LD A,7
	CALL runtimeDebug
	LD HL,(ZXBASIC_VAR_sh)
	INC HL
; +
	LD (ZXBASIC_VAR_sh),HL
ZXB_LABEL_12:
ZXBASIC_LINE_380:
; 380  LET a$(x+1)=" "
	LD HL,380
	LD (23621),HL
; 		380.1  LET a$(x+1{00 00 01 00 00 })=" "
	LD A,1
	LD (23623),a
	LD HL,380
	LD A,1
	CALL runtimeDebug
	LD HL,ZXBASIC_VAR_a_string
	PUSH HL
	LD DE,(ZXBASIC_VAR_x)
	LD HL,1
; +
	ADD HL,DE
	PUSH HL
	PUSH HL
	LD HL,STRING_0	; 
	CALL runtimeStoreFixedStringWithRangeFromBstr
ZXBASIC_LINE_385:
; 385  LET e$(x+1)=" "
	LD HL,385
	LD (23621),HL
; 		385.1  LET e$(x+1{00 00 01 00 00 })=" "
	LD A,1
	LD (23623),a
	LD HL,385
	LD A,1
	CALL runtimeDebug
	LD HL,ZXBASIC_VAR_e_string
	PUSH HL
	LD DE,(ZXBASIC_VAR_x)
	LD HL,1
; +
	ADD HL,DE
	PUSH HL
	PUSH HL
	LD HL,STRING_0	; 
	CALL runtimeStoreFixedStringWithRangeFromBstr
ZXBASIC_LINE_390:
; 390  PRINT  AT 20,6; INK 6; BRIGHT 1; PAPER 2;sc;
	LD HL,390
	LD (23621),HL
; 		390.1  PRINT  AT 20{00 00 14 00 00 },6{00 00 06 00 00 }; INK 6{00 00 06 00 00 }; BRIGHT 1{00 00 01 00 00 }; PAPER 2{00 00 02 00 00 };sc;
	LD A,1
	LD (23623),a
	LD HL,390
	LD A,1
	CALL runtimeDebug
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,20
	LD HL,6
	CALL runtimePrintAt
	LD HL,6
	CALL runtimeLocalInk
	LD HL,1
	CALL runtimeLocalBright
	LD HL,2
	CALL runtimeLocalPaper
	LD HL,(ZXBASIC_VAR_sc)
	CALL runtimePrintInt
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_400:
; 400  BEEP 0.002,10
	LD HL,400
	LD (23621),HL
; 		400.1  BEEP 0.002{78 03 12 6e 97 },10{00 00 0a 00 00 }
	LD A,1
	LD (23623),a
	LD HL,400
	LD A,1
	CALL runtimeDebug
	LD HL,FLOAT_4	;0.002
	CALL runtimePushFloatVar
	LD HL,10
	CALL runtimeIntToFloat
	CALL $03F8
ZXBASIC_LINE_405:
; 405  PRINT  INK 3; AT 0,20;"L=";l
	LD HL,405
	LD (23621),HL
; 		405.1  PRINT  INK 3{00 00 03 00 00 }; AT 0{00 00 00 00 00 },20{00 00 14 00 00 };"L=";l
	LD A,1
	LD (23623),a
	LD HL,405
	LD A,1
	CALL runtimeDebug
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,3
	CALL runtimeLocalInk
	LD DE,0
	LD HL,20
	CALL runtimePrintAt
	LD HL,STRING_4	;L=
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_l)
	CALL runtimePrintInt
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_410:
; 410  IF l<6 THEN  RETURN 
	LD HL,410
	LD (23621),HL
; 		410.1  IF l<6{00 00 06 00 00 } THEN  RETURN 
	LD A,1
	LD (23623),a
	LD HL,410
	LD A,1
	CALL runtimeDebug
	LD DE,(ZXBASIC_VAR_l)
	LD HL,6
; <
	CALL runtimeCmpHLltDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_13
; 		410.2  RETURN 
	LD A,2
	LD (23623),a
	LD HL,410
	LD A,2
	CALL runtimeDebug
	CALL runtimeCheckBreakDebug
	RET
ZXB_LABEL_13:
ZXBASIC_LINE_420:
; 420  FOR t=30 TO 40: BEEP 0.004,t: NEXT t: LET a=2: FOR c=0 TO 17: PRINT  AT c,0; PAPER 0;,,,,: NEXT c: BEEP 0.03,35: LET sc=sc+50: GOSUB 780
	LD HL,420
	LD (23621),HL
; 		420.1  FOR t=30{00 00 1e 00 00 } TO 40{00 00 28 00 00 }
	LD A,1
	LD (23623),a
	LD HL,420
	LD A,1
	CALL runtimeDebug
	CALL runtimeCheckBreakDebug
	LD HL,30
	LD (ZXBASIC_VAR_t),HL
	LD HL,40
	LD (ZXBASIC_VAR_for_t),HL
FOR_3:
; 		420.2  BEEP 0.004{79 03 12 6e 97 },t
	LD A,2
	LD (23623),a
	LD HL,420
	LD A,2
	CALL runtimeDebug
	LD HL,FLOAT_8	;0.004
	CALL runtimePushFloatVar
	LD HL,(ZXBASIC_VAR_t)
	CALL runtimeIntToFloat
	CALL $03F8
; 		420.3  NEXT t
	LD A,3
	LD (23623),a
	LD HL,420
	LD A,3
	CALL runtimeDebug
	CALL runtimeCheckBreakDebug
	LD HL,(ZXBASIC_VAR_t)
	INC HL
	LD (ZXBASIC_VAR_t),HL
	LD DE,(ZXBASIC_VAR_for_t)
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_3
; 		420.4  LET a=2{00 00 02 00 00 }
	LD A,4
	LD (23623),a
	LD HL,420
	LD A,4
	CALL runtimeDebug
	LD HL,2
	LD (ZXBASIC_VAR_a),HL
; 		420.5  FOR c=0{00 00 00 00 00 } TO 17{00 00 11 00 00 }
	LD A,5
	LD (23623),a
	LD HL,420
	LD A,5
	CALL runtimeDebug
	CALL runtimeCheckBreakDebug
	LD HL,0
	LD (ZXBASIC_VAR_c),HL
	LD HL,17
	LD (ZXBASIC_VAR_for_c),HL
FOR_4:
; 		420.6  PRINT  AT c,0{00 00 00 00 00 }; PAPER 0{00 00 00 00 00 };,,,,
	LD A,6
	LD (23623),a
	LD HL,420
	LD A,6
	CALL runtimeDebug
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,(ZXBASIC_VAR_c)
	LD HL,0
	CALL runtimePrintAt
	LD HL,0
	CALL runtimeLocalPaper
	CALL runtimePrintTab
	CALL runtimePrintTab
	CALL runtimePrintTab
	CALL runtimePrintTab
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
; 		420.7  NEXT c
	LD A,7
	LD (23623),a
	LD HL,420
	LD A,7
	CALL runtimeDebug
	CALL runtimeCheckBreakDebug
	LD HL,(ZXBASIC_VAR_c)
	INC HL
	LD (ZXBASIC_VAR_c),HL
	LD DE,(ZXBASIC_VAR_for_c)
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_4
; 		420.8  BEEP 0.03{7b 75 c2 8f 5c },35{00 00 23 00 00 }
	LD A,8
	LD (23623),a
	LD HL,420
	LD A,8
	CALL runtimeDebug
	LD HL,FLOAT_9	;0.03
	CALL runtimePushFloatVar
	LD HL,35
	CALL runtimeIntToFloat
	CALL $03F8
; 		420.9  LET sc=sc+50{00 00 32 00 00 }
	LD A,9
	LD (23623),a
	LD HL,420
	LD A,9
	CALL runtimeDebug
	LD DE,(ZXBASIC_VAR_sc)
	LD HL,50
; +
	ADD HL,DE
	LD (ZXBASIC_VAR_sc),HL
; 		420.10  GOSUB 780{00 00 0c 03 00 }
	LD A,10
	LD (23623),a
	LD HL,420
	LD A,10
	CALL runtimeDebug
	CALL runtimeCheckBreakDebug
	CALL ZXBASIC_LINE_780
ZXBASIC_LINE_430:
; 430  RETURN 
	LD HL,430
	LD (23621),HL
; 		430.1  RETURN 
	LD A,1
	LD (23623),a
	LD HL,430
	LD A,1
	CALL runtimeDebug
	CALL runtimeCheckBreakDebug
	RET
ZXBASIC_LINE_440:
; 440  PLOT p1*8+12,159: DRAW  OVER 1; INK 2;0,-141: DRAW  OVER 1; INK 2;0,141
	LD HL,440
	LD (23621),HL
; 		440.1  PLOT p1*8{00 00 08 00 00 }+12{00 00 0c 00 00 },159{00 00 9f 00 00 }
	LD A,1
	LD (23623),a
	LD HL,440
	LD A,1
	CALL runtimeDebug
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,(ZXBASIC_VAR_p1)
	LD HL,8
; *
	call runtimeMult16bit
	LD DE,HL
	LD HL,12
; +
	ADD HL,DE
	LD DE,HL
	LD HL,159
	CALL runtimePlot
	POP AF
	LD (ZX_P_FLAG),A
; 		440.2  DRAW  OVER 1{00 00 01 00 00 }; INK 2{00 00 02 00 00 };0{00 00 00 00 00 },-141{00 00 8d 00 00 }
	LD A,2
	LD (23623),a
	LD HL,440
	LD A,2
	CALL runtimeDebug
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,1
	CALL runtimeLocalOver
	LD HL,2
	CALL runtimeLocalInk
	LD HL,0
	PUSH HL
	LD HL,141
	LD BC,HL
; -
	LD HL,0
	SUB HL,BC
	POP DE
	LD B,L
	LD C,E
	CALL runtimeDraw
	POP AF
	LD (ZX_P_FLAG),A
; 		440.3  DRAW  OVER 1{00 00 01 00 00 }; INK 2{00 00 02 00 00 };0{00 00 00 00 00 },141{00 00 8d 00 00 }
	LD A,3
	LD (23623),a
	LD HL,440
	LD A,3
	CALL runtimeDebug
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,1
	CALL runtimeLocalOver
	LD HL,2
	CALL runtimeLocalInk
	LD DE,0
	LD HL,141
	LD B,L
	LD C,E
	CALL runtimeDraw
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_450:
; 450  OUT 254,16: OUT 254,8
	LD HL,450
	LD (23621),HL
; 		450.1  OUT 254{00 00 fe 00 00 },16{00 00 10 00 00 }
	LD A,1
	LD (23623),a
	LD HL,450
	LD A,1
	CALL runtimeDebug
	LD HL,254
	PUSH HL
	LD HL,16
	POP BC
	LD A,L
	OUT (C),A
; 		450.2  OUT 254{00 00 fe 00 00 },8{00 00 08 00 00 }
	LD A,2
	LD (23623),a
	LD HL,450
	LD A,2
	CALL runtimeDebug
	LD HL,254
	PUSH HL
	LD HL,8
	POP BC
	LD A,L
	OUT (C),A
ZXBASIC_LINE_455:
; 455  IF l>0 THEN  IF  ATTR (y,x)=2 THEN  FOR d=10.0 TO 20.0:  BEEP 0.025,0-d: NEXT d: LET h=h+25: PLOT 255,3: DRAW  INK 2;-h,0
	LD HL,455
	LD (23621),HL
; 		455.1  IF l>0{00 00 00 00 00 } THEN  IF  ATTR (y,x)=2{00 00 02 00 00 } THEN  FOR d=10.0{00 00 0a 00 00 } TO 20.0{00 00 14 00 00 }
	LD A,1
	LD (23623),a
	LD HL,455
	LD A,1
	CALL runtimeDebug
	LD DE,(ZXBASIC_VAR_l)
	LD HL,0
; >
	CALL runtimeCmpHlGtDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_14
; 		455.2  IF  ATTR (y,x)=2{00 00 02 00 00 } THEN  FOR d=10.0{00 00 0a 00 00 } TO 20.0{00 00 14 00 00 }
	LD A,2
	LD (23623),a
	LD HL,455
	LD A,2
	CALL runtimeDebug
; ATTR
	LD DE,(ZXBASIC_VAR_y)
	LD HL,(ZXBASIC_VAR_x)
	CALL runtimeAttr
	LD DE,HL
	LD HL,2
; =
	CALL runtimeCmpHLEqDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_15
; 		455.3  FOR d=10.0{00 00 0a 00 00 } TO 20.0{00 00 14 00 00 }
	LD A,3
	LD (23623),a
	LD HL,455
	LD A,3
	CALL runtimeDebug
	CALL runtimeCheckBreakDebug
	LD HL,FLOAT_10	;10.0
	LD DE,ZXBASIC_VAR_d
	LD BC,5
	LDIR
	LD HL,FLOAT_2	;20.0
	LD DE,ZXBASIC_VAR_for_d
	LD BC,5
	LDIR
FOR_5:
; 		455.4  BEEP 0.025{7b 4c cc cc cc },0{00 00 00 00 00 }-d
	LD A,4
	LD (23623),a
	LD HL,455
	LD A,4
	CALL runtimeDebug
	LD HL,FLOAT_11	;0.025
	CALL runtimePushFloatVar
	LD HL,0
	PUSH HL
	LD HL,ZXBASIC_VAR_d
	CALL runtimePushFloatVar
; -
	POP HL
	CALL runtimeIntToFloat
	CALL runtimeSwapFloat
	CALL runtimeMinusFloat
	CALL $03F8
; 		455.5  NEXT d
	LD A,5
	LD (23623),a
	LD HL,455
	LD A,5
	CALL runtimeDebug
	CALL runtimeCheckBreakDebug
	LD HL,ZXBASIC_VAR_d
	CALL runtimePushFloatVar
	RST $28
	DB zxcalc_stack_one	;STACK ONE
	DB zxcalc_addition	;ADD
	DB zxcalc_end_calc	;END CALC
	LD HL,ZXBASIC_VAR_d
	CALL runtimeStoreFloat
	LD HL,ZXBASIC_VAR_for_d
	CALL runtimePushFloatVar
	LD HL,ZXBASIC_VAR_d
	CALL runtimePushFloatVar
	CALL runtimeSmallerFloat
	LD A,L
	CP 0
	JP Z,FOR_5
; 		455.6  LET h=h+25{00 00 19 00 00 }
	LD A,6
	LD (23623),a
	LD HL,455
	LD A,6
	CALL runtimeDebug
	LD DE,(ZXBASIC_VAR_h)
	LD HL,25
; +
	ADD HL,DE
	LD (ZXBASIC_VAR_h),HL
; 		455.7  PLOT 255{00 00 ff 00 00 },3{00 00 03 00 00 }
	LD A,7
	LD (23623),a
	LD HL,455
	LD A,7
	CALL runtimeDebug
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,255
	LD HL,3
	CALL runtimePlot
	POP AF
	LD (ZX_P_FLAG),A
; 		455.8  DRAW  INK 2{00 00 02 00 00 };-h,0{00 00 00 00 00 }
	LD A,8
	LD (23623),a
	LD HL,455
	LD A,8
	CALL runtimeDebug
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,2
	CALL runtimeLocalInk
	LD HL,(ZXBASIC_VAR_h)
	LD BC,HL
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
ZXB_LABEL_15:
ZXB_LABEL_14:
ZXBASIC_LINE_470:
; 470  RETURN 
	LD HL,470
	LD (23621),HL
; 		470.1  RETURN 
	LD A,1
	LD (23623),a
	LD HL,470
	LD A,1
	CALL runtimeDebug
	CALL runtimeCheckBreakDebug
	RET
ZXBASIC_LINE_480:
; 480  REM ** GAME OVER **
	LD HL,480
	LD (23621),HL
	LD A,1
	LD (23623),a
	LD HL,480
	LD A,1
	CALL runtimeDebug
ZXBASIC_LINE_490:
; 490  PRINT  AT 10,8; FLASH 1; INK 2;"G A M E  O V E R"\020\001
	LD HL,490
	LD (23621),HL
; 		490.1  PRINT  AT 10{00 00 0a 00 00 },8{00 00 08 00 00 }; FLASH 1{00 00 01 00 00 }; INK 2{00 00 02 00 00 };"G A M E  O V E R"\020\001
	LD A,1
	LD (23623),a
	LD HL,490
	LD A,1
	CALL runtimeDebug
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,10
	LD HL,8
	CALL runtimePrintAt
	LD HL,1
	CALL runtimeLocalFlash
	LD HL,2
	CALL runtimeLocalInk
	LD HL,STRING_5	;G A M E  O V E R
	CALL runtimePrintString
	LD HL,STRING_5	;G A M E  O V E R
	CALL runtimePrintString
	LD HL,STRING_5	;G A M E  O V E R
	CALL runtimePrintString
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_495:
; 495  PRINT  AT 21,0; FLASH 1; PAPER 2; INK 0;"SHIELD"; FLASH 0
	LD HL,495
	LD (23621),HL
; 		495.1  PRINT  AT 21{00 00 15 00 00 },0{00 00 00 00 00 }; FLASH 1{00 00 01 00 00 }; PAPER 2{00 00 02 00 00 }; INK 0{00 00 00 00 00 };"SHIELD"; FLASH 0{00 00 00 00 00 }
	LD A,1
	LD (23623),a
	LD HL,495
	LD A,1
	CALL runtimeDebug
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,21
	LD HL,0
	CALL runtimePrintAt
	LD HL,1
	CALL runtimeLocalFlash
	LD HL,2
	CALL runtimeLocalPaper
	LD HL,0
	CALL runtimeLocalInk
	LD HL,STRING_6	;SHIELD
	CALL runtimePrintString
	LD HL,0
	CALL runtimeLocalFlash
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_500:
; 500  FOR t=1 TO 5
	LD HL,500
	LD (23621),HL
; 		500.1  FOR t=1{00 00 01 00 00 } TO 5{00 00 05 00 00 }
	LD A,1
	LD (23623),a
	LD HL,500
	LD A,1
	CALL runtimeDebug
	CALL runtimeCheckBreakDebug
	LD HL,1
	LD (ZXBASIC_VAR_t),HL
	LD HL,5
	LD (ZXBASIC_VAR_for_t),HL
FOR_6:
ZXBASIC_LINE_510:
; 510  FOR o=-30.0 TO -20.0: BEEP 0.015,o: NEXT o
	LD HL,510
	LD (23621),HL
; 		510.1  FOR o=-30.0{00 00 1e 00 00 } TO -20.0{00 00 14 00 00 }
	LD A,1
	LD (23623),a
	LD HL,510
	LD A,1
	CALL runtimeDebug
	CALL runtimeCheckBreakDebug
	LD HL,FLOAT_12	;30.0
	CALL runtimePushFloatVar
; -
	CALL runtimeNegFloat
	LD HL,ZXBASIC_VAR_o
	CALL runtimeStoreFloat
	LD HL,FLOAT_2	;20.0
	CALL runtimePushFloatVar
; -
	CALL runtimeNegFloat
	LD HL,ZXBASIC_VAR_for_o
	CALL runtimeStoreFloat
FOR_7:
; 		510.2  BEEP 0.015{7a 75 c2 8f 5c },o
	LD A,2
	LD (23623),a
	LD HL,510
	LD A,2
	CALL runtimeDebug
	LD HL,FLOAT_13	;0.015
	CALL runtimePushFloatVar
	LD HL,ZXBASIC_VAR_o
	CALL runtimePushFloatVar
	CALL $03F8
; 		510.3  NEXT o
	LD A,3
	LD (23623),a
	LD HL,510
	LD A,3
	CALL runtimeDebug
	CALL runtimeCheckBreakDebug
	LD HL,ZXBASIC_VAR_o
	CALL runtimePushFloatVar
	RST $28
	DB zxcalc_stack_one	;STACK ONE
	DB zxcalc_addition	;ADD
	DB zxcalc_end_calc	;END CALC
	LD HL,ZXBASIC_VAR_o
	CALL runtimeStoreFloat
	LD HL,ZXBASIC_VAR_for_o
	CALL runtimePushFloatVar
	LD HL,ZXBASIC_VAR_o
	CALL runtimePushFloatVar
	CALL runtimeSmallerFloat
	LD A,L
	CP 0
	JP Z,FOR_7
ZXBASIC_LINE_520:
; 520  NEXT t
	LD HL,520
	LD (23621),HL
; 		520.1  NEXT t
	LD A,1
	LD (23623),a
	LD HL,520
	LD A,1
	CALL runtimeDebug
	CALL runtimeCheckBreakDebug
	LD HL,(ZXBASIC_VAR_t)
	INC HL
	LD (ZXBASIC_VAR_t),HL
	LD DE,(ZXBASIC_VAR_for_t)
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_6
ZXBASIC_LINE_530:
; 530  IF sc >= hs THEN  LET hs=sc
	LD HL,530
	LD (23621),HL
; 		530.1  IF sc >= hs THEN  LET hs=sc
	LD A,1
	LD (23623),a
	LD HL,530
	LD A,1
	CALL runtimeDebug
	LD DE,(ZXBASIC_VAR_sc)
	LD HL,(ZXBASIC_VAR_hs)
; >=
	CALL runtimeCmpHLGeDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_16
; 		530.2  LET hs=sc
	LD A,2
	LD (23623),a
	LD HL,530
	LD A,2
	CALL runtimeDebug
	LD HL,(ZXBASIC_VAR_sc)
	LD (ZXBASIC_VAR_hs),HL
ZXB_LABEL_16:
ZXBASIC_LINE_540:
; 540  FOR a=1 TO 320: NEXT a: CLS : GOTO 50
	LD HL,540
	LD (23621),HL
; 		540.1  FOR a=1{00 00 01 00 00 } TO 320{00 00 40 01 00 }
	LD A,1
	LD (23623),a
	LD HL,540
	LD A,1
	CALL runtimeDebug
	CALL runtimeCheckBreakDebug
	LD HL,1
	LD (ZXBASIC_VAR_a),HL
	LD HL,320
	LD (ZXBASIC_VAR_for_a),HL
FOR_8:
; 		540.2  NEXT a
	LD A,2
	LD (23623),a
	LD HL,540
	LD A,2
	CALL runtimeDebug
	CALL runtimeCheckBreakDebug
	LD HL,(ZXBASIC_VAR_a)
	INC HL
	LD (ZXBASIC_VAR_a),HL
	LD DE,(ZXBASIC_VAR_for_a)
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_8
; 		540.3  CLS 
	LD A,3
	LD (23623),a
	LD HL,540
	LD A,3
	CALL runtimeDebug
	CALL runtimeCls
; 		540.4  GOTO 50{00 00 32 00 00 }
	LD A,4
	LD (23623),a
	LD HL,540
	LD A,4
	CALL runtimeDebug
	CALL runtimeCheckBreakDebug
	JP ZXBASIC_LINE_50
ZXBASIC_LINE_550:
; 550  REM ** UDG **
	LD HL,550
	LD (23621),HL
	LD A,1
	LD (23623),a
	LD HL,550
	LD A,1
	CALL runtimeDebug
ZXBASIC_LINE_560:
; 560  RESTORE 900: FOR g=0 TO 95
	LD HL,560
	LD (23621),HL
; 		560.1  RESTORE 900{00 00 84 03 00 }
	LD A,1
	LD (23623),a
	LD HL,560
	LD A,1
	CALL runtimeDebug
	LD HL,DATA_900
	LD (DATAPTR),HL
; 		560.2  FOR g=0{00 00 00 00 00 } TO 95{00 00 5f 00 00 }
	LD A,2
	LD (23623),a
	LD HL,560
	LD A,2
	CALL runtimeDebug
	CALL runtimeCheckBreakDebug
	LD HL,0
	LD (ZXBASIC_VAR_g),HL
	LD HL,95
	LD (ZXBASIC_VAR_for_g),HL
FOR_9:
ZXBASIC_LINE_570:
; 570  READ dat
	LD HL,570
	LD (23621),HL
; 		570.1  READ dat
	LD A,1
	LD (23623),a
	LD HL,570
	LD A,1
	CALL runtimeDebug
	LD HL,(DATAPTR)
	LD DE,(HL)
	INC HL
	INC HL
	LD (DATAPTR),HL
	LD (ZXBASIC_VAR_dat),DE
ZXBASIC_LINE_580:
; 580  POKE  USR "a"+g,dat
	LD HL,580
	LD (23621),HL
; 		580.1  POKE  USR "a"+g,dat
	LD A,1
	LD (23623),a
	LD HL,580
	LD A,1
	CALL runtimeDebug
; USR
	LD HL,STRING_7	;a
	CALL runtimeUsrUDG
	LD DE,HL
	LD HL,(ZXBASIC_VAR_g)
; +
	ADD HL,DE
	LD DE,(ZXBASIC_VAR_dat)
	LD (HL),E
ZXBASIC_LINE_590:
; 590  NEXT g
	LD HL,590
	LD (23621),HL
; 		590.1  NEXT g
	LD A,1
	LD (23623),a
	LD HL,590
	LD A,1
	CALL runtimeDebug
	CALL runtimeCheckBreakDebug
	LD HL,(ZXBASIC_VAR_g)
	INC HL
	LD (ZXBASIC_VAR_g),HL
	LD DE,(ZXBASIC_VAR_for_g)
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_9
ZXBASIC_LINE_600:
; 600  RETURN 
	LD HL,600
	LD (23621),HL
; 		600.1  RETURN 
	LD A,1
	LD (23623),a
	LD HL,600
	LD A,1
	CALL runtimeDebug
	CALL runtimeCheckBreakDebug
	RET
ZXBASIC_LINE_700:
; 700  REM ** SCREEN SET UP **
	LD HL,700
	LD (23621),HL
	LD A,1
	LD (23623),a
	LD HL,700
	LD A,1
	CALL runtimeDebug
ZXBASIC_LINE_705:
; 705  PRINT  AT 5,8; INK 6;"\143\143\143\143   \143\143   \143\143\143\143                   \143  \143  \143  \143   \143                 \143   \143  \143  \143   \143                \143    \143\143\143\143  \143\143\143\143                \143     \143  \143  \143                   \143\143\143\143  \143  \143  \143 "
	LD HL,705
	LD (23621),HL
; 		705.1  PRINT  AT 5{00 00 05 00 00 },8{00 00 08 00 00 }; INK 6{00 00 06 00 00 };"\143\143\143\143   \143\143   \143\143\143\143                   \143  \143  \143  \143   \143                 \143   \143  \143  \143   \143                \143    \143\143\143\143  \143\143\143\143                \143     \143  \143  \143                   \143\143\143\143  \143  \143  \143 "
	LD A,1
	LD (23623),a
	LD HL,705
	LD A,1
	CALL runtimeDebug
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,5
	LD HL,8
	CALL runtimePrintAt
	LD HL,6
	CALL runtimeLocalInk
	LD HL,STRING_8	;\8f\8f\8f\8f   \8f\8f   \8f\8f\8f\8f                   \8f  \8f  \8f  \8f   \8f                 \8f   \8f  \8f  \8f   \8f                \8f    \8f\8f\8f\8f  \8f\8f\8f\8f                \8f     \8f  \8f  \8f                   \8f\8f\8f\8f  \8f  \8f  \8f 
	CALL runtimePrintString
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_710:
; 710  PRINT  AT 12,4; INK 2;"KEYS:O,P & M or KEMPSTON"; AT 14,10; FLASH 1; INK 1;"PRESS A KEY"; FLASH 0; INK 3; AT 21,8;"By Animated ALex"
	LD HL,710
	LD (23621),HL
; 		710.1  PRINT  AT 12{00 00 0c 00 00 },4{00 00 04 00 00 }; INK 2{00 00 02 00 00 };"KEYS
	LD A,1
	LD (23623),a
	LD HL,710
	LD A,1
	CALL runtimeDebug
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,12
	LD HL,4
	CALL runtimePrintAt
	LD HL,2
	CALL runtimeLocalInk
	LD HL,STRING_9	;KEYS:O,P & M or KEMPSTON
	CALL runtimePrintString
	LD DE,14
	LD HL,10
	CALL runtimePrintAt
	LD HL,1
	CALL runtimeLocalFlash
	LD HL,1
	CALL runtimeLocalInk
	LD HL,STRING_10	;PRESS A KEY
	CALL runtimePrintString
	LD HL,0
	CALL runtimeLocalFlash
	LD HL,3
	CALL runtimeLocalInk
	LD DE,21
	LD HL,8
	CALL runtimePrintAt
	LD HL,STRING_11	;By Animated ALex
	CALL runtimePrintString
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_715:
; 715  IF  INKEY$  <> "" OR  IN 31=16 THEN  CLS : GOTO 718
	LD HL,715
	LD (23621),HL
; 		715.1  IF  INKEY$  <> "" OR  IN 31{00 00 1f 00 00 }=16{00 00 10 00 00 } THEN  CLS 
	LD A,1
	LD (23623),a
	LD HL,715
	LD A,1
	CALL runtimeDebug
; INKEY$
	CALL runtimeInkey
	LD DE,HL
	LD HL,STRING_12	;
; <>
	CALL runtimeUnequalString
	PUSH HL
; IN
	LD HL,31
	LD BC,HL
	IN A,(C)
	LD L,A
	LD H,0
	LD DE,HL
	LD HL,16
; =
	CALL runtimeCmpHLEqDE
; OR
	POP DE
	call runtimeOrHLDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_17
; 		715.2  CLS 
	LD A,2
	LD (23623),a
	LD HL,715
	LD A,2
	CALL runtimeDebug
	CALL runtimeCls
; 		715.3  GOTO 718{00 00 ce 02 00 }
	LD A,3
	LD (23623),a
	LD HL,715
	LD A,3
	CALL runtimeDebug
	CALL runtimeCheckBreakDebug
	JP ZXBASIC_LINE_718
ZXB_LABEL_17:
ZXBASIC_LINE_717:
; 717  GOTO 715
	LD HL,717
	LD (23621),HL
; 		717.1  GOTO 715{00 00 cb 02 00 }
	LD A,1
	LD (23623),a
	LD HL,717
	LD A,1
	CALL runtimeDebug
	CALL runtimeCheckBreakDebug
	JP ZXBASIC_LINE_715
ZXBASIC_LINE_718:
; 718  PRINT  AT 20,0; BRIGHT 1; PAPER 2;,,
	LD HL,718
	LD (23621),HL
; 		718.1  PRINT  AT 20{00 00 14 00 00 },0{00 00 00 00 00 }; BRIGHT 1{00 00 01 00 00 }; PAPER 2{00 00 02 00 00 };,,
	LD A,1
	LD (23623),a
	LD HL,718
	LD A,1
	CALL runtimeDebug
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,20
	LD HL,0
	CALL runtimePrintAt
	LD HL,1
	CALL runtimeLocalBright
	LD HL,2
	CALL runtimeLocalPaper
	CALL runtimePrintTab
	CALL runtimePrintTab
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_720:
; 720  PRINT  AT 19,0; PAPER 0; INK 2; BRIGHT 0;"\149\150\151\155\149\150\155\154\155\149\150\153\149\155\153\154\153\152\154\152\151\155\149\153\155\155\149\150\149\152\153\154";
	LD HL,720
	LD (23621),HL
; 		720.1  PRINT  AT 19{00 00 13 00 00 },0{00 00 00 00 00 }; PAPER 0{00 00 00 00 00 }; INK 2{00 00 02 00 00 }; BRIGHT 0{00 00 00 00 00 };"\149\150\151\155\149\150\155\154\155\149\150\153\149\155\153\154\153\152\154\152\151\155\149\153\155\155\149\150\149\152\153\154";
	LD A,1
	LD (23623),a
	LD HL,720
	LD A,1
	CALL runtimeDebug
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,19
	LD HL,0
	CALL runtimePrintAt
	LD HL,0
	CALL runtimeLocalPaper
	LD HL,2
	CALL runtimeLocalInk
	LD HL,0
	CALL runtimeLocalBright
	LD HL,STRING_13	;\95\96\97\9b\95\96\9b\9a\9b\95\96\99\95\9b\99\9a\99\98\9a\98\97\9b\95\99\9b\9b\95\96\95\98\99\9a
	CALL runtimePrintString
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_725:
; 725  FOR d=1 TO 5: PLOT 0,d: DRAW  INK 4;255,0: NEXT d
	LD HL,725
	LD (23621),HL
; 		725.1  FOR d=1{00 00 01 00 00 } TO 5{00 00 05 00 00 }
	LD A,1
	LD (23623),a
	LD HL,725
	LD A,1
	CALL runtimeDebug
	CALL runtimeCheckBreakDebug
	LD HL,1
	CALL runtimeIntToFloat
	LD HL,ZXBASIC_VAR_d
	CALL runtimeStoreFloat
	LD HL,5
	CALL runtimeIntToFloat
	LD HL,ZXBASIC_VAR_for_d
	CALL runtimeStoreFloat
FOR_10:
; 		725.2  PLOT 0{00 00 00 00 00 },d
	LD A,2
	LD (23623),a
	LD HL,725
	LD A,2
	CALL runtimeDebug
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,0
	PUSH HL
	LD HL,ZXBASIC_VAR_d
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	POP DE
	CALL runtimePlot
	POP AF
	LD (ZX_P_FLAG),A
; 		725.3  DRAW  INK 4{00 00 04 00 00 };255{00 00 ff 00 00 },0{00 00 00 00 00 }
	LD A,3
	LD (23623),a
	LD HL,725
	LD A,3
	CALL runtimeDebug
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,4
	CALL runtimeLocalInk
	LD DE,255
	LD HL,0
	LD B,L
	LD C,E
	CALL runtimeDraw
	POP AF
	LD (ZX_P_FLAG),A
; 		725.4  NEXT d
	LD A,4
	LD (23623),a
	LD HL,725
	LD A,4
	CALL runtimeDebug
	CALL runtimeCheckBreakDebug
	LD HL,ZXBASIC_VAR_d
	CALL runtimePushFloatVar
	RST $28
	DB zxcalc_stack_one	;STACK ONE
	DB zxcalc_addition	;ADD
	DB zxcalc_end_calc	;END CALC
	LD HL,ZXBASIC_VAR_d
	CALL runtimeStoreFloat
	LD HL,ZXBASIC_VAR_for_d
	CALL runtimePushFloatVar
	LD HL,ZXBASIC_VAR_d
	CALL runtimePushFloatVar
	CALL runtimeSmallerFloat
	LD A,L
	CP 0
	JP Z,FOR_10
ZXBASIC_LINE_730:
; 730  PRINT  AT 21,0; INK 4; INVERSE 1;"SHIELD"
	LD HL,730
	LD (23621),HL
; 		730.1  PRINT  AT 21{00 00 15 00 00 },0{00 00 00 00 00 }; INK 4{00 00 04 00 00 }; INVERSE 1{00 00 01 00 00 };"SHIELD"
	LD A,1
	LD (23623),a
	LD HL,730
	LD A,1
	CALL runtimeDebug
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,21
	LD HL,0
	CALL runtimePrintAt
	LD HL,4
	CALL runtimeLocalInk
	LD HL,1
	CALL runtimeLocalInverse
	LD HL,STRING_6	;SHIELD
	CALL runtimePrintString
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_740:
; 740  REM ** VARIABLES **
	LD HL,740
	LD (23621),HL
	LD A,1
	LD (23623),a
	LD HL,740
	LD A,1
	CALL runtimeDebug
ZXBASIC_LINE_750:
; 750  LET iv=1: LET pp=1: LET p=7: LET p1=p: LET i=2: LET f=350: LET sc=0: LET y=16: LET x=10: LET z=x: LET a=2: LET b=0
	LD HL,750
	LD (23621),HL
; 		750.1  LET iv=1{00 00 01 00 00 }
	LD A,1
	LD (23623),a
	LD HL,750
	LD A,1
	CALL runtimeDebug
	LD HL,1
	LD (ZXBASIC_VAR_iv),HL
; 		750.2  LET pp=1{00 00 01 00 00 }
	LD A,2
	LD (23623),a
	LD HL,750
	LD A,2
	CALL runtimeDebug
	LD HL,1
	LD (ZXBASIC_VAR_pp),HL
; 		750.3  LET p=7{00 00 07 00 00 }
	LD A,3
	LD (23623),a
	LD HL,750
	LD A,3
	CALL runtimeDebug
	LD HL,7
	LD (ZXBASIC_VAR_p),HL
; 		750.4  LET p1=p
	LD A,4
	LD (23623),a
	LD HL,750
	LD A,4
	CALL runtimeDebug
	LD HL,(ZXBASIC_VAR_p)
	LD (ZXBASIC_VAR_p1),HL
; 		750.5  LET i=2{00 00 02 00 00 }
	LD A,5
	LD (23623),a
	LD HL,750
	LD A,5
	CALL runtimeDebug
	LD HL,2
	LD (ZXBASIC_VAR_i),HL
; 		750.6  LET f=350{00 00 5e 01 00 }
	LD A,6
	LD (23623),a
	LD HL,750
	LD A,6
	CALL runtimeDebug
	LD HL,350
	LD (ZXBASIC_VAR_f),HL
; 		750.7  LET sc=0{00 00 00 00 00 }
	LD A,7
	LD (23623),a
	LD HL,750
	LD A,7
	CALL runtimeDebug
	LD HL,0
	LD (ZXBASIC_VAR_sc),HL
; 		750.8  LET y=16{00 00 10 00 00 }
	LD A,8
	LD (23623),a
	LD HL,750
	LD A,8
	CALL runtimeDebug
	LD HL,16
	LD (ZXBASIC_VAR_y),HL
; 		750.9  LET x=10{00 00 0a 00 00 }
	LD A,9
	LD (23623),a
	LD HL,750
	LD A,9
	CALL runtimeDebug
	LD HL,10
	LD (ZXBASIC_VAR_x),HL
; 		750.10  LET z=x
	LD A,10
	LD (23623),a
	LD HL,750
	LD A,10
	CALL runtimeDebug
	LD HL,(ZXBASIC_VAR_x)
	LD (ZXBASIC_VAR_z),HL
; 		750.11  LET a=2{00 00 02 00 00 }
	LD A,11
	LD (23623),a
	LD HL,750
	LD A,11
	CALL runtimeDebug
	LD HL,2
	LD (ZXBASIC_VAR_a),HL
; 		750.12  LET b=0{00 00 00 00 00 }
	LD A,12
	LD (23623),a
	LD HL,750
	LD A,12
	CALL runtimeDebug
	LD HL,0
	LD (ZXBASIC_VAR_b),HL
ZXBASIC_LINE_760:
; 760  DIM a$(32): DIM d$(32): DIM e$(32)
	LD HL,760
	LD (23621),HL
; 		760.1  DIM a$(32{00 00 20 00 00 })
	LD A,1
	LD (23623),a
	LD HL,760
	LD A,1
	CALL runtimeDebug
	LD HL,ZXBASIC_VAR_a_string
	LD BC,33
	CALL runtimeClearStringArray
; 		760.2  DIM d$(32{00 00 20 00 00 })
	LD A,2
	LD (23623),a
	LD HL,760
	LD A,2
	CALL runtimeDebug
	LD HL,ZXBASIC_VAR_d_string
	LD BC,33
	CALL runtimeClearStringArray
; 		760.3  DIM e$(32{00 00 20 00 00 })
	LD A,3
	LD (23623),a
	LD HL,760
	LD A,3
	CALL runtimeDebug
	LD HL,ZXBASIC_VAR_e_string
	LD BC,33
	CALL runtimeClearStringArray
ZXBASIC_LINE_765:
; 765  PRINT  AT 20,0; BRIGHT 1; PAPER 2; INK 6;"SCORE:";sc; AT 20,15;"HI-SCORE:";hs
	LD HL,765
	LD (23621),HL
; 		765.1  PRINT  AT 20{00 00 14 00 00 },0{00 00 00 00 00 }; BRIGHT 1{00 00 01 00 00 }; PAPER 2{00 00 02 00 00 }; INK 6{00 00 06 00 00 };"SCORE
	LD A,1
	LD (23623),a
	LD HL,765
	LD A,1
	CALL runtimeDebug
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,20
	LD HL,0
	CALL runtimePrintAt
	LD HL,1
	CALL runtimeLocalBright
	LD HL,2
	CALL runtimeLocalPaper
	LD HL,6
	CALL runtimeLocalInk
	LD HL,STRING_14	;SCORE:
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_sc)
	CALL runtimePrintInt
	LD DE,20
	LD HL,15
	CALL runtimePrintAt
	LD HL,STRING_15	;HI-SCORE:
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_hs)
	CALL runtimePrintInt
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_770:
; 770  LET h=10
	LD HL,770
	LD (23621),HL
; 		770.1  LET h=10{00 00 0a 00 00 }
	LD A,1
	LD (23623),a
	LD HL,770
	LD A,1
	CALL runtimeDebug
	LD HL,10
	LD (ZXBASIC_VAR_h),HL
ZXBASIC_LINE_780:
; 780  LET a$=" \148   \148   \148   \148   \148   \148          " 
	LD HL,780
	LD (23621),HL
; 		780.1  LET a$=" \148   \148   \148   \148   \148   \148          " 
	LD A,1
	LD (23623),a
	LD HL,780
	LD A,1
	CALL runtimeDebug
	LD DE,ZXBASIC_VAR_a_string
	LD HL,STRING_16	; \94   \94   \94   \94   \94   \94          
	LD BC,32
	CALL runtimeStoreStringVarFix
ZXBASIC_LINE_790:
; 790  LET sh=0: LET ii=6: LET l=0
	LD HL,790
	LD (23621),HL
; 		790.1  LET sh=0{00 00 00 00 00 }
	LD A,1
	LD (23623),a
	LD HL,790
	LD A,1
	CALL runtimeDebug
	LD HL,0
	LD (ZXBASIC_VAR_sh),HL
; 		790.2  LET ii=6{00 00 06 00 00 }
	LD A,2
	LD (23623),a
	LD HL,790
	LD A,2
	CALL runtimeDebug
	LD HL,6
	LD (ZXBASIC_VAR_ii),HL
; 		790.3  LET l=0{00 00 00 00 00 }
	LD A,3
	LD (23623),a
	LD HL,790
	LD A,3
	CALL runtimeDebug
	LD HL,0
	LD (ZXBASIC_VAR_l),HL
ZXBASIC_LINE_795:
; 795  LET f$="\147\144\146"
	LD HL,795
	LD (23621),HL
; 		795.1  LET f$="\147\144\146"
	LD A,1
	LD (23623),a
	LD HL,795
	LD A,1
	CALL runtimeDebug
	LD DE,STRING_17	;\93\90\92
	LD HL,ZXBASIC_VAR_f_string
	CALL runtimeStoreString
ZXBASIC_LINE_800:
; 800  LET c$="\145": LET d$=" "
	LD HL,800
	LD (23621),HL
; 		800.1  LET c$="\145"
	LD A,1
	LD (23623),a
	LD HL,800
	LD A,1
	CALL runtimeDebug
	LD DE,STRING_18	;\91
	LD HL,ZXBASIC_VAR_c_string
	CALL runtimeStoreString
; 		800.2  LET d$=" "
	LD A,2
	LD (23623),a
	LD HL,800
	LD A,2
	CALL runtimeDebug
	LD DE,ZXBASIC_VAR_d_string
	LD HL,STRING_0	; 
	LD BC,32
	CALL runtimeStoreStringVarFix
ZXBASIC_LINE_805:
; 805  LET e$="    \144          \144         \144      "
	LD HL,805
	LD (23621),HL
; 		805.1  LET e$="    \144          \144         \144      "
	LD A,1
	LD (23623),a
	LD HL,805
	LD A,1
	CALL runtimeDebug
	LD DE,ZXBASIC_VAR_e_string
	LD HL,STRING_19	;    \90          \90         \90      
	LD BC,32
	CALL runtimeStoreStringVarFix
ZXBASIC_LINE_850:
; 850  RETURN 
	LD HL,850
	LD (23621),HL
; 		850.1  RETURN 
	LD A,1
	LD (23623),a
	LD HL,850
	LD A,1
	CALL runtimeDebug
	CALL runtimeCheckBreakDebug
	RET
ZXBASIC_LINE_900:
; 900  DATA 126,219,153,255,195,189,90,165
	LD HL,900
	LD (23621),HL
; 		900.1  DATA 126{00 00 7e 00 00 },219{00 00 db 00 00 },153{00 00 99 00 00 },255{00 00 ff 00 00 },195{00 00 c3 00 00 },189{00 00 bd 00 00 },90{00 00 5a 00 00 },165{00 00 a5 00 00 }
	LD A,1
	LD (23623),a
	LD HL,900
	LD A,1
	CALL runtimeDebug
ZXBASIC_LINE_910:
; 910  DATA 24,24,153,153,219,255,255,102
	LD HL,910
	LD (23621),HL
; 		910.1  DATA 24{00 00 18 00 00 },24{00 00 18 00 00 },153{00 00 99 00 00 },153{00 00 99 00 00 },219{00 00 db 00 00 },255{00 00 ff 00 00 },255{00 00 ff 00 00 },102{00 00 66 00 00 }
	LD A,1
	LD (23623),a
	LD HL,910
	LD A,1
	CALL runtimeDebug
ZXBASIC_LINE_920:
; 920  DATA 140,198,194,255,255,130,134,140
	LD HL,920
	LD (23621),HL
; 		920.1  DATA 140{00 00 8c 00 00 },198{00 00 c6 00 00 },194{00 00 c2 00 00 },255{00 00 ff 00 00 },255{00 00 ff 00 00 },130{00 00 82 00 00 },134{00 00 86 00 00 },140{00 00 8c 00 00 }
	LD A,1
	LD (23623),a
	LD HL,920
	LD A,1
	CALL runtimeDebug
ZXBASIC_LINE_930:
; 930  DATA 49,99,67,255,255,65,97,49
	LD HL,930
	LD (23621),HL
; 		930.1  DATA 49{00 00 31 00 00 },99{00 00 63 00 00 },67{00 00 43 00 00 },255{00 00 ff 00 00 },255{00 00 ff 00 00 },65{00 00 41 00 00 },97{00 00 61 00 00 },49{00 00 31 00 00 }
	LD A,1
	LD (23623),a
	LD HL,930
	LD A,1
	CALL runtimeDebug
ZXBASIC_LINE_950:
; 950  DATA 126,219,153,255,195,126,60,102
	LD HL,950
	LD (23621),HL
; 		950.1  DATA 126{00 00 7e 00 00 },219{00 00 db 00 00 },153{00 00 99 00 00 },255{00 00 ff 00 00 },195{00 00 c3 00 00 },126{00 00 7e 00 00 },60{00 00 3c 00 00 },102{00 00 66 00 00 }
	LD A,1
	LD (23623),a
	LD HL,950
	LD A,1
	CALL runtimeDebug
ZXBASIC_LINE_960:
; 960  DATA 0,0,1,7,15,59,119,223
	LD HL,960
	LD (23621),HL
; 		960.1  DATA 0{00 00 00 00 00 },0{00 00 00 00 00 },1{00 00 01 00 00 },7{00 00 07 00 00 },15{00 00 0f 00 00 },59{00 00 3b 00 00 },119{00 00 77 00 00 },223{00 00 df 00 00 }
	LD A,1
	LD (23623),a
	LD HL,960
	LD A,1
	CALL runtimeDebug
ZXBASIC_LINE_970:
; 970  DATA 0,0,128,224,252,255,239,251
	LD HL,970
	LD (23621),HL
; 		970.1  DATA 0{00 00 00 00 00 },0{00 00 00 00 00 },128{00 00 80 00 00 },224{00 00 e0 00 00 },252{00 00 fc 00 00 },255{00 00 ff 00 00 },239{00 00 ef 00 00 },251{00 00 fb 00 00 }
	LD A,1
	LD (23623),a
	LD HL,970
	LD A,1
	CALL runtimeDebug
ZXBASIC_LINE_980:
; 980  DATA 0,34,22,12,30,55,7,255
	LD HL,980
	LD (23621),HL
; 		980.1  DATA 0{00 00 00 00 00 },34{00 00 22 00 00 },22{00 00 16 00 00 },12{00 00 0c 00 00 },30{00 00 1e 00 00 },55{00 00 37 00 00 },7{00 00 07 00 00 },255{00 00 ff 00 00 }
	LD A,1
	LD (23623),a
	LD HL,980
	LD A,1
	CALL runtimeDebug
ZXBASIC_LINE_990:
; 990  DATA 0,0,128,224,120,236,222,255
	LD HL,990
	LD (23621),HL
; 		990.1  DATA 0{00 00 00 00 00 },0{00 00 00 00 00 },128{00 00 80 00 00 },224{00 00 e0 00 00 },120{00 00 78 00 00 },236{00 00 ec 00 00 },222{00 00 de 00 00 },255{00 00 ff 00 00 }
	LD A,1
	LD (23623),a
	LD HL,990
	LD A,1
	CALL runtimeDebug
ZXBASIC_LINE_1000:
; 1000  DATA 60,60,102,255,211,255,153,255
	LD HL,1000
	LD (23621),HL
; 		1000.1  DATA 60{00 00 3c 00 00 },60{00 00 3c 00 00 },102{00 00 66 00 00 },255{00 00 ff 00 00 },211{00 00 d3 00 00 },255{00 00 ff 00 00 },153{00 00 99 00 00 },255{00 00 ff 00 00 }
	LD A,1
	LD (23623),a
	LD HL,1000
	LD A,1
	CALL runtimeDebug
ZXBASIC_LINE_1010:
; 1010  DATA 8,8,12,255,247,255,187,255
	LD HL,1010
	LD (23621),HL
; 		1010.1  DATA 8{00 00 08 00 00 },8{00 00 08 00 00 },12{00 00 0c 00 00 },255{00 00 ff 00 00 },247{00 00 f7 00 00 },255{00 00 ff 00 00 },187{00 00 bb 00 00 },255{00 00 ff 00 00 }
	LD A,1
	LD (23623),a
	LD HL,1010
	LD A,1
	CALL runtimeDebug
ZXBASIC_LINE_1020:
; 1020  DATA 4,4,4,132,236,254,183,255
	LD HL,1020
	LD (23621),HL
; 		1020.1  DATA 4{00 00 04 00 00 },4{00 00 04 00 00 },4{00 00 04 00 00 },132{00 00 84 00 00 },236{00 00 ec 00 00 },254{00 00 fe 00 00 },183{00 00 b7 00 00 },255{00 00 ff 00 00 }
	LD A,1
	LD (23623),a
	LD HL,1020
	LD A,1
	CALL runtimeDebug
ZXBASIC_LINE_1030:
; 1030  REM END OF PROGRAM
	LD HL,1030
	LD (23621),HL
	LD A,1
	LD (23623),a
	LD HL,1030
	LD A,1
	CALL runtimeDebug
ZXBASIC_LINE_1040:
; 1040  RETURN 
	LD HL,1040
	LD (23621),HL
; 		1040.1  RETURN 
	LD A,1
	LD (23623),a
	LD HL,1040
	LD A,1
	CALL runtimeDebug
	CALL runtimeCheckBreakDebug
	RET
ZXBASIC_LINE_9000:
; 9000  PRINT  PAPER 7; INK 0; AT 1,0;"a$=(";a$;")"
	LD HL,9000
	LD (23621),HL
; 		9000.1  PRINT  PAPER 7{00 00 07 00 00 }; INK 0{00 00 00 00 00 }; AT 1{00 00 01 00 00 },0{00 00 00 00 00 };"a$=(";a$;")"
	LD A,1
	LD (23623),a
	LD HL,9000
	LD A,1
	CALL runtimeDebug
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,7
	CALL runtimeLocalPaper
	LD HL,0
	CALL runtimeLocalInk
	LD DE,1
	LD HL,0
	CALL runtimePrintAt
	LD HL,STRING_20	;a$=(
	CALL runtimePrintString
	LD HL,ZXBASIC_VAR_a_string
	LD BC,32
	CALL runtimePrintFixString
	LD HL,STRING_21	;)
	CALL runtimePrintString
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_9010:
; 9010  PRINT  PAPER 7; INK 0;"e$=(";e$;")"
	LD HL,9010
	LD (23621),HL
; 		9010.1  PRINT  PAPER 7{00 00 07 00 00 }; INK 0{00 00 00 00 00 };"e$=(";e$;")"
	LD A,1
	LD (23623),a
	LD HL,9010
	LD A,1
	CALL runtimeDebug
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,7
	CALL runtimeLocalPaper
	LD HL,0
	CALL runtimeLocalInk
	LD HL,STRING_22	;e$=(
	CALL runtimePrintString
	LD HL,ZXBASIC_VAR_e_string
	LD BC,32
	CALL runtimePrintFixString
	LD HL,STRING_21	;)
	CALL runtimePrintString
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_9020:
; 9020  PRINT  PAPER 7; INK 0;"l=";l;" h=";h;" a=";a
	LD HL,9020
	LD (23621),HL
; 		9020.1  PRINT  PAPER 7{00 00 07 00 00 }; INK 0{00 00 00 00 00 };"l=";l;" h=";h;" a=";a
	LD A,1
	LD (23623),a
	LD HL,9020
	LD A,1
	CALL runtimeDebug
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,7
	CALL runtimeLocalPaper
	LD HL,0
	CALL runtimeLocalInk
	LD HL,STRING_23	;l=
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_l)
	CALL runtimePrintInt
	LD HL,STRING_24	; h=
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_h)
	CALL runtimePrintInt
	LD HL,STRING_25	; a=
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_a)
	CALL runtimePrintInt
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_9500:
; 9500  RETURN 
	LD HL,9500
	LD (23621),HL
; 		9500.1  RETURN 
	LD A,1
	LD (23623),a
	LD HL,9500
	LD A,1
	CALL runtimeDebug
	CALL runtimeCheckBreakDebug
	RET
ZXBASIC_LINE_9998:
; 9998  STOP 
	LD HL,9998
	LD (23621),HL
ZXBASIC_VAR_a:	dw 0
ZXBASIC_VAR_a_string:	defs 66
ZXBASIC_VAR_b:	dw 0
ZXBASIC_VAR_c:	dw 0
ZXBASIC_VAR_c_string:	dw 0
ZXBASIC_VAR_d:	defs 5
ZXBASIC_VAR_d_string:	defs 66
ZXBASIC_VAR_dat:	dw 0
ZXBASIC_VAR_e_string:	defs 66
ZXBASIC_VAR_f:	dw 0
ZXBASIC_VAR_f_string:	dw 0
ZXBASIC_VAR_for_a:	dw 0
ZXBASIC_VAR_for_c:	dw 0
ZXBASIC_VAR_for_d:	defs 5
ZXBASIC_VAR_for_g:	dw 0
ZXBASIC_VAR_for_o:	defs 5
ZXBASIC_VAR_for_t:	dw 0
ZXBASIC_VAR_for_u:	dw 0
ZXBASIC_VAR_for_w:	dw 0
ZXBASIC_VAR_g:	dw 0
ZXBASIC_VAR_h:	dw 0
ZXBASIC_VAR_hs:	dw 0
ZXBASIC_VAR_i:	dw 0
ZXBASIC_VAR_ii:	dw 0
ZXBASIC_VAR_iv:	dw 0
ZXBASIC_VAR_j:	dw 0
ZXBASIC_VAR_k:	dw 0
ZXBASIC_VAR_l:	dw 0
ZXBASIC_VAR_o:	defs 5
ZXBASIC_VAR_p:	dw 0
ZXBASIC_VAR_p1:	dw 0
ZXBASIC_VAR_pp:	dw 0
ZXBASIC_VAR_sc:	dw 0
ZXBASIC_VAR_sh:	dw 0
ZXBASIC_VAR_sp:	dw 0
ZXBASIC_VAR_t:	dw 0
ZXBASIC_VAR_u:	dw 0
ZXBASIC_VAR_w:	dw 0
ZXBASIC_VAR_x:	dw 0
ZXBASIC_VAR_y:	dw 0
ZXBASIC_VAR_z:	dw 0
FLOAT_1:	db $7c, $4c, $cc, $cc, $cc	;0.05
FLOAT_10:	db $00, $00, $0a, $00, $00	;10.0
FLOAT_11:	db $7b, $4c, $cc, $cc, $cc	;0.025
FLOAT_12:	db $00, $00, $1e, $00, $00	;30.0
FLOAT_13:	db $7a, $75, $c2, $8f, $5c	;0.015
FLOAT_2:	db $00, $00, $14, $00, $00	;20.0
FLOAT_3:	db $80, $39, $99, $99, $99	;0.725
FLOAT_4:	db $78, $03, $12, $6e, $97	;0.002
FLOAT_5:	db $7b, $23, $d7, $0a, $3d	;0.02
FLOAT_6:	db $7e, $4c, $cc, $cc, $cc	;0.2
FLOAT_7:	db $7a, $23, $d7, $0a, $3d	;0.01
FLOAT_8:	db $79, $03, $12, $6e, $97	;0.004
FLOAT_9:	db $7b, $75, $c2, $8f, $5c	;0.03
STRING_0:	dw 1
	db	" "
STRING_1:	dw 3
	db	"   "
STRING_10:	dw 11
	db	"PRESS A KEY"
STRING_11:	dw 16
	db	"By Animated ALex"
STRING_12:	dw 0
STRING_13:	dw 32
	db	$95, $96, $97, $9b, $95, $96, $9b, $9a, $9b, $95, $96, $99, $95, $9b, $99, $9a, $99, $98, $9a, $98, $97, $9b, $95, $99, $9b, $9b, $95, $96, $95, $98, $99, $9a
STRING_14:	dw 6
	db	"SCORE:"
STRING_15:	dw 9
	db	"HI-SCORE:"
STRING_16:	dw 32
	db	" ", $94, "   ", $94, "   ", $94, "   ", $94, "   ", $94, "   ", $94, "          "
STRING_17:	dw 3
	db	$93, $90, $92
STRING_18:	dw 1
	db	$91
STRING_19:	dw 32
	db	"    ", $90, "          ", $90, "         ", $90, "      "
STRING_2:	dw 1
	db	$94
STRING_20:	dw 4
	db	"a$=("
STRING_21:	dw 1
	db	")"
STRING_22:	dw 4
	db	"e$=("
STRING_23:	dw 2
	db	"l="
STRING_24:	dw 3
	db	" h="
STRING_25:	dw 3
	db	" a="
STRING_3:	dw 1
	db	$90
STRING_4:	dw 2
	db	"L="
STRING_5:	dw 16
	db	"G A M E  O V E R"
STRING_6:	dw 6
	db	"SHIELD"
STRING_7:	dw 1
	db	"a"
STRING_8:	dw 174
	db	$8f, $8f, $8f, $8f, "   ", $8f, $8f, "   ", $8f, $8f, $8f, $8f, "                   ", $8f, "  ", $8f, "  ", $8f, "  ", $8f, "   ", $8f, "                 ", $8f, "   ", $8f, "  ", $8f, "  ", $8f, "   ", $8f, "                ", $8f, "    ", $8f
	db $8f, $8f, $8f, "  ", $8f, $8f, $8f, $8f, "                ", $8f, "     ", $8f, "  ", $8f, "  ", $8f, "                   ", $8f, $8f, $8f, $8f, "  ", $8f, "  ", $8f, "  ", $8f, " "
STRING_9:	dw 24
	db	"KEYS:O,P & M or KEMPSTON"
ZXLINES:
	dw 10, ZXBASIC_LINE_10
	dw 20, ZXBASIC_LINE_20
	dw 30, ZXBASIC_LINE_30
	dw 40, ZXBASIC_LINE_40
	dw 50, ZXBASIC_LINE_50
	dw 170, ZXBASIC_LINE_170
	dw 180, ZXBASIC_LINE_180
	dw 185, ZXBASIC_LINE_185
	dw 190, ZXBASIC_LINE_190
	dw 200, ZXBASIC_LINE_200
	dw 202, ZXBASIC_LINE_202
	dw 203, ZXBASIC_LINE_203
	dw 205, ZXBASIC_LINE_205
	dw 210, ZXBASIC_LINE_210
	dw 230, ZXBASIC_LINE_230
	dw 240, ZXBASIC_LINE_240
	dw 250, ZXBASIC_LINE_250
	dw 260, ZXBASIC_LINE_260
	dw 265, ZXBASIC_LINE_265
	dw 270, ZXBASIC_LINE_270
	dw 280, ZXBASIC_LINE_280
	dw 290, ZXBASIC_LINE_290
	dw 300, ZXBASIC_LINE_300
	dw 310, ZXBASIC_LINE_310
	dw 320, ZXBASIC_LINE_320
	dw 330, ZXBASIC_LINE_330
	dw 348, ZXBASIC_LINE_348
	dw 350, ZXBASIC_LINE_350
	dw 360, ZXBASIC_LINE_360
	dw 365, ZXBASIC_LINE_365
	dw 366, ZXBASIC_LINE_366
	dw 370, ZXBASIC_LINE_370
	dw 375, ZXBASIC_LINE_375
	dw 380, ZXBASIC_LINE_380
	dw 385, ZXBASIC_LINE_385
	dw 390, ZXBASIC_LINE_390
	dw 400, ZXBASIC_LINE_400
	dw 405, ZXBASIC_LINE_405
	dw 410, ZXBASIC_LINE_410
	dw 420, ZXBASIC_LINE_420
	dw 430, ZXBASIC_LINE_430
	dw 440, ZXBASIC_LINE_440
	dw 450, ZXBASIC_LINE_450
	dw 455, ZXBASIC_LINE_455
	dw 470, ZXBASIC_LINE_470
	dw 480, ZXBASIC_LINE_480
	dw 490, ZXBASIC_LINE_490
	dw 495, ZXBASIC_LINE_495
	dw 500, ZXBASIC_LINE_500
	dw 510, ZXBASIC_LINE_510
	dw 520, ZXBASIC_LINE_520
	dw 530, ZXBASIC_LINE_530
	dw 540, ZXBASIC_LINE_540
	dw 550, ZXBASIC_LINE_550
	dw 560, ZXBASIC_LINE_560
	dw 570, ZXBASIC_LINE_570
	dw 580, ZXBASIC_LINE_580
	dw 590, ZXBASIC_LINE_590
	dw 600, ZXBASIC_LINE_600
	dw 700, ZXBASIC_LINE_700
	dw 705, ZXBASIC_LINE_705
	dw 710, ZXBASIC_LINE_710
	dw 715, ZXBASIC_LINE_715
	dw 717, ZXBASIC_LINE_717
	dw 718, ZXBASIC_LINE_718
	dw 720, ZXBASIC_LINE_720
	dw 725, ZXBASIC_LINE_725
	dw 730, ZXBASIC_LINE_730
	dw 740, ZXBASIC_LINE_740
	dw 750, ZXBASIC_LINE_750
	dw 760, ZXBASIC_LINE_760
	dw 765, ZXBASIC_LINE_765
	dw 770, ZXBASIC_LINE_770
	dw 780, ZXBASIC_LINE_780
	dw 790, ZXBASIC_LINE_790
	dw 795, ZXBASIC_LINE_795
	dw 800, ZXBASIC_LINE_800
	dw 805, ZXBASIC_LINE_805
	dw 850, ZXBASIC_LINE_850
	dw 900, ZXBASIC_LINE_900
	dw 910, ZXBASIC_LINE_910
	dw 920, ZXBASIC_LINE_920
	dw 930, ZXBASIC_LINE_930
	dw 950, ZXBASIC_LINE_950
	dw 960, ZXBASIC_LINE_960
	dw 970, ZXBASIC_LINE_970
	dw 980, ZXBASIC_LINE_980
	dw 990, ZXBASIC_LINE_990
	dw 1000, ZXBASIC_LINE_1000
	dw 1010, ZXBASIC_LINE_1010
	dw 1020, ZXBASIC_LINE_1020
	dw 1030, ZXBASIC_LINE_1030
	dw 1040, ZXBASIC_LINE_1040
	dw 9000, ZXBASIC_LINE_9000
	dw 9010, ZXBASIC_LINE_9010
	dw 9020, ZXBASIC_LINE_9020
	dw 9500, ZXBASIC_LINE_9500
	dw 9998, ZXBASIC_LINE_9998
	dw 0, 0
DATAPTR:	DW 0
DATA_900:
	dw 126
	dw 219
	dw 153
	dw 255
	dw 195
	dw 189
	dw 90
	dw 165
DATA_910:
	dw 24
	dw 24
	dw 153
	dw 153
	dw 219
	dw 255
	dw 255
	dw 102
DATA_920:
	dw 140
	dw 198
	dw 194
	dw 255
	dw 255
	dw 130
	dw 134
	dw 140
DATA_930:
	dw 49
	dw 99
	dw 67
	dw 255
	dw 255
	dw 65
	dw 97
	dw 49
DATA_950:
	dw 126
	dw 219
	dw 153
	dw 255
	dw 195
	dw 126
	dw 60
	dw 102
DATA_960:
	dw 0
	dw 0
	dw 1
	dw 7
	dw 15
	dw 59
	dw 119
	dw 223
DATA_970:
	dw 0
	dw 0
	dw 128
	dw 224
	dw 252
	dw 255
	dw 239
	dw 251
DATA_980:
	dw 0
	dw 34
	dw 22
	dw 12
	dw 30
	dw 55
	dw 7
	dw 255
DATA_990:
	dw 0
	dw 0
	dw 128
	dw 224
	dw 120
	dw 236
	dw 222
	dw 255
DATA_1000:
	dw 60
	dw 60
	dw 102
	dw 255
	dw 211
	dw 255
	dw 153
	dw 255
DATA_1010:
	dw 8
	dw 8
	dw 12
	dw 255
	dw 247
	dw 255
	dw 187
	dw 255
DATA_1020:
	dw 4
	dw 4
	dw 4
	dw 132
	dw 236
	dw 254
	dw 183
	dw 255

ZX_VARIABLES:
	db 1,"a",1,0
	dw ZXBASIC_VAR_a
	db 2,"a$",3,1,32
	dw ZXBASIC_VAR_a_string
	db 1,"b",1,0
	dw ZXBASIC_VAR_b
	db 1,"c",1,0
	dw ZXBASIC_VAR_c
	db 2,"c$",3,0
	dw ZXBASIC_VAR_c_string
	db 1,"d",2,0
	dw ZXBASIC_VAR_d
	db 2,"d$",3,1,32
	dw ZXBASIC_VAR_d_string
	db 3,"dat",1,0
	dw ZXBASIC_VAR_dat
	db 2,"e$",3,1,32
	dw ZXBASIC_VAR_e_string
	db 1,"f",1,0
	dw ZXBASIC_VAR_f
	db 2,"f$",3,0
	dw ZXBASIC_VAR_f_string
	db 5,"for_a",1,0
	dw ZXBASIC_VAR_for_a
	db 5,"for_c",1,0
	dw ZXBASIC_VAR_for_c
	db 5,"for_d",2,0
	dw ZXBASIC_VAR_for_d
	db 5,"for_g",1,0
	dw ZXBASIC_VAR_for_g
	db 5,"for_o",2,0
	dw ZXBASIC_VAR_for_o
	db 5,"for_t",1,0
	dw ZXBASIC_VAR_for_t
	db 5,"for_u",1,0
	dw ZXBASIC_VAR_for_u
	db 5,"for_w",1,0
	dw ZXBASIC_VAR_for_w
	db 1,"g",1,0
	dw ZXBASIC_VAR_g
	db 1,"h",1,0
	dw ZXBASIC_VAR_h
	db 2,"hs",1,0
	dw ZXBASIC_VAR_hs
	db 1,"i",1,0
	dw ZXBASIC_VAR_i
	db 2,"ii",1,0
	dw ZXBASIC_VAR_ii
	db 2,"iv",1,0
	dw ZXBASIC_VAR_iv
	db 1,"j",1,0
	dw ZXBASIC_VAR_j
	db 1,"k",1,0
	dw ZXBASIC_VAR_k
	db 1,"l",1,0
	dw ZXBASIC_VAR_l
	db 1,"o",2,0
	dw ZXBASIC_VAR_o
	db 1,"p",1,0
	dw ZXBASIC_VAR_p
	db 2,"p1",1,0
	dw ZXBASIC_VAR_p1
	db 2,"pp",1,0
	dw ZXBASIC_VAR_pp
	db 2,"sc",1,0
	dw ZXBASIC_VAR_sc
	db 2,"sh",1,0
	dw ZXBASIC_VAR_sh
	db 2,"sp",1,0
	dw ZXBASIC_VAR_sp
	db 1,"t",1,0
	dw ZXBASIC_VAR_t
	db 1,"u",1,0
	dw ZXBASIC_VAR_u
	db 1,"w",1,0
	dw ZXBASIC_VAR_w
	db 1,"x",1,0
	dw ZXBASIC_VAR_x
	db 1,"y",1,0
	dw ZXBASIC_VAR_y
	db 1,"z",1,0
	dw ZXBASIC_VAR_z
	db 0

    DISPLAY "Compiled Basic = ", /D, $-CBASIC_START,  " bytes"
