
CBASIC_START
compiledBasic:
	call ZXHeapClear
	LD (runtimeSaveSP),SP
	LD HL,DATA_1000
	LD (DATAPTR),HL
ZXBASIC_LINE_2:
; 2  RANDOMIZE 
	LD HL,2
	LD (23621),HL
; 		2.1  RANDOMIZE 
	LD A,1
	LD (23623),a
ZXBASIC_LINE_11:
; 11  GOSUB 950
	LD HL,11
	LD (23621),HL
; 		11.1  GOSUB 950{00 00 b6 03 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_950:
ZXBASIC_LINE_15:
; 15  LET sc=25: LET l=3
	LD HL,15
	LD (23621),HL
; 		15.1  LET sc=25{00 00 19 00 00 }
	LD A,1
	LD (23623),a
	LD HL,25
	LD (ZXBASIC_VAR_sc),HL
; 		15.2  LET l=3{00 00 03 00 00 }
	LD A,2
	LD (23623),a
	LD HL,3
	LD (ZXBASIC_VAR_l),HL
ZXBASIC_LINE_20:
; 20  GOSUB 700
	LD HL,20
	LD (23621),HL
; 		20.1  GOSUB 700{00 00 bc 02 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_700:
ZXBASIC_LINE_30:
; 30  LET k$= INKEY : LET j= IN 31
	LD HL,30
	LD (23621),HL
; 		30.1  LET k$= INKEY 
	LD A,1
	LD (23623),a
; INKEY
	CALL runtimeInkey
	LD DE,HL
	LD HL,ZXBASIC_VAR_k_string
	CALL runtimeStoreString
; 		30.2  LET j= IN 31{00 00 1f 00 00 }
	LD A,2
	LD (23623),a
; IN
	LD HL,31
	LD BC,HL
	IN A,(C)
	LD L,A
	LD H,0
	LD (ZXBASIC_VAR_j),HL
ZXBASIC_LINE_35:
; 35  IF sc=0 THEN  FOR w=10 TO 50: BEEP 0.004,w: PRINT  AT 21,11; FLASH 1;"WELL DONE": PRINT  AT r,c; INK ( RND *7);""; AT r,c; CHR 128: NEXT w: PRINT  AT 1,10;"TOWERS SAVED ";l: FOR u=1 TO 120: BEEP 0.002,( RND *35): OUT 254,( RND *32): BEEP .012,( RND *25): NEXT u: GOTO 2
	LD HL,35
	LD (23621),HL
; 		35.1  IF sc=0{00 00 00 00 00 } THEN  FOR w=10{00 00 0a 00 00 } TO 50{00 00 32 00 00 }
	LD A,1
	LD (23623),a
	LD DE,(ZXBASIC_VAR_sc)
	LD HL,0
; =
	SUB HL,DE
	LD HL,0
	CALL Z,HL1
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_1
; 		35.2  FOR w=10{00 00 0a 00 00 } TO 50{00 00 32 00 00 }
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,10
	LD (ZXBASIC_VAR_w),HL
	LD HL,50
	LD (ZXBASIC_VAR_for_w),HL
FOR_0:
; 		35.3  BEEP 0.004{79 03 12 6e 97 },w
	LD A,3
	LD (23623),a
	LD HL,FLOAT_1	;0.004
	CALL runtimePushFloatVar
	LD HL,(ZXBASIC_VAR_w)
	CALL runtimeIntToFloat
	CALL $03F8
; 		35.4  PRINT  AT 21{00 00 15 00 00 },11{00 00 0b 00 00 }; FLASH 1{00 00 01 00 00 };"WELL DONE"
	LD A,4
	LD (23623),a
	XOR A,A
	LD (ZX_TV_FLAG),A
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,21
	LD HL,11
	CALL runtimePrintAt
	LD HL,1
	CALL runtimeLocalFlash
	LD HL,STRING_0	;WELL DONE
	CALL runtimePrintString
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
; 		35.5  PRINT  AT r,c; INK ( RND *7{00 00 07 00 00 });""; AT r,c; CHR 128{00 00 80 00 00 }
	LD A,5
	LD (23623),a
	XOR A,A
	LD (ZX_TV_FLAG),A
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,(ZXBASIC_VAR_r)
	LD HL,(ZXBASIC_VAR_c)
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
	LD HL,STRING_1	;\92
	CALL runtimePrintString
	LD DE,(ZXBASIC_VAR_r)
	LD HL,(ZXBASIC_VAR_c)
	CALL runtimePrintAt
; CHR
	LD HL,128
	CALL runtimeChr
	CALL runtimePrintString
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
	CALL ZXFreeTempCompact
; 		35.6  NEXT w
	LD A,6
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,(ZXBASIC_VAR_w)
	INC HL
	LD (ZXBASIC_VAR_w),HL
	LD DE,(ZXBASIC_VAR_for_w)
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_0
; 		35.7  PRINT  AT 1{00 00 01 00 00 },10{00 00 0a 00 00 };"TOWERS SAVED ";l
	LD A,7
	LD (23623),a
	XOR A,A
	LD (ZX_TV_FLAG),A
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,1
	LD HL,10
	CALL runtimePrintAt
	LD HL,STRING_2	;TOWERS SAVED 
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_l)
	CALL runtimePrintInt
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
; 		35.8  FOR u=1{00 00 01 00 00 } TO 120{00 00 78 00 00 }
	LD A,8
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,1
	LD (ZXBASIC_VAR_u),HL
	LD HL,120
	LD (ZXBASIC_VAR_for_u),HL
FOR_1:
; 		35.9  BEEP 0.002{78 03 12 6e 97 },( RND *35{00 00 23 00 00 })
	LD A,9
	LD (23623),a
	LD HL,FLOAT_2	;0.002
	CALL runtimePushFloatVar
; (
; RND
	CALL runtimeRND
	LD HL,35
; *
	CALL runtimeIntToFloat
	RST $28
	DB $04	;MULT
	DB $38	;END CALC
; )
	CALL $03F8
; 		35.10  OUT 254{00 00 fe 00 00 },( RND *32{00 00 20 00 00 })
	LD A,10
	LD (23623),a
	LD HL,254
	PUSH HL
; (
; RND
	CALL runtimeRND
	LD HL,32
; *
	CALL runtimeIntToFloat
	RST $28
	DB $04	;MULT
	DB $38	;END CALC
; )
	CALL runtimeFloatToInt
	POP BC
	LD A,L
	OUT (C),A
; 		35.11  BEEP .012{7a 44 9b a5 e3 },( RND *25{00 00 19 00 00 })
	LD A,11
	LD (23623),a
	LD HL,FLOAT_3	;.012
	CALL runtimePushFloatVar
; (
; RND
	CALL runtimeRND
	LD HL,25
; *
	CALL runtimeIntToFloat
	RST $28
	DB $04	;MULT
	DB $38	;END CALC
; )
	CALL $03F8
; 		35.12  NEXT u
	LD A,12
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,(ZXBASIC_VAR_u)
	INC HL
	LD (ZXBASIC_VAR_u),HL
	LD DE,(ZXBASIC_VAR_for_u)
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_1
; 		35.13  GOTO 2{00 00 02 00 00 }
	LD A,13
	LD (23623),a
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_2
ZXB_LABEL_1:
ZXBASIC_LINE_40:
; 40  LET y=y+((k$="a" OR j=4) AND y<19)-((k$="q" OR j=8) AND y>3)
	LD HL,40
	LD (23621),HL
; 		40.1  LET y=y+((k$="a" OR j=4{00 00 04 00 00 }) AND y<19{00 00 13 00 00 })-((k$="q" OR j=8{00 00 08 00 00 }) AND y>3{00 00 03 00 00 })
	LD A,1
	LD (23623),a
	LD HL,(ZXBASIC_VAR_y)
	PUSH HL
; (
; (
	LD DE,(ZXBASIC_VAR_k_string)
	LD HL,STRING_3	;a
; =
	CALL runtimeEqualString
	PUSH HL
	LD DE,(ZXBASIC_VAR_j)
	LD HL,4
; =
	SUB HL,DE
	LD HL,0
	CALL Z,HL1
; OR
	POP DE
	call runtimeOrHLDE
	PUSH HL
; )
	LD DE,(ZXBASIC_VAR_y)
	LD HL,19
; <
	SUB HL,DE
	LD HL,0
	call nc,HL1
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
	LD DE,(ZXBASIC_VAR_k_string)
	LD HL,STRING_4	;q
; =
	CALL runtimeEqualString
	PUSH HL
	LD DE,(ZXBASIC_VAR_j)
	LD HL,8
; =
	SUB HL,DE
	LD HL,0
	CALL Z,HL1
; OR
	POP DE
	call runtimeOrHLDE
	PUSH HL
; )
	LD DE,(ZXBASIC_VAR_y)
	LD HL,3
; >
	SUB HL,DE
	LD HL,0
	call c,HL1
; AND
	POP DE
	call runtimeAndHLDE
; )
; -
	POP DE
	EX HL,DE
	SUB HL,DE
	LD (ZXBASIC_VAR_y),HL
	CALL ZXFreeTempCompact
