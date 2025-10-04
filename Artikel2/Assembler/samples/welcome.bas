; welcome to ZXBasic IDE and Compiler
; comments can be made by a semicolon at the line start
; or with // like in Java. The // comment can be part of a BASIC line
; of course you still can use REM for comments
; you can write your programm like you used in ZX Spectrum with line numbers
; however it is not nessary
; you can simple use a label 
; 
; For the compiler, REM acts like a compiler option
; the following line defines i as integer and f and g as floating point
; You can define constants
#define BLUE 1
#define RED 2
#define WHITE 7
; constants are not case sensitve
PAPER BLUE
INK white
CLS
; Control codes can be used with \number or with \name. For example the first USD is \144
; Any numbers must have three digits
Print "The IDE allows to create control codes like Paper and INK by"
print "using the backslash"
print "you can even use AT and TAB or add UDG characters by its code"
print 
print 
PRINT "\INK\002This is red\INK\007 and \INK\004this green\ink\007"
CALL anykey


REM int16 i
REM float f g
; you do not need to use line numbers, they will be created automatically.
; after running the program, you can see the converted BASIC program in the tab emulator.bas
; labels start with #
CLS:
print "Line numbers are not needed"
print "use labels instead:"
print
print "\ink\006FOR i = 1 TO 10"
print "\ink\006    IF i = 5 THEN GOTO #forexit"
print "\ink\006    PRINT i"
print "\ink\006NEXT i"
print "\ink\006#forexit"
print "\ink\006PRINT ";chr$(34);"#forexit=;";chr$(34);"#forexit"
print "-----------------"
FOR i = 1 TO 10
    IF i = 5 THEN GOTO #forexit
    PRINT i
NEXT i
#forexit
; If you run this program by clicking on emulator or compiler, line numbers are genereated and all #labels will
; be replaced by a line number
; even if you use it as a variable
print "#forexit=";#forexit
PRINT "Press any key";
PAUSE 0
CLS
; you can even use it in goto for example goto #label+choice*10
; also in restore and gosub
; Instead of GOTO you can use do loop, repeat until or while wend
REM ------------- Drawing WITH REPEAT AND WHILE   ------
REM ----------------------------------------------------
PRINT "Drawing WITH REPEAT AND WHILE"
x = 10: y = 10
WHILE x < 200
    REPEAT
        PLOT x,y: DRAW 5,0: DRAW 0,5: DRAW -5,0: DRAW 0,-5
        y = y + 10
    UNTIL y > 100
    y = 10
    x = x + 10
WEND
REM ----------------------------------------------------
PRINT "Press any key"
PAUSE 0
CLS
PRINT "The CODE used FOR the drawing is:"
PRINT
ink 6
PRINT "x = 10: y = 10"
PRINT "WHILE x < 200"
PRINT "   REPEAT "
PRINT "      PLOT x,y: DRAW 5,0: DRAW 0,5: DRAW -5,0: DRAW 0,-5"
PRINT "      y = y + 10
PRINT "    UNTIL y > 100"
PRINT "    y = 10"
PRINT "    x = x + 10"
PRINT "WEND"
call anykey
CLS
PRINT "The CODE gets converted TO ":
PRINT
ink 6
PRINT "1130 LET x = 10"
PRINT "1140 LET y = 10"
PRINT "1150 IF NOT(x < 200) THEN GOTO 1230"
PRINT "1160 PLOT x,y: DRAW 5,0: DRAW 0,5: DRAW -5,0: DRAW 0,-5"
PRINT "1170 LET y = y + 10"
PRINT "1180 IF y > 100 THEN GOTO 1200"
PRINT "1190 GOTO 1160"
PRINT "1200 LET y = 10"
PRINT "1210 LET x = x + 10"
PRINT "1220 GOTO 1150"
call anykey


; instead of many if then, you can use select
; you may want to look up the genered code in the emulator.tab tabulator
; case is not faster but it is easier to read. However the compiled BASIC code
; is hard to read
REM ----------------------------------------------------
print "You can use SELECT instead of IF"
ink 6
PRINT "SELECT a"
PRINT " CASE 49:PRINT ";chr$(34);"1 pressed";chr$(34);":BREAK"
PRINT " CASE 50:PRINT ";chr$(34);"2 pressed";chr$(34);":BREAK"
PRINT " CASE 51:PRINT ";chr$(34);"3 pressed";chr$(34);":BREAK"
PRINT " CASE 52:PRINT ";chr$(34);"4 pressed";chr$(34);":BREAK"
PRINT " CASE 120:PRINT ";chr$(34);"you pressed x";chr$(3);":BREAK"
PRINT "  DEFAULT:"
PRINT "  PRINT ";chr$(34);"you pressed something ELSE";chr$(34)
PRINT "END"
call anykey
print "This will be converted into"
ink 6
PRINT "1810 IF a <> 49 THEN GOTO 1830"
PRINT "1820 PRINT ";chr$(34);"1 pressed";chr$(34);": GOTO 1960"
PRINT "1830 IF a <> 50 THEN GOTO 1850"
PRINT "1840 PRINT ";chr$(34);"2 pressed";chr$(34);": GOTO 1960"
PRINT "1850 IF a <> 51 THEN GOTO 1870"
PRINT "1860 PRINT ";chr$(34);"3 pressed";chr$(34);": GOTO 1960"
PRINT "1870 IF a <> 52 THEN GOTO 1890"
PRINT "1880 PRINT ";chr$(34);"4 pressed";chr$(34);": GOTO 1960"
PRINT "1890 IF a <> 53 THEN GOTO 1910"
print
ink 7
print "though it is not faster but"
print "easier to read"
print 

