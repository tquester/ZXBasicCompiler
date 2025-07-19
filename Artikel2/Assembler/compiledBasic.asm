
CBASIC_START
compiledBasic:
	call ZXHeapClear
	LD (runtimeSaveSP),SP
	LD HL,DATA_140
	LD (DATAPTR),HL
; 4.1  DIM s(22,22)
	LD HL,ZXBASIC_VAR_s_array
	LD BC,2645
	CALL runtimeClearArray
; 4.1  DIM x(100)
	LD HL,ZXBASIC_VAR_x_array
	LD BC,505
	CALL runtimeClearArray
; 4.1  DIM y(100)
	LD HL,ZXBASIC_VAR_y_array
	LD BC,505
	CALL runtimeClearArray
; 4.1  DIM c$(100,1)
	LD HL,ZXBASIC_VAR_c_string
	LD BC,202
	CALL runtimeClearStringArray
; 4.1  DIM d$(100,1)
	LD HL,ZXBASIC_VAR_d_string
	LD BC,202
	CALL runtimeClearStringArray
; 4.1  DIM c(100)
	LD HL,ZXBASIC_VAR_c_array
	LD BC,505
	CALL runtimeClearArray
; 4.1  DIM d(100)
	LD HL,ZXBASIC_VAR_d_array
	LD BC,505
	CALL runtimeClearArray
; 140.1 
; 160.1 
; 180.1 
; 200.1 
; 470.1  DIM s(22,32)
	LD HL,ZXBASIC_VAR_s_array
	LD BC,2645
	CALL runtimeClearArray
; 530.1  DIM x(nz)
; 540.1  DIM y(nz)
; 550.1  DIM c$(nz,1)
; 550.1  DIM d$(nz,1)
; 560.1  DIM c(nz)
; 560.1  DIM d(nz)
ZXBASIC_LINE_1:
; 1  REM compiler-options
ZXBASIC_LINE_2:
; 2  REM int16 i x y dx dy ny nx n b zi zx zy UDG s() x() y() d()
ZXBASIC_LINE_3:
; 3  REM data int16
ZXBASIC_LINE_4:
; 4  DIM s(22,22): DIM x(100): DIM y(100): DIM c$(100,1): DIM d$(100,1): DIM c(100): DIM d(100)
; 		4.1  DIM s(22{00 00 16 00 00 },22{00 00 16 00 00 })
	LD HL,ZXBASIC_VAR_s_array
	LD BC,2645
	CALL runtimeClearArray
; 		4.2  DIM x(100{00 00 64 00 00 })
	LD HL,ZXBASIC_VAR_x_array
	LD BC,505
	CALL runtimeClearArray
; 		4.3  DIM y(100{00 00 64 00 00 })
	LD HL,ZXBASIC_VAR_y_array
	LD BC,505
	CALL runtimeClearArray
; 		4.4  DIM c$(100{00 00 64 00 00 },1{00 00 01 00 00 })
	LD HL,ZXBASIC_VAR_c_string
	LD BC,202
	CALL runtimeClearStringArray
; 		4.5  DIM d$(100{00 00 64 00 00 },1{00 00 01 00 00 })
	LD HL,ZXBASIC_VAR_d_string
	LD BC,202
	CALL runtimeClearStringArray
; 		4.6  DIM c(100{00 00 64 00 00 })
	LD HL,ZXBASIC_VAR_c_array
	LD BC,505
	CALL runtimeClearArray
; 		4.7  DIM d(100{00 00 64 00 00 })
	LD HL,ZXBASIC_VAR_d_array
	LD BC,505
	CALL runtimeClearArray
ZXBASIC_LINE_10:
; 10  REM \134      ZXombies!      \134
ZXBASIC_LINE_20:
; 20  REM \134   2017 @xenopunk   \134
ZXBASIC_LINE_30:
; 30  REM \134 #zxspectrumbasicjam \134
ZXBASIC_LINE_40:
; 40  LET UDG=0
; 		40.1  LET UDG=0{00 00 00 00 00 }
	LD HL,FLOAT_1	;0
	LD DE,ZXBASIC_VAR_UDG
	LD BC,5
	LDIR
ZXBASIC_LINE_50:
; 50  REM \134\134\134\134\134\134\134\134\134\134 Title Screen
ZXBASIC_LINE_60:
; 60  BORDER 0: PAPER 0: INK 7: BRIGHT 1: CLS 
; 		60.1  BORDER 0{00 00 00 00 00 }
	LD HL,FLOAT_1	;0
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD A,L
	call $2297
; 		60.2  PAPER 0{00 00 00 00 00 }
	LD HL,FLOAT_1	;0
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimePaper
; 		60.3  INK 7{00 00 07 00 00 }
	LD HL,FLOAT_2	;7
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeInk
; 		60.4  BRIGHT 1{00 00 01 00 00 }
	LD HL,FLOAT_3	;1
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeBright
; 		60.5  CLS 
	CALL runtimeCls
