
CBASIC_START
compiledBasic:
	call ZXHeapClear
	LD (runtimeSaveSP),SP
	LD (DATAPTR),HL
	LD HL,DATA_3890
; 1010.1  DIM g(9,9)
	LD HL,ZXBASIC_VAR_g_array
	LD BC,200
	CALL runtimeClearArray
; 1020.1  DIM o(9,9)
	LD HL,ZXBASIC_VAR_o_array
	LD BC,200
	CALL runtimeClearArray
; 		1000.1  RANDOMIZE 
	LD HL,($5C78)	;Timer lower bytes
	LD ($5C76),HL	;Random Seed
ZXBASIC_LINE_1010:
; 1010  DIM g(9,9)
; 		1010.1  DIM g(9{00 00 09 00 00 },9{00 00 09 00 00 })
	LD HL,ZXBASIC_VAR_g_array
	LD BC,200
	CALL runtimeClearArray
ZXBASIC_LINE_1020:
; 1020  DIM o(9,9)
; 		1020.1  DIM o(9{00 00 09 00 00 },9{00 00 09 00 00 })
	LD HL,ZXBASIC_VAR_o_array
	LD BC,200
	CALL runtimeClearArray
ZXBASIC_LINE_1030:
; 1030  LET playerx=0: LET playery=0: LET gridw=6: LET gridh=6: LET fieldx=4: LET fieldy=3: LET numSelected=0: LET xSel1=0: LET ySel1=0: LET colSel1=0: LET xSel2=0: LET ySel2=0: LET colSel2=0: LET found=0: LET moves=0
; 		1030.1  LET playerx=0{00 00 00 00 00 }
	LD HL,0
	LD (ZXBASIC_VAR_playerx),HL
; 		1030.2  LET playery=0{00 00 00 00 00 }
	LD (ZXBASIC_VAR_playery),HL
; 		1030.3  LET gridw=6{00 00 06 00 00 }
	LD HL,6
	LD (ZXBASIC_VAR_gridw),HL
; 		1030.4  LET gridh=6{00 00 06 00 00 }
	LD (ZXBASIC_VAR_gridh),HL
; 		1030.5  LET fieldx=4{00 00 04 00 00 }
	LD HL,4
	LD (ZXBASIC_VAR_fieldx),HL
; 		1030.6  LET fieldy=3{00 00 03 00 00 }
	LD HL,3
	LD (ZXBASIC_VAR_fieldy),HL
; 		1030.7  LET numSelected=0{00 00 00 00 00 }
	LD HL,0
	LD (ZXBASIC_VAR_numSelected),HL
; 		1030.8  LET xSel1=0{00 00 00 00 00 }
	LD (ZXBASIC_VAR_xSel1),HL
; 		1030.9  LET ySel1=0{00 00 00 00 00 }
	LD HL,0
	LD (ZXBASIC_VAR_ySel1),HL
; 		1030.10  LET colSel1=0{00 00 00 00 00 }
	LD (ZXBASIC_VAR_colSel1),HL
; 		1030.11  LET xSel2=0{00 00 00 00 00 }
	LD HL,0
	LD (ZXBASIC_VAR_xSel2),HL
; 		1030.12  LET ySel2=0{00 00 00 00 00 }
	LD (ZXBASIC_VAR_ySel2),HL
; 		1030.13  LET colSel2=0{00 00 00 00 00 }
	LD HL,0
	LD (ZXBASIC_VAR_colSel2),HL
; 		1030.14  LET found=0{00 00 00 00 00 }
	LD (ZXBASIC_VAR_found),HL
; 		1030.15  LET moves=0{00 00 00 00 00 }
	LD HL,0
	LD (ZXBASIC_VAR_moves),HL
ZXBASIC_LINE_1040:
; 1040  GO SUB 1080
; 		1040.1  GO SUB 1080{00 00 38 04 00 }
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_1080
ZXBASIC_LINE_1050:
; 1050  LET playerInputSelect=1
; 		1050.1  LET playerInputSelect=1{00 00 01 00 00 }
	LD HL,1
	LD (ZXBASIC_VAR_playerInputSelect),HL
