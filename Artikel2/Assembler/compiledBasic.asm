
CBASIC_START
compiledBasic:
	call ZXHeapClear
	LD (runtimeSaveSP),SP
	LD HL,DATA_1010
	LD (DATAPTR),HL
; 4020.1  DIM o(3)
	LD HL,ZXBASIC_VAR_o_array
	LD BC,8
	CALL runtimeClearArray
; 4020.1  DIM m$(17,19)
	LD HL,ZXBASIC_VAR_m_string
	LD BC,360
	CALL runtimeClearStringArray
; 4020.1  DIM h$(1000)
	LD HL,ZXBASIC_VAR_h_string
	LD BC,1001
	CALL runtimeClearStringArray
; 4070.1  DIM s(2)
	LD HL,ZXBASIC_VAR_s_array
	LD BC,6
	CALL runtimeClearArray
ZXBASIC_LINE_10:
; 10  REM Sokoban
ZXBASIC_LINE_20:
; 20  REM Simon Ferre'
ZXBASIC_LINE_30:
; 30  REM 
ZXBASIC_LINE_40:
; 40  REM A-\144 B-\145 C-\146 D-\147 E-\148 F-\149 G-\150
ZXBASIC_LINE_50:
; 50  REM 
ZXBASIC_LINE_60:
; 60  BORDER 7: PAPER 7: INK 0: CLS 
; 		60.1  BORDER 7{00 00 07 00 00 }
	LD HL,7
	LD A,L
	call $2297
; 		60.2  PAPER 7{00 00 07 00 00 }
	LD HL,7
	CALL runtimePaper
; 		60.3  INK 0{00 00 00 00 00 }
	LD HL,0
	CALL runtimeInk
; 		60.4  CLS 
	CALL runtimeCls
ZXBASIC_LINE_70:
; 70  GOSUB 1000
; 		70.1  GOSUB 1000{00 00 e8 03 00 }
	CALL ZXBASIC_LINE_1000
ZXBASIC_LINE_80:
; 80  LET u$="k": LET d$="m": LET l$="z": LET r$="x": LET s$="q": LET q$="u": REM set keys
; 		80.1  LET u$="k"
	LD DE,STRING_0	;k
	LD HL,ZXBASIC_VAR_u_string
	CALL runtimeStoreString
; 		80.2  LET d$="m"
	LD DE,STRING_1	;m
	LD HL,ZXBASIC_VAR_d_string
	CALL runtimeStoreString
; 		80.3  LET l$="z"
	LD DE,STRING_2	;z
	LD HL,ZXBASIC_VAR_l_string
	CALL runtimeStoreString
; 		80.4  LET r$="x"
	LD DE,STRING_3	;x
	LD HL,ZXBASIC_VAR_r_string
	CALL runtimeStoreString
; 		80.5  LET s$="q"
	LD DE,STRING_4	;q
	LD HL,ZXBASIC_VAR_s_string
	CALL runtimeStoreString
; 		80.6  LET q$="u"
	LD DE,STRING_5	;u
	LD HL,ZXBASIC_VAR_q_string
	CALL runtimeStoreString
ZXBASIC_LINE_90:
; 90  LET l=0: GOSUB 2000: REM level
; 		90.1  LET l=0{00 00 00 00 00 }
	LD HL,0
	LD (ZXBASIC_VAR_l),HL
; 		90.2  GOSUB 2000{00 00 d0 07 00 }
	CALL ZXBASIC_LINE_2000
ZXBASIC_LINE_100:
; 100  PRINT  AT 19,0;"Sokoban in BASIC by Simon Ferre'"; AT 20,0;"ENTER-play, SPACE-redefine keys"
; 		100.1  PRINT  AT 19{00 00 13 00 00 },0{00 00 00 00 00 };"Sokoban in BASIC by Simon Ferre'"; AT 20{00 00 14 00 00 },0{00 00 00 00 00 };"ENTER-play, SPACE-redefine keys"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,19
	LD HL,0
	CALL runtimePrintAt
	LD HL,STRING_6	;Sokoban in BASIC by Simon Ferre'
	CALL runtimePrintString
	LD DE,20
	LD HL,0
	CALL runtimePrintAt
	LD HL,STRING_7	;ENTER-play, SPACE-redefine keys
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_110:
; 110  PRINT  AT 21,0;"(lrud)=";l$;r$;u$;d$;", restart=";s$;", undo=";q$;"."
; 		110.1  PRINT  AT 21{00 00 15 00 00 },0{00 00 00 00 00 };"(lrud)=";l$;r$;u$;d$;", restart=";s$;", undo=";q$;"."
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,21
	LD HL,0
	CALL runtimePrintAt
	LD HL,STRING_8	;(lrud)=
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_l_string)
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_r_string)
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_u_string)
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_d_string)
	CALL runtimePrintString
	LD HL,STRING_9	;, restart=
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_s_string)
	CALL runtimePrintString
	LD HL,STRING_10	;, undo=
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_q_string)
	CALL runtimePrintString
	LD HL,STRING_11	;.
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
	CALL ZXFreeTempCompact
ZXBASIC_LINE_120:
; 120  GOSUB 630
; 		120.1  GOSUB 630{00 00 76 02 00 }
	CALL ZXBASIC_LINE_630
ZXBASIC_LINE_130:
; 130  GOSUB 500: REM game loop
; 		130.1  GOSUB 500{00 00 f4 01 00 }
	CALL ZXBASIC_LINE_500
ZXBASIC_LINE_140:
; 140  IF k$ <>  CHR$ 13 AND k$ <> " " THEN  GOTO 130
; 		140.1  IF k$ <>  CHR$ 13{00 00 0d 00 00 } AND k$ <> " " THEN  GOTO 130{00 00 82 00 00 }
	LD HL,(ZXBASIC_VAR_k_string)
	PUSH HL
; CHR$
	LD HL,13
	CALL runtimeChr
; <>
	POP DE
	CALL runtimeUnequalString
	PUSH HL
	LD DE,(ZXBASIC_VAR_k_string)
	LD HL,STRING_12	; 
; <>
	CALL runtimeUnequalString
; AND
	POP DE
	call runtimeAndHLDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_1
; 		140.2  GOTO 130{00 00 82 00 00 }
	JP ZXBASIC_LINE_130
ZXB_LABEL_1:
ZXBASIC_LINE_150:
; 150  IF k$= CHR$ 13 THEN  GOTO 300
; 		150.1  IF k$= CHR$ 13{00 00 0d 00 00 } THEN  GOTO 300{00 00 2c 01 00 }
	LD HL,(ZXBASIC_VAR_k_string)
	PUSH HL
; CHR$
	LD HL,13
	CALL runtimeChr
; =
	POP DE
	CALL runtimeEqualString
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_2
; 		150.2  GOTO 300{00 00 2c 01 00 }
	JP ZXBASIC_LINE_300
ZXB_LABEL_2:
ZXBASIC_LINE_160:
; 160  LET k$= INKEY$ : IF k$ <> "" THEN  GOTO 160
; 		160.1  LET k$= INKEY$ 
; INKEY$
	CALL runtimeInkey
	LD DE,HL
	LD HL,ZXBASIC_VAR_k_string
	CALL runtimeStoreString
; 		160.2  IF k$ <> "" THEN  GOTO 160{00 00 a0 00 00 }
	LD DE,(ZXBASIC_VAR_k_string)
	LD HL,STRING_13	;
; <>
	CALL runtimeUnequalString
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_3
; 		160.3  GOTO 160{00 00 a0 00 00 }
	JP ZXBASIC_LINE_160
ZXB_LABEL_3:
ZXBASIC_LINE_170:
; 170  PRINT #0; AT 1,0;"key for left?"
; 		170.1  PRINT #0{00 00 00 00 00 }; AT 1{00 00 01 00 00 },0{00 00 00 00 00 };"key for left?"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,0
	CALL runtimeSetStream
	LD DE,1
	LD HL,0
	CALL runtimePrintAt
	LD HL,STRING_14	;key for left?
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
	LD HL,0
	CALL runtimeSetStream
ZXBASIC_LINE_180:
; 180  LET l$= INKEY$ : IF l$="" OR  CODE l$<97 THEN  GOTO 180
; 		180.1  LET l$= INKEY$ 
; INKEY$
	CALL runtimeInkey
	LD DE,HL
	LD HL,ZXBASIC_VAR_l_string
	CALL runtimeStoreString
; 		180.2  IF l$="" OR  CODE l$<97{00 00 61 00 00 } THEN  GOTO 180{00 00 b4 00 00 }
	LD DE,(ZXBASIC_VAR_l_string)
	LD HL,STRING_13	;
; =
	CALL runtimeEqualString
	PUSH HL
; CODE
	LD HL,(ZXBASIC_VAR_l_string)
	CALL runtimeCode
	LD DE,HL
	LD HL,97
; <
	CALL runtimeCmpHLltDE
; OR
	POP DE
	call runtimeOrHLDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_4
; 		180.3  GOTO 180{00 00 b4 00 00 }
	JP ZXBASIC_LINE_180
ZXB_LABEL_4:
ZXBASIC_LINE_190:
; 190  PRINT #0; AT 1,0;"key for right?"
; 		190.1  PRINT #0{00 00 00 00 00 }; AT 1{00 00 01 00 00 },0{00 00 00 00 00 };"key for right?"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,0
	CALL runtimeSetStream
	LD DE,1
	LD HL,0
	CALL runtimePrintAt
	LD HL,STRING_15	;key for right?
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
	LD HL,0
	CALL runtimeSetStream
ZXBASIC_LINE_200:
; 200  LET r$= INKEY$ : IF r$="" OR r$=l$ OR  CODE r$<97 THEN  GOTO 200
; 		200.1  LET r$= INKEY$ 
; INKEY$
	CALL runtimeInkey
	LD DE,HL
	LD HL,ZXBASIC_VAR_r_string
	CALL runtimeStoreString
; 		200.2  IF r$="" OR r$=l$ OR  CODE r$<97{00 00 61 00 00 } THEN  GOTO 200{00 00 c8 00 00 }
	LD DE,(ZXBASIC_VAR_r_string)
	LD HL,STRING_13	;
; =
	CALL runtimeEqualString
	PUSH HL
	LD DE,(ZXBASIC_VAR_r_string)
	LD HL,(ZXBASIC_VAR_l_string)
; =
	CALL runtimeEqualString
; OR
	POP DE
	call runtimeOrHLDE
	PUSH HL
; CODE
	LD HL,(ZXBASIC_VAR_r_string)
	CALL runtimeCode
	LD DE,HL
	LD HL,97
; <
	CALL runtimeCmpHLltDE
; OR
	POP DE
	call runtimeOrHLDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_5
; 		200.3  GOTO 200{00 00 c8 00 00 }
	JP ZXBASIC_LINE_200
ZXB_LABEL_5:
ZXBASIC_LINE_210:
; 210  PRINT #0; AT 1,0;"key for up?   "
; 		210.1  PRINT #0{00 00 00 00 00 }; AT 1{00 00 01 00 00 },0{00 00 00 00 00 };"key for up?   "
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,0
	CALL runtimeSetStream
	LD DE,1
	LD HL,0
	CALL runtimePrintAt
	LD HL,STRING_16	;key for up?   
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
	LD HL,0
	CALL runtimeSetStream
ZXBASIC_LINE_220:
; 220  LET u$= INKEY$ : IF u$="" OR u$=l$ OR u$=r$ OR  CODE u$<97 THEN  GOTO 220
; 		220.1  LET u$= INKEY$ 
; INKEY$
	CALL runtimeInkey
	LD DE,HL
	LD HL,ZXBASIC_VAR_u_string
	CALL runtimeStoreString
; 		220.2  IF u$="" OR u$=l$ OR u$=r$ OR  CODE u$<97{00 00 61 00 00 } THEN  GOTO 220{00 00 dc 00 00 }
	LD DE,(ZXBASIC_VAR_u_string)
	LD HL,STRING_13	;
; =
	CALL runtimeEqualString
	PUSH HL
	LD DE,(ZXBASIC_VAR_u_string)
	LD HL,(ZXBASIC_VAR_l_string)
; =
	CALL runtimeEqualString
; OR
	POP DE
	call runtimeOrHLDE
	PUSH HL
	LD DE,(ZXBASIC_VAR_u_string)
	LD HL,(ZXBASIC_VAR_r_string)
; =
	CALL runtimeEqualString
; OR
	POP DE
	call runtimeOrHLDE
	PUSH HL
; CODE
	LD HL,(ZXBASIC_VAR_u_string)
	CALL runtimeCode
	LD DE,HL
	LD HL,97
; <
	CALL runtimeCmpHLltDE
; OR
	POP DE
	call runtimeOrHLDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_6
; 		220.3  GOTO 220{00 00 dc 00 00 }
	JP ZXBASIC_LINE_220
ZXB_LABEL_6:
ZXBASIC_LINE_230:
; 230  PRINT #0; AT 1,0;"key for down?"
; 		230.1  PRINT #0{00 00 00 00 00 }; AT 1{00 00 01 00 00 },0{00 00 00 00 00 };"key for down?"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,0
	CALL runtimeSetStream
	LD DE,1
	LD HL,0
	CALL runtimePrintAt
	LD HL,STRING_17	;key for down?
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
	LD HL,0
	CALL runtimeSetStream
ZXBASIC_LINE_240:
; 240  LET d$= INKEY$ : IF d$="" OR d$=l$ OR d$=r$ OR d$=u$ OR  CODE d$<97 THEN  GOTO 240
; 		240.1  LET d$= INKEY$ 
; INKEY$
	CALL runtimeInkey
	LD DE,HL
	LD HL,ZXBASIC_VAR_d_string
	CALL runtimeStoreString
; 		240.2  IF d$="" OR d$=l$ OR d$=r$ OR d$=u$ OR  CODE d$<97{00 00 61 00 00 } THEN  GOTO 240{00 00 f0 00 00 }
	LD DE,(ZXBASIC_VAR_d_string)
	LD HL,STRING_13	;
; =
	CALL runtimeEqualString
	PUSH HL
	LD DE,(ZXBASIC_VAR_d_string)
	LD HL,(ZXBASIC_VAR_l_string)
; =
	CALL runtimeEqualString
; OR
	POP DE
	call runtimeOrHLDE
	PUSH HL
	LD DE,(ZXBASIC_VAR_d_string)
	LD HL,(ZXBASIC_VAR_r_string)
; =
	CALL runtimeEqualString
; OR
	POP DE
	call runtimeOrHLDE
	PUSH HL
	LD DE,(ZXBASIC_VAR_d_string)
	LD HL,(ZXBASIC_VAR_u_string)
; =
	CALL runtimeEqualString
; OR
	POP DE
	call runtimeOrHLDE
	PUSH HL
; CODE
	LD HL,(ZXBASIC_VAR_d_string)
	CALL runtimeCode
	LD DE,HL
	LD HL,97
; <
	CALL runtimeCmpHLltDE
; OR
	POP DE
	call runtimeOrHLDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_7
; 		240.3  GOTO 240{00 00 f0 00 00 }
	JP ZXBASIC_LINE_240
ZXB_LABEL_7:
ZXBASIC_LINE_250:
; 250  PRINT #0; AT 1,0;"key to restart level?"
; 		250.1  PRINT #0{00 00 00 00 00 }; AT 1{00 00 01 00 00 },0{00 00 00 00 00 };"key to restart level?"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,0
	CALL runtimeSetStream
	LD DE,1
	LD HL,0
	CALL runtimePrintAt
	LD HL,STRING_18	;key to restart level?
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
	LD HL,0
	CALL runtimeSetStream
ZXBASIC_LINE_260:
; 260  LET s$= INKEY$ : IF s$="" OR s$=l$ OR s$=r$ OR s$=u$ OR s$=d$ THEN  GOTO 260
; 		260.1  LET s$= INKEY$ 
; INKEY$
	CALL runtimeInkey
	LD DE,HL
	LD HL,ZXBASIC_VAR_s_string
	CALL runtimeStoreString
; 		260.2  IF s$="" OR s$=l$ OR s$=r$ OR s$=u$ OR s$=d$ THEN  GOTO 260{00 00 04 01 00 }
	LD DE,(ZXBASIC_VAR_s_string)
	LD HL,STRING_13	;
; =
	CALL runtimeEqualString
	PUSH HL
	LD DE,(ZXBASIC_VAR_s_string)
	LD HL,(ZXBASIC_VAR_l_string)
; =
	CALL runtimeEqualString
; OR
	POP DE
	call runtimeOrHLDE
	PUSH HL
	LD DE,(ZXBASIC_VAR_s_string)
	LD HL,(ZXBASIC_VAR_r_string)
; =
	CALL runtimeEqualString
; OR
	POP DE
	call runtimeOrHLDE
	PUSH HL
	LD DE,(ZXBASIC_VAR_s_string)
	LD HL,(ZXBASIC_VAR_u_string)
; =
	CALL runtimeEqualString
; OR
	POP DE
	call runtimeOrHLDE
	PUSH HL
	LD DE,(ZXBASIC_VAR_s_string)
	LD HL,(ZXBASIC_VAR_d_string)
; =
	CALL runtimeEqualString
; OR
	POP DE
	call runtimeOrHLDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_8
; 		260.3  GOTO 260{00 00 04 01 00 }
	JP ZXBASIC_LINE_260
ZXB_LABEL_8:
ZXBASIC_LINE_262:
; 262  PRINT #0; AT 1,0;"key to undo move?    "
; 		262.1  PRINT #0{00 00 00 00 00 }; AT 1{00 00 01 00 00 },0{00 00 00 00 00 };"key to undo move?    "
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,0
	CALL runtimeSetStream
	LD DE,1
	LD HL,0
	CALL runtimePrintAt
	LD HL,STRING_19	;key to undo move?    
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
	LD HL,0
	CALL runtimeSetStream
ZXBASIC_LINE_264:
; 264  LET q$= INKEY$ : IF q$="" OR q$=l$ OR q$=r$ OR q$=u$ OR q$=d$ OR q$=s$ THEN  GOTO 264
; 		264.1  LET q$= INKEY$ 
; INKEY$
	CALL runtimeInkey
	LD DE,HL
	LD HL,ZXBASIC_VAR_q_string
	CALL runtimeStoreString
; 		264.2  IF q$="" OR q$=l$ OR q$=r$ OR q$=u$ OR q$=d$ OR q$=s$ THEN  GOTO 264{00 00 08 01 00 }
	LD DE,(ZXBASIC_VAR_q_string)
	LD HL,STRING_13	;
; =
	CALL runtimeEqualString
	PUSH HL
	LD DE,(ZXBASIC_VAR_q_string)
	LD HL,(ZXBASIC_VAR_l_string)
; =
	CALL runtimeEqualString
; OR
	POP DE
	call runtimeOrHLDE
	PUSH HL
	LD DE,(ZXBASIC_VAR_q_string)
	LD HL,(ZXBASIC_VAR_r_string)
; =
	CALL runtimeEqualString
; OR
	POP DE
	call runtimeOrHLDE
	PUSH HL
	LD DE,(ZXBASIC_VAR_q_string)
	LD HL,(ZXBASIC_VAR_u_string)
; =
	CALL runtimeEqualString
; OR
	POP DE
	call runtimeOrHLDE
	PUSH HL
	LD DE,(ZXBASIC_VAR_q_string)
	LD HL,(ZXBASIC_VAR_d_string)
; =
	CALL runtimeEqualString
; OR
	POP DE
	call runtimeOrHLDE
	PUSH HL
	LD DE,(ZXBASIC_VAR_q_string)
	LD HL,(ZXBASIC_VAR_s_string)
; =
	CALL runtimeEqualString
; OR
	POP DE
	call runtimeOrHLDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_9
; 		264.3  GOTO 264{00 00 08 01 00 }
	JP ZXBASIC_LINE_264
ZXB_LABEL_9:
ZXBASIC_LINE_270:
; 270  PRINT #0; AT 1,0,,;
; 		270.1  PRINT #0{00 00 00 00 00 }; AT 1{00 00 01 00 00 },0{00 00 00 00 00 },,;
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,0
	CALL runtimeSetStream
	LD DE,1
	LD HL,0
	CALL runtimePrintAt
	CALL runtimePrintTab
	CALL runtimePrintTab
	POP AF
	LD (ZX_P_FLAG),A
	LD HL,0
	CALL runtimeSetStream
ZXBASIC_LINE_280:
; 280  GOTO 110
; 		280.1  GOTO 110{00 00 6e 00 00 }
	JP ZXBASIC_LINE_110
ZXBASIC_LINE_290:
; 290  REM 
ZXBASIC_LINE_300:
; 300  REM main game
ZXBASIC_LINE_310:
; 310  FOR l=1 TO 50
; 		310.1  FOR l=1{00 00 01 00 00 } TO 50{00 00 32 00 00 }
	LD HL,1
	LD (ZXBASIC_VAR_l),HL
	LD HL,50
	LD (ZXBASIC_VAR_for_l),HL
FOR_0:
ZXBASIC_LINE_320:
; 320  GOSUB 2000: IF l=0 THEN  FOR b=0 TO 7: BORDER b: NEXT b: PRINT  AT 20,1;"G A M E   O V E R ! ! ! ! ! !": PAUSE 0: GOTO 170: REM end of levels
; 		320.1  GOSUB 2000{00 00 d0 07 00 }
	CALL ZXBASIC_LINE_2000
; 		320.2  IF l=0{00 00 00 00 00 } THEN  FOR b=0{00 00 00 00 00 } TO 7{00 00 07 00 00 }
	LD DE,(ZXBASIC_VAR_l)
	LD HL,0
; =
	CALL runtimeCmpHLEqDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_10
; 		320.3  FOR b=0{00 00 00 00 00 } TO 7{00 00 07 00 00 }
	LD HL,0
	LD (ZXBASIC_VAR_b),HL
	LD HL,7
	LD (ZXBASIC_VAR_for_b),HL
FOR_1:
; 		320.4  BORDER b
	LD HL,(ZXBASIC_VAR_b)
	LD A,L
	call $2297
; 		320.5  NEXT b
	LD HL,(ZXBASIC_VAR_b)
	INC HL
	LD (ZXBASIC_VAR_b),HL
	LD DE,(ZXBASIC_VAR_for_b)
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_1
; 		320.6  PRINT  AT 20{00 00 14 00 00 },1{00 00 01 00 00 };"G A M E   O V E R ! ! ! ! ! !"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,20
	LD HL,1
	CALL runtimePrintAt
	LD HL,STRING_20	;G A M E   O V E R ! ! ! ! ! !
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
; 		320.7  PAUSE 0{00 00 00 00 00 }
	LD HL,0
	CALL runtimePause
; 		320.8  GOTO 170{00 00 aa 00 00 }
	JP ZXBASIC_LINE_170
ZXB_LABEL_10:
ZXBASIC_LINE_330:
; 330  PRINT  AT 0,2;"SOKOBAN Level: ";l: PRINT  AT 19,1;"Keys (UDLR)=";u$;d$;l$;r$;", UNDO=";q$;","'"Restart=";s$
; 		330.1  PRINT  AT 0{00 00 00 00 00 },2{00 00 02 00 00 };"SOKOBAN Level
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,0
	LD HL,2
	CALL runtimePrintAt
	LD HL,STRING_21	;SOKOBAN Level: 
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_l)
	CALL runtimePrintInt
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
; 		330.2  PRINT  AT 19{00 00 13 00 00 },1{00 00 01 00 00 };"Keys (UDLR)=";u$;d$;l$;r$;", UNDO=";q$;","'"Restart=";s$
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,19
	LD HL,1
	CALL runtimePrintAt
	LD HL,STRING_22	;Keys (UDLR)=
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_u_string)
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_d_string)
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_l_string)
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_r_string)
	CALL runtimePrintString
	LD HL,STRING_23	;, UNDO=
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_q_string)
	CALL runtimePrintString
	LD HL,STRING_24	;,
	CALL runtimePrintString
	LD HL,STRING_24	;,
	CALL runtimePrintString
	LD HL,STRING_25	;Restart=
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_s_string)
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
	CALL ZXFreeTempCompact
ZXBASIC_LINE_335:
; 335  GOSUB 630
; 		335.1  GOSUB 630{00 00 76 02 00 }
	CALL ZXBASIC_LINE_630
ZXBASIC_LINE_340:
; 340  REM game loop
ZXBASIC_LINE_350:
; 350  GOSUB 500
; 		350.1  GOSUB 500{00 00 f4 01 00 }
	CALL ZXBASIC_LINE_500
ZXBASIC_LINE_355:
; 355  IF k$="<" AND l>1 THEN  LET l=l-1: GOTO 320
; 		355.1  IF k$="<" AND l>1{00 00 01 00 00 } THEN  LET l=l-1{00 00 01 00 00 }
	LD DE,(ZXBASIC_VAR_k_string)
	LD HL,STRING_26	;<
; =
	CALL runtimeEqualString
	PUSH HL
	LD DE,(ZXBASIC_VAR_l)
	LD HL,1
; >
	CALL runtimeCmpHlGtDE
; AND
	POP DE
	call runtimeAndHLDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_11
; 		355.2  LET l=l-1{00 00 01 00 00 }
	LD HL,(ZXBASIC_VAR_l)
	DEC HL
; -
	LD (ZXBASIC_VAR_l),HL
; 		355.3  GOTO 320{00 00 40 01 00 }
	JP ZXBASIC_LINE_320
ZXB_LABEL_11:
ZXBASIC_LINE_356:
; 356  IF k$=">" AND l<50 THEN  LET l=l+1: GOTO 320
; 		356.1  IF k$=">" AND l<50{00 00 32 00 00 } THEN  LET l=l+1{00 00 01 00 00 }
	LD DE,(ZXBASIC_VAR_k_string)
	LD HL,STRING_27	;>
; =
	CALL runtimeEqualString
	PUSH HL
	LD DE,(ZXBASIC_VAR_l)
	LD HL,50
; <
	CALL runtimeCmpHLltDE
; AND
	POP DE
	call runtimeAndHLDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_12
; 		356.2  LET l=l+1{00 00 01 00 00 }
	LD HL,(ZXBASIC_VAR_l)
	INC HL
; +
	LD (ZXBASIC_VAR_l),HL
; 		356.3  GOTO 320{00 00 40 01 00 }
	JP ZXBASIC_LINE_320
ZXB_LABEL_12:
ZXBASIC_LINE_358:
; 358  IF k$=q$ THEN  GOSUB 430
; 		358.1  IF k$=q$ THEN  GOSUB 430{00 00 ae 01 00 }
	LD DE,(ZXBASIC_VAR_k_string)
	LD HL,(ZXBASIC_VAR_q_string)
; =
	CALL runtimeEqualString
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_13
; 		358.2  GOSUB 430{00 00 ae 01 00 }
	CALL ZXBASIC_LINE_430
ZXB_LABEL_13:
ZXBASIC_LINE_360:
; 360  IF k$ <> s$ THEN  GOTO 370: REM restart level pressed
; 		360.1  IF k$ <> s$ THEN  GOTO 370{00 00 72 01 00 }
	LD DE,(ZXBASIC_VAR_k_string)
	LD HL,(ZXBASIC_VAR_s_string)
; <>
	CALL runtimeUnequalString
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_14
; 		360.2  GOTO 370{00 00 72 01 00 }
	JP ZXBASIC_LINE_370
ZXB_LABEL_14:
ZXBASIC_LINE_364:
; 364  PRINT #0; AT 1,3;"Restart level. Sure? (y/n)"
; 		364.1  PRINT #0{00 00 00 00 00 }; AT 1{00 00 01 00 00 },3{00 00 03 00 00 };"Restart level. Sure? (y/n)"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,0
	CALL runtimeSetStream
	LD DE,1
	LD HL,3
	CALL runtimePrintAt
	LD HL,STRING_28	;Restart level. Sure? (y/n)
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
	LD HL,0
	CALL runtimeSetStream
ZXBASIC_LINE_365:
; 365  LET i$= INKEY$ : IF i$="y" THEN  GOTO 320
; 		365.1  LET i$= INKEY$ 
; INKEY$
	CALL runtimeInkey
	LD DE,HL
	LD HL,ZXBASIC_VAR_i_string
	CALL runtimeStoreString
; 		365.2  IF i$="y" THEN  GOTO 320{00 00 40 01 00 }
	LD DE,(ZXBASIC_VAR_i_string)
	LD HL,STRING_29	;y
; =
	CALL runtimeEqualString
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_15
; 		365.3  GOTO 320{00 00 40 01 00 }
	JP ZXBASIC_LINE_320
ZXB_LABEL_15:
ZXBASIC_LINE_366:
; 366  IF i$ <> "n" THEN  GOTO 365
; 		366.1  IF i$ <> "n" THEN  GOTO 365{00 00 6d 01 00 }
	LD DE,(ZXBASIC_VAR_i_string)
	LD HL,STRING_30	;n
; <>
	CALL runtimeUnequalString
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_16
; 		366.2  GOTO 365{00 00 6d 01 00 }
	JP ZXBASIC_LINE_365
ZXB_LABEL_16:
ZXBASIC_LINE_367:
; 367  PRINT #0; AT 1,0,,;
; 		367.1  PRINT #0{00 00 00 00 00 }; AT 1{00 00 01 00 00 },0{00 00 00 00 00 },,;
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,0
	CALL runtimeSetStream
	LD DE,1
	LD HL,0
	CALL runtimePrintAt
	CALL runtimePrintTab
	CALL runtimePrintTab
	POP AF
	LD (ZX_P_FLAG),A
	LD HL,0
	CALL runtimeSetStream
ZXBASIC_LINE_370:
; 370   IF cont<targets THEN  GOTO 350
; 		370.1  IF cont<targets THEN  GOTO 350{00 00 5e 01 00 }
	LD DE,(ZXBASIC_VAR_cont)
	LD HL,(ZXBASIC_VAR_targets)
; <
	CALL runtimeCmpHLltDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_17
; 		370.2  GOTO 350{00 00 5e 01 00 }
	JP ZXBASIC_LINE_350
ZXB_LABEL_17:
ZXBASIC_LINE_380:
; 380  LET k$= INKEY$ : IF k$ <> "" THEN  GOTO 390
; 		380.1  LET k$= INKEY$ 
; INKEY$
	CALL runtimeInkey
	LD DE,HL
	LD HL,ZXBASIC_VAR_k_string
	CALL runtimeStoreString
; 		380.2  IF k$ <> "" THEN  GOTO 390{00 00 86 01 00 }
	LD DE,(ZXBASIC_VAR_k_string)
	LD HL,STRING_13	;
; <>
	CALL runtimeUnequalString
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_18
; 		380.3  GOTO 390{00 00 86 01 00 }
	JP ZXBASIC_LINE_390
ZXB_LABEL_18:
ZXBASIC_LINE_390:
; 390  FOR n=1 TO 10: FOR b=0 TO 7: BORDER b: NEXT b: NEXT n: PRINT #0; AT 1,0;"W E L L   D O N E ! ! ! ! ! ! !"
; 		390.1  FOR n=1{00 00 01 00 00 } TO 10{00 00 0a 00 00 }
	LD HL,1
	LD (ZXBASIC_VAR_n),HL
	LD HL,10
	LD (ZXBASIC_VAR_for_n),HL
FOR_2:
; 		390.2  FOR b=0{00 00 00 00 00 } TO 7{00 00 07 00 00 }
	LD HL,0
	LD (ZXBASIC_VAR_b),HL
	LD HL,7
	LD (ZXBASIC_VAR_for_b),HL
FOR_3:
; 		390.3  BORDER b
	LD HL,(ZXBASIC_VAR_b)
	LD A,L
	call $2297
; 		390.4  NEXT b
	LD HL,(ZXBASIC_VAR_b)
	INC HL
	LD (ZXBASIC_VAR_b),HL
	LD DE,(ZXBASIC_VAR_for_b)
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_3
; 		390.5  NEXT n
	LD HL,(ZXBASIC_VAR_n)
	INC HL
	LD (ZXBASIC_VAR_n),HL
	LD DE,(ZXBASIC_VAR_for_n)
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_2
; 		390.6  PRINT #0{00 00 00 00 00 }; AT 1{00 00 01 00 00 },0{00 00 00 00 00 };"W E L L   D O N E ! ! ! ! ! ! !"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,0
	CALL runtimeSetStream
	LD DE,1
	LD HL,0
	CALL runtimePrintAt
	LD HL,STRING_31	;W E L L   D O N E ! ! ! ! ! ! !
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
	LD HL,0
	CALL runtimeSetStream
ZXBASIC_LINE_400:
; 400  IF  INKEY$ ="" THEN  GOTO 400
; 		400.1  IF  INKEY$ ="" THEN  GOTO 400{00 00 90 01 00 }
; INKEY$
	CALL runtimeInkey
	LD DE,HL
	LD HL,STRING_13	;
; =
	CALL runtimeEqualString
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_19
; 		400.2  GOTO 400{00 00 90 01 00 }
	JP ZXBASIC_LINE_400
ZXB_LABEL_19:
ZXBASIC_LINE_410:
; 410  PAUSE 0
; 		410.1  PAUSE 0{00 00 00 00 00 }
	LD HL,0
	CALL runtimePause
ZXBASIC_LINE_420:
; 420  NEXT l
; 		420.1  NEXT l
	LD HL,(ZXBASIC_VAR_l)
	INC HL
	LD (ZXBASIC_VAR_l),HL
	LD DE,(ZXBASIC_VAR_for_l)
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_0
ZXBASIC_LINE_425:
; 425  PRINT #0; AT 1,0;"WELL DONE - ALL LEVELS COMPLETED";: PAUSE 0: GOTO 90
; 		425.1  PRINT #0{00 00 00 00 00 }; AT 1{00 00 01 00 00 },0{00 00 00 00 00 };"WELL DONE - ALL LEVELS COMPLETED";
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,0
	CALL runtimeSetStream
	LD DE,1
	LD HL,0
	CALL runtimePrintAt
	LD HL,STRING_32	;WELL DONE - ALL LEVELS COMPLETED
	CALL runtimePrintString
	POP AF
	LD (ZX_P_FLAG),A
	LD HL,0
	CALL runtimeSetStream
; 		425.2  PAUSE 0{00 00 00 00 00 }
	LD HL,0
	CALL runtimePause
; 		425.3  GOTO 90{00 00 5a 00 00 }
	JP ZXBASIC_LINE_90
ZXBASIC_LINE_430:
; 430  REM UNDO routine
ZXBASIC_LINE_431:
; 431  LET k$= INKEY$ : IF k$ <> "" THEN  GOTO 431
; 		431.1  LET k$= INKEY$ 
; INKEY$
	CALL runtimeInkey
	LD DE,HL
	LD HL,ZXBASIC_VAR_k_string
	CALL runtimeStoreString
; 		431.2  IF k$ <> "" THEN  GOTO 431{00 00 af 01 00 }
	LD DE,(ZXBASIC_VAR_k_string)
	LD HL,STRING_13	;
; <>
	CALL runtimeUnequalString
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_20
; 		431.3  GOTO 431{00 00 af 01 00 }
	JP ZXBASIC_LINE_431
ZXB_LABEL_20:
ZXBASIC_LINE_435:
; 435  IF moves=0 THEN  RETURN 
; 		435.1  IF moves=0{00 00 00 00 00 } THEN  RETURN 
	LD DE,(ZXBASIC_VAR_moves)
	LD HL,0
; =
	CALL runtimeCmpHLEqDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_21
; 		435.2  RETURN 
	RET
ZXB_LABEL_21:
ZXBASIC_LINE_440:
; 440  LET pull=0: LET k$=h$(moves): LET h$(moves)=" ": IF  CODE k$<97 THEN  LET pull=1: LET k$= CHR$ ( CODE k$+32)
; 		440.1  LET pull=0{00 00 00 00 00 }
	LD HL,0
	LD (ZXBASIC_VAR_pull),HL
; 		440.2  LET k$=h$(moves)
	LD HL,ZXBASIC_VAR_h_string
	PUSH HL
	LD HL,(ZXBASIC_VAR_moves)
	PUSH HL
	LD BC,HL
	POP DE
	POP HL
	CALL runtimePushFixedSubString
	LD DE,HL
	LD HL,ZXBASIC_VAR_k_string
	CALL runtimeStoreString
; 		440.3  LET h$(moves)=" "
	LD HL,ZXBASIC_VAR_h_string
	PUSH HL
	LD HL,(ZXBASIC_VAR_moves)
	PUSH HL
	PUSH HL
	LD HL,STRING_12	; 
	CALL runtimeStoreFixedStringWithRangeFromBstr
; 		440.4  IF  CODE k$<97{00 00 61 00 00 } THEN  LET pull=1{00 00 01 00 00 }
; CODE
	LD HL,(ZXBASIC_VAR_k_string)
	CALL runtimeCode
	LD DE,HL
	LD HL,97
; <
	CALL runtimeCmpHLltDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_22
