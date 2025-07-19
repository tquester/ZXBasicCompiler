1  REM compiler-options
2  REM int16 i x y dx dy ny nx n b zi zx zy UDG s() x() y() d()
3  REM data int16
4  DIM s(22,22):
     DIM x(100):
     DIM y(100):
     DIM c$(100,1):
     DIM d$(100,1):
     DIM c(100):
     DIM d(100)
10  REM \134      ZXombies!      \134
20  REM \134   2017 @xenopunk   \134
30  REM \134 #zxspectrumbasicjam \134
40  LET UDG=0
50  REM \134\134\134\134\134\134\134\134\134\134 Title Screen
60  BORDER 0:
     PAPER 0:
     INK 7:
     BRIGHT 1:
     CLS 
70  PRINT  AT 0,12; INK 2;"ZXombies!"
80  PRINT  AT 2,3; INK 6; BRIGHT 0;"It's 1983 and the dead are"; AT 3,5;"rising from the grave."; AT 4,8;"Who can save us?"
90  PRINT  AT 18,9; INK 4; BRIGHT 0;"2017 @xenopunk"
100  PRINT  AT 19,7; INK 4; BRIGHT 0;"#zxspectrumbasicjam"
110  REM --------Define graphics
120  IF UDG THEN  GOTO 230
130  PRINT  AT 21,8; INK 1; BRIGHT 0;"Decomposing"
140  DATA 56:
     RESTORE 140:
     READ n:
     FOR i=1 TO n:
     READ b:
     POKE  USR "a"+i-1,b:
     PRINT  AT 21,20; INK 1; BRIGHT 0;i;"/";n:
     BEEP 0.002,i:
     NEXT i
150  DATA 24,24,16,60,90,24,36,68
160  DATA 0,60,126,66,126,66,126,126
170  DATA 0,8,16,223,252,34,65,0
180  DATA 24,24,16,30,24,24,20,36
190  DATA 24,24,82,60,24,24,20,20
200  DATA 24,24,16,56,124,186,40,68
210  DATA 0,24,24,126,126,24,24,0
220  LET UDG=1
230  REM -----------Instructions
240  PRINT  AT 6,3; INK 3;"\144"; INK 7; BRIGHT 0;" MAGENTA       100% badass"
250  PRINT  AT 8,3; INK 4; BRIGHT 1;"\147"; INK 7; BRIGHT 0;" DAWDLER        +10 points"
260  PRINT  AT 10,3; INK 5; BRIGHT 1;"\148"; INK 7; BRIGHT 0;" WHINGER        +20 points"
270  PRINT  AT 12,3; INK 6; BRIGHT 1;"\149"; INK 7; BRIGHT 0;" GUZZLER        +30 points"
280  PRINT  AT 14,3; PAPER 2; INK 7; BRIGHT 1;"\150"; PAPER 0; INK 7; BRIGHT 0;" PLASTER           +1 life"
290  PRINT  AT 16,3; INK 5; BRIGHT 1;"QAOP to move + M to attack!"
300  PRINT  AT 21,0; INK 7; FLASH 1;"     Press any key to start     "
310  IF  INKEY$ ="" THEN  GOTO 310
320  REM \134\134\134\134\134\134\134\134\134\134\134\134 Start game
330  BORDER 0:
     PAPER 0:
     INK 7:
     BRIGHT 1:
     CLS 
340  REM ---------------Draw map
350  INK 1:
     BRIGHT 0
360  PRINT  AT 2,0;"+++++++++++++++++++++++++++++++++"
370  FOR i=3 TO 19
380  PRINT  AT i,31;"++"
390  NEXT i
400  PRINT  AT 20,31;"+++++++++++++++++++++++++++++++++"
410  INK 7:
     BRIGHT 1
420  REM -----------Setup player
430  LET score=0:
     PRINT  AT 0,0; BRIGHT 0;"Score:
    ":
     GOSUB 1210
440  LET lives=3:
     PRINT  AT 0,23; BRIGHT 0;"Lives:
    "; INK 3; BRIGHT 1;"\144\144\144"
450  LET wave=1:
     PRINT  AT 0,13; BRIGHT 0;"Wave:
    ":
     GOSUB 1240