ZXBASIC_LINE_45:
; 45  IF oy <> y OR ox <> x THEN  PRINT  AT oy,ox;" "; AT oy,ox+5;" ";
	LD HL,45
	LD (23621),HL
; 		45.1  IF oy <> y OR ox <> x THEN  PRINT  AT oy,ox;" "; AT oy,ox+5{00 00 05 00 00 };" ";
	LD A,1
	LD (23623),a
	LD DE,(ZXBASIC_VAR_oy)
	LD HL,(ZXBASIC_VAR_y)
; <>
	SUB HL,DE
	LD HL,0
	CALL NZ,HL1
	PUSH HL
	LD DE,(ZXBASIC_VAR_ox)
	LD HL,(ZXBASIC_VAR_x)
; <>
	SUB HL,DE
	LD HL,0
	CALL NZ,HL1
; OR
	POP DE
	call runtimeOrHLDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_2
; 		45.2  PRINT  AT oy,ox;" "; AT oy,ox+5{00 00 05 00 00 };" ";
	LD A,2
	LD (23623),a
	XOR A,A
	LD (ZX_TV_FLAG),A
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,(ZXBASIC_VAR_oy)
	LD HL,(ZXBASIC_VAR_ox)
	CALL runtimePrintAt
	LD HL,STRING_5	; 
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_oy)
	PUSH HL
	LD DE,(ZXBASIC_VAR_ox)
	LD HL,5
; +
	ADD HL,DE
	POP DE
	CALL runtimePrintAt
	LD HL,STRING_5	; 
	CALL runtimePrintString
	POP AF
	LD (ZX_P_FLAG),A
ZXB_LABEL_2:
ZXBASIC_LINE_50:
; 50  PRINT  AT y,x; INK 1;""; AT y,x+5;"";
	LD HL,50
	LD (23621),HL
; 		50.1  PRINT  AT y,x; INK 1{00 00 01 00 00 };""; AT y,x+5{00 00 05 00 00 };"";
	LD A,1
	LD (23623),a
	XOR A,A
	LD (ZX_TV_FLAG),A
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,(ZXBASIC_VAR_y)
	LD HL,(ZXBASIC_VAR_x)
	CALL runtimePrintAt
	LD HL,1
	CALL runtimeLocalInk
	LD HL,STRING_6	;\90
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_y)
	PUSH HL
	LD DE,(ZXBASIC_VAR_x)
	LD HL,5
; +
	ADD HL,DE
	POP DE
	CALL runtimePrintAt
	LD HL,STRING_7	;\91
	CALL runtimePrintString
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_55:
; 55  LET oy=y: LET ox=x
	LD HL,55
	LD (23621),HL
; 		55.1  LET oy=y
	LD A,1
	LD (23623),a
	LD HL,(ZXBASIC_VAR_y)
	LD (ZXBASIC_VAR_oy),HL
; 		55.2  LET ox=x
	LD A,2
	LD (23623),a
	LD HL,(ZXBASIC_VAR_x)
	LD (ZXBASIC_VAR_ox),HL
ZXBASIC_LINE_60:
; 60  IF (k$="o" OR j=2) AND c<12 THEN  LET fl=1: GOSUB 200
	LD HL,60
	LD (23621),HL
; 		60.1  IF (k$="o" OR j=2{00 00 02 00 00 }) AND c<12{00 00 0c 00 00 } THEN  LET fl=1{00 00 01 00 00 }
	LD A,1
	LD (23623),a
; (
	LD DE,(ZXBASIC_VAR_k_string)
	LD HL,STRING_8	;o
; =
	CALL runtimeEqualString
	PUSH HL
	LD DE,(ZXBASIC_VAR_j)
	LD HL,2
; =
	SUB HL,DE
	LD HL,0
	CALL Z,HL1
; OR
	POP DE
	call runtimeOrHLDE
	PUSH HL
; )
	LD DE,(ZXBASIC_VAR_c)
	LD HL,12
; <
	SUB HL,DE
	LD HL,0
	call nc,HL1
; AND
	POP DE
	call runtimeAndHLDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_3
; 		60.2  LET fl=1{00 00 01 00 00 }
	LD A,2
	LD (23623),a
	LD HL,1
	LD (ZXBASIC_VAR_fl),HL
; 		60.3  GOSUB 200{00 00 c8 00 00 }
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_200:
ZXB_LABEL_3:
ZXBASIC_LINE_65:
; 65  IF (k$="p" OR j=1) AND c>17 THEN  LET fr=1: GOSUB 200
	LD HL,65
	LD (23621),HL
; 		65.1  IF (k$="p" OR j=1{00 00 01 00 00 }) AND c>17{00 00 11 00 00 } THEN  LET fr=1{00 00 01 00 00 }
	LD A,1
	LD (23623),a
; (
	LD DE,(ZXBASIC_VAR_k_string)
	LD HL,STRING_9	;p
; =
	CALL runtimeEqualString
	PUSH HL
	LD DE,(ZXBASIC_VAR_j)
	LD HL,1
; =
	SUB HL,DE
	LD HL,0
	CALL Z,HL1
; OR
	POP DE
	call runtimeOrHLDE
	PUSH HL
; )
	LD DE,(ZXBASIC_VAR_c)
	LD HL,17
; >
	SUB HL,DE
	LD HL,0
	call c,HL1
; AND
	POP DE
	call runtimeAndHLDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_4
; 		65.2  LET fr=1{00 00 01 00 00 }
	LD A,2
	LD (23623),a
	LD HL,1
	LD (ZXBASIC_VAR_fr),HL
; 		65.3  GOSUB 200{00 00 c8 00 00 }
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_200:
ZXB_LABEL_4:
ZXBASIC_LINE_111:
; 111  PRINT  AT r,c;" "
	LD HL,111
	LD (23621),HL
; 		111.1  PRINT  AT r,c;" "
	LD A,1
	LD (23623),a
	XOR A,A
	LD (ZX_TV_FLAG),A
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,(ZXBASIC_VAR_r)
	LD HL,(ZXBASIC_VAR_c)
	CALL runtimePrintAt
	LD HL,STRING_5	; 
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_120:
; 120  LET r=r+v: LET c=c+h
	LD HL,120
	LD (23621),HL
; 		120.1  LET r=r+v
	LD A,1
	LD (23623),a
	LD DE,(ZXBASIC_VAR_r)
	LD HL,(ZXBASIC_VAR_v)
; +
	ADD HL,DE
	LD (ZXBASIC_VAR_r),HL
; 		120.2  LET c=c+h
	LD A,2
	LD (23623),a
	LD DE,(ZXBASIC_VAR_c)
	LD HL,(ZXBASIC_VAR_h)
; +
	ADD HL,DE
	LD (ZXBASIC_VAR_c),HL
ZXBASIC_LINE_125:
; 125  PRINT  AT r,c;" "
	LD HL,125
	LD (23621),HL
