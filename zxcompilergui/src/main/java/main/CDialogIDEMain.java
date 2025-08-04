package main;

import org.eclipse.swt.widgets.Dialog;
import org.eclipse.swt.widgets.Display;
import org.eclipse.swt.widgets.FileDialog;
import org.eclipse.swt.widgets.Label;
import org.eclipse.swt.widgets.Shell;
import org.eclipse.swt.custom.CTabFolder;
import org.eclipse.swt.custom.CTabItem;
import org.eclipse.swt.custom.LineStyleListener;
import org.eclipse.swt.custom.SashForm;
import org.eclipse.swt.custom.StyleRange;
import org.eclipse.swt.custom.StyledText;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.eclipse.swt.SWT;
import org.eclipse.swt.layout.FillLayout;
import org.eclipse.swt.layout.FormAttachment;
import org.eclipse.swt.layout.FormData;
import org.eclipse.swt.layout.FormLayout;
import org.eclipse.swt.layout.GridData;
import org.eclipse.swt.layout.GridLayout;
import org.eclipse.swt.widgets.ToolBar;
import org.eclipse.swt.widgets.Tree;
import org.eclipse.swt.widgets.TreeItem;

import main.CBASICTokenizer.BASICToken;

import zxcompiler.ZXCompiler;
import zxcompiler.ZXToken;
import zxcompiler.ZXTokenizer;

import org.eclipse.swt.layout.RowLayout;
import org.eclipse.swt.layout.RowData;
import org.eclipse.swt.widgets.Button;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.swt.widgets.Control;
import org.eclipse.swt.events.KeyAdapter;
import org.eclipse.swt.events.KeyEvent;
import org.eclipse.swt.events.ModifyEvent;
import org.eclipse.swt.events.ModifyListener;
import org.eclipse.swt.events.SelectionAdapter;
import org.eclipse.swt.events.SelectionEvent;
import org.eclipse.swt.graphics.Font;
import org.eclipse.swt.graphics.Point;
//import org.eclipse.wb.swt.SWTResourceManager;

public class CDialogIDEMain extends Dialog {

	public String mFolder;
	protected Object result;
	protected Shell shlZxBasic;
	private ZXToken mZXToken = new ZXToken();
	StyledText editor;
	  private Display display;
    Tree tree;
	private BasicLineStyler mBasicLineStyler = new BasicLineStyler();
	private String mFilename;
	private CTabFolder mTabFolder;
	 private static final String[] KEYWORDS = {
	            "REM", "PRINT", "INPUT", "IF", "THEN", "ELSE", "FOR", "NEXT",
	            "GOTO", "GOSUB", "RETURN", "END", "REM SPRITE"
	    };

	    private static final Pattern NUMBER_PATTERN = Pattern.compile("\\b\\d+\\b");
	    private static final Pattern STRING_PATTERN = Pattern.compile("\".*?\"");
	    private static final Pattern COMMENT_PATTERN = Pattern.compile("REM.*", Pattern.CASE_INSENSITIVE);

	/**
	 * Create the dialog.
	 * @param parent
	 * @param style
	 */
	public CDialogIDEMain(Shell parent, int style) {
		super(parent, style);
		setText("SWT Dialog");
	}

	/**
	 * Open the dialog.
	 * @return the result
	 */
	public Object open() {
		if (mFolder == null)
			mFolder = ".";

		createContents();
		shlZxBasic.open();
		shlZxBasic.layout();
		display = shlZxBasic.getDisplay();

        for (int i = 1; i <= 5; i++) {
            TreeItem item = new TreeItem(tree, 0);
            item.setText("Datei " + i);
        }
        autoload();
		Display display = getParent().getDisplay();
		while (!shlZxBasic.isDisposed()) {
			if (!display.readAndDispatch()) {
				display.sleep();
			}
		}
		return result;
	}

	

	private void autoload() {
			String text = getAutoload();
			if (text == null) return;
			String lines[] = text.split("\n");
			for (String line : lines) {
				int p = line.indexOf('=');
				if (p != -1) {
					String name = line.substring(0, p);
					String fname = line.substring(p + 1);
					if (name.compareTo("folder") == 0) {
						mFolder = fname;
						//loadFilesTree();
					} else {
						loadFile(fname);
					}
				} else
					loadFile(line);
			}
	}

	private String getAutoload() {
		String autoload = Tools.loadTextFile("autoload.inf");
		return autoload;
	}

