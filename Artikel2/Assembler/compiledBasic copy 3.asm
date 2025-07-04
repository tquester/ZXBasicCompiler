
CBASIC_START
compiledBasic:
ZX_LINE_100:
	LD HL, 6 
	CALL runtimePaper
	LD HL, 1
	CALL runtimeInk
ZX_LINE_105:
;105  CLS 
	CALL runtimeCls
ZX_LINE_106:
;106  GOSUB 3000{00 00 b8 0b 00 }
	CALL ZX_LINE_3000:
ZX_LINE_110:
;110  GOSUB 1100{00 00 4c 04 00 }
	CALL ZX_LINE_1100:
ZX_LINE_111:
;111  PRINT  AT 1{00 00 01 00 00 },2{00 00 02 00 00 };"Bildschirm scrollen mit POKE"
	LD HL, 1
	PUSH HL
	LD HL, 2
	POP DE
	CALL runtimePrintAt
	LD HL, STRING_0
	CALL runtimePrintString
	CALL runtimePrintNewline
ZX_LINE_115:
;115  FOR s=1{00 00 01 00 00 } TO 10{00 00 0a 00 00 }: GOSUB 1200{00 00 b0 04 00 }: NEXT s
	LD HL, 1
;Store s
	LD (ZXBASIC_VAR_s),HL
;---
	LD HL, 10
	PUSH HL
	LD HL, 1
	PUSH HL
FOR_0:
	CALL ZX_LINE_1200:
	LD HL,0
	ADD HL,SP
	LD IX,HL
	LD HL,(ZXBASIC_VAR_s)
	LD BC,(IX+0)
	ADD HL,BC
	LD (ZXBASIC_VAR_s),HL
	LD DE,(IX+2)
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_0
	POP AF
	POP AF
ZX_LINE_116:
;116  CLS 
	CALL runtimeCls
ZX_LINE_120:
;120  GOSUB 1000{00 00 e8 03 00 }
	CALL ZX_LINE_1000:
ZX_LINE_130:
;130  GOTO 100{00 00 64 00 00 }
	JP ZX_LINE_100
ZX_LINE_190:
;190  PRINT  INK 2{00 00 02 00 00 }; AT 0{00 00 00 00 00 },9{00 00 09 00 00 };"line fill demo"
	LD HL, 2
	CALL runtimeLocalInk
	LD HL, 0
	PUSH HL
	LD HL, 9
	POP DE
	CALL runtimePrintAt
	LD HL, STRING_1
	CALL runtimePrintString
	CALL runtimePrintNewline
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
ZX_LINE_200:
;200  PRINT  OVER 1{00 00 01 00 00 };  BRIGHT 1{00 00 01 00 00 }; PAPER 4{00 00 04 00 00 }; AT 21{00 00 15 00 00 },5{00 00 05 00 00 }; FLASH 1{00 00 01 00 00 };"(C)"; FLASH 0{00 00 00 00 00 };" Thomas Quester";
	LD HL, 1
	CALL runtimeLocalOver
	LD HL, 1
	CALL runtimeLocalBright
	LD HL, 4
	CALL runtimeLocalPaper
	LD HL, 21
	PUSH HL
	LD HL, 5
	POP DE
	CALL runtimePrintAt
	LD HL, 1
	CALL runtimeLocalFlash
	LD HL, STRING_2
	CALL runtimePrintString
	LD HL, 0
	CALL runtimeLocalFlash
	LD HL, STRING_3
	CALL runtimePrintString
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
ZX_LINE_1000:
;1000  LET x=1{00 00 01 00 00 }: LET y=21{00 00 15 00 00 }: LET dx=1{00 00 01 00 00 }: LET dy=1{00 00 01 00 00 }
	LD HL, 1
;Store x
	LD (ZXBASIC_VAR_x),HL
;---
	LD HL, 21
;Store y
	LD (ZXBASIC_VAR_y),HL
;---
	LD HL, 1
;Store dx
	LD (ZXBASIC_VAR_dx),HL
;---
	LD HL, 1
;Store dy
	LD (ZXBASIC_VAR_dy),HL
;---
ZX_LINE_1005:
;1005  FOR i=1{00 00 01 00 00 } TO 2000{00 00 d0 07 00 }
	LD HL, 1
;Store i
	LD (ZXBASIC_VAR_i),HL
;---
	LD HL, 2000
	PUSH HL
ZX_LINE_1010:
;1010  PLOT  OVER 1{00 00 01 00 00 }; INK 3{00 00 03 00 00 };x,y
	LD HL, 1
	PUSH HL
