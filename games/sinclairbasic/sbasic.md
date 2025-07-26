# Sinclair BASIC by Animated Alex

This was Animated Alex first game. It uses fixed length Strings for the animation and gave me a lot of headache while testing and debugging the string functions.
I decided not to used the BASIC variables from the ROM nor the string functions but to write it myself. Also I handle fixes length strings (strings which have been declared with DIM) differently from common strings, so that it needs lots of different functions, assign fixed string to normal string, assign normal string to fixed string, assign normal to fixed sub string and so on. 

# Original
https://animatedal.itch.io/sinclair-basic

# Changes
I added a REM pause 9 in line 101
In contrast to PAUSE 9, this command will be ignored by the interpreter, so the game keeps playable in the interpreter.
Also the REM pause command does not wait for a keystroke. The pause is always the same time interval regardless if a string is pressed

# Download
The compiled version is a bit more responsive but more difficult to play. I wonder if Alex gets through the first level.

https://github.com/tquester/ZXBasicCompiler/blob/main/games/sinclairbasic/sinclairbasic.tap


