package main;

public class CSettings {
	static CSettings mInstance = new CSettings();
	public static CSettings instance() {
		return mInstance;
	}
	
	public String mAssembler="E:/Emulator/z80/dev/sjasmplus-1.20.2.win/sjasmplus.exe";
	public String mAsmOutput="C:\\workspaces\\github\\ZXBasicCompiler\\Artikel2\\Assembler\\compiledBasic.asm";
	public String mTapFile="C:\\workspaces\\github\\ZXBasicCompiler\\Artikel2\\Assembler\\compiled.tap";
	public String mMainAsm="C:\\workspaces\\github\\ZXBasicCompiler\\Artikel2\\Assembler\\main.asm";
	public String mEmulator="C:\\Program Files (x86)\\Spectaculator\\Spectaculator.exe";
	public String mCompilerOptions="-s1 -o -l";
	
	public CSettings() {
		String text = Tools.loadTextFile("settings.ini");
		if (text == null) return;
		String lines[] = text.split("\n");
		for (String line: lines) {
			int p = line.indexOf('=');
			if (p == -1) continue;
			String key = line.substring(0,p).trim().toLowerCase();
			String val = line.substring(p+1).trim();
			switch(key) {
			case "assembler": mAssembler = val; break;
			case "asmoutput": mAsmOutput = val; break;
			case "asmmain": mMainAsm = val; break;
			case "tapfile": mTapFile = val; break;
			case "emulator": mEmulator = val; break;
			case "options": mCompilerOptions=val; break;
			}
		}
	}
	
	public void save() {
		StringBuilder sb = new StringBuilder();
		sb.append(String.format("assembler=%s\n",mAssembler));
		sb.append(String.format("asmoutput=%s\n",mAsmOutput));
		sb.append(String.format("asmmain=%s\n",mMainAsm));
		sb.append(String.format("tapfile=%s\n",mTapFile));
		sb.append(String.format("emulator=%s\n",mEmulator));
		sb.append(String.format("options=%s\n",mCompilerOptions));
		Tools.writeTextFile("settings.ini", sb.toString());
	}
	
	

}