FOR_1:
	LD HL, 1
	CALL runtimeLocalOver
	LD HL, 3
	CALL runtimeLocalInk
	LD HL, (ZXBASIC_VAR_x)
	PUSH HL
	LD HL, (ZXBASIC_VAR_y)
	POP DE
	LD B,L
	LD C,E
	CALL runtimePlot
ZX_LINE_1020:
;1020  LET x=x+dx
	LD HL, (ZXBASIC_VAR_x)
	PUSH HL
	LD HL, (ZXBASIC_VAR_dx)
;+
	POP DE
	ADD HL, DE
;---
;Store x
	LD (ZXBASIC_VAR_x),HL
;---
ZX_LINE_1030:
;1030  LET y=y+dy
	LD HL, (ZXBASIC_VAR_y)
	PUSH HL
	LD HL, (ZXBASIC_VAR_dy)
;+
	POP DE
	ADD HL, DE
;---
;Store y
	LD (ZXBASIC_VAR_y),HL
;---
ZX_LINE_1040:
;1040  IF x <= 1{00 00 01 00 00 } ORX x >= 250{00 00 fa 00 00 } THEN  LET dx=0{00 00 00 00 00 }-dx
	LD HL, (ZXBASIC_VAR_x)
	PUSH HL
	LD HL, 1
;<=
	POP DE
	SUB HL,DE
	LD HL,0
	call nc,HL1
	call z,HL1
;---
	PUSH HL
	LD HL, (ZXBASIC_VAR_x)
	PUSH HL
	LD HL, 250
;>=
	POP DE
	SUB HL,DE
	LD HL,0
	call c,HL1
	call z,HL1
;---
;OR
	POP DE
	LD A,L
	OR E
	LD L,A
	LD H,0
;---
;check for 0
	LD A,L
	CP 0
	JR Z,ZXB_LABEL_1
;---
	LD HL, 0
	PUSH HL
	LD HL, (ZXBASIC_VAR_dx)
;-
	POP DE
	EX HL,DE
	SUB HL, DE
;---
;Store dx
	LD (ZXBASIC_VAR_dx),HL
;---
ZXB_LABEL_1:
ZX_LINE_1050:
;1050  IF y <= 20{00 00 14 00 00 } ORX y >= 160{00 00 a0 00 00 } THEN  LET dy=0{00 00 00 00 00 }-dy
	LD HL, (ZXBASIC_VAR_y)
	PUSH HL
	LD HL, 20
;<=
	POP DE
	SUB HL,DE
	LD HL,0
	call nc,HL1
	call z,HL1
;---
	PUSH HL
	LD HL, (ZXBASIC_VAR_y)
	PUSH HL
	LD HL, 160
;>=
	POP DE
	SUB HL,DE
	LD HL,0
	call c,HL1
	call z,HL1
;---
;OR
	POP DE
	LD A,L
	OR E
	LD L,A
	LD H,0
;---
;check for 0
	LD A,L
	CP 0
	JR Z,ZXB_LABEL_2
;---
	LD HL, 0
	PUSH HL
	LD HL, (ZXBASIC_VAR_dy)
;-
	POP DE
	EX HL,DE
	SUB HL, DE
;---
;Store dy
	LD (ZXBASIC_VAR_dy),HL
;---
ZXB_LABEL_2:
ZX_LINE_1060:
;1060  NEXT i
	LD HL,0
	ADD HL,SP
	LD IX,HL
	LD HL,(ZXBASIC_VAR_i)
	LD BC,(IX+0)
	ADD HL,BC
	LD (ZXBASIC_VAR_i),HL
	LD DE,(IX+2)
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_1
	POP AF
	POP AF
ZX_LINE_1070:
;1070  RETURN 
	RET
ZX_LINE_1100:
;1100  REM 
ZX_LINE_1120:
;1120  FOR i=0{00 00 00 00 00 } TO 255{00 00 ff 00 00 } STEP 3{00 00 03 00 00 }
	LD HL, 0
;Store i
	LD (ZXBASIC_VAR_i),HL
;---
	LD HL, 255
	PUSH HL
	LD HL, 3
	PUSH HL
FOR_2:
ZX_LINE_1130:
;1130  PLOT  INK 1{00 00 01 00 00 };i,0{00 00 00 00 00 }
	LD HL, 1
	CALL runtimeLocalInk
	LD HL, (ZXBASIC_VAR_i)
	PUSH HL
	LD HL, 0
	POP DE
	LD B,L
	LD C,E
	CALL runtimePlot
ZX_LINE_1140:
;1140  DRAW  INK 1{00 00 01 00 00 };255{00 00 ff 00 00 }-i,170{00 00 aa 00 00 }
	LD HL, 1
	CALL runtimeLocalInk
	LD HL, 255
	PUSH HL
	LD HL, (ZXBASIC_VAR_i)
;-
	POP DE
	EX HL,DE
	SUB HL, DE
