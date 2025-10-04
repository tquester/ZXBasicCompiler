package main;

import java.io.File;
import java.nio.file.Path;

import javax.swing.filechooser.FileSystemView;

import org.apache.commons.lang3.SystemUtils;
import org.eclipse.swt.SWT;
import org.eclipse.swt.widgets.FileDialog;
import org.eclipse.swt.widgets.MessageBox;
import org.eclipse.swt.widgets.Shell;

public class CSettings {
	static CSettings mInstance = null;

	public static CSettings instance() {
		if (mInstance == null)
			mInstance = new CSettings();
		return mInstance;
	}

	public String mAssembler = "c:/sjasmplus-1.20.2.win/sjasmplus.exe";
	public String mAsmOutput = null;
	public String mTapFile = null;
	public String mMainAsm = null;
	public String mEmulator = null;//"C:\\Program Files (x86)\\Spectaculator\\Spectaculator.exe";
	public String mCompilerOptions = "-s1 -o -l";

	public CSettings() {
		try {
			String path = getDocumentsPath() + File.separator + "ZXCompiler"
					+ File.separator;
			mAsmOutput = path + "compiledBasic.asm";
			mTapFile = path + "compiled.tap";
			mMainAsm = path + "main.asm";
			mAsmOutput = path + "compiledBasic.asm";

			String fname = appData("settings.ini");
			String text = Tools.loadTextFile(fname);
			if (text != null) {
				String lines[] = text.split("\n");
				for (String line : lines) {
					int p = line.indexOf('=');
					if (p == -1)
						continue;
					String key = line.substring(0, p).trim().toLowerCase();
					String val = line.substring(p + 1).trim();
					switch (key) {
					case "assembler":
						mAssembler = val;
						break;
					case "asmoutput":
						mAsmOutput = val;
						break;
					case "asmmain":
						mMainAsm = val;
						break;
					case "tapfile":
						mTapFile = val;
						break;
					case "emulator":
						mEmulator = val;
						break;
					case "options":
						mCompilerOptions = val;
						break;
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println(String.format("AsmOutput=%s", mAsmOutput));
		System.out.println(String.format("mTapFile=%s", mTapFile));
		System.out.println(String.format("mMainAsm=%s", mMainAsm));
		System.out.println(String.format("mEmulator=%s", mEmulator));
		System.out.println(String.format("mAssembler=%s", mAssembler));
	}

	public static String getDocumentsPath() {
		if (SystemUtils.IS_OS_WINDOWS) {
			// FileSystemView ist die zuverlässigste Methode für Windows
			return FileSystemView.getFileSystemView().getDefaultDirectory().getAbsolutePath();
		} else {
			// Für macOS und Linux
			return System.getProperty("user.home") + File.separator + "Documents";
		}
	}

	static public String appData(String fname) {

		String appDataPath = getDocumentsPath() + File.separator + "ZXCompiler";
				
		File p = new File(appDataPath);
		p.mkdirs();
		appDataPath += File.separator + fname;

		return appDataPath;
	}

	public void save() {
		String fname = appData("settings.ini");
		StringBuilder sb = new StringBuilder();
		sb.append(String.format("assembler=%s\n", mAssembler));
		sb.append(String.format("asmoutput=%s\n", mAsmOutput));
		sb.append(String.format("asmmain=%s\n", mMainAsm));
		sb.append(String.format("tapfile=%s\n", mTapFile));
		sb.append(String.format("emulator=%s\n", mEmulator));
		sb.append(String.format("options=%s\n", mCompilerOptions));
		Tools.writeTextFile(fname, sb.toString());
	}

	public void assertEmulator(Shell shell) {
		if (mEmulator != null) {
			File f = new File(mEmulator);
				if (f.exists())
					return;
		}
		MessageBox messageBox = new MessageBox(shell, SWT.ICON_QUESTION | SWT.OK);
		messageBox.setMessage("Please select your ZX Spectum emulator");
		int response = messageBox.open();
		String[] filterExt = { "*.exe", "*.bat"};
		FileDialog fd = new FileDialog(shell, SWT.OPEN);
		fd.setText("Open Image");
		fd.setFilterExtensions(filterExt);
		String filename = fd.open();
		if (filename != null) {
			mEmulator = filename;
			save();
		}

	}

}
