
CBASIC_START
compiledBasic:
	call ZXHeapClear
	LD (runtimeSaveSP),SP
; 1020.1  DIM a$(8)
	LD HL,ZXBASIC_VAR_a_string
	LD BC,9
	CALL runtimeClearStringArray
; 1030.1  DIM b$(8)
	LD HL,ZXBASIC_VAR_b_string
	LD BC,9
	CALL runtimeClearStringArray
	LD A,1
	LD (23623),a
ZXBASIC_LINE_1010:
; 1010  REM  int16 ai bi
	LD HL,1010
	LD (23621),HL
	LD A,1
	LD (23623),a
ZXBASIC_LINE_1020:
; 1020  DIM a$(8)
	LD HL,1020
	LD (23621),HL
; 		1020.1  DIM a$(8{00 00 08 00 00 })
	LD A,1
	LD (23623),a
	LD HL,ZXBASIC_VAR_a_string
	LD BC,9
	CALL runtimeClearStringArray
ZXBASIC_LINE_1030:
; 1030  DIM b$(8)
	LD HL,1030
	LD (23621),HL
; 		1030.1  DIM b$(8{00 00 08 00 00 })
	LD A,1
	LD (23623),a
	LD HL,ZXBASIC_VAR_b_string
	LD BC,9
	CALL runtimeClearStringArray
ZXBASIC_LINE_1040:
; 1040  LET c$="A"
	LD HL,1040
	LD (23621),HL
; 		1040.1  LET c$="A"
	LD A,1
	LD (23623),a
	LD DE,STRING_0	;A
	LD HL,ZXBASIC_VAR_c_string
	CALL runtimeStoreString
ZXBASIC_LINE_1050:
; 1050  LET c$="B"
	LD HL,1050
	LD (23621),HL
; 		1050.1  LET c$="B"
	LD A,1
	LD (23623),a
	LD DE,STRING_1	;B
	LD HL,ZXBASIC_VAR_c_string
	CALL runtimeStoreString
ZXBASIC_LINE_1060:
; 1060  PRINT c$>d$
	LD HL,1060
	LD (23621),HL
; 		1060.1  PRINT c$>d$
	LD A,1
	LD (23623),a
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD DE,(ZXBASIC_VAR_c_string)
	LD HL,(ZXBASIC_VAR_d_string)
; >
	CALL runtimeBiggerString
	CALL runtimePrintInt
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
	CALL ZXFreeTempCompact
ZXBASIC_LINE_1070:
; 1070  CLS 
	LD HL,1070
	LD (23621),HL
; 		1070.1  CLS 
	LD A,1
	LD (23623),a
	CALL runtimeCls
ZXBASIC_LINE_1080:
; 1080  PRINT "Var String: compare"
	LD HL,1080
	LD (23621),HL
; 		1080.1  PRINT "Var String
	LD A,1
	LD (23623),a
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_2	;Var String: compare
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1090:
; 1090  LET c$="A": LET d$="": GO SUB 1950
	LD HL,1090
	LD (23621),HL
; 		1090.1  LET c$="A"
	LD A,1
	LD (23623),a
	LD DE,STRING_0	;A
	LD HL,ZXBASIC_VAR_c_string
	CALL runtimeStoreString
; 		1090.2  LET d$=""
	LD A,2
	LD (23623),a
	LD DE,STRING_3	;
	LD HL,ZXBASIC_VAR_d_string
	CALL runtimeStoreString
; 		1090.3  GO SUB 1950{00 00 9e 07 00 }
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_1950
ZXBASIC_LINE_1100:
; 1100  LET c$="A": LET d$="B": GO SUB 1950
	LD HL,1100
	LD (23621),HL
; 		1100.1  LET c$="A"
	LD A,1
	LD (23623),a
	LD DE,STRING_0	;A
	LD HL,ZXBASIC_VAR_c_string
	CALL runtimeStoreString
; 		1100.2  LET d$="B"
	LD A,2
	LD (23623),a
	LD DE,STRING_1	;B
	LD HL,ZXBASIC_VAR_d_string
	CALL runtimeStoreString
; 		1100.3  GO SUB 1950{00 00 9e 07 00 }
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_1950
ZXBASIC_LINE_1110:
; 1110  LET c$="B": LET d$="": GO SUB 1950
	LD HL,1110
	LD (23621),HL
; 		1110.1  LET c$="B"
	LD A,1
	LD (23623),a
	LD DE,STRING_1	;B
	LD HL,ZXBASIC_VAR_c_string
	CALL runtimeStoreString
; 		1110.2  LET d$=""
	LD A,2
	LD (23623),a
	LD DE,STRING_3	;
	LD HL,ZXBASIC_VAR_d_string
	CALL runtimeStoreString
; 		1110.3  GO SUB 1950{00 00 9e 07 00 }
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_1950
ZXBASIC_LINE_1120:
; 1120  PAUSE 0
	LD HL,1120
	LD (23621),HL
; 		1120.1  PAUSE 0{00 00 00 00 00 }
	LD A,1
	LD (23623),a
	LD HL,0
	CALL runtimePause
ZXBASIC_LINE_1130:
; 1130  CLS 
	LD HL,1130
	LD (23621),HL
; 		1130.1  CLS 
	LD A,1
	LD (23623),a
	CALL runtimeCls
ZXBASIC_LINE_1140:
; 1140  PRINT "Fix String: compare"
	LD HL,1140
	LD (23621),HL
; 		1140.1  PRINT "Fix String
	LD A,1
	LD (23623),a
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_4	;Fix String: compare
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1150:
; 1150  LET a$="A": LET b$="B": GO SUB 1880
	LD HL,1150
	LD (23621),HL
; 		1150.1  LET a$="A"
	LD A,1
	LD (23623),a
	LD DE,ZXBASIC_VAR_a_string
	LD HL,STRING_0	;A
	LD BC,8
	CALL runtimeStoreStringVarFix
; 		1150.2  LET b$="B"
	LD A,2
	LD (23623),a
	LD DE,ZXBASIC_VAR_b_string
	LD HL,STRING_1	;B
	LD BC,8
	CALL runtimeStoreStringVarFix
; 		1150.3  GO SUB 1880{00 00 58 07 00 }
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_1880
ZXBASIC_LINE_1160:
; 1160  LET a$="B": LET b$="A": GO SUB 1880
	LD HL,1160
	LD (23621),HL
; 		1160.1  LET a$="B"
	LD A,1
	LD (23623),a
	LD DE,ZXBASIC_VAR_a_string
	LD HL,STRING_1	;B
	LD BC,8
	CALL runtimeStoreStringVarFix
; 		1160.2  LET b$="A"
	LD A,2
	LD (23623),a
	LD DE,ZXBASIC_VAR_b_string
	LD HL,STRING_0	;A
	LD BC,8
	CALL runtimeStoreStringVarFix
; 		1160.3  GO SUB 1880{00 00 58 07 00 }
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_1880
ZXBASIC_LINE_1170:
; 1170  LET a$="A": LET b$="": GO SUB 1880
	LD HL,1170
	LD (23621),HL
; 		1170.1  LET a$="A"
	LD A,1
	LD (23623),a
	LD DE,ZXBASIC_VAR_a_string
	LD HL,STRING_0	;A
	LD BC,8
	CALL runtimeStoreStringVarFix
; 		1170.2  LET b$=""
	LD A,2
	LD (23623),a
	LD DE,ZXBASIC_VAR_b_string
	LD HL,STRING_3	;
	LD BC,8
	CALL runtimeStoreStringVarFix
; 		1170.3  GO SUB 1880{00 00 58 07 00 }
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_1880
ZXBASIC_LINE_1180:
; 1180  PAUSE 0
	LD HL,1180
	LD (23621),HL
; 		1180.1  PAUSE 0{00 00 00 00 00 }
	LD A,1
	LD (23623),a
	LD HL,0
	CALL runtimePause
ZXBASIC_LINE_1190:
; 1190  CLS 
	LD HL,1190
	LD (23621),HL
; 		1190.1  CLS 
	LD A,1
	LD (23623),a
	CALL runtimeCls
ZXBASIC_LINE_1200:
; 1200  PRINT "Float: Compare"
	LD HL,1200
	LD (23621),HL
; 		1200.1  PRINT "Float
	LD A,1
	LD (23623),a
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_5	;Float: Compare
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1210:
; 1210  LET af=1: LET bf=2: GO SUB 1580
	LD HL,1210
	LD (23621),HL
