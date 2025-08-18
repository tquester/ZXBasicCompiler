package zxcompiler;

import zxcompiler.ZXTape.TapeEntry;
import zxcompiler.ZXTokenizer.ZXBasicLine;

public class Main {

	public static void main(String[] args) {
		ZXCompiler  compiler = new ZXCompiler();
		ZXBasicLine basicLine = new ZXBasicLine();
		ZXTokenizer tokenizer = new ZXTokenizer();
		if (args.length < 2) {
			System.out.println("ZXCompiler tape file");
			System.out.println("Liest das Tape (.tap) ein und lädt die letzte Version der Datei im Tape");
			System.out.println("Wenn -out nicht angegeben wird, wird die Datei a.asm erzeugt, ansonsten die angegebene Datei");
			System.out.println("-o Optimierung, -o1 Optimierung (original sichtbar)");
			System.out.println("-s Stop. Programm kann mit Shift-Space unterbrochen werden)");
			System.out.println("-s1 Stop. Befehl wird nur bei FOR, NEXT, GOTO, GOSUB, RETURN eingefügt (schneller)");
			System.out.println("-f Floatingpoint. Alle Variablen werden per default als Gleitkomma definiert");
			System.out.println("-l Fügt Zeilennummern ein, Wenn ein Fehler auftritt zeigt der BASIC-Editor die Zeilennummer im Quellcode an");
			
			return;
		}
		
		int op=0;
		int i = 0;
		String outfile = "a.asm";
		String tapefile = "";
		String file = "";
		String basicFile = null;
		while (i < args.length) {
			String s = args[i++];
			if (s.startsWith("-")) {
				switch(s) {
				case "-out":
					String fname = args[i++];
					if (fname.toLowerCase().endsWith(".asm"))
						outfile = fname;
					if (fname.toLowerCase().endsWith(".bas"))
						basicFile = fname;
					break;
				case "-v":
					compiler.mSettingVerbose = true;
					break;
				case "-d":
					compiler.mSettingCompileDebug = true;
					break;
				case "-no":
					compiler.mSettingOptimize = 0;
					break;
				case "-o":
					compiler.mSettingOptimize = 1;
					break;
				case "-o1":
					compiler.mSettingOptimize = 2;
					break;
				case "-osz":
					compiler.mSettingsShortCircuit = true;
					break;
				case "-bl":
					compiler.mSettingLineNr = true;
					break;
				case "-l":
					compiler.mSettingLineNr = true;
					break;
				case "-f":
					compiler.mDefaultType = VARTYP.TYPE_FLOAT;
					break;
				case "-stop":
				case "-s":
					compiler.mSettingStop = 1;
					break;
				case "-s1":
					compiler.mSettingStop = 2;
					break;
				}
				continue;
			}
			switch(op) {
			case 0: tapefile = s;
			op++;
			break;
			case 1: file = s;
			op++;
			break;
			}
			
		}
		
		
		ZXTape tape = new ZXTape();
		tape.load(tapefile);
		TapeEntry entry = tape.get(file);
		
		compiler.start(entry.data);
		compiler.compile();
		compiler.writeCode(outfile);
		if (basicFile != null) compiler.writeBasicFile(basicFile);
			
		


	}

	
}
