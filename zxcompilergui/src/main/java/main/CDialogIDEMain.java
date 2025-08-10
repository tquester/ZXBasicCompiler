package main;

import org.eclipse.swt.widgets.Dialog;
import org.eclipse.swt.widgets.Display;
import org.eclipse.swt.widgets.FileDialog;
import org.eclipse.swt.widgets.Label;
import org.eclipse.swt.widgets.Menu;
import org.eclipse.swt.widgets.MenuItem;
import org.eclipse.swt.widgets.MessageBox;
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
import java.util.TreeSet;
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
import main.spriteed.CDialogSpriteEditor;
import main.spriteed.CUdgMatrixData;
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
import org.eclipse.swt.widgets.Text;
//import org.eclipse.wb.swt.SWTResourceManager;

public class CDialogIDEMain extends Dialog {

	public String mFolder;
	protected Object result;
	protected Shell shlZxBasic;
	private ZXToken mZXToken = new ZXToken();
	StyledText editor;
	  private Display display;
    Tree tree;
    private int lastSearchIndex = 0;
	private BasicLineStyler mBasicLineStyler = new BasicLineStyler();
	private String mFilename;
	private CTabFolder mTabFolder;
	private org.eclipse.swt.widgets.List listNav;
	 private static final String[] KEYWORDS = {
	            "REM", "PRINT", "INPUT", "IF", "THEN", "ELSE", "FOR", "NEXT",
	            "GOTO", "GOSUB", "RETURN", "END", "REM SPRITE"
	    };

	    private static final Pattern NUMBER_PATTERN = Pattern.compile("\\b\\d+\\b");
	    private static final Pattern STRING_PATTERN = Pattern.compile("\".*?\"");
	    private static final Pattern COMMENT_PATTERN = Pattern.compile("REM.*", Pattern.CASE_INSENSITIVE);
	    private Text textlog;
		private TreeSet<String> mSetLabels=null;

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
		createMenu();
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
	        
	        Button btnFormatieren = new Button(toolbar, SWT.NONE);
	        btnFormatieren.addSelectionListener(new SelectionAdapter() {
	        	@Override
	        	public void widgetSelected(SelectionEvent e) {
	        		ZXSpectrumPrettyPrinter pp = new ZXSpectrumPrettyPrinter();
	        		StyledText editor = getEditor();
	        		if (editor != null) {
	        			String text = editor.getText();
	        			text = pp.prettyPrint(text);
	        			editor.setText(text);
	        		}
	        	}
	        });
	        btnFormatieren.setText("Formatieren");
	        
	        Button btnSuchen = new Button(toolbar, SWT.NONE);
	        btnSuchen.addSelectionListener(new SelectionAdapter() {
	        	@Override
	        	public void widgetSelected(SelectionEvent e) {
	        		openSearchDialog(shlZxBasic);
	        	}
	        });
	        btnSuchen.setText("Suchen");
	        
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
	        
	        SashForm sashForm = new SashForm(sash, SWT.VERTICAL);
	        
	        	        // Linke Seite: Tree für Projekt-Navigation
	        	        tree= new Tree(sashForm, SWT.BORDER | SWT.V_SCROLL);
	        	        
	        	        
	        	        listNav = new org.eclipse.swt.widgets.List(sashForm, SWT.BORDER | SWT.V_SCROLL);
	        	        listNav.addSelectionListener(new SelectionAdapter() {
	        	        	@Override
	        	        	public void widgetSelected(SelectionEvent e) {
								onListNavClicked();
	        	        	}
	        	        });
	        sashForm.setWeights(new int[] {1, 1});
	        
	        SashForm sashForm_1 = new SashForm(sash, SWT.VERTICAL);
	        
	        
	        	        // Rechte Seite: StyledText Editor
	        	         
	        	        mTabFolder = new CTabFolder(sashForm_1, SWT.NONE);
	        	        mTabFolder.addSelectionListener(new SelectionAdapter() {
	        	        	@Override
	        	        	public void widgetSelected(SelectionEvent e) {
	        	        		onTabChanged();
	        	        	}
	        	        });
	        	        
	        	        textlog = new Text(sashForm_1, SWT.BORDER | SWT.H_SCROLL | SWT.V_SCROLL | SWT.CANCEL);
	        sashForm_1.setWeights(new int[] {80, 20});
	        