460  REM \134\134\134\134\134\134\134\134\134\134\134\134 Start wave
470  DIM s(22,32)
480  REM ----------Setup zombies
490  LET nz=5+ INT ( RND *25)
500  LET za=4/7
510  LET zb=2/3
520  LET zc=1
530  DIM x(nz)
540  DIM y(nz)
550  DIM c$(nz,1):
     DIM d$(nz,1)
560  DIM c(nz):
     DIM d(nz)
570  LET zi=1
580  LET kz=0
590  PRINT  AT 1,10; INK 1;"Exhuming"
600  FOR i=1 TO nz
610  LET x(i)=2+ INT ( RND *28)
620  LET y(i)=4+ INT ( RND *16)
630  IF s(y(i),x(i)) THEN  GOTO 610
640  LET s(y(i),x(i))=i
650  LET c$(i)="\145":
     LET c(i)=7:
     PRINT  AT y(i),x(i); INK 7; BRIGHT 0;"\145"
660  IF  RND <za THEN  LET d$(i)="\147":
     LET d(i)=4:
     GOTO 700
670  IF  RND <zb THEN  LET d$(i)="\148":
     LET d(i)=5:
     GOTO 700
680  IF  RND <zc THEN  LET d$(i)="\149":
     LET d(i)=6
690  REM LET c$(i)="\150":
     LET c(i)=7:
     PRINT AT y(i),x(i); PAPER 2; INK 7; BRIGHT 1;"\150"
700  PRINT  AT 1,19; INK 1;i;"/";nz:
     BEEP 0.005,i-12
710  NEXT i
720  PRINT  AT 1,10;"              "
730  GOSUB 1120
740  REM ---------Setup framrate
750  LET t=65536* PEEK 23674+256* PEEK 23673+ PEEK 23672+50:
     LET f=0
760  REM \134\134\134\134\134\134\134\134\134\134\134\134\134 Game loop
770  REM ----------Update player
780  LET inkey= CODE  INKEY$ 
782  LET dy=(inkey=10 AND  y<20)-(inkey=11 AND y>3):
     LET ny=y+dy
783  LET dx=(inkey=9  AND x<30)-( inkey = 8 AND x>1):
     LET nx=x+dx
784  IF dx OR dy THEN  GOTO 810
789  LET dy=( IN 65022=190 AND y<20)-( IN 64510=190 AND y>3):
     LET ny=y+dy
790  LET dx=( IN 57342=190 AND x<30)-( IN 57342=189 AND x>1):
     LET nx=x+dx
800  IF  NOT (dx OR dy) THEN  GOTO 840
805  
810  IF (inkey <> 0 OR  IN 32766=191) AND s(ny,nx)=0 THEN  LET s(y,x)=0:
     PRINT  AT y,x;" ":
     LET x=nx:
     LET y=ny:
     LET s(y,x)=-1:
     PRINT  AT y,x; INK 3; BRIGHT 1;"\144":
     BEEP 0.001,24:
     GOTO 840
820  IF (inkey <> 0 OR  IN 32766=191) AND s(ny,nx)>0 THEN  IF c$(s(ny,nx))>"\146" THEN  GOSUB 1180:
     IF lives=0 THEN  GOTO 1060
830  IF (inkey <> 0 OR  IN 32766=190 OR  IN 32766=187) AND s(ny,nx)>0 THEN  IF c$(s(ny,nx))>"\146" THEN  PRINT  AT ny,nx; INK 2; OVER 1;"*":
     BEEP 0.01,36:
     BEEP 0.01,30:
     LET score=score+ (10 AND c$(s(ny,nx))="\147")+(20 AND c$(s(ny,nx))="\148")+(30 AND c$(s(ny,nx))="\149"):
     LET c$(s(ny,nx))="\146":
     PRINT  AT ny,nx; INK c(s(ny,nx)); BRIGHT 0;"\146":
     GOSUB 1210:
     LET kz=kz+1:
     IF kz=nz THEN  GOTO 1000
840  REM ---------Update zombies
850  LET zx=x(zi):
     LET zy=y(zi)
860  IF c$(zi)="\145" THEN  GOTO 930
870  IF c$(zi)="\146" THEN  GOTO 950
880  LET dx= SGN (x-zx):
     LET dy= SGN (y-zy):
     LET nx=zx+dx:
     LET ny=zy+dy
