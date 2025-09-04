# Rich Basic
The IDE allows using some extended commands in BASIC. The code will be re-compiled into ZX Spectrum compatible code

# Line numbers and labels
rich basic does not need line numbers, you can use labels
```
#loop
goto #loop
```
will be compiled into
```
1000 goto 1000
```

You can use # with GOTO, GOSUB, RESTORE and also to assign variables

```
 A=#loop
```
will be compiled into
```
1020 LET A=1000
```

# Assignment
```
A=1
```
will be modified to
```
LET A=1
```
# While, wend, exit

```
a=1
while a < 10 
   if a > 5 then exit
   a=a+1
wend
```

will be compiled to 
```
1000 LET a=1
1010 IF NOT(a < 10 ) THEN GOTO 1050
1020 if a > 5 then GOTO 1050
1030 LET a=a+1
1040 GOTO 1010
1050 
```

# Do .. loop
Do loop creates an endless loop, there is no condition but you can exit the loop with the exit command

```
rem DO LOOP
a=1
do
   print a
   a=a+1
   if a > 10 then exit
loop
```
will be compiled to

```
1060 rem DO LOOP
1070 LET a=1
1080 print a
1090 LET a=a+1
1100 if a > 10 then GOTO 1120
1110 GOTO 1080
```

# Repeat .. until
This loop has the check at the end

```
REM Repeat until
a=1
REPEAT
    PRINT a
    a = a + 1
UNTIL a = 5
```

will be compiled to

```
1000 REM Repeat until
1010 LET a=1
1020 PRINT a
1030 LET a = a + 1
1040 IF a = 5 THEN GOTO 1060
1050 GOTO 1020
```

# Select, case, end
Let key be the choice the user made to start the game. Later we move our player with
```
gosub controlfn
```
Which handles moving our sprite, shooting and so on.


```
select key
   case 1: controlFn = #keyboard: break
   case 2: controlFN = #kempston: break
   case 3: controlFN = #sinclair: break
end
```
will be compiled into
```
1060 IF key <> 1 THEN GOTO 1080
1070 LET controlFn = 1130: GOTO 1120
1080 IF key <> 2 THEN GOTO 1100
1090 LET controlFN = 1150: GOTO 1120
1100 IF key <> 3 THEN GOTO 1120
1110 LET controlFN = 1170: GOTO 1120
```

Like in C or Java, you should end the case with break. However it will not execute the next case, but iterate through all cases until the default, the default will be executed.

# Procedures: proc and call

You can create a procedure with the proc keyword. Also you can pass parameters.
* Procedures are easy to read
* You can pass parameters to procedures
* The compiler is able to find procedures which are never called and is able to remove them
* Procedures can be in a differnt file and included to your program or game.




```
proc test(abc,def)
   print abc+def
end
```
Due to restrictions, it is not possible to use local variables and it is impossible to use recursion (because of there are no local variables)

The procedure will be compiled to
```
1220 print test_0+test_2
1230 return
```

The variables used as parameters are replaces with the name of the procedure followed by a number.

You call the procedure with
```
call test(100,200)
```

This will be compiled into
```
1200 LET test_0=100:LET test_1=200:GO SUB 1220
```

# VAR

In most languages, procedures have local variables. In Sinclair BASIC we can not simulate local variables, however it is bad if a procedure modifies a variable which is used at any other part of the program.
At least for number variables that are not used in FOR..NEXT, we can simulate this by name mangeling. However this will not work in recursive calls.

In order to use procedures and functions with real local variables, the compatiblity with Sinclair BASIC must be turned off.

```
PROC readUDG(count, label)
    VAR adr, byte, ende
    RESTORE label
    LET adr=USR "A"
    LET ende=adr+count*8
    WHILE adr<ende
        READ byte
        POKE adr,byte
        adr = adr+1
    WEND
END
```

Will be compiled into

```
1300 restore PROCreadudg1
1310 let PROCreadudgadr=usr "A"
1320 let PROCreadudgende=PROCreadudgadr+PROCreadudg0*8
1330 IF NOT(PROCreadudgadr<PROCreadudgende) THEN GOTO 1380
1340 read PROCreadudgbyte
1350 poke PROCreadudgadr,PROCreadudgbyte
1360 LET PROCreadudgadr = PROCreadudgadr+1
1370 GOTO 1330
1380 return
```

The call to the procedure 
```
CALL readUDG(8, #MINER)
```
will be compiled into 

```
1160 LET PROCreadudg0=8:LET PROCreadudg1= 1420:GO SUB 1300
```

# Preprocessor

## #define

This defines constants and flags. A constant consists of more than one word

```
#define blau 1
#define rot 2

print "Blau=";blau;" rot=";rot
```

will be compiled into 

```
1000 print "Blau=";1;" rot=";2
```

## #if ... #endif

If flag is defined, the code between #if and #endif will be compiled, otherwise it is skipped.
The IDE defines three constants
ZXSPECTRUM Always true (later there will be other systems)
BASIC True if we build for the Emulator
COMPILER True if we build with the compiler

You can define your own flags

```
#define Kempston

#if Kempston
  REM code for Kempston
#endif
```

## #include 

Allows you to read a different BASIC program into your main program. Also the include may include other files etc.

Because the pre-compiler is able to remove unused procedures, you can build libraries which can be included into various programs without including unused code.












