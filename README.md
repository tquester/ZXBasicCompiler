Deutsch: [Hier klicken](https://github.com/tquester/ZXBasicCompiler/blob/main/ReadmeGer.md)
# ZXBasicCompiler
The goal is to write a compiler for ZX Basic with all differences that ZX Basic has in contrast to other BASIC dialects so that it is mostly compatible with existing BASIC programs and games.
Later the compiler will be extended with sprites and other functions from QBasic2. After the compiler got a GUI and its own editor, it may be extended with labels, procedures etc.
It is also planned to create several back ends, for example for ZX81.

This BASIC compiler loads the BASIC from a .TAP file, i.e. you use the ZX Spectrum Emulator for editing and testing.
The compiler then generates a text file which must be compiled with an assembler (sjasmplus). 
If the optimization is switched on, an easily readable assembler file is generated which can be edited further if required.
Since the compiler does not run on the ZX Spectrum, the entire usable memory can be used.

<img width="1327" height="783" alt="image" src="https://github.com/user-attachments/assets/2e7aff16-a027-4dd6-830d-86cdb42ef8b6" >
Slow Maniac Willy running under Dezog in Assembler. Thanks to Animated Alex (https://animatedal.itch.io/slow-manic-willy)




# Download

https://github.com/tquester/ZXBasicCompiler/blob/main/Download.md 

## Differences to ZX Basic
https://github.com/tquester/ZXBasicCompiler/blob/main/DifferencesGer.md

# Status

## 07/21/2025 Compiler compiles some games without error. More Tests are to come

  | Step | Status |
 |-----------------------|----------------|
 | First Basic compiler | OK
 | Strings | OK |
 | Floats | mostly working |
 | All BASIC commands running | In progress |
 | Tests for each command | In progress | 
 | QBasic commands running | In planning |
 | Documentation | In progress |

Stil Missing: 
* The program must end with STOP. I did not figure out, how to find the end of the BASIC in a TAP file so it compiles until STOP
* String compare is incomplete. The compiler handles dynamic strings and fixed length strings as separate types, so it needs 6*4 = 24 different compare operators
* Some fixed length operations are still missing (Input, USR, VAL, CODE,..) but are working with dynamic strings
* Currently the compiler gets tested with BASIC games from the internet. See https://itch.io/jam/zx-spectrum-basic-jam
* QBasic-Functions

Some games have been successfully compiled, but not all games profit, this one runs far too fast
![ufo_compiled](https://github.com/user-attachments/assets/6d7b285c-91c5-404d-9bd7-03460c353e53)

Thanks  Animated Alex for your games, it showed my lots of errors in my compiler and I discovered aspects of BASIC I did not know. Breathing pure Assembler
https://animatedal.itch.io/


Planned:
* BASIC Editor with labels and optional line numbers. It will create a BASIC program with line numbers which run in the BASIC interpreter
* 
  
<b>7.5.2025: An update will be made today</b>

Translated with DeepL.com (free version)
# Targets
- Almost full support of Sinclair ZX Basic. Existing programs should be compilable with few changes
- Calculations can be made in floats or integers. Integer is approx. 20-30 times faster than floats.
- Instructions for the compiler can be sent in REM commands, e.g. whether a variable is to be interpreted as a float or an integer.
- The output is a readable assembler file. It is easy to optimize a part of the BASIC program in assembler and then use this optimized part in the compilation instead of the compiled BASIC.
- Inclusion of optimized program parts via REM asm. e.g. REM asm include "code.asm" and REM asm call
- The original routine can be skipped. REM stop and REM continue a part of the code is excluded from compilation so that an assembler version can be used instead.
- Separate heap for string processing
- BASIC Debugger (https://github.com/tquester/ZXBasicCompiler/blob/main/debugger.md)

Later, the functions of the BASIC extension will be added and there will be a separate editor

# Demo Tapes
BASIC: https://github.com/tquester/ZXBasicCompiler/blob/main/Artikel2/compilerdemo.tap

Compiled: https://github.com/tquester/ZXBasicCompiler/blob/main/Artikel2/Assembler/compiled.tap

Compiled with Floating Point: https://github.com/tquester/ZXBasicCompiler/blob/main/Artikel2/Assembler/compiledFp.tap

Assembler code: https://github.com/tquester/ZXBasicCompiler/blob/main/Artikel2/Assembler/compiledBasic.asm

BASIC Source of Demo: https://github.com/tquester/ZXBasicCompiler/blob/main/Artikel2/Assembler/compiledBasic.bas

#Speed


# Speed

The plot demo uses only the PLOT command and uses variables to calculate the coordinates, assignment

Part of the speed comes from the fact that the lines no longer need to be interpreted. In BASIC, each program line must be broken down byte by byte in order to execute it. After a GOTO, the entire program is searched for the line number, and when accessing variables, the entire variable memory is searched for the variable. Although variables and lines have a length specification so that you can jump from variable to variable and line to line, this also takes a little computing time. After compilation, each line and each variable has a fixed address that does not change and is known without a search. BASIC also checks each line to see if the break key has been pressed; this can be simulated in the compiler with the -s or -s1 option. -s performs the check after each command, -s1 only before jumps and in for loops. Both take a little computing time and memory. Mathematical expressions also do not need to be broken down and converted into reverse Polish notation; this is done by the compiler.

Most of the speed comes from optimization with integer numbers, which are processed directly by the processor instead of via routines in the ZX Spectrum ROM. In addition, the compiler's optimizer can remove or rearrange many instructions from the code. This is only possible to a limited extent with floating point operations. Among other things, the calls for mathematical operations in the calculator (RST $28) are written directly into the code, after which contiguous blocks are combined into a larger block.

## Original in Basic:
![plot_basic](https://github.com/user-attachments/assets/345013ba-d3f8-418b-8e68-745ea46f87f1)

## Compiled with floating point option (the color changes are only visible in the GIF)
![plot_compiled_fp](https://github.com/user-attachments/assets/9f0514d7-b88c-4473-a784-3408b5c0c54f)

## Compiled with integer option  (The color changes are only visible in the GIF)
![plot_compiled_it](https://github.com/user-attachments/assets/6b9085e1-4c57-4f30-b053-36e6cbda1c50)


# Example
Since the compiler generates a text file (.asm), you still need to assemble it with an assembler, but this can be done automatically with a batch file, allowing you to transfer the code from one emulator to another as a compiled program with just a few clicks.

It is even possible to debug the compiled code directly in DeZog (Visual Studio Code + DeZog).

An example:

The line LET a2=b*b+c*c is implemented in assembler as follows; by default, variables are treated as integers```
```
ZX_LINE_50:
; 50  LET a2=b*b+c*c
	LD DE,(ZXBASIC_VAR_b)
	LD HL,(ZXBASIC_VAR_b)
	call runtimeMult16bit
	PUSH HL
	LD DE,(ZXBASIC_VAR_c)
	LD HL,(ZXBASIC_VAR_c)
	call runtimeMult16bit
	POP DE
	ADD HL,DE
	LD (ZXBASIC_VAR_a2),HL
```
If you want to use floats, you have to define them using REM.

```
ZX_LINE_60:
; 60  REM float af bf cf
ZX_LINE_65:
; 65  LET af=bf*bf+cf*cf
	LD HL,ZXBASIC_VAR_bf
	CALL runtimePushFloatVar
	LD HL,ZXBASIC_VAR_bf
	CALL runtimePushFloatVar
	RST $28
	DB $04	;MULT
	DB $38	;END CALC
	LD HL,ZXBASIC_VAR_cf
	CALL runtimePushFloatVar
	LD HL,ZXBASIC_VAR_cf
	CALL runtimePushFloatVar
	RST $28
	DB $04	;MULT
	DB $0f	;ADD
	DB $38	;END CALC
	LD HL,ZXBASIC_VAR_af
	CALL runtimeStoreFloat
```

Since the compiler outputs the source code, you can optimize it manually and call it later from BASIC:
```
  REM asm call myfunction
  REM stop
  LET a2=a*a+b*b
  REM continue
```
And in one place, preferably behind a return
```
  REM asm include "mycode.asm"
```

The optimized version is located in the file mycode.asm.
```
myfunction:
	LD DE,(ZXBASIC_VAR_b)
	LD HL,DE
	call runtimeMult16bit
	LD BC,HL
	LD DE,(ZXBASIC_VAR_c)
	LD HL,DE
	call runtimeMult16bit
	ADD HL,BC                       ; Optimization
	LD (ZXBASIC_VAR_a2),HL
	RET
```

This should make it possible to develop games that perform similarly to those written in assembler.

# ZXBasic Compiler
This compiler is an article for the Spectrum User Group.
The Artikel1 folder contains a rudimentary compiler, which is explained in the article.
The Artikel2 folder contains the version currently under development.

You can join the user group at
https://www.speccy-scene.de

(Übersetzt mit Deepl.Translator)


