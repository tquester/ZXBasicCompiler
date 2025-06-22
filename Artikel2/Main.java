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
			return;
		}
		
		int op=0;
		int i = 0;
		String outfile = "a.asm";
		String tapefile = "";
		String file = "";
		while (i < args.length) {
			String s = args[i++];
			if (s.startsWith("-")) {
				switch(s) {
				case "-out":
					outfile = args[i++];
					break;
				case "-v":
					compiler.mSettingVerbose = true;
					break;
				case "-no":
					compiler.mSettingOptimize = false;
					break;
				case "-l":
					compiler.mSettingList = true;
					break;
				case "-stop":
				case "-s":
					compiler.mSettingStop = true;
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
		


	}

	
}