; 		125.1  PRINT  AT r,c;" "
	LD A,1
	LD (23623),a
	XOR A,A
	LD (ZX_TV_FLAG),A
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,(ZXBASIC_VAR_r)
	LD HL,(ZXBASIC_VAR_c)
	CALL runtimePrintAt
	LD HL,STRING_5	; 
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_126:
; 126  BEEP 0.0015,60
	LD HL,126
	LD (23621),HL
; 		126.1  BEEP 0.0015{77 44 9b a5 e3 },60{00 00 3c 00 00 }
	LD A,1
	LD (23623),a
	LD HL,FLOAT_4	;0.0015
	CALL runtimePushFloatVar
	LD HL,60
	CALL runtimeIntToFloat
	CALL $03F8
ZXBASIC_LINE_135:
; 135  IF c<1 OR c>30 THEN  LET h=-h
	LD HL,135
	LD (23621),HL
; 		135.1  IF c<1{00 00 01 00 00 } OR c>30{00 00 1e 00 00 } THEN  LET h=-h
	LD A,1
	LD (23623),a
	LD DE,(ZXBASIC_VAR_c)
	LD HL,1
; <
	SUB HL,DE
	LD HL,0
	call nc,HL1
	PUSH HL
	LD DE,(ZXBASIC_VAR_c)
	LD HL,30
; >
	SUB HL,DE
	LD HL,0
	call c,HL1
; OR
	POP DE
	call runtimeOrHLDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_5
; 		135.2  LET h=-h
	LD A,2
	LD (23623),a
	LD HL,(ZXBASIC_VAR_h)
	LD BC,HL
; -
	LD HL,0
	SUB HL,BC
	LD (ZXBASIC_VAR_h),HL
ZXB_LABEL_5:
ZXBASIC_LINE_140:
; 140  IF r<0 OR r >= 18 THEN  LET v=-v
	LD HL,140
	LD (23621),HL
; 		140.1  IF r<0{00 00 00 00 00 } OR r >= 18{00 00 12 00 00 } THEN  LET v=-v
	LD A,1
	LD (23623),a
	LD DE,(ZXBASIC_VAR_r)
	LD HL,0
; <
	SUB HL,DE
	LD HL,0
	call nc,HL1
	PUSH HL
	LD DE,(ZXBASIC_VAR_r)
	LD HL,18
; >=
	SUB HL,DE
	LD HL,0
	call c,HL1
	call z,HL1
; OR
	POP DE
	call runtimeOrHLDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_6
; 		140.2  LET v=-v
	LD A,2
	LD (23623),a
	LD HL,(ZXBASIC_VAR_v)
	LD BC,HL
; -
	LD HL,0
	SUB HL,BC
	LD (ZXBASIC_VAR_v),HL
ZXB_LABEL_6:
ZXBASIC_LINE_158:
; 158  IF or>2 AND oc>13.5 AND oc<17.5 THEN  BEEP 0.015,-12.0: PRINT  AT r,c; FLASH 1; OVER 1; INK 2; PAPER 6;"*"; AT or,oc;"": LET i=i+1
	LD HL,158
	LD (23621),HL
; 		158.1  IF or>2{00 00 02 00 00 } AND oc>13.5{84 58 00 00 00 } AND oc<17.5{85 0c 00 00 00 } THEN  BEEP 0.015{7a 75 c2 8f 5c },-12.0{00 00 0c 00 00 }
	LD A,1
	LD (23623),a
	LD DE,(ZXBASIC_VAR_or)
	LD HL,2
; >
	SUB HL,DE
	LD HL,0
	call c,HL1
	PUSH HL
	LD HL,(ZXBASIC_VAR_oc)
	PUSH HL
	LD HL,FLOAT_5	;13.5
	CALL runtimePushFloatVar
; >
	POP HL
	CALL runtimeIntToFloat
	CALL runtimeSwapFloat
	CALL runtimeBiggerFloat
; AND
	POP DE
	call runtimeAndHLDE
	PUSH HL
	LD HL,(ZXBASIC_VAR_oc)
	PUSH HL
	LD HL,FLOAT_6	;17.5
	CALL runtimePushFloatVar
; <
	POP HL
	CALL runtimeIntToFloat
	CALL runtimeSwapFloat
	CALL runtimeSmallerFloat
; AND
	POP DE
	call runtimeAndHLDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_7
; 		158.2  BEEP 0.015{7a 75 c2 8f 5c },-12.0{00 00 0c 00 00 }
	LD A,2
	LD (23623),a
	LD HL,FLOAT_7	;0.015
	CALL runtimePushFloatVar
	LD HL,FLOAT_8	;12.0
	CALL runtimePushFloatVar
; -
	CALL runtimeNegFloat
	CALL $03F8
; 		158.3  PRINT  AT r,c; FLASH 1{00 00 01 00 00 }; OVER 1{00 00 01 00 00 }; INK 2{00 00 02 00 00 }; PAPER 6{00 00 06 00 00 };"*"; AT or,oc;""
	LD A,3
	LD (23623),a
	XOR A,A
	LD (ZX_TV_FLAG),A
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,(ZXBASIC_VAR_r)
	LD HL,(ZXBASIC_VAR_c)
	CALL runtimePrintAt
	LD HL,1
	CALL runtimeLocalFlash
	LD HL,1
	CALL runtimeLocalOver
	LD HL,2
	CALL runtimeLocalInk
	LD HL,6
	CALL runtimeLocalPaper
	LD HL,STRING_10	;*
	CALL runtimePrintString
	LD DE,(ZXBASIC_VAR_or)
	LD HL,(ZXBASIC_VAR_oc)
	CALL runtimePrintAt
	LD HL,STRING_11	;\89
	CALL runtimePrintString
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
; 		158.4  LET i=i+1{00 00 01 00 00 }
	LD A,4
	LD (23623),a
	LD HL,(ZXBASIC_VAR_i)
	INC HL
; +
	LD (ZXBASIC_VAR_i),HL
ZXB_LABEL_7:
ZXBASIC_LINE_159:
; 159  PRINT  AT r,c;""
	LD HL,159
	LD (23621),HL
; 		159.1  PRINT  AT r,c;""
	LD A,1
	LD (23623),a
	XOR A,A
	LD (ZX_TV_FLAG),A
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,(ZXBASIC_VAR_r)
	LD HL,(ZXBASIC_VAR_c)
	CALL runtimePrintAt
	LD HL,STRING_1	;\92
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_160:
; 160  LET or=r: LET oc=c
	LD HL,160
	LD (23621),HL
; 		160.1  LET or=r
	LD A,1
	LD (23623),a
	LD HL,(ZXBASIC_VAR_r)
	LD (ZXBASIC_VAR_or),HL
; 		160.2  LET oc=c
	LD A,2
	LD (23623),a
	LD HL,(ZXBASIC_VAR_c)
	LD (ZXBASIC_VAR_oc),HL
ZXBASIC_LINE_170:
; 170  IF i >= 20 THEN  FOR k=-20 TO 10: BEEP 0.015,-10: NEXT k: LET l=l-1: PRINT  AT 21,31; PAPER 4;l;: LET i=0: GOTO 175
	LD HL,170
	LD (23621),HL
; 		170.1  IF i >= 20{00 00 14 00 00 } THEN  FOR k=-20{00 00 14 00 00 } TO 10{00 00 0a 00 00 }
	LD A,1
	LD (23623),a
	LD DE,(ZXBASIC_VAR_i)
	LD HL,20
; >=
	SUB HL,DE
	LD HL,0
	call c,HL1
	call z,HL1
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_8
; 		170.2  FOR k=-20{00 00 14 00 00 } TO 10{00 00 0a 00 00 }
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,20
	LD BC,HL
; -
	LD HL,0
	SUB HL,BC
	LD (ZXBASIC_VAR_k),HL
	LD HL,10
	LD (ZXBASIC_VAR_for_k),HL
FOR_2:
; 		170.3  BEEP 0.015{7a 75 c2 8f 5c },-10{00 00 0a 00 00 }
	LD A,3
	LD (23623),a
	LD HL,FLOAT_7	;0.015
	CALL runtimePushFloatVar
	LD HL,10
	LD BC,HL
