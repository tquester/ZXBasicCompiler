10 REM Number Guessing Game
15 rem float A G N
20 PRINT "================================"
30 PRINT "    WELCOME TO GUESS THE NUMBER"
40 PRINT "================================"
50 PRINT
60 PRINT "I'm thinking of a number between 1 and 100"
70 PRINT "Can you guess what it is?"
80 PRINT
90 REM Generate random number between 1 and 100
95 randomize
100 LET N = INT(RND * 100.0) + 1.0
105 print N
110 LET G = 0
120 LET A = 0
130 REM Main game loop
140 PRINT "Enter your guess (1-100): ";
150 INPUT G
160 LET A = A + 1
170 REM Check the guess
180 IF G = N THEN GOTO 260
190 IF G < N THEN PRINT "Too low! Try again."
200 IF G > N THEN PRINT "Too high! Try again."
210 PRINT
220 IF A >= 10 THEN GOTO 300
230 GOTO 140
240 REM Player won
250 PRINT
260 PRINT "Congratulations! You got it!"
270 PRINT "The number was "; N
280 PRINT "It took you "; A; " guesses."
290 GOTO 320
300 REM Player used all attempts
310 PRINT "Sorry! You've used all 10 guesses. The number was "; N
320 PRINT
330 PRINT "Thanks for playing!"
340 PRINT "Press any key to xit..."
350 INPUT X$
360 return