; 		1210.1  LET af=1{00 00 01 00 00 }
	LD A,1
	LD (23623),a
	LD HL,1
	CALL runtimeIntToFloat
	LD HL,ZXBASIC_VAR_af
	CALL runtimeStoreFloat
; 		1210.2  LET bf=2{00 00 02 00 00 }
	LD A,2
	LD (23623),a
	LD HL,2
	CALL runtimeIntToFloat
	LD HL,ZXBASIC_VAR_bf
	CALL runtimeStoreFloat
; 		1210.3  GO SUB 1580{00 00 2c 06 00 }
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_1580
ZXBASIC_LINE_1220:
; 1220  LET af=2: LET bf=1: GO SUB 1580
	LD HL,1220
	LD (23621),HL
; 		1220.1  LET af=2{00 00 02 00 00 }
	LD A,1
	LD (23623),a
	LD HL,2
	CALL runtimeIntToFloat
	LD HL,ZXBASIC_VAR_af
	CALL runtimeStoreFloat
; 		1220.2  LET bf=1{00 00 01 00 00 }
	LD A,2
	LD (23623),a
	LD HL,1
	CALL runtimeIntToFloat
	LD HL,ZXBASIC_VAR_bf
	CALL runtimeStoreFloat
; 		1220.3  GO SUB 1580{00 00 2c 06 00 }
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_1580
ZXBASIC_LINE_1230:
; 1230  LET af=2: LET bf=2: GO SUB 1580
	LD HL,1230
	LD (23621),HL
; 		1230.1  LET af=2{00 00 02 00 00 }
	LD A,1
	LD (23623),a
	LD HL,2
	CALL runtimeIntToFloat
	LD HL,ZXBASIC_VAR_af
	CALL runtimeStoreFloat
; 		1230.2  LET bf=2{00 00 02 00 00 }
	LD A,2
	LD (23623),a
	LD HL,2
	CALL runtimeIntToFloat
	LD HL,ZXBASIC_VAR_bf
	CALL runtimeStoreFloat
; 		1230.3  GO SUB 1580{00 00 2c 06 00 }
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_1580
ZXBASIC_LINE_1240:
; 1240  PAUSE 0
	LD HL,1240
	LD (23621),HL
; 		1240.1  PAUSE 0{00 00 00 00 00 }
	LD A,1
	LD (23623),a
	LD HL,0
	CALL runtimePause
ZXBASIC_LINE_1250:
; 1250  CLS 
	LD HL,1250
	LD (23621),HL
; 		1250.1  CLS 
	LD A,1
	LD (23623),a
	CALL runtimeCls
ZXBASIC_LINE_1260:
; 1260  PRINT "Int16: Compare"
	LD HL,1260
	LD (23621),HL
; 		1260.1  PRINT "Int16
	LD A,1
	LD (23623),a
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_6	;Int16: Compare
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1270:
; 1270  LET ai=1: LET bi=2: GO SUB 1730
	LD HL,1270
	LD (23621),HL
; 		1270.1  LET ai=1{00 00 01 00 00 }
	LD A,1
	LD (23623),a
	LD HL,1
	LD (ZXBASIC_VAR_ai),HL
; 		1270.2  LET bi=2{00 00 02 00 00 }
	LD A,2
	LD (23623),a
	LD HL,2
	LD (ZXBASIC_VAR_bi),HL
; 		1270.3  GO SUB 1730{00 00 c2 06 00 }
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_1730
ZXBASIC_LINE_1280:
; 1280  LET ai=2: LET bi=1: GO SUB 1730
	LD HL,1280
	LD (23621),HL
; 		1280.1  LET ai=2{00 00 02 00 00 }
	LD A,1
	LD (23623),a
	LD HL,2
	LD (ZXBASIC_VAR_ai),HL
; 		1280.2  LET bi=1{00 00 01 00 00 }
	LD A,2
	LD (23623),a
	LD HL,1
	LD (ZXBASIC_VAR_bi),HL
; 		1280.3  GO SUB 1730{00 00 c2 06 00 }
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_1730
ZXBASIC_LINE_1290:
; 1290  LET ai=1: LET bi=1: GO SUB 1730
	LD HL,1290
	LD (23621),HL
; 		1290.1  LET ai=1{00 00 01 00 00 }
	LD A,1
	LD (23623),a
	LD HL,1
	LD (ZXBASIC_VAR_ai),HL
; 		1290.2  LET bi=1{00 00 01 00 00 }
	LD A,2
	LD (23623),a
	LD HL,1
	LD (ZXBASIC_VAR_bi),HL
; 		1290.3  GO SUB 1730{00 00 c2 06 00 }
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_1730
ZXBASIC_LINE_1300:
; 1300  PAUSE 0
	LD HL,1300
	LD (23621),HL
; 		1300.1  PAUSE 0{00 00 00 00 00 }
	LD A,1
	LD (23623),a
	LD HL,0
	CALL runtimePause
ZXBASIC_LINE_1310:
; 1310  CLS 
	LD HL,1310
	LD (23621),HL
; 		1310.1  CLS 
	LD A,1
	LD (23623),a
	CALL runtimeCls
ZXBASIC_LINE_1320:
; 1320  PRINT "Float: Math"
	LD HL,1320
	LD (23621),HL
; 		1320.1  PRINT "Float
	LD A,1
	LD (23623),a
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_7	;Float: Math
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1330:
; 1330  LET af=10: LET bf=3: GO SUB 1660
	LD HL,1330
	LD (23621),HL
; 		1330.1  LET af=10{00 00 0a 00 00 }
	LD A,1
	LD (23623),a
	LD HL,10
	CALL runtimeIntToFloat
	LD HL,ZXBASIC_VAR_af
	CALL runtimeStoreFloat
; 		1330.2  LET bf=3{00 00 03 00 00 }
	LD A,2
	LD (23623),a
	LD HL,3
	CALL runtimeIntToFloat
	LD HL,ZXBASIC_VAR_bf
	CALL runtimeStoreFloat
; 		1330.3  GO SUB 1660{00 00 7c 06 00 }
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_1660
ZXBASIC_LINE_1340:
; 1340  LET af=20: LET bf=1: GO SUB 1660
	LD HL,1340
	LD (23621),HL
; 		1340.1  LET af=20{00 00 14 00 00 }
	LD A,1
	LD (23623),a
	LD HL,20
	CALL runtimeIntToFloat
	LD HL,ZXBASIC_VAR_af
	CALL runtimeStoreFloat
; 		1340.2  LET bf=1{00 00 01 00 00 }
	LD A,2
	LD (23623),a
	LD HL,1
	CALL runtimeIntToFloat
	LD HL,ZXBASIC_VAR_bf
	CALL runtimeStoreFloat
; 		1340.3  GO SUB 1660{00 00 7c 06 00 }
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_1660
ZXBASIC_LINE_1350:
; 1350  LET af=2: LET bf=10: GO SUB 1660
	LD HL,1350
	LD (23621),HL
; 		1350.1  LET af=2{00 00 02 00 00 }
	LD A,1
	LD (23623),a
	LD HL,2
	CALL runtimeIntToFloat
	LD HL,ZXBASIC_VAR_af
	CALL runtimeStoreFloat
; 		1350.2  LET bf=10{00 00 0a 00 00 }
	LD A,2
	LD (23623),a
	LD HL,10
	CALL runtimeIntToFloat
	LD HL,ZXBASIC_VAR_bf
	CALL runtimeStoreFloat
; 		1350.3  GO SUB 1660{00 00 7c 06 00 }
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_1660
ZXBASIC_LINE_1360:
; 1360  LET af=20: LET bf=20: GO SUB 1660
	LD HL,1360
	LD (23621),HL
; 		1360.1  LET af=20{00 00 14 00 00 }
	LD A,1
	LD (23623),a
	LD HL,20
	CALL runtimeIntToFloat
	LD HL,ZXBASIC_VAR_af
	CALL runtimeStoreFloat
; 		1360.2  LET bf=20{00 00 14 00 00 }
	LD A,2
	LD (23623),a
	LD HL,20
	CALL runtimeIntToFloat
	LD HL,ZXBASIC_VAR_bf
	CALL runtimeStoreFloat
; 		1360.3  GO SUB 1660{00 00 7c 06 00 }
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_1660
ZXBASIC_LINE_1370:
; 1370  PAUSE 0
	LD HL,1370
	LD (23621),HL
; 		1370.1  PAUSE 0{00 00 00 00 00 }
	LD A,1
	LD (23623),a
	LD HL,0
	CALL runtimePause
