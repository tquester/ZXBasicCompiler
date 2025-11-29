package main;

import org.eclipse.swt.widgets.Dialog;
import org.eclipse.swt.widgets.DirectoryDialog;
import org.eclipse.swt.widgets.Display;
import org.eclipse.swt.widgets.FileDialog;
import org.eclipse.swt.widgets.Shell;
import org.eclipse.swt.widgets.Label;
import org.eclipse.swt.SWT;
import org.eclipse.swt.widgets.Text;

import main.COSDetector.OS;

import org.eclipse.swt.widgets.Button;
import org.eclipse.swt.events.SelectionAdapter;
import org.eclipse.swt.events.SelectionEvent;

public class CDialogOptions extends Dialog {

	protected Object result;
	protected Shell shlOptionen;
	private Text txtAsmOutput;
	private Text txtAssembler;
	private Text textASMFile;
	private Text textTapeFile;
	private Text textEmulator;
	private Text txtOptions;
	private Text textPath;

	/**
	 * Create the dialog.
	 * @param parent
	 * @param style
	 */
	public CDialogOptions(Shell parent, int style) {
		super(parent, style);
		setText("SWT Dialog");
	}

	/**
	 * Open the dialog.
	 * @return the result
	 */
	
	protected void onOK() {
		CSettings settings = CSettings.instance();
		settings.mAsmOutput = txtAsmOutput.getText();
		settings.mAssembler = txtAssembler.getText();
		settings.mTapFile = textTapeFile.getText();
		settings.mMainAsm = textASMFile.getText();
		settings.mEmulator = textEmulator.getText();
		settings.mCompilerOptions = txtOptions.getText();
		settings.mOutputDir = textPath.getText();
		settings.save();
		shlOptionen.close();
	}
	
	public Object open() {
		createContents();
		shlOptionen.open();
		shlOptionen.layout();
		CSettings set = CSettings.instance();
		textASMFile.setText(nn(set.mMainAsm));
		textTapeFile.setText(nn(set.mTapFile));
		txtAsmOutput.setText(nn(set.mAsmOutput));
		txtAssembler.setText(nn(set.mAssembler));
		textEmulator.setText(nn(set.mEmulator));
		txtOptions.setText(nn(set.mCompilerOptions));
		textPath.setText(nn(set.mOutputDir));
		
		Button button_findFuse = new Button(shlOptionen, SWT.NONE);
		button_findFuse.addSelectionListener(new SelectionAdapter() {
			@Override
			public void widgetSelected(SelectionEvent e) {
				String[] filterExt = { "*.exe" };
				FileDialog fd = new FileDialog(shlOptionen, SWT.OPEN);
				fd.setText("Open basic program");
				fd.setFilterExtensions(filterExt);
				textEmulator.setText(fd.open());

			}
		});
		button_findFuse.setText("...");
		button_findFuse.setBounds(640, 473, 40, 30);
		
		
		
		Display display = getParent().getDisplay();
		while (!shlOptionen.isDisposed()) {
			if (!display.readAndDispatch()) {
				display.sleep();
			}
		}
		return result;
	}

	
	private String nn(String str) {
		return str == null ? "" : str;
	}