; -
	LD HL,0
	SUB HL,BC
	CALL runtimeIntToFloat
	CALL $03F8
; 		170.4  NEXT k
	LD A,4
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,(ZXBASIC_VAR_k)
	INC HL
	LD (ZXBASIC_VAR_k),HL
	LD DE,(ZXBASIC_VAR_for_k)
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_2
; 		170.5  LET l=l-1{00 00 01 00 00 }
	LD A,5
	LD (23623),a
	LD HL,(ZXBASIC_VAR_l)
	DEC HL
; -
	LD (ZXBASIC_VAR_l),HL
; 		170.6  PRINT  AT 21{00 00 15 00 00 },31{00 00 1f 00 00 }; PAPER 4{00 00 04 00 00 };l;
	LD A,6
	LD (23623),a
	XOR A,A
	LD (ZX_TV_FLAG),A
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,21
	LD HL,31
	CALL runtimePrintAt
	LD HL,4
	CALL runtimeLocalPaper
	LD HL,(ZXBASIC_VAR_l)
	CALL runtimePrintInt
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
; 		170.7  LET i=0{00 00 00 00 00 }
	LD A,7
	LD (23623),a
	LD HL,0
	LD (ZXBASIC_VAR_i),HL
; 		170.8  GOTO 175{00 00 af 00 00 }
	LD A,8
	LD (23623),a
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_175
ZXB_LABEL_8:
ZXBASIC_LINE_172:
; 172  GOTO 30
	LD HL,172
	LD (23621),HL