	/**
	 * Create contents of the dialog.
	 */
	private void createContents() {
		shlZxBasic = new Shell(getParent(), getStyle());
		shlZxBasic.setSize(1013, 564);

		shlZxBasic.setLayout(new GridLayout(1, false));

	        // Toolbar oben
	        Composite toolbar = new Composite(shlZxBasic, SWT.NONE);
	        toolbar.setLayoutData(new GridData(SWT.FILL, SWT.TOP, true, false));
	        toolbar.setLayout(new RowLayout());
	        Button button = new Button(toolbar, SWT.PUSH);
	        button.addSelectionListener(new SelectionAdapter() {
	        	@Override
	        	public void widgetSelected(SelectionEvent e) {
	        		onNew();
	        		
	        	}
	        });
	        button.setText("Neu");
	        Button button_1 = new Button(toolbar, SWT.PUSH);
	        button_1.addSelectionListener(new SelectionAdapter() {
	        	@Override
	        	public void widgetSelected(SelectionEvent e) {
	        		onOpenFile();
	        	}
	        });
	        button_1.setText("Öffnen");
	        
	        Button btnSpeichern = new Button(toolbar, SWT.NONE);
	        btnSpeichern.addSelectionListener(new SelectionAdapter() {
	        	@Override
	        	public void widgetSelected(SelectionEvent e) {
	        		onSave();
	        	}
	        });
	        btnSpeichern.setText("Speichern");
	        
	        Button btnSpeichernAls = new Button(toolbar, SWT.NONE);
	        btnSpeichernAls.addSelectionListener(new SelectionAdapter() {
	        	@Override
	        	public void widgetSelected(SelectionEvent e) {
	        		onSavesAs();
	        	}
	        });
	        btnSpeichernAls.setText("Speichern Als");
	        
	        Button btnEmulator = new Button(toolbar, SWT.NONE);
	        btnEmulator.addSelectionListener(new SelectionAdapter() {
	        	@Override
	        	public void widgetSelected(SelectionEvent e) {
	        		onEmulator();
	        	}
	        });
	        btnEmulator.setText("Emulator");
	        
	        Button btnCompiler = new Button(toolbar, SWT.NONE);
	        btnCompiler.addSelectionListener(new SelectionAdapter() {
	        	@Override
	        	public void widgetSelected(SelectionEvent e) {
	        		onCompiler();
	        	}
	        });
	        btnCompiler.setText("Compiler");
	        
	        Button btnUdgEditor = new Button(toolbar, SWT.NONE);
	        btnUdgEditor.addSelectionListener(new SelectionAdapter() {
	        	@Override
	        	public void widgetSelected(SelectionEvent e) {
	        		onUDGEditor();
	        	}
	        });
	        btnUdgEditor.setText("UDG Editor");
	        
	        Button btnSpriteEditor = new Button(toolbar, SWT.NONE);
	        btnSpriteEditor.setText("Sprite Editor");
	        
	        Button btnTileEditor = new Button(toolbar, SWT.NONE);
	        btnTileEditor.setText("Tile Editor");
	        
	        Button btnNewButton = new Button(toolbar, SWT.NONE);
	        btnNewButton.addSelectionListener(new SelectionAdapter() {
	        	@Override
	        	public void widgetSelected(SelectionEvent e) {
	        		CDialogOptions dlg = new CDialogOptions(shlZxBasic, SWT.TITLE|SWT.CLOSE);
	        		dlg.open();
	        	}
	        });
	        btnNewButton.setText("Optionen");

	        // SashForm für Navigation + Editor
	        SashForm sash = new SashForm(shlZxBasic, SWT.HORIZONTAL);
	        sash.setLayoutData(new GridData(SWT.FILL, SWT.FILL, true, true));

	        // Linke Seite: Tree für Projekt-Navigation
	        tree= new Tree(sash, SWT.BORDER | SWT.V_SCROLL);


	        // Rechte Seite: StyledText Editor
	         
	        mTabFolder = new CTabFolder(sash, SWT.NONE);
	        

	        sash.setWeights(new int[] { 25, 75 }); // Start-Aufteilung: 25% links, 75% rechts

	        // Statusleiste unten
	        Label status = new Label(shlZxBasic, SWT.BORDER);
	        status.setLayoutData(new GridData(SWT.FILL, SWT.BOTTOM, true, false));
	        status.setText("Bereit");


	}

	protected void onUDGEditor() {
		CDialogSpriteEditor dlg = new CDialogSpriteEditor(shlZxBasic, getStyle());
		dlg.open();
		
	}

