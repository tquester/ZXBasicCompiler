
CBASIC_START
compiledBasic:
	call ZXHeapClear
	LD (runtimeSaveSP),SP
	LD HL,DATA_1460
	LD (DATAPTR),HL
ZXBASIC_LINE_1:
; 1  REM ** SLOW MANIC WILLY **
	LD HL,1
	LD (23621),HL
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
ZXBASIC_LINE_2:
; 2  REM  * by Animated ALex *
	LD HL,2
	LD (23621),HL
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
ZXBASIC_LINE_3:
; 3  REM MUSIC - Damien Redmond
	LD HL,3
	LD (23621),HL
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
ZXBASIC_LINE_4:
; 4  REM * LINE 1880 48k only *
	LD HL,4
	LD (23621),HL
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
ZXBASIC_LINE_5:
; 5  REM 
	LD HL,5
	LD (23621),HL
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
ZXBASIC_LINE_10:
; 10  PAPER 0: CLS : PAPER 0: INK 7: BORDER 2
	LD HL,10
	LD (23621),HL
; 		10.1  PAPER 0{00 00 00 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,0
	CALL runtimePaper
; 		10.2  CLS 
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	CALL runtimeCls
; 		10.3  PAPER 0{00 00 00 00 00 }
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,0
	CALL runtimePaper
; 		10.4  INK 7{00 00 07 00 00 }
	LD A,4
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,7
	CALL runtimeInk
; 		10.5  BORDER 2{00 00 02 00 00 }
	LD A,5
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,2
	LD A,L
	call $2297
ZXBASIC_LINE_20:
; 20  LET win=0
	LD HL,20
	LD (23621),HL
; 		20.1  LET win=0{00 00 00 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,0
	LD (ZXBASIC_VAR_win),HL
ZXBASIC_LINE_30:
; 30  RESTORE 1460
	LD HL,30
	LD (23621),HL
; 		30.1  RESTORE 1460{00 00 b4 05 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD DE,1460
	LD HL,ZXDATA
	CALL runtimeFindLine
	EX HL,DE
	LD (DATAPTR),DE
ZXBASIC_LINE_50:
; 50  GOSUB 1420
	LD HL,50
	LD (23621),HL
; 		50.1  GOSUB 1420{00 00 8c 05 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_1420
ZXBASIC_LINE_60:
; 60  GOSUB 1810
	LD HL,60
	LD (23621),HL
; 		60.1  GOSUB 1810{00 00 12 07 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_1810
ZXBASIC_LINE_70:
; 70  GOSUB 840
	LD HL,70
	LD (23621),HL
; 		70.1  GOSUB 840{00 00 48 03 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_840
ZXBASIC_LINE_80:
; 80  GOSUB 1100
	LD HL,80
	LD (23621),HL
; 		80.1  GOSUB 1100{00 00 4c 04 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_1100
ZXBASIC_LINE_90:
; 90  REM **** GAME LOOP ****
	LD HL,90
	LD (23621),HL
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
ZXBASIC_LINE_100:
; 100  PAUSE 5: LET g= IN 64510: LET i= IN 57342
	LD HL,100
	LD (23621),HL
; 		100.1  PAUSE 5{00 00 05 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,5
	CALL runtimePause
; 		100.2  LET g= IN 64510{00 00 fe fb 00 }
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
; IN
	LD HL,64510
	LD BC,HL
	IN A,(C)
	LD L,A
	LD H,0
	LD (ZXBASIC_VAR_g),HL
; 		100.3  LET i= IN 57342{00 00 fe df 00 }
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
; IN
	LD HL,57342
	LD BC,HL
	IN A,(C)
	LD L,A
	LD H,0
	LD (ZXBASIC_VAR_i),HL
ZXBASIC_LINE_101:
; 101  IF  IN 64510=190 THEN  LET j=1: LET jj=3: LET f=0: GOSUB 815
	LD HL,101
	LD (23621),HL
; 		101.1  IF  IN 64510{00 00 fe fb 00 }=190{00 00 be 00 00 } THEN  LET j=1{00 00 01 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
; IN
	LD HL,64510
	LD BC,HL
	IN A,(C)
	LD L,A
	LD H,0
	LD DE,HL
	LD HL,190
; =
	CALL runtimeCmpHLEqDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_1
; 		101.2  LET j=1{00 00 01 00 00 }
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,1
	LD (ZXBASIC_VAR_j),HL
; 		101.3  LET jj=3{00 00 03 00 00 }
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,3
	LD (ZXBASIC_VAR_jj),HL
; 		101.4  LET f=0{00 00 00 00 00 }
	LD A,4
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,0
	LD (ZXBASIC_VAR_f),HL
; 		101.5  GOSUB 815{00 00 2f 03 00 }
	LD A,5
	LD (23623),a
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_815
ZXB_LABEL_1:
ZXBASIC_LINE_102:
; 102  IF i=190 AND x<30 THEN  LET x=x+1: LET fl=2: LET fr=2: LET fg=1: LET wk=wk+1
	LD HL,102
	LD (23621),HL
; 		102.1  IF i=190{00 00 be 00 00 } AND x<30{00 00 1e 00 00 } THEN  LET x=x+1{00 00 01 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD DE,(ZXBASIC_VAR_i)
	LD HL,190
; =
	CALL runtimeCmpHLEqDE
	PUSH HL
	LD DE,(ZXBASIC_VAR_x)
	LD HL,30
; <
	CALL runtimeCmpHLltDE
; AND
	POP DE
	call runtimeAndHLDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_2
; 		102.2  LET x=x+1{00 00 01 00 00 }
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,(ZXBASIC_VAR_x)
	INC HL
; +
	LD (ZXBASIC_VAR_x),HL
; 		102.3  LET fl=2{00 00 02 00 00 }
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,2
	LD (ZXBASIC_VAR_fl),HL
; 		102.4  LET fr=2{00 00 02 00 00 }
	LD A,4
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,2
	LD (ZXBASIC_VAR_fr),HL
; 		102.5  LET fg=1{00 00 01 00 00 }
	LD A,5
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,1
	LD (ZXBASIC_VAR_fg),HL
; 		102.6  LET wk=wk+1{00 00 01 00 00 }
	LD A,6
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,(ZXBASIC_VAR_wk)
	INC HL
; +
	LD (ZXBASIC_VAR_wk),HL
ZXB_LABEL_2:
ZXBASIC_LINE_103:
; 103  IF i=189 AND x>1 THEN  LET x=x-1: LET fl=1: LET fr=1: LET fg=2: LET wk=wk+1
	LD HL,103
	LD (23621),HL
; 		103.1  IF i=189{00 00 bd 00 00 } AND x>1{00 00 01 00 00 } THEN  LET x=x-1{00 00 01 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD DE,(ZXBASIC_VAR_i)
	LD HL,189
; =
	CALL runtimeCmpHLEqDE
	PUSH HL
	LD DE,(ZXBASIC_VAR_x)
	LD HL,1
; >
	CALL runtimeCmpHlGtDE
; AND
	POP DE
	call runtimeAndHLDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_3
; 		103.2  LET x=x-1{00 00 01 00 00 }
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,(ZXBASIC_VAR_x)
	DEC HL
; -
	LD (ZXBASIC_VAR_x),HL
; 		103.3  LET fl=1{00 00 01 00 00 }
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,1
	LD (ZXBASIC_VAR_fl),HL
; 		103.4  LET fr=1{00 00 01 00 00 }
	LD A,4
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,1
	LD (ZXBASIC_VAR_fr),HL
; 		103.5  LET fg=2{00 00 02 00 00 }
	LD A,5
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,2
	LD (ZXBASIC_VAR_fg),HL
; 		103.6  LET wk=wk+1{00 00 01 00 00 }
	LD A,6
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,(ZXBASIC_VAR_wk)
	INC HL
; +
	LD (ZXBASIC_VAR_wk),HL
ZXB_LABEL_3:
ZXBASIC_LINE_110:
; 110  IF hf=11 THEN  GOSUB 822
	LD HL,110
	LD (23621),HL
; 		110.1  IF hf=11{00 00 0b 00 00 } THEN  GOSUB 822{00 00 36 03 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD DE,(ZXBASIC_VAR_hf)
	LD HL,11
; =
	CALL runtimeCmpHLEqDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_4
; 		110.2  GOSUB 822{00 00 36 03 00 }
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_822
ZXB_LABEL_4:
ZXBASIC_LINE_112:
; 112  IF hf <= 10 THEN  IF  ATTR (oy+1,ox-1)=5 THEN  LET hf=hf+15: PRINT  AT oy+1,ox-1;" ": FOR o=30 TO 45: BEEP .03,o: NEXT o: LET ae=0: PRINT  AT 21,9; PAPER 0;"            ": GOSUB 825
	LD HL,112
	LD (23621),HL
; 		112.1  IF hf <= 10{00 00 0a 00 00 } THEN  IF  ATTR (oy+1{00 00 01 00 00 },ox-1{00 00 01 00 00 })=5{00 00 05 00 00 } THEN  LET hf=hf+15{00 00 0f 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD DE,(ZXBASIC_VAR_hf)
	LD HL,10
; <=
	CALL runtimeCmpHLLeDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_5
; 		112.2  IF  ATTR (oy+1{00 00 01 00 00 },ox-1{00 00 01 00 00 })=5{00 00 05 00 00 } THEN  LET hf=hf+15{00 00 0f 00 00 }
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
; ATTR
	LD DE,(ZXBASIC_VAR_oy)
	LD HL,1
; +
	ADD HL,DE
	PUSH HL
	LD HL,(ZXBASIC_VAR_ox)
	LD DE,1
; -
	SUB HL,DE
	POP DE
	CALL runtimeAttr
	LD DE,HL
	LD HL,5
; =
	CALL runtimeCmpHLEqDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_6
; 		112.3  LET hf=hf+15{00 00 0f 00 00 }
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
	LD DE,(ZXBASIC_VAR_hf)
	LD HL,15
; +
	ADD HL,DE
	LD (ZXBASIC_VAR_hf),HL
; 		112.4  PRINT  AT oy+1{00 00 01 00 00 },ox-1{00 00 01 00 00 };" "
	LD A,4
	LD (23623),a
	CALL runtimeCheckBreak
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,(ZXBASIC_VAR_oy)
	LD HL,1
; +
	ADD HL,DE
	PUSH HL
	LD HL,(ZXBASIC_VAR_ox)
	LD DE,1
; -
	SUB HL,DE
	POP DE
	CALL runtimePrintAt
	LD HL,STRING_0	; 
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
; 		112.5  FOR o=30{00 00 1e 00 00 } TO 45{00 00 2d 00 00 }
	LD A,5
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,30
	LD (ZXBASIC_VAR_o),HL
	LD HL,45
	LD (ZXBASIC_VAR_for_o),HL
FOR_0:
; 		112.6  BEEP .03{7b 75 c2 8f 5c },o
	LD A,6
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,FLOAT_1	;.03
	CALL runtimePushFloatVar
	LD HL,(ZXBASIC_VAR_o)
	CALL runtimeIntToFloat
	CALL $03F8
; 		112.7  NEXT o
	LD A,7
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,(ZXBASIC_VAR_o)
	INC HL
	LD (ZXBASIC_VAR_o),HL
	LD DE,(ZXBASIC_VAR_for_o)
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_0
; 		112.8  LET ae=0{00 00 00 00 00 }
	LD A,8
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,0
	LD (ZXBASIC_VAR_ae),HL
; 		112.9  PRINT  AT 21{00 00 15 00 00 },9{00 00 09 00 00 }; PAPER 0{00 00 00 00 00 };"            "
	LD A,9
	LD (23623),a
	CALL runtimeCheckBreak
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,21
	LD HL,9
	CALL runtimePrintAt
	LD HL,0
	CALL runtimeLocalPaper
	LD HL,STRING_1	;            
	CALL runtimePrintString
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
; 		112.10  GOSUB 825{00 00 39 03 00 }
	LD A,10
	LD (23623),a
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_825
ZXB_LABEL_6:
ZXB_LABEL_5:
ZXBASIC_LINE_115:
; 115  GOSUB n
	LD HL,115
	LD (23621),HL
; 		115.1  GOSUB n
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD DE,(ZXBASIC_VAR_n)
	LD HL,ZXLINES
	CALL runtimeFindLine
	CALL runtimeVarCall
ZXBASIC_LINE_150:
; 150  IF  ATTR (y+2,x)=7 THEN  LET y=y+0.925: LET j=0: LET f=f+1
	LD HL,150
	LD (23621),HL
; 		150.1  IF  ATTR (y+2{00 00 02 00 00 },x)=7{00 00 07 00 00 } THEN  LET y=y+0.925{80 6c cc cc cc }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
; ATTR
	LD DE,(ZXBASIC_VAR_y)
	LD HL,2
; +
	ADD HL,DE
	LD DE,HL
	LD HL,(ZXBASIC_VAR_x)
	CALL runtimeAttr
	LD DE,HL
	LD HL,7
; =
	CALL runtimeCmpHLEqDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_7
; 		150.2  LET y=y+0.925{80 6c cc cc cc }
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,(ZXBASIC_VAR_y)
	PUSH HL
	LD HL,FLOAT_2	;0.925
	CALL runtimePushFloatVar
; +
	POP HL
	CALL runtimeIntToFloat
	CALL runtimePlusFloat
	CALL runtimeFloatToInt
	LD (ZXBASIC_VAR_y),HL
; 		150.3  LET j=0{00 00 00 00 00 }
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,0
	LD (ZXBASIC_VAR_j),HL
; 		150.4  LET f=f+1{00 00 01 00 00 }
	LD A,4
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,(ZXBASIC_VAR_f)
	INC HL
; +
	LD (ZXBASIC_VAR_f),HL
ZXB_LABEL_7:
ZXBASIC_LINE_160:
; 160  LET j=0
	LD HL,160
	LD (23621),HL
; 		160.1  LET j=0{00 00 00 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,0
	LD (ZXBASIC_VAR_j),HL
ZXBASIC_LINE_190:
; 190  IF  ATTR (oy+2,ox)=32 THEN  GOSUB l
	LD HL,190
	LD (23621),HL
; 		190.1  IF  ATTR (oy+2{00 00 02 00 00 },ox)=32{00 00 20 00 00 } THEN  GOSUB l
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
; ATTR
	LD DE,(ZXBASIC_VAR_oy)
	LD HL,2
; +
	ADD HL,DE
	LD DE,HL
	LD HL,(ZXBASIC_VAR_ox)
	CALL runtimeAttr
	LD DE,HL
	LD HL,32
; =
	CALL runtimeCmpHLEqDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_8
; 		190.2  GOSUB l
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	LD DE,(ZXBASIC_VAR_l)
	LD HL,ZXLINES
	CALL runtimeFindLine
	CALL runtimeVarCall
ZXB_LABEL_8:
ZXBASIC_LINE_195:
; 195  IF  ATTR (y+1,x)=32 THEN  GOSUB l
	LD HL,195
	LD (23621),HL
; 		195.1  IF  ATTR (y+1{00 00 01 00 00 },x)=32{00 00 20 00 00 } THEN  GOSUB l
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
; ATTR
	LD DE,(ZXBASIC_VAR_y)
	LD HL,1
; +
	ADD HL,DE
	LD DE,HL
	LD HL,(ZXBASIC_VAR_x)
	CALL runtimeAttr
	LD DE,HL
	LD HL,32
; =
	CALL runtimeCmpHLEqDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_9
; 		195.2  GOSUB l
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	LD DE,(ZXBASIC_VAR_l)
	LD HL,ZXLINES
	CALL runtimeFindLine
	CALL runtimeVarCall
ZXB_LABEL_9:
ZXBASIC_LINE_200:
; 200  LET c=c+b
	LD HL,200
	LD (23621),HL
; 		200.1  LET c=c+b
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD DE,(ZXBASIC_VAR_c)
	LD HL,(ZXBASIC_VAR_b)
; +
	ADD HL,DE
	LD (ZXBASIC_VAR_c),HL
ZXBASIC_LINE_205:
; 205  IF wk=1 THEN  PRINT  AT oy+1,ox;d$(fl);: PAUSE 5: LET wk=0
	LD HL,205
	LD (23621),HL
; 		205.1  IF wk=1{00 00 01 00 00 } THEN  PRINT  AT oy+1{00 00 01 00 00 },ox;d$(fl);
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD DE,(ZXBASIC_VAR_wk)
	LD HL,1
; =
	CALL runtimeCmpHLEqDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_10
; 		205.2  PRINT  AT oy+1{00 00 01 00 00 },ox;d$(fl);
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,(ZXBASIC_VAR_oy)
	LD HL,1
; +
	ADD HL,DE
	LD DE,HL
	LD HL,(ZXBASIC_VAR_ox)
	CALL runtimePrintAt
	LD HL,(ZXBASIC_VAR_d_string)
	PUSH HL
	LD HL,(ZXBASIC_VAR_fl)
	POP BC
	CALL runtimeCharAt
	CALL runtimePrintString
	POP AF
	LD (ZX_P_FLAG),A
	CALL ZXFreeTempCompact
; 		205.3  PAUSE 5{00 00 05 00 00 }
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,5
	CALL runtimePause
; 		205.4  LET wk=0{00 00 00 00 00 }
	LD A,4
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,0
	LD (ZXBASIC_VAR_wk),HL
ZXB_LABEL_10:
ZXBASIC_LINE_230:
; 230  IF  ATTR (oy+2,ox)=16 THEN  PRINT  AT oy+2,ox-1; INK 0; PAPER 2;"\157";: BEEP 0.0003,65: PRINT  AT oy+2,ox-1; PAPER 0;" ": LET f=0
	LD HL,230
	LD (23621),HL
; 		230.1  IF  ATTR (oy+2{00 00 02 00 00 },ox)=16{00 00 10 00 00 } THEN  PRINT  AT oy+2{00 00 02 00 00 },ox-1{00 00 01 00 00 }; INK 0{00 00 00 00 00 }; PAPER 2{00 00 02 00 00 };"\157";
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
; ATTR
	LD DE,(ZXBASIC_VAR_oy)
	LD HL,2
; +
	ADD HL,DE
	LD DE,HL
	LD HL,(ZXBASIC_VAR_ox)
	CALL runtimeAttr
	LD DE,HL
	LD HL,16
; =
	CALL runtimeCmpHLEqDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_11
; 		230.2  PRINT  AT oy+2{00 00 02 00 00 },ox-1{00 00 01 00 00 }; INK 0{00 00 00 00 00 }; PAPER 2{00 00 02 00 00 };"\157";
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,(ZXBASIC_VAR_oy)
	LD HL,2
; +
	ADD HL,DE
	PUSH HL
	LD HL,(ZXBASIC_VAR_ox)
	LD DE,1
; -
	SUB HL,DE
	POP DE
	CALL runtimePrintAt
	LD HL,0
	CALL runtimeLocalInk
	LD HL,2
	CALL runtimeLocalPaper
	LD HL,STRING_2	;\9d
	CALL runtimePrintString
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
; 		230.3  BEEP 0.0003{75 1d 49 51 82 },65{00 00 41 00 00 }
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,FLOAT_3	;0.0003
	CALL runtimePushFloatVar
	LD HL,65
	CALL runtimeIntToFloat
	CALL $03F8
; 		230.4  PRINT  AT oy+2{00 00 02 00 00 },ox-1{00 00 01 00 00 }; PAPER 0{00 00 00 00 00 };" "
	LD A,4
	LD (23623),a
	CALL runtimeCheckBreak
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,(ZXBASIC_VAR_oy)
	LD HL,2
; +
	ADD HL,DE
	PUSH HL
	LD HL,(ZXBASIC_VAR_ox)
	LD DE,1
; -
	SUB HL,DE
	POP DE
	CALL runtimePrintAt
	LD HL,0
	CALL runtimeLocalPaper
	LD HL,STRING_0	; 
	CALL runtimePrintString
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
; 		230.5  LET f=0{00 00 00 00 00 }
	LD A,5
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,0
	LD (ZXBASIC_VAR_f),HL
ZXB_LABEL_11:
ZXBASIC_LINE_240:
; 240  IF k=5 THEN  GOSUB 720
	LD HL,240
	LD (23621),HL
; 		240.1  IF k=5{00 00 05 00 00 } THEN  GOSUB 720{00 00 d0 02 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD DE,(ZXBASIC_VAR_k)
	LD HL,5
; =
	CALL runtimeCmpHLEqDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_12
; 		240.2  GOSUB 720{00 00 d0 02 00 }
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_720
ZXB_LABEL_12:
ZXBASIC_LINE_250:
; 250  IF  IN 64510=190 THEN  LET j=1: LET jj=3: LET f=0: GOSUB 815
	LD HL,250
	LD (23621),HL
; 		250.1  IF  IN 64510{00 00 fe fb 00 }=190{00 00 be 00 00 } THEN  LET j=1{00 00 01 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
; IN
	LD HL,64510
	LD BC,HL
	IN A,(C)
	LD L,A
	LD H,0
	LD DE,HL
	LD HL,190
; =
	CALL runtimeCmpHLEqDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_13
; 		250.2  LET j=1{00 00 01 00 00 }
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,1
	LD (ZXBASIC_VAR_j),HL
; 		250.3  LET jj=3{00 00 03 00 00 }
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,3
	LD (ZXBASIC_VAR_jj),HL
; 		250.4  LET f=0{00 00 00 00 00 }
	LD A,4
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,0
	LD (ZXBASIC_VAR_f),HL
; 		250.5  GOSUB 815{00 00 2f 03 00 }
	LD A,5
	LD (23623),a
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_815
ZXB_LABEL_13:
ZXBASIC_LINE_280:
; 280  IF y+1=3 THEN  LET jj=2
	LD HL,280
	LD (23621),HL
; 		280.1  IF y+1{00 00 01 00 00 }=3{00 00 03 00 00 } THEN  LET jj=2{00 00 02 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD DE,(ZXBASIC_VAR_y)
	LD HL,1
; +
	ADD HL,DE
	LD DE,HL
	LD HL,3
; =
	CALL runtimeCmpHLEqDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_14
; 		280.2  LET jj=2{00 00 02 00 00 }
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,2
	LD (ZXBASIC_VAR_jj),HL
ZXB_LABEL_14:
ZXBASIC_LINE_285:
; 285  IF (f=p) OR (hf <= 0) THEN  GOSUB l
	LD HL,285
	LD (23621),HL
; 		285.1  IF (f=p) OR (hf <= 0{00 00 00 00 00 }) THEN  GOSUB l
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
; (
	LD DE,(ZXBASIC_VAR_f)
	LD HL,(ZXBASIC_VAR_p)
; =
	CALL runtimeCmpHLEqDE
	PUSH HL
; )
; (
	LD DE,(ZXBASIC_VAR_hf)
	LD HL,0
; <=
	CALL runtimeCmpHLLeDE
; )
; OR
	POP DE
	call runtimeOrHLDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_15
; 		285.2  GOSUB l
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	LD DE,(ZXBASIC_VAR_l)
	LD HL,ZXLINES
	CALL runtimeFindLine
	CALL runtimeVarCall
ZXB_LABEL_15:
ZXBASIC_LINE_290:
; 290  IF  ATTR (y+2,x)=132 THEN  LET x=x-1: BEEP 0.0001,65: LET f=0
	LD HL,290
	LD (23621),HL
; 		290.1  IF  ATTR (y+2{00 00 02 00 00 },x)=132{00 00 84 00 00 } THEN  LET x=x-1{00 00 01 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
; ATTR
	LD DE,(ZXBASIC_VAR_y)
	LD HL,2
; +
	ADD HL,DE
	LD DE,HL
	LD HL,(ZXBASIC_VAR_x)
	CALL runtimeAttr
	LD DE,HL
	LD HL,132
; =
	CALL runtimeCmpHLEqDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_16
; 		290.2  LET x=x-1{00 00 01 00 00 }
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,(ZXBASIC_VAR_x)
	DEC HL
; -
	LD (ZXBASIC_VAR_x),HL
; 		290.3  BEEP 0.0001{73 51 b7 17 58 },65{00 00 41 00 00 }
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,FLOAT_4	;0.0001
	CALL runtimePushFloatVar
	LD HL,65
	CALL runtimeIntToFloat
	CALL $03F8
; 		290.4  LET f=0{00 00 00 00 00 }
	LD A,4
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,0
	LD (ZXBASIC_VAR_f),HL
ZXB_LABEL_16:
ZXBASIC_LINE_300:
; 300  IF j=1 THEN  IF  ATTR (oy+2,x) <> 7 THEN  LET y=y-jj: LET j=0: LET jj=0: LET hf=hf-1: LET f=0: BEEP .0003,60
	LD HL,300
	LD (23621),HL
; 		300.1  IF j=1{00 00 01 00 00 } THEN  IF  ATTR (oy+2{00 00 02 00 00 },x) <> 7{00 00 07 00 00 } THEN  LET y=y-jj
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD DE,(ZXBASIC_VAR_j)
	LD HL,1
; =
	CALL runtimeCmpHLEqDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_17
; 		300.2  IF  ATTR (oy+2{00 00 02 00 00 },x) <> 7{00 00 07 00 00 } THEN  LET y=y-jj
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
; ATTR
	LD DE,(ZXBASIC_VAR_oy)
	LD HL,2
; +
	ADD HL,DE
	LD DE,HL
	LD HL,(ZXBASIC_VAR_x)
	CALL runtimeAttr
	LD DE,HL
	LD HL,7
; <>
	CALL runtimeCmpHlNeDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_18
; 		300.3  LET y=y-jj
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,(ZXBASIC_VAR_y)
	LD DE,(ZXBASIC_VAR_jj)
; -
	SUB HL,DE
	LD (ZXBASIC_VAR_y),HL
; 		300.4  LET j=0{00 00 00 00 00 }
	LD A,4
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,0
	LD (ZXBASIC_VAR_j),HL
; 		300.5  LET jj=0{00 00 00 00 00 }
	LD A,5
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,0
	LD (ZXBASIC_VAR_jj),HL
; 		300.6  LET hf=hf-1{00 00 01 00 00 }
	LD A,6
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,(ZXBASIC_VAR_hf)
	DEC HL
; -
	LD (ZXBASIC_VAR_hf),HL
; 		300.7  LET f=0{00 00 00 00 00 }
	LD A,7
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,0
	LD (ZXBASIC_VAR_f),HL
; 		300.8  BEEP .0003{75 1d 49 51 82 },60{00 00 3c 00 00 }
	LD A,8
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,FLOAT_3	;.0003
	CALL runtimePushFloatVar
	LD HL,60
	CALL runtimeIntToFloat
	CALL $03F8
ZXB_LABEL_18:
ZXB_LABEL_17:
ZXBASIC_LINE_320:
; 320  IF  ATTR (y-1,x)=48 THEN  BEEP .01,12: PRINT  AT y-1,x;" ": LET k=k+1
	LD HL,320
	LD (23621),HL
; 		320.1  IF  ATTR (y-1{00 00 01 00 00 },x)=48{00 00 30 00 00 } THEN  BEEP .01{7a 23 d7 0a 3d },12{00 00 0c 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
; ATTR
	LD HL,(ZXBASIC_VAR_y)
	LD DE,1
; -
	SUB HL,DE
	LD DE,HL
	LD HL,(ZXBASIC_VAR_x)
	CALL runtimeAttr
	LD DE,HL
	LD HL,48
; =
	CALL runtimeCmpHLEqDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_19
; 		320.2  BEEP .01{7a 23 d7 0a 3d },12{00 00 0c 00 00 }
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,FLOAT_5	;.01
	CALL runtimePushFloatVar
	LD HL,12
	CALL runtimeIntToFloat
	CALL $03F8
; 		320.3  PRINT  AT y-1{00 00 01 00 00 },x;" "
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,(ZXBASIC_VAR_y)
	LD DE,1
; -
	SUB HL,DE
	LD DE,HL
	LD HL,(ZXBASIC_VAR_x)
	CALL runtimePrintAt
	LD HL,STRING_0	; 
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
; 		320.4  LET k=k+1{00 00 01 00 00 }
	LD A,4
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,(ZXBASIC_VAR_k)
	INC HL
; +
	LD (ZXBASIC_VAR_k),HL
ZXB_LABEL_19:
ZXBASIC_LINE_325:
; 325  IF  ATTR (y+1,x-1)=48 THEN  BEEP .01,12: PRINT  AT y+1,x-1;" ": LET k=k+1
	LD HL,325
	LD (23621),HL
; 		325.1  IF  ATTR (y+1{00 00 01 00 00 },x-1{00 00 01 00 00 })=48{00 00 30 00 00 } THEN  BEEP .01{7a 23 d7 0a 3d },12{00 00 0c 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
; ATTR
	LD DE,(ZXBASIC_VAR_y)
	LD HL,1
; +
	ADD HL,DE
	PUSH HL
	LD HL,(ZXBASIC_VAR_x)
	LD DE,1
; -
	SUB HL,DE
	POP DE
	CALL runtimeAttr
	LD DE,HL
	LD HL,48
; =
	CALL runtimeCmpHLEqDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_20
; 		325.2  BEEP .01{7a 23 d7 0a 3d },12{00 00 0c 00 00 }
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,FLOAT_5	;.01
	CALL runtimePushFloatVar
	LD HL,12
	CALL runtimeIntToFloat
	CALL $03F8
; 		325.3  PRINT  AT y+1{00 00 01 00 00 },x-1{00 00 01 00 00 };" "
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,(ZXBASIC_VAR_y)
	LD HL,1
; +
	ADD HL,DE
	PUSH HL
	LD HL,(ZXBASIC_VAR_x)
	LD DE,1
; -
	SUB HL,DE
	POP DE
	CALL runtimePrintAt
	LD HL,STRING_0	; 
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
; 		325.4  LET k=k+1{00 00 01 00 00 }
	LD A,4
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,(ZXBASIC_VAR_k)
	INC HL
; +
	LD (ZXBASIC_VAR_k),HL
ZXB_LABEL_20:
ZXBASIC_LINE_330:
; 330  IF  ATTR (y+2,x)=48 THEN  BEEP .01,12: PRINT  AT y+2,x;" ": LET k=k+1
	LD HL,330
	LD (23621),HL
; 		330.1  IF  ATTR (y+2{00 00 02 00 00 },x)=48{00 00 30 00 00 } THEN  BEEP .01{7a 23 d7 0a 3d },12{00 00 0c 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
; ATTR
	LD DE,(ZXBASIC_VAR_y)
	LD HL,2
; +
	ADD HL,DE
	LD DE,HL
	LD HL,(ZXBASIC_VAR_x)
	CALL runtimeAttr
	LD DE,HL
	LD HL,48
; =
	CALL runtimeCmpHLEqDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_21
; 		330.2  BEEP .01{7a 23 d7 0a 3d },12{00 00 0c 00 00 }
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,FLOAT_5	;.01
	CALL runtimePushFloatVar
	LD HL,12
	CALL runtimeIntToFloat
	CALL $03F8
; 		330.3  PRINT  AT y+2{00 00 02 00 00 },x;" "
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,(ZXBASIC_VAR_y)
	LD HL,2
; +
	ADD HL,DE
	LD DE,HL
	LD HL,(ZXBASIC_VAR_x)
	CALL runtimePrintAt
	LD HL,STRING_0	; 
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
; 		330.4  LET k=k+1{00 00 01 00 00 }
	LD A,4
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,(ZXBASIC_VAR_k)
	INC HL
; +
	LD (ZXBASIC_VAR_k),HL
ZXB_LABEL_21:
ZXBASIC_LINE_331:
; 331  IF  ATTR (y,x)=3 THEN  BEEP .01,12: BEEP .02,35: PRINT  AT y,x;" ": GOSUB l
	LD HL,331
	LD (23621),HL
; 		331.1  IF  ATTR (y,x)=3{00 00 03 00 00 } THEN  BEEP .01{7a 23 d7 0a 3d },12{00 00 0c 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
; ATTR
	LD DE,(ZXBASIC_VAR_y)
	LD HL,(ZXBASIC_VAR_x)
	CALL runtimeAttr
	LD DE,HL
	LD HL,3
; =
	CALL runtimeCmpHLEqDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_22
; 		331.2  BEEP .01{7a 23 d7 0a 3d },12{00 00 0c 00 00 }
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,FLOAT_5	;.01
	CALL runtimePushFloatVar
	LD HL,12
	CALL runtimeIntToFloat
	CALL $03F8
; 		331.3  BEEP .02{7b 23 d7 0a 3d },35{00 00 23 00 00 }
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,FLOAT_6	;.02
	CALL runtimePushFloatVar
	LD HL,35
	CALL runtimeIntToFloat
	CALL $03F8
; 		331.4  PRINT  AT y,x;" "
	LD A,4
	LD (23623),a
	CALL runtimeCheckBreak
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,(ZXBASIC_VAR_y)
	LD HL,(ZXBASIC_VAR_x)
	CALL runtimePrintAt
	LD HL,STRING_0	; 
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
; 		331.5  GOSUB l
	LD A,5
	LD (23623),a
	CALL runtimeCheckBreak
	LD DE,(ZXBASIC_VAR_l)
	LD HL,ZXLINES
	CALL runtimeFindLine
	CALL runtimeVarCall
ZXB_LABEL_22:
ZXBASIC_LINE_335:
; 335  IF  ATTR (y,x)=48 THEN  BEEP .01,12: PRINT  AT y,x;" ": LET k=k+1
	LD HL,335
	LD (23621),HL
; 		335.1  IF  ATTR (y,x)=48{00 00 30 00 00 } THEN  BEEP .01{7a 23 d7 0a 3d },12{00 00 0c 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
; ATTR
	LD DE,(ZXBASIC_VAR_y)
	LD HL,(ZXBASIC_VAR_x)
	CALL runtimeAttr
	LD DE,HL
	LD HL,48
; =
	CALL runtimeCmpHLEqDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_23
; 		335.2  BEEP .01{7a 23 d7 0a 3d },12{00 00 0c 00 00 }
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,FLOAT_5	;.01
	CALL runtimePushFloatVar
	LD HL,12
	CALL runtimeIntToFloat
	CALL $03F8
; 		335.3  PRINT  AT y,x;" "
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,(ZXBASIC_VAR_y)
	LD HL,(ZXBASIC_VAR_x)
	CALL runtimePrintAt
	LD HL,STRING_0	; 
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
; 		335.4  LET k=k+1{00 00 01 00 00 }
	LD A,4
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,(ZXBASIC_VAR_k)
	INC HL
; +
	LD (ZXBASIC_VAR_k),HL
ZXB_LABEL_23:
ZXBASIC_LINE_340:
; 340  IF oy <> y OR ox <> x THEN  PRINT  AT oy,ox;" "; AT oy+1,ox;" "
	LD HL,340
	LD (23621),HL
; 		340.1  IF oy <> y OR ox <> x THEN  PRINT  AT oy,ox;" "; AT oy+1{00 00 01 00 00 },ox;" "
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD DE,(ZXBASIC_VAR_oy)
	LD HL,(ZXBASIC_VAR_y)
; <>
	CALL runtimeCmpHlNeDE
	PUSH HL
	LD DE,(ZXBASIC_VAR_ox)
	LD HL,(ZXBASIC_VAR_x)
; <>
	CALL runtimeCmpHlNeDE
; OR
	POP DE
	call runtimeOrHLDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_24
; 		340.2  PRINT  AT oy,ox;" "; AT oy+1{00 00 01 00 00 },ox;" "
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,(ZXBASIC_VAR_oy)
	LD HL,(ZXBASIC_VAR_ox)
	CALL runtimePrintAt
	LD HL,STRING_0	; 
	CALL runtimePrintString
	LD DE,(ZXBASIC_VAR_oy)
	LD HL,1
; +
	ADD HL,DE
	LD DE,HL
	LD HL,(ZXBASIC_VAR_ox)
	CALL runtimePrintAt
	LD HL,STRING_0	; 
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXB_LABEL_24:
ZXBASIC_LINE_350:
; 350  PRINT  AT y,x; INK 7;c$(fr); AT y+1,x;e$(fg);: PAUSE 3
	LD HL,350
	LD (23621),HL
; 		350.1  PRINT  AT y,x; INK 7{00 00 07 00 00 };c$(fr); AT y+1{00 00 01 00 00 },x;e$(fg);
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,(ZXBASIC_VAR_y)
	LD HL,(ZXBASIC_VAR_x)
	CALL runtimePrintAt
	LD HL,7
	CALL runtimeLocalInk
	LD HL,(ZXBASIC_VAR_c_string)
	PUSH HL
	LD HL,(ZXBASIC_VAR_fr)
	POP BC
	CALL runtimeCharAt
	CALL runtimePrintString
	LD DE,(ZXBASIC_VAR_y)
	LD HL,1
; +
	ADD HL,DE
	LD DE,HL
	LD HL,(ZXBASIC_VAR_x)
	CALL runtimePrintAt
	LD HL,(ZXBASIC_VAR_e_string)
	PUSH HL
	LD HL,(ZXBASIC_VAR_fg)
	POP BC
	CALL runtimeCharAt
	CALL runtimePrintString
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
	CALL ZXFreeTempCompact
; 		350.2  PAUSE 3{00 00 03 00 00 }
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,3
	CALL runtimePause
ZXBASIC_LINE_360:
; 360  LET oy=y: LET ox=x
	LD HL,360
	LD (23621),HL
; 		360.1  LET oy=y
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,(ZXBASIC_VAR_y)
	LD (ZXBASIC_VAR_oy),HL
; 		360.2  LET ox=x
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,(ZXBASIC_VAR_x)
	LD (ZXBASIC_VAR_ox),HL
ZXBASIC_LINE_365:
; 365  GOTO 100
	LD HL,365
	LD (23621),HL
; 		365.1  GOTO 100{00 00 64 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_100
ZXBASIC_LINE_370:
; 370  REM *** ROBOT MOVEMENT ***
	LD HL,370
	LD (23621),HL
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
ZXBASIC_LINE_486:
; 486  IF  ATTR (y+1,x)=2 THEN  LET y=oy: LET x=ox
	LD HL,486
	LD (23621),HL
; 		486.1  IF  ATTR (y+1{00 00 01 00 00 },x)=2{00 00 02 00 00 } THEN  LET y=oy
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
; ATTR
	LD DE,(ZXBASIC_VAR_y)
	LD HL,1
; +
	ADD HL,DE
	LD DE,HL
	LD HL,(ZXBASIC_VAR_x)
	CALL runtimeAttr
	LD DE,HL
	LD HL,2
; =
	CALL runtimeCmpHLEqDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_25
; 		486.2  LET y=oy
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,(ZXBASIC_VAR_oy)
	LD (ZXBASIC_VAR_y),HL
; 		486.3  LET x=ox
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,(ZXBASIC_VAR_ox)
	LD (ZXBASIC_VAR_x),HL
ZXB_LABEL_25:
ZXBASIC_LINE_488:
; 488  IF  ATTR (y,x)=2 THEN  LET x=ox: LET y=oy
	LD HL,488
	LD (23621),HL
; 		488.1  IF  ATTR (y,x)=2{00 00 02 00 00 } THEN  LET x=ox
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
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
	JP Z,ZXB_LABEL_26
; 		488.2  LET x=ox
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,(ZXBASIC_VAR_ox)
	LD (ZXBASIC_VAR_x),HL
; 		488.3  LET y=oy
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,(ZXBASIC_VAR_oy)
	LD (ZXBASIC_VAR_y),HL
ZXB_LABEL_26:
ZXBASIC_LINE_489:
; 489  IF  ATTR (y,x)=4 THEN  LET y=oy: LET x=ox
	LD HL,489
	LD (23621),HL
; 		489.1  IF  ATTR (y,x)=4{00 00 04 00 00 } THEN  LET y=oy
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
; ATTR
	LD DE,(ZXBASIC_VAR_y)
	LD HL,(ZXBASIC_VAR_x)
	CALL runtimeAttr
	LD DE,HL
	LD HL,4
; =
	CALL runtimeCmpHLEqDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_27
; 		489.2  LET y=oy
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,(ZXBASIC_VAR_oy)
	LD (ZXBASIC_VAR_y),HL
; 		489.3  LET x=ox
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,(ZXBASIC_VAR_ox)
	LD (ZXBASIC_VAR_x),HL
ZXB_LABEL_27:
ZXBASIC_LINE_490:
; 490  IF  ATTR (y+1,x)=16 THEN  LET x=ox
	LD HL,490
	LD (23621),HL
; 		490.1  IF  ATTR (y+1{00 00 01 00 00 },x)=16{00 00 10 00 00 } THEN  LET x=ox
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
; ATTR
	LD DE,(ZXBASIC_VAR_y)
	LD HL,1
; +
	ADD HL,DE
	LD DE,HL
	LD HL,(ZXBASIC_VAR_x)
	CALL runtimeAttr
	LD DE,HL
	LD HL,16
; =
	CALL runtimeCmpHLEqDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_28
; 		490.2  LET x=ox
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,(ZXBASIC_VAR_ox)
	LD (ZXBASIC_VAR_x),HL
ZXB_LABEL_28:
ZXBASIC_LINE_510:
; 510  LET b=b+(c<8)-(c>13)
	LD HL,510
	LD (23621),HL
; 		510.1  LET b=b+(c<8{00 00 08 00 00 })-(c>13{00 00 0d 00 00 })
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,(ZXBASIC_VAR_b)
	PUSH HL
; (
	LD DE,(ZXBASIC_VAR_c)
	LD HL,8
; <
	CALL runtimeCmpHLltDE
; )
; +
	POP DE
	ADD HL,DE
	PUSH HL
; (
	LD DE,(ZXBASIC_VAR_c)
	LD HL,13
; >
	CALL runtimeCmpHlGtDE
; )
; -
	POP DE
	EX HL,DE
	SUB HL,DE
	LD (ZXBASIC_VAR_b),HL
ZXBASIC_LINE_520:
; 520  IF oc <> c THEN  PRINT  AT 9,oc;" "; AT 10,oc;" "
	LD HL,520
	LD (23621),HL
; 		520.1  IF oc <> c THEN  PRINT  AT 9{00 00 09 00 00 },oc;" "; AT 10{00 00 0a 00 00 },oc;" "
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD DE,(ZXBASIC_VAR_oc)
	LD HL,(ZXBASIC_VAR_c)
; <>
	CALL runtimeCmpHlNeDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_29
; 		520.2  PRINT  AT 9{00 00 09 00 00 },oc;" "; AT 10{00 00 0a 00 00 },oc;" "
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,9
	LD HL,(ZXBASIC_VAR_oc)
	CALL runtimePrintAt
	LD HL,STRING_0	; 
	CALL runtimePrintString
	LD DE,10
	LD HL,(ZXBASIC_VAR_oc)
	CALL runtimePrintAt
	LD HL,STRING_0	; 
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXB_LABEL_29:
ZXBASIC_LINE_530:
; 530  IF b=-1 THEN  PRINT  AT 10,c; INK 6;"\150"; AT 9,c; INK 6;"\148"
	LD HL,530
	LD (23621),HL
; 		530.1  IF b=-1{00 00 01 00 00 } THEN  PRINT  AT 10{00 00 0a 00 00 },c; INK 6{00 00 06 00 00 };"\150"; AT 9{00 00 09 00 00 },c; INK 6{00 00 06 00 00 };"\148"
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,(ZXBASIC_VAR_b)
	PUSH HL
	LD HL,1
	LD BC,HL
; -
	LD HL,0
	SUB HL,BC
; =
	POP DE
	CALL runtimeCmpHLEqDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_30
; 		530.2  PRINT  AT 10{00 00 0a 00 00 },c; INK 6{00 00 06 00 00 };"\150"; AT 9{00 00 09 00 00 },c; INK 6{00 00 06 00 00 };"\148"
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,10
	LD HL,(ZXBASIC_VAR_c)
	CALL runtimePrintAt
	LD HL,6
	CALL runtimeLocalInk
	LD HL,STRING_3	;\96
	CALL runtimePrintString
	LD DE,9
	LD HL,(ZXBASIC_VAR_c)
	CALL runtimePrintAt
	LD HL,6
	CALL runtimeLocalInk
	LD HL,STRING_4	;\94
	CALL runtimePrintString
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
ZXB_LABEL_30:
ZXBASIC_LINE_540:
; 540  IF c=14 THEN  PRINT  AT 10,c; INK 6;"\150"; AT 9,c; INK 6;"\148"
	LD HL,540
	LD (23621),HL
; 		540.1  IF c=14{00 00 0e 00 00 } THEN  PRINT  AT 10{00 00 0a 00 00 },c; INK 6{00 00 06 00 00 };"\150"; AT 9{00 00 09 00 00 },c; INK 6{00 00 06 00 00 };"\148"
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD DE,(ZXBASIC_VAR_c)
	LD HL,14
; =
	CALL runtimeCmpHLEqDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_31
; 		540.2  PRINT  AT 10{00 00 0a 00 00 },c; INK 6{00 00 06 00 00 };"\150"; AT 9{00 00 09 00 00 },c; INK 6{00 00 06 00 00 };"\148"
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,10
	LD HL,(ZXBASIC_VAR_c)
	CALL runtimePrintAt
	LD HL,6
	CALL runtimeLocalInk
	LD HL,STRING_3	;\96
	CALL runtimePrintString
	LD DE,9
	LD HL,(ZXBASIC_VAR_c)
	CALL runtimePrintAt
	LD HL,6
	CALL runtimeLocalInk
	LD HL,STRING_4	;\94
	CALL runtimePrintString
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
ZXB_LABEL_31:
ZXBASIC_LINE_550:
; 550  IF b=1 THEN  PRINT  AT 10,c; INK 6;"\156"; AT 9,c; INK 6; PAPER 0;"\149"
	LD HL,550
	LD (23621),HL
; 		550.1  IF b=1{00 00 01 00 00 } THEN  PRINT  AT 10{00 00 0a 00 00 },c; INK 6{00 00 06 00 00 };"\156"; AT 9{00 00 09 00 00 },c; INK 6{00 00 06 00 00 }; PAPER 0{00 00 00 00 00 };"\149"
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD DE,(ZXBASIC_VAR_b)
	LD HL,1
; =
	CALL runtimeCmpHLEqDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_32
; 		550.2  PRINT  AT 10{00 00 0a 00 00 },c; INK 6{00 00 06 00 00 };"\156"; AT 9{00 00 09 00 00 },c; INK 6{00 00 06 00 00 }; PAPER 0{00 00 00 00 00 };"\149"
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,10
	LD HL,(ZXBASIC_VAR_c)
	CALL runtimePrintAt
	LD HL,6
	CALL runtimeLocalInk
	LD HL,STRING_5	;\9c
	CALL runtimePrintString
	LD DE,9
	LD HL,(ZXBASIC_VAR_c)
	CALL runtimePrintAt
	LD HL,6
	CALL runtimeLocalInk
	LD HL,0
	CALL runtimeLocalPaper
	LD HL,STRING_6	;\95
	CALL runtimePrintString
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
ZXB_LABEL_32:
ZXBASIC_LINE_560:
; 560  IF c=7 THEN  PRINT  AT 10,c; INK 6;"\156"; AT 9,c; INK 6;"\149"
	LD HL,560
	LD (23621),HL
; 		560.1  IF c=7{00 00 07 00 00 } THEN  PRINT  AT 10{00 00 0a 00 00 },c; INK 6{00 00 06 00 00 };"\156"; AT 9{00 00 09 00 00 },c; INK 6{00 00 06 00 00 };"\149"
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD DE,(ZXBASIC_VAR_c)
	LD HL,7
; =
	CALL runtimeCmpHLEqDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_33
; 		560.2  PRINT  AT 10{00 00 0a 00 00 },c; INK 6{00 00 06 00 00 };"\156"; AT 9{00 00 09 00 00 },c; INK 6{00 00 06 00 00 };"\149"
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,10
	LD HL,(ZXBASIC_VAR_c)
	CALL runtimePrintAt
	LD HL,6
	CALL runtimeLocalInk
	LD HL,STRING_5	;\9c
	CALL runtimePrintString
	LD DE,9
	LD HL,(ZXBASIC_VAR_c)
	CALL runtimePrintAt
	LD HL,6
	CALL runtimeLocalInk
	LD HL,STRING_6	;\95
	CALL runtimePrintString
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
ZXB_LABEL_33:
ZXBASIC_LINE_570:
; 570  LET oc=c
	LD HL,570
	LD (23621),HL
; 		570.1  LET oc=c
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,(ZXBASIC_VAR_c)
	LD (ZXBASIC_VAR_oc),HL
ZXBASIC_LINE_580:
; 580  IF (y>9 AND x>10) THEN  PRINT  AT 11,19; PAPER 4; INK 0;"\155"; AT 11,20; PAPER 4; INK 0; INVERSE 1;"\155"; INVERSE 0; PAPER 0; INK 4; FLASH 1;"\162 TRUM \162 TRUM "; FLASH 0;"\155"
	LD HL,580
	LD (23621),HL
; 		580.1  IF (y>9{00 00 09 00 00 } AND x>10{00 00 0a 00 00 }) THEN  PRINT  AT 11{00 00 0b 00 00 },19{00 00 13 00 00 }; PAPER 4{00 00 04 00 00 }; INK 0{00 00 00 00 00 };"\155"; AT 11{00 00 0b 00 00 },20{00 00 14 00 00 }; PAPER 4{00 00 04 00 00 }; INK 0{00 00 00 00 00 }; INVERSE 1{00 00 01 00 00 };"\155"; INVERSE 0{00 00 00 00 00 }; PAPER 0{00 00 00 00 00 }; INK 4{00 00 04 00 00 }; FLASH 1{00 00 01 00 00 };"\162 TRUM \162 TRUM "; FLASH 0{00 00 00 00 00 };"\155"
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
; (
	LD DE,(ZXBASIC_VAR_y)
	LD HL,9
; >
	CALL runtimeCmpHlGtDE
	PUSH HL
	LD DE,(ZXBASIC_VAR_x)
	LD HL,10
; >
	CALL runtimeCmpHlGtDE
; AND
	POP DE
	call runtimeAndHLDE
; )
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_34
; 		580.2  PRINT  AT 11{00 00 0b 00 00 },19{00 00 13 00 00 }; PAPER 4{00 00 04 00 00 }; INK 0{00 00 00 00 00 };"\155"; AT 11{00 00 0b 00 00 },20{00 00 14 00 00 }; PAPER 4{00 00 04 00 00 }; INK 0{00 00 00 00 00 }; INVERSE 1{00 00 01 00 00 };"\155"; INVERSE 0{00 00 00 00 00 }; PAPER 0{00 00 00 00 00 }; INK 4{00 00 04 00 00 }; FLASH 1{00 00 01 00 00 };"\162 TRUM \162 TRUM "; FLASH 0{00 00 00 00 00 };"\155"
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,11
	LD HL,19
	CALL runtimePrintAt
	LD HL,4
	CALL runtimeLocalPaper
	LD HL,0
	CALL runtimeLocalInk
	LD HL,STRING_7	;\9b
	CALL runtimePrintString
	LD DE,11
	LD HL,20
	CALL runtimePrintAt
	LD HL,4
	CALL runtimeLocalPaper
	LD HL,0
	CALL runtimeLocalInk
	LD HL,1
	CALL runtimeLocalInverse
	LD HL,STRING_7	;\9b
	CALL runtimePrintString
	LD HL,0
	CALL runtimeLocalInverse
	LD HL,0
	CALL runtimeLocalPaper
	LD HL,4
	CALL runtimeLocalInk
	LD HL,1
	CALL runtimeLocalFlash
	LD HL,STRING_8	;\a2\a3\a2\a3
	CALL runtimePrintString
	LD HL,0
	CALL runtimeLocalFlash
	LD HL,STRING_7	;\9b
	CALL runtimePrintString
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
ZXB_LABEL_34:
ZXBASIC_LINE_590:
; 590  IF (y>4 OR y<8) AND (x>5 OR x<14) THEN  IF  ABSX (y+1-10)<2 AND  ABSX (x-c)<2 THEN  GOSUB l
	LD HL,590
	LD (23621),HL
; 		590.1  IF (y>4{00 00 04 00 00 } OR y<8{00 00 08 00 00 }) AND (x>5{00 00 05 00 00 } OR x<14{00 00 0e 00 00 }) THEN  IF  ABSX (y+1{00 00 01 00 00 }-10{00 00 0a 00 00 })<2{00 00 02 00 00 } AND  ABSX (x-c)<2{00 00 02 00 00 } THEN  GOSUB l
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
; (
	LD DE,(ZXBASIC_VAR_y)
	LD HL,4
; >
	CALL runtimeCmpHlGtDE
	PUSH HL
	LD DE,(ZXBASIC_VAR_y)
	LD HL,8
; <
	CALL runtimeCmpHLltDE
; OR
	POP DE
	call runtimeOrHLDE
	PUSH HL
; )
; (
	LD DE,(ZXBASIC_VAR_x)
	LD HL,5
; >
	CALL runtimeCmpHlGtDE
	PUSH HL
	LD DE,(ZXBASIC_VAR_x)
	LD HL,14
; <
	CALL runtimeCmpHLltDE
; OR
	POP DE
	call runtimeOrHLDE
; )
; AND
	POP DE
	call runtimeAndHLDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_35
; 		590.2  IF  ABSX (y+1{00 00 01 00 00 }-10{00 00 0a 00 00 })<2{00 00 02 00 00 } AND  ABSX (x-c)<2{00 00 02 00 00 } THEN  GOSUB l
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
; ABSX
	LD DE,(ZXBASIC_VAR_y)
	LD HL,1
; +
	ADD HL,DE
	LD DE,10
; -
	SUB HL,DE
	CALL runtimeAbsInt
	LD DE,HL
	LD HL,2
; <
	CALL runtimeCmpHLltDE
	PUSH HL
; ABSX
	LD HL,(ZXBASIC_VAR_x)
	LD DE,(ZXBASIC_VAR_c)
; -
	SUB HL,DE
	CALL runtimeAbsInt
	LD DE,HL
	LD HL,2
; <
	CALL runtimeCmpHLltDE
; AND
	POP DE
	call runtimeAndHLDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_36
; 		590.3  GOSUB l
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
	LD DE,(ZXBASIC_VAR_l)
	LD HL,ZXLINES
	CALL runtimeFindLine
	CALL runtimeVarCall
ZXB_LABEL_36:
ZXB_LABEL_35:
ZXBASIC_LINE_610:
; 610  IF  ATTR (y,x)=6 THEN  GOSUB l
	LD HL,610
	LD (23621),HL
; 		610.1  IF  ATTR (y,x)=6{00 00 06 00 00 } THEN  GOSUB l
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
; ATTR
	LD DE,(ZXBASIC_VAR_y)
	LD HL,(ZXBASIC_VAR_x)
	CALL runtimeAttr
	LD DE,HL
	LD HL,6
; =
	CALL runtimeCmpHLEqDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_37
; 		610.2  GOSUB l
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	LD DE,(ZXBASIC_VAR_l)
	LD HL,ZXLINES
	CALL runtimeFindLine
	CALL runtimeVarCall
ZXB_LABEL_37:
ZXBASIC_LINE_615:
; 615  IF (y<7 AND x>4) THEN  PRINT  AT 5,6; INK 2;"\154\154\154\154"; AT 5,14; INK 2;"\154\154\154\154\154\154\154"
	LD HL,615
	LD (23621),HL
; 		615.1  IF (y<7{00 00 07 00 00 } AND x>4{00 00 04 00 00 }) THEN  PRINT  AT 5{00 00 05 00 00 },6{00 00 06 00 00 }; INK 2{00 00 02 00 00 };"\154\154\154\154"; AT 5{00 00 05 00 00 },14{00 00 0e 00 00 }; INK 2{00 00 02 00 00 };"\154\154\154\154\154\154\154"
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
; (
	LD DE,(ZXBASIC_VAR_y)
	LD HL,7
; <
	CALL runtimeCmpHLltDE
	PUSH HL
	LD DE,(ZXBASIC_VAR_x)
	LD HL,4
; >
	CALL runtimeCmpHlGtDE
; AND
	POP DE
	call runtimeAndHLDE
; )
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_38
; 		615.2  PRINT  AT 5{00 00 05 00 00 },6{00 00 06 00 00 }; INK 2{00 00 02 00 00 };"\154\154\154\154"; AT 5{00 00 05 00 00 },14{00 00 0e 00 00 }; INK 2{00 00 02 00 00 };"\154\154\154\154\154\154\154"
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,5
	LD HL,6
	CALL runtimePrintAt
	LD HL,2
	CALL runtimeLocalInk
	LD HL,STRING_9	;\9a\9a\9a\9a
	CALL runtimePrintString
	LD DE,5
	LD HL,14
	CALL runtimePrintAt
	LD HL,2
	CALL runtimeLocalInk
	LD HL,STRING_10	;\9a\9a\9a\9a\9a\9a\9a
	CALL runtimePrintString
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
ZXB_LABEL_38:
ZXBASIC_LINE_625:
; 625  IF (y >= 15 AND x >= 29) THEN  LET win=1: GOTO 1760
	LD HL,625
	LD (23621),HL
; 		625.1  IF (y >= 15{00 00 0f 00 00 } AND x >= 29{00 00 1d 00 00 }) THEN  LET win=1{00 00 01 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
; (
	LD DE,(ZXBASIC_VAR_y)
	LD HL,15
; >=
	CALL runtimeCmpHLGeDE
	PUSH HL
	LD DE,(ZXBASIC_VAR_x)
	LD HL,29
; >=
	CALL runtimeCmpHLGeDE
; AND
	POP DE
	call runtimeAndHLDE
; )
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_39
; 		625.2  LET win=1{00 00 01 00 00 }
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,1
	LD (ZXBASIC_VAR_win),HL
; 		625.3  GOTO 1760{00 00 e0 06 00 }
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_1760
ZXB_LABEL_39:
ZXBASIC_LINE_700:
; 700  RETURN 
	LD HL,700
	LD (23621),HL
; 		700.1  RETURN 
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	RET
ZXBASIC_LINE_720:
; 720  REM *** Door open ***
	LD HL,720
	LD (23621),HL
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
ZXBASIC_LINE_730:
; 730  IF k<5 THEN  RETURN 
	LD HL,730
	LD (23621),HL
; 		730.1  IF k<5{00 00 05 00 00 } THEN  RETURN 
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD DE,(ZXBASIC_VAR_k)
	LD HL,5
; <
	CALL runtimeCmpHLltDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_40
; 		730.2  RETURN 
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	RET
ZXB_LABEL_40:
ZXBASIC_LINE_740:
; 740  IF k=5 THEN  FOR o=17 TO 16 STEP -1: BEEP .01,o: BEEP .02,10: PRINT  AT o,28; INK 0;"xxx": NEXT o: LET p=11: LET k=6
	LD HL,740
	LD (23621),HL
; 		740.1  IF k=5{00 00 05 00 00 } THEN  FOR o=17{00 00 11 00 00 } TO 16{00 00 10 00 00 } STEP -1{00 00 01 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD DE,(ZXBASIC_VAR_k)
	LD HL,5
; =
	CALL runtimeCmpHLEqDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_41
; 		740.2  FOR o=17{00 00 11 00 00 } TO 16{00 00 10 00 00 } STEP -1{00 00 01 00 00 }
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,17
	LD (ZXBASIC_VAR_o),HL
	LD HL,16
	LD (ZXBASIC_VAR_for_o),HL
	LD HL,1
	LD BC,HL
; -
	LD HL,0
	SUB HL,BC
	LD (ZXBASIC_VAR_for_o_step),HL
FOR_1:
; 		740.3  BEEP .01{7a 23 d7 0a 3d },o
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,FLOAT_5	;.01
	CALL runtimePushFloatVar
	LD HL,(ZXBASIC_VAR_o)
	CALL runtimeIntToFloat
	CALL $03F8
; 		740.4  BEEP .02{7b 23 d7 0a 3d },10{00 00 0a 00 00 }
	LD A,4
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,FLOAT_6	;.02
	CALL runtimePushFloatVar
	LD HL,10
	CALL runtimeIntToFloat
	CALL $03F8
; 		740.5  PRINT  AT o,28{00 00 1c 00 00 }; INK 0{00 00 00 00 00 };"xxx"
	LD A,5
	LD (23623),a
	CALL runtimeCheckBreak
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,(ZXBASIC_VAR_o)
	LD HL,28
	CALL runtimePrintAt
	LD HL,0
	CALL runtimeLocalInk
	LD HL,STRING_11	;xxx
	CALL runtimePrintString
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
; 		740.6  NEXT o
	LD A,6
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,(ZXBASIC_VAR_o)
	LD BC,(ZXBASIC_VAR_for_o_step)
	LD A,B
	ADD HL,BC
	LD (ZXBASIC_VAR_o),HL
	LD DE,(ZXBASIC_VAR_for_o)
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
; 		740.7  LET p=11{00 00 0b 00 00 }
	LD A,7
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,11
	LD (ZXBASIC_VAR_p),HL
; 		740.8  LET k=6{00 00 06 00 00 }
	LD A,8
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,6
	LD (ZXBASIC_VAR_k),HL
ZXB_LABEL_41:
ZXBASIC_LINE_770:
; 770  GOSUB 790
	LD HL,770
	LD (23621),HL
; 		770.1  GOSUB 790{00 00 16 03 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_790
ZXBASIC_LINE_780:
; 780  RETURN 
	LD HL,780
	LD (23621),HL
; 		780.1  RETURN 
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	RET
ZXBASIC_LINE_790:
; 790  REM *** SCORE REFRESH ***
	LD HL,790
	LD (23621),HL
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
ZXBASIC_LINE_800:
; 800  PRINT  AT 20,0; INK 5;"AIR"
	LD HL,800
	LD (23621),HL
; 		800.1  PRINT  AT 20{00 00 14 00 00 },0{00 00 00 00 00 }; INK 5{00 00 05 00 00 };"AIR"
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,20
	LD HL,0
	CALL runtimePrintAt
	LD HL,5
	CALL runtimeLocalInk
	LD HL,STRING_12	;AIR
	CALL runtimePrintString
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_810:
; 810   PRINT  AT 20,26; INK 7;"\160"; AT 21,26;"\161"; CHR$ 128;lf;
	LD HL,810
	LD (23621),HL
; 		810.1  PRINT  AT 20{00 00 14 00 00 },26{00 00 1a 00 00 }; INK 7{00 00 07 00 00 };"\160"; AT 21{00 00 15 00 00 },26{00 00 1a 00 00 };"\161"; CHR$ 128{00 00 80 00 00 };lf;
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,20
	LD HL,26
	CALL runtimePrintAt
	LD HL,7
	CALL runtimeLocalInk
	LD HL,STRING_13	;\a0
	CALL runtimePrintString
	LD DE,21
	LD HL,26
	CALL runtimePrintAt
	LD HL,STRING_14	;\a1
	CALL runtimePrintString
; CHR$
	LD HL,128
	CALL runtimeChr
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_lf)
	CALL runtimePrintInt
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
	CALL ZXFreeTempCompact
ZXBASIC_LINE_815:
; 815  PRINT  AT 20,4; FLASH ae;hf; FLASH 0; CHR$ 128
	LD HL,815
	LD (23621),HL
; 		815.1  PRINT  AT 20{00 00 14 00 00 },4{00 00 04 00 00 }; FLASH ae;hf; FLASH 0{00 00 00 00 00 }; CHR$ 128{00 00 80 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,20
	LD HL,4
	CALL runtimePrintAt
	LD HL,(ZXBASIC_VAR_ae)
	CALL runtimeLocalFlash
	LD HL,(ZXBASIC_VAR_hf)
	CALL runtimePrintInt
	LD HL,0
	CALL runtimeLocalFlash
; CHR$
	LD HL,128
	CALL runtimeChr
	CALL runtimePrintString
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
	CALL ZXFreeTempCompact
ZXBASIC_LINE_820:
; 820  RETURN 
	LD HL,820
	LD (23621),HL
; 		820.1  RETURN 
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	RET
ZXBASIC_LINE_821:
; 821  REM *** Power Up ***
	LD HL,821
	LD (23621),HL
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
ZXBASIC_LINE_822:
; 822  FOR o=40 TO 45: BEEP 0.04,o: NEXT o: BEEP .05,25: PRINT  AT 10,2; INK 5;" PLAY "
	LD HL,822
	LD (23621),HL
; 		822.1  FOR o=40{00 00 28 00 00 } TO 45{00 00 2d 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,40
	LD (ZXBASIC_VAR_o),HL
	LD HL,45
	LD (ZXBASIC_VAR_for_o),HL
FOR_2:
; 		822.2  BEEP 0.04{7c 23 d7 0a 3d },o
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,FLOAT_7	;0.04
	CALL runtimePushFloatVar
	LD HL,(ZXBASIC_VAR_o)
	CALL runtimeIntToFloat
	CALL $03F8
; 		822.3  NEXT o
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,(ZXBASIC_VAR_o)
	INC HL
	LD (ZXBASIC_VAR_o),HL
	LD DE,(ZXBASIC_VAR_for_o)
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_2
; 		822.4  BEEP .05{7c 4c cc cc cc },25{00 00 19 00 00 }
	LD A,4
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,FLOAT_8	;.05
	CALL runtimePushFloatVar
	LD HL,25
	CALL runtimeIntToFloat
	CALL $03F8
; 		822.5  PRINT  AT 10{00 00 0a 00 00 },2{00 00 02 00 00 }; INK 5{00 00 05 00 00 };" PLAY "
	LD A,5
	LD (23623),a
	CALL runtimeCheckBreak
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,10
	LD HL,2
	CALL runtimePrintAt
	LD HL,5
	CALL runtimeLocalInk
	LD HL,STRING_15	;\a4
	CALL runtimePrintString
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_823:
; 823  LET hf=10: LET ae=1
	LD HL,823
	LD (23621),HL
; 		823.1  LET hf=10{00 00 0a 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,10
	LD (ZXBASIC_VAR_hf),HL
; 		823.2  LET ae=1{00 00 01 00 00 }
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,1
	LD (ZXBASIC_VAR_ae),HL
ZXBASIC_LINE_824:
; 824  PRINT  AT 21,9; INK 5; PAPER 1; FLASH 1;"INCREASE AIR"; FLASH 0
	LD HL,824
	LD (23621),HL
; 		824.1  PRINT  AT 21{00 00 15 00 00 },9{00 00 09 00 00 }; INK 5{00 00 05 00 00 }; PAPER 1{00 00 01 00 00 }; FLASH 1{00 00 01 00 00 };"INCREASE AIR"; FLASH 0{00 00 00 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,21
	LD HL,9
	CALL runtimePrintAt
	LD HL,5
	CALL runtimeLocalInk
	LD HL,1
	CALL runtimeLocalPaper
	LD HL,1
	CALL runtimeLocalFlash
	LD HL,STRING_16	;INCREASE AIR
	CALL runtimePrintString
	LD HL,0
	CALL runtimeLocalFlash
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_825:
; 825  RETURN 
	LD HL,825
	LD (23621),HL
; 		825.1  RETURN 
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	RET
ZXBASIC_LINE_830:
; 830  REM **** VARIABLES ****
	LD HL,830
	LD (23621),HL
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
ZXBASIC_LINE_840:
; 840  LET k=0: LET y=15: LET oy=y: LET x=3: LET ox=x
	LD HL,840
	LD (23621),HL
; 		840.1  LET k=0{00 00 00 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,0
	LD (ZXBASIC_VAR_k),HL
; 		840.2  LET y=15{00 00 0f 00 00 }
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,15
	LD (ZXBASIC_VAR_y),HL
; 		840.3  LET oy=y
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,(ZXBASIC_VAR_y)
	LD (ZXBASIC_VAR_oy),HL
; 		840.4  LET x=3{00 00 03 00 00 }
	LD A,4
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,3
	LD (ZXBASIC_VAR_x),HL
; 		840.5  LET ox=x
	LD A,5
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,(ZXBASIC_VAR_x)
	LD (ZXBASIC_VAR_ox),HL
ZXBASIC_LINE_845:
; 845  LET wk=0
	LD HL,845
	LD (23621),HL
; 		845.1  LET wk=0{00 00 00 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,0
	LD (ZXBASIC_VAR_wk),HL
ZXBASIC_LINE_850:
; 850  INK 7: PAPER 0: BORDER 2
	LD HL,850
	LD (23621),HL
; 		850.1  INK 7{00 00 07 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,7
	CALL runtimeInk
; 		850.2  PAPER 0{00 00 00 00 00 }
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,0
	CALL runtimePaper
; 		850.3  BORDER 2{00 00 02 00 00 }
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,2
	LD A,L
	call $2297
ZXBASIC_LINE_860:
; 860  LET n=484: LET l=990
	LD HL,860
	LD (23621),HL
; 		860.1  LET n=484{00 00 e4 01 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,484
	LD (ZXBASIC_VAR_n),HL
; 		860.2  LET l=990{00 00 de 03 00 }
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,990
	LD (ZXBASIC_VAR_l),HL
ZXBASIC_LINE_870:
; 870  LET t=3: LET ss=1: LET ot=t
	LD HL,870
	LD (23621),HL
; 		870.1  LET t=3{00 00 03 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,3
	LD (ZXBASIC_VAR_t),HL
; 		870.2  LET ss=1{00 00 01 00 00 }
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,1
	LD (ZXBASIC_VAR_ss),HL
; 		870.3  LET ot=t
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,(ZXBASIC_VAR_t)
	LD (ZXBASIC_VAR_ot),HL
ZXBASIC_LINE_890:
; 890  LET m=1: LET e=1
	LD HL,890
	LD (23621),HL
; 		890.1  LET m=1{00 00 01 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,1
	LD (ZXBASIC_VAR_m),HL
; 		890.2  LET e=1{00 00 01 00 00 }
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,1
	LD (ZXBASIC_VAR_e),HL
ZXBASIC_LINE_900:
; 900  LET j=0: LET jj=3
	LD HL,900
	LD (23621),HL
; 		900.1  LET j=0{00 00 00 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,0
	LD (ZXBASIC_VAR_j),HL
; 		900.2  LET jj=3{00 00 03 00 00 }
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,3
	LD (ZXBASIC_VAR_jj),HL
ZXBASIC_LINE_910:
; 910  LET d=0: LET c=8: LET b=1
	LD HL,910
	LD (23621),HL
; 		910.1  LET d=0{00 00 00 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,0
	LD (ZXBASIC_VAR_d),HL
; 		910.2  LET c=8{00 00 08 00 00 }
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,8
	LD (ZXBASIC_VAR_c),HL
; 		910.3  LET b=1{00 00 01 00 00 }
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,1
	LD (ZXBASIC_VAR_b),HL
ZXBASIC_LINE_930:
; 930  LET lf=3: LET f=0: LET p=7
	LD HL,930
	LD (23621),HL
; 		930.1  LET lf=3{00 00 03 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,3
	LD (ZXBASIC_VAR_lf),HL
; 		930.2  LET f=0{00 00 00 00 00 }
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,0
	LD (ZXBASIC_VAR_f),HL
; 		930.3  LET p=7{00 00 07 00 00 }
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,7
	LD (ZXBASIC_VAR_p),HL
ZXBASIC_LINE_940:
; 940  LET hf=15: LET oc=c
	LD HL,940
	LD (23621),HL
; 		940.1  LET hf=15{00 00 0f 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,15
	LD (ZXBASIC_VAR_hf),HL
; 		940.2  LET oc=c
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,(ZXBASIC_VAR_c)
	LD (ZXBASIC_VAR_oc),HL
ZXBASIC_LINE_950:
; 950  LET c$="\144\160": LET d$="\145\161": LET e$="\146\147"
	LD HL,950
	LD (23621),HL
; 		950.1  LET c$="\144\160"
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD DE,STRING_17	;\90\a0
	LD HL,ZXBASIC_VAR_c_string
	CALL runtimeStoreString
; 		950.2  LET d$="\145\161"
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	LD DE,STRING_18	;\91\a1
	LD HL,ZXBASIC_VAR_d_string
	CALL runtimeStoreString
; 		950.3  LET e$="\146\147"
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
	LD DE,STRING_19	;\92\93
	LD HL,ZXBASIC_VAR_e_string
	CALL runtimeStoreString
ZXBASIC_LINE_960:
; 960  LET fg=2: LET fl=1: LET fr=1
	LD HL,960
	LD (23621),HL
; 		960.1  LET fg=2{00 00 02 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,2
	LD (ZXBASIC_VAR_fg),HL
; 		960.2  LET fl=1{00 00 01 00 00 }
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,1
	LD (ZXBASIC_VAR_fl),HL
; 		960.3  LET fr=1{00 00 01 00 00 }
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,1
	LD (ZXBASIC_VAR_fr),HL
ZXBASIC_LINE_970:
; 970  LET h=0: LET s=0: LET ae=0
	LD HL,970
	LD (23621),HL
; 		970.1  LET h=0{00 00 00 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,0
	LD (ZXBASIC_VAR_h),HL
; 		970.2  LET s=0{00 00 00 00 00 }
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,0
	LD (ZXBASIC_VAR_s),HL
; 		970.3  LET ae=0{00 00 00 00 00 }
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,0
	LD (ZXBASIC_VAR_ae),HL
ZXBASIC_LINE_980:
; 980  RETURN 
	LD HL,980
	LD (23621),HL
; 		980.1  RETURN 
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	RET
ZXBASIC_LINE_990:
; 990  REM *** LOST LIFE ***
	LD HL,990
	LD (23621),HL
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
ZXBASIC_LINE_1000:
; 1000  FOR k=40 TO 30 STEP -1: BEEP .003,k: INK  INT ( RND *7)+1: PRINT  AT oy,ox;c$(fr); AT oy+1,ox;d$(fl): NEXT k: INK 7
	LD HL,1000
	LD (23621),HL
; 		1000.1  FOR k=40{00 00 28 00 00 } TO 30{00 00 1e 00 00 } STEP -1{00 00 01 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,40
	LD (ZXBASIC_VAR_k),HL
	LD HL,30
	LD (ZXBASIC_VAR_for_k),HL
	LD HL,1
	LD BC,HL
; -
	LD HL,0
	SUB HL,BC
	LD (ZXBASIC_VAR_for_k_step),HL
FOR_3:
; 		1000.2  BEEP .003{78 44 9b a5 e3 },k
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,FLOAT_9	;.003
	CALL runtimePushFloatVar
	LD HL,(ZXBASIC_VAR_k)
	CALL runtimeIntToFloat
	CALL $03F8
; 		1000.3  INK  INT ( RND *7{00 00 07 00 00 })+1{00 00 01 00 00 }
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
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
	CALL runtimeInk
; 		1000.4  PRINT  AT oy,ox;c$(fr); AT oy+1{00 00 01 00 00 },ox;d$(fl)
	LD A,4
	LD (23623),a
	CALL runtimeCheckBreak
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,(ZXBASIC_VAR_oy)
	LD HL,(ZXBASIC_VAR_ox)
	CALL runtimePrintAt
	LD HL,(ZXBASIC_VAR_c_string)
	PUSH HL
	LD HL,(ZXBASIC_VAR_fr)
	POP BC
	CALL runtimeCharAt
	CALL runtimePrintString
	LD DE,(ZXBASIC_VAR_oy)
	LD HL,1
; +
	ADD HL,DE
	LD DE,HL
	LD HL,(ZXBASIC_VAR_ox)
	CALL runtimePrintAt
	LD HL,(ZXBASIC_VAR_d_string)
	PUSH HL
	LD HL,(ZXBASIC_VAR_fl)
	POP BC
	CALL runtimeCharAt
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
	CALL ZXFreeTempCompact
; 		1000.5  NEXT k
	LD A,5
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,(ZXBASIC_VAR_k)
	LD BC,(ZXBASIC_VAR_for_k_step)
	LD A,B
	ADD HL,BC
	LD (ZXBASIC_VAR_k),HL
	LD DE,(ZXBASIC_VAR_for_k)
	AND $80
	JR Z,FOR_3_1
	SUB HL,DE
	JP Z,FOR_3_2
	JP NC,FOR_3
	JR FOR_3_2
FOR_3_1:
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_3
FOR_3_2:
; 		1000.6  INK 7{00 00 07 00 00 }
	LD A,6
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,7
	CALL runtimeInk
ZXBASIC_LINE_1020:
; 1020  LET lf=lf-1
	LD HL,1020
	LD (23621),HL
; 		1020.1  LET lf=lf-1{00 00 01 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,(ZXBASIC_VAR_lf)
	DEC HL
; -
	LD (ZXBASIC_VAR_lf),HL
ZXBASIC_LINE_1030:
; 1030  IF lf=0 THEN  GOTO 1680
	LD HL,1030
	LD (23621),HL
; 		1030.1  IF lf=0{00 00 00 00 00 } THEN  GOTO 1680{00 00 90 06 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD DE,(ZXBASIC_VAR_lf)
	LD HL,0
; =
	CALL runtimeCmpHLEqDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_42
; 		1030.2  GOTO 1680{00 00 90 06 00 }
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_1680
ZXB_LABEL_42:
ZXBASIC_LINE_1040:
; 1040  IF hf <= 10 THEN  LET hf=15: LET ae=0
	LD HL,1040
	LD (23621),HL
; 		1040.1  IF hf <= 10{00 00 0a 00 00 } THEN  LET hf=15{00 00 0f 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD DE,(ZXBASIC_VAR_hf)
	LD HL,10
; <=
	CALL runtimeCmpHLLeDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_43
; 		1040.2  LET hf=15{00 00 0f 00 00 }
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,15
	LD (ZXBASIC_VAR_hf),HL
; 		1040.3  LET ae=0{00 00 00 00 00 }
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,0
	LD (ZXBASIC_VAR_ae),HL
ZXB_LABEL_43:
ZXBASIC_LINE_1050:
; 1050  LET y=16: LET x=3: LET f=0
	LD HL,1050
	LD (23621),HL
; 		1050.1  LET y=16{00 00 10 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,16
	LD (ZXBASIC_VAR_y),HL
; 		1050.2  LET x=3{00 00 03 00 00 }
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,3
	LD (ZXBASIC_VAR_x),HL
; 		1050.3  LET f=0{00 00 00 00 00 }
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,0
	LD (ZXBASIC_VAR_f),HL
ZXBASIC_LINE_1060:
; 1060  CLS : PAPER 0: INK 7: BORDER 2
	LD HL,1060
	LD (23621),HL
; 		1060.1  CLS 
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	CALL runtimeCls
; 		1060.2  PAPER 0{00 00 00 00 00 }
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,0
	CALL runtimePaper
; 		1060.3  INK 7{00 00 07 00 00 }
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,7
	CALL runtimeInk
; 		1060.4  BORDER 2{00 00 02 00 00 }
	LD A,4
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,2
	LD A,L
	call $2297
ZXBASIC_LINE_1070:
; 1070  GOSUB 1100
	LD HL,1070
	LD (23621),HL
; 		1070.1  GOSUB 1100{00 00 4c 04 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_1100
ZXBASIC_LINE_1090:
; 1090  RETURN 
	LD HL,1090
	LD (23621),HL
; 		1090.1  RETURN 
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	RET
ZXBASIC_LINE_1095:
; 1095  RESTORE 2140
	LD HL,1095
	LD (23621),HL
; 		1095.1  RESTORE 2140{00 00 5c 08 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD DE,2140
	LD HL,ZXDATA
	CALL runtimeFindLine
	EX HL,DE
	LD (DATAPTR),DE
ZXBASIC_LINE_1100:
; 1100  REM *** LEVEL 1 ***
	LD HL,1100
	LD (23621),HL
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
ZXBASIC_LINE_1110:
; 1110  INK 7: LET k=0
	LD HL,1110
	LD (23621),HL
; 		1110.1  INK 7{00 00 07 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,7
	CALL runtimeInk
; 		1110.2  LET k=0{00 00 00 00 00 }
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,0
	LD (ZXBASIC_VAR_k),HL
ZXBASIC_LINE_1120:
; 1120  GOSUB 790
	LD HL,1120
	LD (23621),HL
; 		1120.1  GOSUB 790{00 00 16 03 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_790
ZXBASIC_LINE_1140:
; 1140  PRINT  AT 18,0; INK 2; PAPER 6;"\154\154\154\154\154\154\154\154\154\154\154\154\154\154\154\154\154\154\154\154\154\154\154\154\154\154\154\154\154\154\154\154"; AT 16,19; PAPER 0; INK 2;"\133"; INK 2; PAPER 6;"\155\155\155"; INK 2; PAPER 0;"\138"
	LD HL,1140
	LD (23621),HL
; 		1140.1  PRINT  AT 18{00 00 12 00 00 },0{00 00 00 00 00 }; INK 2{00 00 02 00 00 }; PAPER 6{00 00 06 00 00 };"\154\154\154\154\154\154\154\154\154\154\154\154\154\154\154\154\154\154\154\154\154\154\154\154\154\154\154\154\154\154\154\154"; AT 16{00 00 10 00 00 },19{00 00 13 00 00 }; PAPER 0{00 00 00 00 00 }; INK 2{00 00 02 00 00 };"\133"; INK 2{00 00 02 00 00 }; PAPER 6{00 00 06 00 00 };"\155\155\155"; INK 2{00 00 02 00 00 }; PAPER 0{00 00 00 00 00 };"\138"
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,18
	LD HL,0
	CALL runtimePrintAt
	LD HL,2
	CALL runtimeLocalInk
	LD HL,6
	CALL runtimeLocalPaper
	LD HL,STRING_20	;\9a\9a\9a\9a\9a\9a\9a\9a\9a\9a\9a\9a\9a\9a\9a\9a\9a\9a\9a\9a\9a\9a\9a\9a\9a\9a\9a\9a\9a\9a\9a\9a
	CALL runtimePrintString
	LD DE,16
	LD HL,19
	CALL runtimePrintAt
	LD HL,0
	CALL runtimeLocalPaper
	LD HL,2
	CALL runtimeLocalInk
	LD HL,STRING_21	;\85
	CALL runtimePrintString
	LD HL,2
	CALL runtimeLocalInk
	LD HL,6
	CALL runtimeLocalPaper
	LD HL,STRING_22	;\9b\9b\9b
	CALL runtimePrintString
	LD HL,2
	CALL runtimeLocalInk
	LD HL,0
	CALL runtimeLocalPaper
	LD HL,STRING_23	;\8a
	CALL runtimePrintString
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1150:
; 1150  FOR a=16 TO 17: PRINT  AT a,28; INK 6;"\159\159\159": NEXT a
	LD HL,1150
	LD (23621),HL
; 		1150.1  FOR a=16{00 00 10 00 00 } TO 17{00 00 11 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,16
	LD (ZXBASIC_VAR_a),HL
	LD HL,17
	LD (ZXBASIC_VAR_for_a),HL
FOR_4:
; 		1150.2  PRINT  AT a,28{00 00 1c 00 00 }; INK 6{00 00 06 00 00 };"\159\159\159"
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,(ZXBASIC_VAR_a)
	LD HL,28
	CALL runtimePrintAt
	LD HL,6
	CALL runtimeLocalInk
	LD HL,STRING_24	;\9f\9f\9f
	CALL runtimePrintString
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
; 		1150.3  NEXT a
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,(ZXBASIC_VAR_a)
	INC HL
	LD (ZXBASIC_VAR_a),HL
	LD DE,(ZXBASIC_VAR_for_a)
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_4
ZXBASIC_LINE_1160:
; 1160  PRINT  AT 15,23; INK 0; PAPER 2;"\154\154\154\154\154"; INK 2; PAPER 0;"\155\155\155"; AT 12,28; INK 2; PAPER 0;"\154\154\154"
	LD HL,1160
	LD (23621),HL
; 		1160.1  PRINT  AT 15{00 00 0f 00 00 },23{00 00 17 00 00 }; INK 0{00 00 00 00 00 }; PAPER 2{00 00 02 00 00 };"\154\154\154\154\154"; INK 2{00 00 02 00 00 }; PAPER 0{00 00 00 00 00 };"\155\155\155"; AT 12{00 00 0c 00 00 },28{00 00 1c 00 00 }; INK 2{00 00 02 00 00 }; PAPER 0{00 00 00 00 00 };"\154\154\154"
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,15
	LD HL,23
	CALL runtimePrintAt
	LD HL,0
	CALL runtimeLocalInk
	LD HL,2
	CALL runtimeLocalPaper
	LD HL,STRING_25	;\9a\9a\9a\9a\9a
	CALL runtimePrintString
	LD HL,2
	CALL runtimeLocalInk
	LD HL,0
	CALL runtimeLocalPaper
	LD HL,STRING_22	;\9b\9b\9b
	CALL runtimePrintString
	LD DE,12
	LD HL,28
	CALL runtimePrintAt
	LD HL,2
	CALL runtimeLocalInk
	LD HL,0
	CALL runtimeLocalPaper
	LD HL,STRING_26	;\9a\9a\9a
	CALL runtimePrintString
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1170:
; 1170  PRINT  AT 17,6; INK 2; INVERSE 0;"\151\157\151\157\151\157\151\157\151\157\151\157\151\157\151\157\151\138"; INK 0; AT 17,18; AT 10,15; INK 2; PAPER 6;"\155\155\155\155\155"
	LD HL,1170
	LD (23621),HL
; 		1170.1  PRINT  AT 17{00 00 11 00 00 },6{00 00 06 00 00 }; INK 2{00 00 02 00 00 }; INVERSE 0{00 00 00 00 00 };"\151\157\151\157\151\157\151\157\151\157\151\157\151\157\151\157\151\138"; INK 0{00 00 00 00 00 }; AT 17{00 00 11 00 00 },18{00 00 12 00 00 }; AT 10{00 00 0a 00 00 },15{00 00 0f 00 00 }; INK 2{00 00 02 00 00 }; PAPER 6{00 00 06 00 00 };"\155\155\155\155\155"
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,17
	LD HL,6
	CALL runtimePrintAt
	LD HL,2
	CALL runtimeLocalInk
	LD HL,0
	CALL runtimeLocalInverse
	LD HL,STRING_27	;\97\9d\97\9d\97\9d\97\9d\97\9d\97\9d\97\9d\97\9d\97\8a
	CALL runtimePrintString
	LD HL,0
	CALL runtimeLocalInk
	LD DE,17
	LD HL,18
	CALL runtimePrintAt
	LD DE,10
	LD HL,15
	CALL runtimePrintAt
	LD HL,2
	CALL runtimeLocalInk
	LD HL,6
	CALL runtimeLocalPaper
	LD HL,STRING_28	;\9b\9b\9b\9b\9b
	CALL runtimePrintString
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1180:
; 1180  PRINT  AT 11,7; INK 4; PAPER 0;"\155"; FLASH 1;"\162 TRUM \162 TRUM \162 TRUM "; FLASH 0; INK 4; PAPER 0;"\155"; AT 11,15; PAPER 4; INK 0;"\155\155\155\155\155"; AT 11,1; INK 2; PAPER 0;"\154\154\154\154"
	LD HL,1180
	LD (23621),HL
; 		1180.1  PRINT  AT 11{00 00 0b 00 00 },7{00 00 07 00 00 }; INK 4{00 00 04 00 00 }; PAPER 0{00 00 00 00 00 };"\155"; FLASH 1{00 00 01 00 00 };"\162 TRUM \162 TRUM \162 TRUM "; FLASH 0{00 00 00 00 00 }; INK 4{00 00 04 00 00 }; PAPER 0{00 00 00 00 00 };"\155"; AT 11{00 00 0b 00 00 },15{00 00 0f 00 00 }; PAPER 4{00 00 04 00 00 }; INK 0{00 00 00 00 00 };"\155\155\155\155\155"; AT 11{00 00 0b 00 00 },1{00 00 01 00 00 }; INK 2{00 00 02 00 00 }; PAPER 0{00 00 00 00 00 };"\154\154\154\154"
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,11
	LD HL,7
	CALL runtimePrintAt
	LD HL,4
	CALL runtimeLocalInk
	LD HL,0
	CALL runtimeLocalPaper
	LD HL,STRING_7	;\9b
	CALL runtimePrintString
	LD HL,1
	CALL runtimeLocalFlash
	LD HL,STRING_29	;\a2\a3\a2\a3\a2\a3
	CALL runtimePrintString
	LD HL,0
	CALL runtimeLocalFlash
	LD HL,4
	CALL runtimeLocalInk
	LD HL,0
	CALL runtimeLocalPaper
	LD HL,STRING_7	;\9b
	CALL runtimePrintString
	LD DE,11
	LD HL,15
	CALL runtimePrintAt
	LD HL,4
	CALL runtimeLocalPaper
	LD HL,0
	CALL runtimeLocalInk
	LD HL,STRING_28	;\9b\9b\9b\9b\9b
	CALL runtimePrintString
	LD DE,11
	LD HL,1
	CALL runtimePrintAt
	LD HL,2
	CALL runtimeLocalInk
	LD HL,0
	CALL runtimeLocalPaper
	LD HL,STRING_9	;\9a\9a\9a\9a
	CALL runtimePrintString
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1190:
; 1190  PRINT  AT 11,20; INK 0; PAPER 4; INVERSE 1;"\155"; PAPER 0; INK 4; FLASH 1; INVERSE 0;"\162 TRUM \162 TRUM "; FLASH 0; PAPER 0; INK 4;"\155"; AT 8,1; PAPER 0; INK 2;"\154\154\154"
	LD HL,1190
	LD (23621),HL
; 		1190.1  PRINT  AT 11{00 00 0b 00 00 },20{00 00 14 00 00 }; INK 0{00 00 00 00 00 }; PAPER 4{00 00 04 00 00 }; INVERSE 1{00 00 01 00 00 };"\155"; PAPER 0{00 00 00 00 00 }; INK 4{00 00 04 00 00 }; FLASH 1{00 00 01 00 00 }; INVERSE 0{00 00 00 00 00 };"\162 TRUM \162 TRUM "; FLASH 0{00 00 00 00 00 }; PAPER 0{00 00 00 00 00 }; INK 4{00 00 04 00 00 };"\155"; AT 8{00 00 08 00 00 },1{00 00 01 00 00 }; PAPER 0{00 00 00 00 00 }; INK 2{00 00 02 00 00 };"\154\154\154"
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,11
	LD HL,20
	CALL runtimePrintAt
	LD HL,0
	CALL runtimeLocalInk
	LD HL,4
	CALL runtimeLocalPaper
	LD HL,1
	CALL runtimeLocalInverse
	LD HL,STRING_7	;\9b
	CALL runtimePrintString
	LD HL,0
	CALL runtimeLocalPaper
	LD HL,4
	CALL runtimeLocalInk
	LD HL,1
	CALL runtimeLocalFlash
	LD HL,0
	CALL runtimeLocalInverse
	LD HL,STRING_8	;\a2\a3\a2\a3
	CALL runtimePrintString
	LD HL,0
	CALL runtimeLocalFlash
	LD HL,0
	CALL runtimeLocalPaper
	LD HL,4
	CALL runtimeLocalInk
	LD HL,STRING_7	;\9b
	CALL runtimePrintString
	LD DE,8
	LD HL,1
	CALL runtimePrintAt
	LD HL,0
	CALL runtimeLocalPaper
	LD HL,2
	CALL runtimeLocalInk
	LD HL,STRING_26	;\9a\9a\9a
	CALL runtimePrintString
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1200:
; 1200  PRINT  AT 5,1; INK 2;"\154\154\154\154\154\154\154\154\154"; PAPER 2; INK 0;"\154\154\154\154"; INK 2; PAPER 0;"\154\154\154\154\154\154\154"; AT 5,21; INK 0; PAPER 2;"\154\154\154"; AT 5,24; INK 2; PAPER 0;"\154\154\154\154\154\154\154"
	LD HL,1200
	LD (23621),HL
; 		1200.1  PRINT  AT 5{00 00 05 00 00 },1{00 00 01 00 00 }; INK 2{00 00 02 00 00 };"\154\154\154\154\154\154\154\154\154"; PAPER 2{00 00 02 00 00 }; INK 0{00 00 00 00 00 };"\154\154\154\154"; INK 2{00 00 02 00 00 }; PAPER 0{00 00 00 00 00 };"\154\154\154\154\154\154\154"; AT 5{00 00 05 00 00 },21{00 00 15 00 00 }; INK 0{00 00 00 00 00 }; PAPER 2{00 00 02 00 00 };"\154\154\154"; AT 5{00 00 05 00 00 },24{00 00 18 00 00 }; INK 2{00 00 02 00 00 }; PAPER 0{00 00 00 00 00 };"\154\154\154\154\154\154\154"
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,5
	LD HL,1
	CALL runtimePrintAt
	LD HL,2
	CALL runtimeLocalInk
	LD HL,STRING_30	;\9a\9a\9a\9a\9a\9a\9a\9a\9a
	CALL runtimePrintString
	LD HL,2
	CALL runtimeLocalPaper
	LD HL,0
	CALL runtimeLocalInk
	LD HL,STRING_9	;\9a\9a\9a\9a
	CALL runtimePrintString
	LD HL,2
	CALL runtimeLocalInk
	LD HL,0
	CALL runtimeLocalPaper
	LD HL,STRING_10	;\9a\9a\9a\9a\9a\9a\9a
	CALL runtimePrintString
	LD DE,5
	LD HL,21
	CALL runtimePrintAt
	LD HL,0
	CALL runtimeLocalInk
	LD HL,2
	CALL runtimeLocalPaper
	LD HL,STRING_26	;\9a\9a\9a
	CALL runtimePrintString
	LD DE,5
	LD HL,24
	CALL runtimePrintAt
	LD HL,2
	CALL runtimeLocalInk
	LD HL,0
	CALL runtimeLocalPaper
	LD HL,STRING_10	;\9a\9a\9a\9a\9a\9a\9a
	CALL runtimePrintString
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1210:
; 1210  PRINT  AT 19,0; PAPER 6; INK 0;"       The BASIC Cavern         "
	LD HL,1210
	LD (23621),HL
; 		1210.1  PRINT  AT 19{00 00 13 00 00 },0{00 00 00 00 00 }; PAPER 6{00 00 06 00 00 }; INK 0{00 00 00 00 00 };"       The BASIC Cavern         "
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,19
	LD HL,0
	CALL runtimePrintAt
	LD HL,6
	CALL runtimeLocalPaper
	LD HL,0
	CALL runtimeLocalInk
	LD HL,STRING_31	;       The BASIC Cavern         
	CALL runtimePrintString
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1220:
; 1220  FOR w=0 TO 19: PRINT  AT w,0; INK 2; PAPER 6;"\137"; AT w,31; INK 2; PAPER 6;"\134": NEXT w: PAPER 0: PRINT  AT 0,9; PAPER 6; INK 0;"\152"; AT 1,18; PAPER 6; INK 0;"\152"; AT 0,28; PAPER 6; INK 0;"\152"; AT 4,25; PAPER 6; INK 0;"\152"; AT 7,30; PAPER 6; INK 0;"\152"
	LD HL,1220
	LD (23621),HL
; 		1220.1  FOR w=0{00 00 00 00 00 } TO 19{00 00 13 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,0
	LD (ZXBASIC_VAR_w),HL
	LD HL,19
	LD (ZXBASIC_VAR_for_w),HL
FOR_5:
; 		1220.2  PRINT  AT w,0{00 00 00 00 00 }; INK 2{00 00 02 00 00 }; PAPER 6{00 00 06 00 00 };"\137"; AT w,31{00 00 1f 00 00 }; INK 2{00 00 02 00 00 }; PAPER 6{00 00 06 00 00 };"\134"
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,(ZXBASIC_VAR_w)
	LD HL,0
	CALL runtimePrintAt
	LD HL,2
	CALL runtimeLocalInk
	LD HL,6
	CALL runtimeLocalPaper
	LD HL,STRING_32	;\89
	CALL runtimePrintString
	LD DE,(ZXBASIC_VAR_w)
	LD HL,31
	CALL runtimePrintAt
	LD HL,2
	CALL runtimeLocalInk
	LD HL,6
	CALL runtimeLocalPaper
	LD HL,STRING_33	;\86
	CALL runtimePrintString
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
; 		1220.3  NEXT w
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,(ZXBASIC_VAR_w)
	INC HL
	LD (ZXBASIC_VAR_w),HL
	LD DE,(ZXBASIC_VAR_for_w)
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_5
; 		1220.4  PAPER 0{00 00 00 00 00 }
	LD A,4
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,0
	CALL runtimePaper
; 		1220.5  PRINT  AT 0{00 00 00 00 00 },9{00 00 09 00 00 }; PAPER 6{00 00 06 00 00 }; INK 0{00 00 00 00 00 };"\152"; AT 1{00 00 01 00 00 },18{00 00 12 00 00 }; PAPER 6{00 00 06 00 00 }; INK 0{00 00 00 00 00 };"\152"; AT 0{00 00 00 00 00 },28{00 00 1c 00 00 }; PAPER 6{00 00 06 00 00 }; INK 0{00 00 00 00 00 };"\152"; AT 4{00 00 04 00 00 },25{00 00 19 00 00 }; PAPER 6{00 00 06 00 00 }; INK 0{00 00 00 00 00 };"\152"; AT 7{00 00 07 00 00 },30{00 00 1e 00 00 }; PAPER 6{00 00 06 00 00 }; INK 0{00 00 00 00 00 };"\152"
	LD A,5
	LD (23623),a
	CALL runtimeCheckBreak
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,0
	LD HL,9
	CALL runtimePrintAt
	LD HL,6
	CALL runtimeLocalPaper
	LD HL,0
	CALL runtimeLocalInk
	LD HL,STRING_34	;\98
	CALL runtimePrintString
	LD DE,1
	LD HL,18
	CALL runtimePrintAt
	LD HL,6
	CALL runtimeLocalPaper
	LD HL,0
	CALL runtimeLocalInk
	LD HL,STRING_34	;\98
	CALL runtimePrintString
	LD DE,0
	LD HL,28
	CALL runtimePrintAt
	LD HL,6
	CALL runtimeLocalPaper
	LD HL,0
	CALL runtimeLocalInk
	LD HL,STRING_34	;\98
	CALL runtimePrintString
	LD DE,4
	LD HL,25
	CALL runtimePrintAt
	LD HL,6
	CALL runtimeLocalPaper
	LD HL,0
	CALL runtimeLocalInk
	LD HL,STRING_34	;\98
	CALL runtimePrintString
	LD DE,7
	LD HL,30
	CALL runtimePrintAt
	LD HL,6
	CALL runtimeLocalPaper
	LD HL,0
	CALL runtimeLocalInk
	LD HL,STRING_34	;\98
	CALL runtimePrintString
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1230:
; 1230  PRINT  AT 0,12; INK 3;"\151"; AT 0,17; INK 3;"\151"; AT 16,10; INK 0; PAPER 4;"\153"; AT 10,20; INK 0; PAPER 4;"\153"; AT 4,24; INK 0; PAPER 4;"\153"; AT 4,27; INK 0; PAPER 4;"\153"; PAPER 0
	LD HL,1230
	LD (23621),HL
; 		1230.1  PRINT  AT 0{00 00 00 00 00 },12{00 00 0c 00 00 }; INK 3{00 00 03 00 00 };"\151"; AT 0{00 00 00 00 00 },17{00 00 11 00 00 }; INK 3{00 00 03 00 00 };"\151"; AT 16{00 00 10 00 00 },10{00 00 0a 00 00 }; INK 0{00 00 00 00 00 }; PAPER 4{00 00 04 00 00 };"\153"; AT 10{00 00 0a 00 00 },20{00 00 14 00 00 }; INK 0{00 00 00 00 00 }; PAPER 4{00 00 04 00 00 };"\153"; AT 4{00 00 04 00 00 },24{00 00 18 00 00 }; INK 0{00 00 00 00 00 }; PAPER 4{00 00 04 00 00 };"\153"; AT 4{00 00 04 00 00 },27{00 00 1b 00 00 }; INK 0{00 00 00 00 00 }; PAPER 4{00 00 04 00 00 };"\153"; PAPER 0{00 00 00 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,0
	LD HL,12
	CALL runtimePrintAt
	LD HL,3
	CALL runtimeLocalInk
	LD HL,STRING_35	;\97
	CALL runtimePrintString
	LD DE,0
	LD HL,17
	CALL runtimePrintAt
	LD HL,3
	CALL runtimeLocalInk
	LD HL,STRING_35	;\97
	CALL runtimePrintString
	LD DE,16
	LD HL,10
	CALL runtimePrintAt
	LD HL,0
	CALL runtimeLocalInk
	LD HL,4
	CALL runtimeLocalPaper
	LD HL,STRING_36	;\99
	CALL runtimePrintString
	LD DE,10
	LD HL,20
	CALL runtimePrintAt
	LD HL,0
	CALL runtimeLocalInk
	LD HL,4
	CALL runtimeLocalPaper
	LD HL,STRING_36	;\99
	CALL runtimePrintString
	LD DE,4
	LD HL,24
	CALL runtimePrintAt
	LD HL,0
	CALL runtimeLocalInk
	LD HL,4
	CALL runtimeLocalPaper
	LD HL,STRING_36	;\99
	CALL runtimePrintString
	LD DE,4
	LD HL,27
	CALL runtimePrintAt
	LD HL,0
	CALL runtimeLocalInk
	LD HL,4
	CALL runtimeLocalPaper
	LD HL,STRING_36	;\99
	CALL runtimePrintString
	LD HL,0
	CALL runtimeLocalPaper
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1240:
; 1240  LET oy=y: LET ox=x
	LD HL,1240
	LD (23621),HL
; 		1240.1  LET oy=y
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,(ZXBASIC_VAR_y)
	LD (ZXBASIC_VAR_oy),HL
; 		1240.2  LET ox=x
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,(ZXBASIC_VAR_x)
	LD (ZXBASIC_VAR_ox),HL
ZXBASIC_LINE_1250:
; 1250  RETURN 
	LD HL,1250
	LD (23621),HL
; 		1250.1  RETURN 
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	RET
ZXBASIC_LINE_1410:
; 1410  REM *** UGDS ***
	LD HL,1410
	LD (23621),HL
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
ZXBASIC_LINE_1420:
; 1420  FOR g=0 TO 167
	LD HL,1420
	LD (23621),HL
; 		1420.1  FOR g=0{00 00 00 00 00 } TO 167{00 00 a7 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,0
	LD (ZXBASIC_VAR_g),HL
	LD HL,167
	LD (ZXBASIC_VAR_for_g),HL
FOR_6:
ZXBASIC_LINE_1430:
; 1430  READ dat
	LD HL,1430
	LD (23621),HL
; 		1430.1  READ dat
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,(DATAPTR)
	LD DE,(HL)
	INC HL
	INC HL
	LD (DATAPTR),HL
	LD (ZXBASIC_VAR_dat),DE
ZXBASIC_LINE_1440:
; 1440  POKE  USR "a"+g,dat
	LD HL,1440
	LD (23621),HL
; 		1440.1  POKE  USR "a"+g,dat
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
; USR
	LD HL,STRING_37	;a
	CALL runtimeUsrUDG
	LD DE,HL
	LD HL,(ZXBASIC_VAR_g)
; +
	ADD HL,DE
	LD DE,(ZXBASIC_VAR_dat)
	LD (HL),E
ZXBASIC_LINE_1450:
; 1450  NEXT g
	LD HL,1450
	LD (23621),HL
; 		1450.1  NEXT g
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,(ZXBASIC_VAR_g)
	INC HL
	LD (ZXBASIC_VAR_g),HL
	LD DE,(ZXBASIC_VAR_for_g)
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_6
ZXBASIC_LINE_1460:
; 1460  DATA 192,252,126,124,92,252,124,124
	LD HL,1460
	LD (23621),HL
; 		1460.1  DATA 192{00 00 c0 00 00 },252{00 00 fc 00 00 },126{00 00 7e 00 00 },124{00 00 7c 00 00 },92{00 00 5c 00 00 },252{00 00 fc 00 00 },124{00 00 7c 00 00 },124{00 00 7c 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
ZXBASIC_LINE_1470:
; 1470  DATA 24,62,127,221,28,182,227,71
	LD HL,1470
	LD (23621),HL
; 		1470.1  DATA 24{00 00 18 00 00 },62{00 00 3e 00 00 },127{00 00 7f 00 00 },221{00 00 dd 00 00 },28{00 00 1c 00 00 },182{00 00 b6 00 00 },227{00 00 e3 00 00 },71{00 00 47 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
ZXBASIC_LINE_1480:
; 1480  DATA 24,56,124,118,126,60,108,126
	LD HL,1480
	LD (23621),HL
; 		1480.1  DATA 24{00 00 18 00 00 },56{00 00 38 00 00 },124{00 00 7c 00 00 },118{00 00 76 00 00 },126{00 00 7e 00 00 },60{00 00 3c 00 00 },108{00 00 6c 00 00 },126{00 00 7e 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
ZXBASIC_LINE_1490:
; 1490  DATA 24,28,62,110,126,60,54,126
	LD HL,1490
	LD (23621),HL
; 		1490.1  DATA 24{00 00 18 00 00 },28{00 00 1c 00 00 },62{00 00 3e 00 00 },110{00 00 6e 00 00 },126{00 00 7e 00 00 },60{00 00 3c 00 00 },54{00 00 36 00 00 },126{00 00 7e 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
ZXBASIC_LINE_1500:
; 1500  DATA 28,190,231,231,190,28,62,255
	LD HL,1500
	LD (23621),HL
; 		1500.1  DATA 28{00 00 1c 00 00 },190{00 00 be 00 00 },231{00 00 e7 00 00 },231{00 00 e7 00 00 },190{00 00 be 00 00 },28{00 00 1c 00 00 },62{00 00 3e 00 00 },255{00 00 ff 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
ZXBASIC_LINE_1510:
; 1510  DATA 56,125,231,231,125,56,124,255
	LD HL,1510
	LD (23621),HL
; 		1510.1  DATA 56{00 00 38 00 00 },125{00 00 7d 00 00 },231{00 00 e7 00 00 },231{00 00 e7 00 00 },125{00 00 7d 00 00 },56{00 00 38 00 00 },124{00 00 7c 00 00 },255{00 00 ff 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
ZXBASIC_LINE_1520:
; 1520   DATA 247,14,124,56,24,24,60,255
	LD HL,1520
	LD (23621),HL
; 		1520.1  DATA 247{00 00 f7 00 00 },14{00 00 0e 00 00 },124{00 00 7c 00 00 },56{00 00 38 00 00 },24{00 00 18 00 00 },24{00 00 18 00 00 },60{00 00 3c 00 00 },255{00 00 ff 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
ZXBASIC_LINE_1530:
; 1530  DATA 255,255,127,118,54,52,16,16
	LD HL,1530
	LD (23621),HL
; 		1530.1  DATA 255{00 00 ff 00 00 },255{00 00 ff 00 00 },127{00 00 7f 00 00 },118{00 00 76 00 00 },54{00 00 36 00 00 },52{00 00 34 00 00 },16{00 00 10 00 00 },16{00 00 10 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
ZXBASIC_LINE_1540:
; 1540  DATA 227,221,235,247,247,243,241,247
	LD HL,1540
	LD (23621),HL
; 		1540.1  DATA 227{00 00 e3 00 00 },221{00 00 dd 00 00 },235{00 00 eb 00 00 },247{00 00 f7 00 00 },247{00 00 f7 00 00 },243{00 00 f3 00 00 },241{00 00 f1 00 00 },247{00 00 f7 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
ZXBASIC_LINE_1550:
; 1550  DATA 251,251,107,171,166,181,149,193
	LD HL,1550
	LD (23621),HL
; 		1550.1  DATA 251{00 00 fb 00 00 },251{00 00 fb 00 00 },107{00 00 6b 00 00 },171{00 00 ab 00 00 },166{00 00 a6 00 00 },181{00 00 b5 00 00 },149{00 00 95 00 00 },193{00 00 c1 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
ZXBASIC_LINE_1560:
; 1560  DATA 255,255,219,183,255,109,73,146
	LD HL,1560
	LD (23621),HL
; 		1560.1  DATA 255{00 00 ff 00 00 },255{00 00 ff 00 00 },219{00 00 db 00 00 },183{00 00 b7 00 00 },255{00 00 ff 00 00 },109{00 00 6d 00 00 },73{00 00 49 00 00 },146{00 00 92 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
ZXBASIC_LINE_1570:
; 1570  DATA 255,255,24,24,255,24,129,255
	LD HL,1570
	LD (23621),HL
; 		1570.1  DATA 255{00 00 ff 00 00 },255{00 00 ff 00 00 },24{00 00 18 00 00 },24{00 00 18 00 00 },255{00 00 ff 00 00 },24{00 00 18 00 00 },129{00 00 81 00 00 },255{00 00 ff 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
ZXBASIC_LINE_1580:
; 1580  DATA 239,112,62,28,24,24,60,255
	LD HL,1580
	LD (23621),HL
; 		1580.1  DATA 239{00 00 ef 00 00 },112{00 00 70 00 00 },62{00 00 3e 00 00 },28{00 00 1c 00 00 },24{00 00 18 00 00 },24{00 00 18 00 00 },60{00 00 3c 00 00 },255{00 00 ff 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
ZXBASIC_LINE_1590:
; 1590  DATA 255,255,255,255,182,109,73,146
	LD HL,1590
	LD (23621),HL
; 		1590.1  DATA 255{00 00 ff 00 00 },255{00 00 ff 00 00 },255{00 00 ff 00 00 },255{00 00 ff 00 00 },182{00 00 b6 00 00 },109{00 00 6d 00 00 },73{00 00 49 00 00 },146{00 00 92 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
ZXBASIC_LINE_1600:
; 1600  DATA 136,248,136,142,137,129,145,255
	LD HL,1600
	LD (23621),HL
; 		1600.1  DATA 136{00 00 88 00 00 },248{00 00 f8 00 00 },136{00 00 88 00 00 },142{00 00 8e 00 00 },137{00 00 89 00 00 },129{00 00 81 00 00 },145{00 00 91 00 00 },255{00 00 ff 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
ZXBASIC_LINE_1610:
; 1610  DATA 216,168,216,168,216,168,216,168
	LD HL,1610
	LD (23621),HL
; 		1610.1  DATA 216{00 00 d8 00 00 },168{00 00 a8 00 00 },216{00 00 d8 00 00 },168{00 00 a8 00 00 },216{00 00 d8 00 00 },168{00 00 a8 00 00 },216{00 00 d8 00 00 },168{00 00 a8 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
ZXBASIC_LINE_1620:
; 1620  DATA 3,63,126,62,58,63,62,62
	LD HL,1620
	LD (23621),HL
; 		1620.1  DATA 3{00 00 03 00 00 },63{00 00 3f 00 00 },126{00 00 7e 00 00 },62{00 00 3e 00 00 },58{00 00 3a 00 00 },63{00 00 3f 00 00 },62{00 00 3e 00 00 },62{00 00 3e 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
ZXBASIC_LINE_1630:
; 1630  DATA 24,124,254,187,56,109,199,226
	LD HL,1630
	LD (23621),HL
; 		1630.1  DATA 24{00 00 18 00 00 },124{00 00 7c 00 00 },254{00 00 fe 00 00 },187{00 00 bb 00 00 },56{00 00 38 00 00 },109{00 00 6d 00 00 },199{00 00 c7 00 00 },226{00 00 e2 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
ZXBASIC_LINE_1640:
; 1640  DATA 24,24,24,24,231,231,231,231
	LD HL,1640
	LD (23621),HL
; 		1640.1  DATA 24{00 00 18 00 00 },24{00 00 18 00 00 },24{00 00 18 00 00 },24{00 00 18 00 00 },231{00 00 e7 00 00 },231{00 00 e7 00 00 },231{00 00 e7 00 00 },231{00 00 e7 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
ZXBASIC_LINE_1650:
; 1650  DATA 231,231,231,231,24,24,24,24
	LD HL,1650
	LD (23621),HL
; 		1650.1  DATA 231{00 00 e7 00 00 },231{00 00 e7 00 00 },231{00 00 e7 00 00 },231{00 00 e7 00 00 },24{00 00 18 00 00 },24{00 00 18 00 00 },24{00 00 18 00 00 },24{00 00 18 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
ZXBASIC_LINE_1660:
; 1660  DATA 220,223,37,221,223,38,252,120
	LD HL,1660
	LD (23621),HL
; 		1660.1  DATA 220{00 00 dc 00 00 },223{00 00 df 00 00 },37{00 00 25 00 00 },221{00 00 dd 00 00 },223{00 00 df 00 00 },38{00 00 26 00 00 },252{00 00 fc 00 00 },120{00 00 78 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
ZXBASIC_LINE_1670:
; 1670  RETURN 
	LD HL,1670
	LD (23621),HL
; 		1670.1  RETURN 
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	RET
ZXBASIC_LINE_1680:
; 1680  REM *** BOOT CRUSH ***
	LD HL,1680
	LD (23621),HL
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
ZXBASIC_LINE_1690:
; 1690  CLS : BRIGHT 1: PAPER 1: INK 7: CLS : PAPER 1: CLS 
	LD HL,1690
	LD (23621),HL
; 		1690.1  CLS 
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	CALL runtimeCls
; 		1690.2  BRIGHT 1{00 00 01 00 00 }
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,1
	CALL runtimeBright
; 		1690.3  PAPER 1{00 00 01 00 00 }
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,1
	CALL runtimePaper
; 		1690.4  INK 7{00 00 07 00 00 }
	LD A,4
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,7
	CALL runtimeInk
; 		1690.5  CLS 
	LD A,5
	LD (23623),a
	CALL runtimeCheckBreak
	CALL runtimeCls
; 		1690.6  PAPER 1{00 00 01 00 00 }
	LD A,6
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,1
	CALL runtimePaper
; 		1690.7  CLS 
	LD A,7
	LD (23623),a
	CALL runtimeCheckBreak
	CALL runtimeCls
ZXBASIC_LINE_1700:
; 1700  PRINT  AT 18,0; INK 2; PAPER 6;"\154\154\154\154\154\154\154\154\154\154\154\154\154\154\154\154\154\154\154\154\154\154\154\154\154\154\154\154\154\154\154\154"; AT 19,0; PAPER 6; INK 0;"         The Final Step         "
	LD HL,1700
	LD (23621),HL
; 		1700.1  PRINT  AT 18{00 00 12 00 00 },0{00 00 00 00 00 }; INK 2{00 00 02 00 00 }; PAPER 6{00 00 06 00 00 };"\154\154\154\154\154\154\154\154\154\154\154\154\154\154\154\154\154\154\154\154\154\154\154\154\154\154\154\154\154\154\154\154"; AT 19{00 00 13 00 00 },0{00 00 00 00 00 }; PAPER 6{00 00 06 00 00 }; INK 0{00 00 00 00 00 };"         The Final Step         "
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,18
	LD HL,0
	CALL runtimePrintAt
	LD HL,2
	CALL runtimeLocalInk
	LD HL,6
	CALL runtimeLocalPaper
	LD HL,STRING_20	;\9a\9a\9a\9a\9a\9a\9a\9a\9a\9a\9a\9a\9a\9a\9a\9a\9a\9a\9a\9a\9a\9a\9a\9a\9a\9a\9a\9a\9a\9a\9a\9a
	CALL runtimePrintString
	LD DE,19
	LD HL,0
	CALL runtimePrintAt
	LD HL,6
	CALL runtimeLocalPaper
	LD HL,0
	CALL runtimeLocalInk
	LD HL,STRING_38	;         The Final Step         
	CALL runtimePrintString
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1705:
; 1705  GOSUB 790
	LD HL,1705
	LD (23621),HL
; 		1705.1  GOSUB 790{00 00 16 03 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_790
ZXBASIC_LINE_1710:
; 1710  PRINT  AT 14,15;"\160"; AT 15,15;"\146"; AT 16,15; INK 7;"\155"; AT 17,15; INK 7;"\143"
	LD HL,1710
	LD (23621),HL
; 		1710.1  PRINT  AT 14{00 00 0e 00 00 },15{00 00 0f 00 00 };"\160"; AT 15{00 00 0f 00 00 },15{00 00 0f 00 00 };"\146"; AT 16{00 00 10 00 00 },15{00 00 0f 00 00 }; INK 7{00 00 07 00 00 };"\155"; AT 17{00 00 11 00 00 },15{00 00 0f 00 00 }; INK 7{00 00 07 00 00 };"\143"
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,14
	LD HL,15
	CALL runtimePrintAt
	LD HL,STRING_13	;\a0
	CALL runtimePrintString
	LD DE,15
	LD HL,15
	CALL runtimePrintAt
	LD HL,STRING_39	;\92
	CALL runtimePrintString
	LD DE,16
	LD HL,15
	CALL runtimePrintAt
	LD HL,7
	CALL runtimeLocalInk
	LD HL,STRING_7	;\9b
	CALL runtimePrintString
	LD DE,17
	LD HL,15
	CALL runtimePrintAt
	LD HL,7
	CALL runtimeLocalInk
	LD HL,STRING_40	;\8f
	CALL runtimePrintString
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1720:
; 1720  FOR b=1 TO 15: FOR a=1 TO 10: NEXT a
	LD HL,1720
	LD (23621),HL
; 		1720.1  FOR b=1{00 00 01 00 00 } TO 15{00 00 0f 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,1
	LD (ZXBASIC_VAR_b),HL
	LD HL,15
	LD (ZXBASIC_VAR_for_b),HL
FOR_7:
; 		1720.2  FOR a=1{00 00 01 00 00 } TO 10{00 00 0a 00 00 }
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,1
	LD (ZXBASIC_VAR_a),HL
	LD HL,10
	LD (ZXBASIC_VAR_for_a),HL
FOR_8:
; 		1720.3  NEXT a
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,(ZXBASIC_VAR_a)
	INC HL
	LD (ZXBASIC_VAR_a),HL
	LD DE,(ZXBASIC_VAR_for_a)
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_8
ZXBASIC_LINE_1730:
; 1730  BEEP .006,b*2
	LD HL,1730
	LD (23621),HL
; 		1730.1  BEEP .006{79 44 9b a5 e3 },b*2{00 00 02 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,FLOAT_10	;.006
	CALL runtimePushFloatVar
	LD DE,(ZXBASIC_VAR_b)
	LD HL,2
; *
	call runtimeMult16bit
	CALL runtimeIntToFloat
	CALL $03F8
ZXBASIC_LINE_1740:
; 1740  PRINT  AT b-1,15;"\159"; AT b,15;"\158"
	LD HL,1740
	LD (23621),HL
; 		1740.1  PRINT  AT b-1{00 00 01 00 00 },15{00 00 0f 00 00 };"\159"; AT b,15{00 00 0f 00 00 };"\158"
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,(ZXBASIC_VAR_b)
	LD DE,1
; -
	SUB HL,DE
	LD DE,HL
	LD HL,15
	CALL runtimePrintAt
	LD HL,STRING_41	;\9f
	CALL runtimePrintString
	LD DE,(ZXBASIC_VAR_b)
	LD HL,15
	CALL runtimePrintAt
	LD HL,STRING_42	;\9e
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1750:
; 1750  NEXT b
	LD HL,1750
	LD (23621),HL
; 		1750.1  NEXT b
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,(ZXBASIC_VAR_b)
	INC HL
	LD (ZXBASIC_VAR_b),HL
	LD DE,(ZXBASIC_VAR_for_b)
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_7
ZXBASIC_LINE_1760:
; 1760  FOR i=40 TO 30 STEP -1: BEEP .02,i: NEXT i
	LD HL,1760
	LD (23621),HL
; 		1760.1  FOR i=40{00 00 28 00 00 } TO 30{00 00 1e 00 00 } STEP -1{00 00 01 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,40
	LD (ZXBASIC_VAR_i),HL
	LD HL,30
	LD (ZXBASIC_VAR_for_i),HL
	LD HL,1
	LD BC,HL
; -
	LD HL,0
	SUB HL,BC
	LD (ZXBASIC_VAR_for_i_step),HL
FOR_9:
; 		1760.2  BEEP .02{7b 23 d7 0a 3d },i
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,FLOAT_6	;.02
	CALL runtimePushFloatVar
	LD HL,(ZXBASIC_VAR_i)
	CALL runtimeIntToFloat
	CALL $03F8
; 		1760.3  NEXT i
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,(ZXBASIC_VAR_i)
	LD BC,(ZXBASIC_VAR_for_i_step)
	LD A,B
	ADD HL,BC
	LD (ZXBASIC_VAR_i),HL
	LD DE,(ZXBASIC_VAR_for_i)
	AND $80
	JR Z,FOR_9_1
	SUB HL,DE
	JP Z,FOR_9_2
	JP NC,FOR_9
	JR FOR_9_2
FOR_9_1:
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_9
FOR_9_2:
ZXBASIC_LINE_1770:
; 1770  FOR u=1 TO 3: FOR p=40 TO 10 STEP -1: BEEP .02,p: BORDER  INT ( RND *5)+1: NEXT p: NEXT u
	LD HL,1770
	LD (23621),HL
; 		1770.1  FOR u=1{00 00 01 00 00 } TO 3{00 00 03 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,1
	LD (ZXBASIC_VAR_u),HL
	LD HL,3
	LD (ZXBASIC_VAR_for_u),HL
FOR_10:
; 		1770.2  FOR p=40{00 00 28 00 00 } TO 10{00 00 0a 00 00 } STEP -1{00 00 01 00 00 }
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,40
	LD (ZXBASIC_VAR_p),HL
	LD HL,10
	LD (ZXBASIC_VAR_for_p),HL
	LD HL,1
	LD BC,HL
; -
	LD HL,0
	SUB HL,BC
	LD (ZXBASIC_VAR_for_p_step),HL
FOR_11:
; 		1770.3  BEEP .02{7b 23 d7 0a 3d },p
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,FLOAT_6	;.02
	CALL runtimePushFloatVar
	LD HL,(ZXBASIC_VAR_p)
	CALL runtimeIntToFloat
	CALL $03F8
; 		1770.4  BORDER  INT ( RND *5{00 00 05 00 00 })+1{00 00 01 00 00 }
	LD A,4
	LD (23623),a
	CALL runtimeCheckBreak
; INT
; RND
	CALL runtimeRND
	LD HL,5
; *
	CALL runtimeIntToFloat
	RST $28
	DB $04	;MULT
	DB $38	;END CALC
	CALL runtimeFloatToInt
	INC HL
; +
	LD A,L
	call $2297
; 		1770.5  NEXT p
	LD A,5
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,(ZXBASIC_VAR_p)
	LD BC,(ZXBASIC_VAR_for_p_step)
	LD A,B
	ADD HL,BC
	LD (ZXBASIC_VAR_p),HL
	LD DE,(ZXBASIC_VAR_for_p)
	AND $80
	JR Z,FOR_11_1
	SUB HL,DE
	JP Z,FOR_11_2
	JP NC,FOR_11
	JR FOR_11_2
FOR_11_1:
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_11
FOR_11_2:
; 		1770.6  NEXT u
	LD A,6
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,(ZXBASIC_VAR_u)
	INC HL
	LD (ZXBASIC_VAR_u),HL
	LD DE,(ZXBASIC_VAR_for_u)
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_10
ZXBASIC_LINE_1780:
; 1780  IF win=0 THEN  PRINT  AT 10,9; FLASH 1; INK 2;"GAME"; FLASH 0; AT 10,17; FLASH 1;"OVER"; FLASH 0: BORDER 2
	LD HL,1780
	LD (23621),HL
; 		1780.1  IF win=0{00 00 00 00 00 } THEN  PRINT  AT 10{00 00 0a 00 00 },9{00 00 09 00 00 }; FLASH 1{00 00 01 00 00 }; INK 2{00 00 02 00 00 };"GAME"; FLASH 0{00 00 00 00 00 }; AT 10{00 00 0a 00 00 },17{00 00 11 00 00 }; FLASH 1{00 00 01 00 00 };"OVER"; FLASH 0{00 00 00 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD DE,(ZXBASIC_VAR_win)
	LD HL,0
; =
	CALL runtimeCmpHLEqDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_44
; 		1780.2  PRINT  AT 10{00 00 0a 00 00 },9{00 00 09 00 00 }; FLASH 1{00 00 01 00 00 }; INK 2{00 00 02 00 00 };"GAME"; FLASH 0{00 00 00 00 00 }; AT 10{00 00 0a 00 00 },17{00 00 11 00 00 }; FLASH 1{00 00 01 00 00 };"OVER"; FLASH 0{00 00 00 00 00 }
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,10
	LD HL,9
	CALL runtimePrintAt
	LD HL,1
	CALL runtimeLocalFlash
	LD HL,2
	CALL runtimeLocalInk
	LD HL,STRING_43	;GAME
	CALL runtimePrintString
	LD HL,0
	CALL runtimeLocalFlash
	LD DE,10
	LD HL,17
	CALL runtimePrintAt
	LD HL,1
	CALL runtimeLocalFlash
	LD HL,STRING_44	;OVER
	CALL runtimePrintString
	LD HL,0
	CALL runtimeLocalFlash
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
; 		1780.3  BORDER 2{00 00 02 00 00 }
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,2
	LD A,L
	call $2297
ZXB_LABEL_44:
ZXBASIC_LINE_1785:
; 1785  IF win=1 THEN  PRINT  AT 16,9; FLASH 1;"CONGRATULATIONS"; AT 17,5;"MINER WILLY IS NOW FREE"
	LD HL,1785
	LD (23621),HL
; 		1785.1  IF win=1{00 00 01 00 00 } THEN  PRINT  AT 16{00 00 10 00 00 },9{00 00 09 00 00 }; FLASH 1{00 00 01 00 00 };"CONGRATULATIONS"; AT 17{00 00 11 00 00 },5{00 00 05 00 00 };"MINER WILLY IS NOW FREE"
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD DE,(ZXBASIC_VAR_win)
	LD HL,1
; =
	CALL runtimeCmpHLEqDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_45
; 		1785.2  PRINT  AT 16{00 00 10 00 00 },9{00 00 09 00 00 }; FLASH 1{00 00 01 00 00 };"CONGRATULATIONS"; AT 17{00 00 11 00 00 },5{00 00 05 00 00 };"MINER WILLY IS NOW FREE"
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,16
	LD HL,9
	CALL runtimePrintAt
	LD HL,1
	CALL runtimeLocalFlash
	LD HL,STRING_45	;CONGRATULATIONS
	CALL runtimePrintString
	LD DE,17
	LD HL,5
	CALL runtimePrintAt
	LD HL,STRING_46	;MINER WILLY IS NOW FREE
	CALL runtimePrintString
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
ZXB_LABEL_45:
ZXBASIC_LINE_1790:
; 1790  IF  INKEY$  <> "" THEN  CLS : BRIGHT 0: GOTO 10
	LD HL,1790
	LD (23621),HL
; 		1790.1  IF  INKEY$  <> "" THEN  CLS 
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
; INKEY$
	CALL runtimeInkey
	LD DE,HL
	LD HL,STRING_47	;
; <>
	CALL runtimeUnequalString
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_46
; 		1790.2  CLS 
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	CALL runtimeCls
; 		1790.3  BRIGHT 0{00 00 00 00 00 }
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,0
	CALL runtimeBright
; 		1790.4  GOTO 10{00 00 0a 00 00 }
	LD A,4
	LD (23623),a
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_10
ZXB_LABEL_46:
ZXBASIC_LINE_1800:
; 1800  GOTO 1790
	LD HL,1800
	LD (23621),HL
; 		1800.1  GOTO 1790{00 00 fe 06 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_1790
ZXBASIC_LINE_1810:
; 1810  REM **** START UP ****
	LD HL,1810
	LD (23621),HL
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
ZXBASIC_LINE_1820:
; 1820  CLS : PAPER 0: BRIGHT 0: INK 7
	LD HL,1820
	LD (23621),HL
; 		1820.1  CLS 
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	CALL runtimeCls
; 		1820.2  PAPER 0{00 00 00 00 00 }
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,0
	CALL runtimePaper
; 		1820.3  BRIGHT 0{00 00 00 00 00 }
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,0
	CALL runtimeBright
; 		1820.4  INK 7{00 00 07 00 00 }
	LD A,4
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,7
	CALL runtimeInk
ZXBASIC_LINE_1830:
; 1830  LET t=6: LET ot=t: LET ss=1
	LD HL,1830
	LD (23621),HL
; 		1830.1  LET t=6{00 00 06 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,6
	LD (ZXBASIC_VAR_t),HL
; 		1830.2  LET ot=t
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,(ZXBASIC_VAR_t)
	LD (ZXBASIC_VAR_ot),HL
; 		1830.3  LET ss=1{00 00 01 00 00 }
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,1
	LD (ZXBASIC_VAR_ss),HL
ZXBASIC_LINE_1840:
; 1840  LET d=1: LET win=0
	LD HL,1840
	LD (23621),HL
; 		1840.1  LET d=1{00 00 01 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,1
	LD (ZXBASIC_VAR_d),HL
; 		1840.2  LET win=0{00 00 00 00 00 }
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,0
	LD (ZXBASIC_VAR_win),HL
ZXBASIC_LINE_1850:
; 1850  PRINT  AT 14,20;"\160"; AT 15,20;"\146"
	LD HL,1850
	LD (23621),HL
; 		1850.1  PRINT  AT 14{00 00 0e 00 00 },20{00 00 14 00 00 };"\160"; AT 15{00 00 0f 00 00 },20{00 00 14 00 00 };"\146"
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,14
	LD HL,20
	CALL runtimePrintAt
	LD HL,STRING_13	;\a0
	CALL runtimePrintString
	LD DE,15
	LD HL,20
	CALL runtimePrintAt
	LD HL,STRING_39	;\92
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1870:
; 1870  INK 7
	LD HL,1870
	LD (23621),HL
; 		1870.1  INK 7{00 00 07 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,7
	CALL runtimeInk
ZXBASIC_LINE_1875:
; 1875  PRINT  AT 14,20;"\160"; AT 15,20;"\146"
	LD HL,1875
	LD (23621),HL
; 		1875.1  PRINT  AT 14{00 00 0e 00 00 },20{00 00 14 00 00 };"\160"; AT 15{00 00 0f 00 00 },20{00 00 14 00 00 };"\146"
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,14
	LD HL,20
	CALL runtimePrintAt
	LD HL,STRING_13	;\a0
	CALL runtimePrintString
	LD DE,15
	LD HL,20
	CALL runtimePrintAt
	LD HL,STRING_39	;\92
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1878:
; 1878  REM !!LINE 1880 48k only!!
	LD HL,1878
	LD (23621),HL
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
ZXBASIC_LINE_1880:
; 1880  FOR a=0 TO 7: POKE 23680,11: POKE 23681,72+a: LPRINT "M A N I C": NEXT a
	LD HL,1880
	LD (23621),HL
; 		1880.1  FOR a=0{00 00 00 00 00 } TO 7{00 00 07 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,0
	LD (ZXBASIC_VAR_a),HL
	LD HL,7
	LD (ZXBASIC_VAR_for_a),HL
FOR_12:
; 		1880.2  POKE 23680{00 00 80 5c 00 },11{00 00 0b 00 00 }
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,23680
	LD DE,11
	LD (HL),E
; 		1880.3  POKE 23681{00 00 81 5c 00 },72{00 00 48 00 00 }+a
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,23681
	PUSH HL
	LD DE,72
	LD HL,(ZXBASIC_VAR_a)
; +
	ADD HL,DE
	POP DE
	EX HL,DE
	LD (HL),E
; 		1880.4  LPRINT "M A N I C"
	LD A,4
	LD (23623),a
	CALL runtimeCheckBreak
	LD A,3
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_48	;M A N I C
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
; 		1880.5  NEXT a
	LD A,5
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,(ZXBASIC_VAR_a)
	INC HL
	LD (ZXBASIC_VAR_a),HL
	LD DE,(ZXBASIC_VAR_for_a)
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_12
ZXBASIC_LINE_1900:
; 1900  REM .. MUSIC LOOP ..
	LD HL,1900
	LD (23621),HL
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
ZXBASIC_LINE_1910:
; 1910  LET r=0.05: FOR s=1 TO 180: READ p
	LD HL,1910
	LD (23621),HL
; 		1910.1  LET r=0.05{7c 4c cc cc cc }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,FLOAT_8	;0.05
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD (ZXBASIC_VAR_r),HL
; 		1910.2  FOR s=1{00 00 01 00 00 } TO 180{00 00 b4 00 00 }
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,1
	LD (ZXBASIC_VAR_s),HL
	LD HL,180
	LD (ZXBASIC_VAR_for_s),HL
FOR_13:
; 		1910.3  READ p
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,(DATAPTR)
	LD DE,(HL)
	INC HL
	INC HL
	LD (DATAPTR),HL
	LD (ZXBASIC_VAR_p),DE
ZXBASIC_LINE_1990:
; 1990  IF  INKEY$  <> "" THEN  CLS : GOTO 3000
	LD HL,1990
	LD (23621),HL
; 		1990.1  IF  INKEY$  <> "" THEN  CLS 
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
; INKEY$
	CALL runtimeInkey
	LD DE,HL
	LD HL,STRING_47	;
; <>
	CALL runtimeUnequalString
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_47
; 		1990.2  CLS 
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	CALL runtimeCls
; 		1990.3  GOTO 3000{00 00 b8 0b 00 }
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_3000
ZXB_LABEL_47:
ZXBASIC_LINE_2000:
; 2000  BEEP 0.05,p
	LD HL,2000
	LD (23621),HL
; 		2000.1  BEEP 0.05{7c 4c cc cc cc },p
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,FLOAT_8	;0.05
	CALL runtimePushFloatVar
	LD HL,(ZXBASIC_VAR_p)
	CALL runtimeIntToFloat
	CALL $03F8
ZXBASIC_LINE_2005:
; 2005  PRINT  AT 8,12; INK ( RND *7);"S L O W"; AT 15,11;"W I L L Y"
	LD HL,2005
	LD (23621),HL
; 		2005.1  PRINT  AT 8{00 00 08 00 00 },12{00 00 0c 00 00 }; INK ( RND *7{00 00 07 00 00 });"S L O W"; AT 15{00 00 0f 00 00 },11{00 00 0b 00 00 };"W I L L Y"
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,8
	LD HL,12
	CALL runtimePrintAt
; (
; RND
	CALL runtimeRND
	LD HL,7
; *
	CALL runtimeIntToFloat
	RST $28
	DB $04	;MULT
	DB $38	;END CALC
; )
	CALL runtimeFloatToInt
	CALL runtimeLocalInk
	LD HL,STRING_49	;S L O W
	CALL runtimePrintString
	LD DE,15
	LD HL,11
	CALL runtimePrintAt
	LD HL,STRING_50	;W I L L Y
	CALL runtimePrintString
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_2010:
; 2010  NEXT s
	LD HL,2010
	LD (23621),HL
; 		2010.1  NEXT s
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,(ZXBASIC_VAR_s)
	INC HL
	LD (ZXBASIC_VAR_s),HL
	LD DE,(ZXBASIC_VAR_for_s)
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_13
ZXBASIC_LINE_2020:
; 2020  RESTORE 2050
	LD HL,2020
	LD (23621),HL
; 		2020.1  RESTORE 2050{00 00 02 08 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD DE,2050
	LD HL,ZXDATA
	CALL runtimeFindLine
	EX HL,DE
	LD (DATAPTR),DE
ZXBASIC_LINE_2030:
; 2030  GOTO 1900
	LD HL,2030
	LD (23621),HL
; 		2030.1  GOTO 1900{00 00 6c 07 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_1900
ZXBASIC_LINE_2050:
; 2050  DATA 0,-12,5,-12,8,-12
	LD HL,2050
	LD (23621),HL
; 		2050.1  DATA 0{00 00 00 00 00 },-12{00 00 0c 00 00 },5{00 00 05 00 00 },-12{00 00 0c 00 00 },8{00 00 08 00 00 },-12{00 00 0c 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
ZXBASIC_LINE_2060:
; 2060  DATA 0,-12,5,-12,8,-12
	LD HL,2060
	LD (23621),HL
; 		2060.1  DATA 0{00 00 00 00 00 },-12{00 00 0c 00 00 },5{00 00 05 00 00 },-12{00 00 0c 00 00 },8{00 00 08 00 00 },-12{00 00 0c 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
ZXBASIC_LINE_2070:
; 2070  DATA 0,-12,5,-12,8,-12
	LD HL,2070
	LD (23621),HL
; 		2070.1  DATA 0{00 00 00 00 00 },-12{00 00 0c 00 00 },5{00 00 05 00 00 },-12{00 00 0c 00 00 },8{00 00 08 00 00 },-12{00 00 0c 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
ZXBASIC_LINE_2080:
; 2080  DATA 0,-12,5,-12,8,-12
	LD HL,2080
	LD (23621),HL
; 		2080.1  DATA 0{00 00 00 00 00 },-12{00 00 0c 00 00 },5{00 00 05 00 00 },-12{00 00 0c 00 00 },8{00 00 08 00 00 },-12{00 00 0c 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
ZXBASIC_LINE_2090:
; 2090  DATA 0,-12,5,-12,8,-12
	LD HL,2090
	LD (23621),HL
; 		2090.1  DATA 0{00 00 00 00 00 },-12{00 00 0c 00 00 },5{00 00 05 00 00 },-12{00 00 0c 00 00 },8{00 00 08 00 00 },-12{00 00 0c 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
ZXBASIC_LINE_2100:
; 2100  DATA 0,-12,5,-12,8,-12
	LD HL,2100
	LD (23621),HL
; 		2100.1  DATA 0{00 00 00 00 00 },-12{00 00 0c 00 00 },5{00 00 05 00 00 },-12{00 00 0c 00 00 },8{00 00 08 00 00 },-12{00 00 0c 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
ZXBASIC_LINE_2110:
; 2110  DATA 0,-12,5,-12,8,-12
	LD HL,2110
	LD (23621),HL
; 		2110.1  DATA 0{00 00 00 00 00 },-12{00 00 0c 00 00 },5{00 00 05 00 00 },-12{00 00 0c 00 00 },8{00 00 08 00 00 },-12{00 00 0c 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
ZXBASIC_LINE_2120:
; 2120  DATA 0,-12,5,-12,8,-12
	LD HL,2120
	LD (23621),HL
; 		2120.1  DATA 0{00 00 00 00 00 },-12{00 00 0c 00 00 },5{00 00 05 00 00 },-12{00 00 0c 00 00 },8{00 00 08 00 00 },-12{00 00 0c 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
ZXBASIC_LINE_2130:
; 2130  REM bar 9
	LD HL,2130
	LD (23621),HL
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
ZXBASIC_LINE_2140:
; 2140  DATA 1,11,5,-11,8,-11
	LD HL,2140
	LD (23621),HL
; 		2140.1  DATA 1{00 00 01 00 00 },11{00 00 0b 00 00 },5{00 00 05 00 00 },-11{00 00 0b 00 00 },8{00 00 08 00 00 },-11{00 00 0b 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
ZXBASIC_LINE_2150:
; 2150  DATA 1,11,5,-11,8,-11
	LD HL,2150
	LD (23621),HL
; 		2150.1  DATA 1{00 00 01 00 00 },11{00 00 0b 00 00 },5{00 00 05 00 00 },-11{00 00 0b 00 00 },8{00 00 08 00 00 },-11{00 00 0b 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
ZXBASIC_LINE_2160:
; 2160  DATA 1,-11,6,-11,10,-2
	LD HL,2160
	LD (23621),HL
; 		2160.1  DATA 1{00 00 01 00 00 },-11{00 00 0b 00 00 },6{00 00 06 00 00 },-11{00 00 0b 00 00 },10{00 00 0a 00 00 },-2{00 00 02 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
ZXBASIC_LINE_2170:
; 2170  DATA 1,-11,6,-11,10,-2
	LD HL,2170
	LD (23621),HL
; 		2170.1  DATA 1{00 00 01 00 00 },-11{00 00 0b 00 00 },6{00 00 06 00 00 },-11{00 00 0b 00 00 },10{00 00 0a 00 00 },-2{00 00 02 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
ZXBASIC_LINE_2180:
; 2180  DATA 0,-12,4,-12,10,-12
	LD HL,2180
	LD (23621),HL
; 		2180.1  DATA 0{00 00 00 00 00 },-12{00 00 0c 00 00 },4{00 00 04 00 00 },-12{00 00 0c 00 00 },10{00 00 0a 00 00 },-12{00 00 0c 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
ZXBASIC_LINE_2190:
; 2190  DATA 0,-12,5,-12,8,-12
	LD HL,2190
	LD (23621),HL
; 		2190.1  DATA 0{00 00 00 00 00 },-12{00 00 0c 00 00 },5{00 00 05 00 00 },-12{00 00 0c 00 00 },8{00 00 08 00 00 },-12{00 00 0c 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
ZXBASIC_LINE_2200:
; 2200  DATA 0,-12,5,-12,7,-12
	LD HL,2200
	LD (23621),HL
; 		2200.1  DATA 0{00 00 00 00 00 },-12{00 00 0c 00 00 },5{00 00 05 00 00 },-12{00 00 0c 00 00 },7{00 00 07 00 00 },-12{00 00 0c 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
ZXBASIC_LINE_2210:
; 2210  DATA 0,-12,5,-12,7,-12
	LD HL,2210
	LD (23621),HL
; 		2210.1  DATA 0{00 00 00 00 00 },-12{00 00 0c 00 00 },5{00 00 05 00 00 },-12{00 00 0c 00 00 },7{00 00 07 00 00 },-12{00 00 0c 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
ZXBASIC_LINE_2220:
; 2220  REM bar 17
	LD HL,2220
	LD (23621),HL
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
ZXBASIC_LINE_2230:
; 2230  DATA -4,-16,0,-16,5,-16
	LD HL,2230
	LD (23621),HL
; 		2230.1  DATA -4{00 00 04 00 00 },-16{00 00 10 00 00 },0{00 00 00 00 00 },-16{00 00 10 00 00 },5{00 00 05 00 00 },-16{00 00 10 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
ZXBASIC_LINE_2240:
; 2240  DATA 0,-12,5,-12,8,-12
	LD HL,2240
	LD (23621),HL
; 		2240.1  DATA 0{00 00 00 00 00 },-12{00 00 0c 00 00 },5{00 00 05 00 00 },-12{00 00 0c 00 00 },8{00 00 08 00 00 },-12{00 00 0c 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
ZXBASIC_LINE_2250:
; 2250  DATA 0,-12,5,-12,8,-12
	LD HL,2250
	LD (23621),HL
; 		2250.1  DATA 0{00 00 00 00 00 },-12{00 00 0c 00 00 },5{00 00 05 00 00 },-12{00 00 0c 00 00 },8{00 00 08 00 00 },-12{00 00 0c 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
ZXBASIC_LINE_2260:
; 2260  DATA 12,-12,5,-12,12,-12
	LD HL,2260
	LD (23621),HL
; 		2260.1  DATA 12{00 00 0c 00 00 },-12{00 00 0c 00 00 },5{00 00 05 00 00 },-12{00 00 0c 00 00 },12{00 00 0c 00 00 },-12{00 00 0c 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
ZXBASIC_LINE_2270:
; 2270  DATA 12,-12,5,-12,10,-12
	LD HL,2270
	LD (23621),HL
; 		2270.1  DATA 12{00 00 0c 00 00 },-12{00 00 0c 00 00 },5{00 00 05 00 00 },-12{00 00 0c 00 00 },10{00 00 0a 00 00 },-12{00 00 0c 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
ZXBASIC_LINE_2280:
; 2280  DATA 5,-12,0,-12,10,-12
	LD HL,2280
	LD (23621),HL
; 		2280.1  DATA 5{00 00 05 00 00 },-12{00 00 0c 00 00 },0{00 00 00 00 00 },-12{00 00 0c 00 00 },10{00 00 0a 00 00 },-12{00 00 0c 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
ZXBASIC_LINE_2290:
; 2290  DATA 7,-12,0,-12,10,-12
	LD HL,2290
	LD (23621),HL
; 		2290.1  DATA 7{00 00 07 00 00 },-12{00 00 0c 00 00 },0{00 00 00 00 00 },-12{00 00 0c 00 00 },10{00 00 0a 00 00 },-12{00 00 0c 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
ZXBASIC_LINE_2300:
; 2300  DATA 12,-12,7,-12,10,-12
	LD HL,2300
	LD (23621),HL
; 		2300.1  DATA 12{00 00 0c 00 00 },-12{00 00 0c 00 00 },7{00 00 07 00 00 },-12{00 00 0c 00 00 },10{00 00 0a 00 00 },-12{00 00 0c 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
ZXBASIC_LINE_2310:
; 2310  DATA 12,-12,9,-12,12,-12
	LD HL,2310
	LD (23621),HL
; 		2310.1  DATA 12{00 00 0c 00 00 },-12{00 00 0c 00 00 },9{00 00 09 00 00 },-12{00 00 0c 00 00 },12{00 00 0c 00 00 },-12{00 00 0c 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
ZXBASIC_LINE_2320:
; 2320  DATA 13,-11,5,-11,10,-11
	LD HL,2320
	LD (23621),HL
; 		2320.1  DATA 13{00 00 0d 00 00 },-11{00 00 0b 00 00 },5{00 00 05 00 00 },-11{00 00 0b 00 00 },10{00 00 0a 00 00 },-11{00 00 0b 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
ZXBASIC_LINE_2330:
; 2330  DATA 1,-11,5,-11,10,-11
	LD HL,2330
	LD (23621),HL
; 		2330.1  DATA 1{00 00 01 00 00 },-11{00 00 0b 00 00 },5{00 00 05 00 00 },-11{00 00 0b 00 00 },10{00 00 0a 00 00 },-11{00 00 0b 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
ZXBASIC_LINE_2340:
; 2340  DATA 0,-12,4,-12,10,-12
	LD HL,2340
	LD (23621),HL
; 		2340.1  DATA 0{00 00 00 00 00 },-12{00 00 0c 00 00 },4{00 00 04 00 00 },-12{00 00 0c 00 00 },10{00 00 0a 00 00 },-12{00 00 0c 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
ZXBASIC_LINE_2350:
; 2350  DATA 1,-12,4,-12,16,-12
	LD HL,2350
	LD (23621),HL
; 		2350.1  DATA 1{00 00 01 00 00 },-12{00 00 0c 00 00 },4{00 00 04 00 00 },-12{00 00 0c 00 00 },16{00 00 10 00 00 },-12{00 00 0c 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
ZXBASIC_LINE_2360:
; 2360  DATA 4,-12,7,-12,5,-12
	LD HL,2360
	LD (23621),HL
; 		2360.1  DATA 4{00 00 04 00 00 },-12{00 00 0c 00 00 },7{00 00 07 00 00 },-12{00 00 0c 00 00 },5{00 00 05 00 00 },-12{00 00 0c 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
ZXBASIC_LINE_3000:
; 3000  REM ... Instructions ...
	LD HL,3000
	LD (23621),HL
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
ZXBASIC_LINE_3010:
; 3010  PRINT  AT 1,6;"Manic Miner in BASIC"
	LD HL,3010
	LD (23621),HL
; 		3010.1  PRINT  AT 1{00 00 01 00 00 },6{00 00 06 00 00 };"Manic Miner in BASIC"
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,1
	LD HL,6
	CALL runtimePrintAt
	LD HL,STRING_51	;Manic Miner in BASIC
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_3020:
; 3020  PRINT  AT 2,8;"Can it be done?"
	LD HL,3020
	LD (23621),HL
; 		3020.1  PRINT  AT 2{00 00 02 00 00 },8{00 00 08 00 00 };"Can it be done?"
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,2
	LD HL,8
	CALL runtimePrintAt
	LD HL,STRING_52	;Can it be done?
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_3030:
; 3030  PRINT  AT 4,8;"The following is "; AT 5,6;"a version of LEVEL 1"
	LD HL,3030
	LD (23621),HL
; 		3030.1  PRINT  AT 4{00 00 04 00 00 },8{00 00 08 00 00 };"The following is "; AT 5{00 00 05 00 00 },6{00 00 06 00 00 };"a version of LEVEL 1"
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,4
	LD HL,8
	CALL runtimePrintAt
	LD HL,STRING_53	;The following is 
	CALL runtimePrintString
	LD DE,5
	LD HL,6
	CALL runtimePrintAt
	LD HL,STRING_54	;a version of LEVEL 1
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_3040:
; 3040  PRINT  AT 7,7;"As seen on YouTube"; AT 8,9;"@Animated ALex"
	LD HL,3040
	LD (23621),HL
; 		3040.1  PRINT  AT 7{00 00 07 00 00 },7{00 00 07 00 00 };"As seen on YouTube"; AT 8{00 00 08 00 00 },9{00 00 09 00 00 };"@Animated ALex"
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,7
	LD HL,7
	CALL runtimePrintAt
	LD HL,STRING_55	;As seen on YouTube
	CALL runtimePrintString
	LD DE,8
	LD HL,9
	CALL runtimePrintAt
	LD HL,STRING_56	;@Animated ALex
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_3050:
; 3050  PRINT  AT 10,4;"Controls: O=Left  P=Right"; AT 11,14;"Q=Jump"
	LD HL,3050
	LD (23621),HL
; 		3050.1  PRINT  AT 10{00 00 0a 00 00 },4{00 00 04 00 00 };"Controls
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,10
	LD HL,4
	CALL runtimePrintAt
	LD HL,STRING_57	;Controls: O=Left  P=Right
	CALL runtimePrintString
	LD DE,11
	LD HL,14
	CALL runtimePrintAt
	LD HL,STRING_58	;Q=Jump
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_3060:
; 3060  PRINT  AT 13,5;"Collect all the keys "; PAPER 6; INK 0;"\152"; PAPER 0; INK 7; AT 14,6;"and free Miner Willy"
	LD HL,3060
	LD (23621),HL
; 		3060.1  PRINT  AT 13{00 00 0d 00 00 },5{00 00 05 00 00 };"Collect all the keys "; PAPER 6{00 00 06 00 00 }; INK 0{00 00 00 00 00 };"\152"; PAPER 0{00 00 00 00 00 }; INK 7{00 00 07 00 00 }; AT 14{00 00 0e 00 00 },6{00 00 06 00 00 };"and free Miner Willy"
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,13
	LD HL,5
	CALL runtimePrintAt
	LD HL,STRING_59	;Collect all the keys 
	CALL runtimePrintString
	LD HL,6
	CALL runtimeLocalPaper
	LD HL,0
	CALL runtimeLocalInk
	LD HL,STRING_34	;\98
	CALL runtimePrintString
	LD HL,0
	CALL runtimeLocalPaper
	LD HL,7
	CALL runtimeLocalInk
	LD DE,14
	LD HL,6
	CALL runtimePrintAt
	LD HL,STRING_60	;and free Miner Willy
	CALL runtimePrintString
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_3070:
; 3070  PRINT  AT 16,4;"To increase AIR collect "; INK 5;" PLAY "
	LD HL,3070
	LD (23621),HL
; 		3070.1  PRINT  AT 16{00 00 10 00 00 },4{00 00 04 00 00 };"To increase AIR collect "; INK 5{00 00 05 00 00 };" PLAY "
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,16
	LD HL,4
	CALL runtimePrintAt
	LD HL,STRING_61	;To increase AIR collect 
	CALL runtimePrintString
	LD HL,5
	CALL runtimeLocalInk
	LD HL,STRING_15	;\a4
	CALL runtimePrintString
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_3080:
; 3080  PRINT  AT 21,2;"Programmed in Sinclair BASIC"; AT 19,5; INK 7;"By Animated ALex. 2025"; AT 20,2; INK 7;"Intro MUSIC : Damien Redmond"
	LD HL,3080
	LD (23621),HL
; 		3080.1  PRINT  AT 21{00 00 15 00 00 },2{00 00 02 00 00 };"Programmed in Sinclair BASIC"; AT 19{00 00 13 00 00 },5{00 00 05 00 00 }; INK 7{00 00 07 00 00 };"By Animated ALex. 2025"; AT 20{00 00 14 00 00 },2{00 00 02 00 00 }; INK 7{00 00 07 00 00 };"Intro MUSIC 
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,21
	LD HL,2
	CALL runtimePrintAt
	LD HL,STRING_62	;Programmed in Sinclair BASIC
	CALL runtimePrintString
	LD DE,19
	LD HL,5
	CALL runtimePrintAt
	LD HL,7
	CALL runtimeLocalInk
	LD HL,STRING_63	;By Animated ALex. 2025
	CALL runtimePrintString
	LD DE,20
	LD HL,2
	CALL runtimePrintAt
	LD HL,7
	CALL runtimeLocalInk
	LD HL,STRING_64	;Intro MUSIC : Damien Redmond
	CALL runtimePrintString
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_3090:
; 3090  IF  INKEY$  <> "" THEN  CLS : GOTO 70
	LD HL,3090
	LD (23621),HL
; 		3090.1  IF  INKEY$  <> "" THEN  CLS 
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
; INKEY$
	CALL runtimeInkey
	LD DE,HL
	LD HL,STRING_47	;
; <>
	CALL runtimeUnequalString
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_48
; 		3090.2  CLS 
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	CALL runtimeCls
; 		3090.3  GOTO 70{00 00 46 00 00 }
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_70
ZXB_LABEL_48:
ZXBASIC_LINE_3095:
; 3095  GOTO 3090
	LD HL,3095
	LD (23621),HL
; 		3095.1  GOTO 3090{00 00 12 0c 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_3090
ZXBASIC_LINE_9998:
; 9998  STOP 
	LD HL,9998
	LD (23621),HL
ZXBASIC_VAR_a:	dw 0
ZXBASIC_VAR_ae:	dw 0
ZXBASIC_VAR_b:	dw 0
ZXBASIC_VAR_c:	dw 0
ZXBASIC_VAR_c_string:	dw 0
ZXBASIC_VAR_d:	dw 0
ZXBASIC_VAR_d_string:	dw 0
ZXBASIC_VAR_dat:	dw 0
ZXBASIC_VAR_e:	dw 0
ZXBASIC_VAR_e_string:	dw 0
ZXBASIC_VAR_f:	dw 0
ZXBASIC_VAR_fg:	dw 0
ZXBASIC_VAR_fl:	dw 0
ZXBASIC_VAR_for_a:	dw 0
ZXBASIC_VAR_for_b:	dw 0
ZXBASIC_VAR_for_g:	dw 0
ZXBASIC_VAR_for_i:	dw 0
ZXBASIC_VAR_for_i_step:	dw 0
ZXBASIC_VAR_for_k:	dw 0
ZXBASIC_VAR_for_k_step:	dw 0
ZXBASIC_VAR_for_o:	dw 0
ZXBASIC_VAR_for_o_step:	dw 0
ZXBASIC_VAR_for_p:	dw 0
ZXBASIC_VAR_for_p_step:	dw 0
ZXBASIC_VAR_for_s:	dw 0
ZXBASIC_VAR_for_u:	dw 0
ZXBASIC_VAR_for_w:	dw 0
ZXBASIC_VAR_fr:	dw 0
ZXBASIC_VAR_g:	dw 0
ZXBASIC_VAR_h:	dw 0
ZXBASIC_VAR_hf:	dw 0
ZXBASIC_VAR_i:	dw 0
ZXBASIC_VAR_j:	dw 0
ZXBASIC_VAR_jj:	dw 0
ZXBASIC_VAR_k:	dw 0
ZXBASIC_VAR_l:	dw 0
ZXBASIC_VAR_lf:	dw 0
ZXBASIC_VAR_m:	dw 0
ZXBASIC_VAR_n:	dw 0
ZXBASIC_VAR_o:	dw 0
ZXBASIC_VAR_oc:	dw 0
ZXBASIC_VAR_ot:	dw 0
ZXBASIC_VAR_ox:	dw 0
ZXBASIC_VAR_oy:	dw 0
ZXBASIC_VAR_p:	dw 0
ZXBASIC_VAR_r:	dw 0
ZXBASIC_VAR_s:	dw 0
ZXBASIC_VAR_ss:	dw 0
ZXBASIC_VAR_t:	dw 0
ZXBASIC_VAR_u:	dw 0
ZXBASIC_VAR_w:	dw 0
ZXBASIC_VAR_win:	dw 0
ZXBASIC_VAR_wk:	dw 0
ZXBASIC_VAR_x:	dw 0
ZXBASIC_VAR_y:	dw 0
FLOAT_1:	db $7b, $75, $c2, $8f, $5c	;.03
FLOAT_10:	db $79, $44, $9b, $a5, $e3	;.006
FLOAT_2:	db $80, $6c, $cc, $cc, $cc	;0.925
FLOAT_3:	db $75, $1d, $49, $51, $82	;0.0003
FLOAT_4:	db $73, $51, $b7, $17, $58	;0.0001
FLOAT_5:	db $7a, $23, $d7, $0a, $3d	;.01
FLOAT_6:	db $7b, $23, $d7, $0a, $3d	;.02
FLOAT_7:	db $7c, $23, $d7, $0a, $3d	;0.04
FLOAT_8:	db $7c, $4c, $cc, $cc, $cc	;.05
FLOAT_9:	db $78, $44, $9b, $a5, $e3	;.003
STRING_0:	dw 1
	db	" "
STRING_1:	dw 12
	db	"            "
STRING_10:	dw 7
	db	$9a, $9a, $9a, $9a, $9a, $9a, $9a
STRING_11:	dw 3
	db	"xxx"
STRING_12:	dw 3
	db	"AIR"
STRING_13:	dw 1
	db	$a0
STRING_14:	dw 1
	db	$a1
STRING_15:	dw 1
	db	$a4
STRING_16:	dw 12
	db	"INCREASE AIR"
STRING_17:	dw 2
	db	$90, $a0
STRING_18:	dw 2
	db	$91, $a1
STRING_19:	dw 2
	db	$92, $93
STRING_2:	dw 1
	db	$9d
STRING_20:	dw 32
	db	$9a, $9a, $9a, $9a, $9a, $9a, $9a, $9a, $9a, $9a, $9a, $9a, $9a, $9a, $9a, $9a, $9a, $9a, $9a, $9a, $9a, $9a, $9a, $9a, $9a, $9a, $9a, $9a, $9a, $9a, $9a, $9a
STRING_21:	dw 1
	db	$85
STRING_22:	dw 3
	db	$9b, $9b, $9b
STRING_23:	dw 1
	db	$8a
STRING_24:	dw 3
	db	$9f, $9f, $9f
STRING_25:	dw 5
	db	$9a, $9a, $9a, $9a, $9a
STRING_26:	dw 3
	db	$9a, $9a, $9a
STRING_27:	dw 18
	db	$97, $9d, $97, $9d, $97, $9d, $97, $9d, $97, $9d, $97, $9d, $97, $9d, $97, $9d, $97, $8a
STRING_28:	dw 5
	db	$9b, $9b, $9b, $9b, $9b
STRING_29:	dw 6
	db	$a2, $a3, $a2, $a3, $a2, $a3
STRING_3:	dw 1
	db	$96
STRING_30:	dw 9
	db	$9a, $9a, $9a, $9a, $9a, $9a, $9a, $9a, $9a
STRING_31:	dw 32
	db	"       The BASIC Cavern         "
STRING_32:	dw 1
	db	$89
STRING_33:	dw 1
	db	$86
STRING_34:	dw 1
	db	$98
STRING_35:	dw 1
	db	$97
STRING_36:	dw 1
	db	$99
STRING_37:	dw 1
	db	"a"
STRING_38:	dw 32
	db	"         The Final Step         "
STRING_39:	dw 1
	db	$92
STRING_4:	dw 1
	db	$94
STRING_40:	dw 1
	db	$8f
STRING_41:	dw 1
	db	$9f
STRING_42:	dw 1
	db	$9e
STRING_43:	dw 4
	db	"GAME"
STRING_44:	dw 4
	db	"OVER"
STRING_45:	dw 15
	db	"CONGRATULATIONS"
STRING_46:	dw 23
	db	"MINER WILLY IS NOW FREE"
STRING_47:	dw 0
STRING_48:	dw 9
	db	"M A N I C"
STRING_49:	dw 7
	db	"S L O W"
STRING_5:	dw 1
	db	$9c
STRING_50:	dw 9
	db	"W I L L Y"
STRING_51:	dw 20
	db	"Manic Miner in BASIC"
STRING_52:	dw 15
	db	"Can it be done?"
STRING_53:	dw 17
	db	"The following is "
STRING_54:	dw 20
	db	"a version of LEVEL 1"
STRING_55:	dw 18
	db	"As seen on YouTube"
STRING_56:	dw 14
	db	"@Animated ALex"
STRING_57:	dw 25
	db	"Controls: O=Left  P=Right"
STRING_58:	dw 6
	db	"Q=Jump"
STRING_59:	dw 21
	db	"Collect all the keys "
STRING_6:	dw 1
	db	$95
STRING_60:	dw 20
	db	"and free Miner Willy"
STRING_61:	dw 24
	db	"To increase AIR collect "
STRING_62:	dw 28
	db	"Programmed in Sinclair BASIC"
STRING_63:	dw 22
	db	"By Animated ALex. 2025"
STRING_64:	dw 28
	db	"Intro MUSIC : Damien Redmond"
STRING_7:	dw 1
	db	$9b
STRING_8:	dw 4
	db	$a2, $a3, $a2, $a3
STRING_9:	dw 4
	db	$9a, $9a, $9a, $9a
ZXLINES:
	dw 1, ZXBASIC_LINE_1
	dw 2, ZXBASIC_LINE_2
	dw 3, ZXBASIC_LINE_3
	dw 4, ZXBASIC_LINE_4
	dw 5, ZXBASIC_LINE_5
	dw 10, ZXBASIC_LINE_10
	dw 20, ZXBASIC_LINE_20
	dw 30, ZXBASIC_LINE_30
	dw 50, ZXBASIC_LINE_50
	dw 60, ZXBASIC_LINE_60
	dw 70, ZXBASIC_LINE_70
	dw 80, ZXBASIC_LINE_80
	dw 90, ZXBASIC_LINE_90
	dw 100, ZXBASIC_LINE_100
	dw 101, ZXBASIC_LINE_101
	dw 102, ZXBASIC_LINE_102
	dw 103, ZXBASIC_LINE_103
	dw 110, ZXBASIC_LINE_110
	dw 112, ZXBASIC_LINE_112
	dw 115, ZXBASIC_LINE_115
	dw 150, ZXBASIC_LINE_150
	dw 160, ZXBASIC_LINE_160
	dw 190, ZXBASIC_LINE_190
	dw 195, ZXBASIC_LINE_195
	dw 200, ZXBASIC_LINE_200
	dw 205, ZXBASIC_LINE_205
	dw 230, ZXBASIC_LINE_230
	dw 240, ZXBASIC_LINE_240
	dw 250, ZXBASIC_LINE_250
	dw 280, ZXBASIC_LINE_280
	dw 285, ZXBASIC_LINE_285
	dw 290, ZXBASIC_LINE_290
	dw 300, ZXBASIC_LINE_300
	dw 320, ZXBASIC_LINE_320
	dw 325, ZXBASIC_LINE_325
	dw 330, ZXBASIC_LINE_330
	dw 331, ZXBASIC_LINE_331
	dw 335, ZXBASIC_LINE_335
	dw 340, ZXBASIC_LINE_340
	dw 350, ZXBASIC_LINE_350
	dw 360, ZXBASIC_LINE_360
	dw 365, ZXBASIC_LINE_365
	dw 370, ZXBASIC_LINE_370
	dw 486, ZXBASIC_LINE_486
	dw 488, ZXBASIC_LINE_488
	dw 489, ZXBASIC_LINE_489
	dw 490, ZXBASIC_LINE_490
	dw 510, ZXBASIC_LINE_510
	dw 520, ZXBASIC_LINE_520
	dw 530, ZXBASIC_LINE_530
	dw 540, ZXBASIC_LINE_540
	dw 550, ZXBASIC_LINE_550
	dw 560, ZXBASIC_LINE_560
	dw 570, ZXBASIC_LINE_570
	dw 580, ZXBASIC_LINE_580
	dw 590, ZXBASIC_LINE_590
	dw 610, ZXBASIC_LINE_610
	dw 615, ZXBASIC_LINE_615
	dw 625, ZXBASIC_LINE_625
	dw 700, ZXBASIC_LINE_700
	dw 720, ZXBASIC_LINE_720
	dw 730, ZXBASIC_LINE_730
	dw 740, ZXBASIC_LINE_740
	dw 770, ZXBASIC_LINE_770
	dw 780, ZXBASIC_LINE_780
	dw 790, ZXBASIC_LINE_790
	dw 800, ZXBASIC_LINE_800
	dw 810, ZXBASIC_LINE_810
	dw 815, ZXBASIC_LINE_815
	dw 820, ZXBASIC_LINE_820
	dw 821, ZXBASIC_LINE_821
	dw 822, ZXBASIC_LINE_822
	dw 823, ZXBASIC_LINE_823
	dw 824, ZXBASIC_LINE_824
	dw 825, ZXBASIC_LINE_825
	dw 830, ZXBASIC_LINE_830
	dw 840, ZXBASIC_LINE_840
	dw 845, ZXBASIC_LINE_845
	dw 850, ZXBASIC_LINE_850
	dw 860, ZXBASIC_LINE_860
	dw 870, ZXBASIC_LINE_870
	dw 890, ZXBASIC_LINE_890
	dw 900, ZXBASIC_LINE_900
	dw 910, ZXBASIC_LINE_910
	dw 930, ZXBASIC_LINE_930
	dw 940, ZXBASIC_LINE_940
	dw 950, ZXBASIC_LINE_950
	dw 960, ZXBASIC_LINE_960
	dw 970, ZXBASIC_LINE_970
	dw 980, ZXBASIC_LINE_980
	dw 990, ZXBASIC_LINE_990
	dw 1000, ZXBASIC_LINE_1000
	dw 1020, ZXBASIC_LINE_1020
	dw 1030, ZXBASIC_LINE_1030
	dw 1040, ZXBASIC_LINE_1040
	dw 1050, ZXBASIC_LINE_1050
	dw 1060, ZXBASIC_LINE_1060
	dw 1070, ZXBASIC_LINE_1070
	dw 1090, ZXBASIC_LINE_1090
	dw 1095, ZXBASIC_LINE_1095
	dw 1100, ZXBASIC_LINE_1100
	dw 1110, ZXBASIC_LINE_1110
	dw 1120, ZXBASIC_LINE_1120
	dw 1140, ZXBASIC_LINE_1140
	dw 1150, ZXBASIC_LINE_1150
	dw 1160, ZXBASIC_LINE_1160
	dw 1170, ZXBASIC_LINE_1170
	dw 1180, ZXBASIC_LINE_1180
	dw 1190, ZXBASIC_LINE_1190
	dw 1200, ZXBASIC_LINE_1200
	dw 1210, ZXBASIC_LINE_1210
	dw 1220, ZXBASIC_LINE_1220
	dw 1230, ZXBASIC_LINE_1230
	dw 1240, ZXBASIC_LINE_1240
	dw 1250, ZXBASIC_LINE_1250
	dw 1410, ZXBASIC_LINE_1410
	dw 1420, ZXBASIC_LINE_1420
	dw 1430, ZXBASIC_LINE_1430
	dw 1440, ZXBASIC_LINE_1440
	dw 1450, ZXBASIC_LINE_1450
	dw 1460, ZXBASIC_LINE_1460
	dw 1470, ZXBASIC_LINE_1470
	dw 1480, ZXBASIC_LINE_1480
	dw 1490, ZXBASIC_LINE_1490
	dw 1500, ZXBASIC_LINE_1500
	dw 1510, ZXBASIC_LINE_1510
	dw 1520, ZXBASIC_LINE_1520
	dw 1530, ZXBASIC_LINE_1530
	dw 1540, ZXBASIC_LINE_1540
	dw 1550, ZXBASIC_LINE_1550
	dw 1560, ZXBASIC_LINE_1560
	dw 1570, ZXBASIC_LINE_1570
	dw 1580, ZXBASIC_LINE_1580
	dw 1590, ZXBASIC_LINE_1590
	dw 1600, ZXBASIC_LINE_1600
	dw 1610, ZXBASIC_LINE_1610
	dw 1620, ZXBASIC_LINE_1620
	dw 1630, ZXBASIC_LINE_1630
	dw 1640, ZXBASIC_LINE_1640
	dw 1650, ZXBASIC_LINE_1650
	dw 1660, ZXBASIC_LINE_1660
	dw 1670, ZXBASIC_LINE_1670
	dw 1680, ZXBASIC_LINE_1680
	dw 1690, ZXBASIC_LINE_1690
	dw 1700, ZXBASIC_LINE_1700
	dw 1705, ZXBASIC_LINE_1705
	dw 1710, ZXBASIC_LINE_1710
	dw 1720, ZXBASIC_LINE_1720
	dw 1730, ZXBASIC_LINE_1730
	dw 1740, ZXBASIC_LINE_1740
	dw 1750, ZXBASIC_LINE_1750
	dw 1760, ZXBASIC_LINE_1760
	dw 1770, ZXBASIC_LINE_1770
	dw 1780, ZXBASIC_LINE_1780
	dw 1785, ZXBASIC_LINE_1785
	dw 1790, ZXBASIC_LINE_1790
	dw 1800, ZXBASIC_LINE_1800
	dw 1810, ZXBASIC_LINE_1810
	dw 1820, ZXBASIC_LINE_1820
	dw 1830, ZXBASIC_LINE_1830
	dw 1840, ZXBASIC_LINE_1840
	dw 1850, ZXBASIC_LINE_1850
	dw 1870, ZXBASIC_LINE_1870
	dw 1875, ZXBASIC_LINE_1875
	dw 1878, ZXBASIC_LINE_1878
	dw 1880, ZXBASIC_LINE_1880
	dw 1900, ZXBASIC_LINE_1900
	dw 1910, ZXBASIC_LINE_1910
	dw 1990, ZXBASIC_LINE_1990
	dw 2000, ZXBASIC_LINE_2000
	dw 2005, ZXBASIC_LINE_2005
	dw 2010, ZXBASIC_LINE_2010
	dw 2020, ZXBASIC_LINE_2020
	dw 2030, ZXBASIC_LINE_2030
	dw 2050, ZXBASIC_LINE_2050
	dw 2060, ZXBASIC_LINE_2060
	dw 2070, ZXBASIC_LINE_2070
	dw 2080, ZXBASIC_LINE_2080
	dw 2090, ZXBASIC_LINE_2090
	dw 2100, ZXBASIC_LINE_2100
	dw 2110, ZXBASIC_LINE_2110
	dw 2120, ZXBASIC_LINE_2120
	dw 2130, ZXBASIC_LINE_2130
	dw 2140, ZXBASIC_LINE_2140
	dw 2150, ZXBASIC_LINE_2150
	dw 2160, ZXBASIC_LINE_2160
	dw 2170, ZXBASIC_LINE_2170
	dw 2180, ZXBASIC_LINE_2180
	dw 2190, ZXBASIC_LINE_2190
	dw 2200, ZXBASIC_LINE_2200
	dw 2210, ZXBASIC_LINE_2210
	dw 2220, ZXBASIC_LINE_2220
	dw 2230, ZXBASIC_LINE_2230
	dw 2240, ZXBASIC_LINE_2240
	dw 2250, ZXBASIC_LINE_2250
	dw 2260, ZXBASIC_LINE_2260
	dw 2270, ZXBASIC_LINE_2270
	dw 2280, ZXBASIC_LINE_2280
	dw 2290, ZXBASIC_LINE_2290
	dw 2300, ZXBASIC_LINE_2300
	dw 2310, ZXBASIC_LINE_2310
	dw 2320, ZXBASIC_LINE_2320
	dw 2330, ZXBASIC_LINE_2330
	dw 2340, ZXBASIC_LINE_2340
	dw 2350, ZXBASIC_LINE_2350
	dw 2360, ZXBASIC_LINE_2360
	dw 3000, ZXBASIC_LINE_3000
	dw 3010, ZXBASIC_LINE_3010
	dw 3020, ZXBASIC_LINE_3020
	dw 3030, ZXBASIC_LINE_3030
	dw 3040, ZXBASIC_LINE_3040
	dw 3050, ZXBASIC_LINE_3050
	dw 3060, ZXBASIC_LINE_3060
	dw 3070, ZXBASIC_LINE_3070
	dw 3080, ZXBASIC_LINE_3080
	dw 3090, ZXBASIC_LINE_3090
	dw 3095, ZXBASIC_LINE_3095
	dw 9998, ZXBASIC_LINE_9998
	dw 0, 0
ZXDATA:
	dw 1460, DATA_1460
	dw 1470, DATA_1470
	dw 1480, DATA_1480
	dw 1490, DATA_1490
	dw 1500, DATA_1500
	dw 1510, DATA_1510
	dw 1520, DATA_1520
	dw 1530, DATA_1530
	dw 1540, DATA_1540
	dw 1550, DATA_1550
	dw 1560, DATA_1560
	dw 1570, DATA_1570
	dw 1580, DATA_1580
	dw 1590, DATA_1590
	dw 1600, DATA_1600
	dw 1610, DATA_1610
	dw 1620, DATA_1620
	dw 1630, DATA_1630
	dw 1640, DATA_1640
	dw 1650, DATA_1650
	dw 1660, DATA_1660
	dw 2050, DATA_2050
	dw 2060, DATA_2060
	dw 2070, DATA_2070
	dw 2080, DATA_2080
	dw 2090, DATA_2090
	dw 2100, DATA_2100
	dw 2110, DATA_2110
	dw 2120, DATA_2120
	dw 2150, DATA_2150
	dw 2160, DATA_2160
	dw 2170, DATA_2170
	dw 2180, DATA_2180
	dw 2190, DATA_2190
	dw 2200, DATA_2200
	dw 2210, DATA_2210
	dw 2240, DATA_2240
	dw 2250, DATA_2250
	dw 2260, DATA_2260
	dw 2270, DATA_2270
	dw 2280, DATA_2280
	dw 2290, DATA_2290
	dw 2300, DATA_2300
	dw 2310, DATA_2310
	dw 2320, DATA_2320
	dw 2330, DATA_2330
	dw 2340, DATA_2340
	dw 2350, DATA_2350
	dw 2360, DATA_2360
	dw 0, 0
DATAPTR:	DW 0
DATA_1460:
	dw 192
	dw 252
	dw 126
	dw 124
	dw 92
	dw 252
	dw 124
	dw 124
DATA_1470:
	dw 24
	dw 62
	dw 127
	dw 221
	dw 28
	dw 182
	dw 227
	dw 71
DATA_1480:
	dw 24
	dw 56
	dw 124
	dw 118
	dw 126
	dw 60
	dw 108
	dw 126
DATA_1490:
	dw 24
	dw 28
	dw 62
	dw 110
	dw 126
	dw 60
	dw 54
	dw 126
DATA_1500:
	dw 28
	dw 190
	dw 231
	dw 231
	dw 190
	dw 28
	dw 62
	dw 255
DATA_1510:
	dw 56
	dw 125
	dw 231
	dw 231
	dw 125
	dw 56
	dw 124
	dw 255
DATA_1520:
	dw 247
	dw 14
	dw 124
	dw 56
	dw 24
	dw 24
	dw 60
	dw 255
DATA_1530:
	dw 255
	dw 255
	dw 127
	dw 118
	dw 54
	dw 52
	dw 16
	dw 16
DATA_1540:
	dw 227
	dw 221
	dw 235
	dw 247
	dw 247
	dw 243
	dw 241
	dw 247
DATA_1550:
	dw 251
	dw 251
	dw 107
	dw 171
	dw 166
	dw 181
	dw 149
	dw 193
DATA_1560:
	dw 255
	dw 255
	dw 219
	dw 183
	dw 255
	dw 109
	dw 73
	dw 146
DATA_1570:
	dw 255
	dw 255
	dw 24
	dw 24
	dw 255
	dw 24
	dw 129
	dw 255
DATA_1580:
	dw 239
	dw 112
	dw 62
	dw 28
	dw 24
	dw 24
	dw 60
	dw 255
DATA_1590:
	dw 255
	dw 255
	dw 255
	dw 255
	dw 182
	dw 109
	dw 73
	dw 146
DATA_1600:
	dw 136
	dw 248
	dw 136
	dw 142
	dw 137
	dw 129
	dw 145
	dw 255
DATA_1610:
	dw 216
	dw 168
	dw 216
	dw 168
	dw 216
	dw 168
	dw 216
	dw 168
DATA_1620:
	dw 3
	dw 63
	dw 126
	dw 62
	dw 58
	dw 63
	dw 62
	dw 62
DATA_1630:
	dw 24
	dw 124
	dw 254
	dw 187
	dw 56
	dw 109
	dw 199
	dw 226
DATA_1640:
	dw 24
	dw 24
	dw 24
	dw 24
	dw 231
	dw 231
	dw 231
	dw 231
DATA_1650:
	dw 231
	dw 231
	dw 231
	dw 231
	dw 24
	dw 24
	dw 24
	dw 24
DATA_1660:
	dw 220
	dw 223
	dw 37
	dw 221
	dw 223
	dw 38
	dw 252
	dw 120
DATA_2050:
	dw 0
	dw -12
	dw 5
	dw -12
	dw 8
	dw -12
DATA_2060:
	dw 0
	dw -12
	dw 5
	dw -12
	dw 8
	dw -12
DATA_2070:
	dw 0
	dw -12
	dw 5
	dw -12
	dw 8
	dw -12
DATA_2080:
	dw 0
	dw -12
	dw 5
	dw -12
	dw 8
	dw -12
DATA_2090:
	dw 0
	dw -12
	dw 5
	dw -12
	dw 8
	dw -12
DATA_2100:
	dw 0
	dw -12
	dw 5
	dw -12
	dw 8
	dw -12
DATA_2110:
	dw 0
	dw -12
	dw 5
	dw -12
	dw 8
	dw -12
DATA_2120:
	dw 0
	dw -12
	dw 5
	dw -12
	dw 8
	dw -12
DATA_2140:
	dw 1
	dw 11
	dw 5
	dw -11
	dw 8
	dw -11
DATA_2150:
	dw 1
	dw 11
	dw 5
	dw -11
	dw 8
	dw -11
DATA_2160:
	dw 1
	dw -11
	dw 6
	dw -11
	dw 10
	dw -2
DATA_2170:
	dw 1
	dw -11
	dw 6
	dw -11
	dw 10
	dw -2
DATA_2180:
	dw 0
	dw -12
	dw 4
	dw -12
	dw 10
	dw -12
DATA_2190:
	dw 0
	dw -12
	dw 5
	dw -12
	dw 8
	dw -12
DATA_2200:
	dw 0
	dw -12
	dw 5
	dw -12
	dw 7
	dw -12
DATA_2210:
	dw 0
	dw -12
	dw 5
	dw -12
	dw 7
	dw -12
DATA_2230:
	dw -4
	dw -16
	dw 0
	dw -16
	dw 5
	dw -16
DATA_2240:
	dw 0
	dw -12
	dw 5
	dw -12
	dw 8
	dw -12
DATA_2250:
	dw 0
	dw -12
	dw 5
	dw -12
	dw 8
	dw -12
DATA_2260:
	dw 12
	dw -12
	dw 5
	dw -12
	dw 12
	dw -12
DATA_2270:
	dw 12
	dw -12
	dw 5
	dw -12
	dw 10
	dw -12
DATA_2280:
	dw 5
	dw -12
	dw 0
	dw -12
	dw 10
	dw -12
DATA_2290:
	dw 7
	dw -12
	dw 0
	dw -12
	dw 10
	dw -12
DATA_2300:
	dw 12
	dw -12
	dw 7
	dw -12
	dw 10
	dw -12
DATA_2310:
	dw 12
	dw -12
	dw 9
	dw -12
	dw 12
	dw -12
DATA_2320:
	dw 13
	dw -11
	dw 5
	dw -11
	dw 10
	dw -11
DATA_2330:
	dw 1
	dw -11
	dw 5
	dw -11
	dw 10
	dw -11
DATA_2340:
	dw 0
	dw -12
	dw 4
	dw -12
	dw 10
	dw -12
DATA_2350:
	dw 1
	dw -12
	dw 4
	dw -12
	dw 16
	dw -12
DATA_2360:
	dw 4
	dw -12
	dw 7
	dw -12
	dw 5
	dw -12

ZX_VARIABLES:
	db 0

    DISPLAY "Compiled Basic = ", /D, $-CBASIC_START,  " bytes"
