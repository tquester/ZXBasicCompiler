# Sokoban by simonsnake

https://github.com/tquester/ZXBasicCompiler/blob/main/games/sokoban/sokoban.gif

## Original 
https://itch.io/jam/zx-spectrum-basic-jam/rate/151300

## Download
https://github.com/tquester/ZXBasicCompiler/blob/main/games/sokoban/sokoban.tap

## Changes

For the compiled Version I made a few changes:
* added wait for KEY Release in line 160 and 431 otherwiese it was hard to control the movement as it was way too fast
  160 LET k$ = INKEY$ : IF K$ <> "" THEN GOTO 160
* added support for normal cursor keys: SHIFT-5, SHIFT-6, SHIFT-7 and SHIFT-8 because many Emulators and newer ZX Spectrums as well as add-on keyboards have separate cursor keys and we modern people are used to use them.
* added some speed improvements, for example adding ";" after PRINT at because printing the newline also costs cycles.
* The number of undo-moves have been reduced to 1000 so that the integrated BASIC debugger fits into memory

## Bugs
* Currently defining keys does not work in the compiled version

## Thanks
Thanks simonsnake for this nice game. It helped my finding lots of bugs in my compiler, especially in string processing


