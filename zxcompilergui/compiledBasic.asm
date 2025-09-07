
CBASIC_START
compiledBasic:
	call ZXHeapClear
	LD (runtimeSaveSP),SP
; 		1000.1  LET playerx=0{00 00 00 00 00 }
	LD A,1
	LD (23623),a
	LD HL,0
	LD (ZXBASIC_VAR_playerx),HL
ZXBASIC_LINE_1010:
; 1010  LET playery=0
	LD HL,1010
	LD (23621),HL
; 		1010.1  LET playery=0{00 00 00 00 00 }
	LD A,1
	LD (23623),a
	LD HL,0
	LD (ZXBASIC_VAR_playery),HL
ZXBASIC_LINE_1020:
; 1020  LET playerfire=0
	LD HL,1020
	LD (23621),HL
; 		1020.1  LET playerfire=0{00 00 00 00 00 }
	LD A,1
	LD (23623),a
	LD HL,0
	LD (ZXBASIC_VAR_playerfire),HL
ZXBASIC_LINE_1030:
; 1030  LET playerleft=0
	LD HL,1030
	LD (23621),HL
; 		1030.1  LET playerleft=0{00 00 00 00 00 }
	LD A,1
	LD (23623),a
	LD HL,0
	LD (ZXBASIC_VAR_playerleft),HL
ZXBASIC_LINE_1040:
; 1040  LET playerright=31
	LD HL,1040
	LD (23621),HL
; 		1040.1  LET playerright=31{00 00 1f 00 00 }
	LD A,1
	LD (23623),a
	LD HL,31
	LD (ZXBASIC_VAR_playerright),HL
ZXBASIC_LINE_1050:
; 1050  LET playerup=0
	LD HL,1050
	LD (23621),HL
; 		1050.1  LET playerup=0{00 00 00 00 00 }
	LD A,1
	LD (23623),a
	LD HL,0
	LD (ZXBASIC_VAR_playerup),HL
ZXBASIC_LINE_1060:
; 1060  LET playerdown=21
	LD HL,1060
	LD (23621),HL
; 		1060.1  LET playerdown=21{00 00 15 00 00 }
	LD A,1
	LD (23623),a
	LD HL,21
	LD (ZXBASIC_VAR_playerdown),HL
ZXBASIC_LINE_1070:
; 1070  LET playerKeyMoveLeft=113
	LD HL,1070
	LD (23621),HL
; 		1070.1  LET playerKeyMoveLeft=113{00 00 71 00 00 }
	LD A,1
	LD (23623),a
	LD HL,113
	LD (ZXBASIC_VAR_playerKeyMoveLeft),HL
ZXBASIC_LINE_1080:
; 1080  LET playerKeyMoveRight=119
	LD HL,1080
	LD (23621),HL
; 		1080.1  LET playerKeyMoveRight=119{00 00 77 00 00 }
	LD A,1
	LD (23623),a
	LD HL,119
	LD (ZXBASIC_VAR_playerKeyMoveRight),HL
ZXBASIC_LINE_1090:
; 1090  LET playerKeyMoveUp=112
	LD HL,1090
	LD (23621),HL
; 		1090.1  LET playerKeyMoveUp=112{00 00 70 00 00 }
	LD A,1
	LD (23623),a
	LD HL,112
	LD (ZXBASIC_VAR_playerKeyMoveUp),HL
ZXBASIC_LINE_1100:
; 1100  LET playerKeyMoveDown=108
	LD HL,1100
	LD (23621),HL
; 		1100.1  LET playerKeyMoveDown=108{00 00 6c 00 00 }
	LD A,1
	LD (23623),a
	LD HL,108
	LD (ZXBASIC_VAR_playerKeyMoveDown),HL
ZXBASIC_LINE_1110:
; 1110  LET playerKeyFire=13
	LD HL,1110
	LD (23621),HL
; 		1110.1  LET playerKeyFire=13{00 00 0d 00 00 }
	LD A,1
	LD (23623),a
	LD HL,13
	LD (ZXBASIC_VAR_playerKeyFire),HL
ZXBASIC_LINE_1120:
; 1120  LET playerKeyFire2=32
	LD HL,1120
	LD (23621),HL
; 		1120.1  LET playerKeyFire2=32{00 00 20 00 00 }
	LD A,1
	LD (23623),a
	LD HL,32
	LD (ZXBASIC_VAR_playerKeyFire2),HL
ZXBASIC_LINE_1130:
; 1130  GO SUB 1140
	LD HL,1130
	LD (23621),HL