ZXBASIC_LINE_1060:
; 1060  GO SUB 1750
; 		1060.1  GO SUB 1750{00 00 d6 06 00 }
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_1750
ZXBASIC_LINE_1070:
; 1070  GOTO 4520
; 		1070.1  GOTO 4520{00 00 a8 11 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_4520
ZXBASIC_LINE_1080:
; 1080  REM  SUB initmovement
ZXBASIC_LINE_1090:
; 1090  REM  -----------------
ZXBASIC_LINE_1100:
; 1100  LET playerx=0: LET playery=0: LET playerxold=0: LET playeryold=0: LET playerfire=0: LET playerstep=2: LET playermoved=0: LET singleKey=0: LET playerleft=0: LET playerright=31: LET playerup=0: LET playerdown=21: LET playerKeyMoveLeft=113: LET playerKeyMoveRight=119: LET playerKeyMoveUp=112: LET playerKeyMoveDown=108: LET playerKeyFire=13: LET playerKeyFire2=32: LET playerInputSelect=2: LET playerWaitKeyRelease=0: LET playerWaitKeyPause=13: RETURN 
; 		1100.1  LET playerx=0{00 00 00 00 00 }
	LD HL,0
	LD (ZXBASIC_VAR_playerx),HL
; 		1100.2  LET playery=0{00 00 00 00 00 }
	LD (ZXBASIC_VAR_playery),HL
; 		1100.3  LET playerxold=0{00 00 00 00 00 }
	LD HL,0
	LD (ZXBASIC_VAR_playerxold),HL
; 		1100.4  LET playeryold=0{00 00 00 00 00 }
	LD (ZXBASIC_VAR_playeryold),HL
; 		1100.5  LET playerfire=0{00 00 00 00 00 }
	LD HL,0
	LD (ZXBASIC_VAR_playerfire),HL
; 		1100.6  LET playerstep=2{00 00 02 00 00 }
	LD HL,2
	LD (ZXBASIC_VAR_playerstep),HL
; 		1100.7  LET playermoved=0{00 00 00 00 00 }
	LD HL,0
	LD (ZXBASIC_VAR_playermoved),HL
; 		1100.8  LET singleKey=0{00 00 00 00 00 }
	LD (ZXBASIC_VAR_singleKey),HL
; 		1100.9  LET playerleft=0{00 00 00 00 00 }
	LD HL,0
	LD (ZXBASIC_VAR_playerleft),HL
; 		1100.10  LET playerright=31{00 00 1f 00 00 }
	LD HL,31
	LD (ZXBASIC_VAR_playerright),HL
; 		1100.11  LET playerup=0{00 00 00 00 00 }
	LD HL,0
	LD (ZXBASIC_VAR_playerup),HL
; 		1100.12  LET playerdown=21{00 00 15 00 00 }
	LD HL,21
	LD (ZXBASIC_VAR_playerdown),HL
; 		1100.13  LET playerKeyMoveLeft=113{00 00 71 00 00 }
	LD HL,113
	LD (ZXBASIC_VAR_playerKeyMoveLeft),HL
; 		1100.14  LET playerKeyMoveRight=119{00 00 77 00 00 }
	LD HL,119
	LD (ZXBASIC_VAR_playerKeyMoveRight),HL
; 		1100.15  LET playerKeyMoveUp=112{00 00 70 00 00 }
	LD HL,112
	LD (ZXBASIC_VAR_playerKeyMoveUp),HL
; 		1100.16  LET playerKeyMoveDown=108{00 00 6c 00 00 }
	LD HL,108
	LD (ZXBASIC_VAR_playerKeyMoveDown),HL
; 		1100.17  LET playerKeyFire=13{00 00 0d 00 00 }
	LD HL,13
	LD (ZXBASIC_VAR_playerKeyFire),HL
; 		1100.18  LET playerKeyFire2=32{00 00 20 00 00 }
	LD HL,32
	LD (ZXBASIC_VAR_playerKeyFire2),HL
; 		1100.19  LET playerInputSelect=2{00 00 02 00 00 }
	LD HL,2
	LD (ZXBASIC_VAR_playerInputSelect),HL
; 		1100.20  LET playerWaitKeyRelease=0{00 00 00 00 00 }
	LD HL,0
	LD (ZXBASIC_VAR_playerWaitKeyRelease),HL
; 		1100.21  LET playerWaitKeyPause=13{00 00 0d 00 00 }
	LD HL,13
	LD (ZXBASIC_VAR_playerWaitKeyPause),HL
; 		1100.22  RETURN 
	CALL runtimeCheckBreak
	RET
ZXBASIC_LINE_1110:
; 1110  REM  SUB playermovement
ZXBASIC_LINE_1120:
; 1120  REM  -------------------
ZXBASIC_LINE_1130:
; 1130  IF playerInputSelect>0 AND playerInputSelect<4 THEN  GOTO 1150+10*playerInputSelect
; 		1130.1  IF playerInputSelect>0{00 00 00 00 00 } AND playerInputSelect<4{00 00 04 00 00 } THEN  GOTO 1150{00 00 7e 04 00 }+10{00 00 0a 00 00 }*playerInputSelect
	LD DE,(ZXBASIC_VAR_playerInputSelect)
	LD HL,0
; >
	CALL runtimeCmpHlGtDE
	PUSH HL
	LD DE,(ZXBASIC_VAR_playerInputSelect)
	LD HL,4
; <
	CALL runtimeCmpHLltDE
; AND
	POP DE
	call runtimeAndHLDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_1
; 		1130.2  GOTO 1150{00 00 7e 04 00 }+10{00 00 0a 00 00 }*playerInputSelect
	CALL runtimeCheckBreak
	LD HL,1150
	PUSH HL
	LD DE,10
	LD HL,(ZXBASIC_VAR_playerInputSelect)
; *
	call runtimeMult16bit
; +
	POP DE
	ADD HL,DE
	LD DE,HL
	LD HL,ZXLINES
	CALL runtimeFindLine
	JP (HL)
ZXB_LABEL_1:
ZXBASIC_LINE_1140:
; 1140  RETURN 
; 		1140.1  RETURN 
	CALL runtimeCheckBreak
	RET
ZXBASIC_LINE_1150:
; 1150  PRINT "Error"
; 		1150.1  PRINT "Error"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_0	;Error
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1160:
; 1160  GO SUB 1290: RETURN 
; 		1160.1  GO SUB 1290{00 00 0a 05 00 }
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_1290
; 		1160.2  RETURN 
	CALL runtimeCheckBreak
	RET
ZXBASIC_LINE_1170:
; 1170  GO SUB 1200: RETURN 
; 		1170.1  GO SUB 1200{00 00 b0 04 00 }
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_1200
; 		1170.2  RETURN 
	CALL runtimeCheckBreak
	RET
ZXBASIC_LINE_1180:
; 1180  GO SUB 1250: RETURN 
; 		1180.1  GO SUB 1250{00 00 e2 04 00 }
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_1250
; 		1180.2  RETURN 
	CALL runtimeCheckBreak
	RET
ZXBASIC_LINE_1190:
; 1190  RETURN 
; 		1190.1  RETURN 
	CALL runtimeCheckBreak
	RET
ZXBASIC_LINE_1200:
; 1200  REM  SUB kempstonjoystick
ZXBASIC_LINE_1210:
; 1210  REM  ---------------------
ZXBASIC_LINE_1220:
; 1220  LET singleKey= CODE  INKEY$ : LET port1= IN 31: LET playerKeyFire=0: IF port1>15 THEN  LET playerKeyFire=1: LET port1=port1-16
; 		1220.1  LET singleKey= CODE  INKEY$ 
; CODE
; INKEY$
	CALL runtimeInkey
	CALL runtimeCode
	LD (ZXBASIC_VAR_singleKey),HL
	CALL ZXFreeTempCompact
; 		1220.2  LET port1= IN 31{00 00 1f 00 00 }
; IN
	LD BC,31
	IN A,(C)
	LD L,A
	LD H,0
	LD (ZXBASIC_VAR_port1),HL
; 		1220.3  LET playerKeyFire=0{00 00 00 00 00 }
	LD HL,0
	LD (ZXBASIC_VAR_playerKeyFire),HL
; 		1220.4  IF port1>15{00 00 0f 00 00 } THEN  LET playerKeyFire=1{00 00 01 00 00 }
	LD DE,(ZXBASIC_VAR_port1)
	LD HL,15
; >
	CALL runtimeCmpHlGtDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_2
; 		1220.5  LET playerKeyFire=1{00 00 01 00 00 }
	LD HL,1
	LD (ZXBASIC_VAR_playerKeyFire),HL
; 		1220.6  LET port1=port1-16{00 00 10 00 00 }
	LD HL,(ZXBASIC_VAR_port1)
	LD DE,16
; -
	SUB HL,DE
	LD (ZXBASIC_VAR_port1),HL
ZXB_LABEL_2:
ZXBASIC_LINE_1230:
; 1230  LET playerxold=playerx: LET playeryold=playery: LET playerx=playerx-((port1=2 OR port1=10 OR port1=6) AND playerx>playerleft)+((port1=1 OR port1=5 OR port1=9) AND playerx<playerright): LET playery=playery-((port1=8 OR port1=9 OR port1=10) AND playery>playerup)+((port1=4 OR port1=5 OR port1=6) AND playery<playerdown): IF playerxold <> playerx OR playeryold <> playery THEN  LET playermoved=1
; 		1230.1  LET playerxold=playerx
	LD HL,(ZXBASIC_VAR_playerx)
	LD (ZXBASIC_VAR_playerxold),HL
; 		1230.2  LET playeryold=playery
	LD HL,(ZXBASIC_VAR_playery)
	LD (ZXBASIC_VAR_playeryold),HL
; 		1230.3  LET playerx=playerx-((port1=2{00 00 02 00 00 } OR port1=10{00 00 0a 00 00 } OR port1=6{00 00 06 00 00 }) AND playerx>playerleft)+((port1=1{00 00 01 00 00 } OR port1=5{00 00 05 00 00 } OR port1=9{00 00 09 00 00 }) AND playerx<playerright)
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
; 		1230.4  LET playery=playery-((port1=8{00 00 08 00 00 } OR port1=9{00 00 09 00 00 } OR port1=10{00 00 0a 00 00 }) AND playery>playerup)+((port1=4{00 00 04 00 00 } OR port1=5{00 00 05 00 00 } OR port1=6{00 00 06 00 00 }) AND playery<playerdown)
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
; 		1230.5  IF playerxold <> playerx OR playeryold <> playery THEN  LET playermoved=1{00 00 01 00 00 }
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
	JP Z,ZXB_LABEL_3
; 		1230.6  LET playermoved=1{00 00 01 00 00 }
	LD HL,1
	LD (ZXBASIC_VAR_playermoved),HL
ZXB_LABEL_3:
ZXBASIC_LINE_1240:
; 1240  RETURN 
; 		1240.1  RETURN 
	CALL runtimeCheckBreak
	RET
ZXBASIC_LINE_1250:
; 1250  REM  SUB sinclairjoystick
ZXBASIC_LINE_1260:
; 1260  REM  ---------------------
ZXBASIC_LINE_1270:
; 1270  LET singleKey= CODE  INKEY$ : LET playerxold=playerx: LET playeryold=playery: LET port1= IN 61438: LET p1= INT (port1/2): LET playerKeyFire=(port1-p1*2)=0: LET playerx=playerx-((p1=85 OR p1=86 OR p1=87) AND playerx>playerleft)+((p1=89 OR p1=90 OR p1=91) AND playerx<playerright): LET playery=playery-((p1=86 OR p1=90 OR p1=94) AND playery>playerup)+((p1=85 OR p1=93 OR p1=89) AND playery<playerdown): IF playerxold <> playerx OR playeryold <> playery THEN  LET playermoved=1
; 		1270.1  LET singleKey= CODE  INKEY$ 
; CODE
; INKEY$
	CALL runtimeInkey
	CALL runtimeCode
	LD (ZXBASIC_VAR_singleKey),HL
	CALL ZXFreeTempCompact
; 		1270.2  LET playerxold=playerx
	LD HL,(ZXBASIC_VAR_playerx)
	LD (ZXBASIC_VAR_playerxold),HL
; 		1270.3  LET playeryold=playery
	LD HL,(ZXBASIC_VAR_playery)
	LD (ZXBASIC_VAR_playeryold),HL
; 		1270.4  LET port1= IN 61438{00 00 fe ef 00 }
; IN
	LD BC,61438
	IN A,(C)
	LD L,A
	LD H,0
	LD (ZXBASIC_VAR_port1),HL
; 		1270.5  LET p1= INT (port1/2{00 00 02 00 00 })
; INT
	LD DE,(ZXBASIC_VAR_port1)
	LD HL,2
; /
	call runtimeDiv16bit
	LD (ZXBASIC_VAR_p1),HL
; 		1270.6  LET playerKeyFire=(port1-p1*2{00 00 02 00 00 })=0{00 00 00 00 00 }
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
	LD (ZXBASIC_VAR_playerKeyFire),HL
; 		1270.7  LET playerx=playerx-((p1=85{00 00 55 00 00 } OR p1=86{00 00 56 00 00 } OR p1=87{00 00 57 00 00 }) AND playerx>playerleft)+((p1=89{00 00 59 00 00 } OR p1=90{00 00 5a 00 00 } OR p1=91{00 00 5b 00 00 }) AND playerx<playerright)
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
; 		1270.8  LET playery=playery-((p1=86{00 00 56 00 00 } OR p1=90{00 00 5a 00 00 } OR p1=94{00 00 5e 00 00 }) AND playery>playerup)+((p1=85{00 00 55 00 00 } OR p1=93{00 00 5d 00 00 } OR p1=89{00 00 59 00 00 }) AND playery<playerdown)
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
; 		1270.9  IF playerxold <> playerx OR playeryold <> playery THEN  LET playermoved=1{00 00 01 00 00 }
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
	JP Z,ZXB_LABEL_4
; 		1270.10  LET playermoved=1{00 00 01 00 00 }
	LD HL,1
	LD (ZXBASIC_VAR_playermoved),HL
ZXB_LABEL_4:
ZXBASIC_LINE_1280:
; 1280  RETURN 
; 		1280.1  RETURN 
	CALL runtimeCheckBreak
	RET
ZXBASIC_LINE_1290:
; 1290  REM  SUB keyboard
ZXBASIC_LINE_1300:
; 1300  REM  -------------
ZXBASIC_LINE_1310:
; 1310  LET singleKey=0
; 		1310.1  LET singleKey=0{00 00 00 00 00 }
	LD HL,0
	LD (ZXBASIC_VAR_singleKey),HL
ZXBASIC_LINE_1320:
; 1320  LET PROCkeyboarda= CODE  INKEY$ 
; 		1320.1  LET PROCkeyboarda= CODE  INKEY$ 
; CODE
; INKEY$
	CALL runtimeInkey
	CALL runtimeCode
	LD (ZXBASIC_VAR_PROCkeyboarda),HL
	CALL ZXFreeTempCompact
ZXBASIC_LINE_1330:
; 1330  LET playermoved=0
; 		1330.1  LET playermoved=0{00 00 00 00 00 }
	LD HL,0
	LD (ZXBASIC_VAR_playermoved),HL
ZXBASIC_LINE_1340:
; 1340  IF PROCkeyboarda=0 THEN  RETURN 
; 		1340.1  IF PROCkeyboarda=0{00 00 00 00 00 } THEN  RETURN 
	LD DE,(ZXBASIC_VAR_PROCkeyboarda)
	LD HL,0
; =
	CALL runtimeCmpHLEqDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_5
; 		1340.2  RETURN 
	CALL runtimeCheckBreak
	RET
ZXB_LABEL_5:
ZXBASIC_LINE_1350:
; 1350  LET singleKey=PROCkeyboarda
; 		1350.1  LET singleKey=PROCkeyboarda
	LD HL,(ZXBASIC_VAR_PROCkeyboarda)
	LD (ZXBASIC_VAR_singleKey),HL
ZXBASIC_LINE_1360:
; 1360  LET playerxold=playerx
; 		1360.1  LET playerxold=playerx
	LD HL,(ZXBASIC_VAR_playerx)
	LD (ZXBASIC_VAR_playerxold),HL
ZXBASIC_LINE_1370:
; 1370  LET playeryold=playery
; 		1370.1  LET playeryold=playery
	LD HL,(ZXBASIC_VAR_playery)
	LD (ZXBASIC_VAR_playeryold),HL
ZXBASIC_LINE_1380:
; 1380  LET playermoved=1
; 		1380.1  LET playermoved=1{00 00 01 00 00 }
	LD HL,1
	LD (ZXBASIC_VAR_playermoved),HL
ZXBASIC_LINE_1390:
; 1390  LET playerx=playerx+((PROCkeyboarda=playerKeyMoveRight OR PROCkeyboarda=9) AND playerx<playerright)-((PROCkeyboarda=playerKeyMoveLeft OR PROCkeyboarda=8) AND playerx>playerleft)
; 		1390.1  LET playerx=playerx+((PROCkeyboarda=playerKeyMoveRight OR PROCkeyboarda=9{00 00 09 00 00 }) AND playerx<playerright)-((PROCkeyboarda=playerKeyMoveLeft OR PROCkeyboarda=8{00 00 08 00 00 }) AND playerx>playerleft)
	LD HL,(ZXBASIC_VAR_playerx)
	PUSH HL
; (
; (
	LD DE,(ZXBASIC_VAR_PROCkeyboarda)
	LD HL,(ZXBASIC_VAR_playerKeyMoveRight)
; =
	CALL runtimeCmpHLEqDE
	PUSH HL
	LD DE,(ZXBASIC_VAR_PROCkeyboarda)
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
	LD DE,(ZXBASIC_VAR_PROCkeyboarda)
	LD HL,(ZXBASIC_VAR_playerKeyMoveLeft)
; =
	CALL runtimeCmpHLEqDE
	PUSH HL
	LD DE,(ZXBASIC_VAR_PROCkeyboarda)
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
ZXBASIC_LINE_1400:
; 1400  LET playery=playery+((PROCkeyboarda=playerKeyMoveDown OR PROCkeyboarda=10) AND playery<playerdown)-((PROCkeyboarda=playerKeyMoveUp OR PROCkeyboarda=11) AND playery>playerup)
; 		1400.1  LET playery=playery+((PROCkeyboarda=playerKeyMoveDown OR PROCkeyboarda=10{00 00 0a 00 00 }) AND playery<playerdown)-((PROCkeyboarda=playerKeyMoveUp OR PROCkeyboarda=11{00 00 0b 00 00 }) AND playery>playerup)
	LD HL,(ZXBASIC_VAR_playery)
	PUSH HL
; (
; (
	LD DE,(ZXBASIC_VAR_PROCkeyboarda)
	LD HL,(ZXBASIC_VAR_playerKeyMoveDown)
; =
	CALL runtimeCmpHLEqDE
	PUSH HL
	LD DE,(ZXBASIC_VAR_PROCkeyboarda)
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
	LD DE,(ZXBASIC_VAR_PROCkeyboarda)
	LD HL,(ZXBASIC_VAR_playerKeyMoveUp)
; =
	CALL runtimeCmpHLEqDE
	PUSH HL
	LD DE,(ZXBASIC_VAR_PROCkeyboarda)
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
ZXBASIC_LINE_1410:
; 1410  IF playerxold <> playerx OR playeryold <> playery THEN  LET playermoved=1
; 		1410.1  IF playerxold <> playerx OR playeryold <> playery THEN  LET playermoved=1{00 00 01 00 00 }
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
	JP Z,ZXB_LABEL_6
; 		1410.2  LET playermoved=1{00 00 01 00 00 }
	LD HL,1
	LD (ZXBASIC_VAR_playermoved),HL
ZXB_LABEL_6:
ZXBASIC_LINE_1420:
; 1420  IF playerWaitKeyRelease=1 THEN  GO SUB 1620
; 		1420.1  IF playerWaitKeyRelease=1{00 00 01 00 00 } THEN  GO SUB 1620{00 00 54 06 00 }
	LD DE,(ZXBASIC_VAR_playerWaitKeyRelease)
	LD HL,1
; =
	CALL runtimeCmpHLEqDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_7
; 		1420.2  GO SUB 1620{00 00 54 06 00 }
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_1620
ZXB_LABEL_7:
ZXBASIC_LINE_1430:
; 1430  IF playerWaitKeyPause>0 THEN  PAUSE playerWaitKeyPause
; 		1430.1  IF playerWaitKeyPause>0{00 00 00 00 00 } THEN  PAUSE playerWaitKeyPause
	LD DE,(ZXBASIC_VAR_playerWaitKeyPause)
	LD HL,0
; >
	CALL runtimeCmpHlGtDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_8
; 		1430.2  PAUSE playerWaitKeyPause
	LD HL,(ZXBASIC_VAR_playerWaitKeyPause)
	CALL runtimePause
ZXB_LABEL_8:
ZXBASIC_LINE_1440:
; 1440  RETURN 
; 		1440.1  RETURN 
	CALL runtimeCheckBreak
	RET
ZXBASIC_LINE_1450:
; 1450  REM  SUB getsinglekey
ZXBASIC_LINE_1460:
; 1460  REM  -----------------
ZXBASIC_LINE_1470:
; 1470  LET singleKey= CODE  INKEY$ 
; 		1470.1  LET singleKey= CODE  INKEY$ 
; CODE
; INKEY$
	CALL runtimeInkey
	CALL runtimeCode
	LD (ZXBASIC_VAR_singleKey),HL
	CALL ZXFreeTempCompact
ZXBASIC_LINE_1480:
; 1480  IF singleKey <> 0 THEN  GOTO 1500
; 		1480.1  IF singleKey <> 0{00 00 00 00 00 } THEN  GOTO 1500{00 00 dc 05 00 }
	LD DE,(ZXBASIC_VAR_singleKey)
	LD HL,0
; <>
	CALL runtimeCmpHlNeDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_9
; 		1480.2  GOTO 1500{00 00 dc 05 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_1500
ZXB_LABEL_9:
ZXBASIC_LINE_1490:
; 1490  GOTO 1470
; 		1490.1  GOTO 1470{00 00 be 05 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_1470
ZXBASIC_LINE_1500:
; 1500  LET PROCgetsinglekeya= CODE  INKEY$ 
; 		1500.1  LET PROCgetsinglekeya= CODE  INKEY$ 
; CODE
; INKEY$
	CALL runtimeInkey
	CALL runtimeCode
	LD (ZXBASIC_VAR_PROCgetsinglekeya),HL
	CALL ZXFreeTempCompact
ZXBASIC_LINE_1510:
; 1510  IF PROCgetsinglekeya=0 THEN  GOTO 1530
; 		1510.1  IF PROCgetsinglekeya=0{00 00 00 00 00 } THEN  GOTO 1530{00 00 fa 05 00 }
	LD DE,(ZXBASIC_VAR_PROCgetsinglekeya)
	LD HL,0
; =
	CALL runtimeCmpHLEqDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_10
; 		1510.2  GOTO 1530{00 00 fa 05 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_1530
ZXB_LABEL_10:
ZXBASIC_LINE_1520:
; 1520  GOTO 1500
; 		1520.1  GOTO 1500{00 00 dc 05 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_1500
ZXBASIC_LINE_1530:
; 1530  RETURN 
; 		1530.1  RETURN 
	CALL runtimeCheckBreak
	RET
ZXBASIC_LINE_1540:
; 1540  REM  SUB definekeys
ZXBASIC_LINE_1550:
; 1550  REM  ---------------
ZXBASIC_LINE_1560:
; 1560  PRINT "Press Key FOR left ";: GO SUB 1450: PRINT  CHR$ (singleKey): LET playerKeyMoveLeft=singleKey
; 		1560.1  PRINT "Press Key FOR left ";
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_1	;Press Key FOR left 
	CALL runtimePrintString
	POP AF
	LD (ZX_P_FLAG),A
; 		1560.2  GO SUB 1450{00 00 aa 05 00 }
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_1450
; 		1560.3  PRINT  CHR$ (singleKey)
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
; CHR$
	LD HL,(ZXBASIC_VAR_singleKey)
	CALL runtimeChr
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
	CALL ZXFreeTempCompact
; 		1560.4  LET playerKeyMoveLeft=singleKey
	LD HL,(ZXBASIC_VAR_singleKey)
	LD (ZXBASIC_VAR_playerKeyMoveLeft),HL
ZXBASIC_LINE_1570:
; 1570  PRINT "Press Key FOR right ";: GO SUB 1450: PRINT  CHR$ (singleKey): LET playerKeyMoveRight=singleKey
; 		1570.1  PRINT "Press Key FOR right ";
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_2	;Press Key FOR right 
	CALL runtimePrintString
	POP AF
	LD (ZX_P_FLAG),A
; 		1570.2  GO SUB 1450{00 00 aa 05 00 }
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_1450
; 		1570.3  PRINT  CHR$ (singleKey)
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
; CHR$
	LD HL,(ZXBASIC_VAR_singleKey)
	CALL runtimeChr
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
	CALL ZXFreeTempCompact
; 		1570.4  LET playerKeyMoveRight=singleKey
	LD HL,(ZXBASIC_VAR_singleKey)
	LD (ZXBASIC_VAR_playerKeyMoveRight),HL
ZXBASIC_LINE_1580:
; 1580  PRINT "Press Key FOR up ";: GO SUB 1450: PRINT  CHR$ (singleKey): LET playerKeyMoveUp=singleKey
; 		1580.1  PRINT "Press Key FOR up ";
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_3	;Press Key FOR up 
	CALL runtimePrintString
	POP AF
	LD (ZX_P_FLAG),A
; 		1580.2  GO SUB 1450{00 00 aa 05 00 }
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_1450
; 		1580.3  PRINT  CHR$ (singleKey)
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
; CHR$
	LD HL,(ZXBASIC_VAR_singleKey)
	CALL runtimeChr
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
	CALL ZXFreeTempCompact
; 		1580.4  LET playerKeyMoveUp=singleKey
	LD HL,(ZXBASIC_VAR_singleKey)
	LD (ZXBASIC_VAR_playerKeyMoveUp),HL
ZXBASIC_LINE_1590:
; 1590  PRINT "Press Key FOR down ";: GO SUB 1450: PRINT  CHR$ (singleKey): LET playerKeyMoveDown=singleKey
; 		1590.1  PRINT "Press Key FOR down ";
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_4	;Press Key FOR down 
	CALL runtimePrintString
	POP AF
	LD (ZX_P_FLAG),A
; 		1590.2  GO SUB 1450{00 00 aa 05 00 }
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_1450
; 		1590.3  PRINT  CHR$ (singleKey)
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
; CHR$
	LD HL,(ZXBASIC_VAR_singleKey)
	CALL runtimeChr
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
	CALL ZXFreeTempCompact
; 		1590.4  LET playerKeyMoveDown=singleKey
	LD HL,(ZXBASIC_VAR_singleKey)
	LD (ZXBASIC_VAR_playerKeyMoveDown),HL
ZXBASIC_LINE_1600:
; 1600  PRINT "Press Key FOR fire ";: GO SUB 1450: PRINT  CHR$ (singleKey): LET playerKeyFire=singleKey
; 		1600.1  PRINT "Press Key FOR fire ";
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_5	;Press Key FOR fire 
	CALL runtimePrintString
	POP AF
	LD (ZX_P_FLAG),A
; 		1600.2  GO SUB 1450{00 00 aa 05 00 }
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_1450
; 		1600.3  PRINT  CHR$ (singleKey)
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
; CHR$
	LD HL,(ZXBASIC_VAR_singleKey)
	CALL runtimeChr
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
	CALL ZXFreeTempCompact
; 		1600.4  LET playerKeyFire=singleKey
	LD HL,(ZXBASIC_VAR_singleKey)
	LD (ZXBASIC_VAR_playerKeyFire),HL
ZXBASIC_LINE_1610:
; 1610  RETURN 
; 		1610.1  RETURN 
	CALL runtimeCheckBreak
	RET
ZXBASIC_LINE_1620:
; 1620  REM  SUB waitkeyrelease
ZXBASIC_LINE_1630:
; 1630  REM  -------------------
ZXBASIC_LINE_1640:
; 1640  LET PROCwaitkeyreleasea= CODE  INKEY$ 
; 		1640.1  LET PROCwaitkeyreleasea= CODE  INKEY$ 
; CODE
; INKEY$
	CALL runtimeInkey
	CALL runtimeCode
	LD (ZXBASIC_VAR_PROCwaitkeyreleasea),HL
	CALL ZXFreeTempCompact
ZXBASIC_LINE_1650:
; 1650  IF PROCwaitkeyreleasea=0 THEN  GOTO 1670
; 		1650.1  IF PROCwaitkeyreleasea=0{00 00 00 00 00 } THEN  GOTO 1670{00 00 86 06 00 }
	LD DE,(ZXBASIC_VAR_PROCwaitkeyreleasea)
	LD HL,0
; =
	CALL runtimeCmpHLEqDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_11
; 		1650.2  GOTO 1670{00 00 86 06 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_1670
ZXB_LABEL_11:
ZXBASIC_LINE_1660:
; 1660  GOTO 1640
; 		1660.1  GOTO 1640{00 00 68 06 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_1640
ZXBASIC_LINE_1670:
; 1670  RETURN 
; 		1670.1  RETURN 
	CALL runtimeCheckBreak
	RET
ZXBASIC_LINE_1680:
; 1680  REM  SUB newlevel
ZXBASIC_LINE_1690:
; 1690  REM  -------------
ZXBASIC_LINE_1700:
; 1700  CLS 
; 		1700.1  CLS 
	CALL runtimeCls
ZXBASIC_LINE_1710:
; 1710  GO SUB 3600
; 		1710.1  GO SUB 3600{00 00 10 0e 00 }
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_3600
ZXBASIC_LINE_1720:
; 1720  CLS 
; 		1720.1  CLS 
	CALL runtimeCls
ZXBASIC_LINE_1730:
; 1730  LET PROCdrawgrid0=gridw: LET PROCdrawgrid1=gridh: GO SUB 2950: GO SUB 2690
; 		1730.1  LET PROCdrawgrid0=gridw
	LD HL,(ZXBASIC_VAR_gridw)
	LD (ZXBASIC_VAR_PROCdrawgrid0),HL
; 		1730.2  LET PROCdrawgrid1=gridh
	LD HL,(ZXBASIC_VAR_gridh)
	LD (ZXBASIC_VAR_PROCdrawgrid1),HL
; 		1730.3  GO SUB 2950{00 00 86 0b 00 }
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_2950
; 		1730.4  GO SUB 2690{00 00 82 0a 00 }
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_2690
ZXBASIC_LINE_1740:
; 1740  RETURN 
; 		1740.1  RETURN 
	CALL runtimeCheckBreak
	RET
ZXBASIC_LINE_1750:
; 1750  REM  SUB initialscreen
ZXBASIC_LINE_1760:
; 1760  REM  ------------------
ZXBASIC_LINE_1770:
; 1770  PAPER 6: INK 2: BORDER 6
; 		1770.1  PAPER 6{00 00 06 00 00 }
	LD HL,6
	CALL runtimePaper
; 		1770.2  INK 2{00 00 02 00 00 }
	LD HL,2
	CALL runtimeInk
; 		1770.3  BORDER 6{00 00 06 00 00 }
	LD HL,6
	LD A,L
	call $2297
ZXBASIC_LINE_1780:
; 1780  CLS 
; 		1780.1  CLS 
	CALL runtimeCls
ZXBASIC_LINE_1790:
; 1790  PRINT "     \016\001\017\006\139\131\131\131\131\131\131\135"
; 		1790.1  PRINT "     \016\001\017\006\139\131\131\131\131\131\131\135"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_6	;     \016\001\017\006\139\131\131\131\131\131\131\135
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1800:
; 1800  PRINT "     \016\001\017\006\138\016\007\017\001MEMORY\016\001\017\006\133"
; 		1800.1  PRINT "     \016\001\017\006\138\016\007\017\001MEMORY\016\001\017\006\133"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_7	;     \016\001\017\006\138\016\007\017\001MEMORY\016\001\017\006\133
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1810:
; 1810  PRINT "     \016\001\017\006\142\140\140\140\140\140\140\141"
; 		1810.1  PRINT "     \016\001\017\006\142\140\140\140\140\140\140\141"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_8	;     \016\001\017\006\142\140\140\140\140\140\140\141
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1820:
; 1820  PRINT "        \016\001\017\006\133\138"
; 		1820.1  PRINT "        \016\001\017\006\133\138"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_9	;        \016\001\017\006\133\138
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1830:
; 1830  PRINT "       \016\001\017\006\143\143\143\143"
; 		1830.1  PRINT "       \016\001\017\006\143\143\143\143"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_10	;       \016\001\017\006\143\143\143\143
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1840:
; 1840  LET y=3
; 		1840.1  LET y=3{00 00 03 00 00 }
	LD HL,3
	LD (ZXBASIC_VAR_y),HL
ZXBASIC_LINE_1850:
; 1850  PRINT  AT y+5,4; INVERSE playerInputSelect=1;"1 = Keyboard";
; 		1850.1  PRINT  AT y+5{00 00 05 00 00 },4{00 00 04 00 00 }; INVERSE playerInputSelect=1{00 00 01 00 00 };"1 = Keyboard";
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,(ZXBASIC_VAR_y)
	LD HL,5
; +
	ADD HL,DE
	LD DE,HL
	LD HL,4
	CALL runtimePrintAt
	LD DE,(ZXBASIC_VAR_playerInputSelect)
	LD HL,1
; =
	CALL runtimeCmpHLEqDE
	CALL runtimeLocalInverse
	LD HL,STRING_11	;1 = Keyboard
	CALL runtimePrintString
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1860:
; 1860  PRINT  AT y+7,4; INVERSE playerInputSelect=2;"2 = Kempston";
; 		1860.1  PRINT  AT y+7{00 00 07 00 00 },4{00 00 04 00 00 }; INVERSE playerInputSelect=2{00 00 02 00 00 };"2 = Kempston";
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,(ZXBASIC_VAR_y)
	LD HL,7
; +
	ADD HL,DE
	LD DE,HL
	LD HL,4
	CALL runtimePrintAt
	LD DE,(ZXBASIC_VAR_playerInputSelect)
	LD HL,2
; =
	CALL runtimeCmpHLEqDE
	CALL runtimeLocalInverse
	LD HL,STRING_12	;2 = Kempston
	CALL runtimePrintString
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1870:
; 1870  PRINT  AT y+9,4; INVERSE playerInputSelect=3;"3 = Sinclair";
; 		1870.1  PRINT  AT y+9{00 00 09 00 00 },4{00 00 04 00 00 }; INVERSE playerInputSelect=3{00 00 03 00 00 };"3 = Sinclair";
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,(ZXBASIC_VAR_y)
	LD HL,9
; +
	ADD HL,DE
	LD DE,HL
	LD HL,4
	CALL runtimePrintAt
	LD DE,(ZXBASIC_VAR_playerInputSelect)
	LD HL,3
; =
	CALL runtimeCmpHLEqDE
	CALL runtimeLocalInverse
	LD HL,STRING_13	;3 = Sinclair
	CALL runtimePrintString
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1880:
; 1880  PRINT  AT y+11,4; INVERSE 0;"4 = Define keys"; AT y+13,4; INVERSE 0;"0 = Start";
; 		1880.1  PRINT  AT y+11{00 00 0b 00 00 },4{00 00 04 00 00 }; INVERSE 0{00 00 00 00 00 };"4 = Define keys"; AT y+13{00 00 0d 00 00 },4{00 00 04 00 00 }; INVERSE 0{00 00 00 00 00 };"0 = Start";
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,(ZXBASIC_VAR_y)
	LD HL,11
; +
	ADD HL,DE
	LD DE,HL
	LD HL,4
	CALL runtimePrintAt
	LD HL,0
	CALL runtimeLocalInverse
	LD HL,STRING_14	;4 = Define keys
	CALL runtimePrintString
	LD DE,(ZXBASIC_VAR_y)
	LD HL,13
; +
	ADD HL,DE
	LD DE,HL
	LD HL,4
	CALL runtimePrintAt
	LD HL,0
	CALL runtimeLocalInverse
	LD HL,STRING_15	;0 = Start
	CALL runtimePrintString
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1890:
; 1890  PRINT  AT y+15,4;"(C) 2025 Thomas Quester";
; 		1890.1  PRINT  AT y+15{00 00 0f 00 00 },4{00 00 04 00 00 };"(C) 2025 Thomas Quester";
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,(ZXBASIC_VAR_y)
	LD HL,15
; +
	ADD HL,DE
	LD DE,HL
	LD HL,4
	CALL runtimePrintAt
	LD HL,STRING_16	;(C) 2025 Thomas Quester
	CALL runtimePrintString
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1900:
; 1900  PRINT  AT y+16,0;"See https:/";"/github.com/tquester/ZXBasicCompiler";
; 		1900.1  PRINT  AT y+16{00 00 10 00 00 },0{00 00 00 00 00 };"See https
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,(ZXBASIC_VAR_y)
	LD HL,16
; +
	ADD HL,DE
	LD DE,HL
	LD HL,0
	CALL runtimePrintAt
	LD HL,STRING_17	;See https:/
	CALL runtimePrintString
	LD HL,STRING_18	;/github.com/tquester/ZXBasicCompiler
	CALL runtimePrintString
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1910:
; 1910  GO SUB 2590
; 		1910.1  GO SUB 2590{00 00 1e 0a 00 }
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_2590
ZXBASIC_LINE_1920:
; 1920  IF key <> 48 THEN  GOTO 1970
; 		1920.1  IF key <> 48{00 00 30 00 00 } THEN  GOTO 1970{00 00 b2 07 00 }
	LD DE,(ZXBASIC_VAR_key)
	LD HL,48
; <>
	CALL runtimeCmpHlNeDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_12
; 		1920.2  GOTO 1970{00 00 b2 07 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_1970
ZXB_LABEL_12:
ZXBASIC_LINE_1930:
; 1930  PAPER 5: BORDER 5: INK 7
; 		1930.1  PAPER 5{00 00 05 00 00 }
	LD HL,5
	CALL runtimePaper
; 		1930.2  BORDER 5{00 00 05 00 00 }
	LD HL,5
	LD A,L
	call $2297
; 		1930.3  INK 7{00 00 07 00 00 }
	LD HL,7
	CALL runtimeInk
ZXBASIC_LINE_1940:
; 1940  GO SUB 1680
; 		1940.1  GO SUB 1680{00 00 90 06 00 }
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_1680
ZXBASIC_LINE_1950:
; 1950  GO SUB 2120
; 		1950.1  GO SUB 2120{00 00 48 08 00 }
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_2120
ZXBASIC_LINE_1960:
; 1960  GOTO 2100
; 		1960.1  GOTO 2100{00 00 34 08 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_2100
ZXBASIC_LINE_1970:
; 1970  IF key <> 49 THEN  GOTO 2000
; 		1970.1  IF key <> 49{00 00 31 00 00 } THEN  GOTO 2000{00 00 d0 07 00 }
	LD DE,(ZXBASIC_VAR_key)
	LD HL,49
; <>
	CALL runtimeCmpHlNeDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_13
; 		1970.2  GOTO 2000{00 00 d0 07 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_2000
ZXB_LABEL_13:
ZXBASIC_LINE_1980:
; 1980  LET playerInputSelect=1
; 		1980.1  LET playerInputSelect=1{00 00 01 00 00 }
	LD HL,1
	LD (ZXBASIC_VAR_playerInputSelect),HL
ZXBASIC_LINE_1990:
; 1990  GOTO 2100
; 		1990.1  GOTO 2100{00 00 34 08 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_2100
ZXBASIC_LINE_2000:
; 2000  IF key <> 50 THEN  GOTO 2030
; 		2000.1  IF key <> 50{00 00 32 00 00 } THEN  GOTO 2030{00 00 ee 07 00 }
	LD DE,(ZXBASIC_VAR_key)
	LD HL,50
; <>
	CALL runtimeCmpHlNeDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_14
; 		2000.2  GOTO 2030{00 00 ee 07 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_2030
ZXB_LABEL_14:
ZXBASIC_LINE_2010:
; 2010  LET playerInputSelect=2
; 		2010.1  LET playerInputSelect=2{00 00 02 00 00 }
	LD HL,2
	LD (ZXBASIC_VAR_playerInputSelect),HL
ZXBASIC_LINE_2020:
; 2020  GOTO 2100
; 		2020.1  GOTO 2100{00 00 34 08 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_2100
ZXBASIC_LINE_2030:
; 2030  IF key <> 51 THEN  GOTO 2060
; 		2030.1  IF key <> 51{00 00 33 00 00 } THEN  GOTO 2060{00 00 0c 08 00 }
	LD DE,(ZXBASIC_VAR_key)
	LD HL,51
; <>
	CALL runtimeCmpHlNeDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_15
; 		2030.2  GOTO 2060{00 00 0c 08 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_2060
ZXB_LABEL_15:
ZXBASIC_LINE_2040:
; 2040  LET playerInputSelect=3
; 		2040.1  LET playerInputSelect=3{00 00 03 00 00 }
	LD HL,3
	LD (ZXBASIC_VAR_playerInputSelect),HL
ZXBASIC_LINE_2050:
; 2050  GOTO 2100
; 		2050.1  GOTO 2100{00 00 34 08 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_2100
ZXBASIC_LINE_2060:
; 2060  IF key <> 52 THEN  GOTO 2100
; 		2060.1  IF key <> 52{00 00 34 00 00 } THEN  GOTO 2100{00 00 34 08 00 }
	LD DE,(ZXBASIC_VAR_key)
	LD HL,52
; <>
	CALL runtimeCmpHlNeDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_16
; 		2060.2  GOTO 2100{00 00 34 08 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_2100
ZXB_LABEL_16:
ZXBASIC_LINE_2070:
; 2070  CLS 
; 		2070.1  CLS 
	CALL runtimeCls
ZXBASIC_LINE_2080:
; 2080  GO SUB 1540
; 		2080.1  GO SUB 1540{00 00 04 06 00 }
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_1540
ZXBASIC_LINE_2090:
; 2090  GOTO 2100
; 		2090.1  GOTO 2100{00 00 34 08 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_2100
ZXBASIC_LINE_2100:
; 2100  GOTO 1770
; 		2100.1  GOTO 1770{00 00 ea 06 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_1770
ZXBASIC_LINE_2110:
; 2110  RETURN 
; 		2110.1  RETURN 
	CALL runtimeCheckBreak
	RET
ZXBASIC_LINE_2120:
; 2120  REM  SUB game
ZXBASIC_LINE_2130:
; 2130  REM  ---------
ZXBASIC_LINE_2140:
; 2140  INK 0
; 		2140.1  INK 0{00 00 00 00 00 }
	LD HL,0
	CALL runtimeInk
ZXBASIC_LINE_2150:
; 2150  PRINT  AT 1,14;"M E M O R Y";
; 		2150.1  PRINT  AT 1{00 00 01 00 00 },14{00 00 0e 00 00 };"M E M O R Y";
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,1
	LD HL,14
	CALL runtimePrintAt
	LD HL,STRING_19	;M E M O R Y
	CALL runtimePrintString
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_2160:
; 2160  LET PROCselect0=playerx: LET PROCselect1=playery: GO SUB 3110
; 		2160.1  LET PROCselect0=playerx
	LD HL,(ZXBASIC_VAR_playerx)
	LD (ZXBASIC_VAR_PROCselect0),HL
; 		2160.2  LET PROCselect1=playery
	LD HL,(ZXBASIC_VAR_playery)
	LD (ZXBASIC_VAR_PROCselect1),HL
; 		2160.3  GO SUB 3110{00 00 26 0c 00 }
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_3110
ZXBASIC_LINE_2170:
; 2170  LET y=3
; 		2170.1  LET y=3{00 00 03 00 00 }
	LD HL,3
	LD (ZXBASIC_VAR_y),HL
ZXBASIC_LINE_2180:
; 2180  PRINT  AT 0,20;"sel=";numSelected;"  ";
; 		2180.1  PRINT  AT 0{00 00 00 00 00 },20{00 00 14 00 00 };"sel=";numSelected;"  ";
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,0
	LD HL,20
	CALL runtimePrintAt
	LD HL,STRING_20	;sel=
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_numSelected)
	CALL runtimePrintInt
	LD HL,STRING_21	;  
	CALL runtimePrintString
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_2190:
; 2190  PRINT  AT 3,23;"moves:";moves;" ";
; 		2190.1  PRINT  AT 3{00 00 03 00 00 },23{00 00 17 00 00 };"moves
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,3
	LD HL,23
	CALL runtimePrintAt
	LD HL,STRING_22	;moves:
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_moves)
	CALL runtimePrintInt
	LD HL,STRING_23	; 
	CALL runtimePrintString
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_2200:
; 2200  PRINT  AT 5,23;"found:";found;" ";
; 		2200.1  PRINT  AT 5{00 00 05 00 00 },23{00 00 17 00 00 };"found
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,5
	LD HL,23
	CALL runtimePrintAt
	LD HL,STRING_24	;found:
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_found)
	CALL runtimePrintInt
	LD HL,STRING_23	; 
	CALL runtimePrintString
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_2210:
; 2210  PRINT  AT 7,23; CHR$ (playerKeyMoveLeft); CHR$ (playerKeyMoveRight); CHR$ (playerKeyMoveUp); CHR$ (playerKeyMoveDown);"=MOVE";
; 		2210.1  PRINT  AT 7{00 00 07 00 00 },23{00 00 17 00 00 }; CHR$ (playerKeyMoveLeft); CHR$ (playerKeyMoveRight); CHR$ (playerKeyMoveUp); CHR$ (playerKeyMoveDown);"=MOVE";
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,7
	LD HL,23
	CALL runtimePrintAt
; CHR$
	LD HL,(ZXBASIC_VAR_playerKeyMoveLeft)
	CALL runtimeChr
	CALL runtimePrintString
; CHR$
	LD HL,(ZXBASIC_VAR_playerKeyMoveRight)
	CALL runtimeChr
	CALL runtimePrintString
; CHR$
	LD HL,(ZXBASIC_VAR_playerKeyMoveUp)
	CALL runtimeChr
	CALL runtimePrintString
; CHR$
	LD HL,(ZXBASIC_VAR_playerKeyMoveDown)
	CALL runtimeChr
	CALL runtimePrintString
	LD HL,STRING_25	;=MOVE
	CALL runtimePrintString
	POP AF
	LD (ZX_P_FLAG),A
	CALL ZXFreeTempCompact
ZXBASIC_LINE_2220:
; 2220  PRINT  AT 9,23;"ENTER=";
; 		2220.1  PRINT  AT 9{00 00 09 00 00 },23{00 00 17 00 00 };"ENTER=";
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,9
	LD HL,23
	CALL runtimePrintAt
	LD HL,STRING_26	;ENTER=
	CALL runtimePrintString
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_2230:
; 2230  PRINT  AT 10,23;"SELECT";
; 		2230.1  PRINT  AT 10{00 00 0a 00 00 },23{00 00 17 00 00 };"SELECT";
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,10
	LD HL,23
	CALL runtimePrintAt
	LD HL,STRING_27	;SELECT
	CALL runtimePrintString
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_2240:
; 2240  PRINT  AT 13,23;"Q=Quit";
; 		2240.1  PRINT  AT 13{00 00 0d 00 00 },23{00 00 17 00 00 };"Q=Quit";
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,13
	LD HL,23
	CALL runtimePrintAt
	LD HL,STRING_28	;Q=Quit
	CALL runtimePrintString
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_2250:
; 2250  PRINT  AT 15,23;"R=Restart";
; 		2250.1  PRINT  AT 15{00 00 0f 00 00 },23{00 00 17 00 00 };"R=Restart";
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,15
	LD HL,23
	CALL runtimePrintAt
	LD HL,STRING_29	;R=Restart
	CALL runtimePrintString
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_2260:
; 2260  GO SUB 1110
; 		2260.1  GO SUB 1110{00 00 56 04 00 }
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_1110
ZXBASIC_LINE_2270:
; 2270  PAUSE 3
; 		2270.1  PAUSE 3{00 00 03 00 00 }
	LD HL,3
	CALL runtimePause
ZXBASIC_LINE_2280:
; 2280  IF playerfire THEN  LET PROCunselect0=playerx: LET PROCunselect1=playery: GO SUB 3150: GO SUB 3320: GOTO 2170
; 		2280.1  IF playerfire THEN  LET PROCunselect0=playerx
	LD HL,(ZXBASIC_VAR_playerfire)
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_17
; 		2280.2  LET PROCunselect0=playerx
	LD HL,(ZXBASIC_VAR_playerx)
	LD (ZXBASIC_VAR_PROCunselect0),HL
; 		2280.3  LET PROCunselect1=playery
	LD HL,(ZXBASIC_VAR_playery)
	LD (ZXBASIC_VAR_PROCunselect1),HL
; 		2280.4  GO SUB 3150{00 00 4e 0c 00 }
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_3150
; 		2280.5  GO SUB 3320{00 00 f8 0c 00 }
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_3320
; 		2280.6  GOTO 2170{00 00 7a 08 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_2170
ZXB_LABEL_17:
ZXBASIC_LINE_2290:
; 2290  IF playerInputSelect <> 1 THEN  LET singleKey= CODE  INKEY$ 
; 		2290.1  IF playerInputSelect <> 1{00 00 01 00 00 } THEN  LET singleKey= CODE  INKEY$ 
	LD DE,(ZXBASIC_VAR_playerInputSelect)
	LD HL,1
; <>
	CALL runtimeCmpHlNeDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_18
; 		2290.2  LET singleKey= CODE  INKEY$ 
; CODE
; INKEY$
	CALL runtimeInkey
	CALL runtimeCode
	LD (ZXBASIC_VAR_singleKey),HL
	CALL ZXFreeTempCompact
ZXB_LABEL_18:
	CALL ZXFreeTempCompact
ZXBASIC_LINE_2300:
; 2300  IF  NOT (singleKey <> 0) THEN  GOTO 2500
; 		2300.1  IF  NOT (singleKey <> 0{00 00 00 00 00 }) THEN  GOTO 2500{00 00 c4 09 00 }
; NOT
	LD DE,(ZXBASIC_VAR_singleKey)
	LD HL,0
; <>
	CALL runtimeCmpHlNeDE
	CALL runtimeNotHL
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_19
; 		2300.2  GOTO 2500{00 00 c4 09 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_2500
ZXB_LABEL_19:
ZXBASIC_LINE_2310:
; 2310  PRINT  AT 19,24;"key=";singleKey;"  ";
; 		2310.1  PRINT  AT 19{00 00 13 00 00 },24{00 00 18 00 00 };"key=";singleKey;"  ";
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,19
	LD HL,24
	CALL runtimePrintAt
	LD HL,STRING_30	;key=
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_singleKey)
	CALL runtimePrintInt
	LD HL,STRING_21	;  
	CALL runtimePrintString
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_2320:
; 2320  IF singleKey <> 13 THEN  GOTO 2360
; 		2320.1  IF singleKey <> 13{00 00 0d 00 00 } THEN  GOTO 2360{00 00 38 09 00 }
	LD DE,(ZXBASIC_VAR_singleKey)
	LD HL,13
; <>
	CALL runtimeCmpHlNeDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_20
; 		2320.2  GOTO 2360{00 00 38 09 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_2360
ZXB_LABEL_20:
ZXBASIC_LINE_2330:
; 2330  LET PROCunselect0=playerx: LET PROCunselect1=playery: GO SUB 3150
; 		2330.1  LET PROCunselect0=playerx
	LD HL,(ZXBASIC_VAR_playerx)
	LD (ZXBASIC_VAR_PROCunselect0),HL
; 		2330.2  LET PROCunselect1=playery
	LD HL,(ZXBASIC_VAR_playery)
	LD (ZXBASIC_VAR_PROCunselect1),HL
; 		2330.3  GO SUB 3150{00 00 4e 0c 00 }
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_3150
ZXBASIC_LINE_2340:
; 2340  GO SUB 3320
; 		2340.1  GO SUB 3320{00 00 f8 0c 00 }
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_3320
ZXBASIC_LINE_2350:
; 2350  GOTO 2170
; 		2350.1  GOTO 2170{00 00 7a 08 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_2170
ZXBASIC_LINE_2360:
; 2360  IF singleKey <> 103 THEN  GOTO 2440
; 		2360.1  IF singleKey <> 103{00 00 67 00 00 } THEN  GOTO 2440{00 00 88 09 00 }
	LD DE,(ZXBASIC_VAR_singleKey)
	LD HL,103
; <>
	CALL runtimeCmpHlNeDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_21
; 		2360.2  GOTO 2440{00 00 88 09 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_2440
ZXB_LABEL_21:
ZXBASIC_LINE_2370:
; 2370  CLS 
; 		2370.1  CLS 
	CALL runtimeCls
ZXBASIC_LINE_2380:
; 2380  GO SUB 3720
; 		2380.1  GO SUB 3720{00 00 88 0e 00 }
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_3720
ZXBASIC_LINE_2390:
; 2390  PAUSE 0
; 		2390.1  PAUSE 0{00 00 00 00 00 }
	LD HL,0
	CALL runtimePause
ZXBASIC_LINE_2400:
; 2400  CLS 
; 		2400.1  CLS 
	CALL runtimeCls
ZXBASIC_LINE_2410:
; 2410  LET PROCdrawgrid0=gridw: LET PROCdrawgrid1=gridh: GO SUB 2950
; 		2410.1  LET PROCdrawgrid0=gridw
	LD HL,(ZXBASIC_VAR_gridw)
	LD (ZXBASIC_VAR_PROCdrawgrid0),HL
; 		2410.2  LET PROCdrawgrid1=gridh
	LD HL,(ZXBASIC_VAR_gridh)
	LD (ZXBASIC_VAR_PROCdrawgrid1),HL
; 		2410.3  GO SUB 2950{00 00 86 0b 00 }
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_2950
ZXBASIC_LINE_2420:
; 2420  GOTO 2170
; 		2420.1  GOTO 2170{00 00 7a 08 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_2170
ZXBASIC_LINE_2430:
; 2430  GOTO 2490
; 		2430.1  GOTO 2490{00 00 ba 09 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_2490
ZXBASIC_LINE_2440:
; 2440  IF singleKey <> 113 THEN  GOTO 2460
; 		2440.1  IF singleKey <> 113{00 00 71 00 00 } THEN  GOTO 2460{00 00 9c 09 00 }
	LD DE,(ZXBASIC_VAR_singleKey)
	LD HL,113
; <>
	CALL runtimeCmpHlNeDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_22
; 		2440.2  GOTO 2460{00 00 9c 09 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_2460
ZXB_LABEL_22:
ZXBASIC_LINE_2450:
; 2450  RETURN 
; 		2450.1  RETURN 
	CALL runtimeCheckBreak
	RET
ZXBASIC_LINE_2460:
; 2460  IF singleKey <> 114 THEN  GOTO 2490
; 		2460.1  IF singleKey <> 114{00 00 72 00 00 } THEN  GOTO 2490{00 00 ba 09 00 }
	LD DE,(ZXBASIC_VAR_singleKey)
	LD HL,114
; <>
	CALL runtimeCmpHlNeDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_23
; 		2460.2  GOTO 2490{00 00 ba 09 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_2490
ZXB_LABEL_23:
ZXBASIC_LINE_2470:
; 2470  CLS 
; 		2470.1  CLS 
	CALL runtimeCls
ZXBASIC_LINE_2480:
; 2480  GO SUB 1680
; 		2480.1  GO SUB 1680{00 00 90 06 00 }
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_1680
ZXBASIC_LINE_2490:
; 2490  LET singleKey=0
; 		2490.1  LET singleKey=0{00 00 00 00 00 }
	LD HL,0
	LD (ZXBASIC_VAR_singleKey),HL
ZXBASIC_LINE_2500:
; 2500  IF playermoved=0 THEN  GOTO 2170
; 		2500.1  IF playermoved=0{00 00 00 00 00 } THEN  GOTO 2170{00 00 7a 08 00 }
	LD DE,(ZXBASIC_VAR_playermoved)
	LD HL,0
; =
	CALL runtimeCmpHLEqDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_24
; 		2500.2  GOTO 2170{00 00 7a 08 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_2170
ZXB_LABEL_24:
ZXBASIC_LINE_2510:
; 2510  LET PROCunselect0=playerxold: LET PROCunselect1=playeryold: GO SUB 3150
; 		2510.1  LET PROCunselect0=playerxold
	LD HL,(ZXBASIC_VAR_playerxold)
	LD (ZXBASIC_VAR_PROCunselect0),HL
; 		2510.2  LET PROCunselect1=playeryold
	LD HL,(ZXBASIC_VAR_playeryold)
	LD (ZXBASIC_VAR_PROCunselect1),HL
; 		2510.3  GO SUB 3150{00 00 4e 0c 00 }
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_3150
ZXBASIC_LINE_2520:
; 2520  IF playerx<1 THEN  LET playerx=0
; 		2520.1  IF playerx<1{00 00 01 00 00 } THEN  LET playerx=0{00 00 00 00 00 }
	LD DE,(ZXBASIC_VAR_playerx)
	LD HL,1
; <
	CALL runtimeCmpHLltDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_25
; 		2520.2  LET playerx=0{00 00 00 00 00 }
	LD HL,0
	LD (ZXBASIC_VAR_playerx),HL
ZXB_LABEL_25:
ZXBASIC_LINE_2530:
; 2530  IF playerx>(gridw-1) THEN  LET playerx=gridw-1
; 		2530.1  IF playerx>(gridw-1{00 00 01 00 00 }) THEN  LET playerx=gridw-1{00 00 01 00 00 }
	LD HL,(ZXBASIC_VAR_playerx)
	PUSH HL
; (
	LD HL,(ZXBASIC_VAR_gridw)
	LD DE,1
; -
	SUB HL,DE
; )
; >
	POP DE
	CALL runtimeCmpHlGtDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_26
; 		2530.2  LET playerx=gridw-1{00 00 01 00 00 }
	LD HL,(ZXBASIC_VAR_gridw)
	LD DE,1
; -
	SUB HL,DE
	LD (ZXBASIC_VAR_playerx),HL
ZXB_LABEL_26:
ZXBASIC_LINE_2540:
; 2540  IF playery<1 THEN  LET playery=0
; 		2540.1  IF playery<1{00 00 01 00 00 } THEN  LET playery=0{00 00 00 00 00 }
	LD DE,(ZXBASIC_VAR_playery)
	LD HL,1
; <
	CALL runtimeCmpHLltDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_27
; 		2540.2  LET playery=0{00 00 00 00 00 }
	LD HL,0
	LD (ZXBASIC_VAR_playery),HL
ZXB_LABEL_27:
ZXBASIC_LINE_2550:
; 2550  IF playery>(gridh-1) THEN  LET playery=gridh-1
; 		2550.1  IF playery>(gridh-1{00 00 01 00 00 }) THEN  LET playery=gridh-1{00 00 01 00 00 }
	LD HL,(ZXBASIC_VAR_playery)
	PUSH HL
; (
	LD HL,(ZXBASIC_VAR_gridh)
	LD DE,1
; -
	SUB HL,DE
; )
; >
	POP DE
	CALL runtimeCmpHlGtDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_28
; 		2550.2  LET playery=gridh-1{00 00 01 00 00 }
	LD HL,(ZXBASIC_VAR_gridh)
	LD DE,1
; -
	SUB HL,DE
	LD (ZXBASIC_VAR_playery),HL
ZXB_LABEL_28:
ZXBASIC_LINE_2560:
; 2560  LET PROCselect0=playerx: LET PROCselect1=playery: GO SUB 3110
; 		2560.1  LET PROCselect0=playerx
	LD HL,(ZXBASIC_VAR_playerx)
	LD (ZXBASIC_VAR_PROCselect0),HL
; 		2560.2  LET PROCselect1=playery
	LD HL,(ZXBASIC_VAR_playery)
	LD (ZXBASIC_VAR_PROCselect1),HL
; 		2560.3  GO SUB 3110{00 00 26 0c 00 }
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_3110
ZXBASIC_LINE_2570:
; 2570  GOTO 2170
; 		2570.1  GOTO 2170{00 00 7a 08 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_2170
ZXBASIC_LINE_2580:
; 2580  RETURN 
; 		2580.1  RETURN 
	CALL runtimeCheckBreak
	RET
ZXBASIC_LINE_2590:
; 2590  REM  SUB waitkey
ZXBASIC_LINE_2600:
; 2600  REM  ------------
ZXBASIC_LINE_2610:
; 2610  GO SUB 3830
; 		2610.1  GO SUB 3830{00 00 f6 0e 00 }
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_3830
ZXBASIC_LINE_2620:
; 2620  LET key= CODE  INKEY$ 
; 		2620.1  LET key= CODE  INKEY$ 
; CODE
; INKEY$
	CALL runtimeInkey
	CALL runtimeCode
	LD (ZXBASIC_VAR_key),HL
	CALL ZXFreeTempCompact
ZXBASIC_LINE_2630:
; 2630  IF key <> 0 THEN  GOTO 2650
; 		2630.1  IF key <> 0{00 00 00 00 00 } THEN  GOTO 2650{00 00 5a 0a 00 }
	LD DE,(ZXBASIC_VAR_key)
	LD HL,0
; <>
	CALL runtimeCmpHlNeDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_29
; 		2630.2  GOTO 2650{00 00 5a 0a 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_2650
ZXB_LABEL_29:
ZXBASIC_LINE_2640:
; 2640  GOTO 2610
; 		2640.1  GOTO 2610{00 00 32 0a 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_2610
ZXBASIC_LINE_2650:
; 2650  LET key2= CODE  INKEY$ 
; 		2650.1  LET key2= CODE  INKEY$ 
; CODE
; INKEY$
	CALL runtimeInkey
	CALL runtimeCode
	LD (ZXBASIC_VAR_key2),HL
	CALL ZXFreeTempCompact
ZXBASIC_LINE_2660:
; 2660  IF key2=0 THEN  GOTO 2680
; 		2660.1  IF key2=0{00 00 00 00 00 } THEN  GOTO 2680{00 00 78 0a 00 }
	LD DE,(ZXBASIC_VAR_key2)
	LD HL,0
; =
	CALL runtimeCmpHLEqDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_30
; 		2660.2  GOTO 2680{00 00 78 0a 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_2680
ZXB_LABEL_30:
ZXBASIC_LINE_2670:
; 2670  GOTO 2650
; 		2670.1  GOTO 2650{00 00 5a 0a 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_2650
ZXBASIC_LINE_2680:
; 2680  RETURN 
; 		2680.1  RETURN 
	CALL runtimeCheckBreak
	RET
ZXBASIC_LINE_2690:
; 2690  REM  SUB initgrid
ZXBASIC_LINE_2700:
; 2700  REM  -------------
ZXBASIC_LINE_2710:
; 2710  LET found=0
; 		2710.1  LET found=0{00 00 00 00 00 }
	LD HL,0
	LD (ZXBASIC_VAR_found),HL
ZXBASIC_LINE_2720:
; 2720  PRINT  AT 2,0;"Mixing cards ";
; 		2720.1  PRINT  AT 2{00 00 02 00 00 },0{00 00 00 00 00 };"Mixing cards ";
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,2
	LD HL,0
	CALL runtimePrintAt
	LD HL,STRING_31	;Mixing cards 
	CALL runtimePrintString
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_2730:
; 2730  FOR x=1 TO gridw
; 		2730.1  FOR x=1{00 00 01 00 00 } TO gridw
	CALL runtimeCheckBreak
	LD HL,1
	LD (ZXBASIC_VAR_x),HL
	LD HL,(ZXBASIC_VAR_gridw)
	LD (ZXBASIC_VAR_for_x),HL
FOR_0:
ZXBASIC_LINE_2740:
; 2740  FOR y=1 TO gridh
; 		2740.1  FOR y=1{00 00 01 00 00 } TO gridh
	CALL runtimeCheckBreak
	LD HL,1
	LD (ZXBASIC_VAR_y),HL
	LD HL,(ZXBASIC_VAR_gridh)
	LD (ZXBASIC_VAR_for_y),HL
FOR_1:
ZXBASIC_LINE_2750:
; 2750  LET o(x,y)=0
; 		2750.1  LET o(x,y)=0{00 00 00 00 00 }
	LD HL,(ZXBASIC_VAR_x)
	LD DE,9
	CALL runtimeMult16bit
	LD DE,HL
	LD HL,(ZXBASIC_VAR_y)
	ADD HL,DE
	ADD HL,HL
	PUSH HL
	LD DE,0
	POP HL
	LD BC,ZXBASIC_VAR_o_array
	ADD HL,BC
	LD (HL),DE
ZXBASIC_LINE_2760:
; 2760  NEXT y
; 		2760.1  NEXT y
	CALL runtimeCheckBreak
	LD HL,(ZXBASIC_VAR_y)
	INC HL
	LD (ZXBASIC_VAR_y),HL
	LD DE,(ZXBASIC_VAR_for_y)
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_1
ZXBASIC_LINE_2770:
; 2770  NEXT x
; 		2770.1  NEXT x
	CALL runtimeCheckBreak
	LD HL,(ZXBASIC_VAR_x)
	INC HL
	LD (ZXBASIC_VAR_x),HL
	LD DE,(ZXBASIC_VAR_for_x)
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_0
ZXBASIC_LINE_2780:
; 2780  LET x=1
; 		2780.1  LET x=1{00 00 01 00 00 }
	LD HL,1
	LD (ZXBASIC_VAR_x),HL
ZXBASIC_LINE_2790:
; 2790  LET y=1
; 		2790.1  LET y=1{00 00 01 00 00 }
	LD (ZXBASIC_VAR_y),HL
ZXBASIC_LINE_2800:
; 2800  FOR i=1 TO 2
; 		2800.1  FOR i=1{00 00 01 00 00 } TO 2{00 00 02 00 00 }
	CALL runtimeCheckBreak
	LD HL,1
	LD (ZXBASIC_VAR_i),HL
	LD HL,2
	LD (ZXBASIC_VAR_for_i),HL
FOR_2:
ZXBASIC_LINE_2810:
; 2810  FOR j=144 TO 161
; 		2810.1  FOR j=144{00 00 90 00 00 } TO 161{00 00 a1 00 00 }
	CALL runtimeCheckBreak
	LD HL,144
	LD (ZXBASIC_VAR_j),HL
	LD HL,161
	LD (ZXBASIC_VAR_for_j),HL
FOR_3:
ZXBASIC_LINE_2820:
; 2820  LET g(x,y)=j: LET x=x+1: IF x>gridw THEN  LET x=1: LET y=y+1
; 		2820.1  LET g(x,y)=j
	LD HL,(ZXBASIC_VAR_x)
	LD DE,9
	CALL runtimeMult16bit
	LD DE,HL
	LD HL,(ZXBASIC_VAR_y)
	ADD HL,DE
	ADD HL,HL
	PUSH HL
	LD DE,(ZXBASIC_VAR_j)
	POP HL
	LD BC,ZXBASIC_VAR_g_array
	ADD HL,BC
	LD (HL),DE
; 		2820.2  LET x=x+1{00 00 01 00 00 }
	LD HL,(ZXBASIC_VAR_x)
	INC HL
; +
	LD (ZXBASIC_VAR_x),HL
; 		2820.3  IF x>gridw THEN  LET x=1{00 00 01 00 00 }
	LD DE,(ZXBASIC_VAR_x)
	LD HL,(ZXBASIC_VAR_gridw)
; >
	CALL runtimeCmpHlGtDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_31
; 		2820.4  LET x=1{00 00 01 00 00 }
	LD HL,1
	LD (ZXBASIC_VAR_x),HL
; 		2820.5  LET y=y+1{00 00 01 00 00 }
	LD HL,(ZXBASIC_VAR_y)
	INC HL
; +
	LD (ZXBASIC_VAR_y),HL
ZXB_LABEL_31:
ZXBASIC_LINE_2830:
; 2830  NEXT j
; 		2830.1  NEXT j
	CALL runtimeCheckBreak
	LD HL,(ZXBASIC_VAR_j)
	INC HL
	LD (ZXBASIC_VAR_j),HL
	LD DE,(ZXBASIC_VAR_for_j)
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_3
ZXBASIC_LINE_2840:
; 2840  NEXT i
; 		2840.1  NEXT i
	CALL runtimeCheckBreak
	LD HL,(ZXBASIC_VAR_i)
	INC HL
	LD (ZXBASIC_VAR_i),HL
	LD DE,(ZXBASIC_VAR_for_i)
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_2
ZXBASIC_LINE_2850:
; 2850  LET PROCinitgridw=gridw-1
; 		2850.1  LET PROCinitgridw=gridw-1{00 00 01 00 00 }
	LD HL,(ZXBASIC_VAR_gridw)
	LD DE,1
; -
	SUB HL,DE
	LD (ZXBASIC_VAR_PROCinitgridw),HL
ZXBASIC_LINE_2860:
; 2860  LET PROCinitgridh=gridw-1
; 		2860.1  LET PROCinitgridh=gridw-1{00 00 01 00 00 }
	LD HL,(ZXBASIC_VAR_gridw)
	LD DE,1
; -
	SUB HL,DE
	LD (ZXBASIC_VAR_PROCinitgridh),HL
ZXBASIC_LINE_2870:
; 2870  FOR i=1 TO 25
; 		2870.1  FOR i=1{00 00 01 00 00 } TO 25{00 00 19 00 00 }
	CALL runtimeCheckBreak
	LD HL,1
	LD (ZXBASIC_VAR_i),HL
	LD HL,25
	LD (ZXBASIC_VAR_for_i),HL
FOR_4:
ZXBASIC_LINE_2880:
; 2880  LET x1= INT ( RND *PROCinitgridw)+1: LET y1= INT ( RND *PROCinitgridh)+1
; 		2880.1  LET x1= INT ( RND *PROCinitgridw)+1{00 00 01 00 00 }
; INT
; RND
	CALL runtimeRND
	LD HL,(ZXBASIC_VAR_PROCinitgridw)
; *
	CALL runtimeIntToFloat
	RST $28
	DB $04	;MULT
	DB $38	;END CALC
	CALL runtimeFloatToInt
	INC HL
; +
	LD (ZXBASIC_VAR_x1),HL
; 		2880.2  LET y1= INT ( RND *PROCinitgridh)+1{00 00 01 00 00 }
; INT
; RND
	CALL runtimeRND
	LD HL,(ZXBASIC_VAR_PROCinitgridh)
; *
	CALL runtimeIntToFloat
	RST $28
	DB $04	;MULT
	DB $38	;END CALC
	CALL runtimeFloatToInt
	INC HL
; +
	LD (ZXBASIC_VAR_y1),HL
ZXBASIC_LINE_2890:
; 2890  LET x2= INT ( RND *PROCinitgridw)+1: LET y2= INT ( RND *PROCinitgridh)+1: IF x1 <> x2 OR y1 <> y2 THEN  GOTO 2910
; 		2890.1  LET x2= INT ( RND *PROCinitgridw)+1{00 00 01 00 00 }
; INT
; RND
	CALL runtimeRND
	LD HL,(ZXBASIC_VAR_PROCinitgridw)
; *
	CALL runtimeIntToFloat
	RST $28
	DB $04	;MULT
	DB $38	;END CALC
	CALL runtimeFloatToInt
	INC HL
; +
	LD (ZXBASIC_VAR_x2),HL
; 		2890.2  LET y2= INT ( RND *PROCinitgridh)+1{00 00 01 00 00 }
; INT
; RND
	CALL runtimeRND
	LD HL,(ZXBASIC_VAR_PROCinitgridh)
; *
	CALL runtimeIntToFloat
	RST $28
	DB $04	;MULT
	DB $38	;END CALC
	CALL runtimeFloatToInt
	INC HL
; +
	LD (ZXBASIC_VAR_y2),HL
; 		2890.3  IF x1 <> x2 OR y1 <> y2 THEN  GOTO 2910{00 00 5e 0b 00 }
	LD DE,(ZXBASIC_VAR_x1)
	LD HL,(ZXBASIC_VAR_x2)
; <>
	CALL runtimeCmpHlNeDE
	PUSH HL
	LD DE,(ZXBASIC_VAR_y1)
	LD HL,(ZXBASIC_VAR_y2)
; <>
	CALL runtimeCmpHlNeDE
; OR
	POP DE
	call runtimeOrHLDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_32
; 		2890.4  GOTO 2910{00 00 5e 0b 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_2910
ZXB_LABEL_32:
ZXBASIC_LINE_2900:
; 2900  GOTO 2890
; 		2900.1  GOTO 2890{00 00 4a 0b 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_2890
ZXBASIC_LINE_2910:
; 2910  PRINT  AT 2,0;"Mixing cards ";i;: LET t=g(x1,y1): LET g(x1,y1)=g(x2,y2): LET g(x2,y2)=t
; 		2910.1  PRINT  AT 2{00 00 02 00 00 },0{00 00 00 00 00 };"Mixing cards ";i;
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,2
	LD HL,0
	CALL runtimePrintAt
	LD HL,STRING_31	;Mixing cards 
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_i)
	CALL runtimePrintInt
	POP AF
	LD (ZX_P_FLAG),A
; 		2910.2  LET t=g(x1,y1)
; Array-Access
	LD HL,(ZXBASIC_VAR_x1)
	LD DE,9
	CALL runtimeMult16bit
	LD DE,HL
	LD HL,(ZXBASIC_VAR_y1)
	ADD HL,DE
	ADD HL,HL
	LD DE, ZXBASIC_VAR_g_array
	ADD HL,DE
	LD DE,(HL)
	LD HL,DE
	LD (ZXBASIC_VAR_t),HL
; 		2910.3  LET g(x1,y1)=g(x2,y2)
	LD HL,(ZXBASIC_VAR_x1)
	LD DE,9
	CALL runtimeMult16bit
	LD DE,HL
	LD HL,(ZXBASIC_VAR_y1)
	ADD HL,DE
	ADD HL,HL
	PUSH HL
; Array-Access
	LD HL,(ZXBASIC_VAR_x2)
	LD DE,9
	CALL runtimeMult16bit
	LD DE,HL
	LD HL,(ZXBASIC_VAR_y2)
	ADD HL,DE
	ADD HL,HL
	LD DE, ZXBASIC_VAR_g_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	POP DE
	POP HL
	LD BC,ZXBASIC_VAR_g_array
	ADD HL,BC
	LD (HL),DE
; 		2910.4  LET g(x2,y2)=t
	LD HL,(ZXBASIC_VAR_x2)
	LD DE,9
	CALL runtimeMult16bit
	LD DE,HL
	LD HL,(ZXBASIC_VAR_y2)
	ADD HL,DE
	ADD HL,HL
	PUSH HL
	LD DE,(ZXBASIC_VAR_t)
	POP HL
	LD BC,ZXBASIC_VAR_g_array
	ADD HL,BC
	LD (HL),DE
ZXBASIC_LINE_2920:
; 2920  NEXT i
; 		2920.1  NEXT i
	CALL runtimeCheckBreak
	LD HL,(ZXBASIC_VAR_i)
	INC HL
	LD (ZXBASIC_VAR_i),HL
	LD DE,(ZXBASIC_VAR_for_i)
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_4
ZXBASIC_LINE_2930:
; 2930  PRINT  AT 2,0;"                           ";
; 		2930.1  PRINT  AT 2{00 00 02 00 00 },0{00 00 00 00 00 };"                           ";
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,2
	LD HL,0
	CALL runtimePrintAt
	LD HL,STRING_32	;                           
	CALL runtimePrintString
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_2940:
; 2940  RETURN 
; 		2940.1  RETURN 
	CALL runtimeCheckBreak
	RET
ZXBASIC_LINE_2950:
; 2950  REM  SUB drawgrid(0=sizex, 1=sizey)
ZXBASIC_LINE_2960:
; 2960  REM  -------------------------------
ZXBASIC_LINE_2970:
; 2970  LET PROCdrawgridx=0
; 		2970.1  LET PROCdrawgridx=0{00 00 00 00 00 }
	LD HL,0
	LD (ZXBASIC_VAR_PROCdrawgridx),HL
ZXBASIC_LINE_2980:
; 2980  LET PROCdrawgridcolor=1
; 		2980.1  LET PROCdrawgridcolor=1{00 00 01 00 00 }
	LD HL,1
	LD (ZXBASIC_VAR_PROCdrawgridcolor),HL
ZXBASIC_LINE_2990:
; 2990  LET PROCdrawgridrowcolor=1
; 		2990.1  LET PROCdrawgridrowcolor=1{00 00 01 00 00 }
	LD (ZXBASIC_VAR_PROCdrawgridrowcolor),HL
ZXBASIC_LINE_3000:
; 3000  IF  NOT (PROCdrawgridx<PROCdrawgrid0) THEN  GOTO 3100
; 		3000.1  IF  NOT (PROCdrawgridx<PROCdrawgrid0) THEN  GOTO 3100{00 00 1c 0c 00 }
; NOT
	LD DE,(ZXBASIC_VAR_PROCdrawgridx)
	LD HL,(ZXBASIC_VAR_PROCdrawgrid0)
; <
	CALL runtimeCmpHLltDE
	CALL runtimeNotHL
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_33
; 		3000.2  GOTO 3100{00 00 1c 0c 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_3100
ZXB_LABEL_33:
ZXBASIC_LINE_3010:
; 3010  LET PROCdrawgridy=0
; 		3010.1  LET PROCdrawgridy=0{00 00 00 00 00 }
	LD HL,0
	LD (ZXBASIC_VAR_PROCdrawgridy),HL
ZXBASIC_LINE_3020:
; 3020  LET PROCdrawgridcolor=PROCdrawgridrowcolor
; 		3020.1  LET PROCdrawgridcolor=PROCdrawgridrowcolor
	LD HL,(ZXBASIC_VAR_PROCdrawgridrowcolor)
	LD (ZXBASIC_VAR_PROCdrawgridcolor),HL
ZXBASIC_LINE_3030:
; 3030  LET PROCdrawgridrowcolor=PROCdrawgridrowcolor+1
; 		3030.1  LET PROCdrawgridrowcolor=PROCdrawgridrowcolor+1{00 00 01 00 00 }
	INC HL
; +
	LD (ZXBASIC_VAR_PROCdrawgridrowcolor),HL
ZXBASIC_LINE_3040:
; 3040  IF PROCdrawgridrowcolor=3 THEN  LET PROCdrawgridrowcolor=1
; 		3040.1  IF PROCdrawgridrowcolor=3{00 00 03 00 00 } THEN  LET PROCdrawgridrowcolor=1{00 00 01 00 00 }
	LD DE,(ZXBASIC_VAR_PROCdrawgridrowcolor)
	LD HL,3
; =
	CALL runtimeCmpHLEqDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_34
; 		3040.2  LET PROCdrawgridrowcolor=1{00 00 01 00 00 }
	LD HL,1
	LD (ZXBASIC_VAR_PROCdrawgridrowcolor),HL
ZXB_LABEL_34:
ZXBASIC_LINE_3050:
; 3050  IF  NOT (PROCdrawgridy<PROCdrawgrid1) THEN  GOTO 3080
; 		3050.1  IF  NOT (PROCdrawgridy<PROCdrawgrid1) THEN  GOTO 3080{00 00 08 0c 00 }
; NOT
	LD DE,(ZXBASIC_VAR_PROCdrawgridy)
	LD HL,(ZXBASIC_VAR_PROCdrawgrid1)
; <
	CALL runtimeCmpHLltDE
	CALL runtimeNotHL
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_35
; 		3050.2  GOTO 3080{00 00 08 0c 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_3080
ZXB_LABEL_35:
ZXBASIC_LINE_3060:
; 3060  LET ax=fieldx+PROCdrawgridx+PROCdrawgridx+PROCdrawgridx: LET ay=fieldy+PROCdrawgridy+PROCdrawgridy+PROCdrawgridy: PRINT  AT ay,ax; PAPER PROCdrawgridcolor;"   "; AT ay+1,ax;"   "; AT ay+2,ax;"   ";: LET PROCdrawgridy=PROCdrawgridy+1: LET PROCdrawgridcolor=PROCdrawgridcolor+1: IF PROCdrawgridcolor=3 THEN  LET PROCdrawgridcolor=1
; 		3060.1  LET ax=fieldx+PROCdrawgridx+PROCdrawgridx+PROCdrawgridx
	LD DE,(ZXBASIC_VAR_fieldx)
	LD HL,(ZXBASIC_VAR_PROCdrawgridx)
; +
	ADD HL,DE
	LD DE,HL
	LD HL,(ZXBASIC_VAR_PROCdrawgridx)
; +
	ADD HL,DE
	LD DE,HL
	LD HL,(ZXBASIC_VAR_PROCdrawgridx)
; +
	ADD HL,DE
	LD (ZXBASIC_VAR_ax),HL
; 		3060.2  LET ay=fieldy+PROCdrawgridy+PROCdrawgridy+PROCdrawgridy
	LD DE,(ZXBASIC_VAR_fieldy)
	LD HL,(ZXBASIC_VAR_PROCdrawgridy)
; +
	ADD HL,DE
	LD DE,HL
	LD HL,(ZXBASIC_VAR_PROCdrawgridy)
; +
	ADD HL,DE
	LD DE,HL
	LD HL,(ZXBASIC_VAR_PROCdrawgridy)
; +
	ADD HL,DE
	LD (ZXBASIC_VAR_ay),HL
; 		3060.3  PRINT  AT ay,ax; PAPER PROCdrawgridcolor;"   "; AT ay+1{00 00 01 00 00 },ax;"   "; AT ay+2{00 00 02 00 00 },ax;"   ";
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,(ZXBASIC_VAR_ay)
	LD HL,(ZXBASIC_VAR_ax)
	CALL runtimePrintAt
	LD HL,(ZXBASIC_VAR_PROCdrawgridcolor)
	CALL runtimeLocalPaper
	LD HL,STRING_33	;   
	CALL runtimePrintString
	LD DE,(ZXBASIC_VAR_ay)
	LD HL,1
; +
	ADD HL,DE
	LD DE,HL
	LD HL,(ZXBASIC_VAR_ax)
	CALL runtimePrintAt
	LD HL,STRING_33	;   
	CALL runtimePrintString
	LD DE,(ZXBASIC_VAR_ay)
	LD HL,2
; +
	ADD HL,DE
	LD DE,HL
	LD HL,(ZXBASIC_VAR_ax)
	CALL runtimePrintAt
	LD HL,STRING_33	;   
	CALL runtimePrintString
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
; 		3060.4  LET PROCdrawgridy=PROCdrawgridy+1{00 00 01 00 00 }
	LD HL,(ZXBASIC_VAR_PROCdrawgridy)
	INC HL
; +
	LD (ZXBASIC_VAR_PROCdrawgridy),HL
; 		3060.5  LET PROCdrawgridcolor=PROCdrawgridcolor+1{00 00 01 00 00 }
	LD HL,(ZXBASIC_VAR_PROCdrawgridcolor)
	INC HL
; +
	LD (ZXBASIC_VAR_PROCdrawgridcolor),HL
; 		3060.6  IF PROCdrawgridcolor=3{00 00 03 00 00 } THEN  LET PROCdrawgridcolor=1{00 00 01 00 00 }
	LD DE,(ZXBASIC_VAR_PROCdrawgridcolor)
	LD HL,3
; =
	CALL runtimeCmpHLEqDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_36
; 		3060.7  LET PROCdrawgridcolor=1{00 00 01 00 00 }
	LD HL,1
	LD (ZXBASIC_VAR_PROCdrawgridcolor),HL
ZXB_LABEL_36:
ZXBASIC_LINE_3070:
; 3070  GOTO 3050
; 		3070.1  GOTO 3050{00 00 ea 0b 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_3050
ZXBASIC_LINE_3080:
; 3080  LET PROCdrawgridx=PROCdrawgridx+1
; 		3080.1  LET PROCdrawgridx=PROCdrawgridx+1{00 00 01 00 00 }
	LD HL,(ZXBASIC_VAR_PROCdrawgridx)
	INC HL
; +
	LD (ZXBASIC_VAR_PROCdrawgridx),HL
ZXBASIC_LINE_3090:
; 3090  GOTO 3000
; 		3090.1  GOTO 3000{00 00 b8 0b 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_3000
ZXBASIC_LINE_3100:
; 3100  RETURN 
; 		3100.1  RETURN 
	CALL runtimeCheckBreak
	RET
ZXBASIC_LINE_3110:
; 3110  REM  SUB select(0=x, 1=y)
ZXBASIC_LINE_3120:
; 3120  REM  ---------------------
ZXBASIC_LINE_3130:
; 3130  LET xx=3*PROCselect0+fieldx: LET yy=3*PROCselect1+fieldy: PRINT  AT yy,xx; PAPER 6;"   "; AT yy+1,xx;"   "; AT yy+2,xx;"   ";: IF o(PROCselect0+1,PROCselect1+1)=1 THEN  LET PROCshowpicture0=0: LET PROCshowpicture1=6: LET PROCshowpicture2=PROCselect0: LET PROCshowpicture3=PROCselect1: GO SUB 3220
; 		3130.1  LET xx=3{00 00 03 00 00 }*PROCselect0+fieldx
	LD DE,3
	LD HL,(ZXBASIC_VAR_PROCselect0)
; *
	call runtimeMult16bit
	LD DE,HL
	LD HL,(ZXBASIC_VAR_fieldx)
; +
	ADD HL,DE
	LD (ZXBASIC_VAR_xx),HL
; 		3130.2  LET yy=3{00 00 03 00 00 }*PROCselect1+fieldy
	LD DE,3
	LD HL,(ZXBASIC_VAR_PROCselect1)
; *
	call runtimeMult16bit
	LD DE,HL
	LD HL,(ZXBASIC_VAR_fieldy)
; +
	ADD HL,DE
	LD (ZXBASIC_VAR_yy),HL
; 		3130.3  PRINT  AT yy,xx; PAPER 6{00 00 06 00 00 };"   "; AT yy+1{00 00 01 00 00 },xx;"   "; AT yy+2{00 00 02 00 00 },xx;"   ";
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,(ZXBASIC_VAR_yy)
	LD HL,(ZXBASIC_VAR_xx)
	CALL runtimePrintAt
	LD HL,6
	CALL runtimeLocalPaper
	LD HL,STRING_33	;   
	CALL runtimePrintString
	LD DE,(ZXBASIC_VAR_yy)
	LD HL,1
; +
	ADD HL,DE
	LD DE,HL
	LD HL,(ZXBASIC_VAR_xx)
	CALL runtimePrintAt
	LD HL,STRING_33	;   
	CALL runtimePrintString
	LD DE,(ZXBASIC_VAR_yy)
	LD HL,2
; +
	ADD HL,DE
	LD DE,HL
	LD HL,(ZXBASIC_VAR_xx)
	CALL runtimePrintAt
	LD HL,STRING_33	;   
	CALL runtimePrintString
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
; 		3130.4  IF o(PROCselect0+1{00 00 01 00 00 },PROCselect1+1{00 00 01 00 00 })=1{00 00 01 00 00 } THEN  LET PROCshowpicture0=0{00 00 00 00 00 }
; Array-Access
	LD DE,(ZXBASIC_VAR_PROCselect0)
	LD HL,1
; +
	ADD HL,DE
	LD DE,9
	CALL runtimeMult16bit
	PUSH HL
	LD DE,(ZXBASIC_VAR_PROCselect1)
	LD HL,1
; +
	ADD HL,DE
	POP DE
	ADD HL,DE
	ADD HL,HL
	LD DE, ZXBASIC_VAR_o_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,1
; =
	POP DE
	CALL runtimeCmpHLEqDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_37
; 		3130.5  LET PROCshowpicture0=0{00 00 00 00 00 }
	LD HL,0
	LD (ZXBASIC_VAR_PROCshowpicture0),HL
; 		3130.6  LET PROCshowpicture1=6{00 00 06 00 00 }
	LD HL,6
	LD (ZXBASIC_VAR_PROCshowpicture1),HL
; 		3130.7  LET PROCshowpicture2=PROCselect0
	LD HL,(ZXBASIC_VAR_PROCselect0)
	LD (ZXBASIC_VAR_PROCshowpicture2),HL
; 		3130.8  LET PROCshowpicture3=PROCselect1
	LD HL,(ZXBASIC_VAR_PROCselect1)
	LD (ZXBASIC_VAR_PROCshowpicture3),HL
; 		3130.9  GO SUB 3220{00 00 94 0c 00 }
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_3220
ZXB_LABEL_37:
ZXBASIC_LINE_3140:
; 3140  RETURN 
; 		3140.1  RETURN 
	CALL runtimeCheckBreak
	RET
ZXBASIC_LINE_3150:
; 3150  REM  SUB unselect(0=x, 1=y)
ZXBASIC_LINE_3160:
; 3160  REM  -----------------------
ZXBASIC_LINE_3170:
; 3170  LET xx=3*PROCunselect0+fieldx: LET yy=3*PROCunselect1+fieldy
; 		3170.1  LET xx=3{00 00 03 00 00 }*PROCunselect0+fieldx
	LD DE,3
	LD HL,(ZXBASIC_VAR_PROCunselect0)
; *
	call runtimeMult16bit
	LD DE,HL
	LD HL,(ZXBASIC_VAR_fieldx)
; +
	ADD HL,DE
	LD (ZXBASIC_VAR_xx),HL
; 		3170.2  LET yy=3{00 00 03 00 00 }*PROCunselect1+fieldy
	LD DE,3
	LD HL,(ZXBASIC_VAR_PROCunselect1)
; *
	call runtimeMult16bit
	LD DE,HL
	LD HL,(ZXBASIC_VAR_fieldy)
; +
	ADD HL,DE
	LD (ZXBASIC_VAR_yy),HL
ZXBASIC_LINE_3180:
; 3180  LET ax= INT (PROCunselect0/2)*2: LET ay= INT (PROCunselect1/2)*2: IF ay=PROCunselect1 THEN  LET col=2: IF ax=PROCunselect0 THEN  LET col=1
; 		3180.1  LET ax= INT (PROCunselect0/2{00 00 02 00 00 })*2{00 00 02 00 00 }
; INT
	LD DE,(ZXBASIC_VAR_PROCunselect0)
	LD HL,2
; /
	call runtimeDiv16bit
	LD DE,HL
	LD HL,2
; *
	call runtimeMult16bit
	LD (ZXBASIC_VAR_ax),HL
; 		3180.2  LET ay= INT (PROCunselect1/2{00 00 02 00 00 })*2{00 00 02 00 00 }
; INT
	LD DE,(ZXBASIC_VAR_PROCunselect1)
	LD HL,2
; /
	call runtimeDiv16bit
	LD DE,HL
	LD HL,2
; *
	call runtimeMult16bit
	LD (ZXBASIC_VAR_ay),HL
; 		3180.3  IF ay=PROCunselect1 THEN  LET col=2{00 00 02 00 00 }
	LD DE,(ZXBASIC_VAR_ay)
	LD HL,(ZXBASIC_VAR_PROCunselect1)
; =
	CALL runtimeCmpHLEqDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_38
; 		3180.4  LET col=2{00 00 02 00 00 }
	LD HL,2
	LD (ZXBASIC_VAR_col),HL
; 		3180.5  IF ax=PROCunselect0 THEN  LET col=1{00 00 01 00 00 }
	LD DE,(ZXBASIC_VAR_ax)
	LD HL,(ZXBASIC_VAR_PROCunselect0)
; =
	CALL runtimeCmpHLEqDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_39
; 		3180.6  LET col=1{00 00 01 00 00 }
	LD HL,1
	LD (ZXBASIC_VAR_col),HL
ZXB_LABEL_39:
ZXB_LABEL_38:
ZXBASIC_LINE_3190:
; 3190  IF ay <> PROCunselect1 THEN  LET col=1: IF ax=PROCunselect0 THEN  LET col=2
; 		3190.1  IF ay <> PROCunselect1 THEN  LET col=1{00 00 01 00 00 }
	LD DE,(ZXBASIC_VAR_ay)
	LD HL,(ZXBASIC_VAR_PROCunselect1)
; <>
	CALL runtimeCmpHlNeDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_40
; 		3190.2  LET col=1{00 00 01 00 00 }
	LD HL,1
	LD (ZXBASIC_VAR_col),HL
; 		3190.3  IF ax=PROCunselect0 THEN  LET col=2{00 00 02 00 00 }
	LD DE,(ZXBASIC_VAR_ax)
	LD HL,(ZXBASIC_VAR_PROCunselect0)
; =
	CALL runtimeCmpHLEqDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_41
; 		3190.4  LET col=2{00 00 02 00 00 }
	LD HL,2
	LD (ZXBASIC_VAR_col),HL
ZXB_LABEL_41:
ZXB_LABEL_40:
ZXBASIC_LINE_3200:
; 3200  PRINT  PAPER col; AT yy,xx;"   "; AT yy+1,xx;"   "; AT yy+2,xx;"   ";: IF o(PROCunselect0+1,PROCunselect1+1)=1 THEN  LET PROCshowpicture0=7: LET PROCshowpicture1=col: LET PROCshowpicture2=PROCunselect0: LET PROCshowpicture3=PROCunselect1: GO SUB 3220
; 		3200.1  PRINT  PAPER col; AT yy,xx;"   "; AT yy+1{00 00 01 00 00 },xx;"   "; AT yy+2{00 00 02 00 00 },xx;"   ";
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,(ZXBASIC_VAR_col)
	CALL runtimeLocalPaper
	LD DE,(ZXBASIC_VAR_yy)
	LD HL,(ZXBASIC_VAR_xx)
	CALL runtimePrintAt
	LD HL,STRING_33	;   
	CALL runtimePrintString
	LD DE,(ZXBASIC_VAR_yy)
	LD HL,1
; +
	ADD HL,DE
	LD DE,HL
	LD HL,(ZXBASIC_VAR_xx)
	CALL runtimePrintAt
	LD HL,STRING_33	;   
	CALL runtimePrintString
	LD DE,(ZXBASIC_VAR_yy)
	LD HL,2
; +
	ADD HL,DE
	LD DE,HL
	LD HL,(ZXBASIC_VAR_xx)
	CALL runtimePrintAt
	LD HL,STRING_33	;   
	CALL runtimePrintString
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
; 		3200.2  IF o(PROCunselect0+1{00 00 01 00 00 },PROCunselect1+1{00 00 01 00 00 })=1{00 00 01 00 00 } THEN  LET PROCshowpicture0=7{00 00 07 00 00 }
; Array-Access
	LD DE,(ZXBASIC_VAR_PROCunselect0)
	LD HL,1
; +
	ADD HL,DE
	LD DE,9
	CALL runtimeMult16bit
	PUSH HL
	LD DE,(ZXBASIC_VAR_PROCunselect1)
	LD HL,1
; +
	ADD HL,DE
	POP DE
	ADD HL,DE
	ADD HL,HL
	LD DE, ZXBASIC_VAR_o_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,1
; =
	POP DE
	CALL runtimeCmpHLEqDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_42
; 		3200.3  LET PROCshowpicture0=7{00 00 07 00 00 }
	LD HL,7
	LD (ZXBASIC_VAR_PROCshowpicture0),HL
; 		3200.4  LET PROCshowpicture1=col
	LD HL,(ZXBASIC_VAR_col)
	LD (ZXBASIC_VAR_PROCshowpicture1),HL
; 		3200.5  LET PROCshowpicture2=PROCunselect0
	LD HL,(ZXBASIC_VAR_PROCunselect0)
	LD (ZXBASIC_VAR_PROCshowpicture2),HL
; 		3200.6  LET PROCshowpicture3=PROCunselect1
	LD HL,(ZXBASIC_VAR_PROCunselect1)
	LD (ZXBASIC_VAR_PROCshowpicture3),HL
; 		3200.7  GO SUB 3220{00 00 94 0c 00 }
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_3220
ZXB_LABEL_42:
ZXBASIC_LINE_3210:
; 3210  RETURN 
; 		3210.1  RETURN 
	CALL runtimeCheckBreak
	RET
ZXBASIC_LINE_3220:
; 3220  REM  SUB showpicture(0=color, 1=background, 2=x, 3=y)
ZXBASIC_LINE_3230:
; 3230  REM  -------------------------------------------------
ZXBASIC_LINE_3240:
; 3240  LET xx=PROCshowpicture2+PROCshowpicture2+PROCshowpicture2+fieldx: LET yy=PROCshowpicture3+PROCshowpicture3+PROCshowpicture3+fieldy: PRINT  AT yy+1,xx+1; INK PROCshowpicture0; PAPER PROCshowpicture1; CHR$ (g(PROCshowpicture2+1,PROCshowpicture3+1))
; 		3240.1  LET xx=PROCshowpicture2+PROCshowpicture2+PROCshowpicture2+fieldx
	LD DE,(ZXBASIC_VAR_PROCshowpicture2)
	LD HL,(ZXBASIC_VAR_PROCshowpicture2)
; +
	ADD HL,DE
	LD DE,HL
	LD HL,(ZXBASIC_VAR_PROCshowpicture2)
; +
	ADD HL,DE
	LD DE,HL
	LD HL,(ZXBASIC_VAR_fieldx)
; +
	ADD HL,DE
	LD (ZXBASIC_VAR_xx),HL
; 		3240.2  LET yy=PROCshowpicture3+PROCshowpicture3+PROCshowpicture3+fieldy
	LD DE,(ZXBASIC_VAR_PROCshowpicture3)
	LD HL,(ZXBASIC_VAR_PROCshowpicture3)
; +
	ADD HL,DE
	LD DE,HL
	LD HL,(ZXBASIC_VAR_PROCshowpicture3)
; +
	ADD HL,DE
	LD DE,HL
	LD HL,(ZXBASIC_VAR_fieldy)
; +
	ADD HL,DE
	LD (ZXBASIC_VAR_yy),HL
; 		3240.3  PRINT  AT yy+1{00 00 01 00 00 },xx+1{00 00 01 00 00 }; INK PROCshowpicture0; PAPER PROCshowpicture1; CHR$ (g(PROCshowpicture2+1{00 00 01 00 00 },PROCshowpicture3+1{00 00 01 00 00 }))
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,(ZXBASIC_VAR_yy)
	LD HL,1
; +
	ADD HL,DE
	PUSH HL
	LD DE,(ZXBASIC_VAR_xx)
	LD HL,1
; +
	ADD HL,DE
	POP DE
	CALL runtimePrintAt
	LD HL,(ZXBASIC_VAR_PROCshowpicture0)
	CALL runtimeLocalInk
	LD HL,(ZXBASIC_VAR_PROCshowpicture1)
	CALL runtimeLocalPaper
; CHR$
; Array-Access
	LD DE,(ZXBASIC_VAR_PROCshowpicture2)
	LD HL,1
; +
	ADD HL,DE
	LD DE,9
	CALL runtimeMult16bit
	PUSH HL
	LD DE,(ZXBASIC_VAR_PROCshowpicture3)
	LD HL,1
; +
	ADD HL,DE
	POP DE
	ADD HL,DE
	ADD HL,HL
	LD DE, ZXBASIC_VAR_g_array
	ADD HL,DE
	LD DE,(HL)
	LD HL,DE
	CALL runtimeChr
	CALL runtimePrintString
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
	POP AF
	LD (ZX_P_FLAG),A
	CALL ZXFreeTempCompact
ZXBASIC_LINE_3250:
; 3250  RETURN 
; 		3250.1  RETURN 
	CALL runtimeCheckBreak
	RET
ZXBASIC_LINE_3260:
; 3260  REM  SUB reversecard
ZXBASIC_LINE_3270:
; 3270  REM  ----------------
ZXBASIC_LINE_3280:
; 3280  LET temp=o(playerx+1,playery+1)+1
; 		3280.1  LET temp=o(playerx+1{00 00 01 00 00 },playery+1{00 00 01 00 00 })+1{00 00 01 00 00 }
; Array-Access
	LD DE,(ZXBASIC_VAR_playerx)
	LD HL,1
; +
	ADD HL,DE
	LD DE,9
	CALL runtimeMult16bit
	PUSH HL
	LD DE,(ZXBASIC_VAR_playery)
	LD HL,1
; +
	ADD HL,DE
	POP DE
	ADD HL,DE
	ADD HL,HL
	LD DE, ZXBASIC_VAR_o_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,1
; +
	POP DE
	ADD HL,DE
	LD (ZXBASIC_VAR_temp),HL
ZXBASIC_LINE_3290:
; 3290  IF temp=2 THEN  LET temp=0
; 		3290.1  IF temp=2{00 00 02 00 00 } THEN  LET temp=0{00 00 00 00 00 }
	LD DE,(ZXBASIC_VAR_temp)
	LD HL,2
; =
	CALL runtimeCmpHLEqDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_43
; 		3290.2  LET temp=0{00 00 00 00 00 }
	LD HL,0
	LD (ZXBASIC_VAR_temp),HL
ZXB_LABEL_43:
ZXBASIC_LINE_3300:
; 3300  LET o(playerx+1,playery+1)=temp
; 		3300.1  LET o(playerx+1{00 00 01 00 00 },playery+1{00 00 01 00 00 })=temp
	LD DE,(ZXBASIC_VAR_playerx)
	LD HL,1
; +
	ADD HL,DE
	LD DE,9
	CALL runtimeMult16bit
	PUSH HL
	LD DE,(ZXBASIC_VAR_playery)
	LD HL,1
; +
	ADD HL,DE
	POP DE
	ADD HL,DE
	ADD HL,HL
	PUSH HL
	LD DE,(ZXBASIC_VAR_temp)
	POP HL
	LD BC,ZXBASIC_VAR_o_array
	ADD HL,BC
	LD (HL),DE
ZXBASIC_LINE_3310:
; 3310  RETURN 
; 		3310.1  RETURN 
	CALL runtimeCheckBreak
	RET
ZXBASIC_LINE_3320:
; 3320  REM  SUB enterpressed
ZXBASIC_LINE_3330:
; 3330  REM  -----------------
ZXBASIC_LINE_3340:
; 3340  IF numSelected <> 0 THEN  GOTO 3370
; 		3340.1  IF numSelected <> 0{00 00 00 00 00 } THEN  GOTO 3370{00 00 2a 0d 00 }
	LD DE,(ZXBASIC_VAR_numSelected)
	LD HL,0
; <>
	CALL runtimeCmpHlNeDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_44
; 		3340.2  GOTO 3370{00 00 2a 0d 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_3370
ZXB_LABEL_44:
ZXBASIC_LINE_3350:
; 3350  GO SUB 3500
; 		3350.1  GO SUB 3500{00 00 ac 0d 00 }
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_3500
ZXBASIC_LINE_3360:
; 3360  GOTO 3490;
; 		3360.1  GOTO 3490{00 00 a2 0d 00 };
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_3490
ZXBASIC_LINE_3370:
; 3370  IF numSelected <> 1 THEN  GOTO 3420
; 		3370.1  IF numSelected <> 1{00 00 01 00 00 } THEN  GOTO 3420{00 00 5c 0d 00 }
	LD DE,(ZXBASIC_VAR_numSelected)
	LD HL,1
; <>
	CALL runtimeCmpHlNeDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_45
; 		3370.2  GOTO 3420{00 00 5c 0d 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_3420
ZXB_LABEL_45:
ZXBASIC_LINE_3380:
; 3380  IF o(playerx+1,playery+1)=1 THEN  RETURN 
; 		3380.1  IF o(playerx+1{00 00 01 00 00 },playery+1{00 00 01 00 00 })=1{00 00 01 00 00 } THEN  RETURN 
; Array-Access
	LD DE,(ZXBASIC_VAR_playerx)
	LD HL,1
; +
	ADD HL,DE
	LD DE,9
	CALL runtimeMult16bit
	PUSH HL
	LD DE,(ZXBASIC_VAR_playery)
	LD HL,1
; +
	ADD HL,DE
	POP DE
	ADD HL,DE
	ADD HL,HL
	LD DE, ZXBASIC_VAR_o_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,1
; =
	POP DE
	CALL runtimeCmpHLEqDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_46
; 		3380.2  RETURN 
	CALL runtimeCheckBreak
	RET
ZXB_LABEL_46:
ZXBASIC_LINE_3390:
; 3390  LET o(playerx+1,playery+1)=1
; 		3390.1  LET o(playerx+1{00 00 01 00 00 },playery+1{00 00 01 00 00 })=1{00 00 01 00 00 }
	LD DE,(ZXBASIC_VAR_playerx)
	LD HL,1
; +
	ADD HL,DE
	LD DE,9
	CALL runtimeMult16bit
	PUSH HL
	LD DE,(ZXBASIC_VAR_playery)
	LD HL,1
; +
	ADD HL,DE
	POP DE
	ADD HL,DE
	ADD HL,HL
	PUSH HL
	LD DE,1
	POP HL
	LD BC,ZXBASIC_VAR_o_array
	ADD HL,BC
	LD (HL),DE
ZXBASIC_LINE_3400:
; 3400  LET PROCselect0=playerx: LET PROCselect1=playery: GO SUB 3110
; 		3400.1  LET PROCselect0=playerx
	LD HL,(ZXBASIC_VAR_playerx)
	LD (ZXBASIC_VAR_PROCselect0),HL
; 		3400.2  LET PROCselect1=playery
	LD HL,(ZXBASIC_VAR_playery)
	LD (ZXBASIC_VAR_PROCselect1),HL
; 		3400.3  GO SUB 3110{00 00 26 0c 00 }
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_3110
ZXBASIC_LINE_3410:
; 3410  LET numSelected=2: LET xSel2=playerx: LET ySel2=playery: GOTO 3490;
; 		3410.1  LET numSelected=2{00 00 02 00 00 }
	LD HL,2
	LD (ZXBASIC_VAR_numSelected),HL
; 		3410.2  LET xSel2=playerx
	LD HL,(ZXBASIC_VAR_playerx)
	LD (ZXBASIC_VAR_xSel2),HL
; 		3410.3  LET ySel2=playery
	LD HL,(ZXBASIC_VAR_playery)
	LD (ZXBASIC_VAR_ySel2),HL
; 		3410.4  GOTO 3490{00 00 a2 0d 00 };
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_3490
ZXBASIC_LINE_3420:
; 3420  IF numSelected <> 2 THEN  GOTO 3490
; 		3420.1  IF numSelected <> 2{00 00 02 00 00 } THEN  GOTO 3490{00 00 a2 0d 00 }
	LD DE,(ZXBASIC_VAR_numSelected)
	LD HL,2
; <>
	CALL runtimeCmpHlNeDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_47
; 		3420.2  GOTO 3490{00 00 a2 0d 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_3490
ZXB_LABEL_47:
ZXBASIC_LINE_3430:
; 3430  LET numSelected=0: LET moves=moves+1
; 		3430.1  LET numSelected=0{00 00 00 00 00 }
	LD HL,0
	LD (ZXBASIC_VAR_numSelected),HL
; 		3430.2  LET moves=moves+1{00 00 01 00 00 }
	LD HL,(ZXBASIC_VAR_moves)
	INC HL
; +
	LD (ZXBASIC_VAR_moves),HL
ZXBASIC_LINE_3440:
; 3440  IF g(xSel1+1,ySel1+1)=g(xSel2+1,ySel2+1) THEN  GO SUB 3560: RETURN 
; 		3440.1  IF g(xSel1+1{00 00 01 00 00 },ySel1+1{00 00 01 00 00 })=g(xSel2+1{00 00 01 00 00 },ySel2+1{00 00 01 00 00 }) THEN  GO SUB 3560{00 00 e8 0d 00 }
; Array-Access
	LD DE,(ZXBASIC_VAR_xSel1)
	LD HL,1
; +
	ADD HL,DE
	LD DE,9
	CALL runtimeMult16bit
	PUSH HL
	LD DE,(ZXBASIC_VAR_ySel1)
	LD HL,1
; +
	ADD HL,DE
	POP DE
	ADD HL,DE
	ADD HL,HL
	LD DE, ZXBASIC_VAR_g_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
; Array-Access
	LD DE,(ZXBASIC_VAR_xSel2)
	LD HL,1
; +
	ADD HL,DE
	LD DE,9
	CALL runtimeMult16bit
	PUSH HL
	LD DE,(ZXBASIC_VAR_ySel2)
	LD HL,1
; +
	ADD HL,DE
	POP DE
	ADD HL,DE
	ADD HL,HL
	LD DE, ZXBASIC_VAR_g_array
	ADD HL,DE
	LD DE,(HL)
	LD HL,DE
; =
	POP DE
	CALL runtimeCmpHLEqDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_48
; 		3440.2  GO SUB 3560{00 00 e8 0d 00 }
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_3560
; 		3440.3  RETURN 
	CALL runtimeCheckBreak
	RET
ZXB_LABEL_48:
ZXBASIC_LINE_3450:
; 3450  LET o(xSel1+1,ySel1+1)=0: LET o(xSel2+1,ySel2+1)=0: LET PROCunselect0=xSel1: LET PROCunselect1=ySel1: GO SUB 3150: LET PROCunselect0=xSel2: LET PROCunselect1=ySel2: GO SUB 3150
; 		3450.1  LET o(xSel1+1{00 00 01 00 00 },ySel1+1{00 00 01 00 00 })=0{00 00 00 00 00 }
	LD DE,(ZXBASIC_VAR_xSel1)
	LD HL,1
; +
	ADD HL,DE
	LD DE,9
	CALL runtimeMult16bit
	PUSH HL
	LD DE,(ZXBASIC_VAR_ySel1)
	LD HL,1
; +
	ADD HL,DE
	POP DE
	ADD HL,DE
	ADD HL,HL
	PUSH HL
	LD DE,0
	POP HL
	LD BC,ZXBASIC_VAR_o_array
	ADD HL,BC
	LD (HL),DE
; 		3450.2  LET o(xSel2+1{00 00 01 00 00 },ySel2+1{00 00 01 00 00 })=0{00 00 00 00 00 }
	LD DE,(ZXBASIC_VAR_xSel2)
	LD HL,1
; +
	ADD HL,DE
	LD DE,9
	CALL runtimeMult16bit
	PUSH HL
	LD DE,(ZXBASIC_VAR_ySel2)
	LD HL,1
; +
	ADD HL,DE
	POP DE
	ADD HL,DE
	ADD HL,HL
	PUSH HL
	LD DE,0
	POP HL
	LD BC,ZXBASIC_VAR_o_array
	ADD HL,BC
	LD (HL),DE
; 		3450.3  LET PROCunselect0=xSel1
	LD HL,(ZXBASIC_VAR_xSel1)
	LD (ZXBASIC_VAR_PROCunselect0),HL
; 		3450.4  LET PROCunselect1=ySel1
	LD HL,(ZXBASIC_VAR_ySel1)
	LD (ZXBASIC_VAR_PROCunselect1),HL
; 		3450.5  GO SUB 3150{00 00 4e 0c 00 }
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_3150
; 		3450.6  LET PROCunselect0=xSel2
	LD HL,(ZXBASIC_VAR_xSel2)
	LD (ZXBASIC_VAR_PROCunselect0),HL
; 		3450.7  LET PROCunselect1=ySel2
	LD HL,(ZXBASIC_VAR_ySel2)
	LD (ZXBASIC_VAR_PROCunselect1),HL
; 		3450.8  GO SUB 3150{00 00 4e 0c 00 }
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_3150
ZXBASIC_LINE_3460:
; 3460  LET PROCselect0=playerx: LET PROCselect1=playery: GO SUB 3110
; 		3460.1  LET PROCselect0=playerx
	LD HL,(ZXBASIC_VAR_playerx)
	LD (ZXBASIC_VAR_PROCselect0),HL
; 		3460.2  LET PROCselect1=playery
	LD HL,(ZXBASIC_VAR_playery)
	LD (ZXBASIC_VAR_PROCselect1),HL
; 		3460.3  GO SUB 3110{00 00 26 0c 00 }
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_3110
ZXBASIC_LINE_3470:
; 3470  GO SUB 3500
; 		3470.1  GO SUB 3500{00 00 ac 0d 00 }
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_3500
ZXBASIC_LINE_3480:
; 3480  GOTO 3490
; 		3480.1  GOTO 3490{00 00 a2 0d 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_3490
ZXBASIC_LINE_3490:
; 3490  RETURN 
; 		3490.1  RETURN 
	CALL runtimeCheckBreak
	RET
ZXBASIC_LINE_3500:
; 3500  REM  SUB selcard1
ZXBASIC_LINE_3510:
; 3510  REM  -------------
ZXBASIC_LINE_3520:
; 3520  IF o(playerx+1,playery+1)=1 THEN  RETURN 
; 		3520.1  IF o(playerx+1{00 00 01 00 00 },playery+1{00 00 01 00 00 })=1{00 00 01 00 00 } THEN  RETURN 
; Array-Access
	LD DE,(ZXBASIC_VAR_playerx)
	LD HL,1
; +
	ADD HL,DE
	LD DE,9
	CALL runtimeMult16bit
	PUSH HL
	LD DE,(ZXBASIC_VAR_playery)
	LD HL,1
; +
	ADD HL,DE
	POP DE
	ADD HL,DE
	ADD HL,HL
	LD DE, ZXBASIC_VAR_o_array
	ADD HL,DE
	LD DE,(HL)
	PUSH DE
	LD HL,1
; =
	POP DE
	CALL runtimeCmpHLEqDE
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_49
; 		3520.2  RETURN 
	CALL runtimeCheckBreak
	RET
ZXB_LABEL_49:
ZXBASIC_LINE_3530:
; 3530  GO SUB 3260
; 		3530.1  GO SUB 3260{00 00 bc 0c 00 }
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_3260
ZXBASIC_LINE_3540:
; 3540  LET PROCselect0=playerx: LET PROCselect1=playery: GO SUB 3110
; 		3540.1  LET PROCselect0=playerx
	LD HL,(ZXBASIC_VAR_playerx)
	LD (ZXBASIC_VAR_PROCselect0),HL
; 		3540.2  LET PROCselect1=playery
	LD HL,(ZXBASIC_VAR_playery)
	LD (ZXBASIC_VAR_PROCselect1),HL
; 		3540.3  GO SUB 3110{00 00 26 0c 00 }
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_3110
ZXBASIC_LINE_3550:
; 3550  LET numSelected=1: LET xSel1=playerx: LET ySel1=playery: RETURN 
; 		3550.1  LET numSelected=1{00 00 01 00 00 }
	LD HL,1
	LD (ZXBASIC_VAR_numSelected),HL
; 		3550.2  LET xSel1=playerx
	LD HL,(ZXBASIC_VAR_playerx)
	LD (ZXBASIC_VAR_xSel1),HL
; 		3550.3  LET ySel1=playery
	LD HL,(ZXBASIC_VAR_playery)
	LD (ZXBASIC_VAR_ySel1),HL
; 		3550.4  RETURN 
	CALL runtimeCheckBreak
	RET
ZXBASIC_LINE_3560:
; 3560  REM  SUB tilefound
ZXBASIC_LINE_3570:
; 3570  REM  --------------
ZXBASIC_LINE_3580:
; 3580  LET found=found+1
; 		3580.1  LET found=found+1{00 00 01 00 00 }
	LD HL,(ZXBASIC_VAR_found)
	INC HL
; +
	LD (ZXBASIC_VAR_found),HL
ZXBASIC_LINE_3590:
; 3590  RETURN 
; 		3590.1  RETURN 
	CALL runtimeCheckBreak
	RET
ZXBASIC_LINE_3600:
; 3600  REM  SUB readudg
ZXBASIC_LINE_3610:
; 3610  REM  ------------
ZXBASIC_LINE_3620:
; 3620  RANDOMIZE 
; 		3620.1  RANDOMIZE 
	LD HL,($5C78)	;Timer lower bytes
	LD ($5C76),HL	;Random Seed
ZXBASIC_LINE_3630:
; 3630  LET figures=(4520-3890)/10: LET start= INT ( RND *(figures-19)): PRINT "Figures=";figures;" start=";start;" RESTORE=";3890+start*10: RESTORE 3890+start*10: LET c=144: LET a= USR "A"
; 		3630.1  LET figures=(4520{00 00 a8 11 00 }-3890{00 00 32 0f 00 })/10{00 00 0a 00 00 }
; (
	LD HL,4520
	LD DE,3890
; -
	SUB HL,DE
	LD DE,HL
; )
	LD HL,10
; /
	call runtimeDiv16bit
	LD (ZXBASIC_VAR_figures),HL
; 		3630.2  LET start= INT ( RND *(figures-19{00 00 13 00 00 }))
; INT
; RND
	CALL runtimeRND
; (
	LD HL,(ZXBASIC_VAR_figures)
	LD DE,19
; -
	SUB HL,DE
; )
; *
	CALL runtimeIntToFloat
	RST $28
	DB $04	;MULT
	DB $38	;END CALC
	CALL runtimeFloatToInt
	LD (ZXBASIC_VAR_start),HL
; 		3630.3  PRINT "Figures=";figures;" start=";start;" RESTORE=";3890{00 00 32 0f 00 }+start*10{00 00 0a 00 00 }
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_34	;Figures=
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_figures)
	CALL runtimePrintInt
	LD HL,STRING_35	; start=
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_start)
	CALL runtimePrintInt
	LD HL,STRING_36	; RESTORE=
	CALL runtimePrintString
	LD HL,3890
	PUSH HL
	LD DE,(ZXBASIC_VAR_start)
	LD HL,10
; *
	call runtimeMult16bit
; +
	POP DE
	ADD HL,DE
	CALL runtimePrintInt
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
; 		3630.4  RESTORE 3890{00 00 32 0f 00 }+start*10{00 00 0a 00 00 }
	LD HL,3890
	PUSH HL
	LD DE,(ZXBASIC_VAR_start)
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
; 		3630.5  LET c=144{00 00 90 00 00 }
	LD HL,144
	LD (ZXBASIC_VAR_c),HL
; 		3630.6  LET a= USR "A"
; USR
	LD HL,STRING_37	;A
	CALL runtimeUsrUDG
	LD (ZXBASIC_VAR_a),HL
ZXBASIC_LINE_3640:
; 3640  IF  NOT (c<165) THEN  GOTO 3710
; 		3640.1  IF  NOT (c<165{00 00 a5 00 00 }) THEN  GOTO 3710{00 00 7e 0e 00 }
; NOT
	LD DE,(ZXBASIC_VAR_c)
	LD HL,165
; <
	CALL runtimeCmpHLltDE
	CALL runtimeNotHL
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_50
; 		3640.2  GOTO 3710{00 00 7e 0e 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_3710
ZXB_LABEL_50:
ZXBASIC_LINE_3650:
; 3650  READ a$: PRINT "reading ";c;" = ";a$;": ";: LET i=0
; 		3650.1  READ a$
	LD HL,ZXBASIC_VAR_a_string
	CALL ZXFreeStringVar
	LD HL,(DATAPTR)
	LD (ZXBASIC_VAR_a_string),HL
	LD BC,(HL)
	INC HL
	INC HL
	ADD HL,BC
	LD (DATAPTR),HL
; 		3650.2  PRINT "reading ";c;" = ";a$;"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_38	;reading 
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_c)
	CALL runtimePrintInt
	LD HL,STRING_39	; = 
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_a_string)
	CALL runtimePrintString
	LD HL,STRING_40	;: 
	CALL runtimePrintString
	POP AF
	LD (ZX_P_FLAG),A
	CALL ZXFreeTempCompact
; 		3650.3  LET i=0{00 00 00 00 00 }
	LD HL,0
	LD (ZXBASIC_VAR_i),HL
ZXBASIC_LINE_3660:
; 3660  IF  NOT (i<8) THEN  GOTO 3690
; 		3660.1  IF  NOT (i<8{00 00 08 00 00 }) THEN  GOTO 3690{00 00 6a 0e 00 }
; NOT
	LD DE,(ZXBASIC_VAR_i)
	LD HL,8
; <
	CALL runtimeCmpHLltDE
	CALL runtimeNotHL
	LD A,L
	CP 0
	JP Z,ZXB_LABEL_51
; 		3660.2  GOTO 3690{00 00 6a 0e 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_3690
ZXB_LABEL_51:
ZXBASIC_LINE_3670:
; 3670  READ b: POKE a,b: LET a=a+1: LET i=i+1
; 		3670.1  READ b
	LD HL,(DATAPTR)
	LD DE,(HL)
	INC HL
	INC HL
	LD (DATAPTR),HL
	LD (ZXBASIC_VAR_b),DE
; 		3670.2  POKE a,b
	LD HL,(ZXBASIC_VAR_a)
	LD DE,(ZXBASIC_VAR_b)
	LD (HL),E
; 		3670.3  LET a=a+1{00 00 01 00 00 }
	LD HL,(ZXBASIC_VAR_a)
	INC HL
; +
	LD (ZXBASIC_VAR_a),HL
; 		3670.4  LET i=i+1{00 00 01 00 00 }
	LD HL,(ZXBASIC_VAR_i)
	INC HL
; +
	LD (ZXBASIC_VAR_i),HL
ZXBASIC_LINE_3680:
; 3680  GOTO 3660
; 		3680.1  GOTO 3660{00 00 4c 0e 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_3660
ZXBASIC_LINE_3690:
; 3690  PRINT  CHR$ (c): LET c=c+1
; 		3690.1  PRINT  CHR$ (c)
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
; CHR$
	LD HL,(ZXBASIC_VAR_c)
	CALL runtimeChr
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
	CALL ZXFreeTempCompact
; 		3690.2  LET c=c+1{00 00 01 00 00 }
	LD HL,(ZXBASIC_VAR_c)
	INC HL
; +
	LD (ZXBASIC_VAR_c),HL
ZXBASIC_LINE_3700:
; 3700  GOTO 3640
; 		3700.1  GOTO 3640{00 00 38 0e 00 }
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_3640
ZXBASIC_LINE_3710:
; 3710  RETURN 
; 		3710.1  RETURN 
	CALL runtimeCheckBreak
	RET
ZXBASIC_LINE_3720:
; 3720  REM  SUB printgrid
ZXBASIC_LINE_3730:
; 3730  REM  --------------
ZXBASIC_LINE_3740:
; 3740  FOR y=1 TO gridh
; 		3740.1  FOR y=1{00 00 01 00 00 } TO gridh
	CALL runtimeCheckBreak
	LD HL,1
	LD (ZXBASIC_VAR_y),HL
	LD HL,(ZXBASIC_VAR_gridh)
	LD (ZXBASIC_VAR_for_y),HL
FOR_5:
ZXBASIC_LINE_3750:
; 3750  PRINT y;":";
; 		3750.1  PRINT y;"
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,(ZXBASIC_VAR_y)
	CALL runtimePrintInt
	LD HL,STRING_41	;:
	CALL runtimePrintString
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_3760:
; 3760  FOR x=1 TO gridw
; 		3760.1  FOR x=1{00 00 01 00 00 } TO gridw
	CALL runtimeCheckBreak
	LD HL,1
	LD (ZXBASIC_VAR_x),HL
	LD HL,(ZXBASIC_VAR_gridw)
	LD (ZXBASIC_VAR_for_x),HL
FOR_6:
ZXBASIC_LINE_3770:
; 3770  PRINT  CHR$ (g(x,y));
; 		3770.1  PRINT  CHR$ (g(x,y));
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
; CHR$
; Array-Access
	LD HL,(ZXBASIC_VAR_x)
	LD DE,9
	CALL runtimeMult16bit
	LD DE,HL
	LD HL,(ZXBASIC_VAR_y)
	ADD HL,DE
	ADD HL,HL
	LD DE, ZXBASIC_VAR_g_array
	ADD HL,DE
	LD DE,(HL)
	LD HL,DE
	CALL runtimeChr
	CALL runtimePrintString
	POP AF
	LD (ZX_P_FLAG),A
	CALL ZXFreeTempCompact
ZXBASIC_LINE_3780:
; 3780  NEXT x
; 		3780.1  NEXT x
	CALL runtimeCheckBreak
	LD HL,(ZXBASIC_VAR_x)
	INC HL
	LD (ZXBASIC_VAR_x),HL
	LD DE,(ZXBASIC_VAR_for_x)
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_6
ZXBASIC_LINE_3790:
; 3790  PRINT 
; 		3790.1  PRINT 
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_3800:
; 3800  NEXT y
; 		3800.1  NEXT y
	CALL runtimeCheckBreak
	LD HL,(ZXBASIC_VAR_y)
	INC HL
	LD (ZXBASIC_VAR_y),HL
	LD DE,(ZXBASIC_VAR_for_y)
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_5
ZXBASIC_LINE_3810:
; 3810  PAUSE 0
; 		3810.1  PAUSE 0{00 00 00 00 00 }
	LD HL,0
	CALL runtimePause
ZXBASIC_LINE_3820:
; 3820  RETURN 
; 		3820.1  RETURN 
	CALL runtimeCheckBreak
	RET
ZXBASIC_LINE_3830:
; 3830  REM  SUB readmouse
ZXBASIC_LINE_3840:
; 3840  REM  --------------
ZXBASIC_LINE_3850:
; 3850  LET mousex= IN (64479)
; 		3850.1  LET mousex= IN (64479{00 00 df fb 00 })
; IN
	LD BC,64479
	IN A,(C)
	LD L,A
	LD H,0
	LD (ZXBASIC_VAR_mousex),HL
ZXBASIC_LINE_3860:
; 3860  LET mousey= IN (65503)
; 		3860.1  LET mousey= IN (65503{00 00 df ff 00 })
; IN
	LD BC,65503
	IN A,(C)
	LD L,A
	LD H,0
	LD (ZXBASIC_VAR_mousey),HL
ZXBASIC_LINE_3870:
; 3870  LET mouseb= IN (64223)
; 		3870.1  LET mouseb= IN (64223{00 00 df fa 00 })
; IN
	LD BC,64223
	IN A,(C)
	LD L,A
	LD H,0
	LD (ZXBASIC_VAR_mouseb),HL
ZXBASIC_LINE_3880:
; 3880  RETURN 
; 		3880.1  RETURN 
	CALL runtimeCheckBreak
	RET
ZXBASIC_LINE_3890:
; 3890  DATA "CUBE",31,35,69,249,137,137,138,252
; 		3890.1  DATA "CUBE",31{00 00 1f 00 00 },35{00 00 23 00 00 },69{00 00 45 00 00 },249{00 00 f9 00 00 },137{00 00 89 00 00 },137{00 00 89 00 00 },138{00 00 8a 00 00 },252{00 00 fc 00 00 }
ZXBASIC_LINE_3900:
; 3900  DATA "BUBBLE",24,36,66,145,129,66,36,24
; 		3900.1  DATA "BUBBLE",24{00 00 18 00 00 },36{00 00 24 00 00 },66{00 00 42 00 00 },145{00 00 91 00 00 },129{00 00 81 00 00 },66{00 00 42 00 00 },36{00 00 24 00 00 },24{00 00 18 00 00 }
ZXBASIC_LINE_3910:
; 3910  DATA "LLAMA",32,96,32,34,60,60,20,20
; 		3910.1  DATA "LLAMA",32{00 00 20 00 00 },96{00 00 60 00 00 },32{00 00 20 00 00 },34{00 00 22 00 00 },60{00 00 3c 00 00 },60{00 00 3c 00 00 },20{00 00 14 00 00 },20{00 00 14 00 00 }
ZXBASIC_LINE_3920:
; 3920  DATA "SQUARE",0,126,66,66,66,66,126,0
; 		3920.1  DATA "SQUARE",0{00 00 00 00 00 },126{00 00 7e 00 00 },66{00 00 42 00 00 },66{00 00 42 00 00 },66{00 00 42 00 00 },66{00 00 42 00 00 },126{00 00 7e 00 00 },0{00 00 00 00 00 }
ZXBASIC_LINE_3930:
; 3930  DATA "TRIANGE",16,16,40,40,68,68,130,254
; 		3930.1  DATA "TRIANGE",16{00 00 10 00 00 },16{00 00 10 00 00 },40{00 00 28 00 00 },40{00 00 28 00 00 },68{00 00 44 00 00 },68{00 00 44 00 00 },130{00 00 82 00 00 },254{00 00 fe 00 00 }
ZXBASIC_LINE_3940:
; 3940  DATA "HEART",0,108,254,254,254,124,56,16
; 		3940.1  DATA "HEART",0{00 00 00 00 00 },108{00 00 6c 00 00 },254{00 00 fe 00 00 },254{00 00 fe 00 00 },254{00 00 fe 00 00 },124{00 00 7c 00 00 },56{00 00 38 00 00 },16{00 00 10 00 00 }
ZXBASIC_LINE_3950:
; 3950  DATA "HOUSE",60,126,255,0,126,78,74,122
; 		3950.1  DATA "HOUSE",60{00 00 3c 00 00 },126{00 00 7e 00 00 },255{00 00 ff 00 00 },0{00 00 00 00 00 },126{00 00 7e 00 00 },78{00 00 4e 00 00 },74{00 00 4a 00 00 },122{00 00 7a 00 00 }
ZXBASIC_LINE_3960:
; 3960  DATA "FORK",84,84,84,56,16,16,16,16
; 		3960.1  DATA "FORK",84{00 00 54 00 00 },84{00 00 54 00 00 },84{00 00 54 00 00 },56{00 00 38 00 00 },16{00 00 10 00 00 },16{00 00 10 00 00 },16{00 00 10 00 00 },16{00 00 10 00 00 }
ZXBASIC_LINE_3970:
; 3970  DATA "COFFE CUP",36,72,0,254,133,134,132,120
; 		3970.1  DATA "COFFE CUP",36{00 00 24 00 00 },72{00 00 48 00 00 },0{00 00 00 00 00 },254{00 00 fe 00 00 },133{00 00 85 00 00 },134{00 00 86 00 00 },132{00 00 84 00 00 },120{00 00 78 00 00 }
ZXBASIC_LINE_3980:
; 3980  DATA "HUMAN FIGURE",24,24,0,126,24,24,36,66
; 		3980.1  DATA "HUMAN FIGURE",24{00 00 18 00 00 },24{00 00 18 00 00 },0{00 00 00 00 00 },126{00 00 7e 00 00 },24{00 00 18 00 00 },24{00 00 18 00 00 },36{00 00 24 00 00 },66{00 00 42 00 00 }
ZXBASIC_LINE_3990:
; 3990  DATA "HAND",84,85,85,85,191,191,223,254
; 		3990.1  DATA "HAND",84{00 00 54 00 00 },85{00 00 55 00 00 },85{00 00 55 00 00 },85{00 00 55 00 00 },191{00 00 bf 00 00 },191{00 00 bf 00 00 },223{00 00 df 00 00 },254{00 00 fe 00 00 }
ZXBASIC_LINE_4000:
; 4000  DATA "HEADSET",60,66,129,129,195,195,195,0
; 		4000.1  DATA "HEADSET",60{00 00 3c 00 00 },66{00 00 42 00 00 },129{00 00 81 00 00 },129{00 00 81 00 00 },195{00 00 c3 00 00 },195{00 00 c3 00 00 },195{00 00 c3 00 00 },0{00 00 00 00 00 }
ZXBASIC_LINE_4010:
; 4010  DATA "EYEGLASSES",0,0,33,66,254,170,238,0
; 		4010.1  DATA "EYEGLASSES",0{00 00 00 00 00 },0{00 00 00 00 00 },33{00 00 21 00 00 },66{00 00 42 00 00 },254{00 00 fe 00 00 },170{00 00 aa 00 00 },238{00 00 ee 00 00 },0{00 00 00 00 00 }
ZXBASIC_LINE_4020:
; 4020  DATA "CROSS",56,40,238,130,238,40,40,56
; 		4020.1  DATA "CROSS",56{00 00 38 00 00 },40{00 00 28 00 00 },238{00 00 ee 00 00 },130{00 00 82 00 00 },238{00 00 ee 00 00 },40{00 00 28 00 00 },40{00 00 28 00 00 },56{00 00 38 00 00 }
ZXBASIC_LINE_4030:
; 4030  DATA "ENVELOPE",255,195,165,153,129,129,255,0
; 		4030.1  DATA "ENVELOPE",255{00 00 ff 00 00 },195{00 00 c3 00 00 },165{00 00 a5 00 00 },153{00 00 99 00 00 },129{00 00 81 00 00 },129{00 00 81 00 00 },255{00 00 ff 00 00 },0{00 00 00 00 00 }
ZXBASIC_LINE_4040:
; 4040  DATA "MAGNIFIER",48,72,164,132,72,52,2,1
; 		4040.1  DATA "MAGNIFIER",48{00 00 30 00 00 },72{00 00 48 00 00 },164{00 00 a4 00 00 },132{00 00 84 00 00 },72{00 00 48 00 00 },52{00 00 34 00 00 },2{00 00 02 00 00 },1{00 00 01 00 00 }
ZXBASIC_LINE_4050:
; 4050  DATA "SUN",145,66,24,61,188,24,66,137
; 		4050.1  DATA "SUN",145{00 00 91 00 00 },66{00 00 42 00 00 },24{00 00 18 00 00 },61{00 00 3d 00 00 },188{00 00 bc 00 00 },24{00 00 18 00 00 },66{00 00 42 00 00 },137{00 00 89 00 00 }
ZXBASIC_LINE_4060:
; 4060  DATA "SKULL",60,126,147,147,255,254,124,84
; 		4060.1  DATA "SKULL",60{00 00 3c 00 00 },126{00 00 7e 00 00 },147{00 00 93 00 00 },147{00 00 93 00 00 },255{00 00 ff 00 00 },254{00 00 fe 00 00 },124{00 00 7c 00 00 },84{00 00 54 00 00 }
ZXBASIC_LINE_4070:
; 4070  DATA "SCISSORS",0,2,197,38,24,38,197,2
; 		4070.1  DATA "SCISSORS",0{00 00 00 00 00 },2{00 00 02 00 00 },197{00 00 c5 00 00 },38{00 00 26 00 00 },24{00 00 18 00 00 },38{00 00 26 00 00 },197{00 00 c5 00 00 },2{00 00 02 00 00 }
ZXBASIC_LINE_4080:
; 4080  DATA "FISH",0,49,91,255,123,49,0,0
; 		4080.1  DATA "FISH",0{00 00 00 00 00 },49{00 00 31 00 00 },91{00 00 5b 00 00 },255{00 00 ff 00 00 },123{00 00 7b 00 00 },49{00 00 31 00 00 },0{00 00 00 00 00 },0{00 00 00 00 00 }
ZXBASIC_LINE_4090:
; 4090  DATA "DUMBELL",0,0,66,195,255,195,66,0
; 		4090.1  DATA "DUMBELL",0{00 00 00 00 00 },0{00 00 00 00 00 },66{00 00 42 00 00 },195{00 00 c3 00 00 },255{00 00 ff 00 00 },195{00 00 c3 00 00 },66{00 00 42 00 00 },0{00 00 00 00 00 }
ZXBASIC_LINE_4100:
; 4100  DATA "SWORD",3,5,10,84,40,112,232,192
; 		4100.1  DATA "SWORD",3{00 00 03 00 00 },5{00 00 05 00 00 },10{00 00 0a 00 00 },84{00 00 54 00 00 },40{00 00 28 00 00 },112{00 00 70 00 00 },232{00 00 e8 00 00 },192{00 00 c0 00 00 }
ZXBASIC_LINE_4110:
; 4110  DATA "SHIELD",254,226,226,226,226,100,40,16
; 		4110.1  DATA "SHIELD",254{00 00 fe 00 00 },226{00 00 e2 00 00 },226{00 00 e2 00 00 },226{00 00 e2 00 00 },226{00 00 e2 00 00 },100{00 00 64 00 00 },40{00 00 28 00 00 },16{00 00 10 00 00 }
ZXBASIC_LINE_4120:
; 4120  DATA "ROCKING HORSE",64,226,124,60,36,165,66,60
; 		4120.1  DATA "ROCKING HORSE",64{00 00 40 00 00 },226{00 00 e2 00 00 },124{00 00 7c 00 00 },60{00 00 3c 00 00 },36{00 00 24 00 00 },165{00 00 a5 00 00 },66{00 00 42 00 00 },60{00 00 3c 00 00 }
ZXBASIC_LINE_4130:
; 4130  DATA "BRICK WALL",187,187,0,239,239,0,187,187
; 		4130.1  DATA "BRICK WALL",187{00 00 bb 00 00 },187{00 00 bb 00 00 },0{00 00 00 00 00 },239{00 00 ef 00 00 },239{00 00 ef 00 00 },0{00 00 00 00 00 },187{00 00 bb 00 00 },187{00 00 bb 00 00 }
ZXBASIC_LINE_4140:
; 4140  DATA "SPIRAL",128,191,161,173,165,189,129,255
; 		4140.1  DATA "SPIRAL",128{00 00 80 00 00 },191{00 00 bf 00 00 },161{00 00 a1 00 00 },173{00 00 ad 00 00 },165{00 00 a5 00 00 },189{00 00 bd 00 00 },129{00 00 81 00 00 },255{00 00 ff 00 00 }
ZXBASIC_LINE_4150:
; 4150  DATA "CHERRY",15,18,100,180,246,107,15,6
; 		4150.1  DATA "CHERRY",15{00 00 0f 00 00 },18{00 00 12 00 00 },100{00 00 64 00 00 },180{00 00 b4 00 00 },246{00 00 f6 00 00 },107{00 00 6b 00 00 },15{00 00 0f 00 00 },6{00 00 06 00 00 }
ZXBASIC_LINE_4160:
; 4160  DATA "KEY",120,132,132,120,32,48,32,56
; 		4160.1  DATA "KEY",120{00 00 78 00 00 },132{00 00 84 00 00 },132{00 00 84 00 00 },120{00 00 78 00 00 },32{00 00 20 00 00 },48{00 00 30 00 00 },32{00 00 20 00 00 },56{00 00 38 00 00 }
ZXBASIC_LINE_4170:
; 4170  DATA "PADLOCK",56,68,68,0,124,108,108,124
; 		4170.1  DATA "PADLOCK",56{00 00 38 00 00 },68{00 00 44 00 00 },68{00 00 44 00 00 },0{00 00 00 00 00 },124{00 00 7c 00 00 },108{00 00 6c 00 00 },108{00 00 6c 00 00 },124{00 00 7c 00 00 }
ZXBASIC_LINE_4180:
; 4180  DATA "HOURGLASS",56,68,40,16,16,40,68,56
; 		4180.1  DATA "HOURGLASS",56{00 00 38 00 00 },68{00 00 44 00 00 },40{00 00 28 00 00 },16{00 00 10 00 00 },16{00 00 10 00 00 },40{00 00 28 00 00 },68{00 00 44 00 00 },56{00 00 38 00 00 }
ZXBASIC_LINE_4190:
; 4190  DATA "START FLAG",106,84,106,84,106,64,64,64
; 		4190.1  DATA "START FLAG",106{00 00 6a 00 00 },84{00 00 54 00 00 },106{00 00 6a 00 00 },84{00 00 54 00 00 },106{00 00 6a 00 00 },64{00 00 40 00 00 },64{00 00 40 00 00 },64{00 00 40 00 00 }
ZXBASIC_LINE_4200:
; 4200  DATA "TOBACCO PIPE",80,161,2,230,236,248,112,0
; 		4200.1  DATA "TOBACCO PIPE",80{00 00 50 00 00 },161{00 00 a1 00 00 },2{00 00 02 00 00 },230{00 00 e6 00 00 },236{00 00 ec 00 00 },248{00 00 f8 00 00 },112{00 00 70 00 00 },0{00 00 00 00 00 }
ZXBASIC_LINE_4210:
; 4210  DATA "ROOK",90,126,0,60,60,60,0,126
; 		4210.1  DATA "ROOK",90{00 00 5a 00 00 },126{00 00 7e 00 00 },0{00 00 00 00 00 },60{00 00 3c 00 00 },60{00 00 3c 00 00 },60{00 00 3c 00 00 },0{00 00 00 00 00 },126{00 00 7e 00 00 }
ZXBASIC_LINE_4220:
; 4220  DATA "WALKING STICK",16,40,8,8,8,8,8,8
; 		4220.1  DATA "WALKING STICK",16{00 00 10 00 00 },40{00 00 28 00 00 },8{00 00 08 00 00 },8{00 00 08 00 00 },8{00 00 08 00 00 },8{00 00 08 00 00 },8{00 00 08 00 00 },8{00 00 08 00 00 }
ZXBASIC_LINE_4230:
; 4230  DATA "UMBRELLA",0,56,124,254,16,16,80,32
; 		4230.1  DATA "UMBRELLA",0{00 00 00 00 00 },56{00 00 38 00 00 },124{00 00 7c 00 00 },254{00 00 fe 00 00 },16{00 00 10 00 00 },16{00 00 10 00 00 },80{00 00 50 00 00 },32{00 00 20 00 00 }
ZXBASIC_LINE_4240:
; 4240  DATA "MONITOR",255,129,129,129,129,255,24,60
; 		4240.1  DATA "MONITOR",255{00 00 ff 00 00 },129{00 00 81 00 00 },129{00 00 81 00 00 },129{00 00 81 00 00 },129{00 00 81 00 00 },255{00 00 ff 00 00 },24{00 00 18 00 00 },60{00 00 3c 00 00 }
ZXBASIC_LINE_4250:
; 4250  DATA "LIGHTNING",8,16,32,124,8,80,96,112
; 		4250.1  DATA "LIGHTNING",8{00 00 08 00 00 },16{00 00 10 00 00 },32{00 00 20 00 00 },124{00 00 7c 00 00 },8{00 00 08 00 00 },80{00 00 50 00 00 },96{00 00 60 00 00 },112{00 00 70 00 00 }
ZXBASIC_LINE_4260:
; 4260  DATA "CHESSBOARD",85,170,85,170,85,170,85,170
; 		4260.1  DATA "CHESSBOARD",85{00 00 55 00 00 },170{00 00 aa 00 00 },85{00 00 55 00 00 },170{00 00 aa 00 00 },85{00 00 55 00 00 },170{00 00 aa 00 00 },85{00 00 55 00 00 },170{00 00 aa 00 00 }
ZXBASIC_LINE_4270:
; 4270  DATA "SHIP",16,48,52,116,246,16,255,126
; 		4270.1  DATA "SHIP",16{00 00 10 00 00 },48{00 00 30 00 00 },52{00 00 34 00 00 },116{00 00 74 00 00 },246{00 00 f6 00 00 },16{00 00 10 00 00 },255{00 00 ff 00 00 },126{00 00 7e 00 00 }
ZXBASIC_LINE_4280:
; 4280  DATA "GRASS",0,1,66,36,148,84,85,85
; 		4280.1  DATA "GRASS",0{00 00 00 00 00 },1{00 00 01 00 00 },66{00 00 42 00 00 },36{00 00 24 00 00 },148{00 00 94 00 00 },84{00 00 54 00 00 },85{00 00 55 00 00 },85{00 00 55 00 00 }
ZXBASIC_LINE_4290:
; 4290  DATA "BUSH",33,18,148,92,57,154,92,56
; 		4290.1  DATA "BUSH",33{00 00 21 00 00 },18{00 00 12 00 00 },148{00 00 94 00 00 },92{00 00 5c 00 00 },57{00 00 39 00 00 },154{00 00 9a 00 00 },92{00 00 5c 00 00 },56{00 00 38 00 00 }
ZXBASIC_LINE_4300:
; 4300  DATA "TREE",34,20,217,58,92,24,24,60
; 		4300.1  DATA "TREE",34{00 00 22 00 00 },20{00 00 14 00 00 },217{00 00 d9 00 00 },58{00 00 3a 00 00 },92{00 00 5c 00 00 },24{00 00 18 00 00 },24{00 00 18 00 00 },60{00 00 3c 00 00 }
ZXBASIC_LINE_4310:
; 4310  DATA "GRID",255,170,255,170,255,170,255,170
; 		4310.1  DATA "GRID",255{00 00 ff 00 00 },170{00 00 aa 00 00 },255{00 00 ff 00 00 },170{00 00 aa 00 00 },255{00 00 ff 00 00 },170{00 00 aa 00 00 },255{00 00 ff 00 00 },170{00 00 aa 00 00 }
ZXBASIC_LINE_4320:
; 4320  DATA "WATER DROP",16,16,56,56,92,124,124,56
; 		4320.1  DATA "WATER DROP",16{00 00 10 00 00 },16{00 00 10 00 00 },56{00 00 38 00 00 },56{00 00 38 00 00 },92{00 00 5c 00 00 },124{00 00 7c 00 00 },124{00 00 7c 00 00 },56{00 00 38 00 00 }
ZXBASIC_LINE_4330:
; 4330  DATA "WAVES",6,9,144,96,0,24,36,67
; 		4330.1  DATA "WAVES",6{00 00 06 00 00 },9{00 00 09 00 00 },144{00 00 90 00 00 },96{00 00 60 00 00 },0{00 00 00 00 00 },24{00 00 18 00 00 },36{00 00 24 00 00 },67{00 00 43 00 00 }
ZXBASIC_LINE_4340:
; 4340  DATA "COIN",56,124,238,206,238,198,124,56
; 		4340.1  DATA "COIN",56{00 00 38 00 00 },124{00 00 7c 00 00 },238{00 00 ee 00 00 },206{00 00 ce 00 00 },238{00 00 ee 00 00 },198{00 00 c6 00 00 },124{00 00 7c 00 00 },56{00 00 38 00 00 }
ZXBASIC_LINE_4350:
; 4350  DATA "ICICLE",255,109,109,108,104,104,32,32
; 		4350.1  DATA "ICICLE",255{00 00 ff 00 00 },109{00 00 6d 00 00 },109{00 00 6d 00 00 },108{00 00 6c 00 00 },104{00 00 68 00 00 },104{00 00 68 00 00 },32{00 00 20 00 00 },32{00 00 20 00 00 }
ZXBASIC_LINE_4360:
; 4360  DATA "PILLAR",126,60,24,24,24,24,60,126
; 		4360.1  DATA "PILLAR",126{00 00 7e 00 00 },60{00 00 3c 00 00 },24{00 00 18 00 00 },24{00 00 18 00 00 },24{00 00 18 00 00 },24{00 00 18 00 00 },60{00 00 3c 00 00 },126{00 00 7e 00 00 }
ZXBASIC_LINE_4370:
; 4370  DATA "ARROW",15,3,5,9,16,32,64,128
; 		4370.1  DATA "ARROW",15{00 00 0f 00 00 },3{00 00 03 00 00 },5{00 00 05 00 00 },9{00 00 09 00 00 },16{00 00 10 00 00 },32{00 00 20 00 00 },64{00 00 40 00 00 },128{00 00 80 00 00 }
ZXBASIC_LINE_4380:
; 4380  DATA "WORM",112,168,250,137,113,49,27,14
; 		4380.1  DATA "WORM",112{00 00 70 00 00 },168{00 00 a8 00 00 },250{00 00 fa 00 00 },137{00 00 89 00 00 },113{00 00 71 00 00 },49{00 00 31 00 00 },27{00 00 1b 00 00 },14{00 00 0e 00 00 }
ZXBASIC_LINE_4390:
; 4390  DATA "BIRD",0,0,66,231,189,24,36,0
; 		4390.1  DATA "BIRD",0{00 00 00 00 00 },0{00 00 00 00 00 },66{00 00 42 00 00 },231{00 00 e7 00 00 },189{00 00 bd 00 00 },24{00 00 18 00 00 },36{00 00 24 00 00 },0{00 00 00 00 00 }
ZXBASIC_LINE_4400:
; 4400  DATA "ROCKET",16,56,124,124,124,124,254,214
; 		4400.1  DATA "ROCKET",16{00 00 10 00 00 },56{00 00 38 00 00 },124{00 00 7c 00 00 },124{00 00 7c 00 00 },124{00 00 7c 00 00 },124{00 00 7c 00 00 },254{00 00 fe 00 00 },214{00 00 d6 00 00 }
ZXBASIC_LINE_4410:
; 4410  DATA "MAGNET",220,222,7,3,3,7,222,220
; 		4410.1  DATA "MAGNET",220{00 00 dc 00 00 },222{00 00 de 00 00 },7{00 00 07 00 00 },3{00 00 03 00 00 },3{00 00 03 00 00 },7{00 00 07 00 00 },222{00 00 de 00 00 },220{00 00 dc 00 00 }
ZXBASIC_LINE_4420:
; 4420  DATA "HAMMER",124,126,124,16,16,16,16,16
; 		4420.1  DATA "HAMMER",124{00 00 7c 00 00 },126{00 00 7e 00 00 },124{00 00 7c 00 00 },16{00 00 10 00 00 },16{00 00 10 00 00 },16{00 00 10 00 00 },16{00 00 10 00 00 },16{00 00 10 00 00 }
ZXBASIC_LINE_4430:
; 4430  DATA "BOW",15,58,98,68,200,144,224,128
; 		4430.1  DATA "BOW",15{00 00 0f 00 00 },58{00 00 3a 00 00 },98{00 00 62 00 00 },68{00 00 44 00 00 },200{00 00 c8 00 00 },144{00 00 90 00 00 },224{00 00 e0 00 00 },128{00 00 80 00 00 }
ZXBASIC_LINE_4440:
; 4440  DATA "FLOWER",16,40,84,40,146,84,56,16
; 		4440.1  DATA "FLOWER",16{00 00 10 00 00 },40{00 00 28 00 00 },84{00 00 54 00 00 },40{00 00 28 00 00 },146{00 00 92 00 00 },84{00 00 54 00 00 },56{00 00 38 00 00 },16{00 00 10 00 00 }
ZXBASIC_LINE_4450:
; 4450  DATA "BAT",0,0,36,126,219,129,0,0
; 		4450.1  DATA "BAT",0{00 00 00 00 00 },0{00 00 00 00 00 },36{00 00 24 00 00 },126{00 00 7e 00 00 },219{00 00 db 00 00 },129{00 00 81 00 00 },0{00 00 00 00 00 },0{00 00 00 00 00 }
ZXBASIC_LINE_4460:
; 4460  DATA "COMET",1,8,34,8,96,20,208,192
; 		4460.1  DATA "COMET",1{00 00 01 00 00 },8{00 00 08 00 00 },34{00 00 22 00 00 },8{00 00 08 00 00 },96{00 00 60 00 00 },20{00 00 14 00 00 },208{00 00 d0 00 00 },192{00 00 c0 00 00 }
ZXBASIC_LINE_4470:
; 4470  DATA "DOT",0,0,0,16,0,0,0,0
; 		4470.1  DATA "DOT",0{00 00 00 00 00 },0{00 00 00 00 00 },0{00 00 00 00 00 },16{00 00 10 00 00 },0{00 00 00 00 00 },0{00 00 00 00 00 },0{00 00 00 00 00 },0{00 00 00 00 00 }
ZXBASIC_LINE_4480:
; 4480  DATA "CLOCK",126,239,239,225,255,255,126,0
; 		4480.1  DATA "CLOCK",126{00 00 7e 00 00 },239{00 00 ef 00 00 },239{00 00 ef 00 00 },225{00 00 e1 00 00 },255{00 00 ff 00 00 },255{00 00 ff 00 00 },126{00 00 7e 00 00 },0{00 00 00 00 00 }
ZXBASIC_LINE_4490:
; 4490  DATA "AXE",28,56,61,47,23,46,64,128
; 		4490.1  DATA "AXE",28{00 00 1c 00 00 },56{00 00 38 00 00 },61{00 00 3d 00 00 },47{00 00 2f 00 00 },23{00 00 17 00 00 },46{00 00 2e 00 00 },64{00 00 40 00 00 },128{00 00 80 00 00 }
ZXBASIC_LINE_4500:
; 4500  DATA "NECKLACE",10,32,129,0,66,24,60,24
; 		4500.1  DATA "NECKLACE",10{00 00 0a 00 00 },32{00 00 20 00 00 },129{00 00 81 00 00 },0{00 00 00 00 00 },66{00 00 42 00 00 },24{00 00 18 00 00 },60{00 00 3c 00 00 },24{00 00 18 00 00 }
ZXBASIC_LINE_4510:
; 4510  DATA "HEDGEHOG",20,42,85,122,93,254,127,36
; 		4510.1  DATA "HEDGEHOG",20{00 00 14 00 00 },42{00 00 2a 00 00 },85{00 00 55 00 00 },122{00 00 7a 00 00 },93{00 00 5d 00 00 },254{00 00 fe 00 00 },127{00 00 7f 00 00 },36{00 00 24 00 00 }
ZXBASIC_LINE_4520:
; 4520  STOP 
ZXBASIC_VAR_PROCdrawgrid0:	dw 0
ZXBASIC_VAR_PROCdrawgrid1:	dw 0
ZXBASIC_VAR_PROCdrawgridcolor:	dw 0
ZXBASIC_VAR_PROCdrawgridrowcolor:	dw 0
ZXBASIC_VAR_PROCdrawgridx:	dw 0
ZXBASIC_VAR_PROCdrawgridy:	dw 0
ZXBASIC_VAR_PROCgetsinglekeya:	dw 0
ZXBASIC_VAR_PROCinitgridh:	dw 0
ZXBASIC_VAR_PROCinitgridw:	dw 0
ZXBASIC_VAR_PROCkeyboarda:	dw 0
ZXBASIC_VAR_PROCselect0:	dw 0
ZXBASIC_VAR_PROCselect1:	dw 0
ZXBASIC_VAR_PROCshowpicture0:	dw 0
ZXBASIC_VAR_PROCshowpicture1:	dw 0
ZXBASIC_VAR_PROCshowpicture2:	dw 0
ZXBASIC_VAR_PROCshowpicture3:	dw 0
ZXBASIC_VAR_PROCunselect0:	dw 0
ZXBASIC_VAR_PROCunselect1:	dw 0
ZXBASIC_VAR_PROCwaitkeyreleasea:	dw 0
ZXBASIC_VAR_a:	dw 0
ZXBASIC_VAR_a_string:	dw 0
ZXBASIC_VAR_ax:	dw 0
ZXBASIC_VAR_ay:	dw 0
ZXBASIC_VAR_b:	dw 0
ZXBASIC_VAR_c:	dw 0
ZXBASIC_VAR_col:	dw 0
ZXBASIC_VAR_colSel1:	dw 0
ZXBASIC_VAR_colSel2:	dw 0
ZXBASIC_VAR_fieldx:	dw 0
ZXBASIC_VAR_fieldy:	dw 0
ZXBASIC_VAR_figures:	dw 0
ZXBASIC_VAR_for_i:	dw 0
ZXBASIC_VAR_for_j:	dw 0
ZXBASIC_VAR_for_x:	dw 0
ZXBASIC_VAR_for_y:	dw 0
ZXBASIC_VAR_found:	dw 0
ZXBASIC_VAR_g_array:	defs 200
ZXBASIC_VAR_gridh:	dw 0
ZXBASIC_VAR_gridw:	dw 0
ZXBASIC_VAR_i:	dw 0
ZXBASIC_VAR_j:	dw 0
ZXBASIC_VAR_key:	dw 0
ZXBASIC_VAR_key2:	dw 0
ZXBASIC_VAR_mouseb:	dw 0
ZXBASIC_VAR_mousex:	dw 0
ZXBASIC_VAR_mousey:	dw 0
ZXBASIC_VAR_moves:	dw 0
ZXBASIC_VAR_numSelected:	dw 0
ZXBASIC_VAR_o_array:	defs 200
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
ZXBASIC_VAR_start:	dw 0
ZXBASIC_VAR_t:	dw 0
ZXBASIC_VAR_temp:	dw 0
ZXBASIC_VAR_x:	dw 0
ZXBASIC_VAR_x1:	dw 0
ZXBASIC_VAR_x2:	dw 0
ZXBASIC_VAR_xSel1:	dw 0
ZXBASIC_VAR_xSel2:	dw 0
ZXBASIC_VAR_xx:	dw 0
ZXBASIC_VAR_y:	dw 0
ZXBASIC_VAR_y1:	dw 0
ZXBASIC_VAR_y2:	dw 0
ZXBASIC_VAR_ySel1:	dw 0
ZXBASIC_VAR_ySel2:	dw 0
ZXBASIC_VAR_yy:	dw 0
STRING_0:	dw 5
	db	"Error"
STRING_1:	dw 19
	db	"Press Key FOR left "
STRING_10:	dw 15
	db	"       ", 16, 1, 17, 6, 143, 143, 143, 143
STRING_11:	dw 12
	db	"1 = Keyboard"
STRING_12:	dw 12
	db	"2 = Kempston"
STRING_13:	dw 12
	db	"3 = Sinclair"
STRING_14:	dw 15
	db	"4 = Define keys"
STRING_15:	dw 9
	db	"0 = Start"
STRING_16:	dw 23
	db	"(C) 2025 Thomas Quester"
STRING_17:	dw 11
	db	"See https:/"
STRING_18:	dw 36
	db	"/github.com/tquester/ZXBasicCompiler"
STRING_19:	dw 11
	db	"M E M O R Y"
STRING_2:	dw 20
	db	"Press Key FOR right "
STRING_20:	dw 4
	db	"sel="
STRING_21:	dw 2
	db	"  "
STRING_22:	dw 6
	db	"moves:"
STRING_23:	dw 1
	db	" "
STRING_24:	dw 6
	db	"found:"
STRING_25:	dw 5
	db	"=MOVE"
STRING_26:	dw 6
	db	"ENTER="
STRING_27:	dw 6
	db	"SELECT"
STRING_28:	dw 6
	db	"Q=Quit"
STRING_29:	dw 9
	db	"R=Restart"
STRING_3:	dw 17
	db	"Press Key FOR up "
STRING_30:	dw 4
	db	"key="
STRING_31:	dw 13
	db	"Mixing cards "
STRING_32:	dw 27
	db	"                           "
STRING_33:	dw 3
	db	"   "
STRING_34:	dw 8
	db	"Figures="
STRING_35:	dw 7
	db	" start="
STRING_36:	dw 9
	db	" RESTORE="
STRING_37:	dw 1
	db	"A"
STRING_38:	dw 8
	db	"reading "
STRING_39:	dw 3
	db	" = "
STRING_4:	dw 19
	db	"Press Key FOR down "
STRING_40:	dw 2
	db	": "
STRING_41:	dw 1
	db	":"
STRING_5:	dw 19
	db	"Press Key FOR fire "
STRING_6:	dw 17
	db	"     ", 16, 1, 17, 6, 139, 131, 131, 131, 131, 131, 131, 135
STRING_7:	dw 25
	db	"     ", 16, 1, 17, 6, 138, 16, 7, 17, 1, "MEMORY", 16, 1, 17, 6, 133
STRING_8:	dw 17
	db	"     ", 16, 1, 17, 6, 142, 140, 140, 140, 140, 140, 140, 141
STRING_9:	dw 14
	db	"        ", 16, 1, 17, 6, 133, 138
ZXLINES:
	dw 1010, ZXBASIC_LINE_1010
	dw 1020, ZXBASIC_LINE_1020
	dw 1030, ZXBASIC_LINE_1030
	dw 1040, ZXBASIC_LINE_1040
	dw 1050, ZXBASIC_LINE_1050
	dw 1060, ZXBASIC_LINE_1060
	dw 1070, ZXBASIC_LINE_1070
	dw 1080, ZXBASIC_LINE_1080
	dw 1090, ZXBASIC_LINE_1090
	dw 1100, ZXBASIC_LINE_1100
	dw 1110, ZXBASIC_LINE_1110
	dw 1120, ZXBASIC_LINE_1120
	dw 1130, ZXBASIC_LINE_1130
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
	dw 1260, ZXBASIC_LINE_1260
	dw 1270, ZXBASIC_LINE_1270
	dw 1280, ZXBASIC_LINE_1280
	dw 1290, ZXBASIC_LINE_1290
	dw 1300, ZXBASIC_LINE_1300
	dw 1310, ZXBASIC_LINE_1310
	dw 1320, ZXBASIC_LINE_1320
	dw 1330, ZXBASIC_LINE_1330
	dw 1340, ZXBASIC_LINE_1340
	dw 1350, ZXBASIC_LINE_1350
	dw 1360, ZXBASIC_LINE_1360
	dw 1370, ZXBASIC_LINE_1370
	dw 1380, ZXBASIC_LINE_1380
	dw 1390, ZXBASIC_LINE_1390
	dw 1400, ZXBASIC_LINE_1400
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
	dw 1710, ZXBASIC_LINE_1710
	dw 1720, ZXBASIC_LINE_1720
	dw 1730, ZXBASIC_LINE_1730
	dw 1740, ZXBASIC_LINE_1740
	dw 1750, ZXBASIC_LINE_1750
	dw 1760, ZXBASIC_LINE_1760
	dw 1770, ZXBASIC_LINE_1770
	dw 1780, ZXBASIC_LINE_1780
	dw 1790, ZXBASIC_LINE_1790
	dw 1800, ZXBASIC_LINE_1800
	dw 1810, ZXBASIC_LINE_1810
	dw 1820, ZXBASIC_LINE_1820
	dw 1830, ZXBASIC_LINE_1830
	dw 1840, ZXBASIC_LINE_1840
	dw 1850, ZXBASIC_LINE_1850
	dw 1860, ZXBASIC_LINE_1860
	dw 1870, ZXBASIC_LINE_1870
	dw 1880, ZXBASIC_LINE_1880
	dw 1890, ZXBASIC_LINE_1890
	dw 1900, ZXBASIC_LINE_1900
	dw 1910, ZXBASIC_LINE_1910
	dw 1920, ZXBASIC_LINE_1920
	dw 1930, ZXBASIC_LINE_1930
	dw 1940, ZXBASIC_LINE_1940
	dw 1950, ZXBASIC_LINE_1950
	dw 1960, ZXBASIC_LINE_1960
	dw 1970, ZXBASIC_LINE_1970
	dw 1980, ZXBASIC_LINE_1980
	dw 1990, ZXBASIC_LINE_1990
	dw 2000, ZXBASIC_LINE_2000
	dw 2010, ZXBASIC_LINE_2010
	dw 2020, ZXBASIC_LINE_2020
	dw 2030, ZXBASIC_LINE_2030
	dw 2040, ZXBASIC_LINE_2040
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
	dw 2370, ZXBASIC_LINE_2370
	dw 2380, ZXBASIC_LINE_2380
	dw 2390, ZXBASIC_LINE_2390
	dw 2400, ZXBASIC_LINE_2400
	dw 2410, ZXBASIC_LINE_2410
	dw 2420, ZXBASIC_LINE_2420
	dw 2430, ZXBASIC_LINE_2430
	dw 2440, ZXBASIC_LINE_2440
	dw 2450, ZXBASIC_LINE_2450
	dw 2460, ZXBASIC_LINE_2460
	dw 2470, ZXBASIC_LINE_2470
	dw 2480, ZXBASIC_LINE_2480
	dw 2490, ZXBASIC_LINE_2490
	dw 2500, ZXBASIC_LINE_2500
	dw 2510, ZXBASIC_LINE_2510
	dw 2520, ZXBASIC_LINE_2520
	dw 2530, ZXBASIC_LINE_2530
	dw 2540, ZXBASIC_LINE_2540
	dw 2550, ZXBASIC_LINE_2550
	dw 2560, ZXBASIC_LINE_2560
	dw 2570, ZXBASIC_LINE_2570
	dw 2580, ZXBASIC_LINE_2580
	dw 2590, ZXBASIC_LINE_2590
	dw 2600, ZXBASIC_LINE_2600
	dw 2610, ZXBASIC_LINE_2610
	dw 2620, ZXBASIC_LINE_2620
	dw 2630, ZXBASIC_LINE_2630
	dw 2640, ZXBASIC_LINE_2640
	dw 2650, ZXBASIC_LINE_2650
	dw 2660, ZXBASIC_LINE_2660
	dw 2670, ZXBASIC_LINE_2670
	dw 2680, ZXBASIC_LINE_2680
	dw 2690, ZXBASIC_LINE_2690
	dw 2700, ZXBASIC_LINE_2700
	dw 2710, ZXBASIC_LINE_2710
	dw 2720, ZXBASIC_LINE_2720
	dw 2730, ZXBASIC_LINE_2730
	dw 2740, ZXBASIC_LINE_2740
	dw 2750, ZXBASIC_LINE_2750
	dw 2760, ZXBASIC_LINE_2760
	dw 2770, ZXBASIC_LINE_2770
	dw 2780, ZXBASIC_LINE_2780
	dw 2790, ZXBASIC_LINE_2790
	dw 2800, ZXBASIC_LINE_2800
	dw 2810, ZXBASIC_LINE_2810
	dw 2820, ZXBASIC_LINE_2820
	dw 2830, ZXBASIC_LINE_2830
	dw 2840, ZXBASIC_LINE_2840
	dw 2850, ZXBASIC_LINE_2850
	dw 2860, ZXBASIC_LINE_2860
	dw 2870, ZXBASIC_LINE_2870
	dw 2880, ZXBASIC_LINE_2880
	dw 2890, ZXBASIC_LINE_2890
	dw 2900, ZXBASIC_LINE_2900
	dw 2910, ZXBASIC_LINE_2910
	dw 2920, ZXBASIC_LINE_2920
	dw 2930, ZXBASIC_LINE_2930
	dw 2940, ZXBASIC_LINE_2940
	dw 2950, ZXBASIC_LINE_2950
	dw 2960, ZXBASIC_LINE_2960
	dw 2970, ZXBASIC_LINE_2970
	dw 2980, ZXBASIC_LINE_2980
	dw 2990, ZXBASIC_LINE_2990
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
	dw 3100, ZXBASIC_LINE_3100
	dw 3110, ZXBASIC_LINE_3110
	dw 3120, ZXBASIC_LINE_3120
	dw 3130, ZXBASIC_LINE_3130
	dw 3140, ZXBASIC_LINE_3140
	dw 3150, ZXBASIC_LINE_3150
	dw 3160, ZXBASIC_LINE_3160
	dw 3170, ZXBASIC_LINE_3170
	dw 3180, ZXBASIC_LINE_3180
	dw 3190, ZXBASIC_LINE_3190
	dw 3200, ZXBASIC_LINE_3200
	dw 3210, ZXBASIC_LINE_3210
	dw 3220, ZXBASIC_LINE_3220
	dw 3230, ZXBASIC_LINE_3230
	dw 3240, ZXBASIC_LINE_3240
	dw 3250, ZXBASIC_LINE_3250
	dw 3260, ZXBASIC_LINE_3260
	dw 3270, ZXBASIC_LINE_3270
	dw 3280, ZXBASIC_LINE_3280
	dw 3290, ZXBASIC_LINE_3290
	dw 3300, ZXBASIC_LINE_3300
	dw 3310, ZXBASIC_LINE_3310
	dw 3320, ZXBASIC_LINE_3320
	dw 3330, ZXBASIC_LINE_3330
	dw 3340, ZXBASIC_LINE_3340
	dw 3350, ZXBASIC_LINE_3350
	dw 3360, ZXBASIC_LINE_3360
	dw 3370, ZXBASIC_LINE_3370
	dw 3380, ZXBASIC_LINE_3380
	dw 3390, ZXBASIC_LINE_3390
	dw 3400, ZXBASIC_LINE_3400
	dw 3410, ZXBASIC_LINE_3410
	dw 3420, ZXBASIC_LINE_3420
	dw 3430, ZXBASIC_LINE_3430
	dw 3440, ZXBASIC_LINE_3440
	dw 3450, ZXBASIC_LINE_3450
	dw 3460, ZXBASIC_LINE_3460
	dw 3470, ZXBASIC_LINE_3470
	dw 3480, ZXBASIC_LINE_3480
	dw 3490, ZXBASIC_LINE_3490
	dw 3500, ZXBASIC_LINE_3500
	dw 3510, ZXBASIC_LINE_3510
	dw 3520, ZXBASIC_LINE_3520
	dw 3530, ZXBASIC_LINE_3530
	dw 3540, ZXBASIC_LINE_3540
	dw 3550, ZXBASIC_LINE_3550
	dw 3560, ZXBASIC_LINE_3560
	dw 3570, ZXBASIC_LINE_3570
	dw 3580, ZXBASIC_LINE_3580
	dw 3590, ZXBASIC_LINE_3590
	dw 3600, ZXBASIC_LINE_3600
	dw 3610, ZXBASIC_LINE_3610
	dw 3620, ZXBASIC_LINE_3620
	dw 3630, ZXBASIC_LINE_3630
	dw 3640, ZXBASIC_LINE_3640
	dw 3650, ZXBASIC_LINE_3650
	dw 3660, ZXBASIC_LINE_3660
	dw 3670, ZXBASIC_LINE_3670
	dw 3680, ZXBASIC_LINE_3680
	dw 3690, ZXBASIC_LINE_3690
	dw 3700, ZXBASIC_LINE_3700
	dw 3710, ZXBASIC_LINE_3710
	dw 3720, ZXBASIC_LINE_3720
	dw 3730, ZXBASIC_LINE_3730
	dw 3740, ZXBASIC_LINE_3740
	dw 3750, ZXBASIC_LINE_3750
	dw 3760, ZXBASIC_LINE_3760
	dw 3770, ZXBASIC_LINE_3770
	dw 3780, ZXBASIC_LINE_3780
	dw 3790, ZXBASIC_LINE_3790
	dw 3800, ZXBASIC_LINE_3800
	dw 3810, ZXBASIC_LINE_3810
	dw 3820, ZXBASIC_LINE_3820
	dw 3830, ZXBASIC_LINE_3830
	dw 3840, ZXBASIC_LINE_3840
	dw 3850, ZXBASIC_LINE_3850
	dw 3860, ZXBASIC_LINE_3860
	dw 3870, ZXBASIC_LINE_3870
	dw 3880, ZXBASIC_LINE_3880
	dw 3890, ZXBASIC_LINE_3890
	dw 3900, ZXBASIC_LINE_3900
	dw 3910, ZXBASIC_LINE_3910
	dw 3920, ZXBASIC_LINE_3920
	dw 3930, ZXBASIC_LINE_3930
	dw 3940, ZXBASIC_LINE_3940
	dw 3950, ZXBASIC_LINE_3950
	dw 3960, ZXBASIC_LINE_3960
	dw 3970, ZXBASIC_LINE_3970
	dw 3980, ZXBASIC_LINE_3980
	dw 3990, ZXBASIC_LINE_3990
	dw 4000, ZXBASIC_LINE_4000
	dw 4010, ZXBASIC_LINE_4010
	dw 4020, ZXBASIC_LINE_4020
	dw 4030, ZXBASIC_LINE_4030
	dw 4040, ZXBASIC_LINE_4040
	dw 4050, ZXBASIC_LINE_4050
	dw 4060, ZXBASIC_LINE_4060
	dw 4070, ZXBASIC_LINE_4070
	dw 4080, ZXBASIC_LINE_4080
	dw 4090, ZXBASIC_LINE_4090
	dw 4100, ZXBASIC_LINE_4100
	dw 4110, ZXBASIC_LINE_4110
	dw 4120, ZXBASIC_LINE_4120
	dw 4130, ZXBASIC_LINE_4130
	dw 4140, ZXBASIC_LINE_4140
	dw 4150, ZXBASIC_LINE_4150
	dw 4160, ZXBASIC_LINE_4160
	dw 4170, ZXBASIC_LINE_4170
	dw 4180, ZXBASIC_LINE_4180
	dw 4190, ZXBASIC_LINE_4190
	dw 4200, ZXBASIC_LINE_4200
	dw 4210, ZXBASIC_LINE_4210
	dw 4220, ZXBASIC_LINE_4220
	dw 4230, ZXBASIC_LINE_4230
	dw 4240, ZXBASIC_LINE_4240
	dw 4250, ZXBASIC_LINE_4250
	dw 4260, ZXBASIC_LINE_4260
	dw 4270, ZXBASIC_LINE_4270
	dw 4280, ZXBASIC_LINE_4280
	dw 4290, ZXBASIC_LINE_4290
	dw 4300, ZXBASIC_LINE_4300
	dw 4310, ZXBASIC_LINE_4310
	dw 4320, ZXBASIC_LINE_4320
	dw 4330, ZXBASIC_LINE_4330
	dw 4340, ZXBASIC_LINE_4340
	dw 4350, ZXBASIC_LINE_4350
	dw 4360, ZXBASIC_LINE_4360
	dw 4370, ZXBASIC_LINE_4370
	dw 4380, ZXBASIC_LINE_4380
	dw 4390, ZXBASIC_LINE_4390
	dw 4400, ZXBASIC_LINE_4400
	dw 4410, ZXBASIC_LINE_4410
	dw 4420, ZXBASIC_LINE_4420
	dw 4430, ZXBASIC_LINE_4430
	dw 4440, ZXBASIC_LINE_4440
	dw 4450, ZXBASIC_LINE_4450
	dw 4460, ZXBASIC_LINE_4460
	dw 4470, ZXBASIC_LINE_4470
	dw 4480, ZXBASIC_LINE_4480
	dw 4490, ZXBASIC_LINE_4490
	dw 4500, ZXBASIC_LINE_4500
	dw 4510, ZXBASIC_LINE_4510
	dw 4520, ZXBASIC_LINE_4520
	dw 0, 0
ZXDATA:
	dw 3890, DATA_3890
	dw 3900, DATA_3900
	dw 3910, DATA_3910
	dw 3920, DATA_3920
	dw 3930, DATA_3930
	dw 3940, DATA_3940
	dw 3950, DATA_3950
	dw 3960, DATA_3960
	dw 3970, DATA_3970
	dw 3980, DATA_3980
	dw 3990, DATA_3990
	dw 4000, DATA_4000
	dw 4010, DATA_4010
	dw 4020, DATA_4020
	dw 4030, DATA_4030
	dw 4040, DATA_4040
	dw 4050, DATA_4050
	dw 4060, DATA_4060
	dw 4070, DATA_4070
	dw 4080, DATA_4080
	dw 4090, DATA_4090
	dw 4100, DATA_4100
	dw 4110, DATA_4110
	dw 4120, DATA_4120
	dw 4130, DATA_4130
	dw 4140, DATA_4140
	dw 4150, DATA_4150
	dw 4160, DATA_4160
	dw 4170, DATA_4170
	dw 4180, DATA_4180
	dw 4190, DATA_4190
	dw 4200, DATA_4200
	dw 4210, DATA_4210
	dw 4220, DATA_4220
	dw 4230, DATA_4230
	dw 4240, DATA_4240
	dw 4250, DATA_4250
	dw 4260, DATA_4260
	dw 4270, DATA_4270
	dw 4280, DATA_4280
	dw 4290, DATA_4290
	dw 4300, DATA_4300
	dw 4310, DATA_4310
	dw 4320, DATA_4320
	dw 4330, DATA_4330
	dw 4340, DATA_4340
	dw 4350, DATA_4350
	dw 4360, DATA_4360
	dw 4370, DATA_4370
	dw 4380, DATA_4380
	dw 4390, DATA_4390
	dw 4400, DATA_4400
	dw 4410, DATA_4410
	dw 4420, DATA_4420
	dw 4430, DATA_4430
	dw 4440, DATA_4440
	dw 4450, DATA_4450
	dw 4460, DATA_4460
	dw 4470, DATA_4470
	dw 4480, DATA_4480
	dw 4490, DATA_4490
	dw 4500, DATA_4500
	dw 4510, DATA_4510
	dw 0, 0
DATAPTR:	DW 0
DATA_3890:
	dw 4
	db "CUBE"
	dw 31
	dw 35
	dw 69
	dw 249
	dw 137
	dw 137
	dw 138
	dw 252
DATA_3900:
	dw 6
	db "BUBBLE"
	dw 24
	dw 36
	dw 66
	dw 145
	dw 129
	dw 66
	dw 36
	dw 24
DATA_3910:
	dw 5
	db "LLAMA"
	dw 32
	dw 96
	dw 32
	dw 34
	dw 60
	dw 60
	dw 20
	dw 20
DATA_3920:
	dw 6
	db "SQUARE"
	dw 0
	dw 126
	dw 66
	dw 66
	dw 66
	dw 66
	dw 126
	dw 0
DATA_3930:
	dw 7
	db "TRIANGE"
	dw 16
	dw 16
	dw 40
	dw 40
	dw 68
	dw 68
	dw 130
	dw 254
DATA_3940:
	dw 5
	db "HEART"
	dw 0
	dw 108
	dw 254
	dw 254
	dw 254
	dw 124
	dw 56
	dw 16
DATA_3950:
	dw 5
	db "HOUSE"
	dw 60
	dw 126
	dw 255
	dw 0
	dw 126
	dw 78
	dw 74
	dw 122
DATA_3960:
	dw 4
	db "FORK"
	dw 84
	dw 84
	dw 84
	dw 56
	dw 16
	dw 16
	dw 16
	dw 16
DATA_3970:
	dw 9
	db "COFFE CUP"
	dw 36
	dw 72
	dw 0
	dw 254
	dw 133
	dw 134
	dw 132
	dw 120
DATA_3980:
	dw 12
	db "HUMAN FIGURE"
	dw 24
	dw 24
	dw 0
	dw 126
	dw 24
	dw 24
	dw 36
	dw 66
DATA_3990:
	dw 4
	db "HAND"
	dw 84
	dw 85
	dw 85
	dw 85
	dw 191
	dw 191
	dw 223
	dw 254
DATA_4000:
	dw 7
	db "HEADSET"
	dw 60
	dw 66
	dw 129
	dw 129
	dw 195
	dw 195
	dw 195
	dw 0
DATA_4010:
	dw 10
	db "EYEGLASSES"
	dw 0
	dw 0
	dw 33
	dw 66
	dw 254
	dw 170
	dw 238
	dw 0
DATA_4020:
	dw 5
	db "CROSS"
	dw 56
	dw 40
	dw 238
	dw 130
	dw 238
	dw 40
	dw 40
	dw 56
DATA_4030:
	dw 8
	db "ENVELOPE"
	dw 255
	dw 195
	dw 165
	dw 153
	dw 129
	dw 129
	dw 255
	dw 0
DATA_4040:
	dw 9
	db "MAGNIFIER"
	dw 48
	dw 72
	dw 164
	dw 132
	dw 72
	dw 52
	dw 2
	dw 1
DATA_4050:
	dw 3
	db "SUN"
	dw 145
	dw 66
	dw 24
	dw 61
	dw 188
	dw 24
	dw 66
	dw 137
DATA_4060:
	dw 5
	db "SKULL"
	dw 60
	dw 126
	dw 147
	dw 147
	dw 255
	dw 254
	dw 124
	dw 84
DATA_4070:
	dw 8
	db "SCISSORS"
	dw 0
	dw 2
	dw 197
	dw 38
	dw 24
	dw 38
	dw 197
	dw 2
DATA_4080:
	dw 4
	db "FISH"
	dw 0
	dw 49
	dw 91
	dw 255
	dw 123
	dw 49
	dw 0
	dw 0
DATA_4090:
	dw 7
	db "DUMBELL"
	dw 0
	dw 0
	dw 66
	dw 195
	dw 255
	dw 195
	dw 66
	dw 0
DATA_4100:
	dw 5
	db "SWORD"
	dw 3
	dw 5
	dw 10
	dw 84
	dw 40
	dw 112
	dw 232
	dw 192
DATA_4110:
	dw 6
	db "SHIELD"
	dw 254
	dw 226
	dw 226
	dw 226
	dw 226
	dw 100
	dw 40
	dw 16
DATA_4120:
	dw 13
	db "ROCKING HORSE"
	dw 64
	dw 226
	dw 124
	dw 60
	dw 36
	dw 165
	dw 66
	dw 60
DATA_4130:
	dw 10
	db "BRICK WALL"
	dw 187
	dw 187
	dw 0
	dw 239
	dw 239
	dw 0
	dw 187
	dw 187
DATA_4140:
	dw 6
	db "SPIRAL"
	dw 128
	dw 191
	dw 161
	dw 173
	dw 165
	dw 189
	dw 129
	dw 255
DATA_4150:
	dw 6
	db "CHERRY"
	dw 15
	dw 18
	dw 100
	dw 180
	dw 246
	dw 107
	dw 15
	dw 6
DATA_4160:
	dw 3
	db "KEY"
	dw 120
	dw 132
	dw 132
	dw 120
	dw 32
	dw 48
	dw 32
	dw 56
DATA_4170:
	dw 7
	db "PADLOCK"
	dw 56
	dw 68
	dw 68
	dw 0
	dw 124
	dw 108
	dw 108
	dw 124
DATA_4180:
	dw 9
	db "HOURGLASS"
	dw 56
	dw 68
	dw 40
	dw 16
	dw 16
	dw 40
	dw 68
	dw 56
DATA_4190:
	dw 10
	db "START FLAG"
	dw 106
	dw 84
	dw 106
	dw 84
	dw 106
	dw 64
	dw 64
	dw 64
DATA_4200:
	dw 12
	db "TOBACCO PIPE"
	dw 80
	dw 161
	dw 2
	dw 230
	dw 236
	dw 248
	dw 112
	dw 0
DATA_4210:
	dw 4
	db "ROOK"
	dw 90
	dw 126
	dw 0
	dw 60
	dw 60
	dw 60
	dw 0
	dw 126
DATA_4220:
	dw 13
	db "WALKING STICK"
	dw 16
	dw 40
	dw 8
	dw 8
	dw 8
	dw 8
	dw 8
	dw 8
DATA_4230:
	dw 8
	db "UMBRELLA"
	dw 0
	dw 56
	dw 124
	dw 254
	dw 16
	dw 16
	dw 80
	dw 32
DATA_4240:
	dw 7
	db "MONITOR"
	dw 255
	dw 129
	dw 129
	dw 129
	dw 129
	dw 255
	dw 24
	dw 60
DATA_4250:
	dw 9
	db "LIGHTNING"
	dw 8
	dw 16
	dw 32
	dw 124
	dw 8
	dw 80
	dw 96
	dw 112
DATA_4260:
	dw 10
	db "CHESSBOARD"
	dw 85
	dw 170
	dw 85
	dw 170
	dw 85
	dw 170
	dw 85
	dw 170
DATA_4270:
	dw 4
	db "SHIP"
	dw 16
	dw 48
	dw 52
	dw 116
	dw 246
	dw 16
	dw 255
	dw 126
DATA_4280:
	dw 5
	db "GRASS"
	dw 0
	dw 1
	dw 66
	dw 36
	dw 148
	dw 84
	dw 85
	dw 85
DATA_4290:
	dw 4
	db "BUSH"
	dw 33
	dw 18
	dw 148
	dw 92
	dw 57
	dw 154
	dw 92
	dw 56
DATA_4300:
	dw 4
	db "TREE"
	dw 34
	dw 20
	dw 217
	dw 58
	dw 92
	dw 24
	dw 24
	dw 60
DATA_4310:
	dw 4
	db "GRID"
	dw 255
	dw 170
	dw 255
	dw 170
	dw 255
	dw 170
	dw 255
	dw 170
DATA_4320:
	dw 10
	db "WATER DROP"
	dw 16
	dw 16
	dw 56
	dw 56
	dw 92
	dw 124
	dw 124
	dw 56
DATA_4330:
	dw 5
	db "WAVES"
	dw 6
	dw 9
	dw 144
	dw 96
	dw 0
	dw 24
	dw 36
	dw 67
DATA_4340:
	dw 4
	db "COIN"
	dw 56
	dw 124
	dw 238
	dw 206
	dw 238
	dw 198
	dw 124
	dw 56
DATA_4350:
	dw 6
	db "ICICLE"
	dw 255
	dw 109
	dw 109
	dw 108
	dw 104
	dw 104
	dw 32
	dw 32
DATA_4360:
	dw 6
	db "PILLAR"
	dw 126
	dw 60
	dw 24
	dw 24
	dw 24
	dw 24
	dw 60
	dw 126
DATA_4370:
	dw 5
	db "ARROW"
	dw 15
	dw 3
	dw 5
	dw 9
	dw 16
	dw 32
	dw 64
	dw 128
DATA_4380:
	dw 4
	db "WORM"
	dw 112
	dw 168
	dw 250
	dw 137
	dw 113
	dw 49
	dw 27
	dw 14
DATA_4390:
	dw 4
	db "BIRD"
	dw 0
	dw 0
	dw 66
	dw 231
	dw 189
	dw 24
	dw 36
	dw 0
DATA_4400:
	dw 6
	db "ROCKET"
	dw 16
	dw 56
	dw 124
	dw 124
	dw 124
	dw 124
	dw 254
	dw 214
DATA_4410:
	dw 6
	db "MAGNET"
	dw 220
	dw 222
	dw 7
	dw 3
	dw 3
	dw 7
	dw 222
	dw 220
DATA_4420:
	dw 6
	db "HAMMER"
	dw 124
	dw 126
	dw 124
	dw 16
	dw 16
	dw 16
	dw 16
	dw 16
DATA_4430:
	dw 3
	db "BOW"
	dw 15
	dw 58
	dw 98
	dw 68
	dw 200
	dw 144
	dw 224
	dw 128
DATA_4440:
	dw 6
	db "FLOWER"
	dw 16
	dw 40
	dw 84
	dw 40
	dw 146
	dw 84
	dw 56
	dw 16
DATA_4450:
	dw 3
	db "BAT"
	dw 0
	dw 0
	dw 36
	dw 126
	dw 219
	dw 129
	dw 0
	dw 0
DATA_4460:
	dw 5
	db "COMET"
	dw 1
	dw 8
	dw 34
	dw 8
	dw 96
	dw 20
	dw 208
	dw 192
DATA_4470:
	dw 3
	db "DOT"
	dw 0
	dw 0
	dw 0
	dw 16
	dw 0
	dw 0
	dw 0
	dw 0
DATA_4480:
	dw 5
	db "CLOCK"
	dw 126
	dw 239
	dw 239
	dw 225
	dw 255
	dw 255
	dw 126
	dw 0
DATA_4490:
	dw 3
	db "AXE"
	dw 28
	dw 56
	dw 61
	dw 47
	dw 23
	dw 46
	dw 64
	dw 128
DATA_4500:
	dw 8
	db "NECKLACE"
	dw 10
	dw 32
	dw 129
	dw 0
	dw 66
	dw 24
	dw 60
	dw 24
DATA_4510:
	dw 8
	db "HEDGEHOG"
	dw 20
	dw 42
	dw 85
	dw 122
	dw 93
	dw 254
	dw 127
	dw 36

ZX_VARIABLES:
	db 0

    DISPLAY "Compiled Basic = ", /D, $-CBASIC_START,  " bytes"
