# Slow Manic Willy
by Animated Alex

Game | Assembler
-----|-----
![slowwilly](https://github.com/user-attachments/assets/535b40b7-1255-4903-9c47-6b1ebb2f7f78) | <img width="328" height="348" alt="image" src="https://github.com/user-attachments/assets/e89a5ddd-ab9f-48f7-b833-3622fdb8a25c" />


## Original
https://animatedal.itch.io/slow-manic-willy

## Changes
* The STOP statement has been added in line 9998 followed by the save statement
* Since the compiled version runs about 10-20 times faster some pause needed to be added
* The first PAUSE is in line 100 the main game loop
* A second pause has been added in line 205.  In line 205, Willy is drawn with his legs open. Without the pause, it would be immediately overwritten and it would look as if he were teleporting.

## Compiling
361 fine BASIC lines have been compiled into 4483 lines of assembler

Slow Manic Will compiles in integer mode without any compiler instructions

## Download
Placed with kind permission below.
https://github.com/tquester/ZXBasicCompiler/blob/main/games/slowwilly/slowwilly.tap

The original BASIC-Version can be found on the itch-page (see Original)




