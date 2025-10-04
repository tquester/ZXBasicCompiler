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
//import org.eclipse.swt.custom.StyledText;
import org.eclipse.swt.custom.StyledText;

import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;
import java.util.TreeMap;
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

import main.precompiler.OldBasicPreparser;
import main.precompiler.CBASICPreparser;
import main.precompiler.CBASICTokenizer;
import main.precompiler.CBASICTokenizer.BASICToken;
import main.spriteed.CDialogSpriteEditor;
import main.spriteed.CDialogTileEditor;
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
import org.eclipse.swt.events.MouseAdapter;
import org.eclipse.swt.events.MouseEvent;
//import org.eclipse.wb.swt.SWTResourceManager;

public class CDialogIDEMain extends Dialog {

	public String mFolder;
	protected Object result;
	protected Shell shlZxBasic;
	private ZXToken mZXToken = new ZXToken();
	BASICSourceViewer editor;
	  private Display display;
    Tree tree;
    private int lastSearchIndex = 0;
	private BasicLineStyler mBasicLineStyler = new BasicLineStyler();
	private String mFilename;
	private CTabFolder mTabFolder;
	private FileSystemTreePopulator mFileSystemPopulator;
	private org.eclipse.swt.widgets.List listNav;
	private TreeMap<String, Integer> mMapLabels = new TreeMap<String, Integer>();
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
        System.out.println("Starting");

        CDownloadAndInstallAssembler dass = new CDownloadAndInstallAssembler();

        System.out.println("Create contents");

        createContents();

        System.out.println("shell open");

        CSettings settings = CSettings.instance();
         
        shlZxBasic.open();
        System.out.println("Loading assembler");
        dass.assertAssemblerInstalled(shlZxBasic);
        settings.assertEmulator(shlZxBasic);
		createMenu();
		shlZxBasic.layout();
		display = shlZxBasic.getDisplay();
		