ZXBASIC_LINE_1380:
; 1380  CLS 
	LD HL,1380
	LD (23621),HL
; 		1380.1  CLS 
	LD A,1
	LD (23623),a
	CALL runtimeCls
ZXBASIC_LINE_1390:
; 1390  PRINT "Int16: Math"
	LD HL,1390
	LD (23621),HL
; 		1390.1  PRINT "Int16
	LD A,1
	LD (23623),a
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_8	;Int16: Math
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1400:
; 1400  LET ai=10: LET bi=3: GO SUB 1810
	LD HL,1400
	LD (23621),HL
; 		1400.1  LET ai=10{00 00 0a 00 00 }
	LD A,1
	LD (23623),a
	LD HL,10
	LD (ZXBASIC_VAR_ai),HL
; 		1400.2  LET bi=3{00 00 03 00 00 }
	LD A,2
	LD (23623),a
	LD HL,3
	LD (ZXBASIC_VAR_bi),HL
; 		1400.3  GO SUB 1810{00 00 12 07 00 }
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_1810
ZXBASIC_LINE_1410:
; 1410  LET ai=20: LET bi=1: GO SUB 1810
	LD HL,1410
	LD (23621),HL
; 		1410.1  LET ai=20{00 00 14 00 00 }
	LD A,1
	LD (23623),a
	LD HL,20
	LD (ZXBASIC_VAR_ai),HL
; 		1410.2  LET bi=1{00 00 01 00 00 }
	LD A,2
	LD (23623),a
	LD HL,1
	LD (ZXBASIC_VAR_bi),HL
; 		1410.3  GO SUB 1810{00 00 12 07 00 }
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_1810
ZXBASIC_LINE_1420:
; 1420  LET ai=2: LET bi=10: GO SUB 1810
	LD HL,1420
	LD (23621),HL
; 		1420.1  LET ai=2{00 00 02 00 00 }
	LD A,1
	LD (23623),a
	LD HL,2
	LD (ZXBASIC_VAR_ai),HL
; 		1420.2  LET bi=10{00 00 0a 00 00 }
	LD A,2
	LD (23623),a
	LD HL,10
	LD (ZXBASIC_VAR_bi),HL
; 		1420.3  GO SUB 1810{00 00 12 07 00 }
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_1810
ZXBASIC_LINE_1430:
; 1430  LET ai=10: LET bi=10: GO SUB 1810
	LD HL,1430
	LD (23621),HL
; 		1430.1  LET ai=10{00 00 0a 00 00 }
	LD A,1
	LD (23623),a
	LD HL,10
	LD (ZXBASIC_VAR_ai),HL
; 		1430.2  LET bi=10{00 00 0a 00 00 }
	LD A,2
	LD (23623),a
	LD HL,10
	LD (ZXBASIC_VAR_bi),HL
; 		1430.3  GO SUB 1810{00 00 12 07 00 }
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_1810
ZXBASIC_LINE_1440:
; 1440  PAUSE 0
	LD HL,1440
	LD (23621),HL
; 		1440.1  PAUSE 0{00 00 00 00 00 }
	LD A,1
	LD (23623),a
	LD HL,0
	CALL runtimePause
ZXBASIC_LINE_1450:
; 1450  CLS 
	LD HL,1450
	LD (23621),HL
; 		1450.1  CLS 
	LD A,1
	LD (23623),a
	CALL runtimeCls
ZXBASIC_LINE_1460:
; 1460  PRINT "Var/Fix String: compare"
	LD HL,1460
	LD (23621),HL
; 		1460.1  PRINT "Var/Fix String
	LD A,1
	LD (23623),a
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_9	;Var/Fix String: compare
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1470:
; 1470  LET c$="A": LET b$="B": GO SUB 2020
	LD HL,1470
	LD (23621),HL
; 		1470.1  LET c$="A"
	LD A,1
	LD (23623),a
	LD DE,STRING_0	;A
	LD HL,ZXBASIC_VAR_c_string
	CALL runtimeStoreString
; 		1470.2  LET b$="B"
	LD A,2
	LD (23623),a
	LD DE,ZXBASIC_VAR_b_string
	LD HL,STRING_1	;B
	LD BC,8
	CALL runtimeStoreStringVarFix
; 		1470.3  GO SUB 2020{00 00 e4 07 00 }
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_2020
ZXBASIC_LINE_1480:
; 1480  LET c$="B": LET b$="A": GO SUB 2020
	LD HL,1480
	LD (23621),HL
; 		1480.1  LET c$="B"
	LD A,1
	LD (23623),a
	LD DE,STRING_1	;B
	LD HL,ZXBASIC_VAR_c_string
	CALL runtimeStoreString
; 		1480.2  LET b$="A"
	LD A,2
	LD (23623),a
	LD DE,ZXBASIC_VAR_b_string
	LD HL,STRING_0	;A
	LD BC,8
	CALL runtimeStoreStringVarFix
; 		1480.3  GO SUB 2020{00 00 e4 07 00 }
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_2020
ZXBASIC_LINE_1490:
; 1490  LET c$="A": LET b$="": GO SUB 2020
	LD HL,1490
	LD (23621),HL
; 		1490.1  LET c$="A"
	LD A,1
	LD (23623),a
	LD DE,STRING_0	;A
	LD HL,ZXBASIC_VAR_c_string
	CALL runtimeStoreString
; 		1490.2  LET b$=""
	LD A,2
	LD (23623),a
	LD DE,ZXBASIC_VAR_b_string
	LD HL,STRING_3	;
	LD BC,8
	CALL runtimeStoreStringVarFix
; 		1490.3  GO SUB 2020{00 00 e4 07 00 }
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_2020
ZXBASIC_LINE_1500:
; 1500  PAUSE 0
	LD HL,1500
	LD (23621),HL
; 		1500.1  PAUSE 0{00 00 00 00 00 }
	LD A,1
	LD (23623),a
	LD HL,0
	CALL runtimePause
ZXBASIC_LINE_1510:
; 1510  CLS 
	LD HL,1510
	LD (23621),HL
; 		1510.1  CLS 
	LD A,1
	LD (23623),a
	CALL runtimeCls
ZXBASIC_LINE_1520:
; 1520  PRINT "Fix/Var String: compare"
	LD HL,1520
	LD (23621),HL
; 		1520.1  PRINT "Fix/Var String
	LD A,1
	LD (23623),a
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_10	;Fix/Var String: compare
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1530:
; 1530  LET a$="A": LET d$="B": GO SUB 2090
	LD HL,1530
	LD (23621),HL
; 		1530.1  LET a$="A"
	LD A,1
	LD (23623),a
	LD DE,ZXBASIC_VAR_a_string
	LD HL,STRING_0	;A
	LD BC,8
	CALL runtimeStoreStringVarFix
; 		1530.2  LET d$="B"
	LD A,2
	LD (23623),a
	LD DE,STRING_1	;B
	LD HL,ZXBASIC_VAR_d_string
	CALL runtimeStoreString
; 		1530.3  GO SUB 2090{00 00 2a 08 00 }
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_2090
ZXBASIC_LINE_1540:
; 1540  LET a$="B": LET d$="A": GO SUB 2090
	LD HL,1540
	LD (23621),HL
; 		1540.1  LET a$="B"
	LD A,1
	LD (23623),a
	LD DE,ZXBASIC_VAR_a_string
	LD HL,STRING_1	;B
	LD BC,8
	CALL runtimeStoreStringVarFix
; 		1540.2  LET d$="A"
	LD A,2
	LD (23623),a
	LD DE,STRING_0	;A
	LD HL,ZXBASIC_VAR_d_string
	CALL runtimeStoreString
; 		1540.3  GO SUB 2090{00 00 2a 08 00 }
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_2090
ZXBASIC_LINE_1550:
; 1550  LET a$="A": LET d$="": GO SUB 2090
	LD HL,1550
	LD (23621),HL
; 		1550.1  LET a$="A"
	LD A,1
	LD (23623),a
	LD DE,ZXBASIC_VAR_a_string
	LD HL,STRING_0	;A
	LD BC,8
	CALL runtimeStoreStringVarFix
; 		1550.2  LET d$=""
	LD A,2
	LD (23623),a
	LD DE,STRING_3	;
	LD HL,ZXBASIC_VAR_d_string
	CALL runtimeStoreString