ZXBASIC_LINE_70:
; 70  PRINT  AT 0,12; INK 2;"ZXombies!"
; 		70.1  PRINT  AT 0{00 00 00 00 00 },12{00 00 0c 00 00 }; INK 2{00 00 02 00 00 };"ZXombies!"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,FLOAT_1	;0
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	PUSH HL
	LD HL,FLOAT_4	;12
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	POP DE
	CALL runtimePrintAt
	LD HL,FLOAT_5	;2
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeLocalInk
	LD HL,STRING_0	;ZXombies!
	CALL runtimePrintString
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_80:
; 80  PRINT  AT 2,3; INK 6; BRIGHT 0;"It's 1983 and the dead are"; AT 3,5;"rising from the grave."; AT 4,8;"Who can save us?"
; 		80.1  PRINT  AT 2{00 00 02 00 00 },3{00 00 03 00 00 }; INK 6{00 00 06 00 00 }; BRIGHT 0{00 00 00 00 00 };"It's 1983 and the dead are"; AT 3{00 00 03 00 00 },5{00 00 05 00 00 };"rising from the grave."; AT 4{00 00 04 00 00 },8{00 00 08 00 00 };"Who can save us?"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,FLOAT_5	;2
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	PUSH HL
	LD HL,FLOAT_6	;3
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	POP DE
	CALL runtimePrintAt
	LD HL,FLOAT_7	;6
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeLocalInk
	LD HL,FLOAT_1	;0
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeLocalBright
	LD HL,STRING_1	;It's 1983 and the dead are
	CALL runtimePrintString
	LD HL,FLOAT_6	;3
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	PUSH HL
	LD HL,FLOAT_8	;5
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	POP DE
	CALL runtimePrintAt
	LD HL,STRING_2	;rising from the grave.
	CALL runtimePrintString
	LD HL,FLOAT_9	;4
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	PUSH HL
	LD HL,FLOAT_10	;8
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	POP DE
	CALL runtimePrintAt
	LD HL,STRING_3	;Who can save us?
	CALL runtimePrintString
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_90:
; 90  PRINT  AT 18,9; INK 4; BRIGHT 0;"2017 @xenopunk"
; 		90.1  PRINT  AT 18{00 00 12 00 00 },9{00 00 09 00 00 }; INK 4{00 00 04 00 00 }; BRIGHT 0{00 00 00 00 00 };"2017 @xenopunk"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,FLOAT_11	;18
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	PUSH HL
	LD HL,FLOAT_12	;9
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	POP DE
	CALL runtimePrintAt
	LD HL,FLOAT_9	;4
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeLocalInk
	LD HL,FLOAT_1	;0
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeLocalBright
	LD HL,STRING_4	;2017 @xenopunk
	CALL runtimePrintString
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_100:
; 100  PRINT  AT 19,7; INK 4; BRIGHT 0;"#zxspectrumbasicjam"
; 		100.1  PRINT  AT 19{00 00 13 00 00 },7{00 00 07 00 00 }; INK 4{00 00 04 00 00 }; BRIGHT 0{00 00 00 00 00 };"#zxspectrumbasicjam"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,FLOAT_13	;19
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	PUSH HL
	LD HL,FLOAT_2	;7
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	POP DE
	CALL runtimePrintAt
	LD HL,FLOAT_9	;4
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeLocalInk
	LD HL,FLOAT_1	;0
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeLocalBright
	LD HL,STRING_5	;#zxspectrumbasicjam
	CALL runtimePrintString
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_110:
; 110  REM --------Define graphics
ZXBASIC_LINE_120:
; 120  IF UDG THEN  GOTO 230
; 		120.1  IF UDG THEN  GOTO 230{00 00 e6 00 00 }
	LD HL,ZXBASIC_VAR_UDG
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_1
; 		120.2  GOTO 230{00 00 e6 00 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_230
ZXB_LABEL_1:
ZXBASIC_LINE_130:
; 130  PRINT  AT 21,8; INK 1; BRIGHT 0;"Decomposing"
; 		130.1  PRINT  AT 21{00 00 15 00 00 },8{00 00 08 00 00 }; INK 1{00 00 01 00 00 }; BRIGHT 0{00 00 00 00 00 };"Decomposing"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,FLOAT_15	;21
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	PUSH HL
	LD HL,FLOAT_10	;8
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	POP DE
	CALL runtimePrintAt
	LD HL,FLOAT_3	;1
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeLocalInk
	LD HL,FLOAT_1	;0
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeLocalBright
	LD HL,STRING_6	;Decomposing
	CALL runtimePrintString
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_140:
; 140  DATA 56: RESTORE 140: READ n: FOR i=1 TO n: READ b: POKE  USR "a"+i-1,b: PRINT  AT 21,20; INK 1; BRIGHT 0;i;"/";n: BEEP 0.002,i: NEXT i
; 		140.1  DATA 56{00 00 38 00 00 }
; 		140.2  RESTORE 140{00 00 8c 00 00 }
	LD HL,DATA_140
	LD (DATAPTR),HL
; 		140.3  READ n
	LD HL,(DATAPTR)
	LD DE,ZXBASIC_VAR_n
	LD BC,5
	LDIR
	LD (DATAPTR),HL
; 		140.4  FOR i=1{00 00 01 00 00 } TO n
	CALL runtimeCheckBreak
	LD HL,FLOAT_3	;1
	LD DE,ZXBASIC_VAR_i
	LD BC,5
	LDIR
	LD HL,ZXBASIC_VAR_n
	LD DE,ZXBASIC_VAR_for_i
	LD BC,5
	LDIR
FOR_0:
; 		140.5  READ b
	LD HL,(DATAPTR)
	LD DE,ZXBASIC_VAR_b
	LD BC,5
	LDIR
	LD (DATAPTR),HL
; 		140.6  POKE  USR "a"+i-1{00 00 01 00 00 },b
; USR
	LD HL,STRING_7	;a
	CALL runtimeUsrUDG
	PUSH HL
	LD HL,ZXBASIC_VAR_i
	CALL runtimePushFloatVar
; +
	POP HL
	CALL runtimeIntToFloat
	CALL runtimePlusFloat
	LD HL,FLOAT_3	;1
	CALL runtimePushFloatVar
; -
	RST $28
	DB $03	;SUB
	DB $38	;END CALC
	CALL runtimeFloatToInt
	PUSH HL
	LD HL,ZXBASIC_VAR_b
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	POP DE
	EX HL,DE
	LD (HL),E
; 		140.7  PRINT  AT 21{00 00 15 00 00 },20{00 00 14 00 00 }; INK 1{00 00 01 00 00 }; BRIGHT 0{00 00 00 00 00 };i;"/";n
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,FLOAT_15	;21
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	PUSH HL
	LD HL,FLOAT_17	;20
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	POP DE
	CALL runtimePrintAt
	LD HL,FLOAT_3	;1
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeLocalInk
	LD HL,FLOAT_1	;0
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeLocalBright
	LD HL,ZXBASIC_VAR_i
	CALL runtimePushFloatVar
	CALL runtimePrintFloat
	LD HL,STRING_8	;/
	CALL runtimePrintString
	LD HL,ZXBASIC_VAR_n
	CALL runtimePushFloatVar
	CALL runtimePrintFloat
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
; 		140.8  BEEP 0.002{78 03 12 6e 97 },i
	LD HL,FLOAT_18	;0.002
	CALL runtimePushFloatVar
	LD HL,ZXBASIC_VAR_i
	CALL runtimePushFloatVar
	CALL $03F8
; 		140.9  NEXT i
	CALL runtimeCheckBreak
	LD HL,ZXBASIC_VAR_i
	CALL runtimePushFloatVar
	RST $28
	DB zxcalc_stack_one	;STACK ONE
	DB zxcalc_addition	;ADD
	DB zxcalc_end_calc	;END CALC
	LD HL,ZXBASIC_VAR_i
	CALL runtimeStoreFloat
	LD HL,ZXBASIC_VAR_for_i
	CALL runtimePushFloatVar
	LD HL,ZXBASIC_VAR_i
	CALL runtimePushFloatVar
	CALL runtimeSmallerFloat
	LD A,L
	CP 0
	JP Z,FOR_0
ZXBASIC_LINE_150:
; 150  DATA 24,24,16,60,90,24,36,68
; 		150.1  DATA 24{00 00 18 00 00 },24{00 00 18 00 00 },16{00 00 10 00 00 },60{00 00 3c 00 00 },90{00 00 5a 00 00 },24{00 00 18 00 00 },36{00 00 24 00 00 },68{00 00 44 00 00 }
ZXBASIC_LINE_160:
; 160  DATA 0,60,126,66,126,66,126,126
; 		160.1  DATA 0{00 00 00 00 00 },60{00 00 3c 00 00 },126{00 00 7e 00 00 },66{00 00 42 00 00 },126{00 00 7e 00 00 },66{00 00 42 00 00 },126{00 00 7e 00 00 },126{00 00 7e 00 00 }
ZXBASIC_LINE_170:
; 170  DATA 0,8,16,223,252,34,65,0
; 		170.1  DATA 0{00 00 00 00 00 },8{00 00 08 00 00 },16{00 00 10 00 00 },223{00 00 df 00 00 },252{00 00 fc 00 00 },34{00 00 22 00 00 },65{00 00 41 00 00 },0{00 00 00 00 00 }
ZXBASIC_LINE_180:
; 180  DATA 24,24,16,30,24,24,20,36
; 		180.1  DATA 24{00 00 18 00 00 },24{00 00 18 00 00 },16{00 00 10 00 00 },30{00 00 1e 00 00 },24{00 00 18 00 00 },24{00 00 18 00 00 },20{00 00 14 00 00 },36{00 00 24 00 00 }
ZXBASIC_LINE_190:
; 190  DATA 24,24,82,60,24,24,20,20
; 		190.1  DATA 24{00 00 18 00 00 },24{00 00 18 00 00 },82{00 00 52 00 00 },60{00 00 3c 00 00 },24{00 00 18 00 00 },24{00 00 18 00 00 },20{00 00 14 00 00 },20{00 00 14 00 00 }
ZXBASIC_LINE_200:
; 200  DATA 24,24,16,56,124,186,40,68
; 		200.1  DATA 24{00 00 18 00 00 },24{00 00 18 00 00 },16{00 00 10 00 00 },56{00 00 38 00 00 },124{00 00 7c 00 00 },186{00 00 ba 00 00 },40{00 00 28 00 00 },68{00 00 44 00 00 }
ZXBASIC_LINE_210:
; 210  DATA 0,24,24,126,126,24,24,0
; 		210.1  DATA 0{00 00 00 00 00 },24{00 00 18 00 00 },24{00 00 18 00 00 },126{00 00 7e 00 00 },126{00 00 7e 00 00 },24{00 00 18 00 00 },24{00 00 18 00 00 },0{00 00 00 00 00 }
ZXBASIC_LINE_220:
; 220  LET UDG=1
; 		220.1  LET UDG=1{00 00 01 00 00 }
	LD HL,FLOAT_3	;1
	LD DE,ZXBASIC_VAR_UDG
	LD BC,5
	LDIR
ZXBASIC_LINE_230:
; 230  REM -----------Instructions
ZXBASIC_LINE_240:
; 240  PRINT  AT 6,3; INK 3;"\144"; INK 7; BRIGHT 0;" MAGENTA       100% badass"
; 		240.1  PRINT  AT 6{00 00 06 00 00 },3{00 00 03 00 00 }; INK 3{00 00 03 00 00 };"\144"; INK 7{00 00 07 00 00 }; BRIGHT 0{00 00 00 00 00 };" MAGENTA       100% badass"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,FLOAT_7	;6
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	PUSH HL
	LD HL,FLOAT_6	;3
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	POP DE
	CALL runtimePrintAt
	LD HL,FLOAT_6	;3
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeLocalInk
	LD HL,STRING_9	;\90
	CALL runtimePrintString
	LD HL,FLOAT_2	;7
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeLocalInk
	LD HL,FLOAT_1	;0
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeLocalBright
	LD HL,STRING_10	; MAGENTA       100% badass
	CALL runtimePrintString
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_250:
; 250  PRINT  AT 8,3; INK 4; BRIGHT 1;"\147"; INK 7; BRIGHT 0;" DAWDLER        +10 points"
; 		250.1  PRINT  AT 8{00 00 08 00 00 },3{00 00 03 00 00 }; INK 4{00 00 04 00 00 }; BRIGHT 1{00 00 01 00 00 };"\147"; INK 7{00 00 07 00 00 }; BRIGHT 0{00 00 00 00 00 };" DAWDLER        +10 points"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,FLOAT_10	;8
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	PUSH HL
	LD HL,FLOAT_6	;3
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	POP DE
	CALL runtimePrintAt
	LD HL,FLOAT_9	;4
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeLocalInk
	LD HL,FLOAT_3	;1
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeLocalBright
	LD HL,STRING_11	;\93
	CALL runtimePrintString
	LD HL,FLOAT_2	;7
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeLocalInk
	LD HL,FLOAT_1	;0
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeLocalBright
	LD HL,STRING_12	; DAWDLER        +10 points
	CALL runtimePrintString
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_260:
; 260  PRINT  AT 10,3; INK 5; BRIGHT 1;"\148"; INK 7; BRIGHT 0;" WHINGER        +20 points"
; 		260.1  PRINT  AT 10{00 00 0a 00 00 },3{00 00 03 00 00 }; INK 5{00 00 05 00 00 }; BRIGHT 1{00 00 01 00 00 };"\148"; INK 7{00 00 07 00 00 }; BRIGHT 0{00 00 00 00 00 };" WHINGER        +20 points"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,FLOAT_19	;10
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	PUSH HL
	LD HL,FLOAT_6	;3
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	POP DE
	CALL runtimePrintAt
	LD HL,FLOAT_8	;5
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeLocalInk
	LD HL,FLOAT_3	;1
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeLocalBright
	LD HL,STRING_13	;\94
	CALL runtimePrintString
	LD HL,FLOAT_2	;7
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeLocalInk
	LD HL,FLOAT_1	;0
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeLocalBright
	LD HL,STRING_14	; WHINGER        +20 points
	CALL runtimePrintString
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_270:
; 270  PRINT  AT 12,3; INK 6; BRIGHT 1;"\149"; INK 7; BRIGHT 0;" GUZZLER        +30 points"
; 		270.1  PRINT  AT 12{00 00 0c 00 00 },3{00 00 03 00 00 }; INK 6{00 00 06 00 00 }; BRIGHT 1{00 00 01 00 00 };"\149"; INK 7{00 00 07 00 00 }; BRIGHT 0{00 00 00 00 00 };" GUZZLER        +30 points"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,FLOAT_4	;12
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	PUSH HL
	LD HL,FLOAT_6	;3
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	POP DE
	CALL runtimePrintAt
	LD HL,FLOAT_7	;6
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeLocalInk
	LD HL,FLOAT_3	;1
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeLocalBright
	LD HL,STRING_15	;\95
	CALL runtimePrintString
	LD HL,FLOAT_2	;7
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeLocalInk
	LD HL,FLOAT_1	;0
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeLocalBright
	LD HL,STRING_16	; GUZZLER        +30 points
	CALL runtimePrintString
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_280:
; 280  PRINT  AT 14,3; PAPER 2; INK 7; BRIGHT 1;"\150"; PAPER 0; INK 7; BRIGHT 0;" PLASTER           +1 life"
; 		280.1  PRINT  AT 14{00 00 0e 00 00 },3{00 00 03 00 00 }; PAPER 2{00 00 02 00 00 }; INK 7{00 00 07 00 00 }; BRIGHT 1{00 00 01 00 00 };"\150"; PAPER 0{00 00 00 00 00 }; INK 7{00 00 07 00 00 }; BRIGHT 0{00 00 00 00 00 };" PLASTER           +1 life"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,FLOAT_20	;14
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	PUSH HL
	LD HL,FLOAT_6	;3
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	POP DE
	CALL runtimePrintAt
	LD HL,FLOAT_5	;2
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeLocalPaper
	LD HL,FLOAT_2	;7
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeLocalInk
	LD HL,FLOAT_3	;1
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeLocalBright
	LD HL,STRING_17	;\96
	CALL runtimePrintString
	LD HL,FLOAT_1	;0
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeLocalPaper
	LD HL,FLOAT_2	;7
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeLocalInk
	LD HL,FLOAT_1	;0
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeLocalBright
	LD HL,STRING_18	; PLASTER           +1 life
	CALL runtimePrintString
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_290:
; 290  PRINT  AT 16,3; INK 5; BRIGHT 1;"QAOP to move + M to attack!"
; 		290.1  PRINT  AT 16{00 00 10 00 00 },3{00 00 03 00 00 }; INK 5{00 00 05 00 00 }; BRIGHT 1{00 00 01 00 00 };"QAOP to move + M to attack!"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,FLOAT_21	;16
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	PUSH HL
	LD HL,FLOAT_6	;3
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	POP DE
	CALL runtimePrintAt
	LD HL,FLOAT_8	;5
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeLocalInk
	LD HL,FLOAT_3	;1
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeLocalBright
	LD HL,STRING_19	;QAOP to move + M to attack!
	CALL runtimePrintString
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_300:
; 300  PRINT  AT 21,0; INK 7; FLASH 1;"     Press any key to start     "
; 		300.1  PRINT  AT 21{00 00 15 00 00 },0{00 00 00 00 00 }; INK 7{00 00 07 00 00 }; FLASH 1{00 00 01 00 00 };"     Press any key to start     "
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,FLOAT_15	;21
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	PUSH HL
	LD HL,FLOAT_1	;0
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	POP DE
	CALL runtimePrintAt
	LD HL,FLOAT_2	;7
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeLocalInk
	LD HL,FLOAT_3	;1
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeLocalFlash
	LD HL,STRING_20	;     Press any key to start     
	CALL runtimePrintString
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_310:
; 310  IF  INKEY$ ="" THEN  GOTO 310
; 		310.1  IF  INKEY$ ="" THEN  GOTO 310{00 00 36 01 00 }
; INKEY$
	CALL runtimeInkey
	LD DE,HL
	LD HL,STRING_21	;
; =
	CALL runtimeEqualString
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_2
; 		310.2  GOTO 310{00 00 36 01 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_310
ZXB_LABEL_2:
ZXBASIC_LINE_320:
; 320  REM \134\134\134\134\134\134\134\134\134\134\134\134 Start game
ZXBASIC_LINE_330:
; 330  BORDER 0: PAPER 0: INK 7: BRIGHT 1: CLS 
; 		330.1  BORDER 0{00 00 00 00 00 }
	LD HL,FLOAT_1	;0
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD A,L
	call $2297
; 		330.2  PAPER 0{00 00 00 00 00 }
	LD HL,FLOAT_1	;0
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimePaper
; 		330.3  INK 7{00 00 07 00 00 }
	LD HL,FLOAT_2	;7
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeInk
; 		330.4  BRIGHT 1{00 00 01 00 00 }
	LD HL,FLOAT_3	;1
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeBright
; 		330.5  CLS 
	CALL runtimeCls
ZXBASIC_LINE_340:
; 340  REM ---------------Draw map
ZXBASIC_LINE_350:
; 350  INK 1: BRIGHT 0
; 		350.1  INK 1{00 00 01 00 00 }
	LD HL,FLOAT_3	;1
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeInk
; 		350.2  BRIGHT 0{00 00 00 00 00 }
	LD HL,FLOAT_1	;0
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeBright
ZXBASIC_LINE_360:
; 360  PRINT  AT 2,0;"+++++++++++++++++++++++++++++++++"
; 		360.1  PRINT  AT 2{00 00 02 00 00 },0{00 00 00 00 00 };"+++++++++++++++++++++++++++++++++"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,FLOAT_5	;2
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	PUSH HL
	LD HL,FLOAT_1	;0
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	POP DE
	CALL runtimePrintAt
	LD HL,STRING_22	;+++++++++++++++++++++++++++++++++
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_370:
; 370  FOR i=3 TO 19
; 		370.1  FOR i=3{00 00 03 00 00 } TO 19{00 00 13 00 00 }
	CALL runtimeCheckBreak
	LD HL,FLOAT_6	;3
	LD DE,ZXBASIC_VAR_i
	LD BC,5
	LDIR
	LD HL,FLOAT_13	;19
	LD DE,ZXBASIC_VAR_for_i
	LD BC,5
	LDIR
FOR_1:
ZXBASIC_LINE_380:
; 380  PRINT  AT i,31;"++"
; 		380.1  PRINT  AT i,31{00 00 1f 00 00 };"++"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,ZXBASIC_VAR_i
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	PUSH HL
	LD HL,FLOAT_23	;31
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	POP DE
	CALL runtimePrintAt
	LD HL,STRING_23	;++
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_390:
; 390  NEXT i
; 		390.1  NEXT i
	CALL runtimeCheckBreak
	LD HL,ZXBASIC_VAR_i
	CALL runtimePushFloatVar
	RST $28
	DB zxcalc_stack_one	;STACK ONE
	DB zxcalc_addition	;ADD
	DB zxcalc_end_calc	;END CALC
	LD HL,ZXBASIC_VAR_i
	CALL runtimeStoreFloat
	LD HL,ZXBASIC_VAR_for_i
	CALL runtimePushFloatVar
	LD HL,ZXBASIC_VAR_i
	CALL runtimePushFloatVar
	CALL runtimeSmallerFloat
	LD A,L
	CP 0
	JP Z,FOR_1
ZXBASIC_LINE_400:
; 400  PRINT  AT 20,31;"+++++++++++++++++++++++++++++++++"
; 		400.1  PRINT  AT 20{00 00 14 00 00 },31{00 00 1f 00 00 };"+++++++++++++++++++++++++++++++++"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,FLOAT_17	;20
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	PUSH HL
	LD HL,FLOAT_23	;31
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	POP DE
	CALL runtimePrintAt
	LD HL,STRING_22	;+++++++++++++++++++++++++++++++++
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_410:
; 410  INK 7: BRIGHT 1
; 		410.1  INK 7{00 00 07 00 00 }
	LD HL,FLOAT_2	;7
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeInk
; 		410.2  BRIGHT 1{00 00 01 00 00 }
	LD HL,FLOAT_3	;1
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeBright
ZXBASIC_LINE_420:
; 420  REM -----------Setup player
ZXBASIC_LINE_430:
; 430  LET score=0: PRINT  AT 0,0; BRIGHT 0;"Score:": GOSUB 1210
; 		430.1  LET score=0{00 00 00 00 00 }
	LD HL,FLOAT_1	;0
	LD DE,ZXBASIC_VAR_score
	LD BC,5
	LDIR
; 		430.2  PRINT  AT 0{00 00 00 00 00 },0{00 00 00 00 00 }; BRIGHT 0{00 00 00 00 00 };"Score
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,FLOAT_1	;0
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	PUSH HL
	LD HL,FLOAT_1	;0
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	POP DE
	CALL runtimePrintAt
	LD HL,FLOAT_1	;0
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeLocalBright
	LD HL,STRING_24	;Score:
	CALL runtimePrintString
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
; 		430.3  GOSUB 1210{00 00 ba 04 00 }
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_1210
ZXBASIC_LINE_440:
; 440  LET lives=3: PRINT  AT 0,23; BRIGHT 0;"Lives:"; INK 3; BRIGHT 1;"\144\144\144"
; 		440.1  LET lives=3{00 00 03 00 00 }
	LD HL,FLOAT_6	;3
	LD DE,ZXBASIC_VAR_lives
	LD BC,5
	LDIR
; 		440.2  PRINT  AT 0{00 00 00 00 00 },23{00 00 17 00 00 }; BRIGHT 0{00 00 00 00 00 };"Lives
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,FLOAT_1	;0
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	PUSH HL
	LD HL,FLOAT_25	;23
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	POP DE
	CALL runtimePrintAt
	LD HL,FLOAT_1	;0
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeLocalBright
	LD HL,STRING_25	;Lives:
	CALL runtimePrintString
	LD HL,FLOAT_6	;3
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeLocalInk
	LD HL,FLOAT_3	;1
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeLocalBright
	LD HL,STRING_26	;\90\90\90
	CALL runtimePrintString
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_450:
; 450  LET wave=1: PRINT  AT 0,13; BRIGHT 0;"Wave:": GOSUB 1240
; 		450.1  LET wave=1{00 00 01 00 00 }
	LD HL,FLOAT_3	;1
	LD DE,ZXBASIC_VAR_wave
	LD BC,5
	LDIR
; 		450.2  PRINT  AT 0{00 00 00 00 00 },13{00 00 0d 00 00 }; BRIGHT 0{00 00 00 00 00 };"Wave
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,FLOAT_1	;0
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	PUSH HL
	LD HL,FLOAT_26	;13
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	POP DE
	CALL runtimePrintAt
	LD HL,FLOAT_1	;0
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeLocalBright
	LD HL,STRING_27	;Wave:
	CALL runtimePrintString
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
; 		450.3  GOSUB 1240{00 00 d8 04 00 }
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_1240
ZXBASIC_LINE_460:
; 460  REM \134\134\134\134\134\134\134\134\134\134\134\134 Start wave
ZXBASIC_LINE_470:
; 470  DIM s(22,32)
; 		470.1  DIM s(22{00 00 16 00 00 },32{00 00 20 00 00 })
	LD HL,ZXBASIC_VAR_s_array
	LD BC,2645
	CALL runtimeClearArray
ZXBASIC_LINE_480:
; 480  REM ----------Setup zombies
ZXBASIC_LINE_490:
; 490  LET nz=5+ INT ( RND *25)
; 		490.1  LET nz=5{00 00 05 00 00 }+ INT ( RND *25{00 00 19 00 00 })
	LD HL,FLOAT_8	;5
	CALL runtimePushFloatVar
; INT
; RND
	CALL runtimeRND
	LD HL,FLOAT_28	;25
	CALL runtimePushFloatVar
; *
	RST $28
	DB $04	;MULT
	DB $38	;END CALC
	CALL runtimeFloatToInt
; +
	CALL runtimeIntToFloat
	CALL runtimePlusFloat
	LD HL,ZXBASIC_VAR_nz
	CALL runtimeStoreFloat
ZXBASIC_LINE_500:
; 500  LET za=4/7
; 		500.1  LET za=4{00 00 04 00 00 }/7{00 00 07 00 00 }
	LD HL,FLOAT_9	;4
	CALL runtimePushFloatVar
	LD HL,FLOAT_2	;7
	CALL runtimePushFloatVar
; /
	RST $28
	DB $05	;DIV
	DB $38	;END CALC
	LD HL,ZXBASIC_VAR_za
	CALL runtimeStoreFloat
ZXBASIC_LINE_510:
; 510  LET zb=2/3
; 		510.1  LET zb=2{00 00 02 00 00 }/3{00 00 03 00 00 }
	LD HL,FLOAT_5	;2
	CALL runtimePushFloatVar
	LD HL,FLOAT_6	;3
	CALL runtimePushFloatVar
; /
	RST $28
	DB $05	;DIV
	DB $38	;END CALC
	LD HL,ZXBASIC_VAR_zb
	CALL runtimeStoreFloat
ZXBASIC_LINE_520:
; 520  LET zc=1
; 		520.1  LET zc=1{00 00 01 00 00 }
	LD HL,FLOAT_3	;1
	LD DE,ZXBASIC_VAR_zc
	LD BC,5
	LDIR
ZXBASIC_LINE_530:
; 530  DIM x(nz)
; 		530.1  DIM x(nz)
; 		530.2 )
ZXBASIC_LINE_540:
; 540  DIM y(nz)
; 		540.1  DIM y(nz)
; 		540.2 )
ZXBASIC_LINE_550:
; 550  DIM c$(nz,1): DIM d$(nz,1)
; 		550.1  DIM c$(nz,1{00 00 01 00 00 })
; 		550.2 ,1{00 00 01 00 00 })
; 		550.3 )
; 		550.4  DIM d$(nz,1{00 00 01 00 00 })
; 		550.5 ,1{00 00 01 00 00 })
; 		550.6 )
ZXBASIC_LINE_560:
; 560  DIM c(nz): DIM d(nz)
; 		560.1  DIM c(nz)
; 		560.2 )
; 		560.3  DIM d(nz)
; 		560.4 )
ZXBASIC_LINE_570:
; 570  LET zi=1
; 		570.1  LET zi=1{00 00 01 00 00 }
	LD HL,FLOAT_3	;1
	LD DE,ZXBASIC_VAR_zi
	LD BC,5
	LDIR
ZXBASIC_LINE_580:
; 580  LET kz=0
; 		580.1  LET kz=0{00 00 00 00 00 }
	LD HL,FLOAT_1	;0
	LD DE,ZXBASIC_VAR_kz
	LD BC,5
	LDIR
