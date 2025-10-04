1000 !1000 GO SUB 1310
1010 GO SUB 1050
1020 GOTO 1910
1030 REM SUB game
1040 REM ---------
1050 CLS
1060 LET p1 = 1: LET p2 = 1: LET player = 1
1070 LET PROCdrawboard0=p1:LET PROCdrawboard1= p2:GO SUB 1690
1080 INK 7: PRINT AT 20, 0; "Spieler "; player; " am Zug ";
1090 GO SUB 1510
1100 IF NOT(player = 1) THEN GOTO 1140
1110 LET p1 = p1 + roll
1120 LET p1 = CALL checkSpecialFields(p1)
1130 GOTO 1160
1140 LET p2 = p2 + roll
1150 LET p2 = CALL checkSpecialFields(p2)
1160 LET PROCdrawboard0=p1:LET PROCdrawboard1= p2:GO SUB 1690
1170 IF p1 >= 30 THEN INK 2: PRINT AT 16, 0; "Spieler 1 gewinnt! ";: GOTO 1210
1180 IF p2 >= 30 THEN INK 5: PRINT AT 16, 0; "Spieler 2 gewinnt! ";: GOTO 1210
1190 LET player = 3 - player
1200 GOTO 1080
1210 GOTO 1910
1220 return
1230 DATA 24, 60, 126, 219, 255, 126, 60, 24
1240 DATA 24, 60, 126, 219, 255, 102, 60, 24
1250 DATA 60, 66, 165, 129, 165, 153, 66, 60
1260 DATA 60, 66, 165, 129, 153, 165, 66, 60
1270 DATA 60, 90, 189, 189, 189, 189, 90, 60
1280 DATA 0, 0, 24, 60, 60, 24, 0, 0
1290 REM SUB readudg
1300 REM ------------
1310 LET adr = USR "A"
1320 FOR i=1 TO 6
1330 FOR b = 1 TO 8
1340 READ a:POKE adr,a:LET adr=adr+1
1350 NEXT b
1360 NEXT i
1370 return
1380 REM SUB drawdice
1390 REM -------------
1400 GOTO 1410+10*frame
1410 REM there is nice 0
1420 PRINT AT 1, 0; "\138   \133";AT 2, 0; "\138 \149 \133";AT 3, 0; "\138   \133";:RETURN
1430 PRINT AT 1, 0; "\138\149  \133";AT 2, 0; "\138   \133";AT 3, 0; "\138  \149\133";:RETURN
1440 PRINT AT 1, 0; "\138\149  \133";AT 2, 0; "\138 \149 \133";AT 3, 0; "\138  \149\133";:RETURN
1450 PRINT AT 1, 0; "\138\149 \149\133";AT 2, 0; "\138   \133";AT 3, 0; "\138\149 \149\133";:RETURN
1460 PRINT AT 1, 0; "\138\149 \149\133";AT 2, 0; "\138 \149 \133";AT 3, 0; "\138\149 \149\133";:RETURN
1470 PRINT AT 1, 0; "\138\149 \149\133";AT 2, 0; "\138\149 \149\133";AT 3, 0; "\138\149 \149\133";:RETURN
1480 return
1490 REM SUB rolldice
1500 REM -------------
1510 LET frame =0
1520 LET lastKey =0
1530 PRINT AT 5, 0; "Taste=STOP"
1540 INK 7
1550 PAPER 1
1560 PRINT AT 0, 0; "\139\131\131\131\135";AT 4,0;"\142\140\140\140\141";
1570 LET frame = frame + 1
1580 IF frame = 7 THEN LET frame=1
1590 LET PROCdrawdice0=frame:GO SUB 1400
1600 LET k = CODE inkey$
1610 IF k <> 0 THEN LET lastKey = k:GOTO 1630
1620 GOTO 1570
1630 LET roll=frame
1640 INK 7
1650 PAPER 0
1660 return
1670 REM SUB drawboard(0=p1, 1=p2)
1680 REM --------------------------
1690 CLS
1700 PRINT AT 0, 5; "LUCKY RACE";
1710 LET row = 1
1720 LET col = 1
1730 FOR f = 1 TO 30
1740 INK 4: PAPER 7
1750 PRINT AT 2 + row * 2, col * 3; "\139";
1760 IF f < 10 THEN PRINT " "; f;
1770 if f >= 10 then PRINT f;
1780 PRINT "\135"
1790 IF f = PROCdrawboard0 THEN INK 2: PRINT AT 2 + row * 2, col * 3 + 1; "\144";:GOTO #drawBoard1
1800 IF f = PROCdrawboard1 THEN INK 5: PRINT AT 2 + row * 2, col * 3 + 1; "\145";:GOTO #drawBoard1
1810 IF f = 5 OR f = 15 OR f = 25 THEN INK 3: PRINT AT 2 + row * 2, col * 3 + 1; "\146";:GOTO #drawBoard1
1820 IF f = 8 OR f = 18 OR f = 28 THEN INK 1: PRINT AT 2 + row * 2, col * 3 + 1; "\147";:GOTO #drawBoard1
1830 IF f = 12 OR f = 22 THEN INK 6: PRINT AT 2 + row * 2, col * 3 + 1; "\148";:GOTO #drawBoard1
1840 LET col=col+1: if col=11 then LET col=1: LET row=row+1
1850 NEXT f
1860 INK 2: PRINT AT 18, 0; "P1: Feld "; PROCdrawboard0
1870 INK 5: PRINT AT 19, 0; "P2: Feld "; PROCdrawboard1
1880 return
1890 REM SUB sub
1900 REM --------
1910 STOP
