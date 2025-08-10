package main.spriteed;

import org.eclipse.swt.widgets.Dialog;
import org.eclipse.swt.widgets.Display;
import org.eclipse.swt.widgets.Shell;
import org.eclipse.swt.widgets.Composite;

import java.util.ArrayList;
import java.util.TreeMap;

import org.eclipse.swt.SWT;
import org.eclipse.swt.custom.StyledText;
import org.eclipse.swt.events.PaintListener;
import org.eclipse.swt.graphics.Color;
import org.eclipse.swt.graphics.Rectangle;
import org.eclipse.swt.events.MouseEvent;
import org.eclipse.swt.events.MouseListener;
import org.eclipse.swt.events.PaintEvent;
import org.eclipse.swt.widgets.Button;
import org.eclipse.swt.widgets.Combo;
import org.eclipse.swt.widgets.Text;

import main.CDialogMessage;

import org.eclipse.swt.events.ModifyListener;
import org.eclipse.swt.events.ModifyEvent;
import org.eclipse.swt.events.SelectionAdapter;
import org.eclipse.swt.events.SelectionEvent;
import org.eclipse.swt.events.ControlAdapter;
import org.eclipse.swt.events.ControlEvent;
import org.eclipse.swt.widgets.Label;
import org.eclipse.swt.widgets.Canvas;

public class CDialogSpriteEditor extends Dialog {

	protected Object result;
	protected Shell shell;
	private CSpriteCanvas mCanvas;
	private Button mBtnShowAs8x8;
	private Button mBtnShowBitmaps;
	private CCanvasSpriteMatrix mCanvasSpriteView;
	private TreeMap<Integer, String> mLabels = new TreeMap<>();
	private Combo mComboTileset;
	public CResources mResources = new CResources();
	int[] mSpriteData = new int[16];
	//int spriteHeight = 0;			// 0 = 16x16
	//int mBasePos=0;
	private Text mTextHex;
	private boolean mParse = true;
	private CSpriteData mCurSprite;
	private CDialogSpriteEditor mSpriteEditor;
	Combo comboNumColumns;
	Combo comboNumRows;
	public ICanvasSpriteMatrixData mMatrixData;
	public String mText;
	private boolean mInUpdate=false;
	
	public void readSourcefile(StyledText editor) {
		mResources = new CResources();
		mResources.readSourcecode(editor);
	}

	/**
	 * Create the dialog.
	 * @param parent
	 * @param style
	 */
	public CDialogSpriteEditor(Shell parent, int style) {
		super(parent, style);
		setText("SWT Dialog");
	}