ZXBASIC_LINE_590:
; 590  PRINT  AT 1,10; INK 1;"Exhuming"
; 		590.1  PRINT  AT 1{00 00 01 00 00 },10{00 00 0a 00 00 }; INK 1{00 00 01 00 00 };"Exhuming"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,FLOAT_3	;1
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	PUSH HL
	LD HL,FLOAT_19	;10
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	POP DE
	CALL runtimePrintAt
	LD HL,FLOAT_3	;1
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeLocalInk
	LD HL,STRING_28	;Exhuming
	CALL runtimePrintString
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_600:
; 600  FOR i=1 TO nz
; 		600.1  FOR i=1{00 00 01 00 00 } TO nz
	CALL runtimeCheckBreak
	LD HL,FLOAT_3	;1
	LD DE,ZXBASIC_VAR_i
	LD BC,5
	LDIR
	LD HL,ZXBASIC_VAR_nz
	LD DE,ZXBASIC_VAR_for_i
	LD BC,5
	LDIR
FOR_2:
ZXBASIC_LINE_610:
; 610  LET x(i)=2+ INT ( RND *28)
; 		610.1  LET x(i)=2{00 00 02 00 00 }+ INT ( RND *28{00 00 1c 00 00 })
	LD HL,ZXBASIC_VAR_i
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD DE,5
	CALL runtimeMult16bit
	PUSH HL
	LD HL,FLOAT_5	;2
	CALL runtimePushFloatVar
; INT
; RND
	CALL runtimeRND
	LD HL,FLOAT_29	;28
	CALL runtimePushFloatVar
; *
	RST $28
	DB $04	;MULT
	DB $38	;END CALC
	CALL runtimeFloatToInt
; +
	CALL runtimeIntToFloat
	CALL runtimePlusFloat
	POP HL
	LD BC,ZXBASIC_VAR_x_array
	ADD HL,BC
	CALL runtimeStoreFloat
ZXBASIC_LINE_620:
; 620  LET y(i)=4+ INT ( RND *16)
; 		620.1  LET y(i)=4{00 00 04 00 00 }+ INT ( RND *16{00 00 10 00 00 })
	LD HL,ZXBASIC_VAR_i
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD DE,5
	CALL runtimeMult16bit
	PUSH HL
	LD HL,FLOAT_9	;4
	CALL runtimePushFloatVar
; INT
; RND
	CALL runtimeRND
	LD HL,FLOAT_21	;16
	CALL runtimePushFloatVar
; *
	RST $28
	DB $04	;MULT
	DB $38	;END CALC
	CALL runtimeFloatToInt
; +
	CALL runtimeIntToFloat
	CALL runtimePlusFloat
	POP HL
	LD BC,ZXBASIC_VAR_y_array
	ADD HL,BC
	CALL runtimeStoreFloat
ZXBASIC_LINE_630:
; 630  IF s(y(i),x(i)) THEN  GOTO 610
; 		630.1  IF s(y(i),x(i)) THEN  GOTO 610{00 00 62 02 00 }
; Array-Access
; Array-Access
	LD HL,ZXBASIC_VAR_i
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD DE,5
	CALL runtimeMult16bit
	LD DE, ZXBASIC_VAR_y_array
	ADD HL,DE
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD DE,22
	CALL runtimeMult16bit
	PUSH HL