;---
	PUSH HL
	LD HL, 170
	POP DE
	LD B,L
	LD C,E
	CALL runtimeDraw
ZX_LINE_1150:
;1150  NEXT i
	LD HL,0
	ADD HL,SP
	LD IX,HL
	LD HL,(ZXBASIC_VAR_i)
	LD BC,(IX+0)
	ADD HL,BC
	LD (ZXBASIC_VAR_i),HL
	LD DE,(IX+2)
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_2
	POP AF
	POP AF
ZX_LINE_1155:
;1155  RETURN 
	RET
ZX_LINE_1160:
;1160  FOR i=1{00 00 01 00 00 } TO 170{00 00 aa 00 00 } STEP 3{00 00 03 00 00 }
	LD HL, 1
;Store i
	LD (ZXBASIC_VAR_i),HL
;---
	LD HL, 170
	PUSH HL
	LD HL, 1
	PUSH HL
FOR_3:
ZX_LINE_1170:
;1170  PLOT  INK 2{00 00 02 00 00 };0{00 00 00 00 00 },i
	LD HL, 2
	CALL runtimeLocalInk
	LD HL, 0
	PUSH HL
	LD HL, (ZXBASIC_VAR_i)
	POP DE
	LD B,L
	LD C,E
	CALL runtimePlot
ZX_LINE_1180:
;1180  DRAW  INK 2{00 00 02 00 00 };255{00 00 ff 00 00 },170{00 00 aa 00 00 }-i
	LD HL, 2
	CALL runtimeLocalInk
	LD HL, 255
	PUSH HL
	LD HL, 170
	PUSH HL
	LD HL, (ZXBASIC_VAR_i)
;-
	POP DE
	EX HL,DE
	SUB HL, DE
;---
	POP DE
	LD B,L
	LD C,E
	CALL runtimeDraw
ZX_LINE_1190:
;1190  NEXT i
	LD HL,0
	ADD HL,SP
	LD IX,HL
	LD HL,(ZXBASIC_VAR_i)
	LD BC,(IX+0)
	ADD HL,BC
	LD (ZXBASIC_VAR_i),HL
	LD DE,(IX+2)
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_3
	POP AF
	POP AF
ZX_LINE_1195:
;1195  RETURN 
	RET
ZX_LINE_1200:

				LD HL,$4000
				ld D,H
				LD E,L
				
				ld b,192
				inc HL
				ld	a,0
ScrollLoop:		push BC
				ld  bc,31
				LDIR 
				ld (DE),a
				inc hl
				inc de

				pop bc
				djnz ScrollLoop
				ret



;1200  REM Scroll left
ZX_LINE_1210:	LD HL, 16384
;1210  LET adr=16384
				LD (ZXBASIC_VAR_adr),HL
ZX_LINE_1220: 	LD HL, 1
				LD (ZXBASIC_VAR_l),HL
				LD  B,191
FOR_4:			PUSH BC
				LD HL, (ZXBASIC_VAR_adr)
				LD (ZXBASIC_VAR_adrl),HL
ZX_LINE_1240:	LD B,31
				LD HL, (ZXBASIC_VAR_adrl)
FOR_5:			INC  HL
				LD   A,(HL)
				DEC  HL
				LD (HL),A
				INC  HL
				DJNZ FOR_5
;1260  POKE adr+31,0
ZX_LINE_1260: 	LD DE, (ZXBASIC_VAR_adr)
				LD HL, 31
				ADD HL, DE
				LD  A,0
				LD (HL),A
;1270  LET adr=adr+32{00 00 20 00 00 }
ZX_LINE_1270:	LD DE, (ZXBASIC_VAR_adr)
				LD HL, 32
				ADD HL, DE
				LD (ZXBASIC_VAR_adr),HL
ZX_LINE_1280:	POP  BC
				DJNZ FOR_4
ZX_LINE_1290:	RET
ZX_LINE_3000:
;3000  DATA 24{00 00 18 00 00 },60{00 00 3c 00 00 },126{00 00 7e 00 00 },219{00 00 db 00 00 },255{00 00 ff 00 00 },36{00 00 24 00 00 },90{00 00 5a 00 00 },165{00 00 a5 00 00 }
ZX_LINE_3010:
;3010  DATA 60{00 00 3c 00 00 },66{00 00 42 00 00 },102{00 00 66 00 00 },153{00 00 99 00 00 },129{00 00 81 00 00 },90{00 00 5a 00 00 },66{00 00 42 00 00 },60{00 00 3c 00 00 }
ZX_LINE_3020:
;3020  DATA 0{00 00 00 00 00 },0{00 00 00 00 00 },255{00 00 ff 00 00 },153{00 00 99 00 00 },255{00 00 ff 00 00 },129{00 00 81 00 00 },255{00 00 ff 00 00 },36{00 00 24 00 00 }
ZX_LINE_3100:
;3100  LET pos= USR "A"
	LD HL, STRING_4
	CALL runtimeUsrUDG
