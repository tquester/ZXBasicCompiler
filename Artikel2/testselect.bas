; ---------------------------------------------
; test procedure
; ---------------------------------------------

test(5,6)

; ---------------------------------------------
; test select
; ---------------------------------------------
FOR a=1 TO 4
    FOR b=1 TO 3
        PRINT "a=";a;" b=";b
        SELECT a
            CASE 1: PRINT "CASE 1"
            SELECT b
                CASE 1: PRINT "CASE 1.1"
                PRINT "Neue Zeile"
                PRINT "Dritte Zeile"
                CASE 2: PRINT "CASE 1.2"
                ELSE: PRINT "ELSE block: b>2"
            END SELECT
            CASE 2: PRINT "2"
            SELECT b
                CASE 1: PRINT "CASE 2.1"
                CASE 2: PRINT "CASE 2.2"
            END SELECT
            CASE 3: PRINT "3"
            SELECT b
                CASE 1: PRINT "CASE 3.1"
                CASE 2: PRINT "CASE 3.2"
            END SELECT
            ELSE: PRINT "ELSE block a > 3"
        END SELECT
    NEXT b
NEXT a
PAUSE 0
; ---------------------------------------------
; test float conversion
; ---------------------------------------------
REM float xpi
LET xpi=3.14159
CLS
INK 2
PRINT "PI="
OVER 1: INK 4
; ---------------------------------------------
; line draw demo (speed-test)
; ---------------------------------------------
LET i=1
WHILE i < 10
    PRINT i
    IF i >= 5 THEN exit
    LET i=i+1
WEND
LET i=0
GO SUB #setTime:
LET x=1:
LET y=21:
LET dx=1:
LET dy=1
LET i=0
WHILE i < 15000
    PLOT x,y
    LET x=x+dx:
    LET y=y+dy
    IF x<=1 OR x>=250 THEN LET dx=0-dx
    IF y<=20 OR y>=160 THEN LET dy=0-dy
    LET i=i+1:
WEND
; ---------------------------------------------
; Print time
; ---------------------------------------------
LET ticks=PEEK 23672+PEEK 23673*256:
LET tsec=INT (ticks/50):
LET min=INT (tsec/60):
LET sec=tsec-min*60
PRINT AT 21,0
PAUSE 0
RETURN
; ---------------------------------------------
; Subroutine: Reset time
; ---------------------------------------------
#setTime
POKE 23672,0: POKE 23673,0: POKE 23674,0: RETURN

procedure test(a,b)
   print "a=";a;" b=";b
return

STOP
9000 DATA 1,2,3
9998 STOP
9999 SAVE "lines.bas"