; 		440.5  LET pull=1{00 00 01 00 00 }
	LD HL,1
	LD (ZXBASIC_VAR_pull),HL
; 		440.6  LET k$= CHR$ ( CODE k$+32{00 00 20 00 00 })
; CHR$
; CODE
	LD HL,(ZXBASIC_VAR_k_string)
	CALL runtimeCode
	LD DE,HL
	LD HL,32
; +
	ADD HL,DE
	CALL runtimeChr
	LD DE,HL
	LD HL,ZXBASIC_VAR_k_string
	CALL runtimeStoreString
ZXB_LABEL_22:
ZXBASIC_LINE_441:
; 441  LET o(1)=s(1): LET o(2)=s(2): LET vm=(1 AND k$=u$)+(-1 AND k$=d$): LET hm=(1 AND k$=l$)+(-1 AND k$=r$): REM reversed direction indicators
; 		441.1  LET o(1{00 00 01 00 00 })=s(1{00 00 01 00 00 })
	LD HL,1
	ADD HL,HL
	PUSH HL
; Array-Access
	LD HL,1
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	POP DE
	POP HL
	LD BC,ZXBASIC_VAR_o_array
	ADD HL,BC
	LD (HL),DE
; 		441.2  LET o(2{00 00 02 00 00 })=s(2{00 00 02 00 00 })
	LD HL,2
	ADD HL,HL
	PUSH HL
; Array-Access
	LD HL,2
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	POP DE
	POP HL
	LD BC,ZXBASIC_VAR_o_array
	ADD HL,BC
	LD (HL),DE
; 		441.3  LET vm=(1{00 00 01 00 00 } AND k$=u$)+(-1{00 00 01 00 00 } AND k$=d$)
; (
	LD HL,1
	PUSH HL
	LD DE,(ZXBASIC_VAR_k_string)
	LD HL,(ZXBASIC_VAR_u_string)
; =
	CALL runtimeEqualString
; AND
	POP DE
	call runtimeAndHLDE
	PUSH HL
; )
; (
	LD HL,1
	PUSH HL
	LD DE,(ZXBASIC_VAR_k_string)
	LD HL,(ZXBASIC_VAR_d_string)
; =
	CALL runtimeEqualString
; AND
	POP DE
	call runtimeAndHLDE
	LD BC,HL
; -
	LD HL,0
	SUB HL,BC
; )
; +
	POP DE
	ADD HL,DE
	LD (ZXBASIC_VAR_vm),HL
	CALL ZXFreeTempCompact
; 		441.4  LET hm=(1{00 00 01 00 00 } AND k$=l$)+(-1{00 00 01 00 00 } AND k$=r$)
; (
	LD HL,1
	PUSH HL
	LD DE,(ZXBASIC_VAR_k_string)
	LD HL,(ZXBASIC_VAR_l_string)
; =
	CALL runtimeEqualString
; AND
	POP DE
	call runtimeAndHLDE
	PUSH HL
; )
; (
	LD HL,1
	PUSH HL
	LD DE,(ZXBASIC_VAR_k_string)
	LD HL,(ZXBASIC_VAR_r_string)
; =
	CALL runtimeEqualString
; AND
	POP DE
	call runtimeAndHLDE
	LD BC,HL
; -
	LD HL,0
	SUB HL,BC
; )
; +
	POP DE
	ADD HL,DE
	LD (ZXBASIC_VAR_hm),HL
	CALL ZXFreeTempCompact
ZXBASIC_LINE_445:
; 445  IF  NOT pull THEN  GOTO 489
; 		445.1  IF  NOT pull THEN  GOTO 489{00 00 e9 01 00 }
; NOT
	LD HL,(ZXBASIC_VAR_pull)
	CALL runtimeNotHL
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_23
; 		445.2  GOTO 489{00 00 e9 01 00 }
	JP ZXBASIC_LINE_489
ZXB_LABEL_23:
ZXBASIC_LINE_446:
; 446  LET pushes=pushes-1
; 		446.1  LET pushes=pushes-1{00 00 01 00 00 }
	LD HL,(ZXBASIC_VAR_pushes)
	DEC HL
; -
	LD (ZXBASIC_VAR_pushes),HL
ZXBASIC_LINE_450:
; 450  IF m$(s(1)-vm,s(2)-hm)="\146" THEN  LET m$(s(1)-vm,s(2)-hm)="\145": LET r=s(1)-vm: LET c=s(2)-hm: LET last=0: GOSUB 3000: GOTO 460
; 		450.1  IF m$(s(1{00 00 01 00 00 })-vm,s(2{00 00 02 00 00 })-hm)="\146" THEN  LET m$(s(1{00 00 01 00 00 })-vm,s(2{00 00 02 00 00 })-hm)="\145"
; Array-Access
	LD HL,1
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,(ZXBASIC_VAR_vm)
; -
	POP DE
	EX HL,DE
	SUB HL,DE
	LD DE,19
	CALL runtimeMult16bit
	LD DE,HL
	LD HL,ZXBASIC_VAR_m_string
	ADD HL,DE
	PUSH HL
; Array-Access
	LD HL,2
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,(ZXBASIC_VAR_hm)
; -
	POP DE
	EX HL,DE
	SUB HL,DE
	PUSH HL
	LD BC,HL
	POP DE
	POP HL
	CALL runtimePushFixedSubString
	LD DE,HL
	LD HL,STRING_33	;\92
; =
	CALL runtimeEqualString
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_24
; 		450.2  LET m$(s(1{00 00 01 00 00 })-vm,s(2{00 00 02 00 00 })-hm)="\145"
; Array-Access
	LD HL,1
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,(ZXBASIC_VAR_vm)
; -
	POP DE
	EX HL,DE
	SUB HL,DE
	LD DE,19
	CALL runtimeMult16bit
	LD DE,HL
	LD HL,ZXBASIC_VAR_m_string
	ADD HL,DE
	PUSH HL
; Array-Access
	LD HL,2
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,(ZXBASIC_VAR_hm)
; -
	POP DE
	EX HL,DE
	SUB HL,DE
	PUSH HL
	PUSH HL
	LD HL,STRING_34	;\91
	CALL runtimeStoreFixedStringWithRangeFromBstr
; 		450.3  LET r=s(1{00 00 01 00 00 })-vm
; Array-Access
	LD HL,1
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,(ZXBASIC_VAR_vm)
; -
	POP DE
	EX HL,DE
	SUB HL,DE
	LD (ZXBASIC_VAR_r),HL
; 		450.4  LET c=s(2{00 00 02 00 00 })-hm
; Array-Access
	LD HL,2
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,(ZXBASIC_VAR_hm)
; -
	POP DE
	EX HL,DE
	SUB HL,DE
	LD (ZXBASIC_VAR_c),HL
; 		450.5  LET last=0{00 00 00 00 00 }
	LD HL,0
	LD (ZXBASIC_VAR_last),HL
; 		450.6  GOSUB 3000{00 00 b8 0b 00 }
	CALL ZXBASIC_LINE_3000
; 		450.7  GOTO 460{00 00 cc 01 00 }
	JP ZXBASIC_LINE_460
ZXB_LABEL_24:
ZXBASIC_LINE_451:
; 451  IF m$(s(1)-vm,s(2)-hm)="\150" THEN  LET m$(s(1)-vm,s(2)-hm)="\147": LET r=s(1)-vm: LET c=s(2)-hm: LET last=0: GOSUB 3000: LET cont=cont-1
; 		451.1  IF m$(s(1{00 00 01 00 00 })-vm,s(2{00 00 02 00 00 })-hm)="\150" THEN  LET m$(s(1{00 00 01 00 00 })-vm,s(2{00 00 02 00 00 })-hm)="\147"
; Array-Access
	LD HL,1
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,(ZXBASIC_VAR_vm)
; -
	POP DE
	EX HL,DE
	SUB HL,DE
	LD DE,19
	CALL runtimeMult16bit
	LD DE,HL
	LD HL,ZXBASIC_VAR_m_string
	ADD HL,DE
	PUSH HL
; Array-Access
	LD HL,2
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,(ZXBASIC_VAR_hm)
; -
	POP DE
	EX HL,DE
	SUB HL,DE
	PUSH HL
	LD BC,HL
	POP DE
	POP HL
	CALL runtimePushFixedSubString
	LD DE,HL
	LD HL,STRING_35	;\96
; =
	CALL runtimeEqualString
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_25
; 		451.2  LET m$(s(1{00 00 01 00 00 })-vm,s(2{00 00 02 00 00 })-hm)="\147"
; Array-Access
	LD HL,1
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,(ZXBASIC_VAR_vm)
; -
	POP DE
	EX HL,DE
	SUB HL,DE
	LD DE,19
	CALL runtimeMult16bit
	LD DE,HL
	LD HL,ZXBASIC_VAR_m_string
	ADD HL,DE
	PUSH HL
; Array-Access
	LD HL,2
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,(ZXBASIC_VAR_hm)
; -
	POP DE
	EX HL,DE
	SUB HL,DE
	PUSH HL
	PUSH HL
	LD HL,STRING_36	;\93
	CALL runtimeStoreFixedStringWithRangeFromBstr
; 		451.3  LET r=s(1{00 00 01 00 00 })-vm
; Array-Access
	LD HL,1
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,(ZXBASIC_VAR_vm)
; -
	POP DE
	EX HL,DE
	SUB HL,DE
	LD (ZXBASIC_VAR_r),HL
; 		451.4  LET c=s(2{00 00 02 00 00 })-hm
; Array-Access
	LD HL,2
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,(ZXBASIC_VAR_hm)
; -
	POP DE
	EX HL,DE
	SUB HL,DE
	LD (ZXBASIC_VAR_c),HL
; 		451.5  LET last=0{00 00 00 00 00 }
	LD HL,0
	LD (ZXBASIC_VAR_last),HL
; 		451.6  GOSUB 3000{00 00 b8 0b 00 }
	CALL ZXBASIC_LINE_3000
; 		451.7  LET cont=cont-1{00 00 01 00 00 }
	LD HL,(ZXBASIC_VAR_cont)
	DEC HL
; -
	LD (ZXBASIC_VAR_cont),HL
ZXB_LABEL_25:
ZXBASIC_LINE_460:
; 460  IF m$(s(1),s(2))="\145" THEN  LET m$(s(1),s(2))="\146": LET r=s(1): LET c=s(2): LET last=0: GOSUB 3000: GOTO 489
; 		460.1  IF m$(s(1{00 00 01 00 00 }),s(2{00 00 02 00 00 }))="\145" THEN  LET m$(s(1{00 00 01 00 00 }),s(2{00 00 02 00 00 }))="\146"
; Array-Access
	LD HL,1
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	LD HL,DE
	LD DE,19
	CALL runtimeMult16bit
	LD DE,HL
	LD HL,ZXBASIC_VAR_m_string
	ADD HL,DE
	PUSH HL
; Array-Access
	LD HL,2
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	LD HL,DE
	PUSH HL
	LD BC,HL
	POP DE
	POP HL
	CALL runtimePushFixedSubString
	LD DE,HL
	LD HL,STRING_34	;\91
; =
	CALL runtimeEqualString
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_26
; 		460.2  LET m$(s(1{00 00 01 00 00 }),s(2{00 00 02 00 00 }))="\146"
; Array-Access
	LD HL,1
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	LD HL,DE
	LD DE,19
	CALL runtimeMult16bit
	LD DE,HL
	LD HL,ZXBASIC_VAR_m_string
	ADD HL,DE
	PUSH HL
; Array-Access
	LD HL,2
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	LD HL,DE
	PUSH HL
	PUSH HL
	LD HL,STRING_33	;\92
	CALL runtimeStoreFixedStringWithRangeFromBstr
; 		460.3  LET r=s(1{00 00 01 00 00 })
; Array-Access
	LD HL,1
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	LD HL,DE
	LD (ZXBASIC_VAR_r),HL
; 		460.4  LET c=s(2{00 00 02 00 00 })
; Array-Access
	LD HL,2
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	LD HL,DE
	LD (ZXBASIC_VAR_c),HL
; 		460.5  LET last=0{00 00 00 00 00 }
	LD HL,0
	LD (ZXBASIC_VAR_last),HL
; 		460.6  GOSUB 3000{00 00 b8 0b 00 }
	CALL ZXBASIC_LINE_3000
; 		460.7  GOTO 489{00 00 e9 01 00 }
	JP ZXBASIC_LINE_489
ZXB_LABEL_26:
ZXBASIC_LINE_461:
; 461  IF m$(s(1),s(2))="\147" THEN  LET m$(s(1),s(2))="\150": LET r=s(1): LET c=s(2): LET last=0: GOSUB 3000: LET cont=cont+1
; 		461.1  IF m$(s(1{00 00 01 00 00 }),s(2{00 00 02 00 00 }))="\147" THEN  LET m$(s(1{00 00 01 00 00 }),s(2{00 00 02 00 00 }))="\150"
; Array-Access
	LD HL,1
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	LD HL,DE
	LD DE,19
	CALL runtimeMult16bit
	LD DE,HL
	LD HL,ZXBASIC_VAR_m_string
	ADD HL,DE
	PUSH HL
; Array-Access
	LD HL,2
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	LD HL,DE
	PUSH HL
	LD BC,HL
	POP DE
	POP HL
	CALL runtimePushFixedSubString
	LD DE,HL
	LD HL,STRING_36	;\93
; =
	CALL runtimeEqualString
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_27
; 		461.2  LET m$(s(1{00 00 01 00 00 }),s(2{00 00 02 00 00 }))="\150"
; Array-Access
	LD HL,1
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	LD HL,DE
	LD DE,19
	CALL runtimeMult16bit
	LD DE,HL
	LD HL,ZXBASIC_VAR_m_string
	ADD HL,DE
	PUSH HL
; Array-Access
	LD HL,2
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	LD HL,DE
	PUSH HL
	PUSH HL
	LD HL,STRING_35	;\96
	CALL runtimeStoreFixedStringWithRangeFromBstr
; 		461.3  LET r=s(1{00 00 01 00 00 })
; Array-Access
	LD HL,1
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	LD HL,DE
	LD (ZXBASIC_VAR_r),HL
; 		461.4  LET c=s(2{00 00 02 00 00 })
; Array-Access
	LD HL,2
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	LD HL,DE
	LD (ZXBASIC_VAR_c),HL
; 		461.5  LET last=0{00 00 00 00 00 }
	LD HL,0
	LD (ZXBASIC_VAR_last),HL
; 		461.6  GOSUB 3000{00 00 b8 0b 00 }
	CALL ZXBASIC_LINE_3000
; 		461.7  LET cont=cont+1{00 00 01 00 00 }
	LD HL,(ZXBASIC_VAR_cont)
	INC HL
; +
	LD (ZXBASIC_VAR_cont),HL
ZXB_LABEL_27:
ZXBASIC_LINE_489:
; 489  LET s(1)=s(1)+vm: LET s(2)=s(2)+hm: REM direction indicators
; 		489.1  LET s(1{00 00 01 00 00 })=s(1{00 00 01 00 00 })+vm
	LD HL,1
	ADD HL,HL
	PUSH HL
; Array-Access
	LD HL,1
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,(ZXBASIC_VAR_vm)
; +
	POP DE
	ADD HL,DE
	LD DE,HL
	POP HL
	LD BC,ZXBASIC_VAR_s_array
	ADD HL,BC
	LD (HL),DE
; 		489.2  LET s(2{00 00 02 00 00 })=s(2{00 00 02 00 00 })+hm
	LD HL,2
	ADD HL,HL
	PUSH HL
; Array-Access
	LD HL,2
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,(ZXBASIC_VAR_hm)
; +
	POP DE
	ADD HL,DE
	LD DE,HL
	POP HL
	LD BC,ZXBASIC_VAR_s_array
	ADD HL,BC
	LD (HL),DE
ZXBASIC_LINE_490:
; 490  LET moves=moves-1: GOTO 605
; 		490.1  LET moves=moves-1{00 00 01 00 00 }
	LD HL,(ZXBASIC_VAR_moves)
	DEC HL
; -
	LD (ZXBASIC_VAR_moves),HL
; 		490.2  GOTO 605{00 00 5d 02 00 }
	JP ZXBASIC_LINE_605
ZXBASIC_LINE_499:
; 499  RETURN 
; 		499.1  RETURN 
	RET
ZXBASIC_LINE_500:
; 500  REM Game Loop
ZXBASIC_LINE_510:
; 510  LET k$= INKEY$ : LET key= CODE k$: IF  NOT (k$=d$ OR k$=u$ OR k$=l$ OR k$=r$ OR (key >= 8 AND key <= 11))  THEN  RETURN 
; 		510.1  LET k$= INKEY$ 
; INKEY$
	CALL runtimeInkey
	LD DE,HL
	LD HL,ZXBASIC_VAR_k_string
	CALL runtimeStoreString
; 		510.2  LET key= CODE k$
; CODE
	LD HL,(ZXBASIC_VAR_k_string)
	CALL runtimeCode
	LD (ZXBASIC_VAR_key),HL
	CALL ZXFreeTempCompact
; 		510.3  IF  NOT (k$=d$ OR k$=u$ OR k$=l$ OR k$=r$ OR (key >= 8{00 00 08 00 00 } AND key <= 11{00 00 0b 00 00 }))  THEN  RETURN 
; NOT
	LD DE,(ZXBASIC_VAR_k_string)
	LD HL,(ZXBASIC_VAR_d_string)
; =
	CALL runtimeEqualString
	PUSH HL
	LD DE,(ZXBASIC_VAR_k_string)
	LD HL,(ZXBASIC_VAR_u_string)
; =
	CALL runtimeEqualString
; OR
	POP DE
	call runtimeOrHLDE
	PUSH HL
	LD DE,(ZXBASIC_VAR_k_string)
	LD HL,(ZXBASIC_VAR_l_string)
; =
	CALL runtimeEqualString
; OR
	POP DE
	call runtimeOrHLDE
	PUSH HL
	LD DE,(ZXBASIC_VAR_k_string)
	LD HL,(ZXBASIC_VAR_r_string)
; =
	CALL runtimeEqualString
; OR
	POP DE
	call runtimeOrHLDE
	PUSH HL
; (
	LD DE,(ZXBASIC_VAR_key)
	LD HL,8
; >=
	CALL runtimeCmpHLGeDE
	PUSH HL
	LD DE,(ZXBASIC_VAR_key)
	LD HL,11
; <=
	CALL runtimeCmpHLLeDE
; AND
	POP DE
	call runtimeAndHLDE
; )
; OR
	POP DE
	call runtimeOrHLDE
	CALL runtimeNotHL
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_28
; 		510.4  RETURN 
	RET
ZXB_LABEL_28:
ZXBASIC_LINE_512:
; 512  IF  INKEY$  <> "" THEN  GOTO 512
; 		512.1  IF  INKEY$  <> "" THEN  GOTO 512{00 00 00 02 00 }
; INKEY$
	CALL runtimeInkey
	LD DE,HL
	LD HL,STRING_13	;
; <>
	CALL runtimeUnequalString
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_29
; 		512.2  GOTO 512{00 00 00 02 00 }
	JP ZXBASIC_LINE_512
ZXB_LABEL_29:
ZXBASIC_LINE_513:
; 513  IF key=11 THEN  LET k$=u$
; 		513.1  IF key=11{00 00 0b 00 00 } THEN  LET k$=u$
	LD DE,(ZXBASIC_VAR_key)
	LD HL,11
; =
	CALL runtimeCmpHLEqDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_30
; 		513.2  LET k$=u$
	LD DE,(ZXBASIC_VAR_u_string)
	LD HL,ZXBASIC_VAR_k_string
	CALL runtimeStoreString
ZXB_LABEL_30:
ZXBASIC_LINE_514:
; 514  IF key=10 THEN  LET k$=d$
; 		514.1  IF key=10{00 00 0a 00 00 } THEN  LET k$=d$
	LD DE,(ZXBASIC_VAR_key)
	LD HL,10
; =
	CALL runtimeCmpHLEqDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_31
; 		514.2  LET k$=d$
	LD DE,(ZXBASIC_VAR_d_string)
	LD HL,ZXBASIC_VAR_k_string
	CALL runtimeStoreString
ZXB_LABEL_31:
ZXBASIC_LINE_515:
; 515  IF key=8 THEN  LET k$=l$
; 		515.1  IF key=8{00 00 08 00 00 } THEN  LET k$=l$
	LD DE,(ZXBASIC_VAR_key)
	LD HL,8
; =
	CALL runtimeCmpHLEqDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_32
; 		515.2  LET k$=l$
	LD DE,(ZXBASIC_VAR_l_string)
	LD HL,ZXBASIC_VAR_k_string
	CALL runtimeStoreString
ZXB_LABEL_32:
ZXBASIC_LINE_516:
; 516  IF key=9 THEN  LET k$=r$
; 		516.1  IF key=9{00 00 09 00 00 } THEN  LET k$=r$
	LD DE,(ZXBASIC_VAR_key)
	LD HL,9
; =
	CALL runtimeCmpHLEqDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_33
; 		516.2  LET k$=r$
	LD DE,(ZXBASIC_VAR_r_string)
	LD HL,ZXBASIC_VAR_k_string
	CALL runtimeStoreString
ZXB_LABEL_33:
ZXBASIC_LINE_517:
; 517  LET key=0
; 		517.1  LET key=0{00 00 00 00 00 }
	LD HL,0
	LD (ZXBASIC_VAR_key),HL
ZXBASIC_LINE_519:
; 519  IF k$="h" OR k$="H" THEN  REM asm call  ZXHeapWalk
; 		519.1  IF k$="h" OR k$="H" THEN  REM asm call  ZXHeapWalk
	LD DE,(ZXBASIC_VAR_k_string)
	LD HL,STRING_37	;h
; =
	CALL runtimeEqualString
	PUSH HL
	LD DE,(ZXBASIC_VAR_k_string)
	LD HL,STRING_38	;H
; =
	CALL runtimeEqualString
; OR
	POP DE
	call runtimeOrHLDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_34
	call  ZXHeapWalk 
ZXB_LABEL_34:
ZXBASIC_LINE_520:
; 520  IF k$ = "t" OR k$="T" THEN  GOSUB 9990
; 		520.1  IF k$ = "t" OR k$="T" THEN  GOSUB 9990{00 00 06 27 00 }
	LD DE,(ZXBASIC_VAR_k_string)
	LD HL,STRING_39	;t
; =
	CALL runtimeEqualString
	PUSH HL
	LD DE,(ZXBASIC_VAR_k_string)
	LD HL,STRING_40	;T
; =
	CALL runtimeEqualString
; OR
	POP DE
	call runtimeOrHLDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_35
; 		520.2  GOSUB 9990{00 00 06 27 00 }
	CALL ZXBASIC_LINE_9990
ZXB_LABEL_35:
ZXBASIC_LINE_529:
; 529  LET o(1)=s(1): LET o(2)=s(2): LET o(3)=pushes: REM old player position/pushes
; 		529.1  LET o(1{00 00 01 00 00 })=s(1{00 00 01 00 00 })
	LD HL,1
	ADD HL,HL
	PUSH HL
; Array-Access
	LD HL,1
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	POP DE
	POP HL
	LD BC,ZXBASIC_VAR_o_array
	ADD HL,BC
	LD (HL),DE
; 		529.2  LET o(2{00 00 02 00 00 })=s(2{00 00 02 00 00 })
	LD HL,2
	ADD HL,HL
	PUSH HL
; Array-Access
	LD HL,2
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	POP DE
	POP HL
	LD BC,ZXBASIC_VAR_o_array
	ADD HL,BC
	LD (HL),DE
; 		529.3  LET o(3{00 00 03 00 00 })=pushes
	LD HL,3
	ADD HL,HL
	PUSH HL
	LD DE,(ZXBASIC_VAR_pushes)
	POP HL
	LD BC,ZXBASIC_VAR_o_array
	ADD HL,BC
	LD (HL),DE
ZXBASIC_LINE_530:
; 530   LET vm=0+(-1 AND k$=u$)+(1 AND k$=d$): LET hm=0+(-1 AND k$=l$)+(1 AND k$=r$): REM direction indicators
; 		530.1  LET vm=0{00 00 00 00 00 }+(-1{00 00 01 00 00 } AND k$=u$)+(1{00 00 01 00 00 } AND k$=d$)
	LD HL,0
	PUSH HL
; (
	LD HL,1
	PUSH HL
	LD DE,(ZXBASIC_VAR_k_string)
	LD HL,(ZXBASIC_VAR_u_string)
; =
	CALL runtimeEqualString
; AND
	POP DE
	call runtimeAndHLDE
	LD BC,HL
; -
	LD HL,0
	SUB HL,BC
; )
; +
	POP DE
	ADD HL,DE
	PUSH HL
; (
	LD HL,1
	PUSH HL
	LD DE,(ZXBASIC_VAR_k_string)
	LD HL,(ZXBASIC_VAR_d_string)
; =
	CALL runtimeEqualString
; AND
	POP DE
	call runtimeAndHLDE
; )
; +
	POP DE
	ADD HL,DE
	LD (ZXBASIC_VAR_vm),HL
	CALL ZXFreeTempCompact
; 		530.2  LET hm=0{00 00 00 00 00 }+(-1{00 00 01 00 00 } AND k$=l$)+(1{00 00 01 00 00 } AND k$=r$)
	LD HL,0
	PUSH HL
; (
	LD HL,1
	PUSH HL
	LD DE,(ZXBASIC_VAR_k_string)
	LD HL,(ZXBASIC_VAR_l_string)
; =
	CALL runtimeEqualString
; AND
	POP DE
	call runtimeAndHLDE
	LD BC,HL
; -
	LD HL,0
	SUB HL,BC
; )
; +
	POP DE
	ADD HL,DE
	PUSH HL
; (
	LD HL,1
	PUSH HL
	LD DE,(ZXBASIC_VAR_k_string)
	LD HL,(ZXBASIC_VAR_r_string)
; =
	CALL runtimeEqualString
; AND
	POP DE
	call runtimeAndHLDE
; )
; +
	POP DE
	ADD HL,DE
	LD (ZXBASIC_VAR_hm),HL
	CALL ZXFreeTempCompact
ZXBASIC_LINE_540:
; 540  IF m$(s(1)+vm,s(2)+hm)="\145" THEN  LET s(1)=s(1)+vm: LET s(2)=s(2)+hm: LET moves=moves+1: GOTO 600: REM walk into blank space
; 		540.1  IF m$(s(1{00 00 01 00 00 })+vm,s(2{00 00 02 00 00 })+hm)="\145" THEN  LET s(1{00 00 01 00 00 })=s(1{00 00 01 00 00 })+vm
; Array-Access
	LD HL,1
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,(ZXBASIC_VAR_vm)
; +
	POP DE
	ADD HL,DE
	LD DE,19
	CALL runtimeMult16bit
	LD DE,HL
	LD HL,ZXBASIC_VAR_m_string
	ADD HL,DE
	PUSH HL
; Array-Access
	LD HL,2
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,(ZXBASIC_VAR_hm)
; +
	POP DE
	ADD HL,DE
	PUSH HL
	LD BC,HL
	POP DE
	POP HL
	CALL runtimePushFixedSubString
	LD DE,HL
	LD HL,STRING_34	;\91
; =
	CALL runtimeEqualString
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_36
; 		540.2  LET s(1{00 00 01 00 00 })=s(1{00 00 01 00 00 })+vm
	LD HL,1
	ADD HL,HL
	PUSH HL
; Array-Access
	LD HL,1
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,(ZXBASIC_VAR_vm)
; +
	POP DE
	ADD HL,DE
	LD DE,HL
	POP HL
	LD BC,ZXBASIC_VAR_s_array
	ADD HL,BC
	LD (HL),DE
; 		540.3  LET s(2{00 00 02 00 00 })=s(2{00 00 02 00 00 })+hm
	LD HL,2
	ADD HL,HL
	PUSH HL
; Array-Access
	LD HL,2
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,(ZXBASIC_VAR_hm)
; +
	POP DE
	ADD HL,DE
	LD DE,HL
	POP HL
	LD BC,ZXBASIC_VAR_s_array
	ADD HL,BC
	LD (HL),DE
; 		540.4  LET moves=moves+1{00 00 01 00 00 }
	LD HL,(ZXBASIC_VAR_moves)
	INC HL
; +
	LD (ZXBASIC_VAR_moves),HL
; 		540.5  GOTO 600{00 00 58 02 00 }
	JP ZXBASIC_LINE_600
ZXB_LABEL_36:
ZXBASIC_LINE_550:
; 550  IF m$(s(1)+vm,s(2)+hm)="\147" THEN  LET s(1)=s(1)+vm: LET s(2)=s(2)+hm: LET moves=moves+1: GOTO 600: REM walk into empty target
; 		550.1  IF m$(s(1{00 00 01 00 00 })+vm,s(2{00 00 02 00 00 })+hm)="\147" THEN  LET s(1{00 00 01 00 00 })=s(1{00 00 01 00 00 })+vm
; Array-Access
	LD HL,1
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,(ZXBASIC_VAR_vm)
; +
	POP DE
	ADD HL,DE
	LD DE,19
	CALL runtimeMult16bit
	LD DE,HL
	LD HL,ZXBASIC_VAR_m_string
	ADD HL,DE
	PUSH HL
; Array-Access
	LD HL,2
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,(ZXBASIC_VAR_hm)
; +
	POP DE
	ADD HL,DE
	PUSH HL
	LD BC,HL
	POP DE
	POP HL
	CALL runtimePushFixedSubString
	LD DE,HL
	LD HL,STRING_36	;\93
; =
	CALL runtimeEqualString
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_37
; 		550.2  LET s(1{00 00 01 00 00 })=s(1{00 00 01 00 00 })+vm
	LD HL,1
	ADD HL,HL
	PUSH HL
; Array-Access
	LD HL,1
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,(ZXBASIC_VAR_vm)
; +
	POP DE
	ADD HL,DE
	LD DE,HL
	POP HL
	LD BC,ZXBASIC_VAR_s_array
	ADD HL,BC
	LD (HL),DE
; 		550.3  LET s(2{00 00 02 00 00 })=s(2{00 00 02 00 00 })+hm
	LD HL,2
	ADD HL,HL
	PUSH HL
; Array-Access
	LD HL,2
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,(ZXBASIC_VAR_hm)
; +
	POP DE
	ADD HL,DE
	LD DE,HL
	POP HL
	LD BC,ZXBASIC_VAR_s_array
	ADD HL,BC
	LD (HL),DE
; 		550.4  LET moves=moves+1{00 00 01 00 00 }
	LD HL,(ZXBASIC_VAR_moves)
	INC HL
; +
	LD (ZXBASIC_VAR_moves),HL
; 		550.5  GOTO 600{00 00 58 02 00 }
	JP ZXBASIC_LINE_600
ZXB_LABEL_37:
ZXBASIC_LINE_560:
; 560  IF m$(s(1)+vm,s(2)+hm)="\146" THEN  IF m$(s(1)+vm+vm,s(2)+hm+hm)="\145" THEN  LET m$(s(1)+vm+vm,s(2)+hm+hm)=m$(s(1)+vm,s(2)+hm): LET m$(s(1)+vm,s(2)+hm)="\145": LET r=s(1)+vm+vm: LET c=s(2)+hm+hm: LET last=0: GOSUB 3000: LET s(1)=s(1)+vm: LET s(2)=s(2)+hm: LET moves=moves+1: LET pushes=pushes+1: GOTO 600: REM push crate into blank space
; 		560.1  IF m$(s(1{00 00 01 00 00 })+vm,s(2{00 00 02 00 00 })+hm)="\146" THEN  IF m$(s(1{00 00 01 00 00 })+vm+vm,s(2{00 00 02 00 00 })+hm+hm)="\145" THEN  LET m$(s(1{00 00 01 00 00 })+vm+vm,s(2{00 00 02 00 00 })+hm+hm)=m$(s(1{00 00 01 00 00 })+vm,s(2{00 00 02 00 00 })+hm)
; Array-Access
	LD HL,1
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,(ZXBASIC_VAR_vm)
; +
	POP DE
	ADD HL,DE
	LD DE,19
	CALL runtimeMult16bit
	LD DE,HL
	LD HL,ZXBASIC_VAR_m_string
	ADD HL,DE
	PUSH HL
; Array-Access
	LD HL,2
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,(ZXBASIC_VAR_hm)
; +
	POP DE
	ADD HL,DE
	PUSH HL
	LD BC,HL
	POP DE
	POP HL
	CALL runtimePushFixedSubString
	LD DE,HL
	LD HL,STRING_33	;\92
; =
	CALL runtimeEqualString
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_38
; 		560.2  IF m$(s(1{00 00 01 00 00 })+vm+vm,s(2{00 00 02 00 00 })+hm+hm)="\145" THEN  LET m$(s(1{00 00 01 00 00 })+vm+vm,s(2{00 00 02 00 00 })+hm+hm)=m$(s(1{00 00 01 00 00 })+vm,s(2{00 00 02 00 00 })+hm)
; Array-Access
	LD HL,1
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,(ZXBASIC_VAR_vm)
; +
	POP DE
	ADD HL,DE
	LD DE,HL
	LD HL,(ZXBASIC_VAR_vm)
; +
	ADD HL,DE
	LD DE,19
	CALL runtimeMult16bit
	LD DE,HL
	LD HL,ZXBASIC_VAR_m_string
	ADD HL,DE
	PUSH HL
; Array-Access
	LD HL,2
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,(ZXBASIC_VAR_hm)
; +
	POP DE
	ADD HL,DE
	LD DE,HL
	LD HL,(ZXBASIC_VAR_hm)
; +
	ADD HL,DE
	PUSH HL
	LD BC,HL
	POP DE
	POP HL
	CALL runtimePushFixedSubString
	LD DE,HL
	LD HL,STRING_34	;\91
; =
	CALL runtimeEqualString
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_39
; 		560.3  LET m$(s(1{00 00 01 00 00 })+vm+vm,s(2{00 00 02 00 00 })+hm+hm)=m$(s(1{00 00 01 00 00 })+vm,s(2{00 00 02 00 00 })+hm)
; Array-Access
	LD HL,1
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,(ZXBASIC_VAR_vm)
; +
	POP DE
	ADD HL,DE
	LD DE,HL
	LD HL,(ZXBASIC_VAR_vm)
; +
	ADD HL,DE
	LD DE,19
	CALL runtimeMult16bit
	LD DE,HL
	LD HL,ZXBASIC_VAR_m_string
	ADD HL,DE
	PUSH HL
; Array-Access
	LD HL,2
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,(ZXBASIC_VAR_hm)
; +
	POP DE
	ADD HL,DE
	LD DE,HL
	LD HL,(ZXBASIC_VAR_hm)
; +
	ADD HL,DE
	PUSH HL
	PUSH HL
; Array-Access
	LD HL,1
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,(ZXBASIC_VAR_vm)
; +
	POP DE
	ADD HL,DE
	LD DE,19
	CALL runtimeMult16bit
	LD DE,HL
	LD HL,ZXBASIC_VAR_m_string
	ADD HL,DE
	PUSH HL
; Array-Access
	LD HL,2
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,(ZXBASIC_VAR_hm)
; +
	POP DE
	ADD HL,DE
	PUSH HL
	LD BC,HL
	POP DE
	POP HL
	CALL runtimePushFixedSubString
	CALL runtimeStoreFixedStringWithRangeFromBstr
; 		560.4  LET m$(s(1{00 00 01 00 00 })+vm,s(2{00 00 02 00 00 })+hm)="\145"
; Array-Access
	LD HL,1
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,(ZXBASIC_VAR_vm)
; +
	POP DE
	ADD HL,DE
	LD DE,19
	CALL runtimeMult16bit
	LD DE,HL
	LD HL,ZXBASIC_VAR_m_string
	ADD HL,DE
	PUSH HL
; Array-Access
	LD HL,2
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,(ZXBASIC_VAR_hm)
; +
	POP DE
	ADD HL,DE
	PUSH HL
	PUSH HL
	LD HL,STRING_34	;\91
	CALL runtimeStoreFixedStringWithRangeFromBstr
; 		560.5  LET r=s(1{00 00 01 00 00 })+vm+vm
; Array-Access
	LD HL,1
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,(ZXBASIC_VAR_vm)
; +
	POP DE
	ADD HL,DE
	LD DE,HL
	LD HL,(ZXBASIC_VAR_vm)
; +
	ADD HL,DE
	LD (ZXBASIC_VAR_r),HL
; 		560.6  LET c=s(2{00 00 02 00 00 })+hm+hm
; Array-Access
	LD HL,2
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,(ZXBASIC_VAR_hm)
; +
	POP DE
	ADD HL,DE
	LD DE,HL
	LD HL,(ZXBASIC_VAR_hm)
; +
	ADD HL,DE
	LD (ZXBASIC_VAR_c),HL
