package zxcompiler;

import zxcompiler.ZXTape.TapeEntry;
import zxcompiler.ZXTokenizer.ZXBasicLine;

public class Main {

	public static void main(String[] args) {
		ZXCompiler  compiler = new ZXCompiler();
		ZXBasicLine basicLine = new ZXBasicLine();
		ZXTokenizer tokenizer = new ZXTokenizer();
		ZXTape tape = new ZXTape();
		tape.load("E:\\Emulator\\zxdev\\zxspectrum_fastCircle\\test.tap");
		TapeEntry entry = tape.get("linefill");
		
		compiler.start(entry.data);
		compiler.compile();
		


	}

}