;Store pos
	LD (ZXBASIC_VAR_pos),HL
;---
ZX_LINE_3110:
;3110  RESTORE 3000{00 00 b8 0b 00 }
	LD HL,DATA_3000
	LD (DATAPTR),HL
ZX_LINE_3120:
;3120  LET pos=65368{00 00 58 ff 00 }
	LD HL, 65368
;Store pos
	LD (ZXBASIC_VAR_pos),HL
;---
ZX_LINE_3130:
;3130  FOR i=1{00 00 01 00 00 } TO 3{00 00 03 00 00 }
	LD HL, 1
;Store i
	LD (ZXBASIC_VAR_i),HL
;---
	LD HL, 3
	PUSH HL
ZX_LINE_3140:
;3140  FOR j=1{00 00 01 00 00 } TO 8{00 00 08 00 00 }
	LD HL, 1
	PUSH HL
FOR_6:
	LD HL, 1
;Store j
	LD (ZXBASIC_VAR_j),HL
;---
	LD HL, 8
	PUSH HL
ZX_LINE_3150:
;3150  READ a
	LD HL, 1
	PUSH HL
FOR_7:
	LD HL,(DATAPTR)
	LD DE,(HL)
	INC HL
	INC HL
	LD (DATAPTR),HL
	LD (ZXBASIC_VAR_a),DE
ZX_LINE_3160:
;3160  POKE pos,a
	LD HL, (ZXBASIC_VAR_pos)
	PUSH HL
	LD HL, (ZXBASIC_VAR_a)
	POP DE
	EX HL,DE
	LD (HL),E
ZX_LINE_3170:
;3170  LET pos=pos+1{00 00 01 00 00 }
	LD HL, (ZXBASIC_VAR_pos)
	PUSH HL
	LD HL, 1
;+
	POP DE
	ADD HL, DE
;---
;Store pos
	LD (ZXBASIC_VAR_pos),HL
;---
ZX_LINE_3180:
;3180  NEXT j
	LD HL,0
	ADD HL,SP
	LD IX,HL
	LD HL,(ZXBASIC_VAR_j)
	LD BC,(IX+0)
	ADD HL,BC
	LD (ZXBASIC_VAR_j),HL
	LD DE,(IX+2)
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_7
	POP AF
	POP AF
ZX_LINE_3190:
;3190  NEXT i
	LD HL,0
	ADD HL,SP
	LD IX,HL
	LD HL,(ZXBASIC_VAR_i)
	LD BC,(IX+0)
	ADD HL,BC
	LD (ZXBASIC_VAR_i),HL
	LD DE,(IX+2)
	EX HL,DE
	SUB HL,DE
	JP NC,FOR_6
	POP AF
	POP AF
ZX_LINE_3200:
;3200  PRINT  INK 1{00 00 01 00 00 }; AT 0{00 00 00 00 00 },0{00 00 00 00 00 };"UDG:";
	LD HL, 1
	CALL runtimeLocalInk
	LD HL, 0
	PUSH HL
	LD HL, 0
	POP DE
	CALL runtimePrintAt
	LD HL, STRING_5
	CALL runtimePrintString
	LD A,(ZX_ATTR_P)
	LD (ZX_ATTR_T),A
ZX_LINE_3210:
;3210  RETURN 
	RET
ZX_LINE_9999:
;9999  STOP 
ZXBASIC_VAR_a:	dw 0
ZXBASIC_VAR_adr:	dw 0
ZXBASIC_VAR_adrl:	dw 0
ZXBASIC_VAR_dx:	dw 0
ZXBASIC_VAR_dy:	dw 0
ZXBASIC_VAR_i:	dw 0
ZXBASIC_VAR_j:	dw 0
ZXBASIC_VAR_l:	dw 0
ZXBASIC_VAR_p:	dw 0
ZXBASIC_VAR_pos:	dw 0
ZXBASIC_VAR_s:	dw 0
ZXBASIC_VAR_x:	dw 0
ZXBASIC_VAR_y:	dw 0
STRING_0:	dw 28
	db"Bildschirm scrollen mit POKE"
STRING_1:	dw 14
	db"line fill demo"
STRING_2:	dw 3
	db"(C)"
STRING_3:	dw 15
	db" Thomas Quester"
STRING_4:	dw 1
	db"A"
STRING_5:	dw 7
	db	"UDG:",144,145,146
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

	defs 




    DISPLAY "Compiled Basic = ", /D, $-CBASIC_START,  " bytes"