; 		560.7  LET last=0{00 00 00 00 00 }
	LD HL,0
	LD (ZXBASIC_VAR_last),HL
; 		560.8  GOSUB 3000{00 00 b8 0b 00 }
	CALL ZXBASIC_LINE_3000
; 		560.9  LET s(1{00 00 01 00 00 })=s(1{00 00 01 00 00 })+vm
	LD HL,1
	ADD HL,HL
	PUSH HL
; Array-Access
	LD HL,1
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,(ZXBASIC_VAR_vm)
; +
	POP DE
	ADD HL,DE
	LD DE,HL
	POP HL
	LD BC,ZXBASIC_VAR_s_array
	ADD HL,BC
	LD (HL),DE
; 		560.10  LET s(2{00 00 02 00 00 })=s(2{00 00 02 00 00 })+hm
	LD HL,2
	ADD HL,HL
	PUSH HL
; Array-Access
	LD HL,2
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,(ZXBASIC_VAR_hm)
; +
	POP DE
	ADD HL,DE
	LD DE,HL
	POP HL
	LD BC,ZXBASIC_VAR_s_array
	ADD HL,BC
	LD (HL),DE
; 		560.11  LET moves=moves+1{00 00 01 00 00 }
	LD HL,(ZXBASIC_VAR_moves)
	INC HL
; +
	LD (ZXBASIC_VAR_moves),HL
; 		560.12  LET pushes=pushes+1{00 00 01 00 00 }
	LD HL,(ZXBASIC_VAR_pushes)
	INC HL
; +
	LD (ZXBASIC_VAR_pushes),HL
; 		560.13  GOTO 600{00 00 58 02 00 }
	JP ZXBASIC_LINE_600
ZXB_LABEL_39:
ZXB_LABEL_38:
ZXBASIC_LINE_570:
; 570  IF m$(s(1)+vm,s(2)+hm)="\146" THEN  IF m$(s(1)+vm+vm,s(2)+hm+hm)="\147" THEN  LET m$(s(1)+vm+vm,s(2)+hm+hm)="\150": LET m$(s(1)+vm,s(2)+hm)="\145": LET r=s(1)+vm+vm: LET c=s(2)+hm+hm: LET last=0: GOSUB 3000: LET s(1)=s(1)+vm: LET s(2)=s(2)+hm: LET moves=moves+1: LET pushes=pushes+1: LET cont=cont+1: GOTO 600: REM push crate into target
; 		570.1  IF m$(s(1{00 00 01 00 00 })+vm,s(2{00 00 02 00 00 })+hm)="\146" THEN  IF m$(s(1{00 00 01 00 00 })+vm+vm,s(2{00 00 02 00 00 })+hm+hm)="\147" THEN  LET m$(s(1{00 00 01 00 00 })+vm+vm,s(2{00 00 02 00 00 })+hm+hm)="\150"
; Array-Access
	LD HL,1
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,(ZXBASIC_VAR_vm)
; +
	POP DE
	ADD HL,DE
	LD DE,19
	CALL runtimeMult16bit
	LD DE,HL
	LD HL,ZXBASIC_VAR_m_string
	ADD HL,DE
	PUSH HL
; Array-Access
	LD HL,2
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,(ZXBASIC_VAR_hm)
; +
	POP DE
	ADD HL,DE
	PUSH HL
	LD BC,HL
	POP DE
	POP HL
	CALL runtimePushFixedSubString
	LD DE,HL
	LD HL,STRING_33	;\92
; =
	CALL runtimeEqualString
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_40
; 		570.2  IF m$(s(1{00 00 01 00 00 })+vm+vm,s(2{00 00 02 00 00 })+hm+hm)="\147" THEN  LET m$(s(1{00 00 01 00 00 })+vm+vm,s(2{00 00 02 00 00 })+hm+hm)="\150"
; Array-Access
	LD HL,1
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,(ZXBASIC_VAR_vm)
; +
	POP DE
	ADD HL,DE
	LD DE,HL
	LD HL,(ZXBASIC_VAR_vm)
; +
	ADD HL,DE
	LD DE,19
	CALL runtimeMult16bit
	LD DE,HL
	LD HL,ZXBASIC_VAR_m_string
	ADD HL,DE
	PUSH HL
; Array-Access
	LD HL,2
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,(ZXBASIC_VAR_hm)
; +
	POP DE
	ADD HL,DE
	LD DE,HL
	LD HL,(ZXBASIC_VAR_hm)
; +
	ADD HL,DE
	PUSH HL
	LD BC,HL
	POP DE
	POP HL
	CALL runtimePushFixedSubString
	LD DE,HL
	LD HL,STRING_36	;\93
; =
	CALL runtimeEqualString
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_41
; 		570.3  LET m$(s(1{00 00 01 00 00 })+vm+vm,s(2{00 00 02 00 00 })+hm+hm)="\150"
; Array-Access
	LD HL,1
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,(ZXBASIC_VAR_vm)
; +
	POP DE
	ADD HL,DE
	LD DE,HL
	LD HL,(ZXBASIC_VAR_vm)
; +
	ADD HL,DE
	LD DE,19
	CALL runtimeMult16bit
	LD DE,HL
	LD HL,ZXBASIC_VAR_m_string
	ADD HL,DE
	PUSH HL
; Array-Access
	LD HL,2
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,(ZXBASIC_VAR_hm)
; +
	POP DE
	ADD HL,DE
	LD DE,HL
	LD HL,(ZXBASIC_VAR_hm)
; +
	ADD HL,DE
	PUSH HL
	PUSH HL
	LD HL,STRING_35	;\96
	CALL runtimeStoreFixedStringWithRangeFromBstr
; 		570.4  LET m$(s(1{00 00 01 00 00 })+vm,s(2{00 00 02 00 00 })+hm)="\145"
; Array-Access
	LD HL,1
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,(ZXBASIC_VAR_vm)
; +
	POP DE
	ADD HL,DE
	LD DE,19
	CALL runtimeMult16bit
	LD DE,HL
	LD HL,ZXBASIC_VAR_m_string
	ADD HL,DE
	PUSH HL
; Array-Access
	LD HL,2
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,(ZXBASIC_VAR_hm)
; +
	POP DE
	ADD HL,DE
	PUSH HL
	PUSH HL
	LD HL,STRING_34	;\91
	CALL runtimeStoreFixedStringWithRangeFromBstr
; 		570.5  LET r=s(1{00 00 01 00 00 })+vm+vm
; Array-Access
	LD HL,1
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,(ZXBASIC_VAR_vm)
; +
	POP DE
	ADD HL,DE
	LD DE,HL
	LD HL,(ZXBASIC_VAR_vm)
; +
	ADD HL,DE
	LD (ZXBASIC_VAR_r),HL
; 		570.6  LET c=s(2{00 00 02 00 00 })+hm+hm
; Array-Access
	LD HL,2
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,(ZXBASIC_VAR_hm)
; +
	POP DE
	ADD HL,DE
	LD DE,HL
	LD HL,(ZXBASIC_VAR_hm)
; +
	ADD HL,DE
	LD (ZXBASIC_VAR_c),HL
; 		570.7  LET last=0{00 00 00 00 00 }
	LD HL,0
	LD (ZXBASIC_VAR_last),HL
; 		570.8  GOSUB 3000{00 00 b8 0b 00 }
	CALL ZXBASIC_LINE_3000
; 		570.9  LET s(1{00 00 01 00 00 })=s(1{00 00 01 00 00 })+vm
	LD HL,1
	ADD HL,HL
	PUSH HL
; Array-Access
	LD HL,1
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,(ZXBASIC_VAR_vm)
; +
	POP DE
	ADD HL,DE
	LD DE,HL
	POP HL
	LD BC,ZXBASIC_VAR_s_array
	ADD HL,BC
	LD (HL),DE
; 		570.10  LET s(2{00 00 02 00 00 })=s(2{00 00 02 00 00 })+hm
	LD HL,2
	ADD HL,HL
	PUSH HL
; Array-Access
	LD HL,2
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,(ZXBASIC_VAR_hm)
; +
	POP DE
	ADD HL,DE
	LD DE,HL
	POP HL
	LD BC,ZXBASIC_VAR_s_array
	ADD HL,BC
	LD (HL),DE
; 		570.11  LET moves=moves+1{00 00 01 00 00 }
	LD HL,(ZXBASIC_VAR_moves)
	INC HL
; +
	LD (ZXBASIC_VAR_moves),HL
; 		570.12  LET pushes=pushes+1{00 00 01 00 00 }
	LD HL,(ZXBASIC_VAR_pushes)
	INC HL
; +
	LD (ZXBASIC_VAR_pushes),HL
; 		570.13  LET cont=cont+1{00 00 01 00 00 }
	LD HL,(ZXBASIC_VAR_cont)
	INC HL
; +
	LD (ZXBASIC_VAR_cont),HL
; 		570.14  GOTO 600{00 00 58 02 00 }
	JP ZXBASIC_LINE_600
ZXB_LABEL_41:
ZXB_LABEL_40:
ZXBASIC_LINE_580:
; 580  IF m$(s(1)+vm,s(2)+hm)="\150" THEN  IF m$(s(1)+vm+vm,s(2)+hm+hm)="\145" THEN  LET m$(s(1)+vm+vm,s(2)+hm+hm)="\146": LET m$(s(1)+vm,s(2)+hm)="\147": LET r=s(1)+vm+vm: LET c=s(2)+hm+hm: LET last=0: GOSUB 3000: LET s(1)=s(1)+vm: LET s(2)=s(2)+hm: LET moves=moves+1: LET pushes=pushes+1: LET cont=cont-1: GOTO 600: REM targeted crate into blank space
; 		580.1  IF m$(s(1{00 00 01 00 00 })+vm,s(2{00 00 02 00 00 })+hm)="\150" THEN  IF m$(s(1{00 00 01 00 00 })+vm+vm,s(2{00 00 02 00 00 })+hm+hm)="\145" THEN  LET m$(s(1{00 00 01 00 00 })+vm+vm,s(2{00 00 02 00 00 })+hm+hm)="\146"
; Array-Access
	LD HL,1
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,(ZXBASIC_VAR_vm)
; +
	POP DE
	ADD HL,DE
	LD DE,19
	CALL runtimeMult16bit
	LD DE,HL
	LD HL,ZXBASIC_VAR_m_string
	ADD HL,DE
	PUSH HL
; Array-Access
	LD HL,2
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,(ZXBASIC_VAR_hm)
; +
	POP DE
	ADD HL,DE
	PUSH HL
	LD BC,HL
	POP DE
	POP HL
	CALL runtimePushFixedSubString
	LD DE,HL
	LD HL,STRING_35	;\96
; =
	CALL runtimeEqualString
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_42
; 		580.2  IF m$(s(1{00 00 01 00 00 })+vm+vm,s(2{00 00 02 00 00 })+hm+hm)="\145" THEN  LET m$(s(1{00 00 01 00 00 })+vm+vm,s(2{00 00 02 00 00 })+hm+hm)="\146"
; Array-Access
	LD HL,1
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,(ZXBASIC_VAR_vm)
; +
	POP DE
	ADD HL,DE
	LD DE,HL
	LD HL,(ZXBASIC_VAR_vm)
; +
	ADD HL,DE
	LD DE,19
	CALL runtimeMult16bit
	LD DE,HL
	LD HL,ZXBASIC_VAR_m_string
	ADD HL,DE
	PUSH HL
; Array-Access
	LD HL,2
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,(ZXBASIC_VAR_hm)
; +
	POP DE
	ADD HL,DE
	LD DE,HL
	LD HL,(ZXBASIC_VAR_hm)
; +
	ADD HL,DE
	PUSH HL
	LD BC,HL
	POP DE
	POP HL
	CALL runtimePushFixedSubString
	LD DE,HL
	LD HL,STRING_34	;\91
; =
	CALL runtimeEqualString
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_43
; 		580.3  LET m$(s(1{00 00 01 00 00 })+vm+vm,s(2{00 00 02 00 00 })+hm+hm)="\146"
; Array-Access
	LD HL,1
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,(ZXBASIC_VAR_vm)
; +
	POP DE
	ADD HL,DE
	LD DE,HL
	LD HL,(ZXBASIC_VAR_vm)
; +
	ADD HL,DE
	LD DE,19
	CALL runtimeMult16bit
	LD DE,HL
	LD HL,ZXBASIC_VAR_m_string
	ADD HL,DE
	PUSH HL
; Array-Access
	LD HL,2
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,(ZXBASIC_VAR_hm)
; +
	POP DE
	ADD HL,DE
	LD DE,HL
	LD HL,(ZXBASIC_VAR_hm)
; +
	ADD HL,DE
	PUSH HL
	PUSH HL
	LD HL,STRING_33	;\92
	CALL runtimeStoreFixedStringWithRangeFromBstr
; 		580.4  LET m$(s(1{00 00 01 00 00 })+vm,s(2{00 00 02 00 00 })+hm)="\147"
; Array-Access
	LD HL,1
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,(ZXBASIC_VAR_vm)
; +
	POP DE
	ADD HL,DE
	LD DE,19
	CALL runtimeMult16bit
	LD DE,HL
	LD HL,ZXBASIC_VAR_m_string
	ADD HL,DE
	PUSH HL
; Array-Access
	LD HL,2
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,(ZXBASIC_VAR_hm)
; +
	POP DE
	ADD HL,DE
	PUSH HL
	PUSH HL
	LD HL,STRING_36	;\93
	CALL runtimeStoreFixedStringWithRangeFromBstr
; 		580.5  LET r=s(1{00 00 01 00 00 })+vm+vm
; Array-Access
	LD HL,1
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,(ZXBASIC_VAR_vm)
; +
	POP DE
	ADD HL,DE
	LD DE,HL
	LD HL,(ZXBASIC_VAR_vm)
; +
	ADD HL,DE
	LD (ZXBASIC_VAR_r),HL
; 		580.6  LET c=s(2{00 00 02 00 00 })+hm+hm
; Array-Access
	LD HL,2
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,(ZXBASIC_VAR_hm)
; +
	POP DE
	ADD HL,DE
	LD DE,HL
	LD HL,(ZXBASIC_VAR_hm)
; +
	ADD HL,DE
	LD (ZXBASIC_VAR_c),HL
; 		580.7  LET last=0{00 00 00 00 00 }
	LD HL,0
	LD (ZXBASIC_VAR_last),HL
; 		580.8  GOSUB 3000{00 00 b8 0b 00 }
	CALL ZXBASIC_LINE_3000
; 		580.9  LET s(1{00 00 01 00 00 })=s(1{00 00 01 00 00 })+vm
	LD HL,1
	ADD HL,HL
	PUSH HL
; Array-Access
	LD HL,1
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,(ZXBASIC_VAR_vm)
; +
	POP DE
	ADD HL,DE
	LD DE,HL
	POP HL
	LD BC,ZXBASIC_VAR_s_array
	ADD HL,BC
	LD (HL),DE
; 		580.10  LET s(2{00 00 02 00 00 })=s(2{00 00 02 00 00 })+hm
	LD HL,2
	ADD HL,HL
	PUSH HL
; Array-Access
	LD HL,2
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,(ZXBASIC_VAR_hm)
; +
	POP DE
	ADD HL,DE
	LD DE,HL
	POP HL
	LD BC,ZXBASIC_VAR_s_array
	ADD HL,BC
	LD (HL),DE
; 		580.11  LET moves=moves+1{00 00 01 00 00 }
	LD HL,(ZXBASIC_VAR_moves)
	INC HL
; +
	LD (ZXBASIC_VAR_moves),HL
; 		580.12  LET pushes=pushes+1{00 00 01 00 00 }
	LD HL,(ZXBASIC_VAR_pushes)
	INC HL
; +
	LD (ZXBASIC_VAR_pushes),HL
; 		580.13  LET cont=cont-1{00 00 01 00 00 }
	LD HL,(ZXBASIC_VAR_cont)
	DEC HL
; -
	LD (ZXBASIC_VAR_cont),HL
; 		580.14  GOTO 600{00 00 58 02 00 }
	JP ZXBASIC_LINE_600
ZXB_LABEL_43:
ZXB_LABEL_42:
ZXBASIC_LINE_590:
; 590  IF m$(s(1)+vm,s(2)+hm)="\150" THEN  IF m$(s(1)+vm+vm,s(2)+hm+hm)="\147" THEN  LET m$(s(1)+vm+vm,s(2)+hm+hm)="\150": LET m$(s(1)+vm,s(2)+hm)="\147": LET r=s(1)+vm+vm: LET c=s(2)+hm+hm: LET last=0: GOSUB 3000: LET s(1)=s(1)+vm: LET s(2)=s(2)+hm: LET moves=moves+1: LET pushes=pushes+1: GOTO 600: REM targeted crate into target
; 		590.1  IF m$(s(1{00 00 01 00 00 })+vm,s(2{00 00 02 00 00 })+hm)="\150" THEN  IF m$(s(1{00 00 01 00 00 })+vm+vm,s(2{00 00 02 00 00 })+hm+hm)="\147" THEN  LET m$(s(1{00 00 01 00 00 })+vm+vm,s(2{00 00 02 00 00 })+hm+hm)="\150"
; Array-Access
	LD HL,1
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,(ZXBASIC_VAR_vm)
; +
	POP DE
	ADD HL,DE
	LD DE,19
	CALL runtimeMult16bit
	LD DE,HL
	LD HL,ZXBASIC_VAR_m_string
	ADD HL,DE
	PUSH HL
; Array-Access
	LD HL,2
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,(ZXBASIC_VAR_hm)
; +
	POP DE
	ADD HL,DE
	PUSH HL
	LD BC,HL
	POP DE
	POP HL
	CALL runtimePushFixedSubString
	LD DE,HL
	LD HL,STRING_35	;\96
; =
	CALL runtimeEqualString
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_44
; 		590.2  IF m$(s(1{00 00 01 00 00 })+vm+vm,s(2{00 00 02 00 00 })+hm+hm)="\147" THEN  LET m$(s(1{00 00 01 00 00 })+vm+vm,s(2{00 00 02 00 00 })+hm+hm)="\150"
; Array-Access
	LD HL,1
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,(ZXBASIC_VAR_vm)
; +
	POP DE
	ADD HL,DE
	LD DE,HL
	LD HL,(ZXBASIC_VAR_vm)
; +
	ADD HL,DE
	LD DE,19
	CALL runtimeMult16bit
	LD DE,HL
	LD HL,ZXBASIC_VAR_m_string
	ADD HL,DE
	PUSH HL
; Array-Access
	LD HL,2
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,(ZXBASIC_VAR_hm)
; +
	POP DE
	ADD HL,DE
	LD DE,HL
	LD HL,(ZXBASIC_VAR_hm)
; +
	ADD HL,DE
	PUSH HL
	LD BC,HL
	POP DE
	POP HL
	CALL runtimePushFixedSubString
	LD DE,HL
	LD HL,STRING_36	;\93
; =
	CALL runtimeEqualString
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_45
; 		590.3  LET m$(s(1{00 00 01 00 00 })+vm+vm,s(2{00 00 02 00 00 })+hm+hm)="\150"
; Array-Access
	LD HL,1
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,(ZXBASIC_VAR_vm)
; +
	POP DE
	ADD HL,DE
	LD DE,HL
	LD HL,(ZXBASIC_VAR_vm)
; +
	ADD HL,DE
	LD DE,19
	CALL runtimeMult16bit
	LD DE,HL
	LD HL,ZXBASIC_VAR_m_string
	ADD HL,DE
	PUSH HL
; Array-Access
	LD HL,2
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,(ZXBASIC_VAR_hm)
; +
	POP DE
	ADD HL,DE
	LD DE,HL
	LD HL,(ZXBASIC_VAR_hm)
; +
	ADD HL,DE
	PUSH HL
	PUSH HL
	LD HL,STRING_35	;\96
	CALL runtimeStoreFixedStringWithRangeFromBstr
; 		590.4  LET m$(s(1{00 00 01 00 00 })+vm,s(2{00 00 02 00 00 })+hm)="\147"
; Array-Access
	LD HL,1
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,(ZXBASIC_VAR_vm)
; +
	POP DE
	ADD HL,DE
	LD DE,19
	CALL runtimeMult16bit
	LD DE,HL
	LD HL,ZXBASIC_VAR_m_string
	ADD HL,DE
	PUSH HL
; Array-Access
	LD HL,2
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,(ZXBASIC_VAR_hm)
; +
	POP DE
	ADD HL,DE
	PUSH HL
	PUSH HL
	LD HL,STRING_36	;\93
	CALL runtimeStoreFixedStringWithRangeFromBstr
; 		590.5  LET r=s(1{00 00 01 00 00 })+vm+vm
; Array-Access
	LD HL,1
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,(ZXBASIC_VAR_vm)
; +
	POP DE
	ADD HL,DE
	LD DE,HL
	LD HL,(ZXBASIC_VAR_vm)
; +
	ADD HL,DE
	LD (ZXBASIC_VAR_r),HL
; 		590.6  LET c=s(2{00 00 02 00 00 })+hm+hm
; Array-Access
	LD HL,2
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,(ZXBASIC_VAR_hm)
; +
	POP DE
	ADD HL,DE
	LD DE,HL
	LD HL,(ZXBASIC_VAR_hm)
; +
	ADD HL,DE
	LD (ZXBASIC_VAR_c),HL
; 		590.7  LET last=0{00 00 00 00 00 }
	LD HL,0
	LD (ZXBASIC_VAR_last),HL
; 		590.8  GOSUB 3000{00 00 b8 0b 00 }
	CALL ZXBASIC_LINE_3000
; 		590.9  LET s(1{00 00 01 00 00 })=s(1{00 00 01 00 00 })+vm
	LD HL,1
	ADD HL,HL
	PUSH HL
; Array-Access
	LD HL,1
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,(ZXBASIC_VAR_vm)
; +
	POP DE
	ADD HL,DE
	LD DE,HL
	POP HL
	LD BC,ZXBASIC_VAR_s_array
	ADD HL,BC
	LD (HL),DE
; 		590.10  LET s(2{00 00 02 00 00 })=s(2{00 00 02 00 00 })+hm
	LD HL,2
	ADD HL,HL
	PUSH HL
; Array-Access
	LD HL,2
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,(ZXBASIC_VAR_hm)
; +
	POP DE
	ADD HL,DE
	LD DE,HL
	POP HL
	LD BC,ZXBASIC_VAR_s_array
	ADD HL,BC
	LD (HL),DE
; 		590.11  LET moves=moves+1{00 00 01 00 00 }
	LD HL,(ZXBASIC_VAR_moves)
	INC HL
; +
	LD (ZXBASIC_VAR_moves),HL
; 		590.12  LET pushes=pushes+1{00 00 01 00 00 }
	LD HL,(ZXBASIC_VAR_pushes)
	INC HL
; +
	LD (ZXBASIC_VAR_pushes),HL
; 		590.13  GOTO 600{00 00 58 02 00 }
	JP ZXBASIC_LINE_600
ZXB_LABEL_45:
ZXB_LABEL_44:
ZXBASIC_LINE_595:
; 595  RETURN 
; 		595.1  RETURN 
	RET
ZXBASIC_LINE_600:
; 600  IF o(3) <> pushes THEN  LET k$= CHR$ ( CODE k$-32)
; 		600.1  IF o(3{00 00 03 00 00 }) <> pushes THEN  LET k$= CHR$ ( CODE k$-32{00 00 20 00 00 })
; Array-Access
	LD HL,3
	ADD HL,HL
	LD DE, ZXBASIC_VAR_o_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,(ZXBASIC_VAR_pushes)
; <>
	POP DE
	CALL runtimeCmpHlNeDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_46
; 		600.2  LET k$= CHR$ ( CODE k$-32{00 00 20 00 00 })
; CHR$
; CODE
	LD HL,(ZXBASIC_VAR_k_string)
	CALL runtimeCode
	LD DE,32
; -
	SUB HL,DE
	CALL runtimeChr
	LD DE,HL
	LD HL,ZXBASIC_VAR_k_string
	CALL runtimeStoreString
ZXB_LABEL_46:
ZXBASIC_LINE_601:
; 601  LET h$(moves)=k$: REM store last move made
; 		601.1  LET h$(moves)=k$
	LD HL,ZXBASIC_VAR_h_string
	PUSH HL
	LD HL,(ZXBASIC_VAR_moves)
	PUSH HL
	PUSH HL
	LD HL,(ZXBASIC_VAR_k_string)
	CALL runtimeStoreFixedStringWithRangeFromBstr
	CALL ZXFreeTempCompact
ZXBASIC_LINE_605:
; 605  IF s(1) <> o(1) OR s(2) <> o(2) THEN  LET r=o(1): LET c=o(2): LET last=0: GOSUB 3000: REM redraw character at old player position
; 		605.1  IF s(1{00 00 01 00 00 }) <> o(1{00 00 01 00 00 }) OR s(2{00 00 02 00 00 }) <> o(2{00 00 02 00 00 }) THEN  LET r=o(1{00 00 01 00 00 })
; Array-Access
	LD HL,1
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
; Array-Access
	LD HL,1
	ADD HL,HL
	LD DE, ZXBASIC_VAR_o_array
	ADD HL,DE
	LD DE,(HL)
	LD HL,DE
; <>
	POP DE
	CALL runtimeCmpHlNeDE
	PUSH HL
; Array-Access
	LD HL,2
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
; Array-Access
	LD HL,2
	ADD HL,HL
	LD DE, ZXBASIC_VAR_o_array
	ADD HL,DE
	LD DE,(HL)
	LD HL,DE
; <>
	POP DE
	CALL runtimeCmpHlNeDE
; OR
	POP DE
	call runtimeOrHLDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_47
; 		605.2  LET r=o(1{00 00 01 00 00 })
; Array-Access
	LD HL,1
	ADD HL,HL
	LD DE, ZXBASIC_VAR_o_array
	ADD HL,DE
	LD DE,(HL)
	LD HL,DE
	LD (ZXBASIC_VAR_r),HL
; 		605.3  LET c=o(2{00 00 02 00 00 })
; Array-Access
	LD HL,2
	ADD HL,HL
	LD DE, ZXBASIC_VAR_o_array
	ADD HL,DE
	LD DE,(HL)
	LD HL,DE
	LD (ZXBASIC_VAR_c),HL
; 		605.4  LET last=0{00 00 00 00 00 }
	LD HL,0
	LD (ZXBASIC_VAR_last),HL
; 		605.5  GOSUB 3000{00 00 b8 0b 00 }
	CALL ZXBASIC_LINE_3000
ZXB_LABEL_47:
ZXBASIC_LINE_610:
; 610  IF m$(s(1),s(2))="\145" THEN  PRINT  AT s(1),s(2); INK 2; PAPER 5;"\148"
; 		610.1  IF m$(s(1{00 00 01 00 00 }),s(2{00 00 02 00 00 }))="\145" THEN  PRINT  AT s(1{00 00 01 00 00 }),s(2{00 00 02 00 00 }); INK 2{00 00 02 00 00 }; PAPER 5{00 00 05 00 00 };"\148"
; Array-Access
	LD HL,1
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	LD HL,DE
	LD DE,19
	CALL runtimeMult16bit
	LD DE,HL
	LD HL,ZXBASIC_VAR_m_string
	ADD HL,DE
	PUSH HL
; Array-Access
	LD HL,2
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	LD HL,DE
	PUSH HL
	LD BC,HL
	POP DE
	POP HL
	CALL runtimePushFixedSubString
	LD DE,HL
	LD HL,STRING_34	;\91
; =
	CALL runtimeEqualString
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_48
; 		610.2  PRINT  AT s(1{00 00 01 00 00 }),s(2{00 00 02 00 00 }); INK 2{00 00 02 00 00 }; PAPER 5{00 00 05 00 00 };"\148"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
; Array-Access
	LD HL,1
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
; Array-Access
	LD HL,2
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	LD HL,DE
	POP DE
	CALL runtimePrintAt
	LD HL,2
	CALL runtimeLocalInk
	LD HL,5
	CALL runtimeLocalPaper
	LD HL,STRING_41	;\94
	CALL runtimePrintString
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
ZXB_LABEL_48:
ZXBASIC_LINE_620:
; 620  IF m$(s(1),s(2))="\147" THEN  PRINT  AT s(1),s(2); INK 0; PAPER 2;"\149"
; 		620.1  IF m$(s(1{00 00 01 00 00 }),s(2{00 00 02 00 00 }))="\147" THEN  PRINT  AT s(1{00 00 01 00 00 }),s(2{00 00 02 00 00 }); INK 0{00 00 00 00 00 }; PAPER 2{00 00 02 00 00 };"\149"
; Array-Access
	LD HL,1
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	LD HL,DE
	LD DE,19
	CALL runtimeMult16bit
	LD DE,HL
	LD HL,ZXBASIC_VAR_m_string
	ADD HL,DE
	PUSH HL
; Array-Access
	LD HL,2
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	LD HL,DE
	PUSH HL
	LD BC,HL
	POP DE
	POP HL
	CALL runtimePushFixedSubString
	LD DE,HL
	LD HL,STRING_36	;\93
; =
	CALL runtimeEqualString
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_49
; 		620.2  PRINT  AT s(1{00 00 01 00 00 }),s(2{00 00 02 00 00 }); INK 0{00 00 00 00 00 }; PAPER 2{00 00 02 00 00 };"\149"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
; Array-Access
	LD HL,1
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
; Array-Access
	LD HL,2
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	LD HL,DE
	POP DE
	CALL runtimePrintAt
	LD HL,0
	CALL runtimeLocalInk
	LD HL,2
	CALL runtimeLocalPaper
	LD HL,STRING_42	;\95
	CALL runtimePrintString
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
ZXB_LABEL_49:
ZXBASIC_LINE_630:
; 630  INK 0: PAPER 7: PRINT  AT 2,21;cont; AT 5,21;moves; AT 8,21;pushes
; 		630.1  INK 0{00 00 00 00 00 }
	LD HL,0
	CALL runtimeInk
; 		630.2  PAPER 7{00 00 07 00 00 }
	LD HL,7
	CALL runtimePaper
; 		630.3  PRINT  AT 2{00 00 02 00 00 },21{00 00 15 00 00 };cont; AT 5{00 00 05 00 00 },21{00 00 15 00 00 };moves; AT 8{00 00 08 00 00 },21{00 00 15 00 00 };pushes
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,2
	LD HL,21
	CALL runtimePrintAt
	LD HL,(ZXBASIC_VAR_cont)
	CALL runtimePrintInt
	LD DE,5
	LD HL,21
	CALL runtimePrintAt
	LD HL,(ZXBASIC_VAR_moves)
	CALL runtimePrintInt
	LD DE,8
	LD HL,21
	CALL runtimePrintAt
	LD HL,(ZXBASIC_VAR_pushes)
	CALL runtimePrintInt
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_650:
; 650  RETURN 
; 		650.1  RETURN 
	RET
ZXBASIC_LINE_1000:
; 1000  RESTORE 1010: FOR n= USR "a" TO  USR "h"-1: READ a: POKE n,a: NEXT n: RETURN 
; 		1000.1  RESTORE 1010{00 00 f2 03 00 }
	LD DE,1010
	LD HL,ZXDATA
	CALL runtimeFindLine
	EX HL,DE
	LD (DATAPTR),DE
; 		1000.2  FOR n= USR "a" TO  USR "h"-1{00 00 01 00 00 }
; USR
	LD HL,STRING_43	;a
	CALL runtimeUsrUDG
	LD (ZXBASIC_VAR_n),HL
; USR
	LD HL,STRING_37	;h
	CALL runtimeUsrUDG
	LD DE,1
; -
	SUB HL,DE
	LD (ZXBASIC_VAR_for_n),HL
FOR_4:
; 		1000.3  READ a
	LD HL,(DATAPTR)
	LD DE,(HL)
	INC HL
	INC HL
	LD (DATAPTR),HL
	LD (ZXBASIC_VAR_a),DE
; 		1000.4  POKE n,a
	LD HL,(ZXBASIC_VAR_n)
	LD DE,(ZXBASIC_VAR_a)
	LD (HL),E
; 		1000.5  NEXT n
	LD HL,(ZXBASIC_VAR_n)
	INC HL
	LD (ZXBASIC_VAR_n),HL
	LD DE,(ZXBASIC_VAR_for_n)
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_4
; 		1000.6  RETURN 
	RET
ZXBASIC_LINE_1010:
; 1010  DATA 85,129,1,129,1,129,1,255,0,0,8,56,28,16,0,0,0,42,124,70,68,70,124,0,255,255,247,199,227,239,255,255,24,60,90,255,219,102,60,24,231,195,165,0,36,153,195,231,255,213,131,185,187,185,131,255
; 		1010.1  DATA 85{00 00 55 00 00 },129{00 00 81 00 00 },1{00 00 01 00 00 },129{00 00 81 00 00 },1{00 00 01 00 00 },129{00 00 81 00 00 },1{00 00 01 00 00 },255{00 00 ff 00 00 },0{00 00 00 00 00 },0{00 00 00 00 00 },8{00 00 08 00 00 },56{00 00 38 00 00 },28{00 00 1c 00 00 },16{00 00 10 00 00 },0{00 00 00 00 00 },0{00 00 00 00 00 },0{00 00 00 00 00 },42{00 00 2a 00 00 },124{00 00 7c 00 00 },70{00 00 46 00 00 },68{00 00 44 00 00 },70{00 00 46 00 00 },124{00 00 7c 00 00 },0{00 00 00 00 00 },255{00 00 ff 00 00 },255{00 00 ff 00 00 },247{00 00 f7 00 00 },199{00 00 c7 00 00 },227{00 00 e3 00 00 },239{00 00 ef 00 00 },255{00 00 ff 00 00 },255{00 00 ff 00 00 },24{00 00 18 00 00 },60{00 00 3c 00 00 },90{00 00 5a 00 00 },255{00 00 ff 00 00 },219{00 00 db 00 00 },102{00 00 66 00 00 },60{00 00 3c 00 00 },24{00 00 18 00 00 },231{00 00 e7 00 00 },195{00 00 c3 00 00 },165{00 00 a5 00 00 },0{00 00 00 00 00 },36{00 00 24 00 00 },153{00 00 99 00 00 },195{00 00 c3 00 00 },231{00 00 e7 00 00 },255{00 00 ff 00 00 },213{00 00 d5 00 00 },131{00 00 83 00 00 },185{00 00 b9 00 00 },187{00 00 bb 00 00 },185{00 00 b9 00 00 },131{00 00 83 00 00 },255{00 00 ff 00 00 }
ZXBASIC_LINE_2000:
; 2000  REM Quick draw the level
ZXBASIC_LINE_2010:
; 2010  GOSUB 4000: IF s(1)=0 AND s(2)=0 THEN  LET l=0: RETURN 
; 		2010.1  GOSUB 4000{00 00 a0 0f 00 }
	CALL ZXBASIC_LINE_4000
; 		2010.2  IF s(1{00 00 01 00 00 })=0{00 00 00 00 00 } AND s(2{00 00 02 00 00 })=0{00 00 00 00 00 } THEN  LET l=0{00 00 00 00 00 }
; Array-Access
	LD HL,1
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,0
; =
	POP DE
	CALL runtimeCmpHLEqDE
	PUSH HL
; Array-Access
	LD HL,2
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,0
; =
	POP DE
	CALL runtimeCmpHLEqDE
; AND
	POP DE
	call runtimeAndHLDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_50
; 		2010.3  LET l=0{00 00 00 00 00 }
	LD HL,0
	LD (ZXBASIC_VAR_l),HL
; 		2010.4  RETURN 
	RET
ZXB_LABEL_50:
ZXBASIC_LINE_2020:
; 2020  LET last=0: LET i=1: PAPER 7: INK 0: CLS : FOR r=1 TO 17: FOR c=1 TO 19: REM fast
; 		2020.1  LET last=0{00 00 00 00 00 }
	LD HL,0
	LD (ZXBASIC_VAR_last),HL
; 		2020.2  LET i=1{00 00 01 00 00 }
	LD HL,1
	LD (ZXBASIC_VAR_i),HL
; 		2020.3  PAPER 7{00 00 07 00 00 }
	LD HL,7
	CALL runtimePaper
; 		2020.4  INK 0{00 00 00 00 00 }
	LD HL,0
	CALL runtimeInk
; 		2020.5  CLS 
	CALL runtimeCls
; 		2020.6  FOR r=1{00 00 01 00 00 } TO 17{00 00 11 00 00 }
	LD HL,1
	LD (ZXBASIC_VAR_r),HL
	LD HL,17
	LD (ZXBASIC_VAR_for_r),HL
FOR_5:
; 		2020.7  FOR c=1{00 00 01 00 00 } TO 19{00 00 13 00 00 }
	LD HL,1
	LD (ZXBASIC_VAR_c),HL
	LD HL,19
	LD (ZXBASIC_VAR_for_c),HL
