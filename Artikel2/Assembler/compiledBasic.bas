1  CLS :
     RESTORE 
2  RANDOMIZE 
11  GOSUB 950
15  LET sc=25:
     LET l=3
20  GOSUB 700
30  LET k$= INKEY :
     LET j= IN 31
35  IF sc=0 THEN  FOR w=10 TO 50:
     BEEP 0.004,w:
     PRINT  AT 21,11; FLASH 1;"WELL DONE":
     PRINT  AT r,c; INK ( RND *7);""; AT r,c; CHR 128:
     NEXT w:
     PRINT  AT 1,10;"TOWERS SAVED ";l:
     FOR u=1 TO 120:
     BEEP 0.002,( RND *35):
     OUT 254,( RND *32):
     BEEP .012,( RND *25):
     NEXT u:
     GOTO 2
40  LET y=y+((k$="a" OR j=4) AND y<19)-((k$="q" OR j=8) AND y>3)
45  IF oy <> y OR ox <> x THEN  PRINT  AT oy,ox;" "; AT oy,ox+5;" ";
50  PRINT  AT y,x; INK 1;""; AT y,x+5;"";
55  LET oy=y:
     LET ox=x
60  IF (k$="o" OR j=2) AND c<12 THEN  LET fl=1:
     GOSUB 200
65  IF (k$="p" OR j=1) AND c>17 THEN  LET fr=1:
     GOSUB 200
111  PRINT  AT r,c;" "
120  LET r=r+v:
     LET c=c+h
125  PRINT  AT r,c;" "
126  BEEP 0.0015,60
135  IF c<1 OR c>30 THEN  LET h=-h
140  IF r<0 OR r >= 18 THEN  LET v=-v
158  IF or>2 AND oc>13.5 AND oc<17.5 THEN  BEEP 0.015,-12.0:
     PRINT  AT r,c; FLASH 1; OVER 1; INK 2; PAPER 6;"*"; AT or,oc;"":
     LET i=i+1
159  PRINT  AT r,c;""
160  LET or=r:
     LET oc=c
170  IF i >= 20 THEN  FOR k=-20 TO 10:
     BEEP 0.015,-10:
     NEXT k:
     LET l=l-1:
     PRINT  AT 21,31; PAPER 4;l;:
     LET i=0:
     GOTO 175
172  GOTO 30
175  FOR d=3 TO 19:
     BEEP 0.001,-25:
     PRINT  AT d,14; PAPER 5; OVER 1; INK 2; PAPER 6; FLASH 1;"****"; AT d,14;"";:
     NEXT d:
     FOR s=1 TO 420:
     NEXT s
180  IF l=0 THEN  LET l=3:
     LET sc=20:
     PRINT  AT 1,8; FLASH 1; INK 0;"G A M E  O V E R":
     FOR a=1 TO 120:
     BEEP 0.015,a/35:
     NEXT a:
     CLS :
     GOTO 20
190  GOSUB 800
195  GOTO 30
200  BEEP 0.0020,15:
     OUT 254,( RND *32)
210  IF fl=1 THEN  PLOT  INK 5;ox*8-1,oy*8-173:
     DRAW  OVER 1; INK 3;-70,0:
     DRAW  OVER 1; INK 5;70,0:
     LET fl=0
250  IF fr=1 THEN  PLOT  INK 5;ox*8+48,oy*8-173:
     DRAW  OVER 1; INK 3;70,0:
     DRAW  OVER 1; INK 5;-70,0:
     LET fr=0
260  IF  ATTR (r,c)=40 THEN  RETURN 
270  FOR g=50 TO 55:
     PRINT  AT r,c; INK ( RND *7);"";:
     BEEP 0.001,g:
     PRINT  AT r,c; CHR 128:
     NEXT g:
     LET sc=sc-1:
     LET r=1:
     LET c=( RND *29)+1
275  PRINT  AT 21,4; PAPER 4;sc; CHR 128
280  RETURN 
700  PAPER 7:
     INK 0:
     BORDER 7:
     CLS 
701  PRINT  AT 7,2;"                                                                                                                                                                                           ";
702  PRINT  AT 21,10;"By Animated AL"
703  PRINT  AT 1,8;"PRESS FIRE TO PLAY"
705  OUT 254,( RND *32)
706  BEEP 0.008,35-( RND *7)
715  IF  INKEY  <> "" OR  IN 31=16 THEN  LET cn=2:
     GOTO 800
720  GOTO 705
800  REM SET UP
805  PAPER 5:
     INK 0:
     BORDER 5:
     CLS 
810  FOR b=4 TO 19
815  PRINT  AT 3,14;""; PAPER 7;""; PAPER 5;"";
820  PRINT  AT b,14; INK 0; PAPER 7;"";:
     NEXT b
825  PRINT  AT 20,0; PAPER 4;""
826  PRINT  AT 21,0; PAPER 4;,,
830  LET y=19:
     LET oy=y:
     LET x=13:
     LET ox=x
840  LET r=5:
     LET or=r:
     LET c=1:
     LET oc=c:
     LET h=1:
     LET v=1
845  LET i=0:
     LET fl=0:
     LET fr=0
850  PRINT  AT 21,0; PAPER 4;"UFO:
    ";sc; AT 21,24;"TOWERS:
    ";l
860  RETURN 
950  FOR a=0 TO 23
960  READ dat
970  POKE  USR "a"+a,dat
980  NEXT a:
     RETURN 
1000  DATA 6,6,243,63,15,139,219,126
1010  DATA 96,96,207,252,240,209,219,126
1020  DATA 24,60,102,66,255,219,126,129
9998  STOP 