; Array-Access
	LD HL,ZXBASIC_VAR_i
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD DE,5
	CALL runtimeMult16bit
	LD DE, ZXBASIC_VAR_x_array
	ADD HL,DE
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	POP DE
	ADD HL,DE
	LD DE,5
	CALL runtimeMult16bit
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_3
; 		630.2  GOTO 610{00 00 62 02 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_610
ZXB_LABEL_3:
ZXBASIC_LINE_640:
; 640  LET s(y(i),x(i))=i
; 		640.1  LET s(y(i),x(i))=i
; Array-Access
	LD HL,ZXBASIC_VAR_i
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD DE,5
	CALL runtimeMult16bit
	LD DE, ZXBASIC_VAR_y_array
	ADD HL,DE
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD DE,22
	CALL runtimeMult16bit
	PUSH HL
; Array-Access
	LD HL,ZXBASIC_VAR_i
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD DE,5
	CALL runtimeMult16bit
	LD DE, ZXBASIC_VAR_x_array
	ADD HL,DE
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	POP DE
	ADD HL,DE
	LD DE,5
	CALL runtimeMult16bit
	PUSH HL
	LD HL,ZXBASIC_VAR_i
	CALL runtimePushFloatVar
	POP HL
	LD BC,ZXBASIC_VAR_s_array
	ADD HL,BC
	CALL runtimeStoreFloat
ZXBASIC_LINE_650:
; 650  LET c$(i)="\145": LET c(i)=7: PRINT  AT y(i),x(i); INK 7; BRIGHT 0;"\145"
; 		650.1  LET c$(i)="\145"
	LD HL,ZXBASIC_VAR_i
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD DE,HL
	LD HL,ZXBASIC_VAR_c_string
	ADD HL,DE
	LD DE,HL
	LD HL,STRING_29	;\91
	LD BC,1
	CALL runtimeStoreStringVarFix
; 		650.2  LET c(i)=7{00 00 07 00 00 }
	LD HL,ZXBASIC_VAR_i
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD DE,5
	CALL runtimeMult16bit
	PUSH HL
	LD HL,FLOAT_2	;7
	CALL runtimePushFloatVar
	POP HL
	LD BC,ZXBASIC_VAR_c_array
	ADD HL,BC
	CALL runtimeStoreFloat
; 		650.3  PRINT  AT y(i),x(i); INK 7{00 00 07 00 00 }; BRIGHT 0{00 00 00 00 00 };"\145"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
; Array-Access
	LD HL,ZXBASIC_VAR_i
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD DE,5
	CALL runtimeMult16bit
	LD DE, ZXBASIC_VAR_y_array
	ADD HL,DE
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	PUSH HL
; Array-Access
	LD HL,ZXBASIC_VAR_i
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD DE,5
	CALL runtimeMult16bit
	LD DE, ZXBASIC_VAR_x_array
	ADD HL,DE
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	POP DE
	CALL runtimePrintAt
	LD HL,FLOAT_2	;7
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeLocalInk
	LD HL,FLOAT_1	;0
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeLocalBright
	LD HL,STRING_29	;\91
	CALL runtimePrintString
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_660:
; 660  IF  RND <za THEN  LET d$(i)="\147": LET d(i)=4: GOTO 700
; 		660.1  IF  RND <za THEN  LET d$(i)="\147"
; RND
	CALL runtimeRND
	LD HL,ZXBASIC_VAR_za
	CALL runtimePushFloatVar
; <
	CALL runtimeSmallerFloat
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_4
; 		660.2  LET d$(i)="\147"
	LD HL,ZXBASIC_VAR_i
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD DE,HL
	LD HL,ZXBASIC_VAR_d_string
	ADD HL,DE
	LD DE,HL
	LD HL,STRING_11	;\93
	LD BC,1
	CALL runtimeStoreStringVarFix
; 		660.3  LET d(i)=4{00 00 04 00 00 }
	LD HL,ZXBASIC_VAR_i
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD DE,5
	CALL runtimeMult16bit
	PUSH HL
	LD HL,FLOAT_9	;4
	CALL runtimePushFloatVar
	POP HL
	LD BC,ZXBASIC_VAR_d_array
	ADD HL,BC
	CALL runtimeStoreFloat
; 		660.4  GOTO 700{00 00 bc 02 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_700
ZXB_LABEL_4:
ZXBASIC_LINE_670:
; 670  IF  RND <zb THEN  LET d$(i)="\148": LET d(i)=5: GOTO 700
; 		670.1  IF  RND <zb THEN  LET d$(i)="\148"
; RND
	CALL runtimeRND
	LD HL,ZXBASIC_VAR_zb
	CALL runtimePushFloatVar
; <
	CALL runtimeSmallerFloat
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_5
; 		670.2  LET d$(i)="\148"
	LD HL,ZXBASIC_VAR_i
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD DE,HL
	LD HL,ZXBASIC_VAR_d_string
	ADD HL,DE
	LD DE,HL
	LD HL,STRING_13	;\94
	LD BC,1
	CALL runtimeStoreStringVarFix
; 		670.3  LET d(i)=5{00 00 05 00 00 }
	LD HL,ZXBASIC_VAR_i
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD DE,5
	CALL runtimeMult16bit
	PUSH HL
	LD HL,FLOAT_8	;5
	CALL runtimePushFloatVar
	POP HL
	LD BC,ZXBASIC_VAR_d_array
	ADD HL,BC
	CALL runtimeStoreFloat
; 		670.4  GOTO 700{00 00 bc 02 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_700
ZXB_LABEL_5:
ZXBASIC_LINE_680:
; 680  IF  RND <zc THEN  LET d$(i)="\149": LET d(i)=6
; 		680.1  IF  RND <zc THEN  LET d$(i)="\149"
; RND
	CALL runtimeRND
	LD HL,ZXBASIC_VAR_zc
	CALL runtimePushFloatVar
; <
	CALL runtimeSmallerFloat
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_6
; 		680.2  LET d$(i)="\149"
	LD HL,ZXBASIC_VAR_i
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD DE,HL
	LD HL,ZXBASIC_VAR_d_string
	ADD HL,DE
	LD DE,HL
	LD HL,STRING_15	;\95
	LD BC,1
	CALL runtimeStoreStringVarFix
; 		680.3  LET d(i)=6{00 00 06 00 00 }
	LD HL,ZXBASIC_VAR_i
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD DE,5
	CALL runtimeMult16bit
	PUSH HL
	LD HL,FLOAT_7	;6
	CALL runtimePushFloatVar
	POP HL
	LD BC,ZXBASIC_VAR_d_array
	ADD HL,BC
	CALL runtimeStoreFloat
ZXB_LABEL_6:
ZXBASIC_LINE_690:
; 690  REM LET c$(i)="\150": LET c(i)=7: PRINT AT y(i),x(i); PAPER 2; INK 7; BRIGHT 1;"\150"
ZXBASIC_LINE_700:
; 700  PRINT  AT 1,19; INK 1;i;"/";nz: BEEP 0.005,i-12
; 		700.1  PRINT  AT 1{00 00 01 00 00 },19{00 00 13 00 00 }; INK 1{00 00 01 00 00 };i;"/";nz
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,FLOAT_3	;1
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	PUSH HL
	LD HL,FLOAT_13	;19
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	POP DE
	CALL runtimePrintAt
	LD HL,FLOAT_3	;1
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeLocalInk
	LD HL,ZXBASIC_VAR_i
	CALL runtimePushFloatVar
	CALL runtimePrintFloat
	LD HL,STRING_8	;/
	CALL runtimePrintString
	LD HL,ZXBASIC_VAR_nz
	CALL runtimePushFloatVar
	CALL runtimePrintFloat
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
; 		700.2  BEEP 0.005{79 23 d7 0a 3d },i-12{00 00 0c 00 00 }
	LD HL,FLOAT_32	;0.005
	CALL runtimePushFloatVar
	LD HL,ZXBASIC_VAR_i
	CALL runtimePushFloatVar
	LD HL,FLOAT_4	;12
	CALL runtimePushFloatVar
; -
	RST $28
	DB $03	;SUB
	DB $38	;END CALC
	CALL $03F8
ZXBASIC_LINE_710:
; 710  NEXT i
; 		710.1  NEXT i
	CALL runtimeCheckBreak
	LD HL,ZXBASIC_VAR_i
	CALL runtimePushFloatVar
	RST $28
	DB zxcalc_stack_one	;STACK ONE
	DB zxcalc_addition	;ADD
	DB zxcalc_end_calc	;END CALC
	LD HL,ZXBASIC_VAR_i
	CALL runtimeStoreFloat
	LD HL,ZXBASIC_VAR_for_i
	CALL runtimePushFloatVar
	LD HL,ZXBASIC_VAR_i
	CALL runtimePushFloatVar
	CALL runtimeSmallerFloat
	LD A,L
	CP 0
	JP Z,FOR_2
ZXBASIC_LINE_720:
; 720  PRINT  AT 1,10;"              "
; 		720.1  PRINT  AT 1{00 00 01 00 00 },10{00 00 0a 00 00 };"              "
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,FLOAT_3	;1
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	PUSH HL
	LD HL,FLOAT_19	;10
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	POP DE
	CALL runtimePrintAt
	LD HL,STRING_30	;              
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_730:
; 730  GOSUB 1120
; 		730.1  GOSUB 1120{00 00 60 04 00 }
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_1120
ZXBASIC_LINE_740:
; 740  REM ---------Setup framrate
ZXBASIC_LINE_750:
; 750  LET t=65536* PEEK 23674+256* PEEK 23673+ PEEK 23672+50: LET f=0
; 		750.1  LET t=65536{91 00 00 00 00 }* PEEK 23674{00 00 7a 5c 00 }+256{00 00 00 01 00 }* PEEK 23673{00 00 79 5c 00 }+ PEEK 23672{00 00 78 5c 00 }+50{00 00 32 00 00 }
	LD HL,FLOAT_34	;65536
	CALL runtimePushFloatVar
; PEEK
	LD HL,FLOAT_35	;23674
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD L,(HL)
	LD H,0
; *
	CALL runtimeIntToFloat
	RST $28
	DB $04	;MULT
	DB $38	;END CALC
	LD HL,FLOAT_36	;256
	CALL runtimePushFloatVar
; PEEK
	LD HL,FLOAT_37	;23673
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD L,(HL)
	LD H,0
; *
	CALL runtimeIntToFloat
	RST $28
	DB $04	;MULT
; END CALC
; +
	DB $0f	;ADD
	DB $38	;END CALC
; PEEK
	LD HL,FLOAT_38	;23672
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD L,(HL)
	LD H,0
; +
	CALL runtimeIntToFloat
	CALL runtimePlusFloat
	LD HL,FLOAT_39	;50
	CALL runtimePushFloatVar
; +
	RST $28
	DB $0f	;ADD
	DB $38	;END CALC
	LD HL,ZXBASIC_VAR_t
	CALL runtimeStoreFloat
; 		750.2  LET f=0{00 00 00 00 00 }
	LD HL,FLOAT_1	;0
	LD DE,ZXBASIC_VAR_f
	LD BC,5
	LDIR
ZXBASIC_LINE_760:
; 760  REM \134\134\134\134\134\134\134\134\134\134\134\134\134 Game loop
ZXBASIC_LINE_770:
; 770  REM ----------Update player
ZXBASIC_LINE_780:
; 780  LET inkey= CODE  INKEY$ 
; 		780.1  LET inkey= CODE  INKEY$ 
; CODE
; INKEY$
	CALL runtimeInkey
	CALL runtimeCode
	CALL runtimeIntToFloat
	LD HL,ZXBASIC_VAR_inkey
	CALL runtimeStoreFloat
ZXBASIC_LINE_782:
; 782  LET dy=(inkey=10 AND  y<20)-(inkey=11 AND y>3): LET ny=y+dy
; 		782.1  LET dy=(inkey=10{00 00 0a 00 00 } AND  y<20{00 00 14 00 00 })-(inkey=11{00 00 0b 00 00 } AND y>3{00 00 03 00 00 })
; (
	LD HL,ZXBASIC_VAR_inkey
	CALL runtimePushFloatVar
	LD HL,FLOAT_19	;10
	CALL runtimePushFloatVar
; =
	CALL runtimeEqualFloat
	PUSH HL
	LD HL,ZXBASIC_VAR_y
	CALL runtimePushFloatVar
	LD HL,FLOAT_17	;20
	CALL runtimePushFloatVar
; <
	CALL runtimeSmallerFloat
; AND
	POP DE
	call runtimeAndHLDE
	PUSH HL
; )
; (
	LD HL,ZXBASIC_VAR_inkey
	CALL runtimePushFloatVar
	LD HL,FLOAT_40	;11
	CALL runtimePushFloatVar
; =
	CALL runtimeEqualFloat
	PUSH HL
	LD HL,ZXBASIC_VAR_y
	CALL runtimePushFloatVar
	LD HL,FLOAT_6	;3
	CALL runtimePushFloatVar
; >
	CALL runtimeBiggerFloat
; AND
	POP DE
	call runtimeAndHLDE
; )
; -
	POP DE
	EX HL,DE
	SUB HL,DE
	CALL runtimeIntToFloat
	LD HL,ZXBASIC_VAR_dy
	CALL runtimeStoreFloat
; 		782.2  LET ny=y+dy
	LD HL,ZXBASIC_VAR_y
	CALL runtimePushFloatVar
	LD HL,ZXBASIC_VAR_dy
	CALL runtimePushFloatVar
; +
	RST $28
	DB $0f	;ADD
	DB $38	;END CALC
	LD HL,ZXBASIC_VAR_ny
	CALL runtimeStoreFloat
ZXBASIC_LINE_783:
; 783  LET dx=(inkey=9  AND x<30)-( inkey = 8 AND x>1): LET nx=x+dx
; 		783.1  LET dx=(inkey=9 {00 00 09 00 00 } AND x<30{00 00 1e 00 00 })-( inkey = 8{00 00 08 00 00 } AND x>1{00 00 01 00 00 })
; (
	LD HL,ZXBASIC_VAR_inkey
	CALL runtimePushFloatVar
	LD HL,FLOAT_12	;9 
	CALL runtimePushFloatVar
; =
	CALL runtimeEqualFloat
	PUSH HL
	LD HL,ZXBASIC_VAR_x
	CALL runtimePushFloatVar
	LD HL,FLOAT_41	;30
	CALL runtimePushFloatVar
; <
	CALL runtimeSmallerFloat
; AND
	POP DE
	call runtimeAndHLDE
	PUSH HL
; )
; (
	LD HL,ZXBASIC_VAR_inkey
	CALL runtimePushFloatVar
	LD HL,FLOAT_10	;8
	CALL runtimePushFloatVar
; =
	CALL runtimeEqualFloat
	PUSH HL
	LD HL,ZXBASIC_VAR_x
	CALL runtimePushFloatVar
	LD HL,FLOAT_3	;1
	CALL runtimePushFloatVar
; >
	CALL runtimeBiggerFloat
; AND
	POP DE
	call runtimeAndHLDE
; )
; -
	POP DE
	EX HL,DE
	SUB HL,DE
	CALL runtimeIntToFloat
	LD HL,ZXBASIC_VAR_dx
	CALL runtimeStoreFloat
; 		783.2  LET nx=x+dx
	LD HL,ZXBASIC_VAR_x
	CALL runtimePushFloatVar
	LD HL,ZXBASIC_VAR_dx
	CALL runtimePushFloatVar
; +
	RST $28
	DB $0f	;ADD
	DB $38	;END CALC
	LD HL,ZXBASIC_VAR_nx
	CALL runtimeStoreFloat
ZXBASIC_LINE_784:
; 784  IF dx OR dy THEN  GOTO 810
; 		784.1  IF dx OR dy THEN  GOTO 810{00 00 2a 03 00 }
	LD HL,ZXBASIC_VAR_dx
	CALL runtimePushFloatVar
	LD HL,ZXBASIC_VAR_dy
	CALL runtimePushFloatVar
; OR
	CALL runtimeOrFloat
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_7
; 		784.2  GOTO 810{00 00 2a 03 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_810
ZXB_LABEL_7:
ZXBASIC_LINE_789:
; 789  LET dy=( IN 65022=190 AND y<20)-( IN 64510=190 AND y>3): LET ny=y+dy
; 		789.1  LET dy=( IN 65022{00 00 fe fd 00 }=190{00 00 be 00 00 } AND y<20{00 00 14 00 00 })-( IN 64510{00 00 fe fb 00 }=190{00 00 be 00 00 } AND y>3{00 00 03 00 00 })
; (
; IN
	LD HL,FLOAT_43	;65022
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD BC,HL
	IN A,(C)
	LD L,A
	LD H,0
	PUSH HL
	LD HL,FLOAT_44	;190
	CALL runtimePushFloatVar
; =
	POP HL
	CALL runtimeIntToFloat
	CALL runtimeEqualFloat
	PUSH HL
	LD HL,ZXBASIC_VAR_y
	CALL runtimePushFloatVar
	LD HL,FLOAT_17	;20
	CALL runtimePushFloatVar
; <
	CALL runtimeSmallerFloat
; AND
	POP DE
	call runtimeAndHLDE
	PUSH HL
; )
; (
; IN
	LD HL,FLOAT_45	;64510
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD BC,HL
	IN A,(C)
	LD L,A
	LD H,0
	PUSH HL
	LD HL,FLOAT_44	;190
	CALL runtimePushFloatVar
; =
	POP HL
	CALL runtimeIntToFloat
	CALL runtimeEqualFloat
	PUSH HL
	LD HL,ZXBASIC_VAR_y
	CALL runtimePushFloatVar
	LD HL,FLOAT_6	;3
	CALL runtimePushFloatVar
; >
	CALL runtimeBiggerFloat
; AND
	POP DE
	call runtimeAndHLDE
; )
; -
	POP DE
	EX HL,DE
	SUB HL,DE
	CALL runtimeIntToFloat
	LD HL,ZXBASIC_VAR_dy
	CALL runtimeStoreFloat
; 		789.2  LET ny=y+dy
	LD HL,ZXBASIC_VAR_y
	CALL runtimePushFloatVar
	LD HL,ZXBASIC_VAR_dy
	CALL runtimePushFloatVar
; +
	RST $28
	DB $0f	;ADD
	DB $38	;END CALC
	LD HL,ZXBASIC_VAR_ny
	CALL runtimeStoreFloat
ZXBASIC_LINE_790:
; 790  LET dx=( IN 57342=190 AND x<30)-( IN 57342=189 AND x>1): LET nx=x+dx
; 		790.1  LET dx=( IN 57342{00 00 fe df 00 }=190{00 00 be 00 00 } AND x<30{00 00 1e 00 00 })-( IN 57342{00 00 fe df 00 }=189{00 00 bd 00 00 } AND x>1{00 00 01 00 00 })
; (
; IN
	LD HL,FLOAT_46	;57342
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD BC,HL
	IN A,(C)
	LD L,A
	LD H,0
	PUSH HL
	LD HL,FLOAT_44	;190
	CALL runtimePushFloatVar
; =
	POP HL
	CALL runtimeIntToFloat
	CALL runtimeEqualFloat
	PUSH HL
	LD HL,ZXBASIC_VAR_x
	CALL runtimePushFloatVar
	LD HL,FLOAT_41	;30
	CALL runtimePushFloatVar
; <
	CALL runtimeSmallerFloat
; AND
	POP DE
	call runtimeAndHLDE
	PUSH HL
; )
; (
; IN
	LD HL,FLOAT_46	;57342
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD BC,HL
	IN A,(C)
	LD L,A
	LD H,0
	PUSH HL
	LD HL,FLOAT_47	;189
	CALL runtimePushFloatVar
; =
	POP HL
	CALL runtimeIntToFloat
	CALL runtimeEqualFloat
	PUSH HL
	LD HL,ZXBASIC_VAR_x
	CALL runtimePushFloatVar
	LD HL,FLOAT_3	;1
	CALL runtimePushFloatVar
; >
	CALL runtimeBiggerFloat
; AND
	POP DE
	call runtimeAndHLDE
; )
; -
	POP DE
	EX HL,DE
	SUB HL,DE
	CALL runtimeIntToFloat
	LD HL,ZXBASIC_VAR_dx
	CALL runtimeStoreFloat
; 		790.2  LET nx=x+dx
	LD HL,ZXBASIC_VAR_x
	CALL runtimePushFloatVar
	LD HL,ZXBASIC_VAR_dx
	CALL runtimePushFloatVar
; +
	RST $28
	DB $0f	;ADD
	DB $38	;END CALC
	LD HL,ZXBASIC_VAR_nx
	CALL runtimeStoreFloat
ZXBASIC_LINE_800:
; 800  IF  NOT (dx OR dy) THEN  GOTO 840
; 		800.1  IF  NOT (dx OR dy) THEN  GOTO 840{00 00 48 03 00 }
; NOT
	LD HL,ZXBASIC_VAR_dx
	CALL runtimePushFloatVar
	LD HL,ZXBASIC_VAR_dy
	CALL runtimePushFloatVar
; OR
	CALL runtimeOrFloat
	CALL runtimeNotHL
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_8
; 		800.2  GOTO 840{00 00 48 03 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_840
ZXB_LABEL_8:
ZXBASIC_LINE_805:
; 805  
ZXBASIC_LINE_810:
; 810  IF (inkey <> 0 OR  IN 32766=191) AND s(ny,nx)=0 THEN  LET s(y,x)=0: PRINT  AT y,x;" ": LET x=nx: LET y=ny: LET s(y,x)=-1: PRINT  AT y,x; INK 3; BRIGHT 1;"\144": BEEP 0.001,24: GOTO 840
; 		810.1  IF (inkey <> 0{00 00 00 00 00 } OR  IN 32766{00 00 fe 7f 00 }=191{00 00 bf 00 00 }) AND s(ny,nx)=0{00 00 00 00 00 } THEN  LET s(y,x)=0{00 00 00 00 00 }
; (
	LD HL,ZXBASIC_VAR_inkey
	CALL runtimePushFloatVar
	LD HL,FLOAT_1	;0
	CALL runtimePushFloatVar
; <>
	CALL runtimeUnequalFloat
	PUSH HL
; IN
	LD HL,FLOAT_49	;32766
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD BC,HL
	IN A,(C)
	LD L,A
	LD H,0
	PUSH HL
	LD HL,FLOAT_50	;191
	CALL runtimePushFloatVar
; =
	POP HL
	CALL runtimeIntToFloat
	CALL runtimeEqualFloat
; OR
	POP DE
	call runtimeOrHLDE
	PUSH HL
; )
; Array-Access
	LD HL,ZXBASIC_VAR_ny
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD DE,22
	CALL runtimeMult16bit
	PUSH HL
	LD HL,ZXBASIC_VAR_nx
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	POP DE
	ADD HL,DE
	LD DE,5
	CALL runtimeMult16bit
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	CALL runtimePushFloatVar
	LD HL,FLOAT_1	;0
	CALL runtimePushFloatVar
; =
	CALL runtimeEqualFloat
; AND
	POP DE
	call runtimeAndHLDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_9
; 		810.2  LET s(y,x)=0{00 00 00 00 00 }
	LD HL,ZXBASIC_VAR_y
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD DE,22
	CALL runtimeMult16bit
	PUSH HL
	LD HL,ZXBASIC_VAR_x
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	POP DE
	ADD HL,DE
	LD DE,5
	CALL runtimeMult16bit
	PUSH HL
	LD HL,FLOAT_1	;0
	CALL runtimePushFloatVar
	POP HL
	LD BC,ZXBASIC_VAR_s_array
	ADD HL,BC
	CALL runtimeStoreFloat
; 		810.3  PRINT  AT y,x;" "
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,ZXBASIC_VAR_y
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	PUSH HL
	LD HL,ZXBASIC_VAR_x
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	POP DE
	CALL runtimePrintAt
	LD HL,STRING_31	; 
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
; 		810.4  LET x=nx
	LD HL,ZXBASIC_VAR_nx
	LD DE,ZXBASIC_VAR_x
	LD BC,5
	LDIR
; 		810.5  LET y=ny
	LD HL,ZXBASIC_VAR_ny
	LD DE,ZXBASIC_VAR_y
	LD BC,5
	LDIR
; 		810.6  LET s(y,x)=-1{00 00 01 00 00 }
	LD HL,ZXBASIC_VAR_y
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD DE,22
	CALL runtimeMult16bit
	PUSH HL
	LD HL,ZXBASIC_VAR_x
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	POP DE
	ADD HL,DE
	LD DE,5
	CALL runtimeMult16bit
	PUSH HL
	LD HL,FLOAT_3	;1
	CALL runtimePushFloatVar
; -
	CALL runtimeNegFloat
	POP HL
	LD BC,ZXBASIC_VAR_s_array
	ADD HL,BC
	CALL runtimeStoreFloat
; 		810.7  PRINT  AT y,x; INK 3{00 00 03 00 00 }; BRIGHT 1{00 00 01 00 00 };"\144"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,ZXBASIC_VAR_y
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	PUSH HL
	LD HL,ZXBASIC_VAR_x
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	POP DE
	CALL runtimePrintAt
	LD HL,FLOAT_6	;3
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeLocalInk
	LD HL,FLOAT_3	;1
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeLocalBright
	LD HL,STRING_9	;\90
	CALL runtimePrintString
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
; 		810.8  BEEP 0.001{77 03 12 6e 97 },24{00 00 18 00 00 }
	LD HL,FLOAT_51	;0.001
	CALL runtimePushFloatVar
	LD HL,FLOAT_52	;24
	CALL runtimePushFloatVar
	CALL $03F8
; 		810.9  GOTO 840{00 00 48 03 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_840
ZXB_LABEL_9:
ZXBASIC_LINE_820:
; 820  IF (inkey <> 0 OR  IN 32766=191) AND s(ny,nx)>0 THEN  IF c$(s(ny,nx))>"\146" THEN  GOSUB 1180: IF lives=0 THEN  GOTO 1060
; 		820.1  IF (inkey <> 0{00 00 00 00 00 } OR  IN 32766{00 00 fe 7f 00 }=191{00 00 bf 00 00 }) AND s(ny,nx)>0{00 00 00 00 00 } THEN  IF c$(s(ny,nx))>"\146" THEN  GOSUB 1180{00 00 9c 04 00 }
; (
	LD HL,ZXBASIC_VAR_inkey
	CALL runtimePushFloatVar
	LD HL,FLOAT_1	;0
	CALL runtimePushFloatVar
; <>
	CALL runtimeUnequalFloat
	PUSH HL
; IN
	LD HL,FLOAT_49	;32766
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD BC,HL
	IN A,(C)
	LD L,A
	LD H,0
	PUSH HL
	LD HL,FLOAT_50	;191
	CALL runtimePushFloatVar
; =
	POP HL
	CALL runtimeIntToFloat
	CALL runtimeEqualFloat
; OR
	POP DE
	call runtimeOrHLDE
	PUSH HL
; )
; Array-Access
	LD HL,ZXBASIC_VAR_ny
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD DE,22
	CALL runtimeMult16bit
	PUSH HL
	LD HL,ZXBASIC_VAR_nx
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	POP DE
	ADD HL,DE
	LD DE,5
	CALL runtimeMult16bit
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	CALL runtimePushFloatVar
	LD HL,FLOAT_1	;0
	CALL runtimePushFloatVar
; >
	CALL runtimeBiggerFloat
; AND
	POP DE
	call runtimeAndHLDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_10
; 		820.2  IF c$(s(ny,nx))>"\146" THEN  GOSUB 1180{00 00 9c 04 00 }
; Array-Access
	LD HL,ZXBASIC_VAR_ny
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD DE,22
	CALL runtimeMult16bit
	PUSH HL
	LD HL,ZXBASIC_VAR_nx
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	POP DE
	ADD HL,DE
	LD DE,5
	CALL runtimeMult16bit
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD DE,HL
	LD HL,ZXBASIC_VAR_c_string
	ADD HL,DE
	PUSH HL
	LD HL,STRING_32	;\92
; >
	POP IX
	LD DE,1
	CALL runtimeBiggerStringVarFix
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_11
; 		820.3  GOSUB 1180{00 00 9c 04 00 }
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_1180
; 		820.4  IF lives=0{00 00 00 00 00 } THEN  GOTO 1060{00 00 24 04 00 }
	LD HL,ZXBASIC_VAR_lives
	CALL runtimePushFloatVar
	LD HL,FLOAT_1	;0
	CALL runtimePushFloatVar
; =
	CALL runtimeEqualFloat
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_12
; 		820.5  GOTO 1060{00 00 24 04 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_1060
ZXB_LABEL_12:
ZXB_LABEL_11:
ZXB_LABEL_10:
ZXBASIC_LINE_830:
; 830  IF (inkey <> 0 OR  IN 32766=190 OR  IN 32766=187) AND s(ny,nx)>0 THEN  IF c$(s(ny,nx))>"\146" THEN  PRINT  AT ny,nx; INK 2; OVER 1;"*": BEEP 0.01,36: BEEP 0.01,30: LET score=score+ (10 AND c$(s(ny,nx))="\147")+(20 AND c$(s(ny,nx))="\148")+(30 AND c$(s(ny,nx))="\149"): LET c$(s(ny,nx))="\146": PRINT  AT ny,nx; INK c(s(ny,nx)); BRIGHT 0;"\146": GOSUB 1210: LET kz=kz+1: IF kz=nz THEN  GOTO 1000
; 		830.1  IF (inkey <> 0{00 00 00 00 00 } OR  IN 32766{00 00 fe 7f 00 }=190{00 00 be 00 00 } OR  IN 32766{00 00 fe 7f 00 }=187{00 00 bb 00 00 }) AND s(ny,nx)>0{00 00 00 00 00 } THEN  IF c$(s(ny,nx))>"\146" THEN  PRINT  AT ny,nx; INK 2{00 00 02 00 00 }; OVER 1{00 00 01 00 00 };"*"
; (
	LD HL,ZXBASIC_VAR_inkey
	CALL runtimePushFloatVar
	LD HL,FLOAT_1	;0
	CALL runtimePushFloatVar
; <>
	CALL runtimeUnequalFloat
	PUSH HL
; IN
	LD HL,FLOAT_49	;32766
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD BC,HL
	IN A,(C)
	LD L,A
	LD H,0
	PUSH HL
	LD HL,FLOAT_44	;190
	CALL runtimePushFloatVar
; =
	POP HL
	CALL runtimeIntToFloat
	CALL runtimeEqualFloat
; OR
	POP DE
	call runtimeOrHLDE
	PUSH HL
; IN
	LD HL,FLOAT_49	;32766
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD BC,HL
	IN A,(C)
	LD L,A
	LD H,0
	PUSH HL
	LD HL,FLOAT_55	;187
	CALL runtimePushFloatVar
; =
	POP HL
	CALL runtimeIntToFloat
	CALL runtimeEqualFloat
; OR
	POP DE
	call runtimeOrHLDE
	PUSH HL
; )
; Array-Access
	LD HL,ZXBASIC_VAR_ny
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD DE,22
	CALL runtimeMult16bit
	PUSH HL
	LD HL,ZXBASIC_VAR_nx
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	POP DE
	ADD HL,DE
	LD DE,5
	CALL runtimeMult16bit
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	CALL runtimePushFloatVar
	LD HL,FLOAT_1	;0
	CALL runtimePushFloatVar
; >
	CALL runtimeBiggerFloat
; AND
	POP DE
	call runtimeAndHLDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_13
; 		830.2  IF c$(s(ny,nx))>"\146" THEN  PRINT  AT ny,nx; INK 2{00 00 02 00 00 }; OVER 1{00 00 01 00 00 };"*"
; Array-Access
	LD HL,ZXBASIC_VAR_ny
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD DE,22
	CALL runtimeMult16bit
	PUSH HL
	LD HL,ZXBASIC_VAR_nx
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	POP DE
	ADD HL,DE
	LD DE,5
	CALL runtimeMult16bit
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD DE,HL
	LD HL,ZXBASIC_VAR_c_string
	ADD HL,DE
	PUSH HL
	LD HL,STRING_32	;\92
; >
	POP IX
	LD DE,1
	CALL runtimeBiggerStringVarFix
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_14
; 		830.3  PRINT  AT ny,nx; INK 2{00 00 02 00 00 }; OVER 1{00 00 01 00 00 };"*"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,ZXBASIC_VAR_ny
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	PUSH HL
	LD HL,ZXBASIC_VAR_nx
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	POP DE
	CALL runtimePrintAt
	LD HL,FLOAT_5	;2
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeLocalInk
	LD HL,FLOAT_3	;1
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeLocalOver
	LD HL,STRING_33	;*
	CALL runtimePrintString
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
; 		830.4  BEEP 0.01{7a 23 d7 0a 3d },36{00 00 24 00 00 }
	LD HL,FLOAT_56	;0.01
	CALL runtimePushFloatVar
	LD HL,FLOAT_57	;36
	CALL runtimePushFloatVar
	CALL $03F8
; 		830.5  BEEP 0.01{7a 23 d7 0a 3d },30{00 00 1e 00 00 }
	LD HL,FLOAT_56	;0.01
	CALL runtimePushFloatVar
	LD HL,FLOAT_41	;30
	CALL runtimePushFloatVar
	CALL $03F8
; 		830.6  LET score=score+ (10{00 00 0a 00 00 } AND c$(s(ny,nx))="\147")+(20{00 00 14 00 00 } AND c$(s(ny,nx))="\148")+(30{00 00 1e 00 00 } AND c$(s(ny,nx))="\149")
	LD HL,ZXBASIC_VAR_score
	CALL runtimePushFloatVar
; (
	LD HL,FLOAT_19	;10
	CALL runtimePushFloatVar
; Array-Access
	LD HL,ZXBASIC_VAR_ny
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD DE,22
	CALL runtimeMult16bit
	PUSH HL
	LD HL,ZXBASIC_VAR_nx
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	POP DE
	ADD HL,DE
	LD DE,5
	CALL runtimeMult16bit
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD DE,HL
	LD HL,ZXBASIC_VAR_c_string
	ADD HL,DE
	PUSH HL
	LD HL,STRING_11	;\93
; =
	POP IX
	LD DE,1
	CALL runtimeEqualStringVarFix
; AND
	CALL runtimeIntToFloat
	CALL runtimeAndFloat
; )
; +
	CALL runtimeIntToFloat
	CALL runtimePlusFloat
; (
	LD HL,FLOAT_17	;20
	CALL runtimePushFloatVar
; Array-Access
	LD HL,ZXBASIC_VAR_ny
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD DE,22
	CALL runtimeMult16bit
	PUSH HL
	LD HL,ZXBASIC_VAR_nx
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	POP DE
	ADD HL,DE
	LD DE,5
	CALL runtimeMult16bit
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD DE,HL
	LD HL,ZXBASIC_VAR_c_string
	ADD HL,DE
	PUSH HL
	LD HL,STRING_13	;\94
; =
	POP IX
	LD DE,1
	CALL runtimeEqualStringVarFix
; AND
	CALL runtimeIntToFloat
	CALL runtimeAndFloat
; )
; +
	CALL runtimeIntToFloat
	CALL runtimePlusFloat
; (
	LD HL,FLOAT_41	;30
	CALL runtimePushFloatVar
; Array-Access
	LD HL,ZXBASIC_VAR_ny
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD DE,22
	CALL runtimeMult16bit
	PUSH HL
	LD HL,ZXBASIC_VAR_nx
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	POP DE
	ADD HL,DE
	LD DE,5
	CALL runtimeMult16bit
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD DE,HL
	LD HL,ZXBASIC_VAR_c_string
	ADD HL,DE
	PUSH HL
	LD HL,STRING_15	;\95
; =
	POP IX
	LD DE,1
	CALL runtimeEqualStringVarFix
; AND
	CALL runtimeIntToFloat
	CALL runtimeAndFloat
; )
; +
	CALL runtimeIntToFloat
	CALL runtimePlusFloat
	LD HL,ZXBASIC_VAR_score
	CALL runtimeStoreFloat
; 		830.7  LET c$(s(ny,nx))="\146"
; Array-Access
	LD HL,ZXBASIC_VAR_ny
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD DE,22
	CALL runtimeMult16bit
	PUSH HL
	LD HL,ZXBASIC_VAR_nx
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	POP DE
	ADD HL,DE
	LD DE,5
	CALL runtimeMult16bit
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD DE,HL
	LD HL,ZXBASIC_VAR_c_string
	ADD HL,DE
	LD DE,HL
	LD HL,STRING_32	;\92
	LD BC,1
	CALL runtimeStoreStringVarFix
; 		830.8  PRINT  AT ny,nx; INK c(s(ny,nx)); BRIGHT 0{00 00 00 00 00 };"\146"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,ZXBASIC_VAR_ny
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	PUSH HL
	LD HL,ZXBASIC_VAR_nx
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	POP DE
	CALL runtimePrintAt
; Array-Access
; Array-Access
	LD HL,ZXBASIC_VAR_ny
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD DE,22
	CALL runtimeMult16bit
	PUSH HL
	LD HL,ZXBASIC_VAR_nx
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	POP DE
	ADD HL,DE
	LD DE,5
	CALL runtimeMult16bit
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD DE,5
	CALL runtimeMult16bit
	LD DE, ZXBASIC_VAR_c_array
	ADD HL,DE
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeLocalInk
	LD HL,FLOAT_1	;0
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeLocalBright
	LD HL,STRING_32	;\92
	CALL runtimePrintString
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
; 		830.9  GOSUB 1210{00 00 ba 04 00 }
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_1210
; 		830.10  LET kz=kz+1{00 00 01 00 00 }
	LD HL,ZXBASIC_VAR_kz
	CALL runtimePushFloatVar
	LD HL,FLOAT_3	;1
	CALL runtimePushFloatVar
; +
	RST $28
	DB $0f	;ADD
	DB $38	;END CALC
	LD HL,ZXBASIC_VAR_kz
	CALL runtimeStoreFloat
; 		830.11  IF kz=nz THEN  GOTO 1000{00 00 e8 03 00 }
	LD HL,ZXBASIC_VAR_kz
	CALL runtimePushFloatVar
	LD HL,ZXBASIC_VAR_nz
	CALL runtimePushFloatVar
; =
	CALL runtimeEqualFloat
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_15
; 		830.12  GOTO 1000{00 00 e8 03 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_1000
ZXB_LABEL_15:
ZXB_LABEL_14:
ZXB_LABEL_13:
ZXBASIC_LINE_840:
; 840  REM ---------Update zombies
ZXBASIC_LINE_850:
; 850  LET zx=x(zi): LET zy=y(zi)
; 		850.1  LET zx=x(zi)
; Array-Access
	LD HL,ZXBASIC_VAR_zi
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD DE,5
	CALL runtimeMult16bit
	LD DE, ZXBASIC_VAR_x_array
	ADD HL,DE
	CALL runtimePushFloatVar
	LD HL,ZXBASIC_VAR_zx
	CALL runtimeStoreFloat
; 		850.2  LET zy=y(zi)
; Array-Access
	LD HL,ZXBASIC_VAR_zi
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD DE,5
	CALL runtimeMult16bit
	LD DE, ZXBASIC_VAR_y_array
	ADD HL,DE
	CALL runtimePushFloatVar
	LD HL,ZXBASIC_VAR_zy
	CALL runtimeStoreFloat
ZXBASIC_LINE_860:
; 860  IF c$(zi)="\145" THEN  GOTO 930
; 		860.1  IF c$(zi)="\145" THEN  GOTO 930{00 00 a2 03 00 }
	LD HL,ZXBASIC_VAR_zi
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD DE,HL
	LD HL,ZXBASIC_VAR_c_string
	ADD HL,DE
	PUSH HL
	LD HL,STRING_29	;\91
; =
	POP IX
	LD DE,1
	CALL runtimeEqualStringVarFix
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_16
; 		860.2  GOTO 930{00 00 a2 03 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_930
ZXB_LABEL_16:
ZXBASIC_LINE_870:
; 870  IF c$(zi)="\146" THEN  GOTO 950
; 		870.1  IF c$(zi)="\146" THEN  GOTO 950{00 00 b6 03 00 }
	LD HL,ZXBASIC_VAR_zi
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD DE,HL
	LD HL,ZXBASIC_VAR_c_string
	ADD HL,DE
	PUSH HL
	LD HL,STRING_32	;\92
; =
	POP IX
	LD DE,1
	CALL runtimeEqualStringVarFix
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_17
; 		870.2  GOTO 950{00 00 b6 03 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_950
ZXB_LABEL_17:
ZXBASIC_LINE_880:
; 880  LET dx= SGN (x-zx): LET dy= SGN (y-zy): LET nx=zx+dx: LET ny=zy+dy
; 		880.1  LET dx= SGN (x-zx)
; SGN
	LD HL,ZXBASIC_VAR_x
	CALL runtimePushFloatVar
	LD HL,ZXBASIC_VAR_zx
	CALL runtimePushFloatVar
; -
	RST $28
	DB $03	;SUB
; END CALC
	db zxcalc_sgn
	db zxcalc_end_calc
	LD HL,ZXBASIC_VAR_dx
	CALL runtimeStoreFloat
; 		880.2  LET dy= SGN (y-zy)
; SGN
	LD HL,ZXBASIC_VAR_y
	CALL runtimePushFloatVar
	LD HL,ZXBASIC_VAR_zy
	CALL runtimePushFloatVar
; -
	RST $28
	DB $03	;SUB
; END CALC
	db zxcalc_sgn
	db zxcalc_end_calc
	LD HL,ZXBASIC_VAR_dy
	CALL runtimeStoreFloat
; 		880.3  LET nx=zx+dx
	LD HL,ZXBASIC_VAR_zx
	CALL runtimePushFloatVar
	LD HL,ZXBASIC_VAR_dx
	CALL runtimePushFloatVar
; +
	RST $28
	DB $0f	;ADD
	DB $38	;END CALC
	LD HL,ZXBASIC_VAR_nx
	CALL runtimeStoreFloat
; 		880.4  LET ny=zy+dy
	LD HL,ZXBASIC_VAR_zy
	CALL runtimePushFloatVar
	LD HL,ZXBASIC_VAR_dy
	CALL runtimePushFloatVar
; +
	RST $28
	DB $0f	;ADD
	DB $38	;END CALC
	LD HL,ZXBASIC_VAR_ny
	CALL runtimeStoreFloat
ZXBASIC_LINE_890:
; 890  IF s(ny,nx)=0 THEN  LET s(zy,zx)=0: PRINT  AT zy,zx;" ": LET x(zi)=nx: LET y(zi)=ny: LET s(ny,nx)=zi: PRINT  AT ny,nx; INK c(zi); BRIGHT 1;c$(zi): BEEP 0.001,12: GOTO 950
; 		890.1  IF s(ny,nx)=0{00 00 00 00 00 } THEN  LET s(zy,zx)=0{00 00 00 00 00 }
; Array-Access
	LD HL,ZXBASIC_VAR_ny
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD DE,22
	CALL runtimeMult16bit
	PUSH HL
	LD HL,ZXBASIC_VAR_nx
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	POP DE
	ADD HL,DE
	LD DE,5
	CALL runtimeMult16bit
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	CALL runtimePushFloatVar
	LD HL,FLOAT_1	;0
	CALL runtimePushFloatVar
; =
	CALL runtimeEqualFloat
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_18
; 		890.2  LET s(zy,zx)=0{00 00 00 00 00 }
	LD HL,ZXBASIC_VAR_zy
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD DE,22
	CALL runtimeMult16bit
	PUSH HL
	LD HL,ZXBASIC_VAR_zx
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	POP DE
	ADD HL,DE
	LD DE,5
	CALL runtimeMult16bit
	PUSH HL
	LD HL,FLOAT_1	;0
	CALL runtimePushFloatVar
	POP HL
	LD BC,ZXBASIC_VAR_s_array
	ADD HL,BC
	CALL runtimeStoreFloat
; 		890.3  PRINT  AT zy,zx;" "
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,ZXBASIC_VAR_zy
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	PUSH HL
	LD HL,ZXBASIC_VAR_zx
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	POP DE
	CALL runtimePrintAt
	LD HL,STRING_31	; 
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
; 		890.4  LET x(zi)=nx
	LD HL,ZXBASIC_VAR_zi
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD DE,5
	CALL runtimeMult16bit
	PUSH HL
	LD HL,ZXBASIC_VAR_nx
	CALL runtimePushFloatVar
	POP HL
	LD BC,ZXBASIC_VAR_x_array
	ADD HL,BC
	CALL runtimeStoreFloat
; 		890.5  LET y(zi)=ny
	LD HL,ZXBASIC_VAR_zi
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD DE,5
	CALL runtimeMult16bit
	PUSH HL
	LD HL,ZXBASIC_VAR_ny
	CALL runtimePushFloatVar
	POP HL
	LD BC,ZXBASIC_VAR_y_array
	ADD HL,BC
	CALL runtimeStoreFloat
; 		890.6  LET s(ny,nx)=zi
	LD HL,ZXBASIC_VAR_ny
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD DE,22
	CALL runtimeMult16bit
	PUSH HL
	LD HL,ZXBASIC_VAR_nx
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	POP DE
	ADD HL,DE
	LD DE,5
	CALL runtimeMult16bit
	PUSH HL
	LD HL,ZXBASIC_VAR_zi
	CALL runtimePushFloatVar
	POP HL
	LD BC,ZXBASIC_VAR_s_array
	ADD HL,BC
	CALL runtimeStoreFloat
; 		890.7  PRINT  AT ny,nx; INK c(zi); BRIGHT 1{00 00 01 00 00 };c$(zi)
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,ZXBASIC_VAR_ny
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	PUSH HL
	LD HL,ZXBASIC_VAR_nx
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	POP DE
	CALL runtimePrintAt
; Array-Access
	LD HL,ZXBASIC_VAR_zi
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD DE,5
	CALL runtimeMult16bit
	LD DE, ZXBASIC_VAR_c_array
	ADD HL,DE
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeLocalInk
	LD HL,FLOAT_3	;1
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeLocalBright
	LD HL,ZXBASIC_VAR_zi
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD DE,HL
	LD HL,ZXBASIC_VAR_c_string
	ADD HL,DE
	LD BC,1
	CALL runtimePrintFixString
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
; 		890.8  BEEP 0.001{77 03 12 6e 97 },12{00 00 0c 00 00 }
	LD HL,FLOAT_51	;0.001
	CALL runtimePushFloatVar
	LD HL,FLOAT_4	;12
	CALL runtimePushFloatVar
	CALL $03F8
; 		890.9  GOTO 950{00 00 b6 03 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_950
ZXB_LABEL_18:
ZXBASIC_LINE_900:
; 900  IF s(ny,nx)>0 THEN  GOTO 950
; 		900.1  IF s(ny,nx)>0{00 00 00 00 00 } THEN  GOTO 950{00 00 b6 03 00 }
; Array-Access
	LD HL,ZXBASIC_VAR_ny
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD DE,22
	CALL runtimeMult16bit
	PUSH HL
	LD HL,ZXBASIC_VAR_nx
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	POP DE
	ADD HL,DE
	LD DE,5
	CALL runtimeMult16bit
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	CALL runtimePushFloatVar
	LD HL,FLOAT_1	;0
	CALL runtimePushFloatVar
; >
	CALL runtimeBiggerFloat
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_19
; 		900.2  GOTO 950{00 00 b6 03 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_950
ZXB_LABEL_19:
ZXBASIC_LINE_910:
; 910  GOSUB 1180: IF lives=0 THEN  GOTO 1060
; 		910.1  GOSUB 1180{00 00 9c 04 00 }
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_1180
; 		910.2  IF lives=0{00 00 00 00 00 } THEN  GOTO 1060{00 00 24 04 00 }
	LD HL,ZXBASIC_VAR_lives
	CALL runtimePushFloatVar
	LD HL,FLOAT_1	;0
	CALL runtimePushFloatVar
; =
	CALL runtimeEqualFloat
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_20
; 		910.3  GOTO 1060{00 00 24 04 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_1060
ZXB_LABEL_20:
ZXBASIC_LINE_920:
; 920  GOTO 950
; 		920.1  GOTO 950{00 00 b6 03 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_950
ZXBASIC_LINE_930:
; 930  IF  RND <1/2 THEN  GOTO 950
; 		930.1  IF  RND <1{00 00 01 00 00 }/2{00 00 02 00 00 } THEN  GOTO 950{00 00 b6 03 00 }
; RND
	CALL runtimeRND
	LD HL,FLOAT_3	;1
	CALL runtimePushFloatVar
	LD HL,FLOAT_5	;2
	CALL runtimePushFloatVar
; /
	RST $28
	DB $05	;DIV
	DB $38	;END CALC
; <
	CALL runtimeSmallerFloat
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_21
; 		930.2  GOTO 950{00 00 b6 03 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_950
ZXB_LABEL_21:
ZXBASIC_LINE_940:
; 940  LET c$(zi)=d$(zi): LET c(zi)=d(zi): PRINT  AT zy,zx; INK c(zi); BRIGHT 1;c$(zi): BEEP 0.01,-12: BEEP 0.01,-13: BEEP 0.01,-14
; 		940.1  LET c$(zi)=d$(zi)
	LD HL,ZXBASIC_VAR_zi
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD DE,HL
	LD HL,ZXBASIC_VAR_c_string
	ADD HL,DE
	PUSH HL
	LD HL,ZXBASIC_VAR_zi
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD DE,HL
	LD HL,ZXBASIC_VAR_d_string
	ADD HL,DE
	PUSH HL
	LD BC,1
	PUSH BC
	LD BC,1
	PUSH BC
	CALL runtimeSetFixedString
; 		940.2  LET c(zi)=d(zi)
	LD HL,ZXBASIC_VAR_zi
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD DE,5
	CALL runtimeMult16bit
	PUSH HL
; Array-Access
	LD HL,ZXBASIC_VAR_zi
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD DE,5
	CALL runtimeMult16bit
	LD DE, ZXBASIC_VAR_d_array
	ADD HL,DE
	CALL runtimePushFloatVar
	POP HL
	LD BC,ZXBASIC_VAR_c_array
	ADD HL,BC
	CALL runtimeStoreFloat
; 		940.3  PRINT  AT zy,zx; INK c(zi); BRIGHT 1{00 00 01 00 00 };c$(zi)
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,ZXBASIC_VAR_zy
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	PUSH HL
	LD HL,ZXBASIC_VAR_zx
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	POP DE
	CALL runtimePrintAt
; Array-Access
	LD HL,ZXBASIC_VAR_zi
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD DE,5
	CALL runtimeMult16bit
	LD DE, ZXBASIC_VAR_c_array
	ADD HL,DE
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeLocalInk
	LD HL,FLOAT_3	;1
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeLocalBright
	LD HL,ZXBASIC_VAR_zi
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD DE,HL
	LD HL,ZXBASIC_VAR_c_string
	ADD HL,DE
	LD BC,1
	CALL runtimePrintFixString
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
; 		940.4  BEEP 0.01{7a 23 d7 0a 3d },-12{00 00 0c 00 00 }
	LD HL,FLOAT_56	;0.01
	CALL runtimePushFloatVar
	LD HL,FLOAT_4	;12
	CALL runtimePushFloatVar
; -
	CALL runtimeNegFloat
	CALL $03F8
; 		940.5  BEEP 0.01{7a 23 d7 0a 3d },-13{00 00 0d 00 00 }
	LD HL,FLOAT_56	;0.01
	CALL runtimePushFloatVar
	LD HL,FLOAT_26	;13
	CALL runtimePushFloatVar
; -
	CALL runtimeNegFloat
	CALL $03F8
; 		940.6  BEEP 0.01{7a 23 d7 0a 3d },-14{00 00 0e 00 00 }
	LD HL,FLOAT_56	;0.01
	CALL runtimePushFloatVar
	LD HL,FLOAT_20	;14
	CALL runtimePushFloatVar
; -
	CALL runtimeNegFloat
	CALL $03F8
ZXBASIC_LINE_950:
; 950  LET zi=zi+1: IF zi>nz THEN  LET zi=1
; 		950.1  LET zi=zi+1{00 00 01 00 00 }
	LD HL,ZXBASIC_VAR_zi
	CALL runtimePushFloatVar
	LD HL,FLOAT_3	;1
	CALL runtimePushFloatVar
; +
	RST $28
	DB $0f	;ADD
	DB $38	;END CALC
	LD HL,ZXBASIC_VAR_zi
	CALL runtimeStoreFloat
; 		950.2  IF zi>nz THEN  LET zi=1{00 00 01 00 00 }
	LD HL,ZXBASIC_VAR_zi
	CALL runtimePushFloatVar
	LD HL,ZXBASIC_VAR_nz
	CALL runtimePushFloatVar
; >
	CALL runtimeBiggerFloat
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_22
; 		950.3  LET zi=1{00 00 01 00 00 }
	LD HL,FLOAT_3	;1
	LD DE,ZXBASIC_VAR_zi
	LD BC,5
	LDIR
ZXB_LABEL_22:
ZXBASIC_LINE_960:
; 960  REM -------Update framerate
ZXBASIC_LINE_970:
; 970  GOTO 760
; 		970.1  GOTO 760{00 00 f8 02 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_760
ZXBASIC_LINE_980:
; 980  LET dt=65536* PEEK 23674+256* PEEK 23673+ PEEK 23672: LET f=f+1: IF dt >= t THEN  PRINT  AT 1,14; INK 1; BRIGHT 0;f: LET t=dt+50: LET f=0
; 		980.1  LET dt=65536{91 00 00 00 00 }* PEEK 23674{00 00 7a 5c 00 }+256{00 00 00 01 00 }* PEEK 23673{00 00 79 5c 00 }+ PEEK 23672{00 00 78 5c 00 }
	LD HL,FLOAT_34	;65536
	CALL runtimePushFloatVar
; PEEK
	LD HL,FLOAT_35	;23674
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD L,(HL)
	LD H,0
; *
	CALL runtimeIntToFloat
	RST $28
	DB $04	;MULT
	DB $38	;END CALC
	LD HL,FLOAT_36	;256
	CALL runtimePushFloatVar
; PEEK
	LD HL,FLOAT_37	;23673
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD L,(HL)
	LD H,0
; *
	CALL runtimeIntToFloat
	RST $28
	DB $04	;MULT
; END CALC
; +
	DB $0f	;ADD
	DB $38	;END CALC
; PEEK
	LD HL,FLOAT_38	;23672
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD L,(HL)
	LD H,0
; +
	CALL runtimeIntToFloat
	CALL runtimePlusFloat
	LD HL,ZXBASIC_VAR_dt
	CALL runtimeStoreFloat
; 		980.2  LET f=f+1{00 00 01 00 00 }
	LD HL,ZXBASIC_VAR_f
	CALL runtimePushFloatVar
	LD HL,FLOAT_3	;1
	CALL runtimePushFloatVar
; +
	RST $28
	DB $0f	;ADD
	DB $38	;END CALC
	LD HL,ZXBASIC_VAR_f
	CALL runtimeStoreFloat
; 		980.3  IF dt >= t THEN  PRINT  AT 1{00 00 01 00 00 },14{00 00 0e 00 00 }; INK 1{00 00 01 00 00 }; BRIGHT 0{00 00 00 00 00 };f
	LD HL,ZXBASIC_VAR_dt
	CALL runtimePushFloatVar
	LD HL,ZXBASIC_VAR_t
	CALL runtimePushFloatVar
; >=
	CALL runtimeBiggerEqualFloat
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_23
; 		980.4  PRINT  AT 1{00 00 01 00 00 },14{00 00 0e 00 00 }; INK 1{00 00 01 00 00 }; BRIGHT 0{00 00 00 00 00 };f
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,FLOAT_3	;1
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	PUSH HL
	LD HL,FLOAT_20	;14
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	POP DE
	CALL runtimePrintAt
	LD HL,FLOAT_3	;1
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeLocalInk
	LD HL,FLOAT_1	;0
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeLocalBright
	LD HL,ZXBASIC_VAR_f
	CALL runtimePushFloatVar
	CALL runtimePrintFloat
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
; 		980.5  LET t=dt+50{00 00 32 00 00 }
	LD HL,ZXBASIC_VAR_dt
	CALL runtimePushFloatVar
	LD HL,FLOAT_39	;50
	CALL runtimePushFloatVar
; +
	RST $28
	DB $0f	;ADD
	DB $38	;END CALC
	LD HL,ZXBASIC_VAR_t
	CALL runtimeStoreFloat
; 		980.6  LET f=0{00 00 00 00 00 }
	LD HL,FLOAT_1	;0
	LD DE,ZXBASIC_VAR_f
	LD BC,5
	LDIR
ZXB_LABEL_23:
ZXBASIC_LINE_990:
; 990  GOTO 760
; 		990.1  GOTO 760{00 00 f8 02 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_760
ZXBASIC_LINE_1000:
; 1000  REM \134\134\134\134\134\134\134\134\134 Wave complete
ZXBASIC_LINE_1010:
; 1010  PRINT  AT 1,9;"WAVE COMPLETE!": BEEP 0.1,0: BEEP 0.05,0: BEEP 0.05,0: BEEP 0.2,12
; 		1010.1  PRINT  AT 1{00 00 01 00 00 },9{00 00 09 00 00 };"WAVE COMPLETE!"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,FLOAT_3	;1
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	PUSH HL
	LD HL,FLOAT_12	;9
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	POP DE
	CALL runtimePrintAt
	LD HL,STRING_34	;WAVE COMPLETE!
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
; 		1010.2  BEEP 0.1{7d 4c cc cc cc },0{00 00 00 00 00 }
	LD HL,FLOAT_62	;0.1
	CALL runtimePushFloatVar
	LD HL,FLOAT_1	;0
	CALL runtimePushFloatVar
	CALL $03F8
; 		1010.3  BEEP 0.05{7c 4c cc cc cc },0{00 00 00 00 00 }
	LD HL,FLOAT_63	;0.05
	CALL runtimePushFloatVar
	LD HL,FLOAT_1	;0
	CALL runtimePushFloatVar
	CALL $03F8
; 		1010.4  BEEP 0.05{7c 4c cc cc cc },0{00 00 00 00 00 }
	LD HL,FLOAT_63	;0.05
	CALL runtimePushFloatVar
	LD HL,FLOAT_1	;0
	CALL runtimePushFloatVar
	CALL $03F8
; 		1010.5  BEEP 0.2{7e 4c cc cc cc },12{00 00 0c 00 00 }
	LD HL,FLOAT_64	;0.2
	CALL runtimePushFloatVar
	LD HL,FLOAT_4	;12
	CALL runtimePushFloatVar
	CALL $03F8
ZXBASIC_LINE_1020:
; 1020  FOR i=1 TO nz: PRINT  AT y(i),x(i);" ": BEEP 0.01,i: NEXT i: PRINT  AT y,x;" "
; 		1020.1  FOR i=1{00 00 01 00 00 } TO nz
	CALL runtimeCheckBreak
	LD HL,FLOAT_3	;1
	LD DE,ZXBASIC_VAR_i
	LD BC,5
	LDIR
	LD HL,ZXBASIC_VAR_nz
	LD DE,ZXBASIC_VAR_for_i
	LD BC,5
	LDIR
FOR_3:
; 		1020.2  PRINT  AT y(i),x(i);" "
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
; Array-Access
	LD HL,ZXBASIC_VAR_i
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD DE,5
	CALL runtimeMult16bit
	LD DE, ZXBASIC_VAR_y_array
	ADD HL,DE
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	PUSH HL
; Array-Access
	LD HL,ZXBASIC_VAR_i
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD DE,5
	CALL runtimeMult16bit
	LD DE, ZXBASIC_VAR_x_array
	ADD HL,DE
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	POP DE
	CALL runtimePrintAt
	LD HL,STRING_31	; 
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
; 		1020.3  BEEP 0.01{7a 23 d7 0a 3d },i
	LD HL,FLOAT_56	;0.01
	CALL runtimePushFloatVar
	LD HL,ZXBASIC_VAR_i
	CALL runtimePushFloatVar
	CALL $03F8
; 		1020.4  NEXT i
	CALL runtimeCheckBreak
	LD HL,ZXBASIC_VAR_i
	CALL runtimePushFloatVar
	RST $28
	DB zxcalc_stack_one	;STACK ONE
	DB zxcalc_addition	;ADD
	DB zxcalc_end_calc	;END CALC
	LD HL,ZXBASIC_VAR_i
	CALL runtimeStoreFloat
	LD HL,ZXBASIC_VAR_for_i
	CALL runtimePushFloatVar
	LD HL,ZXBASIC_VAR_i
	CALL runtimePushFloatVar
	CALL runtimeSmallerFloat
	LD A,L
	CP 0
	JP Z,FOR_3
; 		1020.5  PRINT  AT y,x;" "
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,ZXBASIC_VAR_y
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	PUSH HL
	LD HL,ZXBASIC_VAR_x
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	POP DE
	CALL runtimePrintAt
	LD HL,STRING_31	; 
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1030:
; 1030  PRINT  AT 1,9;"              "
; 		1030.1  PRINT  AT 1{00 00 01 00 00 },9{00 00 09 00 00 };"              "
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,FLOAT_3	;1
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	PUSH HL
	LD HL,FLOAT_12	;9
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	POP DE
	CALL runtimePrintAt
	LD HL,STRING_30	;              
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1040:
; 1040  LET wave=wave+1: GOSUB 1240
; 		1040.1  LET wave=wave+1{00 00 01 00 00 }
	LD HL,ZXBASIC_VAR_wave
	CALL runtimePushFloatVar
	LD HL,FLOAT_3	;1
	CALL runtimePushFloatVar
; +
	RST $28
	DB $0f	;ADD
	DB $38	;END CALC
	LD HL,ZXBASIC_VAR_wave
	CALL runtimeStoreFloat
; 		1040.2  GOSUB 1240{00 00 d8 04 00 }
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_1240
ZXBASIC_LINE_1050:
; 1050  GOTO 460
; 		1050.1  GOTO 460{00 00 cc 01 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_460
ZXBASIC_LINE_1060:
; 1060  REM \134\134\134\134\134\134\134\134\134\134\134\134\134 Game Over
ZXBASIC_LINE_1070:
; 1070  FOR j=1 TO 10: PRINT  AT 1,j;" GAME"; AT 1,26-j;"OVER! ": BEEP 0.02,-11-j: BEEP 0.02,-8-j: NEXT j
; 		1070.1  FOR j=1{00 00 01 00 00 } TO 10{00 00 0a 00 00 }
	CALL runtimeCheckBreak
	LD HL,FLOAT_3	;1
	LD DE,ZXBASIC_VAR_j
	LD BC,5
	LDIR
	LD HL,FLOAT_19	;10
	LD DE,ZXBASIC_VAR_for_j
	LD BC,5
	LDIR
FOR_4:
; 		1070.2  PRINT  AT 1{00 00 01 00 00 },j;" GAME"; AT 1{00 00 01 00 00 },26{00 00 1a 00 00 }-j;"OVER! "
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,FLOAT_3	;1
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	PUSH HL
	LD HL,ZXBASIC_VAR_j
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	POP DE
	CALL runtimePrintAt
	LD HL,STRING_35	; GAME
	CALL runtimePrintString
	LD HL,FLOAT_3	;1
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	PUSH HL
	LD HL,FLOAT_66	;26
	CALL runtimePushFloatVar
	LD HL,ZXBASIC_VAR_j
	CALL runtimePushFloatVar
; -
	RST $28
	DB $03	;SUB
	DB $38	;END CALC
	CALL runtimeFloatToInt
	POP DE
	CALL runtimePrintAt
	LD HL,STRING_36	;OVER! 
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
; 		1070.3  BEEP 0.02{7b 23 d7 0a 3d },-11{00 00 0b 00 00 }-j
	LD HL,FLOAT_67	;0.02
	CALL runtimePushFloatVar
	LD HL,FLOAT_40	;11
	CALL runtimePushFloatVar
	LD HL,ZXBASIC_VAR_j
	CALL runtimePushFloatVar
; -
	RST $28
	DB $03	;SUB
	DB $38	;END CALC
; -
	CALL runtimeNegFloat
	CALL $03F8
; 		1070.4  BEEP 0.02{7b 23 d7 0a 3d },-8{00 00 08 00 00 }-j
	LD HL,FLOAT_67	;0.02
	CALL runtimePushFloatVar
	LD HL,FLOAT_10	;8
	CALL runtimePushFloatVar
	LD HL,ZXBASIC_VAR_j
	CALL runtimePushFloatVar
; -
	RST $28
	DB $03	;SUB
	DB $38	;END CALC
; -
	CALL runtimeNegFloat
	CALL $03F8
; 		1070.5  NEXT j
	CALL runtimeCheckBreak
	LD HL,ZXBASIC_VAR_j
	CALL runtimePushFloatVar
	RST $28
	DB zxcalc_stack_one	;STACK ONE
	DB zxcalc_addition	;ADD
	DB zxcalc_end_calc	;END CALC
	LD HL,ZXBASIC_VAR_j
	CALL runtimeStoreFloat
	LD HL,ZXBASIC_VAR_for_j
	CALL runtimePushFloatVar
	LD HL,ZXBASIC_VAR_j
	CALL runtimePushFloatVar
	CALL runtimeSmallerFloat
	LD A,L
	CP 0
	JP Z,FOR_4
ZXBASIC_LINE_1080:
; 1080  PRINT  AT 1,0; INK 7; FLASH 1;"    Press any key to continue   "
; 		1080.1  PRINT  AT 1{00 00 01 00 00 },0{00 00 00 00 00 }; INK 7{00 00 07 00 00 }; FLASH 1{00 00 01 00 00 };"    Press any key to continue   "
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,FLOAT_3	;1
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	PUSH HL
	LD HL,FLOAT_1	;0
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	POP DE
	CALL runtimePrintAt
	LD HL,FLOAT_2	;7
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeLocalInk
	LD HL,FLOAT_3	;1
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeLocalFlash
	LD HL,STRING_37	;    Press any key to continue   
	CALL runtimePrintString
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1090:
; 1090  IF  INKEY$ ="" THEN  GOTO 1090
; 		1090.1  IF  INKEY$ ="" THEN  GOTO 1090{00 00 42 04 00 }
; INKEY$
	CALL runtimeInkey
	LD DE,HL
	LD HL,STRING_21	;
; =
	CALL runtimeEqualString
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_24
; 		1090.2  GOTO 1090{00 00 42 04 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_1090
ZXB_LABEL_24:
ZXBASIC_LINE_1100:
; 1100  GOTO 50
; 		1100.1  GOTO 50{00 00 32 00 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_50
ZXBASIC_LINE_1110:
; 1110  REM \134\134\134\134\134\134\134\134\134\134\134 Subroutines
ZXBASIC_LINE_1120:
; 1120  REM -----------Spawn player
ZXBASIC_LINE_1130:
; 1130  LET x=2+ INT ( RND *28)
; 		1130.1  LET x=2{00 00 02 00 00 }+ INT ( RND *28{00 00 1c 00 00 })
	LD HL,FLOAT_5	;2
	CALL runtimePushFloatVar
; INT
; RND
	CALL runtimeRND
	LD HL,FLOAT_29	;28
	CALL runtimePushFloatVar
; *
	RST $28
	DB $04	;MULT
	DB $38	;END CALC
	CALL runtimeFloatToInt
; +
	CALL runtimeIntToFloat
	CALL runtimePlusFloat
	LD HL,ZXBASIC_VAR_x
	CALL runtimeStoreFloat
ZXBASIC_LINE_1140:
; 1140  LET y=4+ INT ( RND *16)
; 		1140.1  LET y=4{00 00 04 00 00 }+ INT ( RND *16{00 00 10 00 00 })
	LD HL,FLOAT_9	;4
	CALL runtimePushFloatVar
; INT
; RND
	CALL runtimeRND
	LD HL,FLOAT_21	;16
	CALL runtimePushFloatVar
; *
	RST $28
	DB $04	;MULT
	DB $38	;END CALC
	CALL runtimeFloatToInt
; +
	CALL runtimeIntToFloat
	CALL runtimePlusFloat
	LD HL,ZXBASIC_VAR_y
	CALL runtimeStoreFloat
ZXBASIC_LINE_1150:
; 1150  IF s(y,x) THEN  GOTO 1130
; 		1150.1  IF s(y,x) THEN  GOTO 1130{00 00 6a 04 00 }
; Array-Access
	LD HL,ZXBASIC_VAR_y
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD DE,22
	CALL runtimeMult16bit
	PUSH HL
	LD HL,ZXBASIC_VAR_x
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	POP DE
	ADD HL,DE
	LD DE,5
	CALL runtimeMult16bit
	LD DE, ZXBASIC_VAR_s_array
	ADD HL,DE
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_25
; 		1150.2  GOTO 1130{00 00 6a 04 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_1130
ZXB_LABEL_25:
ZXBASIC_LINE_1160:
; 1160  LET s(y,x)=-1: FOR j=1 TO 10 STEP 2: PRINT  AT y,x;" ": BEEP 0.01,j+12: PRINT  AT y,x; INK 3; BRIGHT 1;"\144": BEEP 0.01,j+13: NEXT j
; 		1160.1  LET s(y,x)=-1{00 00 01 00 00 }
	LD HL,ZXBASIC_VAR_y
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD DE,22
	CALL runtimeMult16bit
	PUSH HL
	LD HL,ZXBASIC_VAR_x
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	POP DE
	ADD HL,DE
	LD DE,5
	CALL runtimeMult16bit
	PUSH HL
	LD HL,FLOAT_3	;1
	CALL runtimePushFloatVar
; -
	CALL runtimeNegFloat
	POP HL
	LD BC,ZXBASIC_VAR_s_array
	ADD HL,BC
	CALL runtimeStoreFloat
; 		1160.2  FOR j=1{00 00 01 00 00 } TO 10{00 00 0a 00 00 } STEP 2{00 00 02 00 00 }
	CALL runtimeCheckBreak
	LD HL,FLOAT_3	;1
	LD DE,ZXBASIC_VAR_j
	LD BC,5
	LDIR
	LD HL,FLOAT_19	;10
	LD DE,ZXBASIC_VAR_for_j
	LD BC,5
	LDIR
	LD HL,FLOAT_5	;2
	LD DE,ZXBASIC_VAR_for_j_step
	LD BC,5
	LDIR
FOR_5:
; 		1160.3  PRINT  AT y,x;" "
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,ZXBASIC_VAR_y
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	PUSH HL
	LD HL,ZXBASIC_VAR_x
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	POP DE
	CALL runtimePrintAt
	LD HL,STRING_31	; 
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
; 		1160.4  BEEP 0.01{7a 23 d7 0a 3d },j+12{00 00 0c 00 00 }
	LD HL,FLOAT_56	;0.01
	CALL runtimePushFloatVar
	LD HL,ZXBASIC_VAR_j
	CALL runtimePushFloatVar
	LD HL,FLOAT_4	;12
	CALL runtimePushFloatVar
; +
	RST $28
	DB $0f	;ADD
	DB $38	;END CALC
	CALL $03F8
; 		1160.5  PRINT  AT y,x; INK 3{00 00 03 00 00 }; BRIGHT 1{00 00 01 00 00 };"\144"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,ZXBASIC_VAR_y
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	PUSH HL
	LD HL,ZXBASIC_VAR_x
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	POP DE
	CALL runtimePrintAt
	LD HL,FLOAT_6	;3
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeLocalInk
	LD HL,FLOAT_3	;1
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeLocalBright
	LD HL,STRING_9	;\90
	CALL runtimePrintString
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
; 		1160.6  BEEP 0.01{7a 23 d7 0a 3d },j+13{00 00 0d 00 00 }
	LD HL,FLOAT_56	;0.01
	CALL runtimePushFloatVar
	LD HL,ZXBASIC_VAR_j
	CALL runtimePushFloatVar
	LD HL,FLOAT_26	;13
	CALL runtimePushFloatVar
; +
	RST $28
	DB $0f	;ADD
	DB $38	;END CALC
	CALL $03F8
; 		1160.7  NEXT j
	CALL runtimeCheckBreak
	LD HL,ZXBASIC_VAR_for_j
	CALL runtimePushFloatVar
	LD HL,ZXBASIC_VAR_j
	CALL runtimePushFloatVar
	LD HL,ZXBASIC_VAR_for_j_step
	CALL runtimePushFloatVar
	RST $28
	DB zxcalc_addition	;ADD
	DB zxcalc_duplicate	;DUPLICATE
	DB $38	;END CALC
	LD HL,ZXBASIC_VAR_j
	CALL runtimeStoreFloat
	RST $28
	db zxcalc_subtract
	db zxcalc_end_calc
	LD HL,ZXBASIC_VAR_for_j_step
	CALL runtimePushFloatVar
	CALL runtimeNextFloat
	CP 0
	JP Z,FOR_5
ZXBASIC_LINE_1170:
; 1170  RETURN 
; 		1170.1  RETURN 
	CALL runtimeCheckBreak
	RET
ZXBASIC_LINE_1180:
; 1180  REM ------------Kill player
ZXBASIC_LINE_1190:
; 1190  PRINT  AT y,x; INK 2; OVER 1;"*": BEEP 0.01,24: BEEP 0.01,18: LET s(y,x)=0: PRINT  AT y,x; INK 3; BRIGHT 0;"\146": FOR j=1 TO 6 STEP 2: PRINT  AT 0,28+lives; INK 3; BRIGHT 1;"\144": BEEP 0.01,0-j: PRINT  AT 0,28+lives; INK 1; BRIGHT 0;"\144": BEEP 0.01,0-j-1: NEXT j: LET lives=lives-1: IF lives>0 THEN  PRINT  AT y,x;" ": GOSUB 1130
; 		1190.1  PRINT  AT y,x; INK 2{00 00 02 00 00 }; OVER 1{00 00 01 00 00 };"*"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,ZXBASIC_VAR_y
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	PUSH HL
	LD HL,ZXBASIC_VAR_x
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	POP DE
	CALL runtimePrintAt
	LD HL,FLOAT_5	;2
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeLocalInk
	LD HL,FLOAT_3	;1
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeLocalOver
	LD HL,STRING_33	;*
	CALL runtimePrintString
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
; 		1190.2  BEEP 0.01{7a 23 d7 0a 3d },24{00 00 18 00 00 }
	LD HL,FLOAT_56	;0.01
	CALL runtimePushFloatVar
	LD HL,FLOAT_52	;24
	CALL runtimePushFloatVar
	CALL $03F8
; 		1190.3  BEEP 0.01{7a 23 d7 0a 3d },18{00 00 12 00 00 }
	LD HL,FLOAT_56	;0.01
	CALL runtimePushFloatVar
	LD HL,FLOAT_11	;18
	CALL runtimePushFloatVar
	CALL $03F8
; 		1190.4  LET s(y,x)=0{00 00 00 00 00 }
	LD HL,ZXBASIC_VAR_y
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD DE,22
	CALL runtimeMult16bit
	PUSH HL
	LD HL,ZXBASIC_VAR_x
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	POP DE
	ADD HL,DE
	LD DE,5
	CALL runtimeMult16bit
	PUSH HL
	LD HL,FLOAT_1	;0
	CALL runtimePushFloatVar
	POP HL
	LD BC,ZXBASIC_VAR_s_array
	ADD HL,BC
	CALL runtimeStoreFloat
; 		1190.5  PRINT  AT y,x; INK 3{00 00 03 00 00 }; BRIGHT 0{00 00 00 00 00 };"\146"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,ZXBASIC_VAR_y
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	PUSH HL
	LD HL,ZXBASIC_VAR_x
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	POP DE
	CALL runtimePrintAt
	LD HL,FLOAT_6	;3
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeLocalInk
	LD HL,FLOAT_1	;0
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeLocalBright
	LD HL,STRING_32	;\92
	CALL runtimePrintString
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
; 		1190.6  FOR j=1{00 00 01 00 00 } TO 6{00 00 06 00 00 } STEP 2{00 00 02 00 00 }
	CALL runtimeCheckBreak
	LD HL,FLOAT_3	;1
	LD DE,ZXBASIC_VAR_j
	LD BC,5
	LDIR
	LD HL,FLOAT_7	;6
	LD DE,ZXBASIC_VAR_for_j
	LD BC,5
	LDIR
	LD HL,FLOAT_5	;2
	LD DE,ZXBASIC_VAR_for_j_step
	LD BC,5
	LDIR
FOR_6:
; 		1190.7  PRINT  AT 0{00 00 00 00 00 },28{00 00 1c 00 00 }+lives; INK 3{00 00 03 00 00 }; BRIGHT 1{00 00 01 00 00 };"\144"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,FLOAT_1	;0
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	PUSH HL
	LD HL,FLOAT_29	;28
	CALL runtimePushFloatVar
	LD HL,ZXBASIC_VAR_lives
	CALL runtimePushFloatVar
; +
	RST $28
	DB $0f	;ADD
	DB $38	;END CALC
	CALL runtimeFloatToInt
	POP DE
	CALL runtimePrintAt
	LD HL,FLOAT_6	;3
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeLocalInk
	LD HL,FLOAT_3	;1
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeLocalBright
	LD HL,STRING_9	;\90
	CALL runtimePrintString
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
; 		1190.8  BEEP 0.01{7a 23 d7 0a 3d },0{00 00 00 00 00 }-j
	LD HL,FLOAT_56	;0.01
	CALL runtimePushFloatVar
	LD HL,FLOAT_1	;0
	CALL runtimePushFloatVar
	LD HL,ZXBASIC_VAR_j
	CALL runtimePushFloatVar
; -
	RST $28
	DB $03	;SUB
	DB $38	;END CALC
	CALL $03F8
; 		1190.9  PRINT  AT 0{00 00 00 00 00 },28{00 00 1c 00 00 }+lives; INK 1{00 00 01 00 00 }; BRIGHT 0{00 00 00 00 00 };"\144"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,FLOAT_1	;0
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	PUSH HL
	LD HL,FLOAT_29	;28
	CALL runtimePushFloatVar
	LD HL,ZXBASIC_VAR_lives
	CALL runtimePushFloatVar
; +
	RST $28
	DB $0f	;ADD
	DB $38	;END CALC
	CALL runtimeFloatToInt
	POP DE
	CALL runtimePrintAt
	LD HL,FLOAT_3	;1
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeLocalInk
	LD HL,FLOAT_1	;0
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeLocalBright
	LD HL,STRING_9	;\90
	CALL runtimePrintString
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
; 		1190.10  BEEP 0.01{7a 23 d7 0a 3d },0{00 00 00 00 00 }-j-1{00 00 01 00 00 }
	LD HL,FLOAT_56	;0.01
	CALL runtimePushFloatVar
	LD HL,FLOAT_1	;0
	CALL runtimePushFloatVar
	LD HL,ZXBASIC_VAR_j
	CALL runtimePushFloatVar
; -
	RST $28
	DB $03	;SUB
	DB $38	;END CALC
	LD HL,FLOAT_3	;1
	CALL runtimePushFloatVar
; -
	RST $28
	DB $03	;SUB
	DB $38	;END CALC
	CALL $03F8
; 		1190.11  NEXT j
	CALL runtimeCheckBreak
	LD HL,ZXBASIC_VAR_for_j
	CALL runtimePushFloatVar
	LD HL,ZXBASIC_VAR_j
	CALL runtimePushFloatVar
	LD HL,ZXBASIC_VAR_for_j_step
	CALL runtimePushFloatVar
	RST $28
	DB zxcalc_addition	;ADD
	DB zxcalc_duplicate	;DUPLICATE
	DB $38	;END CALC
	LD HL,ZXBASIC_VAR_j
	CALL runtimeStoreFloat
	RST $28
	db zxcalc_subtract
	db zxcalc_end_calc
	LD HL,ZXBASIC_VAR_for_j_step
	CALL runtimePushFloatVar
	CALL runtimeNextFloat
	CP 0
	JP Z,FOR_6
; 		1190.12  LET lives=lives-1{00 00 01 00 00 }
	LD HL,ZXBASIC_VAR_lives
	CALL runtimePushFloatVar
	LD HL,FLOAT_3	;1
	CALL runtimePushFloatVar
; -
	RST $28
	DB $03	;SUB
	DB $38	;END CALC
	LD HL,ZXBASIC_VAR_lives
	CALL runtimeStoreFloat
; 		1190.13  IF lives>0{00 00 00 00 00 } THEN  PRINT  AT y,x;" "
	LD HL,ZXBASIC_VAR_lives
	CALL runtimePushFloatVar
	LD HL,FLOAT_1	;0
	CALL runtimePushFloatVar
; >
	CALL runtimeBiggerFloat
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_26
; 		1190.14  PRINT  AT y,x;" "
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,ZXBASIC_VAR_y
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	PUSH HL
	LD HL,ZXBASIC_VAR_x
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	POP DE
	CALL runtimePrintAt
	LD HL,STRING_31	; 
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
; 		1190.15  GOSUB 1130{00 00 6a 04 00 }
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_1130
ZXB_LABEL_26:
ZXBASIC_LINE_1200:
; 1200  RETURN 
; 		1200.1  RETURN 
	CALL runtimeCheckBreak
	RET
ZXBASIC_LINE_1210:
; 1210  REM -----------Update score
ZXBASIC_LINE_1220:
; 1220  PRINT  AT 0,6; INK 7; BRIGHT 1;score
; 		1220.1  PRINT  AT 0{00 00 00 00 00 },6{00 00 06 00 00 }; INK 7{00 00 07 00 00 }; BRIGHT 1{00 00 01 00 00 };score
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,FLOAT_1	;0
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	PUSH HL
	LD HL,FLOAT_7	;6
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	POP DE
	CALL runtimePrintAt
	LD HL,FLOAT_2	;7
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeLocalInk
	LD HL,FLOAT_3	;1
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeLocalBright
	LD HL,ZXBASIC_VAR_score
	CALL runtimePushFloatVar
	CALL runtimePrintFloat
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1230:
; 1230  RETURN 
; 		1230.1  RETURN 
	CALL runtimeCheckBreak
	RET
ZXBASIC_LINE_1240:
; 1240  REM ------------Update wave
ZXBASIC_LINE_1250:
; 1250  PRINT  AT 0,18; BRIGHT 1;wave
; 		1250.1  PRINT  AT 0{00 00 00 00 00 },18{00 00 12 00 00 }; BRIGHT 1{00 00 01 00 00 };wave
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,FLOAT_1	;0
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	PUSH HL
	LD HL,FLOAT_11	;18
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	POP DE
	CALL runtimePrintAt
	LD HL,FLOAT_3	;1
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeLocalBright
	LD HL,ZXBASIC_VAR_wave
	CALL runtimePushFloatVar
	CALL runtimePrintFloat
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1260:
; 1260  RETURN 
; 		1260.1  RETURN 
	CALL runtimeCheckBreak
	RET
ZXBASIC_LINE_1270:
; 1270  REM -------------Extra life
ZXBASIC_LINE_1280:
; 1280  LET lives=lives+1
; 		1280.1  LET lives=lives+1{00 00 01 00 00 }
	LD HL,ZXBASIC_VAR_lives
	CALL runtimePushFloatVar
	LD HL,FLOAT_3	;1
	CALL runtimePushFloatVar
; +
	RST $28
	DB $0f	;ADD
	DB $38	;END CALC
	LD HL,ZXBASIC_VAR_lives
	CALL runtimeStoreFloat
ZXBASIC_LINE_1290:
; 1290  PRINT  AT 0,28+lives; INK 3; BRIGHT 1;"\144"
; 		1290.1  PRINT  AT 0{00 00 00 00 00 },28{00 00 1c 00 00 }+lives; INK 3{00 00 03 00 00 }; BRIGHT 1{00 00 01 00 00 };"\144"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,FLOAT_1	;0
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	PUSH HL
	LD HL,FLOAT_29	;28
	CALL runtimePushFloatVar
	LD HL,ZXBASIC_VAR_lives
	CALL runtimePushFloatVar
; +
	RST $28
	DB $0f	;ADD
	DB $38	;END CALC
	CALL runtimeFloatToInt
	POP DE
	CALL runtimePrintAt
	LD HL,FLOAT_6	;3
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeLocalInk
	LD HL,FLOAT_3	;1
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	CALL runtimeLocalBright
	LD HL,STRING_9	;\90
	CALL runtimePrintString
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1300:
; 1300  RETURN 
; 		1300.1  RETURN 
	CALL runtimeCheckBreak
	RET
ZXBASIC_LINE_9000:
; 9000  PRINT  AT 0,0;"57342="; IN 57342;" 32766="; IN 32766;" 65022= "; IN 65022;" 64510="; IN 64510;
; 		9000.1  PRINT  AT 0{00 00 00 00 00 },0{00 00 00 00 00 };"57342="; IN 57342{00 00 fe df 00 };" 32766="; IN 32766{00 00 fe 7f 00 };" 65022= "; IN 65022{00 00 fe fd 00 };" 64510="; IN 64510{00 00 fe fb 00 };
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,FLOAT_1	;0
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	PUSH HL
	LD HL,FLOAT_1	;0
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	POP DE
	CALL runtimePrintAt
	LD HL,STRING_38	;57342=
	CALL runtimePrintString
; IN
	LD HL,FLOAT_46	;57342
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD BC,HL
	IN A,(C)
	LD L,A
	LD H,0
	CALL runtimePrintInt
	LD HL,STRING_39	; 32766=
	CALL runtimePrintString
; IN
	LD HL,FLOAT_49	;32766
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD BC,HL
	IN A,(C)
	LD L,A
	LD H,0
	CALL runtimePrintInt
	LD HL,STRING_40	; 65022= 
	CALL runtimePrintString
; IN
	LD HL,FLOAT_43	;65022
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD BC,HL
	IN A,(C)
	LD L,A
	LD H,0
	CALL runtimePrintInt
	LD HL,STRING_41	; 64510=
	CALL runtimePrintString
; IN
	LD HL,FLOAT_45	;64510
	CALL runtimePushFloatVar
	CALL runtimeFloatToInt
	LD BC,HL
	IN A,(C)
	LD L,A
	LD H,0
	CALL runtimePrintInt
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_9010:
; 9010  GOTO 9000
; 		9010.1  GOTO 9000{00 00 28 23 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_9000
ZXBASIC_LINE_9990:
; 9990  STOP 
ZXBASIC_VAR_UDG:	defs 5
ZXBASIC_VAR_b:	defs 5
ZXBASIC_VAR_c_array:	defs 505
ZXBASIC_VAR_c_string:	defs 404
ZXBASIC_VAR_d_array:	defs 505
ZXBASIC_VAR_d_string:	defs 404
ZXBASIC_VAR_dt:	defs 5
ZXBASIC_VAR_dx:	defs 5
ZXBASIC_VAR_dy:	defs 5
ZXBASIC_VAR_f:	defs 5
ZXBASIC_VAR_for_i:	defs 5
ZXBASIC_VAR_for_j:	defs 5
ZXBASIC_VAR_for_j_step:	defs 5
ZXBASIC_VAR_i:	defs 5
ZXBASIC_VAR_inkey:	defs 5
ZXBASIC_VAR_j:	defs 5
ZXBASIC_VAR_kz:	defs 5
ZXBASIC_VAR_lives:	defs 5
ZXBASIC_VAR_n:	defs 5
ZXBASIC_VAR_nx:	defs 5
ZXBASIC_VAR_ny:	defs 5
ZXBASIC_VAR_nz:	defs 5
ZXBASIC_VAR_s_array:	defs 2645
ZXBASIC_VAR_score:	defs 5
ZXBASIC_VAR_t:	defs 5
ZXBASIC_VAR_wave:	defs 5
ZXBASIC_VAR_x:	defs 5
ZXBASIC_VAR_x_array:	defs 505
ZXBASIC_VAR_y:	defs 5
ZXBASIC_VAR_y_array:	defs 505
ZXBASIC_VAR_za:	defs 5
ZXBASIC_VAR_zb:	defs 5
ZXBASIC_VAR_zc:	defs 5
ZXBASIC_VAR_zi:	defs 5
ZXBASIC_VAR_zx:	defs 5
ZXBASIC_VAR_zy:	defs 5
FLOAT_1:	db $00, $00, $00, $00, $00	;0
FLOAT_10:	db $00, $00, $08, $00, $00	;8
FLOAT_11:	db $00, $00, $12, $00, $00	;18
FLOAT_12:	db $00, $00, $09, $00, $00	;9
FLOAT_13:	db $00, $00, $13, $00, $00	;19
FLOAT_14:	db $00, $00, $e6, $00, $00	;230
FLOAT_15:	db $00, $00, $15, $00, $00	;21
FLOAT_16:	db $00, $00, $8c, $00, $00	;140
FLOAT_17:	db $00, $00, $14, $00, $00	;20
FLOAT_18:	db $78, $03, $12, $6e, $97	;0.002
FLOAT_19:	db $00, $00, $0a, $00, $00	;10
FLOAT_2:	db $00, $00, $07, $00, $00	;7
FLOAT_20:	db $00, $00, $0e, $00, $00	;14
FLOAT_21:	db $00, $00, $10, $00, $00	;16
FLOAT_22:	db $00, $00, $36, $01, $00	;310
FLOAT_23:	db $00, $00, $1f, $00, $00	;31
FLOAT_24:	db $00, $00, $ba, $04, $00	;1210
FLOAT_25:	db $00, $00, $17, $00, $00	;23
FLOAT_26:	db $00, $00, $0d, $00, $00	;13
FLOAT_27:	db $00, $00, $d8, $04, $00	;1240
FLOAT_28:	db $00, $00, $19, $00, $00	;25
FLOAT_29:	db $00, $00, $1c, $00, $00	;28
FLOAT_3:	db $00, $00, $01, $00, $00	;1
FLOAT_30:	db $00, $00, $62, $02, $00	;610
FLOAT_31:	db $00, $00, $bc, $02, $00	;700
FLOAT_32:	db $79, $23, $d7, $0a, $3d	;0.005
FLOAT_33:	db $00, $00, $60, $04, $00	;1120
FLOAT_34:	db $91, $00, $00, $00, $00	;65536
FLOAT_35:	db $00, $00, $7a, $5c, $00	;23674
FLOAT_36:	db $00, $00, $00, $01, $00	;256
FLOAT_37:	db $00, $00, $79, $5c, $00	;23673
FLOAT_38:	db $00, $00, $78, $5c, $00	;23672
FLOAT_39:	db $00, $00, $32, $00, $00	;50
FLOAT_4:	db $00, $00, $0c, $00, $00	;12
FLOAT_40:	db $00, $00, $0b, $00, $00	;11
FLOAT_41:	db $00, $00, $1e, $00, $00	;30
FLOAT_42:	db $00, $00, $2a, $03, $00	;810
FLOAT_43:	db $00, $00, $fe, $fd, $00	;65022
FLOAT_44:	db $00, $00, $be, $00, $00	;190
FLOAT_45:	db $00, $00, $fe, $fb, $00	;64510
FLOAT_46:	db $00, $00, $fe, $df, $00	;57342
FLOAT_47:	db $00, $00, $bd, $00, $00	;189
FLOAT_48:	db $00, $00, $48, $03, $00	;840
FLOAT_49:	db $00, $00, $fe, $7f, $00	;32766
FLOAT_5:	db $00, $00, $02, $00, $00	;2
FLOAT_50:	db $00, $00, $bf, $00, $00	;191
FLOAT_51:	db $77, $03, $12, $6e, $97	;0.001
FLOAT_52:	db $00, $00, $18, $00, $00	;24
FLOAT_53:	db $00, $00, $9c, $04, $00	;1180
FLOAT_54:	db $00, $00, $24, $04, $00	;1060
FLOAT_55:	db $00, $00, $bb, $00, $00	;187
FLOAT_56:	db $7a, $23, $d7, $0a, $3d	;0.01
FLOAT_57:	db $00, $00, $24, $00, $00	;36
FLOAT_58:	db $00, $00, $e8, $03, $00	;1000
FLOAT_59:	db $00, $00, $a2, $03, $00	;930
FLOAT_6:	db $00, $00, $03, $00, $00	;3
FLOAT_60:	db $00, $00, $b6, $03, $00	;950
FLOAT_61:	db $00, $00, $f8, $02, $00	;760
FLOAT_62:	db $7d, $4c, $cc, $cc, $cc	;0.1
FLOAT_63:	db $7c, $4c, $cc, $cc, $cc	;0.05
FLOAT_64:	db $7e, $4c, $cc, $cc, $cc	;0.2
FLOAT_65:	db $00, $00, $cc, $01, $00	;460
FLOAT_66:	db $00, $00, $1a, $00, $00	;26
FLOAT_67:	db $7b, $23, $d7, $0a, $3d	;0.02
FLOAT_68:	db $00, $00, $42, $04, $00	;1090
FLOAT_69:	db $00, $00, $6a, $04, $00	;1130
FLOAT_7:	db $00, $00, $06, $00, $00	;6
FLOAT_70:	db $00, $00, $28, $23, $00	;9000
FLOAT_8:	db $00, $00, $05, $00, $00	;5
FLOAT_9:	db $00, $00, $04, $00, $00	;4
STRING_0:	dw 9
	db	"ZXombies!"
STRING_1:	dw 26
	db	"It's 1983 and the dead are"
STRING_10:	dw 26
	db	" MAGENTA       100% badass"
STRING_11:	dw 1
	db	$93
STRING_12:	dw 26
	db	" DAWDLER        +10 points"
STRING_13:	dw 1
	db	$94
STRING_14:	dw 26
	db	" WHINGER        +20 points"
STRING_15:	dw 1
	db	$95
STRING_16:	dw 26
	db	" GUZZLER        +30 points"
STRING_17:	dw 1
	db	$96
STRING_18:	dw 26
	db	" PLASTER           +1 life"
STRING_19:	dw 27
	db	"QAOP to move + M to attack!"
STRING_2:	dw 22
	db	"rising from the grave."
STRING_20:	dw 32
	db	"     Press any key to start     "
STRING_21:	dw 0
STRING_22:	dw 33
	db	"+++++++++++++++++++++++++++++++++"
STRING_23:	dw 2
	db	"++"
STRING_24:	dw 6
	db	"Score:"
STRING_25:	dw 6
	db	"Lives:"
STRING_26:	dw 3
	db	$90, $90, $90
STRING_27:	dw 5
	db	"Wave:"
STRING_28:	dw 8
	db	"Exhuming"
STRING_29:	dw 1
	db	$91
STRING_3:	dw 16
	db	"Who can save us?"
STRING_30:	dw 14
	db	"              "
STRING_31:	dw 1
	db	" "
STRING_32:	dw 1
	db	$92
STRING_33:	dw 1
	db	"*"
STRING_34:	dw 14
	db	"WAVE COMPLETE!"
STRING_35:	dw 5
	db	" GAME"
STRING_36:	dw 6
	db	"OVER! "
STRING_37:	dw 32
	db	"    Press any key to continue   "
STRING_38:	dw 6
	db	"57342="
STRING_39:	dw 7
	db	" 32766="
STRING_4:	dw 15
	db	"2017 @xenopunk"
STRING_40:	dw 8
	db	" 65022= "
STRING_41:	dw 7
	db	" 64510="
STRING_5:	dw 19
	db	"#zxspectrumbasicjam"
STRING_6:	dw 11
	db	"Decomposing"
STRING_7:	dw 1
	db	"a"
STRING_8:	dw 1
	db	"/"
STRING_9:	dw 1
	db	$90
DATAPTR:	DW 0
DATA_140:
	db $00,$00,$38,$00,$00	;56
DATA_150:
	db $00,$00,$18,$00,$00	;24
	db $00,$00,$18,$00,$00	;24
	db $00,$00,$10,$00,$00	;16
	db $00,$00,$3c,$00,$00	;60
	db $00,$00,$5a,$00,$00	;90
	db $00,$00,$18,$00,$00	;24
	db $00,$00,$24,$00,$00	;36
	db $00,$00,$44,$00,$00	;68
DATA_160:
	db $00,$00,$00,$00,$00	;0
	db $00,$00,$3c,$00,$00	;60
	db $00,$00,$7e,$00,$00	;126
	db $00,$00,$42,$00,$00	;66
	db $00,$00,$7e,$00,$00	;126
	db $00,$00,$42,$00,$00	;66
	db $00,$00,$7e,$00,$00	;126
	db $00,$00,$7e,$00,$00	;126
DATA_170:
	db $00,$00,$00,$00,$00	;0
	db $00,$00,$08,$00,$00	;8
	db $00,$00,$10,$00,$00	;16
	db $00,$00,$df,$00,$00	;223
	db $00,$00,$fc,$00,$00	;252
	db $00,$00,$22,$00,$00	;34
	db $00,$00,$41,$00,$00	;65
	db $00,$00,$00,$00,$00	;0
DATA_180:
	db $00,$00,$18,$00,$00	;24
	db $00,$00,$18,$00,$00	;24
	db $00,$00,$10,$00,$00	;16
	db $00,$00,$1e,$00,$00	;30
	db $00,$00,$18,$00,$00	;24
	db $00,$00,$18,$00,$00	;24
	db $00,$00,$14,$00,$00	;20
	db $00,$00,$24,$00,$00	;36
DATA_190:
	db $00,$00,$18,$00,$00	;24
	db $00,$00,$18,$00,$00	;24
	db $00,$00,$52,$00,$00	;82
	db $00,$00,$3c,$00,$00	;60
	db $00,$00,$18,$00,$00	;24
	db $00,$00,$18,$00,$00	;24
	db $00,$00,$14,$00,$00	;20
	db $00,$00,$14,$00,$00	;20
DATA_200:
	db $00,$00,$18,$00,$00	;24
	db $00,$00,$18,$00,$00	;24
	db $00,$00,$10,$00,$00	;16
	db $00,$00,$38,$00,$00	;56
	db $00,$00,$7c,$00,$00	;124
	db $00,$00,$ba,$00,$00	;186
	db $00,$00,$28,$00,$00	;40
	db $00,$00,$44,$00,$00	;68
DATA_210:
	db $00,$00,$00,$00,$00	;0
	db $00,$00,$18,$00,$00	;24
	db $00,$00,$18,$00,$00	;24
	db $00,$00,$7e,$00,$00	;126
	db $00,$00,$7e,$00,$00	;126
	db $00,$00,$18,$00,$00	;24
	db $00,$00,$18,$00,$00	;24
	db $00,$00,$00,$00,$00	;0


    DISPLAY "Compiled Basic = ", /D, $-CBASIC_START,  " bytes"