FOR_6:
ZXBASIC_LINE_2030:
; 2030  GOSUB 3000
; 		2030.1  GOSUB 3000{00 00 b8 0b 00 }
	CALL ZXBASIC_LINE_3000
ZXBASIC_LINE_2040:
; 2040  NEXT c: NEXT r: LET i=0
; 		2040.1  NEXT c
	LD HL,(ZXBASIC_VAR_c)
	INC HL
	LD (ZXBASIC_VAR_c),HL
	LD DE,(ZXBASIC_VAR_for_c)
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_6
; 		2040.2  NEXT r
	LD HL,(ZXBASIC_VAR_r)
	INC HL
	LD (ZXBASIC_VAR_r),HL
	LD DE,(ZXBASIC_VAR_for_r)
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_5
; 		2040.3  LET i=0{00 00 00 00 00 }
	LD HL,0
	LD (ZXBASIC_VAR_i),HL
ZXBASIC_LINE_2050:
; 2050  IF m$(s(1),s(2))="\145" THEN  PRINT  AT s(1),s(2); INK 2; PAPER 5;"\148"
; 		2050.1  IF m$(s(1{00 00 01 00 00 }),s(2{00 00 02 00 00 }))="\145" THEN  PRINT  AT s(1{00 00 01 00 00 }),s(2{00 00 02 00 00 }); INK 2{00 00 02 00 00 }; PAPER 5{00 00 05 00 00 };"\148"
; Array-Access
	LD HL,1
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	LD HL,DE
	LD DE,19
	CALL runtimeMult16bit
	LD DE,HL
	LD HL,ZXBASIC_VAR_m_string
	ADD HL,DE
	PUSH HL
; Array-Access
	LD HL,2
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	LD HL,DE
	PUSH HL
	LD BC,HL
	POP DE
	POP HL
	CALL runtimePushFixedSubString
	LD DE,HL
	LD HL,STRING_34	;\91
; =
	CALL runtimeEqualString
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_51
; 		2050.2  PRINT  AT s(1{00 00 01 00 00 }),s(2{00 00 02 00 00 }); INK 2{00 00 02 00 00 }; PAPER 5{00 00 05 00 00 };"\148"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
; Array-Access
	LD HL,1
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
; Array-Access
	LD HL,2
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	LD HL,DE
	POP DE
	CALL runtimePrintAt
	LD HL,2
	CALL runtimeLocalInk
	LD HL,5
	CALL runtimeLocalPaper
	LD HL,STRING_41	;\94
	CALL runtimePrintString
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
ZXB_LABEL_51:
ZXBASIC_LINE_2060:
; 2060  IF m$(s(1),s(2))="\147" THEN  PRINT  AT s(1),s(2); INK 0; PAPER 2;"\149"
; 		2060.1  IF m$(s(1{00 00 01 00 00 }),s(2{00 00 02 00 00 }))="\147" THEN  PRINT  AT s(1{00 00 01 00 00 }),s(2{00 00 02 00 00 }); INK 0{00 00 00 00 00 }; PAPER 2{00 00 02 00 00 };"\149"
; Array-Access
	LD HL,1
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	LD HL,DE
	LD DE,19
	CALL runtimeMult16bit
	LD DE,HL
	LD HL,ZXBASIC_VAR_m_string
	ADD HL,DE
	PUSH HL
; Array-Access
	LD HL,2
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	LD HL,DE
	PUSH HL
	LD BC,HL
	POP DE
	POP HL
	CALL runtimePushFixedSubString
	LD DE,HL
	LD HL,STRING_36	;\93
; =
	CALL runtimeEqualString
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_52
; 		2060.2  PRINT  AT s(1{00 00 01 00 00 }),s(2{00 00 02 00 00 }); INK 0{00 00 00 00 00 }; PAPER 2{00 00 02 00 00 };"\149"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
; Array-Access
	LD HL,1
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
; Array-Access
	LD HL,2
	ADD HL,HL
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	LD DE,(HL)
	LD HL,DE
	POP DE
	CALL runtimePrintAt
	LD HL,0
	CALL runtimeLocalInk
	LD HL,2
	CALL runtimeLocalPaper
	LD HL,STRING_42	;\95
	CALL runtimePrintString
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
ZXB_LABEL_52:
ZXBASIC_LINE_2070:
; 2070  INK 1: PAPER 7: REM slow
; 		2070.1  INK 1{00 00 01 00 00 }
	LD HL,1
	CALL runtimeInk
; 		2070.2  PAPER 7{00 00 07 00 00 }
	LD HL,7
	CALL runtimePaper
ZXBASIC_LINE_2080:
; 2080  PRINT  AT 1,21;"Crates 'on'"; AT 4,21;"Moves: "; AT 7,21;"Pushes:"
; 		2080.1  PRINT  AT 1{00 00 01 00 00 },21{00 00 15 00 00 };"Crates 'on'"; AT 4{00 00 04 00 00 },21{00 00 15 00 00 };"Moves
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,1
	LD HL,21
	CALL runtimePrintAt
	LD HL,STRING_44	;Crates 'on'
	CALL runtimePrintString
	LD DE,4
	LD HL,21
	CALL runtimePrintAt
	LD HL,STRING_45	;Moves: 
	CALL runtimePrintString
	LD DE,7
	LD HL,21
	CALL runtimePrintAt
	LD HL,STRING_46	;Pushes:
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_2090:
; 2090  INK 0: RETURN 
; 		2090.1  INK 0{00 00 00 00 00 }
	LD HL,0
	CALL runtimeInk
; 		2090.2  RETURN 
	RET
ZXBASIC_LINE_3000:
; 3000  REM choose ink and paper colour
ZXBASIC_LINE_3005:
; 3005  LET cod= CODE m$(r,c)
; 		3005.1  LET cod= CODE m$(r,c)
; CODE
	LD HL,(ZXBASIC_VAR_r)
	LD DE,19
	CALL runtimeMult16bit
	LD DE,HL
	LD HL,ZXBASIC_VAR_m_string
	ADD HL,DE
	PUSH HL
	LD HL,(ZXBASIC_VAR_c)
	PUSH HL
	LD BC,HL
	POP DE
	POP HL
	CALL runtimePushFixedSubString
	CALL runtimeCode
	LD (ZXBASIC_VAR_cod),HL
ZXBASIC_LINE_3010:
; 3010  IF cod= 147 THEN  PAPER 7: INK 0: IF i THEN  LET targets=targets+1
; 		3010.1  IF cod= 147{00 00 93 00 00 } THEN  PAPER 7{00 00 07 00 00 }
	LD DE,(ZXBASIC_VAR_cod)
	LD HL,147
; =
	CALL runtimeCmpHLEqDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_53
; 		3010.2  PAPER 7{00 00 07 00 00 }
	LD HL,7
	CALL runtimePaper
; 		3010.3  INK 0{00 00 00 00 00 }
	LD HL,0
	CALL runtimeInk
; 		3010.4  IF i THEN  LET targets=targets+1{00 00 01 00 00 }
	LD HL,(ZXBASIC_VAR_i)
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_54
; 		3010.5  LET targets=targets+1{00 00 01 00 00 }
	LD HL,(ZXBASIC_VAR_targets)
	INC HL
; +
	LD (ZXBASIC_VAR_targets),HL
ZXB_LABEL_54:
ZXB_LABEL_53:
ZXBASIC_LINE_3020:
; 3020  IF cod=145 THEN  PAPER 5: INK 0
; 		3020.1  IF cod=145{00 00 91 00 00 } THEN  PAPER 5{00 00 05 00 00 }
	LD DE,(ZXBASIC_VAR_cod)
	LD HL,145
; =
	CALL runtimeCmpHLEqDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_55
; 		3020.2  PAPER 5{00 00 05 00 00 }
	LD HL,5
	CALL runtimePaper
; 		3020.3  INK 0{00 00 00 00 00 }
	LD HL,0
	CALL runtimeInk
ZXB_LABEL_55:
ZXBASIC_LINE_3030:
; 3030  IF cod=146 THEN  PAPER 5: INK 2
; 		3030.1  IF cod=146{00 00 92 00 00 } THEN  PAPER 5{00 00 05 00 00 }
	LD DE,(ZXBASIC_VAR_cod)
	LD HL,146
; =
	CALL runtimeCmpHLEqDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_56
; 		3030.2  PAPER 5{00 00 05 00 00 }
	LD HL,5
	CALL runtimePaper
; 		3030.3  INK 2{00 00 02 00 00 }
	LD HL,2
	CALL runtimeInk
ZXB_LABEL_56:
ZXBASIC_LINE_3040:
; 3040  IF cod=150 THEN  PAPER 2: INK 0: IF i THEN  LET targets=targets+1: LET cont=cont+1
; 		3040.1  IF cod=150{00 00 96 00 00 } THEN  PAPER 2{00 00 02 00 00 }
	LD DE,(ZXBASIC_VAR_cod)
	LD HL,150
; =
	CALL runtimeCmpHLEqDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_57
; 		3040.2  PAPER 2{00 00 02 00 00 }
	LD HL,2
	CALL runtimePaper
; 		3040.3  INK 0{00 00 00 00 00 }
	LD HL,0
	CALL runtimeInk
; 		3040.4  IF i THEN  LET targets=targets+1{00 00 01 00 00 }
	LD HL,(ZXBASIC_VAR_i)
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_58
; 		3040.5  LET targets=targets+1{00 00 01 00 00 }
	LD HL,(ZXBASIC_VAR_targets)
	INC HL
; +
	LD (ZXBASIC_VAR_targets),HL
; 		3040.6  LET cont=cont+1{00 00 01 00 00 }
	LD HL,(ZXBASIC_VAR_cont)
	INC HL
; +
	LD (ZXBASIC_VAR_cont),HL
ZXB_LABEL_58:
ZXB_LABEL_57:
ZXBASIC_LINE_3050:
; 3050  IF cod=144 THEN  PAPER 6: INK 1
; 		3050.1  IF cod=144{00 00 90 00 00 } THEN  PAPER 6{00 00 06 00 00 }
	LD DE,(ZXBASIC_VAR_cod)
	LD HL,144
; =
	CALL runtimeCmpHLEqDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_59
; 		3050.2  PAPER 6{00 00 06 00 00 }
	LD HL,6
	CALL runtimePaper
; 		3050.3  INK 1{00 00 01 00 00 }
	LD HL,1
	CALL runtimeInk
ZXB_LABEL_59:
ZXBASIC_LINE_3060:
; 3060  PRINT  AT r,c; CHR$ cod;: RETURN 
; 		3060.1  PRINT  AT r,c; CHR$ cod;
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,(ZXBASIC_VAR_r)
	LD HL,(ZXBASIC_VAR_c)
	CALL runtimePrintAt
; CHR$
	LD HL,(ZXBASIC_VAR_cod)
	CALL runtimeChr
	CALL runtimePrintString
	POP AF
	LD (ZX_P_FLAG),A
	CALL ZXFreeTempCompact
; 		3060.2  RETURN 
	RET
ZXBASIC_LINE_4000:
; 4000  REM Level data
ZXBASIC_LINE_4010:
; 4010  REM fast
ZXBASIC_LINE_4020:
; 4020  DIM o(3): DIM m$(17,19): DIM h$(1000): LET moves=0: LET pushes=0: LET targets=0: LET cont=0: REM cont=crates on targets
; 		4020.1  DIM o(3{00 00 03 00 00 })
	LD HL,ZXBASIC_VAR_o_array
	LD BC,8
	CALL runtimeClearArray
; 		4020.2  DIM m$(17{00 00 11 00 00 },19{00 00 13 00 00 })
	LD HL,ZXBASIC_VAR_m_string
	LD BC,360
	CALL runtimeClearStringArray
; 		4020.3  DIM h$(1000{00 00 e8 03 00 })
	LD HL,ZXBASIC_VAR_h_string
	LD BC,1001
	CALL runtimeClearStringArray
; 		4020.4  LET moves=0{00 00 00 00 00 }
	LD HL,0
	LD (ZXBASIC_VAR_moves),HL
; 		4020.5  LET pushes=0{00 00 00 00 00 }
	LD (ZXBASIC_VAR_pushes),HL
; 		4020.6  LET targets=0{00 00 00 00 00 }
	LD HL,0
	LD (ZXBASIC_VAR_targets),HL
; 		4020.7  LET cont=0{00 00 00 00 00 }
	LD (ZXBASIC_VAR_cont),HL
ZXBASIC_LINE_4030:
; 4030  LET b$="\144\144\144\144\144\144\144\144\144\144\144\144\144\144\144\144\144\144\144"
; 		4030.1  LET b$="\144\144\144\144\144\144\144\144\144\144\144\144\144\144\144\144\144\144\144"
	LD DE,STRING_47	;\90\90\90\90\90\90\90\90\90\90\90\90\90\90\90\90\90\90\90
	LD HL,ZXBASIC_VAR_b_string
	CALL runtimeStoreString
ZXBASIC_LINE_4040:
; 4040  IF l<0 OR l>50 THEN  STOP 
; 		4040.1  IF l<0{00 00 00 00 00 } OR l>50{00 00 32 00 00 } THEN  STOP 
	LD DE,(ZXBASIC_VAR_l)
	LD HL,0
; <
	CALL runtimeCmpHLltDE
	PUSH HL
	LD DE,(ZXBASIC_VAR_l)
	LD HL,50
; >
	CALL runtimeCmpHlGtDE
; OR
	POP DE
	call runtimeOrHLDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_60
; 		4040.2  STOP 
ZXB_LABEL_60:
ZXBASIC_LINE_4050:
; 4050  RESTORE 5000+l*10
; 		4050.1  RESTORE 5000{00 00 88 13 00 }+l*10{00 00 0a 00 00 }
	LD HL,5000
	PUSH HL
	LD DE,(ZXBASIC_VAR_l)
	LD HL,10
; *
	call runtimeMult16bit
; +
	POP DE
	ADD HL,DE
	LD DE,HL
	LD HL,ZXDATA
	CALL runtimeFindLine
	EX HL,DE
	LD (DATAPTR),DE
ZXBASIC_LINE_4060:
; 4060  FOR y=1 TO 17: LET m$(y)=b$: NEXT y: REM blank level
; 		4060.1  FOR y=1{00 00 01 00 00 } TO 17{00 00 11 00 00 }
	LD HL,1
	LD (ZXBASIC_VAR_y),HL
	LD HL,17
	LD (ZXBASIC_VAR_for_y),HL
FOR_7:
; 		4060.2  LET m$(y)=b$
	LD HL,(ZXBASIC_VAR_y)
	LD DE,19
	CALL runtimeMult16bit
	LD DE,HL
	LD HL,ZXBASIC_VAR_m_string
	ADD HL,DE
	LD DE,HL
	LD HL,(ZXBASIC_VAR_b_string)
	LD BC,19
	CALL runtimeStoreStringVarFix
	CALL ZXFreeTempCompact
; 		4060.3  NEXT y
	LD HL,(ZXBASIC_VAR_y)
	INC HL
	LD (ZXBASIC_VAR_y),HL
	LD DE,(ZXBASIC_VAR_for_y)
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_7
ZXBASIC_LINE_4070:
; 4070  READ index: DIM s(2): IF index=-1 THEN  RETURN 
; 		4070.1  READ index
	LD HL,(DATAPTR)
	LD DE,(HL)
	INC HL
	INC HL
	LD (DATAPTR),HL
	LD (ZXBASIC_VAR_index),DE
; 		4070.2  DIM s(2{00 00 02 00 00 })
	LD HL,ZXBASIC_VAR_s_array
	LD BC,6
	CALL runtimeClearArray
; 		4070.3  IF index=-1{00 00 01 00 00 } THEN  RETURN 
	LD HL,(ZXBASIC_VAR_index)
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
	JP Z,ZXB_LABEL_61
; 		4070.4  RETURN 
	RET
ZXB_LABEL_61:
ZXBASIC_LINE_4080:
; 4080  READ y,x: LET s(1)=y: LET s(2)=x: FOR n=1 TO index: READ y$: LET y= CODE y$(1)-96: LET f= CODE y$(2)-96: LET y$=y$(3 TO ): LET m$(y,f TO f+ LEN y$-1)=y$:  NEXT n
; 		4080.1  READ y,x
	LD HL,(DATAPTR)
	LD DE,(HL)
	INC HL
	INC HL
	LD (DATAPTR),HL
	LD (ZXBASIC_VAR_y),DE
	LD HL,(DATAPTR)
	LD DE,(HL)
	INC HL
	INC HL
	LD (DATAPTR),HL
	LD (ZXBASIC_VAR_x),DE
; 		4080.2  LET s(1{00 00 01 00 00 })=y
	LD HL,1
	ADD HL,HL
	PUSH HL
	LD DE,(ZXBASIC_VAR_y)
	POP HL
	LD BC,ZXBASIC_VAR_s_array
	ADD HL,BC
	LD (HL),DE
; 		4080.3  LET s(2{00 00 02 00 00 })=x
	LD HL,2
	ADD HL,HL
	PUSH HL
	LD DE,(ZXBASIC_VAR_x)
	POP HL
	LD BC,ZXBASIC_VAR_s_array
	ADD HL,BC
	LD (HL),DE
; 		4080.4  FOR n=1{00 00 01 00 00 } TO index
	LD HL,1
	LD (ZXBASIC_VAR_n),HL
	LD HL,(ZXBASIC_VAR_index)
	LD (ZXBASIC_VAR_for_n),HL
FOR_8:
; 		4080.5  READ y$
	LD HL,ZXBASIC_VAR_y_string
	CALL ZXFreeStringVar
	LD HL,(DATAPTR)
	LD (ZXBASIC_VAR_y_string),HL
	LD BC,(HL)
	INC HL
	INC HL
	ADD HL,BC
	LD (DATAPTR),HL
; 		4080.6  LET y= CODE y$(1{00 00 01 00 00 })-96{00 00 60 00 00 }
; CODE
	LD HL,(ZXBASIC_VAR_y_string)
	PUSH HL
	LD HL,1
	POP BC
	CALL runtimeCharAt
	CALL runtimeCode
	LD DE,96
; -
	SUB HL,DE
	LD (ZXBASIC_VAR_y),HL
	CALL ZXFreeTempCompact
; 		4080.7  LET f= CODE y$(2{00 00 02 00 00 })-96{00 00 60 00 00 }
; CODE
	LD HL,(ZXBASIC_VAR_y_string)
	PUSH HL
	LD HL,2
	POP BC
	CALL runtimeCharAt
	CALL runtimeCode
	LD DE,96
; -
	SUB HL,DE
	LD (ZXBASIC_VAR_f),HL
	CALL ZXFreeTempCompact
; 		4080.8  LET y$=y$(3{00 00 03 00 00 } TO )
	LD HL,(ZXBASIC_VAR_y_string)
	PUSH HL
	LD DE,3
	LD HL,-1
	POP BC
	CALL runtimeSubstring
	LD DE,HL
	LD HL,ZXBASIC_VAR_y_string
	CALL runtimeStoreString
; 		4080.9  LET m$(y,f TO f+ LEN y$-1{00 00 01 00 00 })=y$
	LD HL,(ZXBASIC_VAR_y)
	LD DE,19
	CALL runtimeMult16bit
	LD DE,HL
	LD HL,ZXBASIC_VAR_m_string
	ADD HL,DE
	PUSH HL
	LD HL,(ZXBASIC_VAR_f)
	PUSH HL
	LD HL,(ZXBASIC_VAR_f)
	PUSH HL
; LEN
	LD HL,(ZXBASIC_VAR_y_string)
	CALL runtimeLen
; +
	POP DE
	ADD HL,DE
	LD DE,1
; -
	SUB HL,DE
	PUSH HL
	LD HL,(ZXBASIC_VAR_y_string)
	CALL runtimeStoreFixedStringWithRangeFromBstr
	CALL ZXFreeTempCompact
; 		4080.10  NEXT n
	LD HL,(ZXBASIC_VAR_n)
	INC HL
	LD (ZXBASIC_VAR_n),HL
	LD DE,(ZXBASIC_VAR_for_n)
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_8
ZXBASIC_LINE_4090:
; 4090  REM slow
ZXBASIC_LINE_4100:
; 4100  RETURN 
; 		4100.1  RETURN 
	RET
