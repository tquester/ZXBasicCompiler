package main;

import org.eclipse.swt.widgets.Dialog;
import org.eclipse.swt.widgets.Display;
import org.eclipse.swt.widgets.FileDialog;
import org.eclipse.swt.widgets.Shell;
import org.eclipse.swt.widgets.Label;
import org.eclipse.swt.SWT;
import org.eclipse.swt.widgets.Text;
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
	public Object open() {
		createContents();
		shlOptionen.open();
		shlOptionen.layout();
		CSettings set = CSettings.instance();
		textASMFile.setText(set.mAsmOutput);
		textTapeFile.setText(set.mTapFile);
		txtAsmOutput.setText(set.mAsmOutput);
		txtAssembler.setText(set.mAssembler);
		textEmulator.setText(set.mEmulator);
		txtOptions.setText(set.mCompilerOptions);
		
		
		Display display = getParent().getDisplay();
		while (!shlOptionen.isDisposed()) {
			if (!display.readAndDispatch()) {
				display.sleep();
			}
		}
		return result;
	}

	
	/**
	 * Create contents of the dialog.
	 */
	private void createContents() {
		shlOptionen = new Shell(getParent(), getStyle());
		shlOptionen.setSize(698, 599);
		shlOptionen.setText("Optionen");
		
		Label lblNewLabel = new Label(shlOptionen, SWT.NONE);
		lblNewLabel.setBounds(10, 21, 435, 20);
		lblNewLabel.setText("Ausgabe assembler");
		
		txtAsmOutput = new Text(shlOptionen, SWT.BORDER);
		txtAsmOutput.setText("C:\\workspaces\\github\\ZXBasicCompiler\\Artikel2\\Assembler\\compiledBasic.asm");
		txtAsmOutput.setBounds(10, 47, 615, 26);
		
		Button button = new Button(shlOptionen, SWT.NONE);
		button.addSelectionListener(new SelectionAdapter() {
			@Override
			public void widgetSelected(SelectionEvent e) {
				onFindOutputFile();
			}
		});
		button.setBounds(640, 47, 40, 30);
		button.setText("...");
		
		Label lblAssembler = new Label(shlOptionen, SWT.NONE);
		lblAssembler.setBounds(10, 89, 603, 20);
		lblAssembler.setText("Assembler sjasmplus");
		
		txtAssembler = new Text(shlOptionen, SWT.BORDER);
		txtAssembler.setText("E:/Emulator/z80/dev/sjasmplus-1.20.2.win/sjasmplus.exe");
		txtAssembler.setBounds(10, 115, 615, 26);
		
		Button button_1 = new Button(shlOptionen, SWT.NONE);
		button_1.addSelectionListener(new SelectionAdapter() {
			@Override
			public void widgetSelected(SelectionEvent e) {
				onFindAssembler();
			}
		});
		button_1.setText("...");
		button_1.setBounds(640, 113, 40, 30);
		
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
		lblMainAsmFil.setBounds(10, 147, 316, 20);
		lblMainAsmFil.setText("Main ASM file");
		
		textASMFile = new Text(shlOptionen, SWT.BORDER);
		textASMFile.setText("C:\\workspaces\\github\\ZXBasicCompiler\\Artikel2\\Assembler\\main.asm");
		textASMFile.setBounds(10, 167, 615, 26);
		
		Button button_1_1 = new Button(shlOptionen, SWT.NONE);
		button_1_1.addSelectionListener(new SelectionAdapter() {
			@Override
			public void widgetSelected(SelectionEvent e) {
				onFindAsmMainFile();
			}
		});
		button_1_1.setText("...");
		button_1_1.setBounds(640, 165, 40, 30);
		
		Label lblCompiledTapeFile = new Label(shlOptionen, SWT.NONE);
		lblCompiledTapeFile.setText("compiled tape file");
		lblCompiledTapeFile.setBounds(10, 199, 316, 20);
		
		textTapeFile = new Text(shlOptionen, SWT.BORDER);
		textTapeFile.setText("C:\\workspaces\\github\\ZXBasicCompiler\\Artikel2\\Assembler\\compiled.tap");
		textTapeFile.setBounds(10, 225, 615, 26);
		
		Button button_1_1_1 = new Button(shlOptionen, SWT.NONE);
		button_1_1_1.addSelectionListener(new SelectionAdapter() {
			@Override
			public void widgetSelected(SelectionEvent e) {
				onFindTapFile();
			}
		});
		button_1_1_1.setText("...");
		button_1_1_1.setBounds(640, 223, 40, 30);
		Label lblEmulator = new Label(shlOptionen, SWT.NONE);
		lblEmulator.setText("Emulator");
		lblEmulator.setBounds(10, 447, 316, 20);
		
		textEmulator = new Text(shlOptionen, SWT.BORDER);
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
		lblCompilerOptionen.setBounds(10, 263, 199, 20);
		lblCompilerOptionen.setText("Compiler Optionen");
		
		txtOptions = new Text(shlOptionen, SWT.BORDER);
		txtOptions.setText(".s1 -o -l");
		txtOptions.setBounds(10, 302, 603, 21);;


	}

	protected void onFindTapFile() {
		String[] filterExt = { "*.tap" };
		FileDialog fd = new FileDialog(shlOptionen, SWT.OPEN);
		fd.setText("Open tap file");
		fd.setFilterExtensions(filterExt);
		textTapeFile.setText(fd.open());
		
	}

	protected void onFindAsmMainFile() {
		String[] filterExt = { "*.bas" };
		FileDialog fd = new FileDialog(shlOptionen, SWT.OPEN);
		fd.setText("Open basic program");
		fd.setFilterExtensions(filterExt);
		textASMFile.setText(fd.open());
		
	}

	protected void onOK() {
		CSettings settings = CSettings.instance();
		settings.mAsmOutput = txtAsmOutput.getText();
		settings.mAssembler = txtAssembler.getText();
		settings.mTapFile = textTapeFile.getText();
		settings.mMainAsm = textASMFile.getText();
		settings.mEmulator = textEmulator.getText();
		settings.mCompilerOptions = txtOptions.getText();
		settings.save();
		shlOptionen.close();
	}

	protected void onFindAssembler() {
		String[] filterExt = { "*.bas" };
		FileDialog fd = new FileDialog(shlOptionen, SWT.OPEN);
		fd.setText("Open basic program");
		fd.setFilterExtensions(filterExt);
		txtAssembler.setText(fd.open());
		
	}

	protected void onFindOutputFile() {
		String[] filterExt = { "*.bas" };
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