; 		1550.3  GO SUB 2090{00 00 2a 08 00 }
	LD A,3
	LD (23623),a
	CALL runtimeCheckBreak
	CALL ZXBASIC_LINE_2090
ZXBASIC_LINE_1560:
; 1560  PAUSE 0
	LD HL,1560
	LD (23621),HL
; 		1560.1  PAUSE 0{00 00 00 00 00 }
	LD A,1
	LD (23623),a
	LD HL,0
	CALL runtimePause
ZXBASIC_LINE_1570:
; 1570  RETURN 
	LD HL,1570
	LD (23621),HL
; 		1570.1  RETURN 
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	RET
ZXBASIC_LINE_1580:
; 1580  PRINT "--------"
	LD HL,1580
	LD (23621),HL
; 		1580.1  PRINT "--------"
	LD A,1
	LD (23623),a
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_11	;--------
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1590:
; 1590  PRINT af;"> ";bf;" -> ";af>bf
	LD HL,1590
	LD (23621),HL
; 		1590.1  PRINT af;"> ";bf;" -> ";af>bf
	LD A,1
	LD (23623),a
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,ZXBASIC_VAR_af
	CALL runtimePushFloatVar
	CALL runtimePrintFloat
	LD HL,STRING_12	;> 
	CALL runtimePrintString
	LD HL,ZXBASIC_VAR_bf
	CALL runtimePushFloatVar
	CALL runtimePrintFloat
	LD HL,STRING_13	; -> 
	CALL runtimePrintString
	LD HL,ZXBASIC_VAR_af
	CALL runtimePushFloatVar
	LD HL,ZXBASIC_VAR_bf
	CALL runtimePushFloatVar
; >
	CALL runtimeBiggerFloat
	CALL runtimePrintInt
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1600:
; 1600  PRINT af;">=";bf;" -> ";af >= bf
	LD HL,1600
	LD (23621),HL
; 		1600.1  PRINT af;">=";bf;" -> ";af >= bf
	LD A,1
	LD (23623),a
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,ZXBASIC_VAR_af
	CALL runtimePushFloatVar
	CALL runtimePrintFloat
	LD HL,STRING_14	;>=
	CALL runtimePrintString
	LD HL,ZXBASIC_VAR_bf
	CALL runtimePushFloatVar
	CALL runtimePrintFloat
	LD HL,STRING_13	; -> 
	CALL runtimePrintString
	LD HL,ZXBASIC_VAR_af
	CALL runtimePushFloatVar
	LD HL,ZXBASIC_VAR_bf
	CALL runtimePushFloatVar
; >=
	CALL runtimeBiggerEqualFloat
	CALL runtimePrintInt
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1610:
; 1610  PRINT af;"< ";bf;" -> ";af<bf
	LD HL,1610
	LD (23621),HL
; 		1610.1  PRINT af;"< ";bf;" -> ";af<bf
	LD A,1
	LD (23623),a
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,ZXBASIC_VAR_af
	CALL runtimePushFloatVar
	CALL runtimePrintFloat
	LD HL,STRING_15	;< 
	CALL runtimePrintString
	LD HL,ZXBASIC_VAR_bf
	CALL runtimePushFloatVar
	CALL runtimePrintFloat
	LD HL,STRING_13	; -> 
	CALL runtimePrintString
	LD HL,ZXBASIC_VAR_af
	CALL runtimePushFloatVar
	LD HL,ZXBASIC_VAR_bf
	CALL runtimePushFloatVar
; <
	CALL runtimeSmallerFloat
	CALL runtimePrintInt
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1620:
; 1620  PRINT af;"<=";bf;" -> ";af <= bf
	LD HL,1620
	LD (23621),HL
; 		1620.1  PRINT af;"<=";bf;" -> ";af <= bf
	LD A,1
	LD (23623),a
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,ZXBASIC_VAR_af
	CALL runtimePushFloatVar
	CALL runtimePrintFloat
	LD HL,STRING_16	;<=
	CALL runtimePrintString
	LD HL,ZXBASIC_VAR_bf
	CALL runtimePushFloatVar
	CALL runtimePrintFloat
	LD HL,STRING_13	; -> 
	CALL runtimePrintString
	LD HL,ZXBASIC_VAR_af
	CALL runtimePushFloatVar
	LD HL,ZXBASIC_VAR_bf
	CALL runtimePushFloatVar
; <=
	CALL runtimeSmallerEqualFloat
	CALL runtimePrintInt
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1630:
; 1630  PRINT af;"<>";bf;" -> ";af <> bf
	LD HL,1630
	LD (23621),HL
; 		1630.1  PRINT af;"<>";bf;" -> ";af <> bf
	LD A,1
	LD (23623),a
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,ZXBASIC_VAR_af
	CALL runtimePushFloatVar
	CALL runtimePrintFloat
	LD HL,STRING_17	;<>
	CALL runtimePrintString
	LD HL,ZXBASIC_VAR_bf
	CALL runtimePushFloatVar
	CALL runtimePrintFloat
	LD HL,STRING_13	; -> 
	CALL runtimePrintString
	LD HL,ZXBASIC_VAR_af
	CALL runtimePushFloatVar
	LD HL,ZXBASIC_VAR_bf
	CALL runtimePushFloatVar
; <>
	CALL runtimeUnequalFloat
	CALL runtimePrintInt
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1640:
; 1640  PRINT af;"= ";bf;" -> ";af=bf
	LD HL,1640
	LD (23621),HL
; 		1640.1  PRINT af;"= ";bf;" -> ";af=bf
	LD A,1
	LD (23623),a
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,ZXBASIC_VAR_af
	CALL runtimePushFloatVar
	CALL runtimePrintFloat
	LD HL,STRING_18	;= 
	CALL runtimePrintString
	LD HL,ZXBASIC_VAR_bf
	CALL runtimePushFloatVar
	CALL runtimePrintFloat
	LD HL,STRING_13	; -> 
	CALL runtimePrintString
	LD HL,ZXBASIC_VAR_af
	CALL runtimePushFloatVar
	LD HL,ZXBASIC_VAR_bf
	CALL runtimePushFloatVar
; =
	CALL runtimeEqualFloat
	CALL runtimePrintInt
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1650:
; 1650  RETURN 
	LD HL,1650
	LD (23621),HL
; 		1650.1  RETURN 
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	RET
ZXBASIC_LINE_1660:
; 1660  PRINT "--------"
	LD HL,1660
	LD (23621),HL
; 		1660.1  PRINT "--------"
	LD A,1
	LD (23623),a
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_11	;--------
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1670:
; 1670  PRINT af;"+";bf;" -> ";af+bf
	LD HL,1670
	LD (23621),HL
; 		1670.1  PRINT af;"+";bf;" -> ";af+bf
	LD A,1
	LD (23623),a
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,ZXBASIC_VAR_af
	CALL runtimePushFloatVar
	CALL runtimePrintFloat
	LD HL,STRING_19	;+
	CALL runtimePrintString
	LD HL,ZXBASIC_VAR_bf
	CALL runtimePushFloatVar
	CALL runtimePrintFloat
	LD HL,STRING_13	; -> 
	CALL runtimePrintString
	LD HL,ZXBASIC_VAR_af
	CALL runtimePushFloatVar
	LD HL,ZXBASIC_VAR_bf
	CALL runtimePushFloatVar
; +
	RST $28
	DB $0f	;ADD
	DB $38	;END CALC
	CALL runtimePrintFloat
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1680:
; 1680  PRINT af;"-";bf;" -> ";af-bf
	LD HL,1680
	LD (23621),HL
; 		1680.1  PRINT af;"-";bf;" -> ";af-bf
	LD A,1
	LD (23623),a
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,ZXBASIC_VAR_af
	CALL runtimePushFloatVar
	CALL runtimePrintFloat
	LD HL,STRING_20	;-
	CALL runtimePrintString
	LD HL,ZXBASIC_VAR_bf
	CALL runtimePushFloatVar
	CALL runtimePrintFloat
	LD HL,STRING_13	; -> 
	CALL runtimePrintString
	LD HL,ZXBASIC_VAR_af
	CALL runtimePushFloatVar
	LD HL,ZXBASIC_VAR_bf
	CALL runtimePushFloatVar
; -
	RST $28
	DB $03	;SUB
	DB $38	;END CALC
	CALL runtimePrintFloat
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1690:
; 1690  PRINT af;"*";bf;" -> ";af*bf
	LD HL,1690
	LD (23621),HL