ZXBASIC_LINE_5000:
; 5000  DATA 26,2,2,"bb\145\145\145\145\145\145\145\145\145\145\145\145\145\145\145\145\145","ib\145\145\145\145\145\145\145\145\145\145\145\145\145\145\145\145\145","pb\145\145\145\145\145\145\145\145\145\145\145\145\145\145\145\145\145","cb\145","cf\145","cj\145\144\146\144\145","cr\145","db\145\144\147\146\145\144\145\144\145\144\147\144\145\144\145\144\145","eb\145","ef\145\144\145\144\145\144\144\145\145\144\145\144\145","fb\145\145\145\144\145\144\145\144\145\144\145\144\145\144\145\144\145","gb\145\145\145\144\145\144\145\144\145\144\145\144\145\144\145\144\145","hb\145","hf\145","hj\145\144\145\144\145","hr\145","jb\145","jf\147\145\145\144\144\145\145\144\145\145\146\144\145","kb\145\144\145\145\144\145\144\145\145\144\145\144\144\145\145\144\145","lb\145","lf\145\145","ll\145\144\147\144\145\144\145","mb\145\144\145\145\144\145\144\147\147\144\145\144\145\145\144\144\145","nb\145\144\145\145\144\145\144\146\146\144\145\144\147\146\144\144\145","ob\145","of\145\145\144\145\145\144\145\144\146\145\145\144\145"
; 		5000.1  DATA 26{00 00 1a 00 00 },2{00 00 02 00 00 },2{00 00 02 00 00 },"bb\145\145\145\145\145\145\145\145\145\145\145\145\145\145\145\145\145","ib\145\145\145\145\145\145\145\145\145\145\145\145\145\145\145\145\145","pb\145\145\145\145\145\145\145\145\145\145\145\145\145\145\145\145\145","cb\145","cf\145","cj\145\144\146\144\145","cr\145","db\145\144\147\146\145\144\145\144\145\144\147\144\145\144\145\144\145","eb\145","ef\145\144\145\144\145\144\144\145\145\144\145\144\145","fb\145\145\145\144\145\144\145\144\145\144\145\144\145\144\145\144\145","gb\145\145\145\144\145\144\145\144\145\144\145\144\145\144\145\144\145","hb\145","hf\145","hj\145\144\145\144\145","hr\145","jb\145","jf\147\145\145\144\144\145\145\144\145\145\146\144\145","kb\145\144\145\145\144\145\144\145\145\144\145\144\144\145\145\144\145","lb\145","lf\145\145","ll\145\144\147\144\145\144\145","mb\145\144\145\145\144\145\144\147\147\144\145\144\145\145\144\144\145","nb\145\144\145\145\144\145\144\146\146\144\145\144\147\146\144\144\145","ob\145","of\145\145\144\145\145\144\145\144\146\145\145\144\145"
ZXBASIC_LINE_5010:
; 5010  DATA 10,11,12,"df\145\145\145","ef\146\145\145","ff\145\145\146","gd\145\145\146\145\146\145","hd\145\144\145\144\144\145","ib\145\145\145\144\145\144\144\145","io\145\145\147\147","jb\145\146\145\145\146\145\145\145\145\145\145\145\145\145\145\147\147","kf\145\144\144\144\145\144\145\144\144\145\145\147\147","lf\145\145\145\145\145"
; 		5010.1  DATA 10{00 00 0a 00 00 },11{00 00 0b 00 00 },12{00 00 0c 00 00 },"df\145\145\145","ef\146\145\145","ff\145\145\146","gd\145\145\146\145\146\145","hd\145\144\145\144\144\145","ib\145\145\145\144\145\144\144\145","io\145\145\147\147","jb\145\146\145\145\146\145\145\145\145\145\145\145\145\145\145\147\147","kf\145\144\144\144\145\144\145\144\144\145\145\147\147","lf\145\145\145\145\145"
ZXBASIC_LINE_5020:
; 5020  DATA 8,8,11,"ee\147\147\145\145\144\145\145\145\145\145","fe\147\147\145\145\144\145\146\145\145\146\145\145","ge\147\147\145\145\144\146\144\144\144\144\145\145","he\147\147\145\145\145\145\145\145\144\144\145\145","ie\147\147\145\145\144\145\144\145\145\146\145","jj\145\144\144\146\145\146\145","kg\145\146\145\145\146\145\146\145\146\145","lg\145\145\145\145\144\145\145\145\145\145"
; 		5020.1  DATA 8{00 00 08 00 00 },8{00 00 08 00 00 },11{00 00 0b 00 00 },"ee\147\147\145\145\144\145\145\145\145\145","fe\147\147\145\145\144\145\146\145\145\146\145\145","ge\147\147\145\145\144\146\144\144\144\144\145\145","he\147\147\145\145\145\145\145\145\144\144\145\145","ie\147\147\145\145\144\145\144\145\145\146\145","jj\145\144\144\146\145\146\145","kg\145\146\145\145\146\145\146\145\146\145","lg\145\145\145\145\144\145\145\145\145\145"
ZXBASIC_LINE_5030:
; 5030  DATA 9,5,16,"ek\145\145\145\145\145\145","fk\145\146\144\146\145","gk\145\146\145\145\146","hl\146\145\146\145","ik\145\146\145\144\145","jc\147\147\147\147\145\145","jk\145\146\145\145\146\145\145","kd\147\147\147\145\145\145\145\146\145\145\146\145\145\145","lc\147\147\147\147\145\145"
; 		5030.1  DATA 9{00 00 09 00 00 },5{00 00 05 00 00 },16{00 00 10 00 00 },"ek\145\145\145\145\145\145","fk\145\146\144\146\145","gk\145\146\145\145\146","hl\146\145\146\145","ik\145\146\145\144\145","jc\147\147\147\147\145\145","jk\145\146\145\145\146\145\145","kd\147\147\147\145\145\145\145\146\145\145\146\145\145\145","lc\147\147\147\147\145\145"
ZXBASIC_LINE_5040:
; 5040  DATA 12,13,11,"cm\145\145\147\147\147\147","dm\145\145\147\147\147\147","eb\145\145\145\145\144\145\145\146\145\146\145\145\145\147\147\147\147","fb\145\146\146\146\144\146\145\145\146\145\144\145\145\147\147\147\147","gb\145\145\146\145\145\145\145\145\146\145\144\145\145\147\147\147\147","hb\145\146\146\145\144\146\145\146\145\146","ib\145\145\146\145\144\145\145\145\145\145","jc\145","kb\145\145\145\145\144\145\145\145\145","lb\145\145\145\145\145\146\145\145\145","mb\145\145\146\146\144\146\146\145\145\145","nb\145\145\145\145\144\145\145\145\145"
; 		5040.1  DATA 12{00 00 0c 00 00 },13{00 00 0d 00 00 },11{00 00 0b 00 00 },"cm\145\145\147\147\147\147","dm\145\145\147\147\147\147","eb\145\145\145\145\144\145\145\146\145\146\145\145\145\147\147\147\147","fb\145\146\146\146\144\146\145\145\146\145\144\145\145\147\147\147\147","gb\145\145\146\145\145\145\145\145\146\145\144\145\145\147\147\147\147","hb\145\146\146\145\144\146\145\146\145\146","ib\145\145\146\145\144\145\145\145\145\145","jc\145","kb\145\145\145\145\144\145\145\145\145","lb\145\145\145\145\145\146\145\145\145","mb\145\145\146\146\144\146\146\145\145\145","nb\145\145\145\145\144\145\145\145\145"
ZXBASIC_LINE_5050:
; 5050  DATA 11,10,16,"dk\145\145\145","ek\145\144\146\144\144\145\145","fk\145\145\145\145\145\146\145","gk\145\144\144\144\145\145\145","hc\147\147\147\147\145\145\144\144\145\146\145\145\146","ic\147\147\147\147\145\145\145\145\146\145\146\146\145","jc\147\147\147\147\145\145\144\144\146\145\145\146\145\145","kk\145\145\146\145\145","lk\145\146\145\146\145\145","mm\145\144\144\145","nm\145\145\145\145"
; 		5050.1  DATA 11{00 00 0b 00 00 },10{00 00 0a 00 00 },16{00 00 10 00 00 },"dk\145\145\145","ek\145\144\146\144\144\145\145","fk\145\145\145\145\145\146\145","gk\145\144\144\144\145\145\145","hc\147\147\147\147\145\145\144\144\145\146\145\145\146","ic\147\147\147\147\145\145\145\145\146\145\146\146\145","jc\147\147\147\147\145\145\144\144\146\145\145\146\145\145","kk\145\145\146\145\145","lk\145\146\145\146\145\145","mm\145\144\144\145","nm\145\145\145\145"
ZXBASIC_LINE_5060:
; 5060  DATA 12,5,13,"ee\147\147\145\145","em\145","fe\147\147\145\145","fl\145\145\145","ge\147\147\145\145\145\145\145\146\146\145","he\147\147\145\145\144\145\144\145\146\145","ie\147\147","ij\145\144\145\146\145","jh\145\146\145\144\146\145\145","kh\145\145\146\144\145\146\145","lh\145\146\145\145\146\145\145","mh\145\145\144\144\145\145\145"
; 		5060.1  DATA 12{00 00 0c 00 00 },5{00 00 05 00 00 },13{00 00 0d 00 00 },"ee\147\147\145\145","em\145","fe\147\147\145\145","fl\145\145\145","ge\147\147\145\145\145\145\145\146\146\145","he\147\147\145\145\144\145\144\145\146\145","ie\147\147","ij\145\144\145\146\145","jh\145\146\145\144\146\145\145","kh\145\145\146\144\145\146\145","lh\145\146\145\145\146\145\145","mh\145\145\144\144\145\145\145"
ZXBASIC_LINE_5070:
; 5070  DATA 15,5,9,"dl\145\145\145","ef\145\144\145\145\144\144\145\146\146\145","fe\145\145\145\145\146\145\145\145\145\145\145","ge\145\145\146\145\145","gm\145\145\145","hg\145","hm\146","ie\145\146\145\145","il\145\147\147","je\145\146\145\146\145\146\145\147\147\147","ke\145\145\145\145","kl\147\147\147","le\145\146\146\145","ll\147\147\147","me\145\145"
; 		5070.1  DATA 15{00 00 0f 00 00 },5{00 00 05 00 00 },9{00 00 09 00 00 },"dl\145\145\145","ef\145\144\145\145\144\144\145\146\146\145","fe\145\145\145\145\146\145\145\145\145\145\145","ge\145\145\146\145\145","gm\145\145\145","hg\145","hm\146","ie\145\146\145\145","il\145\147\147","je\145\146\145\146\145\146\145\147\147\147","ke\145\145\145\145","kl\147\147\147","le\145\146\146\145","ll\147\147\147","me\145\145"
ZXBASIC_LINE_5080:
; 5080  DATA 15,7,3,"be\145\145","ce\145\145\145\145\146\145\145\145\146\145\146\145","de\145\146\144\145\146\145\144\145\145\146\145\145","ee\145\145\146\145\146\145\145\144\145\145\145\145","fe\145\146\144\145\144\145\145","fp\145","gc\145\144\146\145\146\145\146\145\145\144\144\145\145\145","hc\145\145\145\145\146\145\144\146\144\145\145\145\144\145","ic\145\145\145\146\145\145\145\145\146\145\146\145\146\145","jg\145\145","ke\145\145\145\145\145\145","le\145\145\145\145\145\145","me\147\147\147\147\147\147","ne\147\147\147\147\147\147","oe\147\147\147\147\147\147"
; 		5080.1  DATA 15{00 00 0f 00 00 },7{00 00 07 00 00 },3{00 00 03 00 00 },"be\145\145","ce\145\145\145\145\146\145\145\145\146\145\146\145","de\145\146\144\145\146\145\144\145\145\146\145\145","ee\145\145\146\145\146\145\145\144\145\145\145\145","fe\145\146\144\145\144\145\145","fp\145","gc\145\144\146\145\146\145\146\145\145\144\144\145\145\145","hc\145\145\145\145\146\145\144\146\144\145\145\145\144\145","ic\145\145\145\146\145\145\145\145\146\145\146\145\146\145","jg\145\145","ke\145\145\145\145\145\145","le\145\145\145\145\145\145","me\147\147\147\147\147\147","ne\147\147\147\147\147\147","oe\147\147\147\147\147\147"
ZXBASIC_LINE_5090:
; 5090  DATA 12,12,3,"cm\145\145\147\147\147","dm\145\145\147\147\147","ei\145\145\145\145\145\145\147\145\147","fi\145\145\144\144\145\145\147\147\147","gj\145\144\144\145\145\147\147\147","hj\145","ih\145\146\146\146\145","jh\145\145\146\145\146\145","kd\145\145\145\144\146\145\146\145\145\145\144\145\145\145","lc\145\145\146\145\145\146\145\145\145\145\146\145\145\146\145","mh\145\146\146\145\146\145","nh\145\145\145\145\145\145"
; 		5090.1  DATA 12{00 00 0c 00 00 },12{00 00 0c 00 00 },3{00 00 03 00 00 },"cm\145\145\147\147\147","dm\145\145\147\147\147","ei\145\145\145\145\145\145\147\145\147","fi\145\145\144\144\145\145\147\147\147","gj\145\144\144\145\145\147\147\147","hj\145","ih\145\146\146\146\145","jh\145\145\146\145\146\145","kd\145\145\145\144\146\145\146\145\145\145\144\145\145\145","lc\145\145\146\145\145\146\145\145\145\145\146\145\145\146\145","mh\145\146\146\145\146\145","nh\145\145\145\145\145\145"
ZXBASIC_LINE_5100:
; 5100  DATA 18,2,3,"bc\145","bh\145\145\145\145\145\145\145\144\145\145\145","cb\145\146\146\145\145\145\146\146\145\145\146\145\146\145\147\147\147","db\145\145\146\146\146\144\145\145\145\145\146\145\145\144\147\147\147","eb\145\146\145\145\145\144\145\146\146\145\146\146\145\144\147\147\147","fd\145\145\145\144\145\145\146\145\145\145\145\144\147\147\147","gb\145\145\145\145\145\144\145\146\145\146\145\146\145\144\147\147\147","hb\145\145\145\145","hl\145","hp\147\147\147","ic\145\144\145\145\144\145\145\146\145\146\145\145\144\147\147\147","jb\145\145\144\144\145\144\145\146\146\145\146\145\146\144\144\147\147","kb\145\147\147\144\145\144\145\145\146\145\145\145\145\145\145\144\147","lb\145\147\147\144\145\144\145\146\146\146\145\146\146\146\145\144\147","mf\145\144\145\145\145\145\145\145\145\144\145\144\147","nf\145","np\145\144\147","of\145\145\145\145\145\145\145\145\145\145\145\144\147"
; 		5100.1  DATA 18{00 00 12 00 00 },2{00 00 02 00 00 },3{00 00 03 00 00 },"bc\145","bh\145\145\145\145\145\145\145\144\145\145\145","cb\145\146\146\145\145\145\146\146\145\145\146\145\146\145\147\147\147","db\145\145\146\146\146\144\145\145\145\145\146\145\145\144\147\147\147","eb\145\146\145\145\145\144\145\146\146\145\146\146\145\144\147\147\147","fd\145\145\145\144\145\145\146\145\145\145\145\144\147\147\147","gb\145\145\145\145\145\144\145\146\145\146\145\146\145\144\147\147\147","hb\145\145\145\145","hl\145","hp\147\147\147","ic\145\144\145\145\144\145\145\146\145\146\145\145\144\147\147\147","jb\145\145\144\144\145\144\145\146\146\145\146\145\146\144\144\147\147","kb\145\147\147\144\145\144\145\145\146\145\145\145\145\145\145\144\147","lb\145\147\147\144\145\144\145\146\146\146\145\146\146\146\145\144\147","mf\145\144\145\145\145\145\145\145\145\144\145\144\147","nf\145","np\145\144\147","of\145\145\145\145\145\145\145\145\145\145\145\144\147"
ZXBASIC_LINE_5110:
; 5110  DATA 15,4,8,"cl\145\145","dg\145\145","dl\146\145","ee\145\145\145\145\145\145\146\145\145","fd\145\145\146\145\146\146\144\144\145","gc\145\145\144\146\144\144\145\145\145\145\145","hc\145\144\145\146\145\146\146\145\144\145","ic\145\145\145\146\145\144\145\145\144\145\146\145","je\145\145\145\145\144\145\145\146\146\145\144\145\145\145","ke\145\144\144\145\146\145\145\145\145\145\145\145\145\145","lb\147\145\145\145\145","lj\145\145","mb\147\147\145\147\147","nb\147\147\147\144\147","ob\147\147\147\147\147"
; 		5110.1  DATA 15{00 00 0f 00 00 },4{00 00 04 00 00 },8{00 00 08 00 00 },"cl\145\145","dg\145\145","dl\146\145","ee\145\145\145\145\145\145\146\145\145","fd\145\145\146\145\146\146\144\144\145","gc\145\145\144\146\144\144\145\145\145\145\145","hc\145\144\145\146\145\146\146\145\144\145","ic\145\145\145\146\145\144\145\145\144\145\146\145","je\145\145\145\145\144\145\145\146\146\145\144\145\145\145","ke\145\144\144\145\146\145\145\145\145\145\145\145\145\145","lb\147\145\145\145\145","lj\145\145","mb\147\147\145\147\147","nb\147\147\147\144\147","ob\147\147\147\147\147"
ZXBASIC_LINE_5120:
; 5120  DATA 14,7,9,"dc\145\145\145\145\145\145\145\145\145\145\145\145\145\145","ec\145\144\145","el\145\145\145\145\145","fc\145\144\145\145\146\145\146\145\146\145\146\144\145\145","gc\145\144\145\145\145\146\145\146\145\145\145\144\144\145","hc\145\144\145\145\146\145\146\145\146","ho\147\147\147","ic\145\144\145\145\145\146\145\146\145\145\144\144\147\147\147","jc\145","jg\146\146\146\145\146\145\144\144\147\147\147","kc\145\145\145\145\145\144\145\144\144\145\144\144\147\147\147","lg\145\145\145\144\144\145\144\144\147\147\147","mk\145\145\145\145\145","nk\145\145\145\145\145"
; 		5120.1  DATA 14{00 00 0e 00 00 },7{00 00 07 00 00 },9{00 00 09 00 00 },"dc\145\145\145\145\145\145\145\145\145\145\145\145\145\145","ec\145\144\145","el\145\145\145\145\145","fc\145\144\145\145\146\145\146\145\146\145\146\144\145\145","gc\145\144\145\145\145\146\145\146\145\145\145\144\144\145","hc\145\144\145\145\146\145\146\145\146","ho\147\147\147","ic\145\144\145\145\145\146\145\146\145\145\144\144\147\147\147","jc\145","jg\146\146\146\145\146\145\144\144\147\147\147","kc\145\145\145\145\145\144\145\144\144\145\144\144\147\147\147","lg\145\145\145\144\144\145\144\144\147\147\147","mk\145\145\145\145\145","nk\145\145\145\145\145"
ZXBASIC_LINE_5130:
; 5130  DATA 12,7,7,"de\145\145\145\144\144\145\145","ed\145\145\145\145\145\144\145\145\144\145\145\145\145","fb\145\145\146\145\144\146\145\144\145\145\144\145\145\147\147\147\145","gb\145\144\145\146\144\145\146\144\144\145\144\145\144\147\144\147\145","hb\145\145\144\145\144\146\145\145\144\145\145\145\145\147\145\147\145","ib\145\146\145\145\145\145\146\145\144\145\144\145\144\147\144\147\145","jb\145\145\145\144\144\145\145\144\144\146\145\146\145\147\145\147\145","kb\145\146\145\144\145\145\145\144\145\145\144\146\144\147\144\147\145","lc\145\146\145\145\146\145\145\145\146\145\145\146\147\147\147\145","mc\146\145","mk\145\145\145\145\144\144\145\145","nc\145\145"
; 		5130.1  DATA 12{00 00 0c 00 00 },7{00 00 07 00 00 },7{00 00 07 00 00 },"de\145\145\145\144\144\145\145","ed\145\145\145\145\145\144\145\145\144\145\145\145\145","fb\145\145\146\145\144\146\145\144\145\145\144\145\145\147\147\147\145","gb\145\144\145\146\144\145\146\144\144\145\144\145\144\147\144\147\145","hb\145\145\144\145\144\146\145\145\144\145\145\145\145\147\145\147\145","ib\145\146\145\145\145\145\146\145\144\145\144\145\144\147\144\147\145","jb\145\145\145\144\144\145\145\144\144\146\145\146\145\147\145\147\145","kb\145\146\145\144\145\145\145\144\145\145\144\146\144\147\144\147\145","lc\145\146\145\145\146\145\145\145\146\145\145\146\147\147\147\145","mc\146\145","mk\145\145\145\145\144\144\145\145","nc\145\145"
ZXBASIC_LINE_5140:
; 5140  DATA 20,3,11,"bi\145\145\145\145\145","cc\145\145\145\145\145\144\145\146\145\146\145","dc\146\146\145\144\145\145\145","ec\145","eg\147\147\147\147\147\147\144\144\145\145\145","fc\145\145\145\146\147\147\147\147\147\147\144\144\145\144\145","gc\145","gg\147\147\147\147\147\147\145\145\145\145\145","hc\145\145\145","hj\145","hn\145\144\146","ib\145\145\144\146\145\145\145\144\145\145\146\145\145\144\145","jb\145\145\146\145\146\146\146\145\145\144\145\146\144\144\145","kb\145\145\145\146\145\146\145","kl\146\146\145\144\145","lf\145\145\145\145\145\146\145\145\145\144\145","mh\145","ml\145\145\145\144\145","nh\145\145\145\145\145\144\145\145\145","oo\145\145"
; 		5140.1  DATA 20{00 00 14 00 00 },3{00 00 03 00 00 },11{00 00 0b 00 00 },"bi\145\145\145\145\145","cc\145\145\145\145\145\144\145\146\145\146\145","dc\146\146\145\144\145\145\145","ec\145","eg\147\147\147\147\147\147\144\144\145\145\145","fc\145\145\145\146\147\147\147\147\147\147\144\144\145\144\145","gc\145","gg\147\147\147\147\147\147\145\145\145\145\145","hc\145\145\145","hj\145","hn\145\144\146","ib\145\145\144\146\145\145\145\144\145\145\146\145\145\144\145","jb\145\145\146\145\146\146\146\145\145\144\145\146\144\144\145","kb\145\145\145\146\145\146\145","kl\146\146\145\144\145","lf\145\145\145\145\145\146\145\145\145\144\145","mh\145","ml\145\145\145\144\145","nh\145\145\145\145\145\144\145\145\145","oo\145\145"
ZXBASIC_LINE_5150:
; 5150  DATA 16,6,8,"bf\145\145\145\144\145\145","cf\145\145\146\145\145\145","df\145\144\146\145\145\145","ed\145\145\146\145\145\144\144\146\145\145\145","fd\145\145\144\145\145\145\146\145\144\145\146","gd\145\145\144\145\145\145\145\145\145\146\145","he\145","hj\146\144\144\145\145\145\145\145","id\145\146\144\147\147\147\147\147\144\145\144\145\145\145","jd\145\145\146\147\147\150\150\147\145\146\144\145","kd\145\145\144\147\147\147\147\147\144\145\145\145","lc\145\145\145","lh\145","mc\145\146\146\145\145\144\145\145","nc\145\145\144\145\145\145\145\145","oh\145\145\145"
; 		5150.1  DATA 16{00 00 10 00 00 },6{00 00 06 00 00 },8{00 00 08 00 00 },"bf\145\145\145\144\145\145","cf\145\145\146\145\145\145","df\145\144\146\145\145\145","ed\145\145\146\145\145\144\144\146\145\145\145","fd\145\145\144\145\145\145\146\145\144\145\146","gd\145\145\144\145\145\145\145\145\145\146\145","he\145","hj\146\144\144\145\145\145\145\145","id\145\146\144\147\147\147\147\147\144\145\144\145\145\145","jd\145\145\146\147\147\150\150\147\145\146\144\145","kd\145\145\144\147\147\147\147\147\144\145\145\145","lc\145\145\145","lh\145","mc\145\146\146\145\145\144\145\145","nc\145\145\144\145\145\145\145\145","oh\145\145\145"
ZXBASIC_LINE_5160:
; 5160  DATA 14,7,7,"ce\145\145\145","de\145\145\145\145","ee\145\146\145\145","em\145\145","fe\145\145\146\146\145\146\145\145\145\146","gg\145\145\144\146\145\145\145\145","hf\145\145\144\144\145\145\146\145\146\145","if\145\146\145\145\144\144\145\144\144\145\147","jf\145\145\144\146\144\144\146\145\145\144\147","kh\145\145\145\146\147\147\144\144\147","lg\145\145\145\145\144\147\150\147\147\147","mg\145\146\146\145\144\147\147\147\147\147","ng\145\145","og\145\145"
; 		5160.1  DATA 14{00 00 0e 00 00 },7{00 00 07 00 00 },7{00 00 07 00 00 },"ce\145\145\145","de\145\145\145\145","ee\145\146\145\145","em\145\145","fe\145\145\146\146\145\146\145\145\145\146","gg\145\145\144\146\145\145\145\145","hf\145\145\144\144\145\145\146\145\146\145","if\145\146\145\145\144\144\145\144\144\145\147","jf\145\145\144\146\144\144\146\145\145\144\147","kh\145\145\145\146\147\147\144\144\147","lg\145\145\145\145\144\147\150\147\147\147","mg\145\146\146\145\144\147\147\147\147\147","ng\145\145","og\145\145"
ZXBASIC_LINE_5170:
; 5170  DATA 14,12,5,"cg\147\147\145\145\144\145\145\145","dg\147\147\145\145\145\145\145\145","eg\147\147\145\145\144\145\145","fl\145\145\144\145\145","gf\145\145\145\145\145\145\145\145\145\145\145\145","hf\145\145\144\145\145\144\144\145\145\144\145\145","ig\145\144\144\145\145","ip\145","jd\145\145\146\145\145","jn\145\144\145\145","kd\145\144\145\146\145\145\146\145\145\144\145\146\145\145","ld\145\145\146\145\145\146\145\145\145\144\145\145\145","mg\145\144\144\145","ng\145\145\145\145"
; 		5170.1  DATA 14{00 00 0e 00 00 },12{00 00 0c 00 00 },5{00 00 05 00 00 },"cg\147\147\145\145\144\145\145\145","dg\147\147\145\145\145\145\145\145","eg\147\147\145\145\144\145\145","fl\145\145\144\145\145","gf\145\145\145\145\145\145\145\145\145\145\145\145","hf\145\145\144\145\145\144\144\145\145\144\145\145","ig\145\144\144\145\145","ip\145","jd\145\145\146\145\145","jn\145\144\145\145","kd\145\144\145\146\145\145\146\145\145\144\145\146\145\145","ld\145\145\146\145\145\146\145\145\145\144\145\145\145","mg\145\144\144\145","ng\145\145\145\145"
ZXBASIC_LINE_5180:
; 5180  DATA 13,5,14,"dg\145\145\147\145\145\144\145\145\145","eg\145\144\147\145\145\145\145\145\145","fg\145\144\144\147\147\144\145","gc\145\145\144\145\147\147","gl\145\145\145\145\145","hb\145\146\145\144\147\147\147\145\145\145\146\145\144\145\145\146\145","ib\145\145\145\145\147\147\145\144\144\145\145\144\144\145\144\144\145","je\146\144\144\146\144\145\146\145\144\145\145\145\144\145","ke\145\144\145\145\145\145\144\146\145\146\146\145\144\145","ld\145\145\146\145\144\145\144\145\145\144\145\146\144\144\145","md\145\145\145\145\145\145\145\145\145\145\145\145\145\145\145","nd\145\145","nq\145\145"
; 		5180.1  DATA 13{00 00 0d 00 00 },5{00 00 05 00 00 },14{00 00 0e 00 00 },"dg\145\145\147\145\145\144\145\145\145","eg\145\144\147\145\145\145\145\145\145","fg\145\144\144\147\147\144\145","gc\145\145\144\145\147\147","gl\145\145\145\145\145","hb\145\146\145\144\147\147\147\145\145\145\146\145\144\145\145\146\145","ib\145\145\145\145\147\147\145\144\144\145\145\144\144\145\144\144\145","je\146\144\144\146\144\145\146\145\144\145\145\145\144\145","ke\145\144\145\145\145\145\144\146\145\146\146\145\144\145","ld\145\145\146\145\144\145\144\145\145\144\145\146\144\144\145","md\145\145\145\145\145\145\145\145\145\145\145\145\145\145\145","nd\145\145","nq\145\145"
ZXBASIC_LINE_5190:
; 5190  DATA 18,2,7,"bd\145\145\145\145","cf\145\146\145\145\145","db\145\145\145\144\144\145\145\145\145","eb\145\146\145\144\145\145\144\144\145\145\145\145","fb\145\146\145\144\145\145","fm\145","gc\145\146\145\145\146\145\145\145\145\144\145","hc\145\146\145\146\145","hk\145\144\145","ic\145\144\145\145\146\145\145\144\145\144\145","jc\145\144\145\144\146\144\145\145\145\144\145","kc\145","kg\145\145\145\144\145\144\145","lb\145\145\146\145\145","lk\145\144\145\144\147\147\147\147","mb\145\145\145\145\146\145\145\145\145\146\145\145\145\147\147\144\147","ne\146\145\145\146\144\145\146\145\145\145\147\147\147\147","ob\145\145\145\145\145\145\145\144\145\145\144\144\145\147\147\147\147"
; 		5190.1  DATA 18{00 00 12 00 00 },2{00 00 02 00 00 },7{00 00 07 00 00 },"bd\145\145\145\145","cf\145\146\145\145\145","db\145\145\145\144\144\145\145\145\145","eb\145\146\145\144\145\145\144\144\145\145\145\145","fb\145\146\145\144\145\145","fm\145","gc\145\146\145\145\146\145\145\145\145\144\145","hc\145\146\145\146\145","hk\145\144\145","ic\145\144\145\145\146\145\145\144\145\144\145","jc\145\144\145\144\146\144\145\145\145\144\145","kc\145","kg\145\145\145\144\145\144\145","lb\145\145\146\145\145","lk\145\144\145\144\147\147\147\147","mb\145\145\145\145\146\145\145\145\145\146\145\145\145\147\147\144\147","ne\146\145\145\146\144\145\146\145\145\145\147\147\147\147","ob\145\145\145\145\145\145\145\144\145\145\144\144\145\147\147\147\147"
ZXBASIC_LINE_5200:
; 5200  DATA 21,3,15,"bf\145\145\145\145\145\145\145\145","cb\145\145\145\145\145\144\145\145\145\146\145\145\144\145\145","db\145","dj\146","do\145\145","eb\145\144\145\145\145\145\144\144\145\144\145\145\144\146\145\147\147","fb\145\144\145\146\145\145\145\145\145\144\145\145\144\145\145\144\147","gb\145\144\145\146\145\145\144\145\145\145\145\145\144\146\145\147\147","hb\145\144\145\145","hi\145\144\144\145\145\145\145\145\144\147","ib\145","if\145\145\144\145\145\144\145\145\144\146\145\147\147","jb\145\144\145\145\145\145\144\145\145","jo\145\145\144\147","kb\145\144\146\145\145\145\146\145\145\146\145\145\144\146\145\147\147","lb\145\145\145\145\146\145\144\145\146\145\146\145\144\145\145\144\147","me\145\146","mj\145\145\145\145\144\146\145\147\147","ne\145\145\145\145\146\146\145","no\147\147\147\147","oe\145\145\145\145\145\145"
; 		5200.1  DATA 21{00 00 15 00 00 },3{00 00 03 00 00 },15{00 00 0f 00 00 },"bf\145\145\145\145\145\145\145\145","cb\145\145\145\145\145\144\145\145\145\146\145\145\144\145\145","db\145","dj\146","do\145\145","eb\145\144\145\145\145\145\144\144\145\144\145\145\144\146\145\147\147","fb\145\144\145\146\145\145\145\145\145\144\145\145\144\145\145\144\147","gb\145\144\145\146\145\145\144\145\145\145\145\145\144\146\145\147\147","hb\145\144\145\145","hi\145\144\144\145\145\145\145\145\144\147","ib\145","if\145\145\144\145\145\144\145\145\144\146\145\147\147","jb\145\144\145\145\145\145\144\145\145","jo\145\145\144\147","kb\145\144\146\145\145\145\146\145\145\146\145\145\144\146\145\147\147","lb\145\145\145\145\146\145\144\145\146\145\146\145\144\145\145\144\147","me\145\146","mj\145\145\145\145\144\146\145\147\147","ne\145\145\145\145\146\146\145","no\147\147\147\147","oe\145\145\145\145\145\145"
ZXBASIC_LINE_5210:
; 5210  DATA 14,6,7,"cd\145\145\145\145\145\145\145","dd\145\145\145\145\145\145\145","ee\145","ej\145\144\145\145","fe\145\144\145\144\144\145\145\145\145","gd\145\146\146\146\145\146\145\145\146\146","hd\145\145\144\145\144\144\145\146\145\145","id\145\145\144\145\144\144\145\145\146\145","jg\145\145\146\146\146\145\146\144\145\145","ke\145\145\145\144\144\145\145\145\147\147\147\147","le\145\144\145\145\145\144\145\144\147\147\145\147","me\145\145\145\144\145\144\145\144\144\147\147\147","ni\145\146\145\145\144\147\147\147","oj\145\145\145"
; 		5210.1  DATA 14{00 00 0e 00 00 },6{00 00 06 00 00 },7{00 00 07 00 00 },"cd\145\145\145\145\145\145\145","dd\145\145\145\145\145\145\145","ee\145","ej\145\144\145\145","fe\145\144\145\144\144\145\145\145\145","gd\145\146\146\146\145\146\145\145\146\146","hd\145\145\144\145\144\144\145\146\145\145","id\145\145\144\145\144\144\145\145\146\145","jg\145\145\146\146\146\145\146\144\145\145","ke\145\145\145\144\144\145\145\145\147\147\147\147","le\145\144\145\145\145\144\145\144\147\147\145\147","me\145\145\145\144\145\144\145\144\144\147\147\147","ni\145\146\145\145\144\147\147\147","oj\145\145\145"
ZXBASIC_LINE_5220:
; 5220  DATA 21,5,11,"bb\145\145\145\145","bm\145\145","cb\145\145\145\146\144\145\145\144\145\145\146\145\145\144\145\145\145","db\145\145\146\145\145\146\145\145\146\145\144\145\146\145\146\145\145","ec\146\145\146\145\145\145\144\145\145\144\145\146\145\145\145\145","fb\145\145\146\145","fq\145","gb\145\144\145\145\145\144\147\147\147\147\147\147\147\144\145\146","hb\145\144\144\145\145\144\145\147\147\147\147\147\147\144\145\145","ib\145\144\145\145\145\146\147\147\147\147\147\147\147\147\146\145","jb\145\144\145\146\145\144\147\147\147\147\145\147\147\144\145\145","kb\145\145\146\145\146","kk\146","kp\145\146","lb\145\146\145\145\145","lj\145\146\145\145\145\146\145\145","mb\145\146\145\145\145\145\145\146\145\146\145\145\146\145\145\145\145","nc\145","nj\145\146\145","nr\145","ob\145\145\145\145\145\145\145\145\145\144\145\145\145\145\145\145\145"
; 		5220.1  DATA 21{00 00 15 00 00 },5{00 00 05 00 00 },11{00 00 0b 00 00 },"bb\145\145\145\145","bm\145\145","cb\145\145\145\146\144\145\145\144\145\145\146\145\145\144\145\145\145","db\145\145\146\145\145\146\145\145\146\145\144\145\146\145\146\145\145","ec\146\145\146\145\145\145\144\145\145\144\145\146\145\145\145\145","fb\145\145\146\145","fq\145","gb\145\144\145\145\145\144\147\147\147\147\147\147\147\144\145\146","hb\145\144\144\145\145\144\145\147\147\147\147\147\147\144\145\145","ib\145\144\145\145\145\146\147\147\147\147\147\147\147\147\146\145","jb\145\144\145\146\145\144\147\147\147\147\145\147\147\144\145\145","kb\145\145\146\145\146","kk\146","kp\145\146","lb\145\146\145\145\145","lj\145\146\145\145\145\146\145\145","mb\145\146\145\145\145\145\145\146\145\146\145\145\146\145\145\145\145","nc\145","nj\145\146\145","nr\145","ob\145\145\145\145\145\145\145\145\145\144\145\145\145\145\145\145\145"
ZXBASIC_LINE_5230:
; 5230  DATA 14,9,4,"cf\145\145\144\145\145","df\145\146\144\146\145\144\145\145","eb\147\147\145\144\145\145\144\145\145\144\145\145\145","fb\147\147\145\144\145\146\144\146\145\144\145\145\146","gb\147\145\145\144\145\145\145\145\145\144\146\145\145\144\145\145","hb\147\147\145\145\145\146\144\145\145\144\145\146\145\145\145\145","ib\147\147\145\144\145\145\144\146\145\144\146\145\145\144\145\145","jb\147\147\145\144\145\146\144\145\145\145\145\145\146\144\145\145","kb\147\147\145\144\145\145\144\146\146\144\146\145\145\144\145\145","lb\147\147\145\144\145\146\144\145\145\144\145\145\146\144\146\145\145","mb\147\147\145\144\145\145\144\145\145\144\145\145\145\144\145\145\145","nc\147\145","ni\145\145","np\145\145\145"
; 		5230.1  DATA 14{00 00 0e 00 00 },9{00 00 09 00 00 },4{00 00 04 00 00 },"cf\145\145\144\145\145","df\145\146\144\146\145\144\145\145","eb\147\147\145\144\145\145\144\145\145\144\145\145\145","fb\147\147\145\144\145\146\144\146\145\144\145\145\146","gb\147\145\145\144\145\145\145\145\145\144\146\145\145\144\145\145","hb\147\147\145\145\145\146\144\145\145\144\145\146\145\145\145\145","ib\147\147\145\144\145\145\144\146\145\144\146\145\145\144\145\145","jb\147\147\145\144\145\146\144\145\145\145\145\145\146\144\145\145","kb\147\147\145\144\145\145\144\146\146\144\146\145\145\144\145\145","lb\147\147\145\144\145\146\144\145\145\144\145\145\146\144\146\145\145","mb\147\147\145\144\145\145\144\145\145\144\145\145\145\144\145\145\145","nc\147\145","ni\145\145","np\145\145\145"
ZXBASIC_LINE_5240:
; 5240  DATA 19,15,4,"bb\147\147\147\147\147\147\147\147\147\147\145\145\147","cb\147\147\147\147\147\147\147\147\147\147\146\146\147","dl\146\145\144\145\145\145","eb\145\145\145\145\145\145\146\145\145\146\145\145\145\145\145\146\145","fc\145","fh\145\145\145\144\145\145\146\145\144\145\145","gb\145\145\145\145\145\145\144\145\145\145\144\144\145\145\144\145","hb\145\145\146\144\145\145\144\145\144\144\145\145","hq\145","ib\145\146\145\144\146","ij\145\145\145\145","iq\145","jd\145\145\146\145\144\145\145\144\145\145","jq\145","kd\145\145\145\145\146\145\144\144\145\144\145\145\144\145","lc\145\146\145\145\144\145\145\146\145\145\146\145\146\145\145\145","mc\145\145\146\145\145\146\144\146\146\146\145\145\144\145\145\145","nc\145\145\144\145\145\146\145\145\145\145\145\145","oc\145\145\144\144\145\145\144\145\145\144\145\145"
; 		5240.1  DATA 19{00 00 13 00 00 },15{00 00 0f 00 00 },4{00 00 04 00 00 },"bb\147\147\147\147\147\147\147\147\147\147\145\145\147","cb\147\147\147\147\147\147\147\147\147\147\146\146\147","dl\146\145\144\145\145\145","eb\145\145\145\145\145\145\146\145\145\146\145\145\145\145\145\146\145","fc\145","fh\145\145\145\144\145\145\146\145\144\145\145","gb\145\145\145\145\145\145\144\145\145\145\144\144\145\145\144\145","hb\145\145\146\144\145\145\144\145\144\144\145\145","hq\145","ib\145\146\145\144\146","ij\145\145\145\145","iq\145","jd\145\145\146\145\144\145\145\144\145\145","jq\145","kd\145\145\145\145\146\145\144\144\145\144\145\145\144\145","lc\145\146\145\145\144\145\145\146\145\145\146\145\146\145\145\145","mc\145\145\146\145\145\146\144\146\146\146\145\145\144\145\145\145","nc\145\145\144\145\145\146\145\145\145\145\145\145","oc\145\145\144\144\145\145\144\145\145\144\145\145"
ZXBASIC_LINE_5250:
; 5250  DATA 22,7,17,"bb\145\145","cb\145\145\144\145\145\145\147\147\144\147\147\147\147\147\147","db\145\145\144\145\144\145","dm\145\147\147\147","ec\146\144\145\145\145\145\147\147\147\147\147\147\147\147","fb\145\145\145\144\144\146","fn\145\145","gb\145\146\145\144\145\145\145\145\145","gq\145\145","hc\146\145\144\145\146\145\145\145","hq\145\145","ib\145\145\146\145\144\146\146\146\144\144\145\145\145\145\145\145\145","jb\145\145\145\145\145\145\144\145\145\145\145\144\146\144\146","kb\145","kg\145\144\146\146\146\146\146\145\145\145\145","lb\145\144\145\145\145\145\146\145\145\145\145\145\144\145\145\145","mb\145\144\145\145\145\144\144\145\145\145\145\145\145\145\145","nb\145","ni\146","np\145\146\145","ob\145\145\145\145\145\145\145\145","op\145\145\145"
; 		5250.1  DATA 22{00 00 16 00 00 },7{00 00 07 00 00 },17{00 00 11 00 00 },"bb\145\145","cb\145\145\144\145\145\145\147\147\144\147\147\147\147\147\147","db\145\145\144\145\144\145","dm\145\147\147\147","ec\146\144\145\145\145\145\147\147\147\147\147\147\147\147","fb\145\145\145\144\144\146","fn\145\145","gb\145\146\145\144\145\145\145\145\145","gq\145\145","hc\146\145\144\145\146\145\145\145","hq\145\145","ib\145\145\146\145\144\146\146\146\144\144\145\145\145\145\145\145\145","jb\145\145\145\145\145\145\144\145\145\145\145\144\146\144\146","kb\145","kg\145\144\146\146\146\146\146\145\145\145\145","lb\145\144\145\145\145\145\146\145\145\145\145\145\144\145\145\145","mb\145\144\145\145\145\144\144\145\145\145\145\145\145\145\145","nb\145","ni\146","np\145\146\145","ob\145\145\145\145\145\145\145\145","op\145\145\145"
ZXBASIC_LINE_5260:
; 5260  DATA 10,12,16,"de\145\145\144\145\145","ee\145\145\144\145\145\144\147\147\147","fd\145\145\146\144\145\145\144\147\147\147\145\145","gd\145\146\145\144\146\146\145\147\147\147\145\145","hd\145\145\146\144\145\145\144\147\147\147\145\147","id\145\145\145\144\145\146","je\146\145\145\145\145\145\145\145\146\145\146\145","ke\145\145\144\145\145\146\146\145\144\145\145\145","lj\145\145\144\144\146\146\145","mj\145\145\145\145\145\145"
; 		5260.1  DATA 10{00 00 0a 00 00 },12{00 00 0c 00 00 },16{00 00 10 00 00 },"de\145\145\144\145\145","ee\145\145\144\145\145\144\147\147\147","fd\145\145\146\144\145\145\144\147\147\147\145\145","gd\145\146\145\144\146\146\145\147\147\147\145\145","hd\145\145\146\144\145\145\144\147\147\147\145\147","id\145\145\145\144\145\146","je\146\145\145\145\145\145\145\145\146\145\146\145","ke\145\145\144\145\145\146\146\145\144\145\145\145","lj\145\145\144\144\146\146\145","mj\145\145\145\145\145\145"
ZXBASIC_LINE_5270:
; 5270  DATA 12,14,11,"dc\147\147\147\145\145\145\144\145\145\145\145\144\145\145\145","ec\147\147\147\147\147\145\145\146\144\144\145\144\145\144\146\145","fb\147\147\147\147\147\147\144\145\145\146\145\145\144\145\145\145\145","gb\147\147\147\147\147\147\144\145\145\144\145\145\144\145\144\145\145","hj\145\146\145\145\146\145\146\145\145","id\145\145\145\145\145\144\146\144\144\146\145\144\144\146","jd\145\145\145\146\145\145\145\145\144\145\146\145\145\145\145","kc\145\145\144\144\145","kk\145\144\145\145\144\144\146\145","lc\145\146\145\146\146\145\145\145\145\145\146\145\145\146\145\145","mc\145\146\145\145\145\145\146\144\144\146\145","ni\145\145\145\145"
; 		5270.1  DATA 12{00 00 0c 00 00 },14{00 00 0e 00 00 },11{00 00 0b 00 00 },"dc\147\147\147\145\145\145\144\145\145\145\145\144\145\145\145","ec\147\147\147\147\147\145\145\146\144\144\145\144\145\144\146\145","fb\147\147\147\147\147\147\144\145\145\146\145\145\144\145\145\145\145","gb\147\147\147\147\147\147\144\145\145\144\145\145\144\145\144\145\145","hj\145\146\145\145\146\145\146\145\145","id\145\145\145\145\145\144\146\144\144\146\145\144\144\146","jd\145\145\145\146\145\145\145\145\144\145\146\145\145\145\145","kc\145\145\144\144\145","kk\145\144\145\145\144\144\146\145","lc\145\146\145\146\146\145\145\145\145\145\146\145\145\146\145\145","mc\145\146\145\145\145\145\146\144\144\146\145","ni\145\145\145\145"
ZXBASIC_LINE_5280:
; 5280  DATA 16,10,3,"cl\145\145\145","dh\145\146\145\145\146\145\145","eg\145\146\145\145\146\145\146\145\144\144\147","fc\145\145\145\145\145\145\145\146\146\145\145\144\144\147\147","gc\145\145","gk\145","go\147\147\145","hd\145\144\145\145\144\145\145\145\145\144\147\147\147\145","ic\145\146\145\145\145\144\145\145\145\145\144\147\147\147\145","jc\145\145\144\146\145\144\144\145","jo\147\147\147","kf\145\145\146\145\146\146\145\145\144\144\147\147","lg\145\145\146\145\146\145\145\146\147\147\147","mg\145\146\146\145\145\146\145\144\145\145\147","ng\145\145\145\146\145\146\145\145","ol\145\145\145"
; 		5280.1  DATA 16{00 00 10 00 00 },10{00 00 0a 00 00 },3{00 00 03 00 00 },"cl\145\145\145","dh\145\146\145\145\146\145\145","eg\145\146\145\145\146\145\146\145\144\144\147","fc\145\145\145\145\145\145\145\146\146\145\145\144\144\147\147","gc\145\145","gk\145","go\147\147\145","hd\145\144\145\145\144\145\145\145\145\144\147\147\147\145","ic\145\146\145\145\145\144\145\145\145\145\144\147\147\147\145","jc\145\145\144\146\145\144\144\145","jo\147\147\147","kf\145\145\146\145\146\146\145\145\144\144\147\147","lg\145\145\146\145\146\145\145\146\147\147\147","mg\145\146\146\145\145\146\145\144\145\145\147","ng\145\145\145\146\145\146\145\145","ol\145\145\145"
ZXBASIC_LINE_5290:
; 5290  DATA 14,7,12,"db\145\145\145","eb\145\146\145\145","fc\145\144\145\144\145\145\145\145\145\145\145","gc\145\144\145\145\145\146\144\146\144\145\145\145\144\145\145\145","hb\145\145\144\145\145\145\145\145\145\146\145\144\145\145\145\146\145","ib\145\145","ig\145","iq\145","jb\145\145\144\144\145\147\147\150\147\147\147\147\147\145\144\145","kc\145\144\144\145\150\147\150\147\147\150\147\150\145\144\145","lb\145\146","ln\145\144\144\146\145","mb\145\145\146\145\145\145\146\145\145\146\145\145\145\145\146\145\145","nb\145\145\144\145\145\145\144\145\145\145\144\145\145\145\144\145\145"
; 		5290.1  DATA 14{00 00 0e 00 00 },7{00 00 07 00 00 },12{00 00 0c 00 00 },"db\145\145\145","eb\145\146\145\145","fc\145\144\145\144\145\145\145\145\145\145\145","gc\145\144\145\145\145\146\144\146\144\145\145\145\144\145\145\145","hb\145\145\144\145\145\145\145\145\145\146\145\144\145\145\145\146\145","ib\145\145","ig\145","iq\145","jb\145\145\144\144\145\147\147\150\147\147\147\147\147\145\144\145","kc\145\144\144\145\150\147\150\147\147\150\147\150\145\144\145","lb\145\146","ln\145\144\144\146\145","mb\145\145\146\145\145\145\146\145\145\146\145\145\145\145\146\145\145","nb\145\145\144\145\145\145\144\145\145\145\144\145\145\145\144\145\145"
ZXBASIC_LINE_5300:
; 5300  DATA 18,7,6,"ci\145\145\145\144\145\145\145\145\145","di\145\145\145\145\145\146\145\146\145","eb\145\145\145","ej\145\146\144\144\145\144\145","fb\145\146\145\144\144\145\145\145\144\145\144\144\145\146\145\145","gb\145\146\145\145\145\146\146\145\144\145\144\144\146\146\146\145","hc\145","hg\145\145\145\144\145\144\144\145\145\145\145","ic\145\144\145\145\145","ik\145","iq\146","jc\145\144\145\145\145\145\145\146\145\145\144\147\147\147\147","kb\145\145","kg\145\144\144\145\146\145\144\147\147\147\147","lb\145\146\145\145\145\146\145\144\145\145\145\144\147\147\146\147\145","mb\145\145\144\144\145\146\145\144\145\145\144\144\147\147\147\147\145","nf\145\145\145","no\147\147\147"
; 		5300.1  DATA 18{00 00 12 00 00 },7{00 00 07 00 00 },6{00 00 06 00 00 },"ci\145\145\145\144\145\145\145\145\145","di\145\145\145\145\145\146\145\146\145","eb\145\145\145","ej\145\146\144\144\145\144\145","fb\145\146\145\144\144\145\145\145\144\145\144\144\145\146\145\145","gb\145\146\145\145\145\146\146\145\144\145\144\144\146\146\146\145","hc\145","hg\145\145\145\144\145\144\144\145\145\145\145","ic\145\144\145\145\145","ik\145","iq\146","jc\145\144\145\145\145\145\145\146\145\145\144\147\147\147\147","kb\145\145","kg\145\144\144\145\146\145\144\147\147\147\147","lb\145\146\145\145\145\146\145\144\145\145\145\144\147\147\146\147\145","mb\145\145\144\144\145\146\145\144\145\145\144\144\147\147\147\147\145","nf\145\145\145","no\147\147\147"
ZXBASIC_LINE_5310:
; 5310  DATA 16,4,9,"bd\145\145","cd\145\145\144\144\145\145\144\145\145\145","dc\145\145\146\144\145\146\145\146\145\145\145","ec\146\145\145\146\145\145\144\145\146\145\146\144\145\145","fc\145\145\146\144\144\145\144\146\145\146\145\145\145\145\145","gb\145\145\144\145\145\144\145\144\145\145\145\146\146\146\145\145","hb\145\146\145\145\145\145\146\145\145\146\144\144\145","ib\145\146\145\146\145\144\146\144\145\145\144\145\145","jc\145\145","jh\145\145","jm\146\145","kc\145\145\144\147\147\147\147\145\145\145\145\145","lf\147\147\147\147\147\147","me\147\147\147\147","ne\147\147\147","oe\147\147\147"
; 		5310.1  DATA 16{00 00 10 00 00 },4{00 00 04 00 00 },9{00 00 09 00 00 },"bd\145\145","cd\145\145\144\144\145\145\144\145\145\145","dc\145\145\146\144\145\146\145\146\145\145\145","ec\146\145\145\146\145\145\144\145\146\145\146\144\145\145","fc\145\145\146\144\144\145\144\146\145\146\145\145\145\145\145","gb\145\145\144\145\145\144\145\144\145\145\145\146\146\146\145\145","hb\145\146\145\145\145\145\146\145\145\146\144\144\145","ib\145\146\145\146\145\144\146\144\145\145\144\145\145","jc\145\145","jh\145\145","jm\146\145","kc\145\145\144\147\147\147\147\145\145\145\145\145","lf\147\147\147\147\147\147","me\147\147\147\147","ne\147\147\147","oe\147\147\147"
ZXBASIC_LINE_5320:
; 5320  DATA 13,6,5,"ck\145\145","dg\145\145\145\145\145\146","ef\145\146\145\145\144\144\145","fe\145\146\145\146\145\144\145\146\145\145","gh\145\144\144\145\145\145\146","hf\147\147\147\147\144\146\145\146\145","if\147\147\147\147\144\145\145\145\146","jf\147\147\147\147\145\145\146\146\145","kf\147\147\147\145\144\145\146\145\145\145","lk\146\145\146\145\145","mk\145\145\145","nk\146\145","ok\145\145"
; 		5320.1  DATA 13{00 00 0d 00 00 },6{00 00 06 00 00 },5{00 00 05 00 00 },"ck\145\145","dg\145\145\145\145\145\146","ef\145\146\145\145\144\144\145","fe\145\146\145\146\145\144\145\146\145\145","gh\145\144\144\145\145\145\146","hf\147\147\147\147\144\146\145\146\145","if\147\147\147\147\144\145\145\145\146","jf\147\147\147\147\145\145\146\146\145","kf\147\147\147\145\144\145\146\145\145\145","lk\146\145\146\145\145","mk\145\145\145","nk\146\145","ok\145\145"
ZXBASIC_LINE_5330:
; 5330  DATA 13,12,14,"cf\145\145\145\145\144\144\145\145","df\145\145\145\146\145\145\145\146\145","eh\145\144\144\145\146\146\145","fe\145\145\145\146\145\144\145\145\145\145","ge\145\146\146\146\145\144\145","he\145\145\145\144\145\144\145\146\145","ie\145\145\144\145\145\144\145\145\146\145","je\145\146\144\145\146\144\145\145\145\145","ke\145\145\145\147\147\144\145","lh\147\147\145\146\145\144\145","me\147\147\147\147\147\144\145\146\144\145","nf\147\147\147\147\144\145\145\146\145","og\147\147\144\144\145\145\145\145"
; 		5330.1  DATA 13{00 00 0d 00 00 },12{00 00 0c 00 00 },14{00 00 0e 00 00 },"cf\145\145\145\145\144\144\145\145","df\145\145\145\146\145\145\145\146\145","eh\145\144\144\145\146\146\145","fe\145\145\145\146\145\144\145\145\145\145","ge\145\146\146\146\145\144\145","he\145\145\145\144\145\144\145\146\145","ie\145\145\144\145\145\144\145\145\146\145","je\145\146\144\145\146\144\145\145\145\145","ke\145\145\145\147\147\144\145","lh\147\147\145\146\145\144\145","me\147\147\147\147\147\144\145\146\144\145","nf\147\147\147\147\144\145\145\146\145","og\147\147\144\144\145\145\145\145"
ZXBASIC_LINE_5340:
; 5340  DATA 15,5,14,"cf\147\147\147\147\145\145\145","df\147\144\147\144\145\145\146\145","ef\147\147\147\147\144\145\144\145\145","fe\145\147\147\147\147\144\145\145\144\145\145","ge\145\145\145\145\145\144\146\145\144\144\146\145","hf\145","hj\145\145\146\145\145\145\145","if\146\145\145\146\145\146\145\146\144\145\145","jf\145\144\145\145\146\145\146\145\144\144\145","kf\145\145","kk\145\145\144\144\145","lf\145\145\145\145\144\144\145\144\144\145","mf\145\145\146\145\144\145\145\146\145\145","nh\146\145\146\145\145\145","oh\145\145"
; 		5340.1  DATA 15{00 00 0f 00 00 },5{00 00 05 00 00 },14{00 00 0e 00 00 },"cf\147\147\147\147\145\145\145","df\147\144\147\144\145\145\146\145","ef\147\147\147\147\144\145\144\145\145","fe\145\147\147\147\147\144\145\145\144\145\145","ge\145\145\145\145\145\144\146\145\144\144\146\145","hf\145","hj\145\145\146\145\145\145\145","if\146\145\145\146\145\146\145\146\144\145\145","jf\145\144\145\145\146\145\146\145\144\144\145","kf\145\145","kk\145\145\144\144\145","lf\145\145\145\145\144\144\145\144\144\145","mf\145\145\146\145\144\145\145\146\145\145","nh\146\145\146\145\145\145","oh\145\145"
ZXBASIC_LINE_5350:
; 5350  DATA 20,3,11,"bb\145\145\145\144\145\145\145\145\144\145\144","bo\147\147\147\147","cb\145\145\145\146\146\144\145\145\145\145\145\145\147\147\147\147\147","db\145\145\145\144\145","dj\145\145\145\144\145\147\147\147\147","ec\145\144\144\145","ej\145\145\144\145\145\147\147\147\147","fc\145\146\145\146\145\145\145\145\145\144\145\144\145","gc\145\145\146\145\146\144\144\145\145\144\145\145\145\145\145\145","he\145\144\145\145","hm\145\144\145\144\144\145","ib\145\145\144\145\144\146\145\145\145\144\144\145\144\145\145\145\145","jb\145\146\145\145\146\145\145\144\145\144\144\145\144\145\145\145","kb\145\144\145\146\145\146\145\145\145\145\144\145\144\145\145\145","lb\145\145\146\145\144\144\145\144\144\145\144\145","mb\145\146\146\145\145\145\145\145\146\146\145\145","nc\145\144\144\145","nj\145\146\145\145","oc\145\145\145\145","oj\145\145\145\145"
; 		5350.1  DATA 20{00 00 14 00 00 },3{00 00 03 00 00 },11{00 00 0b 00 00 },"bb\145\145\145\144\145\145\145\145\144\145\144","bo\147\147\147\147","cb\145\145\145\146\146\144\145\145\145\145\145\145\147\147\147\147\147","db\145\145\145\144\145","dj\145\145\145\144\145\147\147\147\147","ec\145\144\144\145","ej\145\145\144\145\145\147\147\147\147","fc\145\146\145\146\145\145\145\145\145\144\145\144\145","gc\145\145\146\145\146\144\144\145\145\144\145\145\145\145\145\145","he\145\144\145\145","hm\145\144\145\144\144\145","ib\145\145\144\145\144\146\145\145\145\144\144\145\144\145\145\145\145","jb\145\146\145\145\146\145\145\144\145\144\144\145\144\145\145\145","kb\145\144\145\146\145\146\145\145\145\145\144\145\144\145\145\145","lb\145\145\146\145\144\144\145\144\144\145\144\145","mb\145\146\146\145\145\145\145\145\146\146\145\145","nc\145\144\144\145","nj\145\146\145\145","oc\145\145\145\145","oj\145\145\145\145"
ZXBASIC_LINE_5360:
; 5360  DATA 21,8,11,"bn\145\145\145","cb\145\145\145","ci\145\145\146\145\146\145\146\145","db\145\146\145\145\145\144\144\145\144\144\145\144\144\145\145","eb\145\145\145\146\145\146\145\145\145\145\145\146\145\145\146\145","fd\145\146\145\145\144\144\145\144\144\145\145\145\145\145","gd\145","gj\145","gp\146\146\145","hd\146","hj\145\145\144\144\145\145\145\145\145","ic\145\146\145\145","ij\146","in\145\146\145\145","jc\145\146\145\145\144\145\145\145","jn\145\145","kc\145\146\146\145\146\145\144\145\145\145\146\146\145","lc\145\145\145\145\145\144\145\145\145\144\144\145\145","mi\147\147\145\147","nf\147\147\147\147\147\147\147\147\147","of\147\147\147\147\147\147\147\147\147"
; 		5360.1  DATA 21{00 00 15 00 00 },8{00 00 08 00 00 },11{00 00 0b 00 00 },"bn\145\145\145","cb\145\145\145","ci\145\145\146\145\146\145\146\145","db\145\146\145\145\145\144\144\145\144\144\145\144\144\145\145","eb\145\145\145\146\145\146\145\145\145\145\145\146\145\145\146\145","fd\145\146\145\145\144\144\145\144\144\145\145\145\145\145","gd\145","gj\145","gp\146\146\145","hd\146","hj\145\145\144\144\145\145\145\145\145","ic\145\146\145\145","ij\146","in\145\146\145\145","jc\145\146\145\145\144\145\145\145","jn\145\145","kc\145\146\146\145\146\145\144\145\145\145\146\146\145","lc\145\145\145\145\145\144\145\145\145\144\144\145\145","mi\147\147\145\147","nf\147\147\147\147\147\147\147\147\147","of\147\147\147\147\147\147\147\147\147"
ZXBASIC_LINE_5370:
; 5370  DATA 15,15,10,"cb\147\147\147\147\147\147\145\145\145","db\147\147\147\147\147\147\145\145\145\144\145\145\144\144\145\145\145","eb\147\147","eg\145\146\145\145\145\145\146\145\145\145\145\145","fb\147\147\147\145\146\145\146\145\144\145\145\145\144\144\145\145\145","gb\147\147\147\144\146","gl\145\145\145\145\144\145\145","hd\145\145\145\145\144\145\145\145\144\146\145\145\144\146\145","id\145\145\146\146\145\146\145\146\145\145\146\144\144\145\145","jd\145\145\146\145\145\145\144\146\144\146\145\144\144\146\145","kf\145\144\144\145\144\145\145\145\145\144\144\145\145","le\145\145\146\145\146\145\144\144\145","me\145\145\145\145\146\145\145\146\145\145","nf\145\145\145\144\145\144\145\145\145","oj\145"
; 		5370.1  DATA 15{00 00 0f 00 00 },15{00 00 0f 00 00 },10{00 00 0a 00 00 },"cb\147\147\147\147\147\147\145\145\145","db\147\147\147\147\147\147\145\145\145\144\145\145\144\144\145\145\145","eb\147\147","eg\145\146\145\145\145\145\146\145\145\145\145\145","fb\147\147\147\145\146\145\146\145\144\145\145\145\144\144\145\145\145","gb\147\147\147\144\146","gl\145\145\145\145\144\145\145","hd\145\145\145\145\144\145\145\145\144\146\145\145\144\146\145","id\145\145\146\146\145\146\145\146\145\145\146\144\144\145\145","jd\145\145\146\145\145\145\144\146\144\146\145\144\144\146\145","kf\145\144\144\145\144\145\145\145\145\144\144\145\145","le\145\145\146\145\146\145\144\144\145","me\145\145\145\145\146\145\145\146\145\145","nf\145\145\145\144\145\144\145\145\145","oj\145"
ZXBASIC_LINE_5380:
; 5380  DATA 9,5,13,"el\145\145","ff\145\145\145\145\145\146\145\145","gf\145\145\145\146\144\144\145\146","hg\146\144\147\147\147\144\145","ig\145\146\147\147\147\145\145","jg\145\144\147\145\147\144\145","kg\145\145\145\144\145\144\146\145","lg\146\145\145\146\145\145\145\145","mg\145\145"
; 		5380.1  DATA 9{00 00 09 00 00 },5{00 00 05 00 00 },13{00 00 0d 00 00 },"el\145\145","ff\145\145\145\145\145\146\145\145","gf\145\145\145\146\144\144\145\146","hg\146\144\147\147\147\144\145","ig\145\146\147\147\147\145\145","jg\145\144\147\145\147\144\145","kg\145\145\145\144\145\144\146\145","lg\146\145\145\146\145\145\145\145","mg\145\145"
ZXBASIC_LINE_5390:
; 5390  DATA 19,4,12,"bo\147\147\147\147","cc\145\145\145\144\144\145\145\145\145\145\144\144\147\147\147\147","db\145\145\146\146\144\144\145\145\146\145\145\144\144\147\147\147\147","eb\145\145\145\145\145\145\146\146\145\146\144\145\145\147\147\147\147","fb\145\145\146\145\144\144\145\146\146\145\144\145\144\145\147\147\147","gb\145\145\146\145\144\144\145\146\145\145\144\145\145\147\147\147\147","hc\145","hi\145","hm\145\144\144\147","ic\145\145\145\146\145\145\146\145\144\144\145\145\145\147\145\145","jb\145\146","jg\145\145\144\145","jp\145","kb\145\145\145\146\145\145\145\144\145\145\145\145\145\145\145","lb\145\145\146\145\144\146\145\146\145\146","lo\145\145","mb\145\146\146\146\144\145\146\145\145\145","nb\145\145\145\145\144\145\145\146\146\145","og\145\145\145"
; 		5390.1  DATA 19{00 00 13 00 00 },4{00 00 04 00 00 },12{00 00 0c 00 00 },"bo\147\147\147\147","cc\145\145\145\144\144\145\145\145\145\145\144\144\147\147\147\147","db\145\145\146\146\144\144\145\145\146\145\145\144\144\147\147\147\147","eb\145\145\145\145\145\145\146\146\145\146\144\145\145\147\147\147\147","fb\145\145\146\145\144\144\145\146\146\145\144\145\144\145\147\147\147","gb\145\145\146\145\144\144\145\146\145\145\144\145\145\147\147\147\147","hc\145","hi\145","hm\145\144\144\147","ic\145\145\145\146\145\145\146\145\144\144\145\145\145\147\145\145","jb\145\146","jg\145\145\144\145","jp\145","kb\145\145\145\146\145\145\145\144\145\145\145\145\145\145\145","lb\145\145\146\145\144\146\145\146\145\146","lo\145\145","mb\145\146\146\146\144\145\146\145\145\145","nb\145\145\145\145\144\145\145\146\146\145","og\145\145\145"
ZXBASIC_LINE_5400:
; 5400  DATA 14,4,17,"bg\145\145\145\145\145\145\145\145\145\145","cg\145\145\144\145\144\146\146\145\146\145\145","dg\146\145\144\146\144\145\145\144\144\145\145","eg\145\144\144\145\144\145\146\145\144\145","ff\145\145\145\146\145\144\146\145\145\144\145","gf\145\145\145\144\145\146\145\145\145\144\145","hg\145\146\145\146\145\145\145\144\144\145","if\145\145\144\145\145\144\144\145\145\146\145","jf\145\145\145\145\144\144\145\146\146\144\145","kh\146\146\145\145\145\144\145\145\145","lc\147\147\147\147\144\145\145","mc\147\144\147\147\147\145","nc\147\147\147\147\145\145\145","oc\147\147\147\147\145\145\145"
; 		5400.1  DATA 14{00 00 0e 00 00 },4{00 00 04 00 00 },17{00 00 11 00 00 },"bg\145\145\145\145\145\145\145\145\145\145","cg\145\145\144\145\144\146\146\145\146\145\145","dg\146\145\144\146\144\145\145\144\144\145\145","eg\145\144\144\145\144\145\146\145\144\145","ff\145\145\145\146\145\144\146\145\145\144\145","gf\145\145\145\144\145\146\145\145\145\144\145","hg\145\146\145\146\145\145\145\144\144\145","if\145\145\144\145\145\144\144\145\145\146\145","jf\145\145\145\145\144\144\145\146\146\144\145","kh\146\146\145\145\145\144\145\145\145","lc\147\147\147\147\144\145\145","mc\147\144\147\147\147\145","nc\147\147\147\147\145\145\145","oc\147\147\147\147\145\145\145"
ZXBASIC_LINE_5410:
; 5410  DATA 16,10,18,"cm\145\145\145","dl\145\145\145\145\145","ek\145\145\146\146\145\145","fj\145\146\146\145\145\146\145","gi\145\146\145\145\145\145\146\145","hi\145\145\145\146\146\145","ib\145\145","il\145\144\144\145\145\145\145","jb\147\145\145\145\145\145\145\145\145\145\145\145\145\146\146\146\145","kb\147\144\145","kl\145\144\144\145\145\145","lb\147\144\145","ll\147\145\144\146\145\146","mb\147\147\147\147\147\147\147\147\147\147\147\145\144\145\145\145\145","no\145\145\146\145","op\145\145"
; 		5410.1  DATA 16{00 00 10 00 00 },10{00 00 0a 00 00 },18{00 00 12 00 00 },"cm\145\145\145","dl\145\145\145\145\145","ek\145\145\146\146\145\145","fj\145\146\146\145\145\146\145","gi\145\146\145\145\145\145\146\145","hi\145\145\145\146\146\145","ib\145\145","il\145\144\144\145\145\145\145","jb\147\145\145\145\145\145\145\145\145\145\145\145\145\146\146\146\145","kb\147\144\145","kl\145\144\144\145\145\145","lb\147\144\145","ll\147\145\144\146\145\146","mb\147\147\147\147\147\147\147\147\147\147\147\145\144\145\145\145\145","no\145\145\146\145","op\145\145"
ZXBASIC_LINE_5420:
; 5420  DATA 13,5,17,"dg\145\145\145\145\145\145","ed\145\145\145\145\144\144\145\146\145\146\145\145\145\145","fd\145\144\144\145\144\144\146\144\146\145\146\145\146","gd\145\147\147\147\147\147\147\144\145\145\146\146\145","hb\145\145\145\147\147\147\147\147\147\144\145\145\144\145\145\145","ib\145\144\145\147\147\147\147\147\147\144\146\145\145\146\145\145","jb\145\144\146\147\147\147\147\147\147\145\146\146\144\145\146\145","kb\145\145\145","kh\145","kl\146\145\145\146\145","ld\145\145\146\145\145\146\145\145\146\145\145\146\145","md\145\145\146\145\145\146\145\145\146\145\145\146\145","ni\145\145\145"
; 		5420.1  DATA 13{00 00 0d 00 00 },5{00 00 05 00 00 },17{00 00 11 00 00 },"dg\145\145\145\145\145\145","ed\145\145\145\145\144\144\145\146\145\146\145\145\145\145","fd\145\144\144\145\144\144\146\144\146\145\146\145\146","gd\145\147\147\147\147\147\147\144\145\145\146\146\145","hb\145\145\145\147\147\147\147\147\147\144\145\145\144\145\145\145","ib\145\144\145\147\147\147\147\147\147\144\146\145\145\146\145\145","jb\145\144\146\147\147\147\147\147\147\145\146\146\144\145\146\145","kb\145\145\145","kh\145","kl\146\145\145\146\145","ld\145\145\146\145\145\146\145\145\146\145\145\146\145","md\145\145\146\145\145\146\145\145\146\145\145\146\145","ni\145\145\145"
ZXBASIC_LINE_5430:
; 5430  DATA 12,11,10,"ej\145\145\144\145\145","ff\145\145\145\144\145\145\145\146\145\145\145\145","gf\145\144\146\146\145\144\144\145\144\144\145\145","hc\145\145\145\145\145\145\144\145\144\145\145\144\144\145","ib\145\145","ig\145\146\144\146\145\145\146\145\145\146\145\145","jb\147\147\147\145\145\145\145\144\145\144\144\145\145\144\145\145\145","kb\147\147\147\144\145\145\145\145\145\145\144\145","kq\145","lb\147\147\147\144\145\145","lk\145\145\146\145\145\146\145\145","ml\145\145\145\144\145\145\145"
; 		5430.1  DATA 12{00 00 0c 00 00 },11{00 00 0b 00 00 },10{00 00 0a 00 00 },"ej\145\145\144\145\145","ff\145\145\145\144\145\145\145\146\145\145\145\145","gf\145\144\146\146\145\144\144\145\144\144\145\145","hc\145\145\145\145\145\145\144\145\144\145\145\144\144\145","ib\145\145","ig\145\146\144\146\145\145\146\145\145\146\145\145","jb\147\147\147\145\145\145\145\144\145\144\144\145\145\144\145\145\145","kb\147\147\147\144\145\145\145\145\145\145\144\145","kq\145","lb\147\147\147\144\145\145","lk\145\145\146\145\145\146\145\145","ml\145\145\145\144\145\145\145"
ZXBASIC_LINE_5440:
; 5440  DATA 19,5,10,"cc\145\145\145","dc\145\144\145","ec\145\145\145\145\145\145\146\145","fc\145\146\145\144\144\146\145","fm\145\145\145","gc\145","gh\145\146\145\145\145\145\146\145","hc\145","hi\145\144\145\145\144\146\145","ic\145\145","ii\145\144\144\146\145\145\145\145\145\145","jb\145\145\146\144\145\145\146\145\145\144\145\144\144\145\144\144\145","kb\145\145\145\145\145\145\145\145\145\144\145\144\147\147\147\144\145","lg\145\145","ll\145\145\147\147\147\145\145","ml\145\144\147\147\147\144\145","nl\145","np\145\144\145","ol\145\145\145\145\145\145\145"
; 		5440.1  DATA 19{00 00 13 00 00 },5{00 00 05 00 00 },10{00 00 0a 00 00 },"cc\145\145\145","dc\145\144\145","ec\145\145\145\145\145\145\146\145","fc\145\146\145\144\144\146\145","fm\145\145\145","gc\145","gh\145\146\145\145\145\145\146\145","hc\145","hi\145\144\145\145\144\146\145","ic\145\145","ii\145\144\144\146\145\145\145\145\145\145","jb\145\145\146\144\145\145\146\145\145\144\145\144\144\145\144\144\145","kb\145\145\145\145\145\145\145\145\145\144\145\144\147\147\147\144\145","lg\145\145","ll\145\145\147\147\147\145\145","ml\145\144\147\147\147\144\145","nl\145","np\145\144\145","ol\145\145\145\145\145\145\145"
ZXBASIC_LINE_5450:
; 5450  DATA 16,12,7,"dc\147\147\147","di\145\145","ec\147\147\147","ei\145\145\146\145\145","fc\147\147\147\147\144\144\145\146\145\145\146","gd\147\147\147\147\144\144\145\145\145\146\145\145","he\147\147\147\145\144\144\145\146\145\146\145","ic\145\144\144\145\145\145\145\144\145\145\146\145\145","jc\145\145\144\144\145\144\145","jm\145","kc\145\146\145\144\145\144\146\145\145\146\145\145\145\145","lc\145\145\146\145\145\145\146\145\145\145\145\146\145\145","mc\145\145\145\144\145\146\145\146\146\145\146\145","nc\145\145","nk\145\145","oc\145"
; 		5450.1  DATA 16{00 00 10 00 00 },12{00 00 0c 00 00 },7{00 00 07 00 00 },"dc\147\147\147","di\145\145","ec\147\147\147","ei\145\145\146\145\145","fc\147\147\147\147\144\144\145\146\145\145\146","gd\147\147\147\147\144\144\145\145\145\146\145\145","he\147\147\147\145\144\144\145\146\145\146\145","ic\145\144\144\145\145\145\145\144\145\145\146\145\145","jc\145\145\144\144\145\144\145","jm\145","kc\145\146\145\144\145\144\146\145\145\146\145\145\145\145","lc\145\145\146\145\145\145\146\145\145\145\145\146\145\145","mc\145\145\145\144\145\146\145\146\146\145\146\145","nc\145\145","nk\145\145","oc\145"
ZXBASIC_LINE_5460:
; 5460  DATA 16,8,14,"bd\145\145\145\145\145\145\145\145","cd\145","ck\145\144\145\145","dd\145\144\145\146\145\146\145\146\145\145\146\145","ed\145\145\145\145\145\145\145\144\146\145\145\145","ff\146\145\145\146\146\144\145\145","gf\145\145\144\144\145\144\145\146","hg\146\144\145\145\145\146\145\145","ig\145\145\146\145\146\145","jg\145\144\145\145\145\146\145\145","kg\145\144\144\145\145\145\144\145","lg\145\145","ln\145","mf\145\145\145\145\145\145\145\145\145","nf\147\147\147\147\147\147\147","of\147\147\147\147\147\147\147"
; 		5460.1  DATA 16{00 00 10 00 00 },8{00 00 08 00 00 },14{00 00 0e 00 00 },"bd\145\145\145\145\145\145\145\145","cd\145","ck\145\144\145\145","dd\145\144\145\146\145\146\145\146\145\145\146\145","ed\145\145\145\145\145\145\145\144\146\145\145\145","ff\146\145\145\146\146\144\145\145","gf\145\145\144\144\145\144\145\146","hg\146\144\145\145\145\146\145\145","ig\145\145\146\145\146\145","jg\145\144\145\145\145\146\145\145","kg\145\144\144\145\145\145\144\145","lg\145\145","ln\145","mf\145\145\145\145\145\145\145\145\145","nf\147\147\147\147\147\147\147","of\147\147\147\147\147\147\147"
ZXBASIC_LINE_5470:
; 5470  DATA 10,9,8,"ek\145\145","fc\145\145\146\145\145\145\145\145\145\146\145","gb\145\145\145\144\144\145\144\144\145\145\145\144\144\147\147\147","hb\145\144\146\146\145\146\145\146\146\144\146\144\144\147\147\147","ib\145\144\145\145\145\145\145\145\145\144\145\145\145\147\147\147","jb\145\145\146\144\145","jj\146\146\145\145\145\147\147\147","kb\145\146\145\145\146\146\145\145\146\145\144\144\147\147\147\147","ld\146\145\145\145\145\145\145\145","md\145\145"
; 		5470.1  DATA 10{00 00 0a 00 00 },9{00 00 09 00 00 },8{00 00 08 00 00 },"ek\145\145","fc\145\145\146\145\145\145\145\145\145\146\145","gb\145\145\145\144\144\145\144\144\145\145\145\144\144\147\147\147","hb\145\144\146\146\145\146\145\146\146\144\146\144\144\147\147\147","ib\145\144\145\145\145\145\145\145\145\144\145\145\145\147\147\147","jb\145\145\146\144\145","jj\146\146\145\145\145\147\147\147","kb\145\146\145\145\146\146\145\145\146\145\144\144\147\147\147\147","ld\146\145\145\145\145\145\145\145","md\145\145"
ZXBASIC_LINE_5480:
; 5480  DATA 15,14,10,"bg\150\147\150\144\150\147\150","cg\147\150\147\150\147\150\147","dg\150\147\150\147\150\147\150","eg\147\150\147\150\147\150\147","fg\150\147\150\147\150\147\150","gi\145\145\145","hi\145\145\145","ij\145","je\145\145\145\145\145\145\145\145\145\145\145","ke\145\146\145\146\145\146\145\146\145\146\145","lf\145\146\145\146\145\146\145\146\145","mf\146\145\146\145\146\145\146\145\146","nf\145\145\145\146\145\146\145\145\145","of\145\145","om\145\145"
; 		5480.1  DATA 15{00 00 0f 00 00 },14{00 00 0e 00 00 },10{00 00 0a 00 00 },"bg\150\147\150\144\150\147\150","cg\147\150\147\150\147\150\147","dg\150\147\150\147\150\147\150","eg\147\150\147\150\147\150\147","fg\150\147\150\147\150\147\150","gi\145\145\145","hi\145\145\145","ij\145","je\145\145\145\145\145\145\145\145\145\145\145","ke\145\146\145\146\145\146\145\146\145\146\145","lf\145\146\145\146\145\146\145\146\145","mf\146\145\146\145\146\145\146\145\146","nf\145\145\145\146\145\146\145\145\145","of\145\145","om\145\145"
ZXBASIC_LINE_5490:
; 5490  DATA 16,13,9,"cj\145\145","dj\145\145\145","ej\145\146\146\145","fj\146\145\145\146\145","gh\145\145\145\145\146\145\145\145","he\145\145\144\145","hn\145\145","ic\145\145\145\145\144\145\144\147\147\147\147\146\145","jc\145\144\145\145\145\146\145\147\147\147\147\144\145","kc\145\145\146\145\144\145\144\147\150\147\147\144\145","le\145\145","lk\145","lo\145","mh\145\145\146\145\145\144\144\146","nj\145\146\145\145\145\145\145","oj\145\145\144\144\145\145\145"
; 		5490.1  DATA 16{00 00 10 00 00 },13{00 00 0d 00 00 },9{00 00 09 00 00 },"cj\145\145","dj\145\145\145","ej\145\146\146\145","fj\146\145\145\146\145","gh\145\145\145\145\146\145\145\145","he\145\145\144\145","hn\145\145","ic\145\145\145\145\144\145\144\147\147\147\147\146\145","jc\145\144\145\145\145\146\145\147\147\147\147\144\145","kc\145\145\146\145\144\145\144\147\150\147\147\144\145","le\145\145","lk\145","lo\145","mh\145\145\146\145\145\144\144\146","nj\145\146\145\145\145\145\145","oj\145\145\144\144\145\145\145"
ZXBASIC_LINE_5500:
; 5500  DATA 19,8,3,"bh\147\147\145\145\145\145\144\145\145\145","cg\147\147\150\145\146\145\145\145\145\146\145","df\147\147\150\147\144\145\144\145\144\146\145","ee\147\147\150\147\144\145\144\145\144\145\146\145\145","fe\147\147\147\144\145\145\144\145\145\145\145\144\145","gb\145\145\144\144\145\144\145\145\145\145\145\145\145\145\145\145","hb\145\145\146\145\146\145","hk\145\145\144\145\144\145","ib\145\146\145\145\145\146\145\145\145\144\145\144\145\145\145","jd\146\146\145\145\145\144\145\144\145\144\145\144\145","kd\145\145\145\146\145\145\145\144\145\144\145","ld\145\146\144\145","lm\145\145\145\145\145\145","md\146\145\145\145","mm\145\145\145\144\145\145","nd\145\145","od\145\145","nn\145\145\145\145\145","on\145\145\145\145"
; 		5500.1  DATA 19{00 00 13 00 00 },8{00 00 08 00 00 },3{00 00 03 00 00 },"bh\147\147\145\145\145\145\144\145\145\145","cg\147\147\150\145\146\145\145\145\145\146\145","df\147\147\150\147\144\145\144\145\144\146\145","ee\147\147\150\147\144\145\144\145\144\145\146\145\145","fe\147\147\147\144\145\145\144\145\145\145\145\144\145","gb\145\145\144\144\145\144\145\145\145\145\145\145\145\145\145\145","hb\145\145\146\145\146\145","hk\145\145\144\145\144\145","ib\145\146\145\145\145\146\145\145\145\144\145\144\145\145\145","jd\146\146\145\145\145\144\145\144\145\144\145\144\145","kd\145\145\145\146\145\145\145\144\145\144\145","ld\145\146\144\145","lm\145\145\145\145\145\145","md\146\145\145\145","mm\145\145\145\144\145\145","nd\145\145","od\145\145","nn\145\145\145\145\145","on\145\145\145\145"
ZXBASIC_LINE_9990:
; 9990  LET a = CODE  INKEY$ 
; 		9990.1  LET a = CODE  INKEY$ 
; CODE
; INKEY$
	CALL runtimeInkey
	CALL runtimeCode
	LD (ZXBASIC_VAR_a),HL
	CALL ZXFreeTempCompact