	/**
	 * Open the dialog.
	 * @return the result
	 */
	public Object open(ICanvasSpriteMatrixData matrixData) {
		createContents();
		mMatrixData = matrixData;
		fillCombo();
		updateText();
		
		Label lblTileset = new Label(shell, SWT.NONE);
		lblTileset.setBounds(463, 10, 55, 15);
		lblTileset.setText("Tileset");
		
		Button btnNewButton = new Button(shell, SWT.NONE);
		btnNewButton.addSelectionListener(new SelectionAdapter() {
			@Override
			public void widgetSelected(SelectionEvent e) {
				onSaveToEditor();
			}
		});
		btnNewButton.setBounds(463, 216, 75, 25);
		btnNewButton.setText("Save");
		
		mCanvasSpriteView = new CCanvasSpriteMatrix(shell, SWT.BORDER);
		
		mCanvasSpriteView.setBounds(688, 30, 232, 312);
		mCanvasSpriteView.setBackground(null);
		mCanvas.setMatrixData(matrixData);
		mCanvasSpriteView.setData(matrixData, new ISpriteCanvasData() {
			
			@Override
			public void updateText() {
				// TODO Auto-generated method stub
				
			}
			
			@Override
			public void setSpriteWord(int bytepos, int word) {
				// TODO Auto-generated method stub
				
			}
			
			@Override
			public void setSpriteByte(int bytepos, int newbyte) {
				// TODO Auto-generated method stub
				
			}
			
			@Override
			public void onSpriteSelected(int pos) {
				mCanvas.mBytes = mMatrixData.getFlatData(pos);
				mCanvas.mOffset = pos;
				mCanvas.redraw();
				
			}
			
			@Override
			public int getSpriteWord(int bytepos) {
				// TODO Auto-generated method stub
				return 0;
			}
			
			@Override
			public int getSpriteByte(int bytepos) {
				mCanvas.mOffset = bytepos;
				mCanvas.redraw();
				updateTitle();
				return 0;
			}
		});
		
				
		
		
		Label lblX = new Label(shell, SWT.NONE);
		lblX.setBounds(523, 255, 20, 15);
		lblX.setText("x");
		
		comboNumColumns= new Combo(shell, SWT.NONE);
		comboNumColumns.addModifyListener(new ModifyListener() {
			public void modifyText(ModifyEvent e) {
				try {
					int columns = Integer.parseInt(comboNumColumns.getText())*8;
					mMatrixData.setTileW(columns);
					mCanvas.setColumns(columns);
				}
				catch(Exception xx) 
			{
					
				}
			}
		});
		comboNumColumns.setItems(new String[] {"1", "2", "3", "4", "5", "6"});
		comboNumColumns.setBounds(473, 247, 46, 23);
		comboNumColumns.setText("1");
		
		
		comboNumRows= new Combo(shell, SWT.NONE);
		comboNumRows.addModifyListener(new ModifyListener() {
			public void modifyText(ModifyEvent e) {
				try {
					int rows = Integer.parseInt(comboNumRows.getText())*8;
					mMatrixData.setTileH(rows);
					mCanvas.setRows(rows);
				}
				catch(Exception xx) 
				{
					
				}
				
			}
		});
		comboNumRows.setItems(new String[] {"1", "2", "3", "4", "5", "6"});
		comboNumRows.setBounds(544, 247, 36, 23);
		comboNumRows.setText("1");
		
		
		mTextHex.setText(mText);
		shell.open();
		shell.layout();
		Display display = getParent().getDisplay();
		while (!shell.isDisposed()) {
			if (!display.readAndDispatch()) {
				display.sleep();
			}
		}
		return result;
	}

	protected void onSaveToEditor() {
		if (mCurSprite != null) {
			mCurSprite.setText(mTextHex.getText());
			if (mResources.save(mCurSprite) == false) {
				CDialogMessage dlg = new CDialogMessage(shell, SWT.TITLE);
				dlg.text = "Error saving icons\nPlase update source file\nmanually";
				dlg.open();
			}
			
		}
		// TODO Auto-generated method stub
		
	}

	protected void onComboSpriteSetSelected() {
		int index = mComboTileset.getSelectionIndex();
		if (index != -1) {
			CSpriteData data = mResources.mSprites.get(index);
			
			mCurSprite = data;
			// todo implement
			mTextHex.setText(data.getText());
			
		}
		
		
	}

	protected void onResize() {
		if (mTextHex == null) return;
		Rectangle bounds = shell.getBounds();
		Rectangle rectText = mTextHex.getBounds();
		mTextHex.setBounds(rectText.x, rectText.y, bounds.width-40, bounds.height-40-rectText.y);
				
		
	}

	private void fillCombo() {
		
		for (CSpriteData data: mResources.mSprites) {
			mComboTileset.add(data.toString());
		}
		
	}