; 		1690.1  PRINT af;"*";bf;" -> ";af*bf
	LD A,1
	LD (23623),a
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,ZXBASIC_VAR_af
	CALL runtimePushFloatVar
	CALL runtimePrintFloat
	LD HL,STRING_21	;*
	CALL runtimePrintString
	LD HL,ZXBASIC_VAR_bf
	CALL runtimePushFloatVar
	CALL runtimePrintFloat
	LD HL,STRING_13	; -> 
	CALL runtimePrintString
	LD HL,ZXBASIC_VAR_af
	CALL runtimePushFloatVar
	LD HL,ZXBASIC_VAR_bf
	CALL runtimePushFloatVar
; *
	RST $28
	DB $04	;MULT
	DB $38	;END CALC
	CALL runtimePrintFloat
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1700:
; 1700  PRINT af;"/";bf;" -> ";af/bf
	LD HL,1700
	LD (23621),HL
; 		1700.1  PRINT af;"/";bf;" -> ";af/bf
	LD A,1
	LD (23623),a
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,ZXBASIC_VAR_af
	CALL runtimePushFloatVar
	CALL runtimePrintFloat
	LD HL,STRING_22	;/
	CALL runtimePrintString
	LD HL,ZXBASIC_VAR_bf
	CALL runtimePushFloatVar
	CALL runtimePrintFloat
	LD HL,STRING_13	; -> 
	CALL runtimePrintString
	LD HL,ZXBASIC_VAR_af
	CALL runtimePushFloatVar
	LD HL,ZXBASIC_VAR_bf
	CALL runtimePushFloatVar
; /
	RST $28
	DB $05	;DIV
	DB $38	;END CALC
	CALL runtimePrintFloat
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1710:
; 1710  PRINT af;"^";bf;" -> ";af^bf
	LD HL,1710
	LD (23621),HL
; 		1710.1  PRINT af;"^";bf;" -> ";af^bf
	LD A,1
	LD (23623),a
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,ZXBASIC_VAR_af
	CALL runtimePushFloatVar
	CALL runtimePrintFloat
	LD HL,STRING_23	;^
	CALL runtimePrintString
	LD HL,ZXBASIC_VAR_bf
	CALL runtimePushFloatVar
	CALL runtimePrintFloat
	LD HL,STRING_13	; -> 
	CALL runtimePrintString
	LD HL,ZXBASIC_VAR_af
	CALL runtimePushFloatVar
	LD HL,ZXBASIC_VAR_bf
	CALL runtimePushFloatVar
; *
	RST $28
	DB zxcalc_to_power	;Power
	DB $38	;END CALC
	CALL runtimePrintFloat
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1720:
; 1720  RETURN 
	LD HL,1720
	LD (23621),HL
; 		1720.1  RETURN 
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	RET
ZXBASIC_LINE_1730:
; 1730  PRINT "--------"
	LD HL,1730
	LD (23621),HL
; 		1730.1  PRINT "--------"
	LD A,1
	LD (23623),a
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_11	;--------
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1740:
; 1740  PRINT ai;"> ";bi;" -> ";ai>bi
	LD HL,1740
	LD (23621),HL
; 		1740.1  PRINT ai;"> ";bi;" -> ";ai>bi
	LD A,1
	LD (23623),a
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,(ZXBASIC_VAR_ai)
	CALL runtimePrintInt
	LD HL,STRING_12	;> 
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_bi)
	CALL runtimePrintInt
	LD HL,STRING_13	; -> 
	CALL runtimePrintString
	LD DE,(ZXBASIC_VAR_ai)
	LD HL,(ZXBASIC_VAR_bi)
; >
	CALL runtimeCmpHlGtDE
	CALL runtimePrintInt
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1750:
; 1750  PRINT ai;">=";bi;" -> ";ai >= bi
	LD HL,1750
	LD (23621),HL
; 		1750.1  PRINT ai;">=";bi;" -> ";ai >= bi
	LD A,1
	LD (23623),a
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,(ZXBASIC_VAR_ai)
	CALL runtimePrintInt
	LD HL,STRING_14	;>=
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_bi)
	CALL runtimePrintInt
	LD HL,STRING_13	; -> 
	CALL runtimePrintString
	LD DE,(ZXBASIC_VAR_ai)
	LD HL,(ZXBASIC_VAR_bi)
; >=
	CALL runtimeCmpHLGeDE
	CALL runtimePrintInt
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1760:
; 1760  PRINT ai;"< ";bi;" -> ";ai<bi
	LD HL,1760
	LD (23621),HL
; 		1760.1  PRINT ai;"< ";bi;" -> ";ai<bi
	LD A,1
	LD (23623),a
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,(ZXBASIC_VAR_ai)
	CALL runtimePrintInt
	LD HL,STRING_15	;< 
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_bi)
	CALL runtimePrintInt
	LD HL,STRING_13	; -> 
	CALL runtimePrintString
	LD DE,(ZXBASIC_VAR_ai)
	LD HL,(ZXBASIC_VAR_bi)
; <
	CALL runtimeCmpHLltDE
	CALL runtimePrintInt
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1770:
; 1770  PRINT ai;"<=";bi;" -> ";ai <= bi
	LD HL,1770
	LD (23621),HL
; 		1770.1  PRINT ai;"<=";bi;" -> ";ai <= bi
	LD A,1
	LD (23623),a
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,(ZXBASIC_VAR_ai)
	CALL runtimePrintInt
	LD HL,STRING_16	;<=
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_bi)
	CALL runtimePrintInt
	LD HL,STRING_13	; -> 
	CALL runtimePrintString
	LD DE,(ZXBASIC_VAR_ai)
	LD HL,(ZXBASIC_VAR_bi)
; <=
	CALL runtimeCmpHLLeDE
	CALL runtimePrintInt
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1780:
; 1780  PRINT ai;"<>";bi;" -> ";ai <> bi
	LD HL,1780
	LD (23621),HL
; 		1780.1  PRINT ai;"<>";bi;" -> ";ai <> bi
	LD A,1
	LD (23623),a
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,(ZXBASIC_VAR_ai)
	CALL runtimePrintInt
	LD HL,STRING_17	;<>
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_bi)
	CALL runtimePrintInt
	LD HL,STRING_13	; -> 
	CALL runtimePrintString
	LD DE,(ZXBASIC_VAR_ai)
	LD HL,(ZXBASIC_VAR_bi)
; <>
	CALL runtimeCmpHlNeDE
	CALL runtimePrintInt
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1790:
; 1790  PRINT ai;"= ";bi;" -> ";ai=bi
	LD HL,1790
	LD (23621),HL
; 		1790.1  PRINT ai;"= ";bi;" -> ";ai=bi
	LD A,1
	LD (23623),a
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,(ZXBASIC_VAR_ai)
	CALL runtimePrintInt
	LD HL,STRING_18	;= 
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_bi)
	CALL runtimePrintInt
	LD HL,STRING_13	; -> 
	CALL runtimePrintString
	LD DE,(ZXBASIC_VAR_ai)
	LD HL,(ZXBASIC_VAR_bi)
; =
	CALL runtimeCmpHLEqDE
	CALL runtimePrintInt
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1800:
; 1800  RETURN 
	LD HL,1800
	LD (23621),HL
; 		1800.1  RETURN 
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	RET
ZXBASIC_LINE_1810:
; 1810  PRINT "--------"
	LD HL,1810
	LD (23621),HL
; 		1810.1  PRINT "--------"
	LD A,1
	LD (23623),a
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,STRING_11	;--------
	CALL runtimePrintString
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1820:
; 1820  PRINT ai;"+";bi;" -> ";ai+bi
	LD HL,1820
	LD (23621),HL
; 		1820.1  PRINT ai;"+";bi;" -> ";ai+bi
	LD A,1
	LD (23623),a
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,(ZXBASIC_VAR_ai)
	CALL runtimePrintInt
	LD HL,STRING_19	;+
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_bi)
	CALL runtimePrintInt
	LD HL,STRING_13	; -> 
	CALL runtimePrintString
	LD DE,(ZXBASIC_VAR_ai)
	LD HL,(ZXBASIC_VAR_bi)
; +
	ADD HL,DE
	CALL runtimePrintInt
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1830:
; 1830  PRINT ai;"-";bi;" -> ";ai-bi
	LD HL,1830
	LD (23621),HL