890  IF s(ny,nx)=0 THEN  LET s(zy,zx)=0:
     PRINT  AT zy,zx;" ":
     LET x(zi)=nx:
     LET y(zi)=ny:
     LET s(ny,nx)=zi:
     PRINT  AT ny,nx; INK c(zi); BRIGHT 1;c$(zi):
     BEEP 0.001,12:
     GOTO 950
900  IF s(ny,nx)>0 THEN  GOTO 950
910  GOSUB 1180:
     IF lives=0 THEN  GOTO 1060
920  GOTO 950
930  IF  RND <1/2 THEN  GOTO 950
940  LET c$(zi)=d$(zi):
     LET c(zi)=d(zi):
     PRINT  AT zy,zx; INK c(zi); BRIGHT 1;c$(zi):
     BEEP 0.01,-12:
     BEEP 0.01,-13:
     BEEP 0.01,-14
950  LET zi=zi+1:
     IF zi>nz THEN  LET zi=1
960  REM -------Update framerate
970  GOTO 760
980  LET dt=65536* PEEK 23674+256* PEEK 23673+ PEEK 23672:
     LET f=f+1:
     IF dt >= t THEN  PRINT  AT 1,14; INK 1; BRIGHT 0;f:
     LET t=dt+50:
     LET f=0
990  GOTO 760
1000  REM \134\134\134\134\134\134\134\134\134 Wave complete
1010  PRINT  AT 1,9;"WAVE COMPLETE!":
     BEEP 0.1,0:
     BEEP 0.05,0:
     BEEP 0.05,0:
     BEEP 0.2,12
1020  FOR i=1 TO nz:
     PRINT  AT y(i),x(i);" ":
     BEEP 0.01,i:
     NEXT i:
     PRINT  AT y,x;" "
1030  PRINT  AT 1,9;"              "
1040  LET wave=wave+1:
     GOSUB 1240
1050  GOTO 460
1060  REM \134\134\134\134\134\134\134\134\134\134\134\134\134 Game Over
1070  FOR j=1 TO 10:
     PRINT  AT 1,j;" GAME"; AT 1,26-j;"OVER! ":
     BEEP 0.02,-11-j:
     BEEP 0.02,-8-j:
     NEXT j
1080  PRINT  AT 1,0; INK 7; FLASH 1;"    Press any key to continue   "
1090  IF  INKEY$ ="" THEN  GOTO 1090
1100  GOTO 50
1110  REM \134\134\134\134\134\134\134\134\134\134\134 Subroutines
1120  REM -----------Spawn player
1130  LET x=2+ INT ( RND *28)
1140  LET y=4+ INT ( RND *16)
1150  IF s(y,x) THEN  GOTO 1130
1160  LET s(y,x)=-1:
     FOR j=1 TO 10 STEP 2:
     PRINT  AT y,x;" ":
     BEEP 0.01,j+12:
     PRINT  AT y,x; INK 3; BRIGHT 1;"\144":
     BEEP 0.01,j+13:
     NEXT j
1170  RETURN 
1180  REM ------------Kill player
1190  PRINT  AT y,x; INK 2; OVER 1;"*":
     BEEP 0.01,24:
     BEEP 0.01,18:
     LET s(y,x)=0:
     PRINT  AT y,x; INK 3; BRIGHT 0;"\146":
     FOR j=1 TO 6 STEP 2:
     PRINT  AT 0,28+lives; INK 3; BRIGHT 1;"\144":
     BEEP 0.01,0-j:
     PRINT  AT 0,28+lives; INK 1; BRIGHT 0;"\144":
     BEEP 0.01,0-j-1:
     NEXT j:
     LET lives=lives-1:
     IF lives>0 THEN  PRINT  AT y,x;" ":
     GOSUB 1130
1200  RETURN 
1210  REM -----------Update score
1220  PRINT  AT 0,6; INK 7; BRIGHT 1;score
1230  RETURN 
1240  REM ------------Update wave
1250  PRINT  AT 0,18; BRIGHT 1;wave
1260  RETURN 
1270  REM -------------Extra life
1280  LET lives=lives+1
1290  PRINT  AT 0,28+lives; INK 3; BRIGHT 1;"\144"
1300  RETURN 
9000  PRINT  AT 0,0;"57342="; IN 57342;" 32766="; IN 32766;" 65022= "; IN 65022;" 64510="; IN 64510;
9010  GOTO 9000
9990  STOP 