print "Lets try it"
call anykey



PRINT "Press any number between 1 AND 6, x TO EXIT"
DO
    DO
        a = CODE inkey$
        IF a <> 0 THEN EXIT
    LOOP
    WHILE CODE inkey$ <> 0
    WEND
    SELECT a
        CASE 49: PRINT "1 pressed": BREAK
        CASE 50: PRINT "2 pressed": BREAK
        CASE 51: PRINT "3 pressed": BREAK
        CASE 52: PRINT "4 pressed": BREAK
        CASE 53: PRINT "5 pressed": BREAK
        CASE 54: PRINT "6 pressed": BREAK
        CASE 120: PRINT "you pressed x": BREAK
            DEFAULT:
            PRINT "you pressed something ELSE"
    END
    IF a = CODE "x" THEN EXIT
LOOP
call anykey
REM ----------------------------------------------------
print "instead of GOSUB you can"
print "define subs with parameters"
print 
ink 6
PRINT "SUB box(x,y,w)"
PRINT "    PLOT x,y:"
PRINT "    DRAW 0,w: DRAW w,0: DRAW 0,-w: DRAW -w,0"
PRINT "END"
ink 7
print 
print "and call it with"
ink 6
print "call box(x,y,10)"
print
ink 7
print "lets try it"
call anykey
print "call will be translated to GOSUB"
ink 6
print "FOR x = 1 TO 100 STEP 10"
print "FOR y = 50 TO 100 STEP 10"
print "LET PROCbox0=x:LET PROCbox1=y:LET PROCbox2=9:GO SUB 2590"
print "NEXT y:NEXT x"
ink 7
; Instead of gosub you can define procedures
; use sub or procedure to start a procedure and use call to call it
; you can call procedures with parameters. This will automatically assign some variables and create the gosub
; for speed in BASIC, we want long lines, but they are hard to read.
; You can end a line with a colon (:) to make long lines
; however do, loop, while, wend, repeat, until, select, case, default, when and end need a line for themself.
FOR x = 1 TO 100 STEP 10:
    FOR y = 50 TO 100 STEP 10:
        CALL box(x,y,9):
    NEXT y:
NEXT x:
call anykey:
print "Though a call is slower than using"
print "GOSUB with global variables"
print "it is easier and the compiler"
print "will automatically remove all"
print "unused subs"
print 
PRINT "Calling a PROCEDURE WITH local  variables:":
CALL test(5)
call anykey
print "You can us multi line IF with"
print "ELSE"
print 
ink 6
print "FOR i = 1 TO 4"
print "    WHEN i=3"
print "        PRINT i"
print "    ELSE"
print "        PRINT ";chr$(34);"i is NOT 3"
print "    END"
print "NEXT i"
ink 7
print "The compiler will also trans-":print "late it with GOTO"
print 
; you can use multi line IF with else but it is called when
print "Lets try it"
FOR i = 1 TO 4
    WHEN i=3
        PRINT "i ist 3"
        ELSE
        PRINT "i is NOT 3, it is ";i
    END
NEXT i
call anykey
GOTO #ende
; the variables are copied to PROCbox0 etc. 
; Though this is not faster then directly using gosub and common variables but it is easier to read
SUB box(x,y,w)
    PLOT x,y:
    DRAW 0,w: DRAW w,0: DRAW 0,-w: DRAW -w,0
END
; Local variables will be renamed. i becomes PROCtesti
; remember that ZX Basic treats one  digit variables differntly than multi-letter variables.
; for maximum speed use single letter variables.
; Also this techique hides local variables from the main program, you can not use recursion.
SUB test(count)
    VAR i
    i=1
    REPEAT
        PRINT "i=";i
        i = i + 1
    UNTIL i > count
END
; The best thing about procedures is, that the compile can find out which one is used and which one is not used.
; This also happens if one procedure calls another one which calls another one and you call the top level
; in this case the compiler will copy all procedures that are needed but not a single procedure more
; You can write common procedures and place them in a separate file
SUB test2
    PRINT "This PROCEDURE is NOT called. "
    PRINT "this means, that it is NOT part of your BASIC program"
END
SUB anykey
    ink 7
    PRINT at 21,0;"Press any key";
    PAUSE 0
    cls
END
#ende
cls
print "If the program ends in the compiler. ZX Spectrum will reset or halt"
pause 0
STOP