; 		1830.1  PRINT ai;"-";bi;" -> ";ai-bi
	LD A,1
	LD (23623),a
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,(ZXBASIC_VAR_ai)
	CALL runtimePrintInt
	LD HL,STRING_20	;-
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_bi)
	CALL runtimePrintInt
	LD HL,STRING_13	; -> 
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_ai)
	LD DE,(ZXBASIC_VAR_bi)
; -
	SUB HL,DE
	CALL runtimePrintInt
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1840:
; 1840  PRINT ai;"*";bi;" -> ";ai*bi
	LD HL,1840
	LD (23621),HL
; 		1840.1  PRINT ai;"*";bi;" -> ";ai*bi
	LD A,1
	LD (23623),a
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,(ZXBASIC_VAR_ai)
	CALL runtimePrintInt
	LD HL,STRING_21	;*
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_bi)
	CALL runtimePrintInt
	LD HL,STRING_13	; -> 
	CALL runtimePrintString
	LD DE,(ZXBASIC_VAR_ai)
	LD HL,(ZXBASIC_VAR_bi)
; *
	call runtimeMult16bit
	CALL runtimePrintInt
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1850:
; 1850  PRINT ai;"/";bi;" -> ";ai/bi
	LD HL,1850
	LD (23621),HL
; 		1850.1  PRINT ai;"/";bi;" -> ";ai/bi
	LD A,1
	LD (23623),a
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,(ZXBASIC_VAR_ai)
	CALL runtimePrintInt
	LD HL,STRING_22	;/
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_bi)
	CALL runtimePrintInt
	LD HL,STRING_13	; -> 
	CALL runtimePrintString
	LD DE,(ZXBASIC_VAR_ai)
	LD HL,(ZXBASIC_VAR_bi)
; /
	call runtimeDiv16bit
	CALL runtimePrintInt
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1860:
; 1860  PRINT ai;"^";bi;" -> ";ai^bi
	LD HL,1860
	LD (23621),HL
; 		1860.1  PRINT ai;"^";bi;" -> ";ai^bi
	LD A,1
	LD (23623),a
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,(ZXBASIC_VAR_ai)
	CALL runtimePrintInt
	LD HL,STRING_23	;^
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_bi)
	CALL runtimePrintInt
	LD HL,STRING_13	; -> 
	CALL runtimePrintString
	LD DE,(ZXBASIC_VAR_ai)
	LD HL,(ZXBASIC_VAR_bi)
; *
	call runtimePower16bit
	CALL runtimePrintInt
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1870:
; 1870  RETURN 
	LD HL,1870
	LD (23621),HL
; 		1870.1  RETURN 
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	RET
ZXBASIC_LINE_1880:
; 1880  PRINT a$;"> ";b$;" -> ";a$>b$
	LD HL,1880
	LD (23621),HL
; 		1880.1  PRINT a$;"> ";b$;" -> ";a$>b$
	LD A,1
	LD (23623),a
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,ZXBASIC_VAR_a_string
	LD BC,8
	CALL runtimePrintFixString
	LD HL,STRING_12	;> 
	CALL runtimePrintString
	LD HL,ZXBASIC_VAR_b_string
	LD BC,8
	CALL runtimePrintFixString
	LD HL,STRING_13	; -> 
	CALL runtimePrintString
	LD HL,ZXBASIC_VAR_a_string
	PUSH HL
	LD HL,ZXBASIC_VAR_b_string
	PUSH HL
; >
	POP IX
	POP HL
	LD BC,8
	LD DE,8
	CALL runtimeBiggerStringFixFix
	CALL runtimePrintInt
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1890:
; 1890  PRINT a$;"< ";b$;" -> ";a$<b$
	LD HL,1890
	LD (23621),HL
; 		1890.1  PRINT a$;"< ";b$;" -> ";a$<b$
	LD A,1
	LD (23623),a
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,ZXBASIC_VAR_a_string
	LD BC,8
	CALL runtimePrintFixString
	LD HL,STRING_15	;< 
	CALL runtimePrintString
	LD HL,ZXBASIC_VAR_b_string
	LD BC,8
	CALL runtimePrintFixString
	LD HL,STRING_13	; -> 
	CALL runtimePrintString
	LD IX,ZXBASIC_VAR_a_string
	LD HL,ZXBASIC_VAR_b_string
; <
	LD BC,8
	LD DE,8
	CALL runtimeSmallerStringFixFix
	CALL runtimePrintInt
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1900:
; 1900  PRINT a$;">=";b$;" -> ";a$ >= b$
	LD HL,1900
	LD (23621),HL
; 		1900.1  PRINT a$;">=";b$;" -> ";a$ >= b$
	LD A,1
	LD (23623),a
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,ZXBASIC_VAR_a_string
	LD BC,8
	CALL runtimePrintFixString
	LD HL,STRING_14	;>=
	CALL runtimePrintString
	LD HL,ZXBASIC_VAR_b_string
	LD BC,8
	CALL runtimePrintFixString
	LD HL,STRING_13	; -> 
	CALL runtimePrintString
	LD IX,ZXBASIC_VAR_a_string
	LD HL,ZXBASIC_VAR_b_string
; >=
	LD BC,8
	LD DE,8
	CALL runtimeBiggerEqualStringFixFix
	CALL runtimePrintInt
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1910:
; 1910  PRINT a$;"<=";b$;" -> ";a$ <= b$
	LD HL,1910
	LD (23621),HL
; 		1910.1  PRINT a$;"<=";b$;" -> ";a$ <= b$
	LD A,1
	LD (23623),a
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,ZXBASIC_VAR_a_string
	LD BC,8
	CALL runtimePrintFixString
	LD HL,STRING_16	;<=
	CALL runtimePrintString
	LD HL,ZXBASIC_VAR_b_string
	LD BC,8
	CALL runtimePrintFixString
	LD HL,STRING_13	; -> 
	CALL runtimePrintString
	LD IX,ZXBASIC_VAR_a_string
	LD HL,ZXBASIC_VAR_b_string
; <=
	LD BC,8
	LD DE,8
	CALL runtimeSmallerEqualStringFixFix
	CALL runtimePrintInt
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1920:
; 1920  PRINT a$;"<>";b$;" -> ";a$ <> b$
	LD HL,1920
	LD (23621),HL
; 		1920.1  PRINT a$;"<>";b$;" -> ";a$ <> b$
	LD A,1
	LD (23623),a
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,ZXBASIC_VAR_a_string
	LD BC,8
	CALL runtimePrintFixString
	LD HL,STRING_17	;<>
	CALL runtimePrintString
	LD HL,ZXBASIC_VAR_b_string
	LD BC,8
	CALL runtimePrintFixString
	LD HL,STRING_13	; -> 
	CALL runtimePrintString
	LD IX,ZXBASIC_VAR_a_string
	LD HL,ZXBASIC_VAR_b_string
; <>
	LD BC,8
	LD DE,8
	CALL runtimeUnequalStringFixFix
	CALL runtimePrintInt
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1930:
; 1930  PRINT a$;"= ";b$;" -> ";a$=b$
	LD HL,1930
	LD (23621),HL
; 		1930.1  PRINT a$;"= ";b$;" -> ";a$=b$
	LD A,1
	LD (23623),a
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,ZXBASIC_VAR_a_string
	LD BC,8
	CALL runtimePrintFixString
	LD HL,STRING_18	;= 
	CALL runtimePrintString
	LD HL,ZXBASIC_VAR_b_string
	LD BC,8
	CALL runtimePrintFixString
	LD HL,STRING_13	; -> 
	CALL runtimePrintString
	LD IX,ZXBASIC_VAR_a_string
	LD HL,ZXBASIC_VAR_b_string
; =
	LD BC,8
	LD DE,8
	CALL runtimeEqualStringFixFix
	CALL runtimePrintInt
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
ZXBASIC_LINE_1940:
; 1940  RETURN 
	LD HL,1940
	LD (23621),HL
; 		1940.1  RETURN 
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	RET
ZXBASIC_LINE_1950:
; 1950  PRINT c$;"> ";d$;" -> ";c$>d$
	LD HL,1950
	LD (23621),HL
; 		1950.1  PRINT c$;"> ";d$;" -> ";c$>d$
	LD A,1
	LD (23623),a
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,(ZXBASIC_VAR_c_string)
	CALL runtimePrintString
	LD HL,STRING_12	;> 
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_d_string)
	CALL runtimePrintString
	LD HL,STRING_13	; -> 
	CALL runtimePrintString
	LD DE,(ZXBASIC_VAR_c_string)
	LD HL,(ZXBASIC_VAR_d_string)
