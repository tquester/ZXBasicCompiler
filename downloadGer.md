# Download und Starten

Momentan gibt es noch kein Setup und kein automatisches Anfügen der Libraries, daher sind einige Schritte nötig.

Laden Sie zunächst das gesamte Projekt herunter:
https://github.com/tquester/ZXBasicCompiler/archive/refs/heads/main.zip

Benötigt wird außerdem:
* Sjasmplus https://github.com/z00m128/sjasmplus
* Java Java Downloads | Oracle Deutschland
* ZX Spectrum Emulator, z.B. Spectaluator oder Fuse
  
Um den kompilierten Code zu sehen, zu editieren und zu testen:
* Visual Studio code Visual Studio Code - Code Editing. Redefined
* DeZog maziac/DeZog: Visual Studio Code Debugger for Z80/ZX Spectrum.
  
Um den Compiler selbst zu ändern ist eine Java-IDE ratsam, zum Beispiel

* Eclipse  https://www.eclipse.org/downloads/
* Netbeans Welcome to Apache NetBeans
* Intelij IntelliJ IDEA – die IDE für professionelle Java- und Kotlin-Entwicklung

# BASIC-Programm schreiben
Schreiben Sie nun mit ihrem ZX Spectrum Emulator ein BASIC-Programm und speichern es auf einem virtuellen Band (.tap) ab.

# Compiler starten
Der Compiler befindet sich Verzeichnis Artikel2\Assembler
Editieren Sie die Datei compile.bat

```
set assembler=E:/Emulator/z80/dev/sjasmplus-1.20.2.win/sjasmplus.exe
java -jar ..\..\zxcompiler.jar %1 %2 %3 %4 %5 %6 %7 -out compiledBasic.asm
%assembler% main.asm
```

In der ersten Zeile muss der Pfad zu sjasmplus eingetragen werden.

Starten Sie nun den Compiler mit 

```
 compile bandname.tap basicname -o -s
```

Es wird zunächst die Datei compiledBasic.asm erzeugt, danach wird der Assembler mit main.asm aufgerufen welcher dann das Band erzeugt, welcher direkt im Emulator geladen werden kann.

# Compileroptionen

| Option | Beschreibung |
|--------|--------------|
| -o | Optimierung. Der Optimierer entfernt einige Anweisungen und fasst andere zusammen |
| -o1 | Optimierung. Der ursprüngliche Code bleibt als Kommantar erhalten (für Compiler-Entwickler) |
| -s | Fügt eine Prüfung auf Break nach jeder Anweisung ein. Man kann das Programm wie in BASIC mit Shift Leertaste unterbrechen |
| -s1 | Wie -1 aber die Anweisung wird nur vor GOTO, RETURN, GOSUB und NEXT eingefügt. Kleiner und schneller aber man kann nicht an jeder Stelle unterbrechen |
| -l | Teilt dem ZX Spectrum bei jeder kompilierten Zeile mit, welche BASIC-Zeile es war. Wenn Sie ein Fehler bekommen, etwa weil außerhalb des Bildschirms gezeichnet wurde, sehen Sie die Zeilennummer und Statement-Nummer des Befehls |
| -out | Angabe der Ausgabedatei |
| -v | Zeigt während des Kompilierens den Assemblercode (für Compiler-Entwickler) |

# Start in DEZOG

Das Verzeichnis enthält alle nötigen Dateien um das Projekt mit DeZog und Visual Studio zu öffnen.
Normalerweise kann man das kompilierte Programm nicht in Dezog debuggen, weil der Debugger vor dem Booten des ZX Spectrum startet. Im Code befindet sich eine abgeänderte Startsquenz welche man aktivieren muss.
Öffnen Sie dazu main.asm und geben bei DEBUGBASIC eine 1 ein.
DEBUG schaltet ein paar weitere Funktionen dazu, z.B. PRINTFPSTACK um den Calculator-Stack auszugeben

```
DEBUG                       equ 1			; Enables debug mode. Used to test so new functions.
DEBUGBASIC                  equ 1			; Initializes the ZX Spectrum using a copy of the startup, then starts the compiled BASIC program.
											; Rom routines are allowed
```