	protected void onCompiler() {
		BasicPreparser pp = new BasicPreparser();
		StyledText editor1=getEditor();
		String text = editor1.getText()+"\n stop\n stop\n\n";
		String[] lines = text.split("\n");
		ArrayList<String> l = new ArrayList<String>();
		for (String s: lines) l.add(s);
		List<BasicLine> result = pp.preprocess(l);
		List<String> parsedResult = pp.createBASIC(result);
		StyledText editor = createStyledText("emulator.bas");
		StringBuilder sb = new StringBuilder();
		for (String line: parsedResult)
			sb.append(line+"\n");
		editor.setText(sb.toString());
		
		
		CBASICTokenizer tokenizer = new CBASICTokenizer();
		try {
			byte[] code = tokenizer.tokenize(sb.toString());
			ZXCompiler compiler = new ZXCompiler();
			CSettings set = CSettings.instance();
			compiler.mSettingCompileDebug = false;
			compiler.mSettingLineNr = true;
			compiler.mSettingOptimize = 1;
			compiler.mSettingStop = 2;
			compiler.start(code);
			compiler.compile();
			compiler.writeCode(CSettings.instance().mAsmOutput);
			StyledText asmEditor=createStyledText("compiledBasic.asm", true);
			asmEditor.setText(compiler.mEmitter.sbCode.toString());
			StringBuilder sbbat = new StringBuilder();
			String path = set.mTapFile;
			int p = path.lastIndexOf('\\');
			if (p == -1) p = path.lastIndexOf("/");
			if (p == -1) return;
			path = path.substring(0,p);
			String compileBat = path+"\\compileRun.bat";
			StringBuilder sbCompileBat = new StringBuilder();
			sbCompileBat.append(String.format("cd \"%s\"\n",path));
			sbCompileBat.append(String.format("del \"%s\"\n",set.mTapFile));
			sbCompileBat.append(String.format("\"%s\" \"%s\"\n", set.mAssembler, set.mMainAsm));
			sbCompileBat.append(String.format("start \"%s\" \"%s\"\n", set.mEmulator, set.mTapFile));
			sbCompileBat.append(String.format("pause\n" ));
			Tools.writeTextFile(compileBat,  sbCompileBat.toString());
			StyledText editLog = createStyledText("log");
			editLog.setText(compiler.mEmitter.mSBLog.toString());
			
			//Tools.executeCommand(String.format("cmd /C \"start %s\"", compileBat), shlZxBasic);
			try {
	            Runtime.getRuntime().exec(String.format("cmd.exe /c \"%s\"", compileBat));
	        } catch (IOException e) {
	            e.printStackTrace();
	        }
			
			
			
					
		
			
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
				
	}

	protected void onNew() {
		StyledText edit = createStyledText();
		edit.setData(null);
		// TODO Auto-generated method stub
		
	}
	
	protected void onSave() {
		StyledText editor=getEditor();
		if (editor == null) {
			onSavesAs();
			return;
		}
		String filename = (String)editor.getData();
		if (filename == null) 
			onSavesAs();
		else
			save(filename);
			
	}
	

	private void save(String filename) {
		StyledText editor = getEditor();
		String text = editor.getText();
		Tools.writeTextFile(filename.trim(), text);
		
	}

	private StyledText getEditor() {
		CTabItem item = mTabFolder.getSelection();
		Control ctrl = item.getControl();
		if (ctrl instanceof StyledText)
			return (StyledText)ctrl;
		return null;
	}

	protected void onSavesAs() {
		StyledText editor = getEditor();
		if (editor == null) return;
		String[] filterExt = { "*.bas" };
		FileDialog fd = new FileDialog(shlZxBasic, SWT.OPEN);
		fd.setText("Open basic program");
		fd.setFilterExtensions(filterExt);
		String filename = fd.open();
		editor.setData(filename);
		save(filename);
		
		
	}

	protected void onOpenFile() {
		String[] filterExt = { "*.bas" };
		FileDialog fd = new FileDialog(shlZxBasic, SWT.OPEN);
		fd.setText("Open basic program");
		fd.setFilterExtensions(filterExt);
		mFilename = fd.open();
		if (mFilename == null)
			return;
		loadFile(mFilename);
		setAutoload();
		
	}


	private void setAutoload() {
		StringBuilder sb = new StringBuilder();
		sb.append("folder=" + mFolder + "\n");
		for (CTabItem item : mTabFolder.getItems()) {
			String fname = (String) item.getData();
			if (fname != null)
				sb.append("file=" + fname + "\n");
		}

		Tools.writeTextFile("autoload.inf", sb.toString());
		
	}

	private void loadFile(String fname) {
		String strSource = Tools.loadTextFile(fname.trim());
		if (strSource == null)
			return;
		File file = new File(fname);
		StyledText text = createStyledText(fname);
		text.setData(fname);
		text.setText(strSource);		
	}
	
	private StyledText createStyledText() {
		return createStyledText("new");
	}

	private StyledText createStyledText(String fname) {
		return createStyledText(fname, false);
	}
	private StyledText createStyledText(String fname, boolean z80) {
		CTabItem[] items = mTabFolder.getItems();
		for (CTabItem item:items) {
			String name = item.getText();
			if (name.compareTo(fname) == 0) {
				Control ctrl = item.getControl();
				if (ctrl instanceof StyledText)  return (StyledText)ctrl;				
			}
		}
		
		
		
		 CTabItem item1 = new CTabItem(mTabFolder, SWT.CLOSE);
		 mTabFolder.setSelection(item1);
		 item1.setData(fname);
		item1.setText(filenameOf(fname));
		StyledText text = new StyledText(mTabFolder, SWT.BORDER | SWT.H_SCROLL | SWT.V_SCROLL | SWT.CANCEL | SWT.MULTI);
		item1.setControl(text);
		text.addModifyListener(new ModifyListener() {
			public void modifyText(ModifyEvent e) {
				onModifyText(e);
			}
		});

		text.addLineStyleListener(mBasicLineStyler);
		if (z80) mBasicLineStyler.initializeZ80();

		text.addKeyListener(new KeyAdapter() {
			@Override
			public void keyReleased(KeyEvent e) {
				onKeyReleasedEditor(e);
			}
		});
		text.addSelectionListener(new SelectionAdapter() {
			@Override
			public void widgetSelected(SelectionEvent e) {
				StyledText text = (StyledText) e.widget;
				Point pt = text.getSelection();
				//mLblStatus.setText(String.format("%d/%d", pt.x, pt.y));
			}
		});
		Font font2 = new Font(display, "Courier New",10, SWT.NORMAL);		
		text.setFont(font2);
		text.addListener(SWT.Dispose, e -> font2.dispose());
		//text.setFont(SWTResourceManager.getFont("Courier New", 9, SWT.NORMAL));
		return text;

	}	

	private String filenameOf(String path) {
		int p = path.lastIndexOf("\\");
		if (p == -1) p = path.lastIndexOf("/");
		if (p != -1) return path.substring(p+1);
		return path;
	}

	protected void onModifyText(ModifyEvent e) {
		// TODO Auto-generated method stub
		
	}

	protected void onKeyReleasedEditor(KeyEvent e) {
		// TODO Auto-generated method stub
		
	}

	
	StyledText newEditor() {
		
        editor = new StyledText(mTabFolder, SWT.BORDER | SWT.V_SCROLL | SWT.H_SCROLL);
        editor.addLineStyleListener(mBasicLineStyler );
        //mTabFolder.setSelection(item);

        return editor;
	}

	protected void onEmulator() {
		try {
			BasicPreparser pp = new BasicPreparser();
			StyledText editor1=getEditor();
			String[] lines = editor1.getText().split("\n");
			ArrayList<String> l = new ArrayList<String>();
			for (String s: lines) l.add(s);
			List<BasicLine> result = pp.preprocess(l);
			List<String> parsedRsult = pp.createBASIC(result);
			StyledText editor = createStyledText("emulator.bas");
			StringBuilder sb = new StringBuilder();
			for (String line: parsedRsult)
				sb.append(line+"\n");
			editor.setText(sb.toString());
			setFilename("emulator.bas");
			
			CBASICTokenizer tokenizer = new CBASICTokenizer();
			try {
				byte[] code = tokenizer.tokenize(sb.toString());
				ZXTapWriter tapWrite = new ZXTapWriter();
				String filename = (String)editor1.getData();
				if (filename == null) filename = "basic.bas";
				tapWrite.writeBasicTap(filename.trim()+".tap", "basic.bas", code, 1000);
				
				
				
				ZXTokenizer zxtokenizer = new ZXTokenizer();
				zxtokenizer.init(code);
				ZXTokenizer.ZXBasicLine basicLine = new ZXTokenizer.ZXBasicLine();
				StyledText editor2 = createStyledText("tokenized");
				StringBuilder sb2= new StringBuilder();
				while (zxtokenizer.getLine(basicLine))
					sb2.append(basicLine.toString()+"\r\n");
				editor2.setText(sb2.toString());
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		
		
		// TODO Auto-generated method stub
		
	}

	private void setFilename(String string) {
		StyledText editor=getEditor();
		if (editor != null)
			editor.setData(string);
		mTabFolder.getSelection().setText(string);
		
	}
}