	/**
	 * Create contents of the dialog.
	 */
	private void createContents() {
		shlOptionen = new Shell(getParent(), getStyle());
		shlOptionen.setSize(698, 599);
		shlOptionen.setText("Optionen");
		
		txtAsmOutput = new Text(shlOptionen, SWT.BORDER);
		txtAsmOutput.setToolTipText("This is the filename of the compiled BASIC programm, usually compiledBASIC.asm\n\nmain.asm is including this file. if you change the file name, you also must change it in main.asm\n");
		txtAsmOutput.setText("C:\\workspaces\\github\\ZXBasicCompiler\\Artikel2\\Assembler\\compiledBasic.asm");
		txtAsmOutput.setBounds(10, 112, 615, 26);
		
		Button button = new Button(shlOptionen, SWT.NONE);
		button.addSelectionListener(new SelectionAdapter() {
			@Override
			public void widgetSelected(SelectionEvent e) {
				onFindOutputFile();
			}
		});
		button.setBounds(640, 112, 40, 30);
		button.setText("...");
		
		Label lblAssembler = new Label(shlOptionen, SWT.NONE);
		lblAssembler.setBounds(10, 154, 603, 20);
		lblAssembler.setText("Assembler sjasmplus");
		
		txtAssembler = new Text(shlOptionen, SWT.BORDER);
		txtAssembler.setToolTipText("path to the sjasmplus. If you are running windows, the IDE will automatically download and install the assembler.\n\nIf you are running on linux or mac os, you must manually download and compile sjasmplus then select the path to the compiled assembler");
		txtAssembler.setText("E:/Emulator/z80/dev/sjasmplus-1.20.2.win/sjasmplus.exe");
		txtAssembler.setBounds(10, 180, 615, 26);
		
		Label lblNewLabel = new Label(shlOptionen, SWT.NONE);
		lblNewLabel.setBounds(10, 89, 68, 17);
		lblNewLabel.setText("Compiled File (compiledBasic.asm)");
		
		Button button_1 = new Button(shlOptionen, SWT.NONE);
		button_1.addSelectionListener(new SelectionAdapter() {
			@Override
			public void widgetSelected(SelectionEvent e) {
				onFindAssembler();
			}
		});
		button_1.setText("...");
		button_1.setBounds(640, 178, 40, 30);
		
		Button btnOk = new Button(shlOptionen, SWT.NONE);
		btnOk.addSelectionListener(new SelectionAdapter() {
			@Override
			public void widgetSelected(SelectionEvent e) {
				onOK();
			}
		});
		btnOk.setBounds(580, 516, 90, 26);
		btnOk.setText("OK");
		
		Label lblMainAsmFil = new Label(shlOptionen, SWT.NONE);
		lblMainAsmFil.setBounds(10, 212, 316, 22);
		lblMainAsmFil.setText("Main ASM file");
		
		textASMFile = new Text(shlOptionen, SWT.BORDER);
		textASMFile.setToolTipText("The main assembler file. Usually main.asm.\nThis is part of the runtime.\n\nYou can change main.asm in order to include or exclude some optons, for example you can run your compiled BASIC in DeZog inside visual Studio or you can enable the BASIC debugger");
		textASMFile.setText("C:\\workspaces\\github\\ZXBasicCompiler\\Artikel2\\Assembler\\main.asm");
		textASMFile.setBounds(10, 232, 615, 26);
		
		Button button_1_1 = new Button(shlOptionen, SWT.NONE);
		button_1_1.addSelectionListener(new SelectionAdapter() {
			@Override
			public void widgetSelected(SelectionEvent e) {
				onFindAsmMainFile();
			}
		});
		button_1_1.setText("...");
		button_1_1.setBounds(640, 230, 40, 30);
		
		Label lblCompiledTapeFile = new Label(shlOptionen, SWT.NONE);
		lblCompiledTapeFile.setText("compiled tape file");
		lblCompiledTapeFile.setBounds(10, 264, 316, 20);
		
		textTapeFile = new Text(shlOptionen, SWT.BORDER);
		textTapeFile.setToolTipText("The output file name of the compiled BASIC.\n\nThis filename is defined in macros.asm inside the BASIC runtime. If you change the file name you must change it in main.asm and macros.asm ");
		textTapeFile.setText("C:\\workspaces\\github\\ZXBasicCompiler\\Artikel2\\Assembler\\compiled.tap");
		textTapeFile.setBounds(10, 290, 615, 26);
		
		Button button_1_1_1 = new Button(shlOptionen, SWT.NONE);
		button_1_1_1.addSelectionListener(new SelectionAdapter() {
			@Override
			public void widgetSelected(SelectionEvent e) {
				onFindTapFile();
			}
		});
		button_1_1_1.setText("...");
		button_1_1_1.setBounds(640, 288, 40, 30);
		Label lblEmulator = new Label(shlOptionen, SWT.NONE);
		lblEmulator.setText("Emulator");
		lblEmulator.setBounds(10, 447, 316, 20);
		
		textEmulator = new Text(shlOptionen, SWT.BORDER);
		textEmulator.setToolTipText("Place the command for the emulator here. On windows it may be fuse.exe.\nOn linux simply write fuse if you installed fuse using your packet manager");
		textEmulator.setText("C:\\Program Files (x86)\\Spectaculator\\Spectaculator.exe");
		textEmulator.setBounds(10, 473, 615, 26);
		
		Button button_1_1_3 = new Button(shlOptionen, SWT.NONE);
		button_1_1_3.addSelectionListener(new SelectionAdapter() {
			@Override
			public void widgetSelected(SelectionEvent e) {
				onFindEmulator();
			}
		});
		
		Label lblCompilerOptionen = new Label(shlOptionen, SWT.NONE);
		lblCompilerOptionen.setBounds(10, 328, 199, 20);
		lblCompilerOptionen.setText("Compiler Optionen");
		
		txtOptions = new Text(shlOptionen, SWT.BORDER);
		txtOptions.setText(".s1 -o -l");
		txtOptions.setBounds(10, 367, 603, 21);;

		Label lblNewLabel_1 = new Label(shlOptionen, SWT.NONE);
		lblNewLabel_1.setBounds(10, 25, 417, 17);
		lblNewLabel_1.setText("Output path");
		
		textPath = new Text(shlOptionen, SWT.BORDER);
		textPath.setToolTipText("This is the directory for the compiled output, we will also create the tapes here if you run your BASIC program in the emulator.\nThis directory must contain the main.asm file and the BASIC runtime directory (ZXLibrary)");
		textPath.setBounds(10, 48, 603, 30);
		
		Button buttonPath = new Button(shlOptionen, SWT.NONE);
		buttonPath.addSelectionListener(new SelectionAdapter() {
			@Override
			public void widgetSelected(SelectionEvent e) {
				DirectoryDialog dlg = new DirectoryDialog(shlOptionen);
				String dir = dlg.open();
				if (dir != null) {
					textPath.setText(dir);
				}
			}
		});
		buttonPath.setBounds(640, 48, 40, 27);
		buttonPath.setText("...");

	}

