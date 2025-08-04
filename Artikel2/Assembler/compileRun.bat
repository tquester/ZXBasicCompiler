cd "C:\workspaces\github\ZXBasicCompiler\Artikel2\Assembler"
del "C:\workspaces\github\ZXBasicCompiler\Artikel2\Assembler\compiled.tap"
"E:/Emulator/z80/dev/sjasmplus-1.20.2.win/sjasmplus.exe" "C:\workspaces\github\ZXBasicCompiler\Artikel2\Assembler\main.asm"
start "C:\Program Files (x86)\Spectaculator\Spectaculator.exe" "C:\workspaces\github\ZXBasicCompiler\Artikel2\Assembler\compiled.tap"
pause
