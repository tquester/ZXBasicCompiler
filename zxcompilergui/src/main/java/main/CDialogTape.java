package main;

import org.eclipse.swt.widgets.Dialog;
import org.eclipse.swt.widgets.Display;
import org.eclipse.swt.widgets.Shell;

import zxcompiler.ZXTape;
import zxcompiler.ZXTape.TapeEntry;
import zxcompiler.ZXTokenizer;
import zxcompiler.ZXTokenizer.ZXBasicLine;

import org.eclipse.swt.widgets.List;
import org.eclipse.swt.SWT;
import org.eclipse.swt.widgets.Button;
import org.eclipse.swt.events.SelectionAdapter;
import org.eclipse.swt.events.SelectionEvent;

public class CDialogTape extends Dialog {

	protected Object result;
	protected Shell shlLoadFromTape;
	public String mFilename;
	public String mSource = null;
	public ZXTape mTape = new ZXTape();
	List list;

	/**
	 * Create the dialog.
	 * @param parent
	 * @param style
	 */
	public CDialogTape(Shell parent, int style) {
		super(parent, style);
		setText("SWT Dialog");
	}

	/**
	 * Open the dialog.
	 * @return the result
	 */
	public Object open() {
		createContents();
		shlLoadFromTape.open();
		shlLoadFromTape.layout();
		mTape.load(mFilename);
		int i=0;
		if (mTape.mTapeEntries != null) {
			for (TapeEntry entry: mTape.mTapeEntries) {
				list.add(entry.name,i++);
			}
		}
		
		Display display = getParent().getDisplay();
		while (!shlLoadFromTape.isDisposed()) {
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
		shlLoadFromTape = new Shell(getParent(), getStyle());
		shlLoadFromTape.setSize(554, 717);
		shlLoadFromTape.setText("Load from Tape");
		
		list = new List(shlLoadFromTape, SWT.BORDER);
		list.setBounds(10, 10, 422, 650);
		
		Button btnLoad = new Button(shlLoadFromTape, SWT.NONE);
		btnLoad.addSelectionListener(new SelectionAdapter() {
			@Override
			public void widgetSelected(SelectionEvent e) {
				onLoad();
			}
		});
		btnLoad.setBounds(438, 10, 90, 30);
		btnLoad.setText("Load");

	}

	protected void onLoad() {
		StringBuilder sb = new StringBuilder();
		int sel = list.getSelectionIndex();
		if (sel == -1) return;
		if (mTape.mTapeEntries == null) return;
		ZXBasicLine bline = new ZXBasicLine();
		try {
			TapeEntry tapeEntry = mTape.mTapeEntries.get(sel);
			ZXTokenizer tokenizer = new ZXTokenizer();
			tokenizer.init(tapeEntry.data,true);
			while (tokenizer.getLine(bline)) {
				String line = bline.toString(false,true,false);
				System.out.println(line);
				sb.append(line+"\n");
			}
			mSource = sb.toString();
			shlLoadFromTape.close();
		
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
	}
}