	/**
	 * Create contents of the dialog.
	 */
	private void createContents() {
		mSpriteEditor = this;
		shell = new Shell(getParent(), getStyle());
		shell.addControlListener(new ControlAdapter() {
			@Override
			public void controlResized(ControlEvent e) {
				onResize();
			}
		});
		shell.setSize(947, 561);
		shell.setText(getText());
		
		mCanvas = new CSpriteCanvas(shell, SWT.NONE);
		mCanvas.mReadonly = false;
		
		mCanvas.setData(new main.spriteed.ISpriteCanvasData() {
			
			@Override
			public void updateText() {
				mSpriteEditor.updateText();
				mCanvasSpriteView.redraw();
				
			}
			
			@Override
			public void setSpriteWord(int bytepos, int word) {
				mSpriteEditor.setSpriteWord(bytepos, word);
				
			}
			
			@Override
			public void setSpriteByte(int bytepos, int newbyte) {
				mSpriteEditor.setSpriteByte(bytepos, newbyte);
				
			}
			
			@Override
			public int getSpriteWord(int bytepos) {
				return mSpriteEditor.getSpriteWord(bytepos);
			}
			
			@Override
			public int getSpriteByte(int bytepos) {
				return mSpriteEditor.getSpriteByte(bytepos);
			}

			@Override
			public void onSpriteSelected(int pos) {
				System.out.println("onSpriteSelected");
				
			}
		});
		mCanvas.setBounds(10, 10, 437, 332);
		
		Button btnShiftLeft = new Button(shell, SWT.NONE);
		btnShiftLeft.addSelectionListener(new SelectionAdapter() {
			@Override
			public void widgetSelected(SelectionEvent e) {
				shiftLeft();
			}
		});
		btnShiftLeft.setBounds(463, 64, 75, 25);
		btnShiftLeft.setText("Shift left");
		
		Button buttonShiftRight = new Button(shell, SWT.NONE);
		buttonShiftRight.addSelectionListener(new SelectionAdapter() {
			@Override
			public void widgetSelected(SelectionEvent e) {
				shiftRight();
			}
		});
		buttonShiftRight.setText("Shift right");
		buttonShiftRight.setBounds(544, 64, 75, 25);
		
		Button buttonShiftUp = new Button(shell, SWT.NONE);
		buttonShiftUp.addSelectionListener(new SelectionAdapter() {
			@Override
			public void widgetSelected(SelectionEvent e) {
				onShiftUp();
			}
		});
		buttonShiftUp.setText("Shift up");
		buttonShiftUp.setBounds(463, 95, 75, 25);
		
		Button btnShiftDown = new Button(shell, SWT.NONE);
		btnShiftDown.addSelectionListener(new SelectionAdapter() {
			@Override
			public void widgetSelected(SelectionEvent e) {
				onShiftDown();
			}
		});
		btnShiftDown.setText("Shift down");
		btnShiftDown.setBounds(544, 95, 75, 25);
		
		Button btnFlipHorizontal = new Button(shell, SWT.NONE);
		btnFlipHorizontal.addSelectionListener(new SelectionAdapter() {
			@Override
			public void widgetSelected(SelectionEvent e) {
				flipH();
			}
		});
		btnFlipHorizontal.setText("flip h");
		btnFlipHorizontal.setBounds(463, 126, 75, 25);
		
		Button btnFlipW = new Button(shell, SWT.NONE);
		btnFlipW.addSelectionListener(new SelectionAdapter() {
			@Override
			public void widgetSelected(SelectionEvent e) {
				flipW();
			}
		});
		btnFlipW.setText("flip w");
		btnFlipW.setBounds(544, 126, 75, 25);
		
		mBtnShowAs8x8 = new Button(shell, SWT.CHECK);
		mBtnShowAs8x8.addSelectionListener(new SelectionAdapter() {
			@Override
			public void widgetSelected(SelectionEvent e) {
				updateText();
			}
		});
		mBtnShowAs8x8.setBounds(463, 296, 212, 16);
		mBtnShowAs8x8.setText("Show 16x16 Sprite as 4*8x8 Sprites");
		
		Button btnNext = new Button(shell, SWT.NONE);
		btnNext.addSelectionListener(new SelectionAdapter() {
			@Override
			public void widgetSelected(SelectionEvent e) {
				prevSprite();
			}
		});
		btnNext.setBounds(463, 157, 75, 25);
		btnNext.setText("<<");
		
		Button btnNext_1 = new Button(shell, SWT.NONE);
		btnNext_1.addSelectionListener(new SelectionAdapter() {
			@Override
			public void widgetSelected(SelectionEvent e) {
				nextSprite();
			}
		});
		btnNext_1.setText(">>");
		btnNext_1.setBounds(544, 157, 75, 25);
		
		Button btnNew = new Button(shell, SWT.NONE);
		btnNew.addSelectionListener(new SelectionAdapter() {
			@Override
			public void widgetSelected(SelectionEvent e) {
				onNewSprite();
			}
		});
		btnNew.setText("New");
		btnNew.setBounds(463, 188, 75, 25);
		
		Button btnCopy = new Button(shell, SWT.NONE);
		btnCopy.addSelectionListener(new SelectionAdapter() {
			@Override
			public void widgetSelected(SelectionEvent e) {
				onCopySprite();
			}
		});
		btnCopy.setText("Copy");
		btnCopy.setBounds(544, 188, 75, 25);
		
		mTextHex = new Text(shell, SWT.BORDER | SWT.H_SCROLL | SWT.V_SCROLL | SWT.CANCEL | SWT.MULTI);
		mTextHex.addModifyListener(new ModifyListener() {
			public void modifyText(ModifyEvent e) {
				if (!mInUpdate)
					parseText(mTextHex.getText()+" ");
			}
		});
	//	mTextHex.setFont(SWTResourceManager.getFont("Courier New", 9, SWT.NORMAL));
		mTextHex.setBounds(10, 348, 910, 170);
		
		mBtnShowBitmaps = new Button(shell, SWT.CHECK);
		mBtnShowBitmaps.addSelectionListener(new SelectionAdapter() {
			@Override
			public void widgetSelected(SelectionEvent e) {
				updateText();
			}
		});
		mBtnShowBitmaps.setBounds(463, 318, 93, 16);
		mBtnShowBitmaps.setText("Show Bitmaps");
		
		mComboTileset = new Combo(shell, SWT.NONE);
		mComboTileset.addSelectionListener(new SelectionAdapter() {
			@Override
			public void widgetSelected(SelectionEvent e) {
				onComboSpriteSetSelected();
			}
		});
		mComboTileset.setBounds(465, 30, 210, 28);



	}