ZXBASIC_LINE_9991:
; 9991  PRINT  AT 0,0;a;" <"; INKEY$ ;">";
; 		9991.1  PRINT  AT 0{00 00 00 00 00 },0{00 00 00 00 00 };a;" <"; INKEY$ ;">";
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,0
	LD HL,0
	CALL runtimePrintAt
	LD HL,(ZXBASIC_VAR_a)
	CALL runtimePrintInt
	LD HL,STRING_48	; <
	CALL runtimePrintString
; INKEY$
	CALL runtimeInkey
	CALL runtimePrintString
	LD HL,STRING_27	;>
	CALL runtimePrintString
	POP AF
	LD (ZX_P_FLAG),A
	CALL ZXFreeTempCompact
ZXBASIC_LINE_9992:
; 9992  GOTO 9990
; 		9992.1  GOTO 9990{00 00 06 27 00 }
	JP ZXBASIC_LINE_9990
ZXBASIC_LINE_9993:
; 9993  IF a=32 THEN  RETURN 
; 		9993.1  IF a=32{00 00 20 00 00 } THEN  RETURN 
	LD DE,(ZXBASIC_VAR_a)
	LD HL,32
; =
	CALL runtimeCmpHLEqDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_62
; 		9993.2  RETURN 
	RET
ZXB_LABEL_62:
ZXBASIC_LINE_9995:
; 9995  GOTO 9990
; 		9995.1  GOTO 9990{00 00 06 27 00 }
	JP ZXBASIC_LINE_9990
ZXBASIC_LINE_9998:
; 9998  STOP 
ZXBASIC_VAR_a:	dw 0
ZXBASIC_VAR_b:	dw 0
ZXBASIC_VAR_b_string:	dw 0
ZXBASIC_VAR_c:	dw 0
ZXBASIC_VAR_cod:	dw 0
ZXBASIC_VAR_cont:	dw 0
ZXBASIC_VAR_d_string:	dw 0
ZXBASIC_VAR_f:	dw 0
ZXBASIC_VAR_for_b:	dw 0
ZXBASIC_VAR_for_c:	dw 0
ZXBASIC_VAR_for_l:	dw 0
ZXBASIC_VAR_for_n:	dw 0
ZXBASIC_VAR_for_r:	dw 0
ZXBASIC_VAR_for_y:	dw 0
ZXBASIC_VAR_h_string:	defs 2002
ZXBASIC_VAR_hm:	dw 0
ZXBASIC_VAR_i:	dw 0
ZXBASIC_VAR_i_string:	dw 0
ZXBASIC_VAR_index:	dw 0
ZXBASIC_VAR_k_string:	dw 0
ZXBASIC_VAR_key:	dw 0
ZXBASIC_VAR_l:	dw 0
ZXBASIC_VAR_l_string:	dw 0
ZXBASIC_VAR_last:	dw 0
ZXBASIC_VAR_m_string:	defs 720
ZXBASIC_VAR_moves:	dw 0
ZXBASIC_VAR_n:	dw 0
ZXBASIC_VAR_o_array:	defs 8
ZXBASIC_VAR_pull:	dw 0
ZXBASIC_VAR_pushes:	dw 0
ZXBASIC_VAR_q_string:	dw 0
ZXBASIC_VAR_r:	dw 0
ZXBASIC_VAR_r_string:	dw 0
ZXBASIC_VAR_s_array:	defs 6
ZXBASIC_VAR_s_string:	dw 0
ZXBASIC_VAR_targets:	dw 0
ZXBASIC_VAR_u_string:	dw 0
ZXBASIC_VAR_vm:	dw 0
ZXBASIC_VAR_x:	dw 0
ZXBASIC_VAR_y:	dw 0
ZXBASIC_VAR_y_string:	dw 0
STRING_0:	dw 1
	db	"k"
STRING_1:	dw 1
	db	"m"
STRING_10:	dw 7
	db	", undo="
STRING_11:	dw 1
	db	"."
STRING_12:	dw 1
	db	" "
STRING_13:	dw 0
STRING_14:	dw 13
	db	"key for left?"
STRING_15:	dw 14
	db	"key for right?"
STRING_16:	dw 14
	db	"key for up?   "
STRING_17:	dw 13
	db	"key for down?"
STRING_18:	dw 21
	db	"key to restart level?"
STRING_19:	dw 21
	db	"key to undo move?    "
STRING_2:	dw 1
	db	"z"
STRING_20:	dw 29
	db	"G A M E   O V E R ! ! ! ! ! !"
STRING_21:	dw 15
	db	"SOKOBAN Level: "
STRING_22:	dw 12
	db	"Keys (UDLR)="
STRING_23:	dw 7
	db	", UNDO="
STRING_24:	dw 1
	db	","
STRING_25:	dw 8
	db	"Restart="
STRING_26:	dw 1
	db	"<"
STRING_27:	dw 1
	db	">"
STRING_28:	dw 26
	db	"Restart level. Sure? (y/n)"
STRING_29:	dw 1
	db	"y"
STRING_3:	dw 1
	db	"x"
STRING_30:	dw 1
	db	"n"
STRING_31:	dw 31
	db	"W E L L   D O N E ! ! ! ! ! ! !"
STRING_32:	dw 32
	db	"WELL DONE - ALL LEVELS COMPLETED"
STRING_33:	dw 1
	db	$92
STRING_34:	dw 1
	db	$91
STRING_35:	dw 1
	db	$96
STRING_36:	dw 1
	db	$93
STRING_37:	dw 1
	db	"h"
STRING_38:	dw 1
	db	"H"
STRING_39:	dw 1
	db	"t"
STRING_4:	dw 1
	db	"q"
STRING_40:	dw 1
	db	"T"
STRING_41:	dw 1
	db	$94
STRING_42:	dw 1
	db	$95
STRING_43:	dw 1
	db	"a"
STRING_44:	dw 11
	db	"Crates 'on'"
STRING_45:	dw 7
	db	"Moves: "
STRING_46:	dw 7
	db	"Pushes:"
STRING_47:	dw 19
	db	$90, $90, $90, $90, $90, $90, $90, $90, $90, $90, $90, $90, $90, $90, $90, $90, $90, $90, $90
STRING_48:	dw 2
	db	" <"
STRING_5:	dw 1
	db	"u"
STRING_6:	dw 32
	db	"Sokoban in BASIC by Simon Ferre'"
STRING_7:	dw 31
	db	"ENTER-play, SPACE-redefine keys"
STRING_8:	dw 7
	db	"(lrud)="
STRING_9:	dw 10
	db	", restart="