; 		172.1  GOTO 30{00 00 1e 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_30
ZXBASIC_LINE_175:
; 175  FOR d=3 TO 19: BEEP 0.001,-25: PRINT  AT d,14; PAPER 5; OVER 1; INK 2; PAPER 6; FLASH 1;"****"; AT d,14;"";: NEXT d: FOR s=1 TO 420: NEXT s
	LD HL,175
	LD (23621),HL
; 		175.1  FOR d=3{00 00 03 00 00 } TO 19{00 00 13 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,3
	LD (ZXBASIC_VAR_d),HL
	LD HL,19
	LD (ZXBASIC_VAR_for_d),HL
FOR_3:
; 		175.2  BEEP 0.001{77 03 12 6e 97 },-25{00 00 19 00 00 }
	LD A,2
	LD (23623),a
	LD HL,FLOAT_9	;0.001
	CALL runtimePushFloatVar
	LD HL,25
	LD BC,HL
; -
	LD HL,0
	SUB HL,BC
	CALL runtimeIntToFloat
	CALL $03F8
; 		175.3  PRINT  AT d,14{00 00 0e 00 00 }; PAPER 5{00 00 05 00 00 }; OVER 1{00 00 01 00 00 }; INK 2{00 00 02 00 00 }; PAPER 6{00 00 06 00 00 }; FLASH 1{00 00 01 00 00 };"****"; AT d,14{00 00 0e 00 00 };"";
	LD A,3
	LD (23623),a
	XOR A,A
	LD (ZX_TV_FLAG),A
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,(ZXBASIC_VAR_d)
	LD HL,14
	CALL runtimePrintAt
	LD HL,5
	CALL runtimeLocalPaper
	LD HL,1
	CALL runtimeLocalOver
	LD HL,2
	CALL runtimeLocalInk
	LD HL,6
	CALL runtimeLocalPaper
	LD HL,1
	CALL runtimeLocalFlash
	LD HL,STRING_12	;****
	CALL runtimePrintString
	LD DE,(ZXBASIC_VAR_d)
	LD HL,14
	CALL runtimePrintAt
	LD HL,STRING_13	;\92\92\92\92
	CALL runtimePrintString
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
; 		175.4  NEXT d
	LD A,4
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,(ZXBASIC_VAR_d)
	INC HL
	LD (ZXBASIC_VAR_d),HL
	LD DE,(ZXBASIC_VAR_for_d)
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_3
; 		175.5  FOR s=1{00 00 01 00 00 } TO 420{00 00 a4 01 00 }
	LD A,5
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,1
	LD (ZXBASIC_VAR_s),HL
	LD HL,420
	LD (ZXBASIC_VAR_for_s),HL
FOR_4:
; 		175.6  NEXT s
	LD A,6
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,(ZXBASIC_VAR_s)
	INC HL
	LD (ZXBASIC_VAR_s),HL
	LD DE,(ZXBASIC_VAR_for_s)
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_4
ZXBASIC_LINE_180:
; 180  IF l=0 THEN  LET l=3: LET sc=20: PRINT  AT 1,8; FLASH 1; INK 0;"G A M E  O V E R": FOR a=1 TO 120: BEEP 0.015,a/35: NEXT a: CLS : GOTO 20
	LD HL,180
	LD (23621),HL
; 		180.1  IF l=0{00 00 00 00 00 } THEN  LET l=3{00 00 03 00 00 }
	LD A,1
	LD (23623),a
	LD DE,(ZXBASIC_VAR_l)
	LD HL,0
; =
	SUB HL,DE
	LD HL,0
	CALL Z,HL1
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_9
; 		180.2  LET l=3{00 00 03 00 00 }
	LD A,2
	LD (23623),a
	LD HL,3
	LD (ZXBASIC_VAR_l),HL
; 		180.3  LET sc=20{00 00 14 00 00 }
	LD A,3
	LD (23623),a
	LD HL,20
	LD (ZXBASIC_VAR_sc),HL
; 		180.4  PRINT  AT 1{00 00 01 00 00 },8{00 00 08 00 00 }; FLASH 1{00 00 01 00 00 }; INK 0{00 00 00 00 00 };"G A M E  O V E R"
	LD A,4
	LD (23623),a
	XOR A,A
	LD (ZX_TV_FLAG),A
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,1
	LD HL,8
	CALL runtimePrintAt
	LD HL,1
	CALL runtimeLocalFlash
	LD HL,0
	CALL runtimeLocalInk
	LD HL,STRING_14	;G A M E  O V E R
	CALL runtimePrintString
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
; 		180.5  FOR a=1{00 00 01 00 00 } TO 120{00 00 78 00 00 }
	LD A,5
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,1
	LD (ZXBASIC_VAR_a),HL
	LD HL,120
	LD (ZXBASIC_VAR_for_a),HL
FOR_5:
; 		180.6  BEEP 0.015{7a 75 c2 8f 5c },a/35{00 00 23 00 00 }
	LD A,6
	LD (23623),a
	LD HL,FLOAT_7	;0.015
	CALL runtimePushFloatVar
	LD DE,(ZXBASIC_VAR_a)
	LD HL,35
; /
	call runtimeDiv16bit
	CALL runtimeIntToFloat
	CALL $03F8
; 		180.7  NEXT a
	LD A,7
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,(ZXBASIC_VAR_a)
	INC HL
	LD (ZXBASIC_VAR_a),HL
	LD DE,(ZXBASIC_VAR_for_a)
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_5
; 		180.8  CLS 
	LD A,8
	LD (23623),a
	CALL runtimeCls
; 		180.9  GOTO 20{00 00 14 00 00 }
	LD A,9
	LD (23623),a
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_20
ZXB_LABEL_9:
ZXBASIC_LINE_190:
; 190  GOSUB 800
	LD HL,190
	LD (23621),HL
; 		190.1  GOSUB 800{00 00 20 03 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_800:
ZXBASIC_LINE_195:
; 195  GOTO 30
	LD HL,195
	LD (23621),HL
; 		195.1  GOTO 30{00 00 1e 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_30
ZXBASIC_LINE_200:
; 200  BEEP 0.0020,15: OUT 254,( RND *32)
	LD HL,200
	LD (23621),HL
; 		200.1  BEEP 0.0020{78 03 12 6e 97 },15{00 00 0f 00 00 }
	LD A,1
	LD (23623),a
	LD HL,FLOAT_2	;0.0020
	CALL runtimePushFloatVar
	LD HL,15
	CALL runtimeIntToFloat
	CALL $03F8
; 		200.2  OUT 254{00 00 fe 00 00 },( RND *32{00 00 20 00 00 })
	LD A,2
	LD (23623),a
	LD HL,254
	PUSH HL
; (
; RND
	CALL runtimeRND
	LD HL,32
; *
	CALL runtimeIntToFloat
	RST $28
	DB $04	;MULT
	DB $38	;END CALC
; )
	CALL runtimeFloatToInt
	POP BC
	LD A,L
	OUT (C),A
ZXBASIC_LINE_210:
; 210  IF fl=1 THEN  PLOT  INK 5;ox*8-1,oy*8-173: DRAW  OVER 1; INK 3;-70,0: DRAW  OVER 1; INK 5;70,0: LET fl=0
	LD HL,210
	LD (23621),HL
; 		210.1  IF fl=1{00 00 01 00 00 } THEN  PLOT  INK 5{00 00 05 00 00 };ox*8{00 00 08 00 00 }-1{00 00 01 00 00 },oy*8{00 00 08 00 00 }-173{00 00 ad 00 00 }
	LD A,1
	LD (23623),a
	LD DE,(ZXBASIC_VAR_fl)
	LD HL,1
; =
	SUB HL,DE
	LD HL,0
	CALL Z,HL1
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_10
; 		210.2  PLOT  INK 5{00 00 05 00 00 };ox*8{00 00 08 00 00 }-1{00 00 01 00 00 },oy*8{00 00 08 00 00 }-173{00 00 ad 00 00 }
	LD A,2
	LD (23623),a
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,5
	CALL runtimeLocalInk
	LD DE,(ZXBASIC_VAR_ox)
	LD HL,8
; *
	call runtimeMult16bit
	LD DE,1
; -
	SUB HL,DE
	PUSH HL
	LD DE,(ZXBASIC_VAR_oy)
	LD HL,8
; *
	call runtimeMult16bit
	LD DE,173
; -
	SUB HL,DE
	POP DE
	CALL runtimePlot
	POP AF
	LD (ZX_P_FLAG),A
; 		210.3  DRAW  OVER 1{00 00 01 00 00 }; INK 3{00 00 03 00 00 };-70{00 00 46 00 00 },0{00 00 00 00 00 }
	LD A,3
	LD (23623),a
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,1
	CALL runtimeLocalOver
	LD HL,3
	CALL runtimeLocalInk
	LD HL,70
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
; 		210.4  DRAW  OVER 1{00 00 01 00 00 }; INK 5{00 00 05 00 00 };70{00 00 46 00 00 },0{00 00 00 00 00 }
	LD A,4
	LD (23623),a
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,1
	CALL runtimeLocalOver
	LD HL,5
	CALL runtimeLocalInk
	LD DE,70
	LD HL,0
	LD B,L
	LD C,E
	CALL runtimeDraw
	POP AF
	LD (ZX_P_FLAG),A
; 		210.5  LET fl=0{00 00 00 00 00 }
	LD A,5
	LD (23623),a
	LD HL,0
	LD (ZXBASIC_VAR_fl),HL
ZXB_LABEL_10:
ZXBASIC_LINE_250:
; 250  IF fr=1 THEN  PLOT  INK 5;ox*8+48,oy*8-173: DRAW  OVER 1; INK 3;70,0: DRAW  OVER 1; INK 5;-70,0: LET fr=0
	LD HL,250
	LD (23621),HL
; 		250.1  IF fr=1{00 00 01 00 00 } THEN  PLOT  INK 5{00 00 05 00 00 };ox*8{00 00 08 00 00 }+48{00 00 30 00 00 },oy*8{00 00 08 00 00 }-173{00 00 ad 00 00 }
	LD A,1
	LD (23623),a
	LD DE,(ZXBASIC_VAR_fr)
	LD HL,1
; =
	SUB HL,DE
	LD HL,0
	CALL Z,HL1
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_11
; 		250.2  PLOT  INK 5{00 00 05 00 00 };ox*8{00 00 08 00 00 }+48{00 00 30 00 00 },oy*8{00 00 08 00 00 }-173{00 00 ad 00 00 }
	LD A,2
	LD (23623),a
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,5
	CALL runtimeLocalInk
	LD DE,(ZXBASIC_VAR_ox)
	LD HL,8
; *
	call runtimeMult16bit
	LD DE,HL
	LD HL,48
; +
	ADD HL,DE
	PUSH HL
	LD DE,(ZXBASIC_VAR_oy)
	LD HL,8
; *
	call runtimeMult16bit
	LD DE,173
; -
	SUB HL,DE
	POP DE
	CALL runtimePlot
	POP AF
	LD (ZX_P_FLAG),A
; 		250.3  DRAW  OVER 1{00 00 01 00 00 }; INK 3{00 00 03 00 00 };70{00 00 46 00 00 },0{00 00 00 00 00 }
	LD A,3
	LD (23623),a
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,1
	CALL runtimeLocalOver
	LD HL,3
	CALL runtimeLocalInk
	LD DE,70
	LD HL,0
	LD B,L
	LD C,E
	CALL runtimeDraw
	POP AF
	LD (ZX_P_FLAG),A
; 		250.4  DRAW  OVER 1{00 00 01 00 00 }; INK 5{00 00 05 00 00 };-70{00 00 46 00 00 },0{00 00 00 00 00 }
	LD A,4
	LD (23623),a
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,1
	CALL runtimeLocalOver
	LD HL,5
	CALL runtimeLocalInk
	LD HL,70
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
; 		250.5  LET fr=0{00 00 00 00 00 }
	LD A,5
	LD (23623),a
	LD HL,0
	LD (ZXBASIC_VAR_fr),HL
ZXB_LABEL_11:
ZXBASIC_LINE_260:
; 260  IF  ATTR (r,c)=40 THEN  RETURN 
	LD HL,260
	LD (23621),HL
; 		260.1  IF  ATTR (r,c)=40{00 00 28 00 00 } THEN  RETURN 
	LD A,1
	LD (23623),a
; ATTR
	LD DE,(ZXBASIC_VAR_r)
	LD HL,(ZXBASIC_VAR_c)
	CALL runtimeAttr
	LD DE,HL
	LD HL,40
; =
	SUB HL,DE
	LD HL,0
	CALL Z,HL1
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_12
; 		260.2  RETURN 
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	RET
ZXB_LABEL_12:
ZXBASIC_LINE_270:
; 270  FOR g=50 TO 55: PRINT  AT r,c; INK ( RND *7);"";: BEEP 0.001,g: PRINT  AT r,c; CHR 128: NEXT g: LET sc=sc-1: LET r=1: LET c=( RND *29)+1
	LD HL,270
	LD (23621),HL
; 		270.1  FOR g=50{00 00 32 00 00 } TO 55{00 00 37 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,50
	LD (ZXBASIC_VAR_g),HL
	LD HL,55
	LD (ZXBASIC_VAR_for_g),HL
FOR_6:
; 		270.2  PRINT  AT r,c; INK ( RND *7{00 00 07 00 00 });"";
	LD A,2
	LD (23623),a
	XOR A,A
	LD (ZX_TV_FLAG),A
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,(ZXBASIC_VAR_r)
	LD HL,(ZXBASIC_VAR_c)
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
	LD HL,STRING_1	;\92
	CALL runtimePrintString
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
; 		270.3  BEEP 0.001{77 03 12 6e 97 },g
	LD A,3
	LD (23623),a
	LD HL,FLOAT_9	;0.001
	CALL runtimePushFloatVar
	LD HL,(ZXBASIC_VAR_g)
	CALL runtimeIntToFloat
	CALL $03F8
; 		270.4  PRINT  AT r,c; CHR 128{00 00 80 00 00 }
	LD A,4
	LD (23623),a
	XOR A,A
	LD (ZX_TV_FLAG),A
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,(ZXBASIC_VAR_r)
	LD HL,(ZXBASIC_VAR_c)
	CALL runtimePrintAt
; CHR
	LD HL,128
	CALL runtimeChr
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
	CALL ZXFreeTempCompact
; 		270.5  NEXT g
	LD A,5
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,(ZXBASIC_VAR_g)
	INC HL
	LD (ZXBASIC_VAR_g),HL
	LD DE,(ZXBASIC_VAR_for_g)
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_6
; 		270.6  LET sc=sc-1{00 00 01 00 00 }
	LD A,6
	LD (23623),a
	LD HL,(ZXBASIC_VAR_sc)
	DEC HL
; -
	LD (ZXBASIC_VAR_sc),HL
; 		270.7  LET r=1{00 00 01 00 00 }
	LD A,7
	LD (23623),a
	LD HL,1
	LD (ZXBASIC_VAR_r),HL
; 		270.8  LET c=( RND *29{00 00 1d 00 00 })+1{00 00 01 00 00 }
	LD A,8
	LD (23623),a
; (
; RND
	CALL runtimeRND
	LD HL,29
; *
	CALL runtimeIntToFloat
	RST $28
	DB $04	;MULT
	DB $38	;END CALC
; )
	LD HL,1
; +
	CALL runtimeIntToFloat
	CALL runtimePlusFloat
	CALL runtimeFloatToInt
	LD (ZXBASIC_VAR_c),HL
ZXBASIC_LINE_275:
; 275  PRINT  AT 21,4; PAPER 4;sc; CHR 128
	LD HL,275
	LD (23621),HL
; 		275.1  PRINT  AT 21{00 00 15 00 00 },4{00 00 04 00 00 }; PAPER 4{00 00 04 00 00 };sc; CHR 128{00 00 80 00 00 }
	LD A,1
	LD (23623),a
	XOR A,A
	LD (ZX_TV_FLAG),A
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,21
	LD HL,4
	CALL runtimePrintAt
	LD HL,4
	CALL runtimeLocalPaper
	LD HL,(ZXBASIC_VAR_sc)
	CALL runtimePrintInt
; CHR
	LD HL,128
	CALL runtimeChr
	CALL runtimePrintString
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
	CALL ZXFreeTempCompact
ZXBASIC_LINE_280:
; 280  RETURN 
	LD HL,280
	LD (23621),HL
; 		280.1  RETURN 
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	RET
ZXBASIC_LINE_700:
; 700  PAPER 7: INK 0: BORDER 7: CLS 
	LD HL,700
	LD (23621),HL
; 		700.1  PAPER 7{00 00 07 00 00 }
	LD A,1
	LD (23623),a
	LD HL,7
	CALL runtimePaper
; 		700.2  INK 0{00 00 00 00 00 }
	LD A,2
	LD (23623),a
	LD HL,0
	CALL runtimeInk
; 		700.3  BORDER 7{00 00 07 00 00 }
	LD A,3
	LD (23623),a
	LD HL,7
	LD A,L
	call $2297
; 		700.4  CLS 
	LD A,4
	LD (23623),a
	CALL runtimeCls
ZXBASIC_LINE_701:
; 701  PRINT  AT 7,2;"                                                                                                                                                                                           ";
	LD HL,701
	LD (23621),HL
; 		701.1  PRINT  AT 7{00 00 07 00 00 },2{00 00 02 00 00 };"                                                                                                                                                                                           ";
	LD A,1
	LD (23623),a
	XOR A,A
	LD (ZX_TV_FLAG),A
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,7
	LD HL,2
	CALL runtimePrintAt
	LD HL,STRING_15	;\8f      \8f  \8f\8f\8f\8f\8f\8f\8f\8f   \8f\8f\8f\8f\8f\8f     \8f      \8f  \8f         \8f      \8f    \8f      \8f  \8f         \8f      \8f    \8f      \8f  \8f\8f\8f\8f\8f\8f\8f   \8f      \8f    \8f      \8f  \8f         \8f      \8f    \8f      \8f  \8f         \8f      \8f    \8f      \8f  \8f         \8f      \8f     \8f\8f\8f\8f\8f\8f   \8f          \8f\8f\8f\8f\8f\8f 
	CALL runtimePrintString
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_702:
; 702  PRINT  AT 21,10;"By Animated AL"
	LD HL,702
	LD (23621),HL
; 		702.1  PRINT  AT 21{00 00 15 00 00 },10{00 00 0a 00 00 };"By Animated AL"
	LD A,1
	LD (23623),a
	XOR A,A
	LD (ZX_TV_FLAG),A
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,21
	LD HL,10
	CALL runtimePrintAt
	LD HL,STRING_16	;By Animated AL
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_703:
; 703  PRINT  AT 1,8;"PRESS FIRE TO PLAY"
	LD HL,703
	LD (23621),HL
; 		703.1  PRINT  AT 1{00 00 01 00 00 },8{00 00 08 00 00 };"PRESS FIRE TO PLAY"
	LD A,1
	LD (23623),a
	XOR A,A
	LD (ZX_TV_FLAG),A
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,1
	LD HL,8
	CALL runtimePrintAt
	LD HL,STRING_17	;PRESS FIRE TO PLAY
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_705:
; 705  OUT 254,( RND *32)
	LD HL,705
	LD (23621),HL
; 		705.1  OUT 254{00 00 fe 00 00 },( RND *32{00 00 20 00 00 })
	LD A,1
	LD (23623),a
	LD HL,254
	PUSH HL
; (
; RND
	CALL runtimeRND
	LD HL,32
; *
	CALL runtimeIntToFloat
	RST $28
	DB $04	;MULT
	DB $38	;END CALC
; )
	CALL runtimeFloatToInt
	POP BC
	LD A,L
	OUT (C),A
ZXBASIC_LINE_706:
; 706  BEEP 0.008,35-( RND *7)
	LD HL,706
	LD (23621),HL
; 		706.1  BEEP 0.008{7a 03 12 6e 97 },35{00 00 23 00 00 }-( RND *7{00 00 07 00 00 })
	LD A,1
	LD (23623),a
	LD HL,FLOAT_10	;0.008
	CALL runtimePushFloatVar
	LD HL,35
	PUSH HL
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
; -
	POP HL
	CALL runtimeIntToFloat
	CALL runtimeSwapFloat
	CALL runtimeMinusFloat
	CALL $03F8
ZXBASIC_LINE_715:
; 715  IF  INKEY  <> "" OR  IN 31=16 THEN  LET cn=2: GOTO 800
	LD HL,715
	LD (23621),HL
; 		715.1  IF  INKEY  <> "" OR  IN 31{00 00 1f 00 00 }=16{00 00 10 00 00 } THEN  LET cn=2{00 00 02 00 00 }
	LD A,1
	LD (23623),a
; INKEY
	CALL runtimeInkey
	LD DE,HL
	LD HL,STRING_18	;
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
	SUB HL,DE
	LD HL,0
	CALL Z,HL1
; OR
	POP DE
	call runtimeOrHLDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_13
; 		715.2  LET cn=2{00 00 02 00 00 }
	LD A,2
	LD (23623),a
	LD HL,2
	LD (ZXBASIC_VAR_cn),HL
; 		715.3  GOTO 800{00 00 20 03 00 }
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_800
ZXB_LABEL_13:
ZXBASIC_LINE_720:
; 720  GOTO 705
	LD HL,720
	LD (23621),HL
; 		720.1  GOTO 705{00 00 c1 02 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_705
ZXBASIC_LINE_800:
; 800  REM SET UP
	LD HL,800
	LD (23621),HL
	LD A,1
	LD (23623),a
ZXBASIC_LINE_805:
; 805  PAPER 5: INK 0: BORDER 5: CLS 
	LD HL,805
	LD (23621),HL
; 		805.1  PAPER 5{00 00 05 00 00 }
	LD A,1
	LD (23623),a
	LD HL,5
	CALL runtimePaper
; 		805.2  INK 0{00 00 00 00 00 }
	LD A,2
	LD (23623),a
	LD HL,0
	CALL runtimeInk
; 		805.3  BORDER 5{00 00 05 00 00 }
	LD A,3
	LD (23623),a
	LD HL,5
	LD A,L
	call $2297
; 		805.4  CLS 
	LD A,4
	LD (23623),a
	CALL runtimeCls
ZXBASIC_LINE_810:
; 810  FOR b=4 TO 19
	LD HL,810
	LD (23621),HL
; 		810.1  FOR b=4{00 00 04 00 00 } TO 19{00 00 13 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,4
	LD (ZXBASIC_VAR_b),HL
	LD HL,19
	LD (ZXBASIC_VAR_for_b),HL
FOR_7:
ZXBASIC_LINE_815:
; 815  PRINT  AT 3,14;""; PAPER 7;""; PAPER 5;"";
	LD HL,815
	LD (23621),HL
; 		815.1  PRINT  AT 3{00 00 03 00 00 },14{00 00 0e 00 00 };""; PAPER 7{00 00 07 00 00 };""; PAPER 5{00 00 05 00 00 };"";
	LD A,1
	LD (23623),a
	XOR A,A
	LD (ZX_TV_FLAG),A
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,3
	LD HL,14
	CALL runtimePrintAt
	LD HL,STRING_19	;\8d
	CALL runtimePrintString
	LD HL,7
	CALL runtimeLocalPaper
	LD HL,STRING_20	;\83\83
	CALL runtimePrintString
	LD HL,5
	CALL runtimeLocalPaper
	LD HL,STRING_21	;\8e
	CALL runtimePrintString
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_820:
; 820  PRINT  AT b,14; INK 0; PAPER 7;"";: NEXT b
	LD HL,820
	LD (23621),HL
; 		820.1  PRINT  AT b,14{00 00 0e 00 00 }; INK 0{00 00 00 00 00 }; PAPER 7{00 00 07 00 00 };"";
	LD A,1
	LD (23623),a
	XOR A,A
	LD (ZX_TV_FLAG),A
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,(ZXBASIC_VAR_b)
	LD HL,14
	CALL runtimePrintAt
	LD HL,0
	CALL runtimeLocalInk
	LD HL,7
	CALL runtimeLocalPaper
	LD HL,STRING_22	;\8a\88\84\85
	CALL runtimePrintString
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
; 		820.2  NEXT b
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,(ZXBASIC_VAR_b)
	INC HL
	LD (ZXBASIC_VAR_b),HL
	LD DE,(ZXBASIC_VAR_for_b)
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_7
ZXBASIC_LINE_825:
; 825  PRINT  AT 20,0; PAPER 4;""
	LD HL,825
	LD (23621),HL
; 		825.1  PRINT  AT 20{00 00 14 00 00 },0{00 00 00 00 00 }; PAPER 4{00 00 04 00 00 };""
	LD A,1
	LD (23623),a
	XOR A,A
	LD (ZX_TV_FLAG),A
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,20
	LD HL,0
	CALL runtimePrintAt
	LD HL,4
	CALL runtimeLocalPaper
	LD HL,STRING_23	;\83\83\83\83\83\83\83\83\83\83\83\83\83\83\83\83\83\83\83\83\83\83\83\83\83\83\83\83\83\83\83\83
	CALL runtimePrintString
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_826:
; 826  PRINT  AT 21,0; PAPER 4;,,
	LD HL,826
	LD (23621),HL
; 		826.1  PRINT  AT 21{00 00 15 00 00 },0{00 00 00 00 00 }; PAPER 4{00 00 04 00 00 };,,
	LD A,1
	LD (23623),a
	XOR A,A
	LD (ZX_TV_FLAG),A
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,21
	LD HL,0
	CALL runtimePrintAt
	LD HL,4
	CALL runtimeLocalPaper
	CALL runtimePrintTab
	CALL runtimePrintTab
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_830:
; 830  LET y=19: LET oy=y: LET x=13: LET ox=x
	LD HL,830
	LD (23621),HL
; 		830.1  LET y=19{00 00 13 00 00 }
	LD A,1
	LD (23623),a
	LD HL,19
	LD (ZXBASIC_VAR_y),HL
; 		830.2  LET oy=y
	LD A,2
	LD (23623),a
	LD HL,(ZXBASIC_VAR_y)
	LD (ZXBASIC_VAR_oy),HL
; 		830.3  LET x=13{00 00 0d 00 00 }
	LD A,3
	LD (23623),a
	LD HL,13
	LD (ZXBASIC_VAR_x),HL
; 		830.4  LET ox=x
	LD A,4
	LD (23623),a
	LD HL,(ZXBASIC_VAR_x)
	LD (ZXBASIC_VAR_ox),HL
ZXBASIC_LINE_840:
; 840  LET r=5: LET or=r: LET c=1: LET oc=c: LET h=1: LET v=1
	LD HL,840
	LD (23621),HL
; 		840.1  LET r=5{00 00 05 00 00 }
	LD A,1
	LD (23623),a
	LD HL,5
	LD (ZXBASIC_VAR_r),HL
; 		840.2  LET or=r
	LD A,2
	LD (23623),a
	LD HL,(ZXBASIC_VAR_r)
	LD (ZXBASIC_VAR_or),HL
; 		840.3  LET c=1{00 00 01 00 00 }
	LD A,3
	LD (23623),a
	LD HL,1
	LD (ZXBASIC_VAR_c),HL
; 		840.4  LET oc=c
	LD A,4
	LD (23623),a
	LD HL,(ZXBASIC_VAR_c)
	LD (ZXBASIC_VAR_oc),HL
; 		840.5  LET h=1{00 00 01 00 00 }
	LD A,5
	LD (23623),a
	LD HL,1
	LD (ZXBASIC_VAR_h),HL
; 		840.6  LET v=1{00 00 01 00 00 }
	LD A,6
	LD (23623),a
	LD HL,1
	LD (ZXBASIC_VAR_v),HL
ZXBASIC_LINE_845:
; 845  LET i=0: LET fl=0: LET fr=0
	LD HL,845
	LD (23621),HL
; 		845.1  LET i=0{00 00 00 00 00 }
	LD A,1
	LD (23623),a
	LD HL,0
	LD (ZXBASIC_VAR_i),HL
; 		845.2  LET fl=0{00 00 00 00 00 }
	LD A,2
	LD (23623),a
	LD HL,0
	LD (ZXBASIC_VAR_fl),HL
; 		845.3  LET fr=0{00 00 00 00 00 }
	LD A,3
	LD (23623),a
	LD HL,0
	LD (ZXBASIC_VAR_fr),HL
ZXBASIC_LINE_850:
; 850  PRINT  AT 21,0; PAPER 4;"UFO:";sc; AT 21,24;"TOWERS:";l
	LD HL,850
	LD (23621),HL
; 		850.1  PRINT  AT 21{00 00 15 00 00 },0{00 00 00 00 00 }; PAPER 4{00 00 04 00 00 };"UFO
	LD A,1
	LD (23623),a
	XOR A,A
	LD (ZX_TV_FLAG),A
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,21
	LD HL,0
	CALL runtimePrintAt
	LD HL,4
	CALL runtimeLocalPaper
	LD HL,STRING_24	;UFO:
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_sc)
	CALL runtimePrintInt
	LD DE,21
	LD HL,24
	CALL runtimePrintAt
	LD HL,STRING_25	;TOWERS:
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_l)
	CALL runtimePrintInt
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_860:
; 860  RETURN 
	LD HL,860
	LD (23621),HL
; 		860.1  RETURN 
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	RET
ZXBASIC_LINE_950:
; 950  FOR a=0 TO 23
	LD HL,950
	LD (23621),HL
; 		950.1  FOR a=0{00 00 00 00 00 } TO 23{00 00 17 00 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,0
	LD (ZXBASIC_VAR_a),HL
	LD HL,23
	LD (ZXBASIC_VAR_for_a),HL
FOR_8:
ZXBASIC_LINE_960:
; 960  READ dat
	LD HL,960
	LD (23621),HL
; 		960.1  READ dat
	LD A,1
	LD (23623),a
	LD HL,(DATAPTR)
	LD DE,(HL)
	INC HL
	INC HL
	LD (DATAPTR),HL
	LD (ZXBASIC_VAR_dat),DE
ZXBASIC_LINE_970:
; 970  POKE  USR "a"+a,dat
	LD HL,970
	LD (23621),HL
; 		970.1  POKE  USR "a"+a,dat
	LD A,1
	LD (23623),a
; USR
	LD HL,STRING_3	;a
	CALL runtimeUsrUDG
	LD DE,HL
	LD HL,(ZXBASIC_VAR_a)
; +
	ADD HL,DE
	LD DE,(ZXBASIC_VAR_dat)
	LD (HL),E
ZXBASIC_LINE_980:
; 980  NEXT a: RETURN 
	LD HL,980
	LD (23621),HL
; 		980.1  NEXT a
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	LD HL,(ZXBASIC_VAR_a)
	INC HL
	LD (ZXBASIC_VAR_a),HL
	LD DE,(ZXBASIC_VAR_for_a)
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_8
; 		980.2  RETURN 
	LD A,2
	LD (23623),a
	CALL runtimeCheckBreak
	RET
ZXBASIC_LINE_1000:
; 1000  DATA 6,6,243,63,15,139,219,126
	LD HL,1000
	LD (23621),HL
; 		1000.1  DATA 6{00 00 06 00 00 },6{00 00 06 00 00 },243{00 00 f3 00 00 },63{00 00 3f 00 00 },15{00 00 0f 00 00 },139{00 00 8b 00 00 },219{00 00 db 00 00 },126{00 00 7e 00 00 }
	LD A,1
	LD (23623),a
ZXBASIC_LINE_1010:
; 1010  DATA 96,96,207,252,240,209,219,126
	LD HL,1010
	LD (23621),HL
; 		1010.1  DATA 96{00 00 60 00 00 },96{00 00 60 00 00 },207{00 00 cf 00 00 },252{00 00 fc 00 00 },240{00 00 f0 00 00 },209{00 00 d1 00 00 },219{00 00 db 00 00 },126{00 00 7e 00 00 }
	LD A,1
	LD (23623),a
ZXBASIC_LINE_1020:
; 1020  DATA 24,60,102,66,255,219,126,129
	LD HL,1020
	LD (23621),HL
; 		1020.1  DATA 24{00 00 18 00 00 },60{00 00 3c 00 00 },102{00 00 66 00 00 },66{00 00 42 00 00 },255{00 00 ff 00 00 },219{00 00 db 00 00 },126{00 00 7e 00 00 },129{00 00 81 00 00 }
	LD A,1
	LD (23623),a
ZXBASIC_LINE_9998:
; 9998  STOP 
	LD HL,9998
	LD (23621),HL
ZXBASIC_VAR_a:	dw 0
ZXBASIC_VAR_b:	dw 0
ZXBASIC_VAR_c:	dw 0
ZXBASIC_VAR_cn:	dw 0
ZXBASIC_VAR_d:	dw 0
ZXBASIC_VAR_dat:	dw 0
ZXBASIC_VAR_fl:	dw 0
ZXBASIC_VAR_for_a:	dw 0
ZXBASIC_VAR_for_b:	dw 0
ZXBASIC_VAR_for_d:	dw 0
ZXBASIC_VAR_for_g:	dw 0
ZXBASIC_VAR_for_k:	dw 0
ZXBASIC_VAR_for_s:	dw 0
ZXBASIC_VAR_for_u:	dw 0
ZXBASIC_VAR_for_w:	dw 0
ZXBASIC_VAR_fr:	dw 0
ZXBASIC_VAR_g:	dw 0
ZXBASIC_VAR_h:	dw 0
ZXBASIC_VAR_i:	dw 0
ZXBASIC_VAR_j:	dw 0
ZXBASIC_VAR_k:	dw 0
ZXBASIC_VAR_k_string:	dw 0
ZXBASIC_VAR_l:	dw 0
ZXBASIC_VAR_oc:	dw 0
ZXBASIC_VAR_or:	dw 0
ZXBASIC_VAR_ox:	dw 0
ZXBASIC_VAR_oy:	dw 0
ZXBASIC_VAR_r:	dw 0
ZXBASIC_VAR_s:	dw 0
ZXBASIC_VAR_sc:	dw 0
ZXBASIC_VAR_u:	dw 0
ZXBASIC_VAR_v:	dw 0
ZXBASIC_VAR_w:	dw 0
ZXBASIC_VAR_x:	dw 0
ZXBASIC_VAR_y:	dw 0
FLOAT_1:	db $79, $03, $12, $6e, $97	;0.004
FLOAT_10:	db $7a, $03, $12, $6e, $97	;0.008
FLOAT_2:	db $78, $03, $12, $6e, $97	;0.002
FLOAT_3:	db $7a, $44, $9b, $a5, $e3	;.012
FLOAT_4:	db $77, $44, $9b, $a5, $e3	;0.0015
FLOAT_5:	db $84, $58, $00, $00, $00	;13.5
FLOAT_6:	db $85, $0c, $00, $00, $00	;17.5
FLOAT_7:	db $7a, $75, $c2, $8f, $5c	;0.015
FLOAT_8:	db $00, $00, $0c, $00, $00	;12.0
FLOAT_9:	db $77, $03, $12, $6e, $97	;0.001
STRING_0:	dw 9
	db	"WELL DONE"
STRING_1:	dw 1
	db	$92
STRING_10:	dw 1
	db	"*"
STRING_11:	dw 1
	db	$89
STRING_12:	dw 4
	db	"****"
STRING_13:	dw 4
	db	$92, $92, $92, $92
STRING_14:	dw 16
	db	"G A M E  O V E R"
STRING_15:	dw 252
	db	$8f, "      ", $8f, "  ", $8f, $8f, $8f, $8f, $8f, $8f, $8f, $8f, "   ", $8f, $8f, $8f, $8f, $8f, $8f, "     ", $8f, "      ", $8f, "  ", $8f, "         ", $8f, "      ", $8f, "    ", $8f, "      ", $8f, "  ", $8f, "         ", $8f, "      ", $8f, "    ", $8f, "      ", $8f
	db "  ", $8f, $8f, $8f, $8f, $8f, $8f, $8f, "   ", $8f, "      ", $8f, "    ", $8f, "      ", $8f, "  ", $8f, "         ", $8f, "      ", $8f, "    ", $8f, "      ", $8f, "  ", $8f, "         ", $8f, "      ", $8f, "    ", $8f, "      ", $8f, "  ", $8f, "         ", $8f
	db "      ", $8f, "     ", $8f, $8f, $8f, $8f, $8f, $8f, "   ", $8f, "          ", $8f, $8f, $8f, $8f, $8f, $8f, " "
STRING_16:	dw 14
	db	"By Animated AL"
STRING_17:	dw 18
	db	"PRESS FIRE TO PLAY"
STRING_18:	dw 0
STRING_19:	dw 1
	db	$8d
STRING_2:	dw 13
	db	"TOWERS SAVED "
STRING_20:	dw 2
	db	$83, $83
STRING_21:	dw 1
	db	$8e
STRING_22:	dw 4
	db	$8a, $88, $84, $85
STRING_23:	dw 32
	db	$83, $83, $83, $83, $83, $83, $83, $83, $83, $83, $83, $83, $83, $83, $83, $83, $83, $83, $83, $83, $83, $83, $83, $83, $83, $83, $83, $83, $83, $83, $83, $83
STRING_24:	dw 4
	db	"UFO:"
STRING_25:	dw 7
	db	"TOWERS:"
STRING_3:	dw 1
	db	"a"
STRING_4:	dw 1
	db	"q"
STRING_5:	dw 1
	db	" "
STRING_6:	dw 1
	db	$90
STRING_7:	dw 1
	db	$91
STRING_8:	dw 1
	db	"o"
STRING_9:	dw 1
	db	"p"
DATAPTR:	DW 0
DATA_1000:
	dw 6
	dw 6
	dw 243
	dw 63
	dw 15
	dw 139
	dw 219
	dw 126
DATA_1010:
	dw 96
	dw 96
	dw 207
	dw 252
	dw 240
	dw 209
	dw 219
	dw 126
DATA_1020:
	dw 24
	dw 60
	dw 102
	dw 66
	dw 255
	dw 219
	dw 126
	dw 129


    DISPLAY "Compiled Basic = ", /D, $-CBASIC_START,  " bytes"