	protected void onCopySprite() {
		int rows = mCanvas.getGridHeight();
		int bytes = mCanvas.getGridWidth()/8;
		int pos = addNewBytes(rows*bytes);
		for (int i=0;i<rows*bytes;i++) {
			mSpriteData[pos+i] = mSpriteData[mCanvas.mOffset+i];
		}
		mCanvas.mOffset = pos;
		updateText();
		mCanvas.redraw();
		
	}

	private int addNewBytes(int newBytes) {
		int r = mSpriteData.length;
		int temp[] = new int[r+newBytes];
		for (int i = 0;i<r;i++) {
			temp[i] = mSpriteData[i];
		}
		mSpriteData = temp;
		return r;
	}

	protected void onNewSprite() {
		int rows = mCanvas.getGridHeight();
		int bytes = mCanvas.getGridWidth()/8;
		int pos = addNewBytes(rows*bytes);
		mCanvas.mOffset = pos;
		updateText();
		mCanvas.redraw();
		
	}

	protected void onShiftDown() {
		mInUpdate = true;
		mCanvas.onShiftDown();
		mInUpdate = false;
	}

	protected void onShiftUp() {
		mInUpdate = true;
		mCanvas.onShiftUp();
		mInUpdate = false;
	}

	protected void flipW() {
		mInUpdate = true;
		mCanvas.flipW();
		mInUpdate = false;
	}

	protected void flipH() {
		mInUpdate = true;
		mCanvas.flipH();
		mInUpdate = false;
	}
	
	int reverse(int b) {
		int r =0;
		int bit = 1;
		for (int i=1;i<=8;i++) {
			int nextbit = (b & bit) != 0 ? 1 : 0;
			r = r+r+nextbit;
			bit = bit << 1;
		}
		
		return r;
	}

	protected void nextSprite() {
		int ofs = mCanvas.getGridHeight();
		if (mCanvas.mOffset + ofs < mSpriteData.length) {
			mCanvas.mOffset += ofs;
		} else
			mCanvas.mOffset = 0;
		mCanvas.redraw();
		updateTitle();
		
	}