	        sash.setWeights(new int[] {20, 50}); // Start-Aufteilung: 25% links, 75% rechts

	        // Statusleiste unten
	        Label status = new Label(shlZxBasic, SWT.BORDER);
	        status.setLayoutData(new GridData(SWT.FILL, SWT.BOTTOM, true, false));
	        status.setText("Bereit");
	}
	
   protected void onListNavClicked() {
		int sel = listNav.getSelectionIndex();
		if (sel == -1) return;
		String such = listNav.getItem(sel);
		StyledText editor = getEditor();
		if (editor == null) return;
		String text[] = editor.getText().split("\n");
		int line = 0;
		for (String s: text) {
			s = s.trim();
			if (s.compareTo(such) == 0) {
				jumpToLine(editor, line);
				break;
			}
			line++;
		}
	}
   
   public static void jumpToLine(StyledText styledText, int lineNumber) {
       try {
           // Berechne den Offset des Zeilenanfangs
           int offset = styledText.getOffsetAtLine(lineNumber);
           
           // Setze Cursor und Auswahl
           styledText.setSelection(offset);
           
           // Zeige die Zeile an (scrollt bei Bedarf)
           styledText.showSelection();
           
           // Optional: Fokus setzen
           styledText.setFocus();
       } catch (IllegalArgumentException e) {
           // Zeile existiert nicht
           System.out.println("Zeile existiert nicht: " + lineNumber);
       }
   }   