; >
	CALL runtimeBiggerString
	CALL runtimePrintInt
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
	CALL ZXFreeTempCompact
ZXBASIC_LINE_1960:
; 1960  PRINT c$;"< ";d$;" -> ";c$<d$
	LD HL,1960
	LD (23621),HL
; 		1960.1  PRINT c$;"< ";d$;" -> ";c$<d$
	LD A,1
	LD (23623),a
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,(ZXBASIC_VAR_c_string)
	CALL runtimePrintString
	LD HL,STRING_15	;< 
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_d_string)
	CALL runtimePrintString
	LD HL,STRING_13	; -> 
	CALL runtimePrintString
	LD DE,(ZXBASIC_VAR_c_string)
	LD HL,(ZXBASIC_VAR_d_string)
; <
	CALL runtimeSmallerString
	CALL runtimePrintInt
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
	CALL ZXFreeTempCompact
ZXBASIC_LINE_1970:
; 1970  PRINT c$;">=";d$;" -> ";c$ >= d$
	LD HL,1970
	LD (23621),HL
; 		1970.1  PRINT c$;">=";d$;" -> ";c$ >= d$
	LD A,1
	LD (23623),a
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,(ZXBASIC_VAR_c_string)
	CALL runtimePrintString
	LD HL,STRING_14	;>=
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_d_string)
	CALL runtimePrintString
	LD HL,STRING_13	; -> 
	CALL runtimePrintString
	LD DE,(ZXBASIC_VAR_c_string)
	LD HL,(ZXBASIC_VAR_d_string)
; >=
	CALL runtimeBiggerEqualString
	CALL runtimePrintInt
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
	CALL ZXFreeTempCompact
ZXBASIC_LINE_1980:
; 1980  PRINT c$;"<=";d$;" -> ";c$ <= d$
	LD HL,1980
	LD (23621),HL
; 		1980.1  PRINT c$;"<=";d$;" -> ";c$ <= d$
	LD A,1
	LD (23623),a
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,(ZXBASIC_VAR_c_string)
	CALL runtimePrintString
	LD HL,STRING_16	;<=
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_d_string)
	CALL runtimePrintString
	LD HL,STRING_13	; -> 
	CALL runtimePrintString
	LD DE,(ZXBASIC_VAR_c_string)
	LD HL,(ZXBASIC_VAR_d_string)
; <=
	CALL runtimeSmallerEqualString
	CALL runtimePrintInt
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
	CALL ZXFreeTempCompact
ZXBASIC_LINE_1990:
; 1990  PRINT c$;"<>";d$;" -> ";c$ <> d$
	LD HL,1990
	LD (23621),HL
; 		1990.1  PRINT c$;"<>";d$;" -> ";c$ <> d$
	LD A,1
	LD (23623),a
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,(ZXBASIC_VAR_c_string)
	CALL runtimePrintString
	LD HL,STRING_17	;<>
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_d_string)
	CALL runtimePrintString
	LD HL,STRING_13	; -> 
	CALL runtimePrintString
	LD DE,(ZXBASIC_VAR_c_string)
	LD HL,(ZXBASIC_VAR_d_string)
; <>
	CALL runtimeUnequalString
	CALL runtimePrintInt
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
	CALL ZXFreeTempCompact
ZXBASIC_LINE_2000:
; 2000  PRINT c$;"= ";d$;" -> ";c$=d$
	LD HL,2000
	LD (23621),HL
; 		2000.1  PRINT c$;"= ";d$;" -> ";c$=d$
	LD A,1
	LD (23623),a
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,(ZXBASIC_VAR_c_string)
	CALL runtimePrintString
	LD HL,STRING_18	;= 
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_d_string)
	CALL runtimePrintString
	LD HL,STRING_13	; -> 
	CALL runtimePrintString
	LD DE,(ZXBASIC_VAR_c_string)
	LD HL,(ZXBASIC_VAR_d_string)
; =
	CALL runtimeEqualString
	CALL runtimePrintInt
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
	CALL ZXFreeTempCompact
ZXBASIC_LINE_2010:
; 2010  RETURN 
	LD HL,2010
	LD (23621),HL
; 		2010.1  RETURN 
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	RET
ZXBASIC_LINE_2020:
; 2020  PRINT c$;"> ";b$;" -> ";c$>b$
	LD HL,2020
	LD (23621),HL
; 		2020.1  PRINT c$;"> ";b$;" -> ";c$>b$
	LD A,1
	LD (23623),a
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,(ZXBASIC_VAR_c_string)
	CALL runtimePrintString
	LD HL,STRING_12	;> 
	CALL runtimePrintString
	LD HL,ZXBASIC_VAR_b_string
	LD BC,8
	CALL runtimePrintFixString
	LD HL,STRING_13	; -> 
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_c_string)
	PUSH HL
	LD HL,ZXBASIC_VAR_b_string
	PUSH HL
; >
	POP IX
	POP HL
	LD DE,8
	CALL runtimeBiggerStringFixVar
	CALL runtimePrintInt
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
	CALL ZXFreeTempCompact
ZXBASIC_LINE_2030:
; 2030  PRINT c$;"< ";b$;" -> ";c$<b$
	LD HL,2030
	LD (23621),HL
; 		2030.1  PRINT c$;"< ";b$;" -> ";c$<b$
	LD A,1
	LD (23623),a
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,(ZXBASIC_VAR_c_string)
	CALL runtimePrintString
	LD HL,STRING_15	;< 
	CALL runtimePrintString
	LD HL,ZXBASIC_VAR_b_string
	LD BC,8
	CALL runtimePrintFixString
	LD HL,STRING_13	; -> 
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_c_string)
	PUSH HL
	LD HL,ZXBASIC_VAR_b_string
	PUSH HL
; <
	POP IX
	POP HL
	LD DE,8
	CALL runtimeSmallerStringFixVar
	CALL runtimePrintInt
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
	CALL ZXFreeTempCompact
ZXBASIC_LINE_2040:
; 2040  PRINT c$;">=";b$;" -> ";c$ >= b$
	LD HL,2040
	LD (23621),HL
; 		2040.1  PRINT c$;">=";b$;" -> ";c$ >= b$
	LD A,1
	LD (23623),a
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,(ZXBASIC_VAR_c_string)
	CALL runtimePrintString
	LD HL,STRING_14	;>=
	CALL runtimePrintString
	LD HL,ZXBASIC_VAR_b_string
	LD BC,8
	CALL runtimePrintFixString
	LD HL,STRING_13	; -> 
	CALL runtimePrintString
	LD DE,(ZXBASIC_VAR_c_string)
	LD HL,ZXBASIC_VAR_b_string
; >=
	LD BC,8
	CALL runtimeBiggerEqualStringFixVar
	CALL runtimePrintInt
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
	CALL ZXFreeTempCompact
ZXBASIC_LINE_2050:
; 2050  PRINT c$;"<=";b$;" -> ";c$ <= b$
	LD HL,2050
	LD (23621),HL
; 		2050.1  PRINT c$;"<=";b$;" -> ";c$ <= b$
	LD A,1
	LD (23623),a
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,(ZXBASIC_VAR_c_string)
	CALL runtimePrintString
	LD HL,STRING_16	;<=
	CALL runtimePrintString
	LD HL,ZXBASIC_VAR_b_string
	LD BC,8
	CALL runtimePrintFixString
	LD HL,STRING_13	; -> 
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_c_string)
	PUSH HL
	LD HL,ZXBASIC_VAR_b_string
	PUSH HL
; <=
	POP IX
	POP HL
	LD DE,8
	CALL runtimeSmallerEqualStringFixVar
	CALL runtimePrintInt
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
	CALL ZXFreeTempCompact
ZXBASIC_LINE_2060:
; 2060  PRINT c$;"<>";b$;" -> ";c$ <> b$
	LD HL,2060
	LD (23621),HL
; 		2060.1  PRINT c$;"<>";b$;" -> ";c$ <> b$
	LD A,1
	LD (23623),a
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,(ZXBASIC_VAR_c_string)
	CALL runtimePrintString
	LD HL,STRING_17	;<>
	CALL runtimePrintString
	LD HL,ZXBASIC_VAR_b_string
	LD BC,8
	CALL runtimePrintFixString
	LD HL,STRING_13	; -> 
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_c_string)
	PUSH HL
	LD HL,ZXBASIC_VAR_b_string
	PUSH HL
; <>
	POP IX
	POP HL
	LD DE,8
	CALL runtimeUnequalStringFixVar
	CALL runtimePrintInt
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
	CALL ZXFreeTempCompact
