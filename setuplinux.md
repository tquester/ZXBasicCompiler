# Setup on Linux
In order to run the IDE/Compiler on Linux you need to prepare some things

1. Install and compile sjasmplus (https://github.com/z00m128/sjasmplus)
   There is no binary for linux, you probably must install the build system.
   Please follow the instructions
3. Install Fuse GTK
4. or Install GTK libraries
5. download the IDE and dependencies
6. start with java -jar zxcompileride

You must setup the options

<img width="716" height="615" alt="image" src="https://github.com/user-attachments/assets/202d561c-ca98-41f8-9432-2e12f82ad34b" />

The output path is the path where you installed the ZX Compiler IDE, it must contain the file main.asm and the ZXLibrary path. This is the runtime library used by the compiled BASIC program.
The IDE will create a shell file and execute it: compileRun.sh. The file will delete the compiled tap file, then calls sjasmplus. The output is redirected into log.txt, then it calls fuse

cd "/home/thomas/workspaces/ZXBasicCompiler/Artikel2/Assembler"
rm "/home/thomas/workspaces/ZXBasicCompiler/Artikel2/Assembler/compiled.tap"
"/home/thomas/workspaces/sjasmplus-1.21.0/sjasmplus" "/home/thomas/workspaces/ZXBasicCompiler/Artikel2/Assembler/main.asm" 2> "/home/thomas/workspaces/ZXBasicCompiler/Artikel2/Assembler/log.txt"
"fuse" "/home/thomas/workspaces/ZXBasicCompiler/Artikel2/Assembler/compiled.tap"
