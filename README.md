# ZXBasicCompiler

Diese BASIC-Compiler lädt das BASIC aus einer .TAP-Datei, d.h. man benutzt den ZX Spectrum Emulator zum Editieren und Testen.
Der Compiler erzeugt daraufhin eine Textdatei welche mit einem Assembler kompiliert werden muss (sjasmplus). 
Wenn die Optimierung eingeschaltet ist, wird eine gut lesbare Assemblerdatei erzeugt welche bei Bedarf weiter bearbeitet werden kann.

# Demo Tapes
BASIC: https://github.com/tquester/ZXBasicCompiler/blob/main/Artikel2/compilerdemo.tap
Kompiliert: https://github.com/tquester/ZXBasicCompiler/blob/main/Artikel2/Assembler/compiled.tap
Assembler-code: https://github.com/tquester/ZXBasicCompiler/blob/main/Artikel2/Assembler/compiledBasic.asm

# ZXBasic Compiler
Dieser Compiler ist ein Artikel für die Spectrum User Group.
Im Ordner Artikel1 befindet sich ein rudimentärer Compiler welcher im Artikel erläutert wird.
Im Ordner Artikel2 befindet sich die aktuell in Entwicklung befindliche Version.

Sie können der Benutzergruppe beitreten unter
https://www.speccy-scene.de 

Wenn wir ein ZX Spectrum BASIC Programm mit 16bit Integers anstelle von Floats kompilieren, sieht der Geschwindigkeitszuwachs wie folgt aus
Der linke Bildschirm ist interpretiertes BASIC, der rechte Bildschirm das gleiche Programm, kompiliert mit unserem Compiler

![Speed compare](https://github.com/tquester/ZXBasicCompiler/blob/main/Artikel1/BasicVSAssembler.gif)

Das gleiche Programm kompiliert mit genialen MCoder III verwendet Gleitkommazahlen und ist deswegen langsamer. Integer werden direkt von der CPU ausgeführt und belegen 2 Bytes, während Gleitkommazahlen mit vielen Zeilen Code berechnet werden und 5 Bytes pro Zahl benötigen. Ziel des neuen Compilers muss es daher sein, dass man als BASIC-Programmierer entscheidet, welche Variablen Gleitkommazahlen sind und welche Integer. Was aber im Gegenzug vom BASIC-Programmierer etwas mehr Arbeit verlangt.

![BasicVSMCoder](https://github.com/user-attachments/assets/86a15789-e422-47ab-92c5-e5490e5a9bfb)
