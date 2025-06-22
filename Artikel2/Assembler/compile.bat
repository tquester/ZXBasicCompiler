set assembler=E:/Emulator/z80/dev/sjasmplus-1.20.2.win/sjasmplus.exe
set emulator="C:\Program Files (x86)\Spectaculator\Spectaculator.exe"
java -jar ..\..\zxcompiler.jar %1 %2 %3 %4 %5 %6 %7
%assembler% main.asm

