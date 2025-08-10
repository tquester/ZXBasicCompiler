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