ZXBASIC_LINE_2070:
; 2070  PRINT c$;"= ";b$;" -> ";c$=b$
	LD HL,2070
	LD (23621),HL
; 		2070.1  PRINT c$;"= ";b$;" -> ";c$=b$
	LD A,1
	LD (23623),a
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,(ZXBASIC_VAR_c_string)
	CALL runtimePrintString
	LD HL,STRING_18	;= 
	CALL runtimePrintString
	LD HL,ZXBASIC_VAR_b_string
	LD BC,8
	CALL runtimePrintFixString
	LD HL,STRING_13	; -> 
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_c_string)
	PUSH HL
	LD HL,ZXBASIC_VAR_b_string
	PUSH HL
; =
	POP IX
	POP HL
	LD DE,8
	CALL runtimeEqualStringFixVar
	CALL runtimePrintInt
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
	CALL ZXFreeTempCompact
ZXBASIC_LINE_2080:
; 2080  RETURN 
	LD HL,2080
	LD (23621),HL
; 		2080.1  RETURN 
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	RET
ZXBASIC_LINE_2090:
; 2090  PRINT a$;"> ";d$;" -> ";a$>d$
	LD HL,2090
	LD (23621),HL
; 		2090.1  PRINT a$;"> ";d$;" -> ";a$>d$
	LD A,1
	LD (23623),a
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,ZXBASIC_VAR_a_string
	LD BC,8
	CALL runtimePrintFixString
	LD HL,STRING_12	;> 
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_d_string)
	CALL runtimePrintString
	LD HL,STRING_13	; -> 
	CALL runtimePrintString
	LD IX,ZXBASIC_VAR_a_string
	LD HL,(ZXBASIC_VAR_d_string)
; >
	LD DE,8
	CALL runtimeBiggerStringVarFix
	CALL runtimePrintInt
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
	CALL ZXFreeTempCompact
ZXBASIC_LINE_2100:
; 2100  PRINT a$;"< ";d$;" -> ";a$<d$
	LD HL,2100
	LD (23621),HL
; 		2100.1  PRINT a$;"< ";d$;" -> ";a$<d$
	LD A,1
	LD (23623),a
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,ZXBASIC_VAR_a_string
	LD BC,8
	CALL runtimePrintFixString
	LD HL,STRING_15	;< 
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_d_string)
	CALL runtimePrintString
	LD HL,STRING_13	; -> 
	CALL runtimePrintString
	LD IX,ZXBASIC_VAR_a_string
	LD HL,(ZXBASIC_VAR_d_string)
; <
	LD DE,8
	CALL runtimeSmallerStringVarFix
	CALL runtimePrintInt
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
	CALL ZXFreeTempCompact
ZXBASIC_LINE_2110:
; 2110  PRINT a$;">=";d$;" -> ";a$ >= d$
	LD HL,2110
	LD (23621),HL
; 		2110.1  PRINT a$;">=";d$;" -> ";a$ >= d$
	LD A,1
	LD (23623),a
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,ZXBASIC_VAR_a_string
	LD BC,8
	CALL runtimePrintFixString
	LD HL,STRING_14	;>=
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_d_string)
	CALL runtimePrintString
	LD HL,STRING_13	; -> 
	CALL runtimePrintString
	LD IX,ZXBASIC_VAR_a_string
	LD HL,(ZXBASIC_VAR_d_string)
; >=
	LD DE,8
	CALL runtimeBiggerEqualStringVarFix
	CALL runtimePrintInt
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
	CALL ZXFreeTempCompact
ZXBASIC_LINE_2120:
; 2120  PRINT a$;"<=";d$;" -> ";a$ <= d$
	LD HL,2120
	LD (23621),HL
; 		2120.1  PRINT a$;"<=";d$;" -> ";a$ <= d$
	LD A,1
	LD (23623),a
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,ZXBASIC_VAR_a_string
	LD BC,8
	CALL runtimePrintFixString
	LD HL,STRING_16	;<=
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_d_string)
	CALL runtimePrintString
	LD HL,STRING_13	; -> 
	CALL runtimePrintString
	LD IX,ZXBASIC_VAR_a_string
	LD HL,(ZXBASIC_VAR_d_string)
; <=
	LD DE,8
	CALL runtimeSmallerEqualStringVarFix
	CALL runtimePrintInt
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
	CALL ZXFreeTempCompact
ZXBASIC_LINE_2130:
; 2130  PRINT a$;"<>";d$;" -> ";a$ <> d$
	LD HL,2130
	LD (23621),HL
; 		2130.1  PRINT a$;"<>";d$;" -> ";a$ <> d$
	LD A,1
	LD (23623),a
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,ZXBASIC_VAR_a_string
	LD BC,8
	CALL runtimePrintFixString
	LD HL,STRING_17	;<>
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_d_string)
	CALL runtimePrintString
	LD HL,STRING_13	; -> 
	CALL runtimePrintString
	LD HL,ZXBASIC_VAR_a_string
	PUSH HL
	LD DE,(ZXBASIC_VAR_d_string)
; <>
	POP HL
	LD BC,8
	CALL runtimeUnequalStringVarFix
	CALL runtimePrintInt
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
	CALL ZXFreeTempCompact
ZXBASIC_LINE_2140:
; 2140  PRINT a$;"= ";d$;" -> ";a$=d$
	LD HL,2140
	LD (23621),HL
; 		2140.1  PRINT a$;"= ";d$;" -> ";a$=d$
	LD A,1
	LD (23623),a
	LD A,2
	CALL $1601	;Open Channel
	LD A,(ZX_P_FLAG)
	PUSH AF
	LD HL,ZXBASIC_VAR_a_string
	LD BC,8
	CALL runtimePrintFixString
	LD HL,STRING_18	;= 
	CALL runtimePrintString
	LD HL,(ZXBASIC_VAR_d_string)
	CALL runtimePrintString
	LD HL,STRING_13	; -> 
	CALL runtimePrintString
	LD IX,ZXBASIC_VAR_a_string
	LD HL,(ZXBASIC_VAR_d_string)
; =
	LD DE,8
	CALL runtimeEqualStringVarFix
	CALL runtimePrintInt
	CALL runtimePrintNewline
	POP AF
	LD (ZX_P_FLAG),A
	CALL ZXFreeTempCompact
ZXBASIC_LINE_2150:
; 2150  RETURN 
	LD HL,2150
	LD (23621),HL
; 		2150.1  RETURN 
	LD A,1
	LD (23623),a
	CALL runtimeCheckBreak
	RET
ZXBASIC_LINE_2160:
; 2160  STOP 
	LD HL,2160
	LD (23621),HL
ZXBASIC_VAR_a_string:	defs 18
ZXBASIC_VAR_af:	defs 5
ZXBASIC_VAR_ai:	dw 0
ZXBASIC_VAR_b_string:	defs 18
ZXBASIC_VAR_bf:	defs 5
ZXBASIC_VAR_bi:	dw 0
ZXBASIC_VAR_c_string:	dw 0
ZXBASIC_VAR_d_string:	dw 0
STRING_0:	dw 1
	db	"A"
STRING_1:	dw 1
	db	"B"
STRING_10:	dw 23
	db	"Fix/Var String: compare"
STRING_11:	dw 8
	db	"--------"
STRING_12:	dw 2
	db	"> "
STRING_13:	dw 4
	db	" -> "
STRING_14:	dw 2
	db	">="
STRING_15:	dw 2
	db	"< "
STRING_16:	dw 2
	db	"<="
STRING_17:	dw 2
	db	"<>"
STRING_18:	dw 2
	db	"= "
STRING_19:	dw 1
	db	"+"
STRING_2:	dw 19
	db	"Var String: compare"
STRING_20:	dw 1
	db	"-"
STRING_21:	dw 1
	db	"*"
STRING_22:	dw 1
	db	"/"
STRING_23:	dw 1
	db	"^"
STRING_3:	dw 0
STRING_4:	dw 19
	db	"Fix String: compare"
STRING_5:	dw 14
	db	"Float: Compare"
STRING_6:	dw 14
	db	"Int16: Compare"
STRING_7:	dw 11
	db	"Float: Math"
STRING_8:	dw 11
	db	"Int16: Math"
STRING_9:	dw 23
	db	"Var/Fix String: compare"

ZX_VARIABLES:
	db 0

    DISPLAY "Compiled Basic = ", /D, $-CBASIC_START,  " bytes"
