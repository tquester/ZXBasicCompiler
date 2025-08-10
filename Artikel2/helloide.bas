; Variablenzuweisungen ohne LET werden ergänzt
a=1
; Label
#LOOP
; Teste while 
a=1
WHILE a < 10
    IF a > 5 THEN EXIT
    PRINT "a=";a
    a=a+1
WEND
; Teste select case 
key=7
SELECT key
    CASE 1: controlFN = #keyboard: BREAK
    CASE 2: controlFN = #kempston: BREAK
    CASE 3: controlFN = #sinclair: BREAK
    DEFAULT: controlFN = #undef
END
#gameloop
PRINT "Funktionsaufruf: Key = ";key
GO SUB controlFN
; Teste Funktionsaufruf
PRINT "Funktionsaufruf: ",
CALL test2
CALL test(100,200)
PAUSE 0
RETURN
#keyboard
PRINT "game control with keyboard
RETURN
#kempston
PRINT "game control with kempston"
RETURN
#sinclair
PRINT "game control with sinclair"
RETURN
#undef
PRINT "game control undef"
RETURN
; Prozedur
PROC test(abc,def)
    PRINT "test PROC with abc=";abc;" def=";def
    PRINT "abc+def=";abc+def
END
PROC test2
    PRINT "Test2 PROC called"
END
label=#LOOP