	private void updateTitle() {
		int size = mCanvas.getGridHeight() * mCanvas.getGridWidth()/8;
		int ofs =  mCanvas.getGridHeight() * mCanvas.getGridWidth()/8;
		int sprite = mCanvas.mOffset / size;
		String label = mLabels.get(mCanvas.mOffset);
		if (label == null) label = "";
		shell.setText(String.format("Sprite %d/%d pos %d %s",sprite, mSpriteData.length/ofs, mCanvas.mOffset, label));
		
		
	}

	protected void prevSprite() {
		int ofs = mCanvas.getSpriteSize();
		if (mCanvas.mOffset - ofs > 0) {
			mCanvas.mOffset -= ofs;
		} else {
			mCanvas.mOffset = mSpriteData.length-ofs;
		}
		mCanvas.redraw();
		updateTitle();
	}

	protected void shiftRight() {
		mInUpdate = true;
		mCanvas.shiftRight();
		mInUpdate = false;
	}

	protected void shiftLeft() {
		mInUpdate = true;
		mCanvas.shiftLeft();
		mInUpdate = false;
	}

	
	private void setSpriteByte(int pos, int data) {
		if (mSpriteData.length < pos+1) {
			int newbytes[] = new int[pos+1];
			for (int i=0;i<mSpriteData.length;i++) 
				newbytes[i] = mSpriteData[i];
			mSpriteData = newbytes;
			
		}
		
		mSpriteData[pos] = data;
		
	}

	int getSpriteByte(int pos) {
		try {
			return pos < mSpriteData.length ? mSpriteData[pos] : 0;
		} catch(Exception ex) {
			ex.printStackTrace();
			return 0;
		}
	}
	
	int getSpriteWord(int pos) {
		int r = getSpriteByte(pos) << 8; 
		r |=  getSpriteByte(pos+1);
		return r;
	}
	
	void setSpriteWord(int pos, int word) {
		setSpriteByte(pos, word >> 8);
		setSpriteByte(pos+1, word & 0xff);
		
	}
	
	String createText() {
		return mMatrixData.toString();
	}
	
	private Object hex16Bin(int left, int right) {
		int word = left*256+right;
		String r = Integer.toString(word, 2).replace('0', ' ').replace('1', '#');
		while (r.length() < 16) r = " "+r;
		return r;
	}
	
	private Object hex8Bin(int b) {
		String r = Integer.toString(b, 2).replace('0', ' ').replace('1', '#');
		while (r.length() < 8) r = " "+r;
		return r;
	}

	private Object sprite8from16(int pos) {
		String str = "";
		if (mBtnShowBitmaps.getSelection()) {
			for (int i=0;i<8;i++) {
				int b = getSpriteByte(pos++);
				pos++;
				str += String.format("  %02x\t#\t%s\n",b, hex8Bin(b));
			}
			
		}
		for (int i=0;i<8;i++) {
			if (i != 0) str += " ";
			str += toHex(getSpriteByte(pos));
			pos+=2;
		}
		
		return str;
	}


	void updateText() {
		mParse = false;
		String text = createText(); 
		if (mCurSprite != null)
			mCurSprite.setText(text);
		mTextHex.setText(text);
		mParse = true;
	}

	private String toHex(int spriteByte) {
		return String.format("0x%02x", spriteByte);
	}
	
	void parseText(String text) {
		mMatrixData.parseText(text);
		mCanvas.mBytes = mMatrixData.getFlatData(0);
		if (mCanvasSpriteView != null)
			mCanvasSpriteView.redraw();
		mCanvas.redraw();
		
	}

	private int readDez(String literal) {
		int r =0;
		try {
			r = Integer.parseInt(literal, 10);
 		} catch(Exception e) {
 			
 		}
		return r;
	}

	private int readHex(String literal) {
		int r =0;
		try {
			r = Integer.parseInt(literal, 16);
 		} catch(Exception e) {
 			
 		}
		return r;
	}
}
