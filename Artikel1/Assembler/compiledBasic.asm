
compiledBasic:
ZX_LINE_1000:
;1000  LET x=1{00 00 01 00 00 }: LET y=1{00 00 01 00 00 }: LET dx=1{00 00 01 00 00 }: LET dy=1{00 00 01 00 00 }

	LD HL, 1
;Store x
	LD (ZXBASIC_VAR_x),HL
;---
	LD HL, 1
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
ZX_LINE_1010:
;1010  PLOT x,y

	LD HL, (ZXBASIC_VAR_x)
	PUSH HL
	LD HL, (ZXBASIC_VAR_y)
	POP DE
	LD B,L
	LD C,E
	CALL RuntimePlot
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
	call c,HL1
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
	call nc,HL1
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
;1050  IF y <= 1{00 00 01 00 00 } ORX y >= 160{00 00 a0 00 00 } THEN  LET dy=0{00 00 00 00 00 }-dy

	LD HL, (ZXBASIC_VAR_y)
	PUSH HL
	LD HL, 1
;<=
	POP DE
	SUB HL,DE
	LD HL,0
	call c,HL1
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
	call nc,HL1
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
;1060  GOTO 1010{00 00 f2 03 00 }

	JP ZX_LINE_1010
ZX_LINE_30720:
;30720  GOTO 1010{00 00 f2 03 00 }

ZXBASIC_VAR_dx:	dw 0
ZXBASIC_VAR_dy:	dw 0
ZXBASIC_VAR_x:	dw 0
ZXBASIC_VAR_y:	dw 0
