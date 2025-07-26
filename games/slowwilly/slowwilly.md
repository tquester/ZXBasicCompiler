# Slow Manic Willy
by Animated Alex

Game | Assembler
-----|-----
![slowwilly](https://github.com/user-attachments/assets/535b40b7-1255-4903-9c47-6b1ebb2f7f78) | <img width="328" height="348" alt="image" src="https://github.com/user-attachments/assets/e89a5ddd-ab9f-48f7-b833-3622fdb8a25c" />


## Original
https://animatedal.itch.io/slow-manic-willy

## Making of
https://www.youtube.com/watch?v=JDasUpPmeX4


## Changes
* The STOP statement has been added in line 9998 followed by the save statement
* Since the compiled version runs about 10-20 times faster some pause needed to be added
* The first PAUSE is in line 100 the main game loop
* A second pause has been added in line 205.  In line 205, Willy is drawn with his legs open. Without the pause, it would be immediately overwritten and it would look as if he were teleporting.
* Changed line 2000 to 2000  BEEP 0.05,p, so that the first argument is treated as float. 

## Compiling
361 fine BASIC lines have been compiled into 4483 lines of assembler

Slow Manic Willy compiles in integer mode without any compiler instructions. Floating point is used for RND which is multiplied by a factor and stored as an integer. This may cause an overflow if the random number is nearly one and should be modified to INK INT(RND*6)+1 
```
; 		1000.3  INK  INT ( RND *7)+1
	CALL runtimeRND
	LD HL,7
	CALL runtimeIntToFloat
	RST $28
	DB $04	;MULT
	DB $38	;END CALC
	CALL runtimeFloatToInt
	INC HL
	CALL runtimeInk
```

## Download
Thanks for permission to puiblish the compiled version

https://github.com/tquester/ZXBasicCompiler/blob/main/games/slowwilly/slowwilly.tap

The original BASIC-Version can be found on the itch-page (see Original)