	protected void onFindTapFile() {
		String[] filterExt = { "*.tap" };
		FileDialog fd = new FileDialog(shlOptionen, SWT.OPEN);
		fd.setText("Open tap file");
		fd.setFilterExtensions(filterExt);
		textTapeFile.setText(fd.open());
		
	}

	protected void onFindAsmMainFile() {
		String[] filterExt = { "*.asm" };
		FileDialog fd = new FileDialog(shlOptionen, SWT.OPEN);
		fd.setText("Open basic program");
		fd.setFilterExtensions(filterExt);
		textASMFile.setText(fd.open());
		
	}


	protected void onFindAssembler() {
		FileDialog fd = new FileDialog(shlOptionen, SWT.OPEN);
		fd.setText("Open assembler");
		txtAssembler.setText(fd.open());
		
	}

	protected void onFindOutputFile() {
		String[] filterExt = { "*.asm" };
		FileDialog fd = new FileDialog(shlOptionen, SWT.OPEN);
		fd.setText("Open basic program");
		fd.setFilterExtensions(filterExt);
		txtAsmOutput.setText(fd.open());
		
		
	}
	protected void onFindEmulator() {
		String[] filterExt = { "*.exe" };
		FileDialog fd = new FileDialog(shlOptionen, SWT.OPEN);
		fd.setText("Open Emulator");
		fd.setFilterExtensions(filterExt);
		textEmulator.setText(fd.open());
		
	}
}