ZXDATA:
	dw 1010, DATA_1010
	dw 5000, DATA_5000
	dw 5010, DATA_5010
	dw 5020, DATA_5020
	dw 5030, DATA_5030
	dw 5040, DATA_5040
	dw 5050, DATA_5050
	dw 5060, DATA_5060
	dw 5070, DATA_5070
	dw 5080, DATA_5080
	dw 5090, DATA_5090
	dw 5100, DATA_5100
	dw 5110, DATA_5110
	dw 5120, DATA_5120
	dw 5130, DATA_5130
	dw 5140, DATA_5140
	dw 5150, DATA_5150
	dw 5160, DATA_5160
	dw 5170, DATA_5170
	dw 5180, DATA_5180
	dw 5190, DATA_5190
	dw 5200, DATA_5200
	dw 5210, DATA_5210
	dw 5220, DATA_5220
	dw 5230, DATA_5230
	dw 5240, DATA_5240
	dw 5250, DATA_5250
	dw 5260, DATA_5260
	dw 5270, DATA_5270
	dw 5280, DATA_5280
	dw 5290, DATA_5290
	dw 5300, DATA_5300
	dw 5310, DATA_5310
	dw 5320, DATA_5320
	dw 5330, DATA_5330
	dw 5340, DATA_5340
	dw 5350, DATA_5350
	dw 5360, DATA_5360
	dw 5370, DATA_5370
	dw 5380, DATA_5380
	dw 5390, DATA_5390
	dw 5400, DATA_5400
	dw 5410, DATA_5410
	dw 5420, DATA_5420
	dw 5430, DATA_5430
	dw 5440, DATA_5440
	dw 5450, DATA_5450
	dw 5460, DATA_5460
	dw 5470, DATA_5470
	dw 5480, DATA_5480
	dw 5490, DATA_5490
	dw 5500, DATA_5500
	dw 0, 0
DATAPTR:	DW 0
DATA_1010:
	dw 85
	dw 129
	dw 1
	dw 129
	dw 1
	dw 129
	dw 1
	dw 255
	dw 0
	dw 0
	dw 8
	dw 56
	dw 28
	dw 16
	dw 0
	dw 0
	dw 0
	dw 42
	dw 124
	dw 70
	dw 68
	dw 70
	dw 124
	dw 0
	dw 255
	dw 255
	dw 247
	dw 199
	dw 227
	dw 239
	dw 255
	dw 255
	dw 24
	dw 60
	dw 90
	dw 255
	dw 219
	dw 102
	dw 60
	dw 24
	dw 231
	dw 195
	dw 165
	dw 0
	dw 36
	dw 153
	dw 195
	dw 231
	dw 255
	dw 213
	dw 131
	dw 185
	dw 187
	dw 185
	dw 131
	dw 255
DATA_5000:
	dw 26
	dw 2
	dw 2
	dw 19
	db "bb", $91, $91, $91, $91, $91, $91, $91, $91, $91, $91, $91, $91, $91, $91, $91, $91, $91
	dw 19
	db "ib", $91, $91, $91, $91, $91, $91, $91, $91, $91, $91, $91, $91, $91, $91, $91, $91, $91
	dw 19
	db "pb", $91, $91, $91, $91, $91, $91, $91, $91, $91, $91, $91, $91, $91, $91, $91, $91, $91
	dw 3
	db "cb", $91
	dw 3
	db "cf", $91
	dw 7
	db "cj", $91, $90, $92, $90, $91
	dw 3
	db "cr", $91
	dw 19
	db "db", $91, $90, $93, $92, $91, $90, $91, $90, $91, $90, $93, $90, $91, $90, $91, $90, $91
	dw 3
	db "eb", $91
	dw 15
	db "ef", $91, $90, $91, $90, $91, $90, $90, $91, $91, $90, $91, $90, $91
	dw 19
	db "fb", $91, $91, $91, $90, $91, $90, $91, $90, $91, $90, $91, $90, $91, $90, $91, $90, $91
	dw 19
	db "gb", $91, $91, $91, $90, $91, $90, $91, $90, $91, $90, $91, $90, $91, $90, $91, $90, $91
	dw 3
	db "hb", $91
	dw 3
	db "hf", $91
	dw 7
	db "hj", $91, $90, $91, $90, $91
	dw 3
	db "hr", $91
	dw 3
	db "jb", $91
	dw 15
	db "jf", $93, $91, $91, $90, $90, $91, $91, $90, $91, $91, $92, $90, $91
	dw 19
	db "kb", $91, $90, $91, $91, $90, $91, $90, $91, $91, $90, $91, $90, $90, $91, $91, $90, $91
	dw 3
	db "lb", $91
	dw 4
	db "lf", $91, $91
	dw 9
	db "ll", $91, $90, $93, $90, $91, $90, $91
	dw 19
	db "mb", $91, $90, $91, $91, $90, $91, $90, $93, $93, $90, $91, $90, $91, $91, $90, $90, $91
	dw 19
	db "nb", $91, $90, $91, $91, $90, $91, $90, $92, $92, $90, $91, $90, $93, $92, $90, $90, $91
	dw 3
	db "ob", $91
	dw 15
	db "of", $91, $91, $90, $91, $91, $90, $91, $90, $92, $91, $91, $90, $91
DATA_5010:
	dw 10
	dw 11
	dw 12
	dw 5
	db "df", $91, $91, $91
	dw 5
	db "ef", $92, $91, $91
	dw 5
	db "ff", $91, $91, $92
	dw 8
	db "gd", $91, $91, $92, $91, $92, $91
	dw 8
	db "hd", $91, $90, $91, $90, $90, $91
	dw 10
	db "ib", $91, $91, $91, $90, $91, $90, $90, $91
	dw 6
	db "io", $91, $91, $93, $93
	dw 19
	db "jb", $91, $92, $91, $91, $92, $91, $91, $91, $91, $91, $91, $91, $91, $91, $91, $93, $93
	dw 15
	db "kf", $91, $90, $90, $90, $91, $90, $91, $90, $90, $91, $91, $93, $93
	dw 7
	db "lf", $91, $91, $91, $91, $91
DATA_5020:
	dw 8
	dw 8
	dw 11
	dw 12
	db "ee", $93, $93, $91, $91, $90, $91, $91, $91, $91, $91
	dw 14
	db "fe", $93, $93, $91, $91, $90, $91, $92, $91, $91, $92, $91, $91
	dw 14
	db "ge", $93, $93, $91, $91, $90, $92, $90, $90, $90, $90, $91, $91
	dw 14
	db "he", $93, $93, $91, $91, $91, $91, $91, $91, $90, $90, $91, $91
	dw 13
	db "ie", $93, $93, $91, $91, $90, $91, $90, $91, $91, $92, $91
	dw 9
	db "jj", $91, $90, $90, $92, $91, $92, $91
	dw 12
	db "kg", $91, $92, $91, $91, $92, $91, $92, $91, $92, $91
	dw 12
	db "lg", $91, $91, $91, $91, $90, $91, $91, $91, $91, $91
DATA_5030:
	dw 9
	dw 5
	dw 16
	dw 8
	db "ek", $91, $91, $91, $91, $91, $91
	dw 7
	db "fk", $91, $92, $90, $92, $91
	dw 7
	db "gk", $91, $92, $91, $91, $92
	dw 6
	db "hl", $92, $91, $92, $91
	dw 7
	db "ik", $91, $92, $91, $90, $91
	dw 8
	db "jc", $93, $93, $93, $93, $91, $91
	dw 9
	db "jk", $91, $92, $91, $91, $92, $91, $91
	dw 16
	db "kd", $93, $93, $93, $91, $91, $91, $91, $92, $91, $91, $92, $91, $91, $91
	dw 8
	db "lc", $93, $93, $93, $93, $91, $91
DATA_5040:
	dw 12
	dw 13
	dw 11
	dw 8
	db "cm", $91, $91, $93, $93, $93, $93
	dw 8
	db "dm", $91, $91, $93, $93, $93, $93
	dw 19
	db "eb", $91, $91, $91, $91, $90, $91, $91, $92, $91, $92, $91, $91, $91, $93, $93, $93, $93
	dw 19
	db "fb", $91, $92, $92, $92, $90, $92, $91, $91, $92, $91, $90, $91, $91, $93, $93, $93, $93
	dw 19
	db "gb", $91, $91, $92, $91, $91, $91, $91, $91, $92, $91, $90, $91, $91, $93, $93, $93, $93
	dw 12
	db "hb", $91, $92, $92, $91, $90, $92, $91, $92, $91, $92
	dw 12
	db "ib", $91, $91, $92, $91, $90, $91, $91, $91, $91, $91
	dw 3
	db "jc", $91
	dw 11
	db "kb", $91, $91, $91, $91, $90, $91, $91, $91, $91
	dw 11
	db "lb", $91, $91, $91, $91, $91, $92, $91, $91, $91
	dw 12
	db "mb", $91, $91, $92, $92, $90, $92, $92, $91, $91, $91
	dw 11
	db "nb", $91, $91, $91, $91, $90, $91, $91, $91, $91
DATA_5050:
	dw 11
	dw 10
	dw 16
	dw 5
	db "dk", $91, $91, $91
	dw 9
	db "ek", $91, $90, $92, $90, $90, $91, $91
	dw 9
	db "fk", $91, $91, $91, $91, $91, $92, $91
	dw 9
	db "gk", $91, $90, $90, $90, $91, $91, $91
	dw 15
	db "hc", $93, $93, $93, $93, $91, $91, $90, $90, $91, $92, $91, $91, $92
	dw 15
	db "ic", $93, $93, $93, $93, $91, $91, $91, $91, $92, $91, $92, $92, $91
	dw 16
	db "jc", $93, $93, $93, $93, $91, $91, $90, $90, $92, $91, $91, $92, $91, $91
	dw 7
	db "kk", $91, $91, $92, $91, $91
	dw 8
	db "lk", $91, $92, $91, $92, $91, $91
	dw 6
	db "mm", $91, $90, $90, $91
	dw 6
	db "nm", $91, $91, $91, $91
DATA_5060:
	dw 12
	dw 5
	dw 13
	dw 6
	db "ee", $93, $93, $91, $91
	dw 3
	db "em", $91
	dw 6
	db "fe", $93, $93, $91, $91
	dw 5
	db "fl", $91, $91, $91
	dw 12
	db "ge", $93, $93, $91, $91, $91, $91, $91, $92, $92, $91
	dw 12
	db "he", $93, $93, $91, $91, $90, $91, $90, $91, $92, $91
	dw 4
	db "ie", $93, $93
	dw 7
	db "ij", $91, $90, $91, $92, $91
	dw 9
	db "jh", $91, $92, $91, $90, $92, $91, $91
	dw 9
	db "kh", $91, $91, $92, $90, $91, $92, $91
	dw 9
	db "lh", $91, $92, $91, $91, $92, $91, $91
	dw 9
	db "mh", $91, $91, $90, $90, $91, $91, $91
DATA_5070:
	dw 15
	dw 5
	dw 9
	dw 5
	db "dl", $91, $91, $91
	dw 12
	db "ef", $91, $90, $91, $91, $90, $90, $91, $92, $92, $91
	dw 13
	db "fe", $91, $91, $91, $91, $92, $91, $91, $91, $91, $91, $91
	dw 7
	db "ge", $91, $91, $92, $91, $91
	dw 5
	db "gm", $91, $91, $91
	dw 3
	db "hg", $91
	dw 3
	db "hm", $92
	dw 6
	db "ie", $91, $92, $91, $91
	dw 5
	db "il", $91, $93, $93
	dw 12
	db "je", $91, $92, $91, $92, $91, $92, $91, $93, $93, $93
	dw 6
	db "ke", $91, $91, $91, $91
	dw 5
	db "kl", $93, $93, $93
	dw 6
	db "le", $91, $92, $92, $91
	dw 5
	db "ll", $93, $93, $93
	dw 4
	db "me", $91, $91
DATA_5080:
	dw 15
	dw 7
	dw 3
	dw 4
	db "be", $91, $91
	dw 14
	db "ce", $91, $91, $91, $91, $92, $91, $91, $91, $92, $91, $92, $91
	dw 14
	db "de", $91, $92, $90, $91, $92, $91, $90, $91, $91, $92, $91, $91
	dw 14
	db "ee", $91, $91, $92, $91, $92, $91, $91, $90, $91, $91, $91, $91
	dw 9
	db "fe", $91, $92, $90, $91, $90, $91, $91
	dw 3
	db "fp", $91
	dw 16
	db "gc", $91, $90, $92, $91, $92, $91, $92, $91, $91, $90, $90, $91, $91, $91
	dw 16
	db "hc", $91, $91, $91, $91, $92, $91, $90, $92, $90, $91, $91, $91, $90, $91
	dw 16
	db "ic", $91, $91, $91, $92, $91, $91, $91, $91, $92, $91, $92, $91, $92, $91
	dw 4
	db "jg", $91, $91
	dw 8
	db "ke", $91, $91, $91, $91, $91, $91
	dw 8
	db "le", $91, $91, $91, $91, $91, $91
	dw 8
	db "me", $93, $93, $93, $93, $93, $93
	dw 8
	db "ne", $93, $93, $93, $93, $93, $93
	dw 8
	db "oe", $93, $93, $93, $93, $93, $93
DATA_5090:
	dw 12
	dw 12
	dw 3
	dw 7
	db "cm", $91, $91, $93, $93, $93
	dw 7
	db "dm", $91, $91, $93, $93, $93
	dw 11
	db "ei", $91, $91, $91, $91, $91, $91, $93, $91, $93
	dw 11
	db "fi", $91, $91, $90, $90, $91, $91, $93, $93, $93
	dw 10
	db "gj", $91, $90, $90, $91, $91, $93, $93, $93
	dw 3
	db "hj", $91
	dw 7
	db "ih", $91, $92, $92, $92, $91
	dw 8
	db "jh", $91, $91, $92, $91, $92, $91
	dw 16
	db "kd", $91, $91, $91, $90, $92, $91, $92, $91, $91, $91, $90, $91, $91, $91
	dw 17
	db "lc", $91, $91, $92, $91, $91, $92, $91, $91, $91, $91, $92, $91, $91, $92, $91
	dw 8
	db "mh", $91, $92, $92, $91, $92, $91
	dw 8
	db "nh", $91, $91, $91, $91, $91, $91
DATA_5100:
	dw 18
	dw 2
	dw 3
	dw 3
	db "bc", $91
	dw 13
	db "bh", $91, $91, $91, $91, $91, $91, $91, $90, $91, $91, $91
	dw 19
	db "cb", $91, $92, $92, $91, $91, $91, $92, $92, $91, $91, $92, $91, $92, $91, $93, $93, $93
	dw 19
	db "db", $91, $91, $92, $92, $92, $90, $91, $91, $91, $91, $92, $91, $91, $90, $93, $93, $93
	dw 19
	db "eb", $91, $92, $91, $91, $91, $90, $91, $92, $92, $91, $92, $92, $91, $90, $93, $93, $93
	dw 17
	db "fd", $91, $91, $91, $90, $91, $91, $92, $91, $91, $91, $91, $90, $93, $93, $93
	dw 19
	db "gb", $91, $91, $91, $91, $91, $90, $91, $92, $91, $92, $91, $92, $91, $90, $93, $93, $93
	dw 6
	db "hb", $91, $91, $91, $91
	dw 3
	db "hl", $91
	dw 5
	db "hp", $93, $93, $93
	dw 18
	db "ic", $91, $90, $91, $91, $90, $91, $91, $92, $91, $92, $91, $91, $90, $93, $93, $93
	dw 19
	db "jb", $91, $91, $90, $90, $91, $90, $91, $92, $92, $91, $92, $91, $92, $90, $90, $93, $93
	dw 19
	db "kb", $91, $93, $93, $90, $91, $90, $91, $91, $92, $91, $91, $91, $91, $91, $91, $90, $93
	dw 19
	db "lb", $91, $93, $93, $90, $91, $90, $91, $92, $92, $92, $91, $92, $92, $92, $91, $90, $93
	dw 15
	db "mf", $91, $90, $91, $91, $91, $91, $91, $91, $91, $90, $91, $90, $93
	dw 3
	db "nf", $91
	dw 5
	db "np", $91, $90, $93
	dw 15
	db "of", $91, $91, $91, $91, $91, $91, $91, $91, $91, $91, $91, $90, $93
DATA_5110:
	dw 15
	dw 4
	dw 8
	dw 4
	db "cl", $91, $91
	dw 4
	db "dg", $91, $91
	dw 4
	db "dl", $92, $91
	dw 11
	db "ee", $91, $91, $91, $91, $91, $91, $92, $91, $91
	dw 11
	db "fd", $91, $91, $92, $91, $92, $92, $90, $90, $91
	dw 13
	db "gc", $91, $91, $90, $92, $90, $90, $91, $91, $91, $91, $91
	dw 12
	db "hc", $91, $90, $91, $92, $91, $92, $92, $91, $90, $91
	dw 14
	db "ic", $91, $91, $91, $92, $91, $90, $91, $91, $90, $91, $92, $91
	dw 16
	db "je", $91, $91, $91, $91, $90, $91, $91, $92, $92, $91, $90, $91, $91, $91
	dw 16
	db "ke", $91, $90, $90, $91, $92, $91, $91, $91, $91, $91, $91, $91, $91, $91
	dw 7
	db "lb", $93, $91, $91, $91, $91
	dw 4
	db "lj", $91, $91
	dw 7
	db "mb", $93, $93, $91, $93, $93
	dw 7
	db "nb", $93, $93, $93, $90, $93
	dw 7
	db "ob", $93, $93, $93, $93, $93
DATA_5120:
	dw 14
	dw 7
	dw 9
	dw 16
	db "dc", $91, $91, $91, $91, $91, $91, $91, $91, $91, $91, $91, $91, $91, $91
	dw 5
	db "ec", $91, $90, $91
	dw 7
	db "el", $91, $91, $91, $91, $91
	dw 16
	db "fc", $91, $90, $91, $91, $92, $91, $92, $91, $92, $91, $92, $90, $91, $91
	dw 16
	db "gc", $91, $90, $91, $91, $91, $92, $91, $92, $91, $91, $91, $90, $90, $91
	dw 11
	db "hc", $91, $90, $91, $91, $92, $91, $92, $91, $92
	dw 5
	db "ho", $93, $93, $93
	dw 17
	db "ic", $91, $90, $91, $91, $91, $92, $91, $92, $91, $91, $90, $90, $93, $93, $93
	dw 3
	db "jc", $91
	dw 13
	db "jg", $92, $92, $92, $91, $92, $91, $90, $90, $93, $93, $93
	dw 17
	db "kc", $91, $91, $91, $91, $91, $90, $91, $90, $90, $91, $90, $90, $93, $93, $93
	dw 13
	db "lg", $91, $91, $91, $90, $90, $91, $90, $90, $93, $93, $93
	dw 7
	db "mk", $91, $91, $91, $91, $91
	dw 7
	db "nk", $91, $91, $91, $91, $91
DATA_5130:
	dw 12
	dw 7
	dw 7
	dw 9
	db "de", $91, $91, $91, $90, $90, $91, $91
	dw 15
	db "ed", $91, $91, $91, $91, $91, $90, $91, $91, $90, $91, $91, $91, $91
	dw 19
	db "fb", $91, $91, $92, $91, $90, $92, $91, $90, $91, $91, $90, $91, $91, $93, $93, $93, $91
	dw 19
	db "gb", $91, $90, $91, $92, $90, $91, $92, $90, $90, $91, $90, $91, $90, $93, $90, $93, $91
	dw 19
	db "hb", $91, $91, $90, $91, $90, $92, $91, $91, $90, $91, $91, $91, $91, $93, $91, $93, $91
	dw 19
	db "ib", $91, $92, $91, $91, $91, $91, $92, $91, $90, $91, $90, $91, $90, $93, $90, $93, $91
	dw 19
	db "jb", $91, $91, $91, $90, $90, $91, $91, $90, $90, $92, $91, $92, $91, $93, $91, $93, $91
	dw 19
	db "kb", $91, $92, $91, $90, $91, $91, $91, $90, $91, $91, $90, $92, $90, $93, $90, $93, $91
	dw 18
	db "lc", $91, $92, $91, $91, $92, $91, $91, $91, $92, $91, $91, $92, $93, $93, $93, $91
	dw 4
	db "mc", $92, $91
	dw 10
	db "mk", $91, $91, $91, $91, $90, $90, $91, $91
	dw 4
	db "nc", $91, $91
DATA_5140:
	dw 20
	dw 3
	dw 11
	dw 7
	db "bi", $91, $91, $91, $91, $91
	dw 13
	db "cc", $91, $91, $91, $91, $91, $90, $91, $92, $91, $92, $91
	dw 9
	db "dc", $92, $92, $91, $90, $91, $91, $91
	dw 3
	db "ec", $91
	dw 13
	db "eg", $93, $93, $93, $93, $93, $93, $90, $90, $91, $91, $91
	dw 17
	db "fc", $91, $91, $91, $92, $93, $93, $93, $93, $93, $93, $90, $90, $91, $90, $91
	dw 3
	db "gc", $91
	dw 13
	db "gg", $93, $93, $93, $93, $93, $93, $91, $91, $91, $91, $91
	dw 5
	db "hc", $91, $91, $91
	dw 3
	db "hj", $91
	dw 5
	db "hn", $91, $90, $92
	dw 17
	db "ib", $91, $91, $90, $92, $91, $91, $91, $90, $91, $91, $92, $91, $91, $90, $91
	dw 17
	db "jb", $91, $91, $92, $91, $92, $92, $92, $91, $91, $90, $91, $92, $90, $90, $91
	dw 9
	db "kb", $91, $91, $91, $92, $91, $92, $91
	dw 7
	db "kl", $92, $92, $91, $90, $91
	dw 13
	db "lf", $91, $91, $91, $91, $91, $92, $91, $91, $91, $90, $91
	dw 3
	db "mh", $91
	dw 7
	db "ml", $91, $91, $91, $90, $91
	dw 11
	db "nh", $91, $91, $91, $91, $91, $90, $91, $91, $91
	dw 4
	db "oo", $91, $91
DATA_5150:
	dw 16
	dw 6
	dw 8
	dw 8
	db "bf", $91, $91, $91, $90, $91, $91
	dw 8
	db "cf", $91, $91, $92, $91, $91, $91
	dw 8
	db "df", $91, $90, $92, $91, $91, $91
	dw 13
	db "ed", $91, $91, $92, $91, $91, $90, $90, $92, $91, $91, $91
	dw 13
	db "fd", $91, $91, $90, $91, $91, $91, $92, $91, $90, $91, $92
	dw 13
	db "gd", $91, $91, $90, $91, $91, $91, $91, $91, $91, $92, $91
	dw 3
	db "he", $91
	dw 10
	db "hj", $92, $90, $90, $91, $91, $91, $91, $91
	dw 16
	db "id", $91, $92, $90, $93, $93, $93, $93, $93, $90, $91, $90, $91, $91, $91
	dw 14
	db "jd", $91, $91, $92, $93, $93, $96, $96, $93, $91, $92, $90, $91
	dw 14
	db "kd", $91, $91, $90, $93, $93, $93, $93, $93, $90, $91, $91, $91
	dw 5
	db "lc", $91, $91, $91
	dw 3
	db "lh", $91
	dw 10
	db "mc", $91, $92, $92, $91, $91, $90, $91, $91
	dw 10
	db "nc", $91, $91, $90, $91, $91, $91, $91, $91
	dw 5
	db "oh", $91, $91, $91
DATA_5160:
	dw 14
	dw 7
	dw 7
	dw 5
	db "ce", $91, $91, $91
	dw 6
	db "de", $91, $91, $91, $91
	dw 6
	db "ee", $91, $92, $91, $91
	dw 4
	db "em", $91, $91
	dw 12
	db "fe", $91, $91, $92, $92, $91, $92, $91, $91, $91, $92
	dw 10
	db "gg", $91, $91, $90, $92, $91, $91, $91, $91
	dw 12
	db "hf", $91, $91, $90, $90, $91, $91, $92, $91, $92, $91
	dw 13
	db "if", $91, $92, $91, $91, $90, $90, $91, $90, $90, $91, $93
	dw 13
	db "jf", $91, $91, $90, $92, $90, $90, $92, $91, $91, $90, $93
	dw 11
	db "kh", $91, $91, $91, $92, $93, $93, $90, $90, $93
	dw 12
	db "lg", $91, $91, $91, $91, $90, $93, $96, $93, $93, $93
	dw 12
	db "mg", $91, $92, $92, $91, $90, $93, $93, $93, $93, $93
	dw 4
	db "ng", $91, $91
	dw 4
	db "og", $91, $91
DATA_5170:
	dw 14
	dw 12
	dw 5
	dw 10
	db "cg", $93, $93, $91, $91, $90, $91, $91, $91
	dw 10
	db "dg", $93, $93, $91, $91, $91, $91, $91, $91
	dw 9
	db "eg", $93, $93, $91, $91, $90, $91, $91
	dw 7
	db "fl", $91, $91, $90, $91, $91
	dw 14
	db "gf", $91, $91, $91, $91, $91, $91, $91, $91, $91, $91, $91, $91
	dw 14
	db "hf", $91, $91, $90, $91, $91, $90, $90, $91, $91, $90, $91, $91
	dw 7
	db "ig", $91, $90, $90, $91, $91
	dw 3
	db "ip", $91
	dw 7
	db "jd", $91, $91, $92, $91, $91
	dw 6
	db "jn", $91, $90, $91, $91
	dw 16
	db "kd", $91, $90, $91, $92, $91, $91, $92, $91, $91, $90, $91, $92, $91, $91
	dw 15
	db "ld", $91, $91, $92, $91, $91, $92, $91, $91, $91, $90, $91, $91, $91
	dw 6
	db "mg", $91, $90, $90, $91
	dw 6
	db "ng", $91, $91, $91, $91
DATA_5180:
	dw 13
	dw 5
	dw 14
	dw 11
	db "dg", $91, $91, $93, $91, $91, $90, $91, $91, $91
	dw 11
	db "eg", $91, $90, $93, $91, $91, $91, $91, $91, $91
	dw 9
	db "fg", $91, $90, $90, $93, $93, $90, $91
	dw 8
	db "gc", $91, $91, $90, $91, $93, $93
	dw 7
	db "gl", $91, $91, $91, $91, $91
	dw 19
	db "hb", $91, $92, $91, $90, $93, $93, $93, $91, $91, $91, $92, $91, $90, $91, $91, $92, $91
	dw 19
	db "ib", $91, $91, $91, $91, $93, $93, $91, $90, $90, $91, $91, $90, $90, $91, $90, $90, $91
	dw 16
	db "je", $92, $90, $90, $92, $90, $91, $92, $91, $90, $91, $91, $91, $90, $91
	dw 16
	db "ke", $91, $90, $91, $91, $91, $91, $90, $92, $91, $92, $92, $91, $90, $91
	dw 17
	db "ld", $91, $91, $92, $91, $90, $91, $90, $91, $91, $90, $91, $92, $90, $90, $91
	dw 17
	db "md", $91, $91, $91, $91, $91, $91, $91, $91, $91, $91, $91, $91, $91, $91, $91
	dw 4
	db "nd", $91, $91
	dw 4
	db "nq", $91, $91
DATA_5190:
	dw 18
	dw 2
	dw 7
	dw 6
	db "bd", $91, $91, $91, $91
	dw 7
	db "cf", $91, $92, $91, $91, $91
	dw 11
	db "db", $91, $91, $91, $90, $90, $91, $91, $91, $91
	dw 14
	db "eb", $91, $92, $91, $90, $91, $91, $90, $90, $91, $91, $91, $91
	dw 8
	db "fb", $91, $92, $91, $90, $91, $91
	dw 3
	db "fm", $91
	dw 13
	db "gc", $91, $92, $91, $91, $92, $91, $91, $91, $91, $90, $91
	dw 7
	db "hc", $91, $92, $91, $92, $91
	dw 5
	db "hk", $91, $90, $91
	dw 13
	db "ic", $91, $90, $91, $91, $92, $91, $91, $90, $91, $90, $91
	dw 13
	db "jc", $91, $90, $91, $90, $92, $90, $91, $91, $91, $90, $91
	dw 3
	db "kc", $91
	dw 9
	db "kg", $91, $91, $91, $90, $91, $90, $91
	dw 7
	db "lb", $91, $91, $92, $91, $91
	dw 10
	db "lk", $91, $90, $91, $90, $93, $93, $93, $93
	dw 19
	db "mb", $91, $91, $91, $91, $92, $91, $91, $91, $91, $92, $91, $91, $91, $93, $93, $90, $93
	dw 16
	db "ne", $92, $91, $91, $92, $90, $91, $92, $91, $91, $91, $93, $93, $93, $93
	dw 19
	db "ob", $91, $91, $91, $91, $91, $91, $91, $90, $91, $91, $90, $90, $91, $93, $93, $93, $93
DATA_5200:
	dw 21
	dw 3
	dw 15
	dw 10
	db "bf", $91, $91, $91, $91, $91, $91, $91, $91
	dw 17
	db "cb", $91, $91, $91, $91, $91, $90, $91, $91, $91, $92, $91, $91, $90, $91, $91
	dw 3
	db "db", $91
	dw 3
	db "dj", $92
	dw 4
	db "do", $91, $91
	dw 19
	db "eb", $91, $90, $91, $91, $91, $91, $90, $90, $91, $90, $91, $91, $90, $92, $91, $93, $93
	dw 19
	db "fb", $91, $90, $91, $92, $91, $91, $91, $91, $91, $90, $91, $91, $90, $91, $91, $90, $93
	dw 19
	db "gb", $91, $90, $91, $92, $91, $91, $90, $91, $91, $91, $91, $91, $90, $92, $91, $93, $93
	dw 6
	db "hb", $91, $90, $91, $91
	dw 12
	db "hi", $91, $90, $90, $91, $91, $91, $91, $91, $90, $93
	dw 3
	db "ib", $91
	dw 15
	db "if", $91, $91, $90, $91, $91, $90, $91, $91, $90, $92, $91, $93, $93
	dw 11
	db "jb", $91, $90, $91, $91, $91, $91, $90, $91, $91
	dw 6
	db "jo", $91, $91, $90, $93
	dw 19
	db "kb", $91, $90, $92, $91, $91, $91, $92, $91, $91, $92, $91, $91, $90, $92, $91, $93, $93
	dw 19
	db "lb", $91, $91, $91, $91, $92, $91, $90, $91, $92, $91, $92, $91, $90, $91, $91, $90, $93
	dw 4
	db "me", $91, $92
	dw 11
	db "mj", $91, $91, $91, $91, $90, $92, $91, $93, $93
	dw 9
	db "ne", $91, $91, $91, $91, $92, $92, $91
	dw 6
	db "no", $93, $93, $93, $93
	dw 8
	db "oe", $91, $91, $91, $91, $91, $91
DATA_5210:
	dw 14
	dw 6
	dw 7
	dw 9
	db "cd", $91, $91, $91, $91, $91, $91, $91
	dw 9
	db "dd", $91, $91, $91, $91, $91, $91, $91
	dw 3
	db "ee", $91
	dw 6
	db "ej", $91, $90, $91, $91
	dw 11
	db "fe", $91, $90, $91, $90, $90, $91, $91, $91, $91
	dw 12
	db "gd", $91, $92, $92, $92, $91, $92, $91, $91, $92, $92
	dw 12
	db "hd", $91, $91, $90, $91, $90, $90, $91, $92, $91, $91
	dw 12
	db "id", $91, $91, $90, $91, $90, $90, $91, $91, $92, $91
	dw 12
	db "jg", $91, $91, $92, $92, $92, $91, $92, $90, $91, $91
	dw 14
	db "ke", $91, $91, $91, $90, $90, $91, $91, $91, $93, $93, $93, $93
	dw 14
	db "le", $91, $90, $91, $91, $91, $90, $91, $90, $93, $93, $91, $93
	dw 14
	db "me", $91, $91, $91, $90, $91, $90, $91, $90, $90, $93, $93, $93
	dw 10
	db "ni", $91, $92, $91, $91, $90, $93, $93, $93
	dw 5
	db "oj", $91, $91, $91
DATA_5220:
	dw 21
	dw 5
	dw 11
	dw 6
	db "bb", $91, $91, $91, $91
	dw 4
	db "bm", $91, $91
	dw 19
	db "cb", $91, $91, $91, $92, $90, $91, $91, $90, $91, $91, $92, $91, $91, $90, $91, $91, $91
	dw 19
	db "db", $91, $91, $92, $91, $91, $92, $91, $91, $92, $91, $90, $91, $92, $91, $92, $91, $91
	dw 18
	db "ec", $92, $91, $92, $91, $91, $91, $90, $91, $91, $90, $91, $92, $91, $91, $91, $91
	dw 6
	db "fb", $91, $91, $92, $91
	dw 3
	db "fq", $91
	dw 18
	db "gb", $91, $90, $91, $91, $91, $90, $93, $93, $93, $93, $93, $93, $93, $90, $91, $92
	dw 18
	db "hb", $91, $90, $90, $91, $91, $90, $91, $93, $93, $93, $93, $93, $93, $90, $91, $91
	dw 18
	db "ib", $91, $90, $91, $91, $91, $92, $93, $93, $93, $93, $93, $93, $93, $93, $92, $91
	dw 18
	db "jb", $91, $90, $91, $92, $91, $90, $93, $93, $93, $93, $91, $93, $93, $90, $91, $91
	dw 7
	db "kb", $91, $91, $92, $91, $92
	dw 3
	db "kk", $92
	dw 4
	db "kp", $91, $92
	dw 7
	db "lb", $91, $92, $91, $91, $91
	dw 10
	db "lj", $91, $92, $91, $91, $91, $92, $91, $91
	dw 19
	db "mb", $91, $92, $91, $91, $91, $91, $91, $92, $91, $92, $91, $91, $92, $91, $91, $91, $91
	dw 3
	db "nc", $91
	dw 5
	db "nj", $91, $92, $91
	dw 3
	db "nr", $91
	dw 19
	db "ob", $91, $91, $91, $91, $91, $91, $91, $91, $91, $90, $91, $91, $91, $91, $91, $91, $91
DATA_5230:
	dw 14
	dw 9
	dw 4
	dw 7
	db "cf", $91, $91, $90, $91, $91
	dw 10
	db "df", $91, $92, $90, $92, $91, $90, $91, $91
	dw 15
	db "eb", $93, $93, $91, $90, $91, $91, $90, $91, $91, $90, $91, $91, $91
	dw 15
	db "fb", $93, $93, $91, $90, $91, $92, $90, $92, $91, $90, $91, $91, $92
	dw 18
	db "gb", $93, $91, $91, $90, $91, $91, $91, $91, $91, $90, $92, $91, $91, $90, $91, $91
	dw 18
	db "hb", $93, $93, $91, $91, $91, $92, $90, $91, $91, $90, $91, $92, $91, $91, $91, $91
	dw 18
	db "ib", $93, $93, $91, $90, $91, $91, $90, $92, $91, $90, $92, $91, $91, $90, $91, $91
	dw 18
	db "jb", $93, $93, $91, $90, $91, $92, $90, $91, $91, $91, $91, $91, $92, $90, $91, $91
	dw 18
	db "kb", $93, $93, $91, $90, $91, $91, $90, $92, $92, $90, $92, $91, $91, $90, $91, $91
	dw 19
	db "lb", $93, $93, $91, $90, $91, $92, $90, $91, $91, $90, $91, $91, $92, $90, $92, $91, $91
	dw 19
	db "mb", $93, $93, $91, $90, $91, $91, $90, $91, $91, $90, $91, $91, $91, $90, $91, $91, $91
	dw 4
	db "nc", $93, $91
	dw 4
	db "ni", $91, $91
	dw 5
	db "np", $91, $91, $91
DATA_5240:
	dw 19
	dw 15
	dw 4
	dw 15
	db "bb", $93, $93, $93, $93, $93, $93, $93, $93, $93, $93, $91, $91, $93
	dw 15
	db "cb", $93, $93, $93, $93, $93, $93, $93, $93, $93, $93, $92, $92, $93
	dw 8
	db "dl", $92, $91, $90, $91, $91, $91
	dw 19
	db "eb", $91, $91, $91, $91, $91, $91, $92, $91, $91, $92, $91, $91, $91, $91, $91, $92, $91
	dw 3
	db "fc", $91
	dw 13
	db "fh", $91, $91, $91, $90, $91, $91, $92, $91, $90, $91, $91
	dw 18
	db "gb", $91, $91, $91, $91, $91, $91, $90, $91, $91, $91, $90, $90, $91, $91, $90, $91
	dw 14
	db "hb", $91, $91, $92, $90, $91, $91, $90, $91, $90, $90, $91, $91
	dw 3
	db "hq", $91
	dw 7
	db "ib", $91, $92, $91, $90, $92
	dw 6
	db "ij", $91, $91, $91, $91
	dw 3
	db "iq", $91
	dw 12
	db "jd", $91, $91, $92, $91, $90, $91, $91, $90, $91, $91
	dw 3
	db "jq", $91
	dw 16
	db "kd", $91, $91, $91, $91, $92, $91, $90, $90, $91, $90, $91, $91, $90, $91
	dw 18
	db "lc", $91, $92, $91, $91, $90, $91, $91, $92, $91, $91, $92, $91, $92, $91, $91, $91
	dw 18
	db "mc", $91, $91, $92, $91, $91, $92, $90, $92, $92, $92, $91, $91, $90, $91, $91, $91
	dw 14
	db "nc", $91, $91, $90, $91, $91, $92, $91, $91, $91, $91, $91, $91
	dw 14
	db "oc", $91, $91, $90, $90, $91, $91, $90, $91, $91, $90, $91, $91
