1000 LET a=1
1010 LET a=1
1020 IF NOT(a < 10 ) THEN GOTO 1070
1030 if a > 5 then GOTO 1070
1040 print "a=";a
1050 LET a=a+1
1060 GOTO 1020
1070 LET key=3
1080 IF key <> 1 THEN GOTO 1100
1090 LET contrlFN = 1210: GOTO 1140
1100 IF key <> 2 THEN GOTO 1120
1110 LET contrlFN = 1230: GOTO 1140
1120 IF key <> 3 THEN GOTO 1140
1130 LET contrlFN = 1250: GOTO 1140
1140 print "Funktionsaufruf: Key = ";key
1150 gosub contrlFN
1160 Print "Funktionsaufruf: ",
1170 GO SUB 1300
1180 LET PROCtest0=100:LET PROCtest1=200:GO SUB 1270
1190 pause 0
1200 return
1210 print "game control with keyboard"
1220 return
1230 print "game control with kempston"
1240 return
1250 print "game control with sinclair"
1260 return
1270 print "test proc called with abc=";PROCtest0;" def=";PROCtest1
1280 print "abc+def=";PROCtest0+PROCtest1
1290 return
1300 print "Test2 proc called"
1310 return
1320 LET label=1010
1330 stop
