cd "C:\workspaces\ZXCompiler\zxcompilergui"
del "C:\workspaces\ZXCompiler\zxcompilergui\compiled.tap"
"C:\workspaces\ZXCompiler\zxcompilergui\tools\sjasmplus\sjasmplus-1.21.0.win\sjasmplus.exe" "C:\workspaces\ZXCompiler\zxcompilergui\compiledBasic.asm" 2> C:\workspaces\ZXCompiler\zxcompilergui\log.txt
start "C:\Program Files (x86)\Spectaculator\Spectaculator.exe" "C:\workspaces\ZXCompiler\zxcompilergui\compiled.tap"
pause