		shlZxBasic.addListener(SWT.Traverse, e -> {
		    if (e.detail == SWT.TRAVERSE_ESCAPE) {
		        // Escape ignorieren
		        e.doit = false;
		    }
		});
		System.out.println("auto load");
		autoload();
		System.out.println("Current folder = "+mFolder);
		System.setProperty("user.dir", mFolder);

		
        mFileSystemPopulator = new FileSystemTreePopulator(tree);
        mFileSystemPopulator.populateTree(mFolder);
        System.out.println("Init complete");
        
        
		Display display = getParent().getDisplay();
		while (!shlZxBasic.isDisposed()) {
			if (!display.readAndDispatch()) {
				display.sleep();
			}
		}
		return result;
	}

	

	private void autoload() {
		mFolder = null;
		mFolder = CSettings.getDocumentsPath()+File.separator+"ZXCompiler"; 				
			String text = getAutoload();
			if (text == null) return;
			String lines[] = text.split("\n");
			for (String line : lines) {
				int p = line.indexOf('=');
				if (p != -1) {
					String name = line.substring(0, p);
					String fname = line.substring(p + 1).trim();
					if (name.compareTo("folder") == 0) {
						if (fname != null) {
							if (fname.compareTo(".") != 0 && fname.compareTo("null") != 0)
								mFolder = fname;
						}
						//loadFilesTree();
					} else {
						loadFile(fname);
					}
				} else
					loadFile(line);
			}
			File f = new File(mFolder);
			f.mkdirs();
			System.setProperty("user.dir", mFolder);
	}

	private String getAutoload() {
		String autoload = Tools.loadTextFile(CSettings.appData("autoload.inf"));
		return autoload;
	}

	/**
	 * Create contents of the dialog.
	 */
	private void createContents() {
		
		//Display display = getParent().getDisplay();
		shlZxBasic = new Shell(display);
		//captureParent();

		//shlZxBasic = new Shell(getParent(), getStyle());
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
	        		try {
	        			onSavesAs();
	        		}
	        		catch(Exception e1)
	        		{
	        			
	        		}
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
	        		onSaveAll();
	        		ZXSpectrumPrettyPrinter pp = new ZXSpectrumPrettyPrinter();
	        		BASICSourceViewer editor = getEditor();
	        		if (editor != null) {
	        			try { 
	        				String text = editor.getText();
	        					text = pp.prettyPrint(text);
	        					editor.setText(text);
	        			}
	        			catch(Exception e1) {
	        				e1.printStackTrace();	        				
	        			}
	        		}
	        	}
	        });
	        btnFormatieren.setText("Formatieren");
	        
	        Button btnSuchen = new Button(toolbar, SWT.NONE);
	        btnSuchen.addSelectionListener(new SelectionAdapter() {
	        	@Override
	        	public void widgetSelected(SelectionEvent e) {
	        		getEditor().openSearchDialog();
	        		
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
	        btnSpriteEditor.addSelectionListener(new SelectionAdapter() {
	        	@Override
	        	public void widgetSelected(SelectionEvent e) {
	        	}
	        });
	        btnSpriteEditor.setText("Sprite Editor");
	        
	        Button btnTileEditor = new Button(toolbar, SWT.NONE);
	        btnTileEditor.addSelectionListener(new SelectionAdapter() {
	        	@Override
	        	public void widgetSelected(SelectionEvent e) {
	        		onTileEditor();
	        	}
	        });
	        btnTileEditor.setText("Tile Editor");
	        
	        Button btnNewButton = new Button(toolbar, SWT.NONE);
	        btnNewButton.addSelectionListener(new SelectionAdapter() {
	        	@Override
	        	public void widgetSelected(SelectionEvent e) {
	        		Shell sh = new Shell(display, SWT.DIALOG_TRIM | SWT.MODELESS);
	        		CDialogOptions dlg = new CDialogOptions(sh, SWT.TITLE|SWT.CLOSE);
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
	        	        tree.addMouseListener(new MouseAdapter() {
	        	        	@Override
	        	        	public void mouseDoubleClick(MouseEvent e) {
	        	        		onDoubleClickTree();
	        	        	}
	        	        });
	        	        
	        	        
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
 
	protected void onDoubleClickTree() {
		TreeItem[] sels = tree.getSelection();
		if (sels.length > 0) {
			TreeItem sel = sels[0];
			File file = (File)sel.getData();
			if (file != null) {
				BASICSourceViewer viewer = createStyledText(file.getAbsolutePath());
				viewer.setEditManager(new EditManager(viewer.getEditor(), file.getAbsolutePath()));
				String text = Tools.loadTextFile(file.getAbsolutePath());
				viewer.setText(text);
			}
			
		}
		
	}

	void captureParent() {
		shlZxBasic = getParent();
	}
	
   protected void onTileEditor() {
	   
	   BASICSourceViewer editor = getEditor();
	   if (editor != null) {
		   Shell sh = new Shell(display, SWT.DIALOG_TRIM | SWT.MODELESS);
		   CDialogTileEditor dlg = new CDialogTileEditor(sh, getStyle());
		   dlg.mSource = editor.getTextWidget();
		   dlg.open();
	   }
	   
		
	}

protected void onListNavClicked() {
		int sel = listNav.getSelectionIndex();
		if (sel == -1) return;
		String such = listNav.getItem(sel);
		BASICSourceViewer editor = getEditor();
		if (editor == null) return;
		Integer line = mMapLabels.get(such);
		if (line != null) 
			jumpToLine(editor.getTextWidget(), line.intValue());
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
       
       MenuItem mntmNewItem = new MenuItem(editMenu, SWT.NONE);
       mntmNewItem.setText("Kopieren");
       
       MenuItem mntmNewItem_1 = new MenuItem(editMenu, SWT.NONE);
       mntmNewItem_1.addSelectionListener(new SelectionAdapter() {
       	@Override
       	public void widgetSelected(SelectionEvent e) {
       		onCreateLabels();
       	}
       });
       mntmNewItem_1.setText("Labels erzeugen");
       
       MenuItem mntmSuchen = new MenuItem(editMenu, SWT.NONE);
       mntmSuchen.addSelectionListener(new SelectionAdapter() {
       	@Override
       	public void widgetSelected(SelectionEvent e) {
       		getEditor().openSearchDialog();
       	
       	}
       });
       mntmSuchen.setText("Suchen\tCtrl+F");

       Menu helpMenu = new Menu(shlZxBasic, SWT.DROP_DOWN);
       helpItem.setMenu(helpMenu);
       
       // Menüeinträge für Datei-Menü
       MenuItem openItem = new MenuItem(fileMenu, SWT.PUSH);
       openItem.addSelectionListener(new SelectionAdapter() {
       	@Override
       	public void widgetSelected(SelectionEvent e) {
       		onOpenFile();
       	}
       });
       openItem.setText("Öffnen\tCtrl+O");
  //     openItem.addListener(SWT.Selection, e -> onOpenFile());
       
       MenuItem saveItem = new MenuItem(fileMenu, SWT.PUSH);
       saveItem.addSelectionListener(new SelectionAdapter() {
       	@Override
       	public void widgetSelected(SelectionEvent e) {
       		onSave();
       	}
       });
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

	protected void onCreateLabels() {
		try {
			BASICSourceViewer editor = getEditor();
			String filename = getFilename(editor);
			if (!filename.toLowerCase().endsWith(".bas")) return;
			String source = editor.getText();
			CBASICPreparser pp = new CBASICPreparser();
			source = pp.createLabels(source);
			editor = createStyledText();
		    setFilename(filename);
			editor.setText(source);
					
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	// TODO Auto-generated method stub
	
}

	protected void onTabChanged() {
		try {
		BASICSourceViewer editor=getEditor();
		String filename = getFilename(editor);
		if (filename == null) return;
		Path path = Path.of(filename);
		try {
		if (filename == null)
			tree.removeAll();
		else 
			if (path != null) {
				if (path.getParent() != null) 
					mFileSystemPopulator.populateTree(path.getParent().toString());
			}
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		
		
		
		mSetLabels = new TreeSet<String>();
		updateLabels();
		listNav.removeAll();
		for (String s:mSetLabels)
			listNav.add(s);
		}
		catch(Exception e)  {
			e.printStackTrace();
		}
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
		mMapLabels.clear();
		BASICSourceViewer editor = getEditor();
		if (editor == null) return false;
		String lines[] = editor.getText().split("\n");
		TreeSet<String> tempSet = new TreeSet<String>();
		for (String s: mSetLabels)
			tempSet.add(s);
		System.out.println(String.format("set = %d, temp=%d",mSetLabels.size(), tempSet.size()));
		int iLine=-1;
		for (String line: lines) {
			line = line.trim();
			iLine++;
			if (line.startsWith("#")) {
				if (!mSetLabels.contains(line)) {
					dirty = true;
					mSetLabels.add(line);
				}
				tempSet.remove(line);
				mMapLabels.put(line, Integer.valueOf(iLine));
				continue;
			}
			if (line.startsWith("PROC ") || line.startsWith("SUB ") || line.startsWith("PROCEDURE ")) {
				int p = line.indexOf(' ');
				if (p != -1) {
					String label = line.substring(p+1);
					p = label.indexOf('(');
					if (p != -1) label = label.substring(0,p);
					if (!mSetLabels.contains(label)) {
						dirty = true;
						mSetLabels.add(label);
					}
					tempSet.remove(label);
					mMapLabels.put(label, Integer.valueOf(iLine));
					continue;
					
				}
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
		BASICSourceViewer editor = getEditor();
		String text="";
		if (editor != null) text = editor.getText();
		CDialogSpriteEditor dlg;
		try {
			Shell sh = new Shell(display, SWT.DIALOG_TRIM | SWT.MODELESS);
			dlg = new CDialogSpriteEditor(sh, getStyle());
			dlg.mText = text;
			dlg.open(new CUdgMatrixData());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

	protected void onCompiler() {
		onSaveAll();
		StringBuilder plog = new StringBuilder();
		CBASICPreparser pp = new CBASICPreparser();
		BASICSourceViewer editor1=getEditor();
		String filename = getFilename(editor1);
		if (filename == null) return;
		if (filename.toLowerCase().endsWith(".asm")) return;


		String text = editor1.getText()+"\r\n stop\r\n";
		TreeSet<String> defines = new TreeSet<String>();
		defines.add("COMPILER");
		defines.add("ZXSPECTRUM");

		text = pp.preparse(filename, plog, text,defines);
		editor = createStyledText("emulator.bas");
		editor.setText(text);
		
		
		CBASICTokenizer tokenizer = new CBASICTokenizer();
		try {
			byte[] code = tokenizer.tokenize(text,5);
			ZXCompiler compiler = new ZXCompiler();
			CSettings set = CSettings.instance();
			compiler.mSettingCompileDebug = false;
			compiler.mSettingLineNr = false;
			compiler.mSettingOptimize = 1;
			compiler.mSettingStop = 2;
			compiler.start(code);
			compiler.compile();
			String compiledBasic = CSettings.instance().mAsmOutput;
			compiler.writeCode(compiledBasic);
			BASICSourceViewer asmEditor=createStyledText("compiledBasic.asm", true);
			asmEditor.setText(compiler.mEmitter.sbCode.toString());
			StringBuilder sbbat = new StringBuilder();
			String path = set.mTapFile;
			int p = path.lastIndexOf('\\');
			if (p == -1) p = path.lastIndexOf(File.separator);
			if (p == -1) return;
			path = path.substring(0,p);
			String logfile = path+"\\log.txt";
			String compileBat = path+"\\compileRun.bat";
			StringBuilder sbCompileBat = new StringBuilder();
			sbCompileBat.append(String.format("cd \"%s\"\n",path));
			sbCompileBat.append(String.format("del \"%s\"\n",set.mTapFile));
			sbCompileBat.append(String.format("\"%s\" \"%s\" 2> \"%s\"\n", set.mAssembler, set.mMainAsm, logfile));
			sbCompileBat.append(String.format("start \"%s\" \"%s\"\n", set.mEmulator, set.mTapFile));
			sbCompileBat.append(String.format("pause\n" ));
			Tools.writeTextFile(compileBat,  sbCompileBat.toString());
			//StyledText editLog = createStyledText("log");
			//editLog.setText(compiler.mEmitter.mSBLog.toString());
			
			//Tools.executeCommand(String.format("cmd /C \"start %s\"", compileBat), shlZxBasic);
			System.out.println("Starting "+compileBat);
			try {
	            Runtime.getRuntime().exec(String.format("cmd.exe /c \"%s\"", compileBat));
	        } catch (IOException e) {
	            e.printStackTrace();
	        }
			String log = Tools.loadTextFile(logfile);
			
			String clog = plog.toString()+"\n"+ compiler.mEmitter.mSBLog.toString();
			if (log != null)
				clog += "\n\n"+log;
			textlog.setText(clog);

			
			
			
					
		
			
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
				
	}

	protected void onNew() {
		BASICSourceViewer edit = createStyledText();
		//edit.setData(null);
		// TODO Auto-generated method stub
		
	}
	
	protected void onSaveAll() {
		onSave();
	}
	protected void onSave() {
		
		BASICSourceViewer editor=getEditor();
		if (editor == null) {
			onSavesAs();
			return;
		}
		String filename = getFilename(editor);
		if (filename == null) 
			onSavesAs();
		else
			save(filename);
			
	}
	

	private void save(String filename) {
		BASICSourceViewer editor = getEditor();
		String text = editor.getText();
		Tools.writeTextFile(filename.trim(), text);
		
	}

	private BASICSourceViewer getEditor() {
		CTabItem item = mTabFolder.getSelection();
		Control ctrl = item.getControl();
		if (ctrl instanceof Composite)
			return (BASICSourceViewer)ctrl.getData();
		return null;
	}

	protected void onSavesAs() {
		BASICSourceViewer editor = getEditor();
		if (editor == null) return;
		String[] filterExt = { "*.bas" };
		FileDialog fd = new FileDialog(shlZxBasic, SWT.OPEN);
		fd.setText("Open basic program");
		fd.setFilterExtensions(filterExt);
		String filename = fd.open();
		if (filename == null) return;
		addFilenameToEditor(editor, filename);
		setFilename(filename);
		
		save(filename);
		
		
	}

	protected void onOpenFile() {
		String[] filterExt = { "*.bas","*.tap" };
		FileDialog fd = new FileDialog(shlZxBasic, SWT.OPEN);
		fd.setText("Open basic program");
		fd.setFilterExtensions(filterExt);
		mFilename = fd.open();
		if (mFilename.toLowerCase().endsWith(".tap")) {
			loadTapFile();
			return;
		}
		if (mFilename == null)
			return;
		loadFile(mFilename);
		setAutoload();
		
	}


	private void loadTapFile() {
		CDialogTape  dlg = new CDialogTape(shlZxBasic, getStyle());
		dlg.mFilename = mFilename;
		dlg.open();
		if (dlg.mSource != null) {
			BASICSourceViewer editor = createStyledText();
			editor.setText(dlg.mSource);
		}
		
	}

	private void setAutoload() {
		StringBuilder sb = new StringBuilder();
		sb.append("folder=" + mFolder + "\n");
		for (CTabItem item : mTabFolder.getItems()) {
			if (item.getControl() instanceof Composite) {
				BASICSourceViewer viewer = (BASICSourceViewer)item.getControl().getData();
				if (viewer != null) {
					if (viewer.getEditManager() != null) {
						String fname = viewer.getEditManager().getFilename();
						if (fname != null)
							sb.append("file=" + fname + "\n");
					}
				}
			}
		}

		Tools.writeTextFile(CSettings.appData("autoload.inf"), sb.toString());
		
	}

	private void loadFile(String fname) {
		fname=fname.trim();
		String strSource = Tools.loadTextFile(fname.trim());
		if (strSource == null)
			return;
		File file = new File(fname);
		BASICSourceViewer text = createStyledText(fname);
		addFilenameToEditor(text, fname);
		text.setText(strSource);		
	}
	
	private BASICSourceViewer createStyledText() {
		return createStyledText("new");
	}

	private BASICSourceViewer createStyledText(String fname) {
		return createStyledText(fname, false);
	}
	private BASICSourceViewer createStyledText(String fname, boolean z80) {
		CTabItem[] items = mTabFolder.getItems();
		for (CTabItem item:items) {
			String name = item.getText().trim();
			if (name.compareTo(fname) == 0) {
				Control ctrl = item.getControl();
				if (ctrl instanceof Composite)  return (BASICSourceViewer)ctrl.getData();				
			}
		}
		
		
		
		 CTabItem item1 = new CTabItem(mTabFolder, SWT.CLOSE);
		 mTabFolder.setSelection(item1);
		 item1.setData(fname);
		item1.setText(filenameOf(fname));
		//StyledText text = new StyledText(mTabFolder, SWT.BORDER | SWT.H_SCROLL | SWT.V_SCROLL | SWT.CANCEL | SWT.MULTI);
		Composite composite = new Composite(mTabFolder, SWT.NONE);
		composite.setLayout(new FillLayout());
		BASICSourceViewer viewer = new BASICSourceViewer(shlZxBasic,  composite, SWT.BORDER | SWT.H_SCROLL | SWT.V_SCROLL | SWT.CANCEL | SWT.MULTI, mZXToken);
		StyledText text = viewer.getTextWidget();
		
		composite.setData(viewer);
		new EditManager(text, fname);
		item1.setControl(composite);
		text.addModifyListener(new ModifyListener() {
			public void modifyText(ModifyEvent e) {
				onModifyText(e);
			}
		});

		text.addLineStyleListener(mBasicLineStyler);
		if (z80) mBasicLineStyler.initializeZ80();

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
		return viewer;

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


	
	/*
	StyledText newEditor() {
		
        editor = new StyledText(mTabFolder, SWT.BORDER | SWT.V_SCROLL | SWT.H_SCROLL);
        editor.addLineStyleListener(mBasicLineStyler );
        //mTabFolder.setSelection(item);

        return editor;
	}
	*/

	protected void onEmulator() {
		try {
			onSaveAll();
			StringBuilder plog = new StringBuilder();
			System.out.println("OnEmulator");
			BASICSourceViewer editor1=getEditor();
			String filename = getFilename(editor1);
			if (filename.toLowerCase().endsWith(".asm")) return;
			
			CBASICPreparser cpp = new CBASICPreparser();
			//BasicPreparser pp = new BasicPreparser();
			String text = editor1.getText();
			
			System.out.println("Preparsing");
			TreeSet<String> defines = new TreeSet<String>();
			defines.add("BASIC");
			defines.add("ZXSPECTRUM");
			text = cpp.preparse(filename,plog,text,defines);
			BASICSourceViewer editor = createStyledText("emulator.bas");
			System.out.println("emulator.bas ready");

			editor.setText(text);;
			textlog.setText(plog.toString());
			 
			System.out.println("Tokenizing");
			CBASICTokenizer tokenizer = new CBASICTokenizer();
			try {
				CSettings set = CSettings.instance();
				ZXBasicFileWriter tapWrite= new ZXBasicFileWriter();
				byte[] code = tokenizer.tokenize(text,0);
				System.out.println("Writing tape");
				//ZXTapWriter tapWrite = new ZXTapWriter();
				
				
				if (filename == null) filename = "basic.bas";
				String tapFilename = filename.trim()+".tap";
				tapWrite.writeZXBasic(tapFilename, "basic", code, 1000);
				String path = tapFilename;
				int p = path.lastIndexOf('\\');
				if (p == -1) p = path.lastIndexOf("/");
				if (p == -1) return;
				path = path.substring(0,p);
				System.out.println("Writing bat");
				
				String compileBat = path+"\\runemulator.bat";
				StringBuilder sbCompileBat = new StringBuilder();
				sbCompileBat.append(String.format("cd \"%s\"\n",path));
				sbCompileBat.append(String.format("start \"%s\" \"%s\"\n", set.mEmulator, tapFilename));
				sbCompileBat.append(String.format("pause\n" ));
				Tools.writeTextFile(compileBat,  sbCompileBat.toString());
				//StyledText editLog = createStyledText("log");
				//editLog.setText(compiler.mEmitter.mSBLog.toString());
				
				//Tools.executeCommand(String.format("cmd /C \"start %s\"", compileBat), shlZxBasic);
				System.out.println("Starting "+compileBat);
				try {
		            Runtime.getRuntime().exec(String.format("cmd.exe /c \"%s\"", compileBat));
		        } catch (IOException e) {
		            e.printStackTrace();
		        }
				
				//tapWrite.writeBasicTap(filename.trim()+".tap", "hello", code, 128*256);
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
		BASICSourceViewer editor=getEditor();
		addFilenameToEditor(editor, string);
		mTabFolder.getSelection().setText(string);
	}
	
	private Path getFilenamePath(BASICSourceViewer editor) {
		EditManager man = editor.getEditManager();
		if (man != null) Path.of( man.getFilename());
		return null;
	}

	private String getFilename(BASICSourceViewer editor) {
		EditManager man = editor.getEditManager();
		if (man != null) return man.getFilename();
		return null;
	}
	
	  private void addFilenameToEditor(BASICSourceViewer editor, String string) {
		EditManager man = (EditManager) editor.getEditManager();
		if (man == null) {
			man = new EditManager(editor.getTextWidget(), string);
			editor.setEditManager(man);
		} else
			man.setFilename(string);
		
		
	}

}