; 		1130.1  GO SUB 1140{00 00 74 04 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_1140
ZXBASIC_LINE_1140:
; 1140  REM  SUB test
	LD HL,1140
	LD (23621),HL
	LD A,1
	LD (23623),a
ZXBASIC_LINE_1150:
; 1150  REM  ---------
	LD HL,1150
	LD (23621),HL
	LD A,1
	LD (23623),a
ZXBASIC_LINE_1160:
; 1160  GO SUB 1190
	LD HL,1160
	LD (23621),HL
; 		1160.1  GO SUB 1190{00 00 a6 04 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_1190
ZXBASIC_LINE_1170:
; 1170  GOTO 1160
	LD HL,1170
	LD (23621),HL
; 		1170.1  GOTO 1160{00 00 88 04 00 }
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	JP ZXBASIC_LINE_1160
ZXBASIC_LINE_1180:
; 1180  RETURN 
	LD HL,1180
	LD (23621),HL
; 		1180.1  RETURN 
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	RET
ZXBASIC_LINE_1190:
; 1190  REM  SUB keyboard
	LD HL,1190
	LD (23621),HL
	LD A,1
	LD (23623),a
ZXBASIC_LINE_1200:
; 1200  REM  -------------
	LD HL,1200
	LD (23621),HL
	LD A,1
	LD (23623),a
ZXBASIC_LINE_1210:
; 1210  LET PROCkeyboarda= CODE  INKEY$ 
	LD HL,1210
	LD (23621),HL
; 		1210.1  LET PROCkeyboarda= CODE  INKEY$ 
	LD A,1
	LD (23623),a
; CODE
; INKEY$
	CALL runtimeInkey
	CALL runtimeCode
	LD (ZXBASIC_VAR_PROCkeyboarda),HL
	CALL ZXFreeTempCompact
ZXBASIC_LINE_1220:
; 1220  LET playerx=playerx+((PROCkeyboarda=playerKeyMoveRight OR PROCkeyboarda=9) AND playerx<playerright)-((PROCkeyboarda=playerKeyMoveLeft OR PROCkeyboarda=8) AND playerx>playerleft)
	LD HL,1220
	LD (23621),HL
; 		1220.1  LET playerx=playerx+((PROCkeyboarda=playerKeyMoveRight OR PROCkeyboarda=9{00 00 09 00 00 }) AND playerx<playerright)-((PROCkeyboarda=playerKeyMoveLeft OR PROCkeyboarda=8{00 00 08 00 00 }) AND playerx>playerleft)
	LD A,1
	LD (23623),a
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
ZXBASIC_LINE_1230:
; 1230  LET playery=playery+(PROCkeyboarda=playerKeyMoveDown OR PROCkeyboarda=10)-(PROCkeyboarda=playerKeyMoveUp OR PROCkeyboarda=11)
	LD HL,1230
	LD (23621),HL
; 		1230.1  LET playery=playery+(PROCkeyboarda=playerKeyMoveDown OR PROCkeyboarda=10{00 00 0a 00 00 })-(PROCkeyboarda=playerKeyMoveUp OR PROCkeyboarda=11{00 00 0b 00 00 })
	LD A,1
	LD (23623),a
	LD HL,(ZXBASIC_VAR_playery)
	PUSH HL
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
; )
; +
	POP DE
	ADD HL,DE
	PUSH HL
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
; )
; -
	POP DE
	EX HL,DE
	SUB HL,DE
	LD (ZXBASIC_VAR_playery),HL
ZXBASIC_LINE_1240:
; 1240  PRINT  AT 0,0;"Key=";PROCkeyboarda;" x=";playerx;" y=";playery;"  ";
	LD HL,1240
	LD (23621),HL
; 		1240.1  PRINT  AT 0{00 00 00 00 00 },0{00 00 00 00 00 };"Key=";PROCkeyboarda;" x=";playerx;" y=";playery;"  ";
	LD A,1
	LD (23623),a
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,0
	LD HL,0
	CALL runtimePrintAt
	LD HL,STRING_0	;Key=
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_PROCkeyboarda)
	CALL runtimePrintInt
	LD HL,STRING_1	; x=
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_playerx)
	CALL runtimePrintInt
	LD HL,STRING_2	; y=
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_playery)
	CALL runtimePrintInt
	LD HL,STRING_3	;  
	CALL runtimePrintString
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1250:
; 1250  RETURN 
	LD HL,1250
	LD (23621),HL
; 		1250.1  RETURN 
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	RET
ZXBASIC_LINE_1260:
; 1260  STOP \000
	LD HL,1260
	LD (23621),HL
ZXBASIC_VAR_PROCkeyboarda:	dw 0
ZXBASIC_VAR_playerKeyFire:	dw 0
ZXBASIC_VAR_playerKeyFire2:	dw 0
ZXBASIC_VAR_playerKeyMoveDown:	dw 0
ZXBASIC_VAR_playerKeyMoveLeft:	dw 0
ZXBASIC_VAR_playerKeyMoveRight:	dw 0
ZXBASIC_VAR_playerKeyMoveUp:	dw 0
ZXBASIC_VAR_playerdown:	dw 0
ZXBASIC_VAR_playerfire:	dw 0
ZXBASIC_VAR_playerleft:	dw 0
ZXBASIC_VAR_playerright:	dw 0
ZXBASIC_VAR_playerup:	dw 0
ZXBASIC_VAR_playerx:	dw 0
ZXBASIC_VAR_playery:	dw 0
STRING_0:	dw 4
	db	"Key="
STRING_1:	dw 3
	db	" x="
STRING_2:	dw 3
	db	" y="
STRING_3:	dw 2
	db	"  "

ZX_VARIABLES:
	db 0

    DISPLAY "Compiled Basic = ", /D, $-CBASIC_START,  " bytes"