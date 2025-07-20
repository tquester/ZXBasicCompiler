# Debugger

<img width="352" height="370" alt="image" src="https://github.com/user-attachments/assets/e0c66056-b00c-446b-b592-339f63e429e7" />

The compiler has a built-in debugger. The program must be compiled with the -d option so that the compiler includes a call to the debugger and a symbol table for the variables with each command. In Main.asm, EQU Debug must be set to 1 so that the debugger is integrated into the code.
When the program starts, the debugger is now visible in the upper third of the screen. Pressing R starts the program. Pressing Break (Shift Space) returns you to the debugger. Pressing B allows you to set a breakpoint on a BASIC line. Pressing W allows you to specify variables that you want to view. The variables are separated by spaces. (This is not yet possible for arrays.) Pressing any other key executes the next BASIC command.
The debugger does not display the BASIC command, only the line number, but the BASIC program is generated as a .bas file during compilation if you specify it with -out. Here you can orient yourself and see which variables are used.
The debugger requires quite a lot of memory (approx. 5KB) because it has its own output functions and the library still contains some unnecessary items. In addition, the symbol table for the variables takes up a little memory space.

```
1000  GOSUB 3700:
     LET x=1:
     LET y=21:
     LET dx=1:
     LET dy=1
1005  FOR i=1 TO 5000
1010  PLOT  OVER 1; INK 3;x,y
1020  LET x=x+dx
1030  LET y=y+dy
1040  IF x <= 1 OR x >= 250 THEN  LET dx=0-dx
1050  IF y <= 20 OR y >= 160 THEN  LET dy=0-dy
1060  NEXT i
1070  GOTO 3710
1100  GOSUB 3700
1120  FOR i=0 TO 255 STEP 3
1130  PLOT  INK 1;i,0
1140  DRAW  INK 1;255-i,170
1150  NEXT i
1155  RETURN 
```