private void createMenu() {
	// Hauptmenü erstellen
       Menu menuBar = new Menu(shlZxBasic, SWT.BAR);
       shlZxBasic.setMenuBar(menuBar);
       
       // Menüpunkte erstellen
       MenuItem fileItem = new MenuItem(menuBar, SWT.CASCADE);
       fileItem.setText("Datei");
       
       MenuItem editItem = new MenuItem(menuBar, SWT.CASCADE);
       editItem.setText("Bearbeiten");

       MenuItem helpItem = new MenuItem(menuBar, SWT.CASCADE);
       helpItem.setText("Hilfe");
       
       // Dropdown-Menüs erstellen
       Menu fileMenu = new Menu(shlZxBasic, SWT.DROP_DOWN);
       fileItem.setMenu(fileMenu);

       Menu editMenu = new Menu(shlZxBasic, SWT.DROP_DOWN);
       editItem.setMenu(editMenu);

       Menu helpMenu = new Menu(shlZxBasic, SWT.DROP_DOWN);
       helpItem.setMenu(helpMenu);
       
       // Menüeinträge für Datei-Menü
       MenuItem openItem = new MenuItem(fileMenu, SWT.PUSH);
       openItem.setText("Öffnen\tCtrl+O");
  //     openItem.addListener(SWT.Selection, e -> onOpenFile());
       
       MenuItem saveItem = new MenuItem(fileMenu, SWT.PUSH);
       saveItem.setText("Speichern\tCtrl+S");
       saveItem.addListener(SWT.Selection, e -> onSave());
       
       MenuItem saveAsItem = new MenuItem(fileMenu, SWT.PUSH);
       saveAsItem.setText("Speichern Al");
       saveAsItem.addListener(SWT.Selection, e -> onSavesAs());
       
       
       MenuItem exitItem = new MenuItem(fileMenu, SWT.PUSH);
       exitItem.setText("Beenden");
       exitItem.addListener(SWT.Selection, e -> shlZxBasic.close());
       
       // Menüeintrag für Hilfe-Menü
       MenuItem aboutItem = new MenuItem(helpMenu, SWT.PUSH);
       aboutItem.setText("Über...");
   }

	protected void onTabChanged() {
		mSetLabels = new TreeSet<String>();
		updateLabels();
		listNav.removeAll();
		for (String s:mSetLabels)
			listNav.add(s);
	}
	
	void updateLabeList() {
		boolean dirty = updateLabels();
		if (dirty) {
			listNav.removeAll();
			for (String s:mSetLabels)
				listNav.add(s);
		}
	}
	
	

	private boolean updateLabels() {
	
		boolean dirty=false;
		if (mSetLabels == null) 
			mSetLabels = new TreeSet<String>();
		StyledText editor = getEditor();
		if (editor == null) return false;
		String lines[] = editor.getText().split("\n");
		TreeSet<String> tempSet = new TreeSet<String>();
		for (String s: mSetLabels)
			tempSet.add(s);
		System.out.println(String.format("set = %d, temp=%d",mSetLabels.size(), tempSet.size()));
		for (String line: lines) {
			line = line.trim();
			if (line.startsWith("#")) {
				if (!mSetLabels.contains(line)) {
					dirty = true;
					mSetLabels.add(line);
				}
				tempSet.remove(line);
			}
		}
		if (!tempSet.isEmpty()) {
			dirty = true;
			for (String s: tempSet)
				mSetLabels.remove(s);
		}
		return dirty;
	}

	protected void onUDGEditor() {
		StyledText editor = getEditor();
		String text="";
		if (editor != null) text = editor.getText();
		CDialogSpriteEditor dlg = new CDialogSpriteEditor(shlZxBasic, getStyle());
		dlg.mText = text;
		dlg.open(new CUdgMatrixData());
		
	}

	protected void onCompiler() {
		CBASICPreparser pp = new CBASICPreparser();
		StyledText editor1=getEditor();

		String text = editor1.getText()+"\r\n stop\r\n";
		text = pp.preparse(text);
		editor = createStyledText("emulator.bas");
		editor.setText(text);
		
		
		CBASICTokenizer tokenizer = new CBASICTokenizer();
		try {
			byte[] code = tokenizer.tokenize(text,5);
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
			String logfile = path+"\\log.txt";
			String compileBat = path+"\\compileRun.bat";
			StringBuilder sbCompileBat = new StringBuilder();
			sbCompileBat.append(String.format("cd \"%s\"\n",path));
			sbCompileBat.append(String.format("del \"%s\"\n",set.mTapFile));
			sbCompileBat.append(String.format("\"%s\" \"%s\" 2> %s\n", set.mAssembler, set.mMainAsm, logfile));
			sbCompileBat.append(String.format("start \"%s\" \"%s\"\n", set.mEmulator, set.mTapFile));
			sbCompileBat.append(String.format("pause\n" ));
			Tools.writeTextFile(compileBat,  sbCompileBat.toString());
			//StyledText editLog = createStyledText("log");
			//editLog.setText(compiler.mEmitter.mSBLog.toString());
			
			//Tools.executeCommand(String.format("cmd /C \"start %s\"", compileBat), shlZxBasic);
			try {
	            Runtime.getRuntime().exec(String.format("cmd.exe /c \"%s\"", compileBat));
	        } catch (IOException e) {
	            e.printStackTrace();
	        }
			String log = Tools.loadTextFile(logfile);
			String clog = compiler.mEmitter.mSBLog.toString();
			if (log != null)
				clog += "\n\n"+log;
			textlog.setText(clog);

			
			
			
					
		
			
			
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
		fname=fname.trim();
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
			String name = item.getText().trim();
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
		updateLabeList();
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
			CBASICPreparser cpp = new CBASICPreparser();
			BasicPreparser pp = new BasicPreparser();
			StyledText editor1=getEditor();
			String text = editor1.getText();
			text = cpp.preparse(text);
			StyledText editor = createStyledText("emulator.bas");
			/*
			String[] lines = text.split("\n");
			ArrayList<String> l = new ArrayList<String>();
			for (String s: lines) l.add(s);
			List<BasicLine> result = pp.preprocess(l);
			List<String> parsedRsult = pp.createBASIC(result);
			
			StringBuilder sb = new StringBuilder();
			for (String line: parsedRsult)
				sb.append(line+"\n");
			editor.setText(sb.toString());
			*/
			editor.setText(text);;
			 
			
			CBASICTokenizer tokenizer = new CBASICTokenizer();
			try {
				byte[] code = tokenizer.tokenize(text,0);
				ZXTapWriter tapWrite = new ZXTapWriter();
				String filename = (String)editor1.getData();
				if (filename == null) filename = "basic.bas";
				tapWrite.writeBasicTap(filename.trim()+".tap", "hello", code, 128*256);
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
	
	  private void openSearchDialog(Shell parentShell) {
	        Shell dialog = new Shell(parentShell, SWT.RESIZE | SWT.DIALOG_TRIM | SWT.APPLICATION_MODAL);
	        dialog.setText("Suchen");
	        dialog.setLayout(new GridLayout(2, false));

	        // Suchfeld
	        Label label = new Label(dialog, SWT.NONE);
	        label.setText("Suchbegriff:");
	        Text searchText = new Text(dialog, SWT.BORDER);
	        searchText.setLayoutData(new GridData(SWT.FILL, SWT.CENTER, true, false));
	        
	        Label replaceLabel = new Label(dialog, SWT.NONE);
	        replaceLabel.setText("Ersetzen mit:");
	        Text replaceText = new Text(dialog, SWT.BORDER);
	        replaceText.setLayoutData(new GridData(SWT.FILL, SWT.CENTER, true, false));


	        // Suchoptionen
	        Button caseSensitive = new Button(dialog, SWT.CHECK);
	        caseSensitive.setText("Groß-/Kleinschreibung beachten");
	        caseSensitive.setLayoutData(new GridData(SWT.FILL, SWT.CENTER, false, false, 2, 1));

	        // Suchbuttons
	        Button findButton = new Button(dialog, SWT.PUSH);
	        findButton.setText("Suchen");
	        findButton.setLayoutData(new GridData(SWT.LEFT, SWT.CENTER, false, false));

	        Button replaceButton = new Button(dialog, SWT.PUSH);
	        replaceButton.setText("Ersetzen");
	        replaceButton.setLayoutData(new GridData(SWT.RIGHT, SWT.CENTER, false, false));

	        
	        Button cancelButton = new Button(dialog, SWT.PUSH);
	        cancelButton.setText("Abbrechen");
	        cancelButton.setLayoutData(new GridData(SWT.RIGHT, SWT.CENTER, false, false));
	        
	        
	        // Event-Handler
	        findButton.addListener(SWT.Selection, e -> {
	            String searchString = searchText.getText();
	            boolean matchCase = caseSensitive.getSelection();
	            findText(getEditor(),searchString, matchCase);
	        });
	        


	        // Event-Handler für Ersetzen
	        replaceButton.addListener(SWT.Selection, e -> {
	            String searchStr = searchText.getText();
	            String replaceStr = replaceText.getText();
	            boolean matchCase = caseSensitive.getSelection();
	            replaceText(getEditor(),searchStr, replaceStr, matchCase);
	        });	        

	        cancelButton.addListener(SWT.Selection, e -> dialog.close());

	        // Enter-Taste im Suchfeld
	        searchText.addKeyListener(new KeyAdapter() {
	            @Override
	            public void keyPressed(KeyEvent e) {
	                if (e.keyCode == SWT.CR || e.keyCode == SWT.KEYPAD_CR) {
	                    String searchString = searchText.getText();
	                    boolean matchCase = caseSensitive.getSelection();
	                    findText(getEditor(),searchString, matchCase);
	                }
	            }
	        });

	        dialog.pack();
	        dialog.open();
	    }
	  
	  private void replaceText(StyledText styledText, String searchString, String replaceString, boolean matchCase) {
		    if (styledText.getSelectionCount() > 0) {
		        String selected = styledText.getSelectionText();
		        boolean matches = matchCase ? selected.equals(searchString) 
		                                  : selected.equalsIgnoreCase(searchString);
		        if (matches) {
		            styledText.replaceTextRange(styledText.getSelectionRange().x, 
		                                      searchString.length(), 
		                                      replaceString);
		        }
		    }
		    findText(styledText, searchString, matchCase);
		}

	    private void findText(StyledText styledText, String searchString, boolean matchCase) {
	        if (searchString.isEmpty()) return;

	        String content = styledText.getText();
	        if (!matchCase) {
	            content = content.toLowerCase();
	            searchString = searchString.toLowerCase();
	        }

	        // Suche ab aktueller Position fortsetzen
	        int start = lastSearchIndex + 1;
	        if (start >= content.length()) start = 0;

	        int foundIndex = content.indexOf(searchString, start);
	        
	        // Falls nicht gefunden, von vorne suchen
	        if (foundIndex == -1 && start > 0) {
	            foundIndex = content.indexOf(searchString, 0);
	        }

	        if (foundIndex != -1) {
	            // Text markieren und anzeigen
	            styledText.setSelection(foundIndex, foundIndex + searchString.length());
	            styledText.showSelection();
	            lastSearchIndex = foundIndex;
	        } else {
	            MessageBox mb = new MessageBox(styledText.getShell(), SWT.ICON_INFORMATION | SWT.OK);
	            mb.setMessage("Text nicht gefunden: " + searchString);
	            mb.open();
	        }
	    }	
	    
}