DATA_5250:
	dw 22
	dw 7
	dw 17
	dw 4
	db "bb", $91, $91
	dw 17
	db "cb", $91, $91, $90, $91, $91, $91, $93, $93, $90, $93, $93, $93, $93, $93, $93
	dw 8
	db "db", $91, $91, $90, $91, $90, $91
	dw 6
	db "dm", $91, $93, $93, $93
	dw 16
	db "ec", $92, $90, $91, $91, $91, $91, $93, $93, $93, $93, $93, $93, $93, $93
	dw 8
	db "fb", $91, $91, $91, $90, $90, $92
	dw 4
	db "fn", $91, $91
	dw 11
	db "gb", $91, $92, $91, $90, $91, $91, $91, $91, $91
	dw 4
	db "gq", $91, $91
	dw 10
	db "hc", $92, $91, $90, $91, $92, $91, $91, $91
	dw 4
	db "hq", $91, $91
	dw 19
	db "ib", $91, $91, $92, $91, $90, $92, $92, $92, $90, $90, $91, $91, $91, $91, $91, $91, $91
	dw 17
	db "jb", $91, $91, $91, $91, $91, $91, $90, $91, $91, $91, $91, $90, $92, $90, $92
	dw 3
	db "kb", $91
	dw 13
	db "kg", $91, $90, $92, $92, $92, $92, $92, $91, $91, $91, $91
	dw 18
	db "lb", $91, $90, $91, $91, $91, $91, $92, $91, $91, $91, $91, $91, $90, $91, $91, $91
	dw 17
	db "mb", $91, $90, $91, $91, $91, $90, $90, $91, $91, $91, $91, $91, $91, $91, $91
	dw 3
	db "nb", $91
	dw 3
	db "ni", $92
	dw 5
	db "np", $91, $92, $91
	dw 10
	db "ob", $91, $91, $91, $91, $91, $91, $91, $91
	dw 5
	db "op", $91, $91, $91
DATA_5260:
	dw 10
	dw 12
	dw 16
	dw 7
	db "de", $91, $91, $90, $91, $91
	dw 11
	db "ee", $91, $91, $90, $91, $91, $90, $93, $93, $93
	dw 14
	db "fd", $91, $91, $92, $90, $91, $91, $90, $93, $93, $93, $91, $91
	dw 14
	db "gd", $91, $92, $91, $90, $92, $92, $91, $93, $93, $93, $91, $91
	dw 14
	db "hd", $91, $91, $92, $90, $91, $91, $90, $93, $93, $93, $91, $93
	dw 8
	db "id", $91, $91, $91, $90, $91, $92
	dw 14
	db "je", $92, $91, $91, $91, $91, $91, $91, $91, $92, $91, $92, $91
	dw 14
	db "ke", $91, $91, $90, $91, $91, $92, $92, $91, $90, $91, $91, $91
	dw 9
	db "lj", $91, $91, $90, $90, $92, $92, $91
	dw 8
	db "mj", $91, $91, $91, $91, $91, $91
DATA_5270:
	dw 12
	dw 14
	dw 11
	dw 17
	db "dc", $93, $93, $93, $91, $91, $91, $90, $91, $91, $91, $91, $90, $91, $91, $91
	dw 18
	db "ec", $93, $93, $93, $93, $93, $91, $91, $92, $90, $90, $91, $90, $91, $90, $92, $91
	dw 19
	db "fb", $93, $93, $93, $93, $93, $93, $90, $91, $91, $92, $91, $91, $90, $91, $91, $91, $91
	dw 19
	db "gb", $93, $93, $93, $93, $93, $93, $90, $91, $91, $90, $91, $91, $90, $91, $90, $91, $91
	dw 11
	db "hj", $91, $92, $91, $91, $92, $91, $92, $91, $91
	dw 16
	db "id", $91, $91, $91, $91, $91, $90, $92, $90, $90, $92, $91, $90, $90, $92
	dw 17
	db "jd", $91, $91, $91, $92, $91, $91, $91, $91, $90, $91, $92, $91, $91, $91, $91
	dw 7
	db "kc", $91, $91, $90, $90, $91
	dw 10
	db "kk", $91, $90, $91, $91, $90, $90, $92, $91
	dw 18
	db "lc", $91, $92, $91, $92, $92, $91, $91, $91, $91, $91, $92, $91, $91, $92, $91, $91
	dw 13
	db "mc", $91, $92, $91, $91, $91, $91, $92, $90, $90, $92, $91
	dw 6
	db "ni", $91, $91, $91, $91
DATA_5280:
	dw 16
	dw 10
	dw 3
	dw 5
	db "cl", $91, $91, $91
	dw 9
	db "dh", $91, $92, $91, $91, $92, $91, $91
	dw 13
	db "eg", $91, $92, $91, $91, $92, $91, $92, $91, $90, $90, $93
	dw 17
	db "fc", $91, $91, $91, $91, $91, $91, $91, $92, $92, $91, $91, $90, $90, $93, $93
	dw 4
	db "gc", $91, $91
	dw 3
	db "gk", $91
	dw 5
	db "go", $93, $93, $91
	dw 16
	db "hd", $91, $90, $91, $91, $90, $91, $91, $91, $91, $90, $93, $93, $93, $91
	dw 17
	db "ic", $91, $92, $91, $91, $91, $90, $91, $91, $91, $91, $90, $93, $93, $93, $91
	dw 10
	db "jc", $91, $91, $90, $92, $91, $90, $90, $91
	dw 5
	db "jo", $93, $93, $93
	dw 14
	db "kf", $91, $91, $92, $91, $92, $92, $91, $91, $90, $90, $93, $93
	dw 13
	db "lg", $91, $91, $92, $91, $92, $91, $91, $92, $93, $93, $93
	dw 13
	db "mg", $91, $92, $92, $91, $91, $92, $91, $90, $91, $91, $93
	dw 10
	db "ng", $91, $91, $91, $92, $91, $92, $91, $91
	dw 5
	db "ol", $91, $91, $91
DATA_5290:
	dw 14
	dw 7
	dw 12
	dw 5
	db "db", $91, $91, $91
	dw 6
	db "eb", $91, $92, $91, $91
	dw 13
	db "fc", $91, $90, $91, $90, $91, $91, $91, $91, $91, $91, $91
	dw 18
	db "gc", $91, $90, $91, $91, $91, $92, $90, $92, $90, $91, $91, $91, $90, $91, $91, $91
	dw 19
	db "hb", $91, $91, $90, $91, $91, $91, $91, $91, $91, $92, $91, $90, $91, $91, $91, $92, $91
	dw 4
	db "ib", $91, $91
	dw 3
	db "ig", $91
	dw 3
	db "iq", $91
	dw 18
	db "jb", $91, $91, $90, $90, $91, $93, $93, $96, $93, $93, $93, $93, $93, $91, $90, $91
	dw 17
	db "kc", $91, $90, $90, $91, $96, $93, $96, $93, $93, $96, $93, $96, $91, $90, $91
	dw 4
	db "lb", $91, $92
	dw 7
	db "ln", $91, $90, $90, $92, $91
	dw 19
	db "mb", $91, $91, $92, $91, $91, $91, $92, $91, $91, $92, $91, $91, $91, $91, $92, $91, $91
	dw 19
	db "nb", $91, $91, $90, $91, $91, $91, $90, $91, $91, $91, $90, $91, $91, $91, $90, $91, $91
DATA_5300:
	dw 18
	dw 7
	dw 6
	dw 11
	db "ci", $91, $91, $91, $90, $91, $91, $91, $91, $91
	dw 11
	db "di", $91, $91, $91, $91, $91, $92, $91, $92, $91
	dw 5
	db "eb", $91, $91, $91
	dw 9
	db "ej", $91, $92, $90, $90, $91, $90, $91
	dw 18
	db "fb", $91, $92, $91, $90, $90, $91, $91, $91, $90, $91, $90, $90, $91, $92, $91, $91
	dw 18
	db "gb", $91, $92, $91, $91, $91, $92, $92, $91, $90, $91, $90, $90, $92, $92, $92, $91
	dw 3
	db "hc", $91
	dw 13
	db "hg", $91, $91, $91, $90, $91, $90, $90, $91, $91, $91, $91
	dw 7
	db "ic", $91, $90, $91, $91, $91
	dw 3
	db "ik", $91
	dw 3
	db "iq", $92
	dw 17
	db "jc", $91, $90, $91, $91, $91, $91, $91, $92, $91, $91, $90, $93, $93, $93, $93
	dw 4
	db "kb", $91, $91
	dw 13
	db "kg", $91, $90, $90, $91, $92, $91, $90, $93, $93, $93, $93
	dw 19
	db "lb", $91, $92, $91, $91, $91, $92, $91, $90, $91, $91, $91, $90, $93, $93, $92, $93, $91
	dw 19
	db "mb", $91, $91, $90, $90, $91, $92, $91, $90, $91, $91, $90, $90, $93, $93, $93, $93, $91
	dw 5
	db "nf", $91, $91, $91
	dw 5
	db "no", $93, $93, $93
DATA_5310:
	dw 16
	dw 4
	dw 9
	dw 4
	db "bd", $91, $91
	dw 12
	db "cd", $91, $91, $90, $90, $91, $91, $90, $91, $91, $91
	dw 13
	db "dc", $91, $91, $92, $90, $91, $92, $91, $92, $91, $91, $91
	dw 16
	db "ec", $92, $91, $91, $92, $91, $91, $90, $91, $92, $91, $92, $90, $91, $91
	dw 17
	db "fc", $91, $91, $92, $90, $90, $91, $90, $92, $91, $92, $91, $91, $91, $91, $91
	dw 18
	db "gb", $91, $91, $90, $91, $91, $90, $91, $90, $91, $91, $91, $92, $92, $92, $91, $91
	dw 15
	db "hb", $91, $92, $91, $91, $91, $91, $92, $91, $91, $92, $90, $90, $91
	dw 15
	db "ib", $91, $92, $91, $92, $91, $90, $92, $90, $91, $91, $90, $91, $91
	dw 4
	db "jc", $91, $91
	dw 4
	db "jh", $91, $91
	dw 4
	db "jm", $92, $91
	dw 14
	db "kc", $91, $91, $90, $93, $93, $93, $93, $91, $91, $91, $91, $91
	dw 8
	db "lf", $93, $93, $93, $93, $93, $93
	dw 6
	db "me", $93, $93, $93, $93
	dw 5
	db "ne", $93, $93, $93
	dw 5
	db "oe", $93, $93, $93
DATA_5320:
	dw 13
	dw 6
	dw 5
	dw 4
	db "ck", $91, $91
	dw 8
	db "dg", $91, $91, $91, $91, $91, $92
	dw 9
	db "ef", $91, $92, $91, $91, $90, $90, $91
	dw 12
	db "fe", $91, $92, $91, $92, $91, $90, $91, $92, $91, $91
	dw 9
	db "gh", $91, $90, $90, $91, $91, $91, $92
	dw 11
	db "hf", $93, $93, $93, $93, $90, $92, $91, $92, $91
	dw 11
	db "if", $93, $93, $93, $93, $90, $91, $91, $91, $92
	dw 11
	db "jf", $93, $93, $93, $93, $91, $91, $92, $92, $91
	dw 12
	db "kf", $93, $93, $93, $91, $90, $91, $92, $91, $91, $91
	dw 7
	db "lk", $92, $91, $92, $91, $91
	dw 5
	db "mk", $91, $91, $91
	dw 4
	db "nk", $92, $91
	dw 4
	db "ok", $91, $91
DATA_5330:
	dw 13
	dw 12
	dw 14
	dw 10
	db "cf", $91, $91, $91, $91, $90, $90, $91, $91
	dw 11
	db "df", $91, $91, $91, $92, $91, $91, $91, $92, $91
	dw 9
	db "eh", $91, $90, $90, $91, $92, $92, $91
	dw 12
	db "fe", $91, $91, $91, $92, $91, $90, $91, $91, $91, $91
	dw 9
	db "ge", $91, $92, $92, $92, $91, $90, $91
	dw 11
	db "he", $91, $91, $91, $90, $91, $90, $91, $92, $91
	dw 12
	db "ie", $91, $91, $90, $91, $91, $90, $91, $91, $92, $91
	dw 12
	db "je", $91, $92, $90, $91, $92, $90, $91, $91, $91, $91
	dw 9
	db "ke", $91, $91, $91, $93, $93, $90, $91
	dw 9
	db "lh", $93, $93, $91, $92, $91, $90, $91
	dw 12
	db "me", $93, $93, $93, $93, $93, $90, $91, $92, $90, $91
	dw 11
	db "nf", $93, $93, $93, $93, $90, $91, $91, $92, $91
	dw 10
	db "og", $93, $93, $90, $90, $91, $91, $91, $91
DATA_5340:
	dw 15
	dw 5
	dw 14
	dw 9
	db "cf", $93, $93, $93, $93, $91, $91, $91
	dw 10
	db "df", $93, $90, $93, $90, $91, $91, $92, $91
	dw 11
	db "ef", $93, $93, $93, $93, $90, $91, $90, $91, $91
	dw 13
	db "fe", $91, $93, $93, $93, $93, $90, $91, $91, $90, $91, $91
	dw 14
	db "ge", $91, $91, $91, $91, $91, $90, $92, $91, $90, $90, $92, $91
	dw 3
	db "hf", $91
	dw 9
	db "hj", $91, $91, $92, $91, $91, $91, $91
	dw 13
	db "if", $92, $91, $91, $92, $91, $92, $91, $92, $90, $91, $91
	dw 13
	db "jf", $91, $90, $91, $91, $92, $91, $92, $91, $90, $90, $91
	dw 4
	db "kf", $91, $91
	dw 7
	db "kk", $91, $91, $90, $90, $91
	dw 12
	db "lf", $91, $91, $91, $91, $90, $90, $91, $90, $90, $91
	dw 12
	db "mf", $91, $91, $92, $91, $90, $91, $91, $92, $91, $91
	dw 8
	db "nh", $92, $91, $92, $91, $91, $91
	dw 4
	db "oh", $91, $91
DATA_5350:
	dw 20
	dw 3
	dw 11
	dw 13
	db "bb", $91, $91, $91, $90, $91, $91, $91, $91, $90, $91, $90
	dw 6
	db "bo", $93, $93, $93, $93
	dw 19
	db "cb", $91, $91, $91, $92, $92, $90, $91, $91, $91, $91, $91, $91, $93, $93, $93, $93, $93
	dw 7
	db "db", $91, $91, $91, $90, $91
	dw 11
	db "dj", $91, $91, $91, $90, $91, $93, $93, $93, $93
	dw 6
	db "ec", $91, $90, $90, $91
	dw 11
	db "ej", $91, $91, $90, $91, $91, $93, $93, $93, $93
	dw 15
	db "fc", $91, $92, $91, $92, $91, $91, $91, $91, $91, $90, $91, $90, $91
	dw 18
	db "gc", $91, $91, $92, $91, $92, $90, $90, $91, $91, $90, $91, $91, $91, $91, $91, $91
	dw 6
	db "he", $91, $90, $91, $91
	dw 8
	db "hm", $91, $90, $91, $90, $90, $91
	dw 19
	db "ib", $91, $91, $90, $91, $90, $92, $91, $91, $91, $90, $90, $91, $90, $91, $91, $91, $91
	dw 18
	db "jb", $91, $92, $91, $91, $92, $91, $91, $90, $91, $90, $90, $91, $90, $91, $91, $91
	dw 18
	db "kb", $91, $90, $91, $92, $91, $92, $91, $91, $91, $91, $90, $91, $90, $91, $91, $91
	dw 14
	db "lb", $91, $91, $92, $91, $90, $90, $91, $90, $90, $91, $90, $91
	dw 14
	db "mb", $91, $92, $92, $91, $91, $91, $91, $91, $92, $92, $91, $91
	dw 6
	db "nc", $91, $90, $90, $91
	dw 6
	db "nj", $91, $92, $91, $91
	dw 6
	db "oc", $91, $91, $91, $91
	dw 6
	db "oj", $91, $91, $91, $91
DATA_5360:
	dw 21
	dw 8
	dw 11
	dw 5
	db "bn", $91, $91, $91
	dw 5
	db "cb", $91, $91, $91
	dw 10
	db "ci", $91, $91, $92, $91, $92, $91, $92, $91
	dw 17
	db "db", $91, $92, $91, $91, $91, $90, $90, $91, $90, $90, $91, $90, $90, $91, $91
	dw 18
	db "eb", $91, $91, $91, $92, $91, $92, $91, $91, $91, $91, $91, $92, $91, $91, $92, $91
	dw 16
	db "fd", $91, $92, $91, $91, $90, $90, $91, $90, $90, $91, $91, $91, $91, $91
	dw 3
	db "gd", $91
	dw 3
	db "gj", $91
	dw 5
	db "gp", $92, $92, $91
	dw 3
	db "hd", $92
	dw 11
	db "hj", $91, $91, $90, $90, $91, $91, $91, $91, $91
	dw 6
	db "ic", $91, $92, $91, $91
	dw 3
	db "ij", $92
	dw 6
	db "in", $91, $92, $91, $91
	dw 10
	db "jc", $91, $92, $91, $91, $90, $91, $91, $91
	dw 4
	db "jn", $91, $91
	dw 15
	db "kc", $91, $92, $92, $91, $92, $91, $90, $91, $91, $91, $92, $92, $91
	dw 15
	db "lc", $91, $91, $91, $91, $91, $90, $91, $91, $91, $90, $90, $91, $91
	dw 6
	db "mi", $93, $93, $91, $93
	dw 11
	db "nf", $93, $93, $93, $93, $93, $93, $93, $93, $93
	dw 11
	db "of", $93, $93, $93, $93, $93, $93, $93, $93, $93
DATA_5370:
	dw 15
	dw 15
	dw 10
	dw 11
	db "cb", $93, $93, $93, $93, $93, $93, $91, $91, $91
	dw 19
	db "db", $93, $93, $93, $93, $93, $93, $91, $91, $91, $90, $91, $91, $90, $90, $91, $91, $91
	dw 4
	db "eb", $93, $93
	dw 14
	db "eg", $91, $92, $91, $91, $91, $91, $92, $91, $91, $91, $91, $91
	dw 19
	db "fb", $93, $93, $93, $91, $92, $91, $92, $91, $90, $91, $91, $91, $90, $90, $91, $91, $91
	dw 7
	db "gb", $93, $93, $93, $90, $92
	dw 9
	db "gl", $91, $91, $91, $91, $90, $91, $91
	dw 17
	db "hd", $91, $91, $91, $91, $90, $91, $91, $91, $90, $92, $91, $91, $90, $92, $91
	dw 17
	db "id", $91, $91, $92, $92, $91, $92, $91, $92, $91, $91, $92, $90, $90, $91, $91
	dw 17
	db "jd", $91, $91, $92, $91, $91, $91, $90, $92, $90, $92, $91, $90, $90, $92, $91
	dw 15
	db "kf", $91, $90, $90, $91, $90, $91, $91, $91, $91, $90, $90, $91, $91
	dw 11
	db "le", $91, $91, $92, $91, $92, $91, $90, $90, $91
	dw 12
	db "me", $91, $91, $91, $91, $92, $91, $91, $92, $91, $91
	dw 11
	db "nf", $91, $91, $91, $90, $91, $90, $91, $91, $91
	dw 3
	db "oj", $91
DATA_5380:
	dw 9
	dw 5
	dw 13
	dw 4
	db "el", $91, $91
	dw 10
	db "ff", $91, $91, $91, $91, $91, $92, $91, $91
	dw 10
	db "gf", $91, $91, $91, $92, $90, $90, $91, $92
	dw 9
	db "hg", $92, $90, $93, $93, $93, $90, $91
	dw 9
	db "ig", $91, $92, $93, $93, $93, $91, $91
	dw 9
	db "jg", $91, $90, $93, $91, $93, $90, $91
	dw 10
	db "kg", $91, $91, $91, $90, $91, $90, $92, $91
	dw 10
	db "lg", $92, $91, $91, $92, $91, $91, $91, $91
	dw 4
	db "mg", $91, $91
DATA_5390:
	dw 19
	dw 4
	dw 12
	dw 6
	db "bo", $93, $93, $93, $93
	dw 18
	db "cc", $91, $91, $91, $90, $90, $91, $91, $91, $91, $91, $90, $90, $93, $93, $93, $93
	dw 19
	db "db", $91, $91, $92, $92, $90, $90, $91, $91, $92, $91, $91, $90, $90, $93, $93, $93, $93
	dw 19
	db "eb", $91, $91, $91, $91, $91, $91, $92, $92, $91, $92, $90, $91, $91, $93, $93, $93, $93
	dw 19
	db "fb", $91, $91, $92, $91, $90, $90, $91, $92, $92, $91, $90, $91, $90, $91, $93, $93, $93
	dw 19
	db "gb", $91, $91, $92, $91, $90, $90, $91, $92, $91, $91, $90, $91, $91, $93, $93, $93, $93
	dw 3
	db "hc", $91
	dw 3
	db "hi", $91
	dw 6
	db "hm", $91, $90, $90, $93
	dw 18
	db "ic", $91, $91, $91, $92, $91, $91, $92, $91, $90, $90, $91, $91, $91, $93, $91, $91
	dw 4
	db "jb", $91, $92
	dw 6
	db "jg", $91, $91, $90, $91
	dw 3
	db "jp", $91
	dw 17
	db "kb", $91, $91, $91, $92, $91, $91, $91, $90, $91, $91, $91, $91, $91, $91, $91
	dw 12
	db "lb", $91, $91, $92, $91, $90, $92, $91, $92, $91, $92
	dw 4
	db "lo", $91, $91
	dw 12
	db "mb", $91, $92, $92, $92, $90, $91, $92, $91, $91, $91
	dw 12
	db "nb", $91, $91, $91, $91, $90, $91, $91, $92, $92, $91
	dw 5
	db "og", $91, $91, $91
DATA_5400:
	dw 14
	dw 4
	dw 17
	dw 12
	db "bg", $91, $91, $91, $91, $91, $91, $91, $91, $91, $91
	dw 13
	db "cg", $91, $91, $90, $91, $90, $92, $92, $91, $92, $91, $91
	dw 13
	db "dg", $92, $91, $90, $92, $90, $91, $91, $90, $90, $91, $91
	dw 12
	db "eg", $91, $90, $90, $91, $90, $91, $92, $91, $90, $91
	dw 13
	db "ff", $91, $91, $91, $92, $91, $90, $92, $91, $91, $90, $91
	dw 13
	db "gf", $91, $91, $91, $90, $91, $92, $91, $91, $91, $90, $91
	dw 12
	db "hg", $91, $92, $91, $92, $91, $91, $91, $90, $90, $91
	dw 13
	db "if", $91, $91, $90, $91, $91, $90, $90, $91, $91, $92, $91
	dw 13
	db "jf", $91, $91, $91, $91, $90, $90, $91, $92, $92, $90, $91
	dw 11
	db "kh", $92, $92, $91, $91, $91, $90, $91, $91, $91
	dw 9
	db "lc", $93, $93, $93, $93, $90, $91, $91
	dw 8
	db "mc", $93, $90, $93, $93, $93, $91
	dw 9
	db "nc", $93, $93, $93, $93, $91, $91, $91
	dw 9
	db "oc", $93, $93, $93, $93, $91, $91, $91
DATA_5410:
	dw 16
	dw 10
	dw 18
	dw 5
	db "cm", $91, $91, $91
	dw 7
	db "dl", $91, $91, $91, $91, $91
	dw 8
	db "ek", $91, $91, $92, $92, $91, $91
	dw 9
	db "fj", $91, $92, $92, $91, $91, $92, $91
	dw 10
	db "gi", $91, $92, $91, $91, $91, $91, $92, $91
	dw 8
	db "hi", $91, $91, $91, $92, $92, $91
	dw 4
	db "ib", $91, $91
	dw 9
	db "il", $91, $90, $90, $91, $91, $91, $91
	dw 19
	db "jb", $93, $91, $91, $91, $91, $91, $91, $91, $91, $91, $91, $91, $91, $92, $92, $92, $91
	dw 5
	db "kb", $93, $90, $91
	dw 8
	db "kl", $91, $90, $90, $91, $91, $91
	dw 5
	db "lb", $93, $90, $91
	dw 8
	db "ll", $93, $91, $90, $92, $91, $92
	dw 19
	db "mb", $93, $93, $93, $93, $93, $93, $93, $93, $93, $93, $93, $91, $90, $91, $91, $91, $91
	dw 6
	db "no", $91, $91, $92, $91
	dw 4
	db "op", $91, $91
DATA_5420:
	dw 13
	dw 5
	dw 17
	dw 8
	db "dg", $91, $91, $91, $91, $91, $91
	dw 16
	db "ed", $91, $91, $91, $91, $90, $90, $91, $92, $91, $92, $91, $91, $91, $91
	dw 15
	db "fd", $91, $90, $90, $91, $90, $90, $92, $90, $92, $91, $92, $91, $92
	dw 15
	db "gd", $91, $93, $93, $93, $93, $93, $93, $90, $91, $91, $92, $92, $91
	dw 18
	db "hb", $91, $91, $91, $93, $93, $93, $93, $93, $93, $90, $91, $91, $90, $91, $91, $91
	dw 18
	db "ib", $91, $90, $91, $93, $93, $93, $93, $93, $93, $90, $92, $91, $91, $92, $91, $91
	dw 18
	db "jb", $91, $90, $92, $93, $93, $93, $93, $93, $93, $91, $92, $92, $90, $91, $92, $91
	dw 5
	db "kb", $91, $91, $91
	dw 3
	db "kh", $91
	dw 7
	db "kl", $92, $91, $91, $92, $91
	dw 15
	db "ld", $91, $91, $92, $91, $91, $92, $91, $91, $92, $91, $91, $92, $91
	dw 15
	db "md", $91, $91, $92, $91, $91, $92, $91, $91, $92, $91, $91, $92, $91
	dw 5
	db "ni", $91, $91, $91
DATA_5430:
	dw 12
	dw 11
	dw 10
	dw 7
	db "ej", $91, $91, $90, $91, $91
	dw 14
	db "ff", $91, $91, $91, $90, $91, $91, $91, $92, $91, $91, $91, $91
	dw 14
	db "gf", $91, $90, $92, $92, $91, $90, $90, $91, $90, $90, $91, $91
	dw 16
	db "hc", $91, $91, $91, $91, $91, $91, $90, $91, $90, $91, $91, $90, $90, $91
	dw 4
	db "ib", $91, $91
	dw 14
	db "ig", $91, $92, $90, $92, $91, $91, $92, $91, $91, $92, $91, $91
	dw 19
	db "jb", $93, $93, $93, $91, $91, $91, $91, $90, $91, $90, $90, $91, $91, $90, $91, $91, $91
	dw 14
	db "kb", $93, $93, $93, $90, $91, $91, $91, $91, $91, $91, $90, $91
	dw 3
	db "kq", $91
	dw 8
	db "lb", $93, $93, $93, $90, $91, $91
	dw 10
	db "lk", $91, $91, $92, $91, $91, $92, $91, $91
	dw 9
	db "ml", $91, $91, $91, $90, $91, $91, $91
DATA_5440:
	dw 19
	dw 5
	dw 10
	dw 5
	db "cc", $91, $91, $91
	dw 5
	db "dc", $91, $90, $91
	dw 10
	db "ec", $91, $91, $91, $91, $91, $91, $92, $91
	dw 9
	db "fc", $91, $92, $91, $90, $90, $92, $91
	dw 5
	db "fm", $91, $91, $91
	dw 3
	db "gc", $91
	dw 10
	db "gh", $91, $92, $91, $91, $91, $91, $92, $91
	dw 3
	db "hc", $91
	dw 9
	db "hi", $91, $90, $91, $91, $90, $92, $91
	dw 4
	db "ic", $91, $91
	dw 12
	db "ii", $91, $90, $90, $92, $91, $91, $91, $91, $91, $91
	dw 19
	db "jb", $91, $91, $92, $90, $91, $91, $92, $91, $91, $90, $91, $90, $90, $91, $90, $90, $91
	dw 19
	db "kb", $91, $91, $91, $91, $91, $91, $91, $91, $91, $90, $91, $90, $93, $93, $93, $90, $91
	dw 4
	db "lg", $91, $91
	dw 9
	db "ll", $91, $91, $93, $93, $93, $91, $91
	dw 9
	db "ml", $91, $90, $93, $93, $93, $90, $91
	dw 3
	db "nl", $91
	dw 5
	db "np", $91, $90, $91
	dw 9
	db "ol", $91, $91, $91, $91, $91, $91, $91
DATA_5450:
	dw 16
	dw 12
	dw 7
	dw 5
	db "dc", $93, $93, $93
	dw 4
	db "di", $91, $91
	dw 5
	db "ec", $93, $93, $93
	dw 7
	db "ei", $91, $91, $92, $91, $91
	dw 13
	db "fc", $93, $93, $93, $93, $90, $90, $91, $92, $91, $91, $92
	dw 14
	db "gd", $93, $93, $93, $93, $90, $90, $91, $91, $91, $92, $91, $91
	dw 13
	db "he", $93, $93, $93, $91, $90, $90, $91, $92, $91, $92, $91
	dw 15
	db "ic", $91, $90, $90, $91, $91, $91, $91, $90, $91, $91, $92, $91, $91
	dw 9
	db "jc", $91, $91, $90, $90, $91, $90, $91
	dw 3
	db "jm", $91
	dw 16
	db "kc", $91, $92, $91, $90, $91, $90, $92, $91, $91, $92, $91, $91, $91, $91
	dw 16
	db "lc", $91, $91, $92, $91, $91, $91, $92, $91, $91, $91, $91, $92, $91, $91
	dw 14
	db "mc", $91, $91, $91, $90, $91, $92, $91, $92, $92, $91, $92, $91
	dw 4
	db "nc", $91, $91
	dw 4
	db "nk", $91, $91
	dw 3
	db "oc", $91
DATA_5460:
	dw 16
	dw 8
	dw 14
	dw 10
	db "bd", $91, $91, $91, $91, $91, $91, $91, $91
	dw 3
	db "cd", $91
	dw 6
	db "ck", $91, $90, $91, $91
	dw 14
	db "dd", $91, $90, $91, $92, $91, $92, $91, $92, $91, $91, $92, $91
	dw 14
	db "ed", $91, $91, $91, $91, $91, $91, $91, $90, $92, $91, $91, $91
	dw 10
	db "ff", $92, $91, $91, $92, $92, $90, $91, $91
	dw 10
	db "gf", $91, $91, $90, $90, $91, $90, $91, $92
	dw 10
	db "hg", $92, $90, $91, $91, $91, $92, $91, $91
	dw 8
	db "ig", $91, $91, $92, $91, $92, $91
	dw 10
	db "jg", $91, $90, $91, $91, $91, $92, $91, $91
	dw 10
	db "kg", $91, $90, $90, $91, $91, $91, $90, $91
	dw 4
	db "lg", $91, $91
	dw 3
	db "ln", $91
	dw 11
	db "mf", $91, $91, $91, $91, $91, $91, $91, $91, $91
	dw 9
	db "nf", $93, $93, $93, $93, $93, $93, $93
	dw 9
	db "of", $93, $93, $93, $93, $93, $93, $93
DATA_5470:
	dw 10
	dw 9
	dw 8
	dw 4
	db "ek", $91, $91
	dw 13
	db "fc", $91, $91, $92, $91, $91, $91, $91, $91, $91, $92, $91
	dw 18
	db "gb", $91, $91, $91, $90, $90, $91, $90, $90, $91, $91, $91, $90, $90, $93, $93, $93
	dw 18
	db "hb", $91, $90, $92, $92, $91, $92, $91, $92, $92, $90, $92, $90, $90, $93, $93, $93
	dw 18
	db "ib", $91, $90, $91, $91, $91, $91, $91, $91, $91, $90, $91, $91, $91, $93, $93, $93
	dw 7
	db "jb", $91, $91, $92, $90, $91
	dw 10
	db "jj", $92, $92, $91, $91, $91, $93, $93, $93
	dw 18
	db "kb", $91, $92, $91, $91, $92, $92, $91, $91, $92, $91, $90, $90, $93, $93, $93, $93
	dw 10
	db "ld", $92, $91, $91, $91, $91, $91, $91, $91
	dw 4
	db "md", $91, $91
DATA_5480:
	dw 15
	dw 14
	dw 10
	dw 9
	db "bg", $96, $93, $96, $90, $96, $93, $96
	dw 9
	db "cg", $93, $96, $93, $96, $93, $96, $93
	dw 9
	db "dg", $96, $93, $96, $93, $96, $93, $96
	dw 9
	db "eg", $93, $96, $93, $96, $93, $96, $93
	dw 9
	db "fg", $96, $93, $96, $93, $96, $93, $96
	dw 5
	db "gi", $91, $91, $91
	dw 5
	db "hi", $91, $91, $91
	dw 3
	db "ij", $91
	dw 13
	db "je", $91, $91, $91, $91, $91, $91, $91, $91, $91, $91, $91
	dw 13
	db "ke", $91, $92, $91, $92, $91, $92, $91, $92, $91, $92, $91
	dw 11
	db "lf", $91, $92, $91, $92, $91, $92, $91, $92, $91
	dw 11
	db "mf", $92, $91, $92, $91, $92, $91, $92, $91, $92
	dw 11
	db "nf", $91, $91, $91, $92, $91, $92, $91, $91, $91
	dw 4
	db "of", $91, $91
	dw 4
	db "om", $91, $91
DATA_5490:
	dw 16
	dw 13
	dw 9
	dw 4
	db "cj", $91, $91
	dw 5
	db "dj", $91, $91, $91
	dw 6
	db "ej", $91, $92, $92, $91
	dw 7
	db "fj", $92, $91, $91, $92, $91
	dw 10
	db "gh", $91, $91, $91, $91, $92, $91, $91, $91
	dw 6
	db "he", $91, $91, $90, $91
	dw 4
	db "hn", $91, $91
	dw 15
	db "ic", $91, $91, $91, $91, $90, $91, $90, $93, $93, $93, $93, $92, $91
	dw 15
	db "jc", $91, $90, $91, $91, $91, $92, $91, $93, $93, $93, $93, $90, $91
	dw 15
	db "kc", $91, $91, $92, $91, $90, $91, $90, $93, $96, $93, $93, $90, $91
	dw 4
	db "le", $91, $91
	dw 3
	db "lk", $91
	dw 3
	db "lo", $91
	dw 10
	db "mh", $91, $91, $92, $91, $91, $90, $90, $92
	dw 9
	db "nj", $91, $92, $91, $91, $91, $91, $91
	dw 9
	db "oj", $91, $91, $90, $90, $91, $91, $91
DATA_5500:
	dw 19
	dw 8
	dw 3
	dw 12
	db "bh", $93, $93, $91, $91, $91, $91, $90, $91, $91, $91
	dw 13
	db "cg", $93, $93, $96, $91, $92, $91, $91, $91, $91, $92, $91
	dw 13
	db "df", $93, $93, $96, $93, $90, $91, $90, $91, $90, $92, $91
	dw 15
	db "ee", $93, $93, $96, $93, $90, $91, $90, $91, $90, $91, $92, $91, $91
	dw 15
	db "fe", $93, $93, $93, $90, $91, $91, $90, $91, $91, $91, $91, $90, $91
	dw 18
	db "gb", $91, $91, $90, $90, $91, $90, $91, $91, $91, $91, $91, $91, $91, $91, $91, $91
	dw 8
	db "hb", $91, $91, $92, $91, $92, $91
	dw 8
	db "hk", $91, $91, $90, $91, $90, $91
	dw 17
	db "ib", $91, $92, $91, $91, $91, $92, $91, $91, $91, $90, $91, $90, $91, $91, $91
	dw 15
	db "jd", $92, $92, $91, $91, $91, $90, $91, $90, $91, $90, $91, $90, $91
	dw 13
	db "kd", $91, $91, $91, $92, $91, $91, $91, $90, $91, $90, $91
	dw 6
	db "ld", $91, $92, $90, $91
	dw 8
	db "lm", $91, $91, $91, $91, $91, $91
	dw 6
	db "md", $92, $91, $91, $91
	dw 8
	db "mm", $91, $91, $91, $90, $91, $91
	dw 4
	db "nd", $91, $91
	dw 4
	db "od", $91, $91
	dw 7
	db "nn", $91, $91, $91, $91, $91
	dw 6
	db "on", $91, $91, $91, $91

ZX_VARIABLES:
	db 0

    DISPLAY "Compiled Basic = ", /D, $-CBASIC_START,  " bytes"
