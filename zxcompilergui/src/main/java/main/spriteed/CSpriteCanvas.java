package main.spriteed;

import org.eclipse.swt.widgets.Composite;
import org.eclipse.swt.widgets.Display;
import org.eclipse.swt.widgets.Canvas;
import org.eclipse.swt.SWT;
import org.eclipse.swt.events.ControlAdapter;
import org.eclipse.swt.events.ControlEvent;
import org.eclipse.swt.graphics.Color;
import org.eclipse.swt.graphics.Rectangle;
import org.eclipse.swt.events.PaintListener;
import org.eclipse.swt.events.PaintEvent;
import org.eclipse.swt.events.MouseAdapter;
import org.eclipse.swt.events.MouseEvent;

public class CSpriteCanvas extends Composite {
	
	
	public byte[] mBytes=null;
	public int mGridHeight=8;
	public int mGridWidth=8;
			
	public int mOffset=0;
	public boolean mReadonly=true;
	public ISpriteCanvasData mSpriteCanvasData = null;
	private ICanvasSpriteMatrixData mMatrixData;
	
	
	/**
	 * Create the composite.
	 * @param parent
	 * @param style
	 */
	public CSpriteCanvas(Composite parent, int style) {
		super(parent, style);
		addMouseListener(new MouseAdapter() {
			@Override
			public void mouseDown(MouseEvent e) {
				onMouseDown(e);
			}
		});
		addPaintListener(new PaintListener() {
			public void paintControl(PaintEvent e) {
				onPaint(e);
			}
		});
		

	}
	public void setData(ISpriteCanvasData data) {
		mSpriteCanvasData= data;
	}
	
	public void setTile(int tile) {			// either an udg or a sprite
		mBytes = mMatrixData.getFlatData(tile);
	}
	

	


	protected void onPaint(PaintEvent e) {

		Rectangle bounds = getBounds();
		Display display = getParent().getDisplay();
		
	    Color white = display.getSystemColor(SWT.COLOR_WHITE);
	    Color black = display.getSystemColor(SWT.COLOR_BLACK);
	    Color gray1 = display.getSystemColor(SWT.COLOR_GRAY);
	    Color gray2 = display.getSystemColor(SWT.COLOR_DARK_GRAY);
	    Color red = display.getSystemColor(SWT.COLOR_RED);
		
	    int width = mGridWidth;
	    int height = mGridHeight;
		int x = 0;
		int y = 0;
		int dx = bounds.width / width;
		int dy = bounds.height / height;
		int w = dx * 16;
		if (height > width) {
			dx = dy;
			w = dx * 8;
		}
		int h = dy * height;
		for (int i = 0; i < width+1; i++) {
			if (i == 8) {
				e.gc.setForeground(black);
			} else {
				if ((i & 3) == 0) {
					e.gc.setForeground(gray2);
				} else
					e.gc.setForeground(gray1);
			}
			e.gc.drawLine(x, 0, x, h);
	
			x += dx;
		}
		for (int i = 0; i < height+1; i++) {
			if (i == 8) {
				e.gc.setForeground(black);
			} else {
				if ((i & 3) == 0) {
					e.gc.setForeground(gray2);
				} else
					e.gc.setForeground(gray1);
			}			
			e.gc.drawLine(0, y, w, y);
			y += dy;
		}
		int bytepos = 0;
		
		y = 0;
		int spheight = mGridHeight;
		
		for (int iy = 0; iy < spheight; iy++) {
			x = 0;
			  for (int bx=0;bx<mGridWidth/8;bx++) {
				int word = getSpriteByte(bytepos);
				bytepos += 1;
				int mask = 0x80;
				for (int ix=0;ix<8;ix++) {
					if ((word & mask) == 0) {
						e.gc.setForeground(white);
						e.gc.setBackground(white);
					} else {
						e.gc.setForeground(black);
						e.gc.setBackground(black);
					}
						
					e.gc.fillRectangle(x+2, y+2, dx-4, dy-4);
					x += dx;
					mask >>= 1;
				}
			  }
				
			
			y += dy;
		}
		
		e.gc.setForeground(red);
		e.gc.setBackground(red);
		for (int iy = spheight+1; iy <= height;iy++) {
			x = 0;
			for (int ix = 0; ix < width; ix++) {
				e.gc.fillRectangle(x+2, y+2, dx-4, dy-4);
				x += dx;
			}
			y += dy;
		}
		
			
	}
	
	
	protected void onMouseDown(MouseEvent e) {

		if (mReadonly) return;
		Rectangle bounds = getBounds();
		int pos;
		int x = 0;
		int y = 0;
	    int width = mGridWidth;
	    int height = mGridHeight;
		int dx = bounds.width / width;
		int dy = bounds.height / height;
		int w = dx * 16;
		if (height > width) {
			dx = dy;
			w = dx * 8;
		}
		x = e.x / dx;
		y = e.y / dy;
		System.out.println(String.format("x=%d, y=%d",x,y));
	
			pos = mOffset + y*(mGridWidth/8) + x/8;
			x &= 7;
			int mask = 0x80 >> x;
			setSpriteByte(pos, getSpriteByte(pos) ^ mask);
		
		redraw();
		updateText();
		
		
		System.out.println(String.format("%d/%d", x,y));
		}
	/**
	 * Gets a byte from mBytes.
	 * Overwrite this function for own memory management
	 * 
	 * @param bytepos Position in memory
	 * @return
	 */
	public int getSpriteByte(int bytepos) {
		if (bytepos < mBytes.length)
			return mBytes[bytepos];
		else 
			return 255;
	}

	/**
	 * Gets a word from mBytes.
	 * Overwrite this function for own memory management

	 * @param bytepos
	 * @return
	 */
	public int getSpriteWord(int bytepos) {
		int result=0;
		if (mBytes != null) {
			if (bytepos+mOffset+1 < mBytes.length) {
				result = mBytes[bytepos+mOffset] * 256 + mBytes[bytepos+mOffset+1];
			}
		}
		return result;
	}
	
	private void setSpriteWord(int bytepos, int word) {
		int result=0;
		if (mBytes != null) {
			if (bytepos+mOffset+1 < mBytes.length) {
				mBytes[bytepos] = (byte)(word >> 8);
				mBytes[bytepos+1] = (byte)(word & 0xff);
			}
		}
	}
	
	/**
	 * Called after Bytes have been changed, overwrite if nessary
	 */
	public void updateText() {
		mMatrixData.setFlatData(mBytes);
		if (mSpriteCanvasData!= null) mSpriteCanvasData.updateText();
	}

	/**Sets a byte in memory. Overwrite for own memory management
	 * 
	 * @param bytepos
	 * @param newbyte
	 */
	public void setSpriteByte(int bytepos, int newbyte) {
			
		if (mBytes != null) {
			if (bytepos+mOffset < mBytes.length) {
				mBytes[bytepos+mOffset] = (byte)(newbyte & 0xff);
			}
		}
		
	}
	
	public void setHeight(int height) {
		mGridHeight = height;
		redraw();
	}
	
	public void setOffset(int offset) {
		mOffset = offset;
		redraw();
	}
	
	public void shiftRight() {
		int line=0;
		int lineh = mMatrixData.getTileW()/8;
		int pos = 0;
		for (int y=0;y<mMatrixData.getTileH();y++) {
			byte carry = 0;
			for (int x=0;x<lineh;x++) {
				int b = mBytes[line+x];	
				if (b < 0) b+=256;
				byte carry2 = (byte) ((b & 0x1) == 0 ? 0 : 1);
				b >>= 1;
				b += carry<<7;
				carry = carry2;
				mBytes[line+x] = (byte)b;
			}
			line += lineh;
		}
		updateText();
		redraw();		
	}



	public void shiftLeft() {
		int line=0;
		int lineh = mMatrixData.getTileW()/8;
		for (int y=0;y<mMatrixData.getTileH();y++) {
			byte carry = 0;
		    
			for (int x=lineh-1;x>=0;x--) {
				byte b = mBytes[line+x];			
				byte carry2 = (byte) ((b & 0x80) == 0 ? 0 : 1);
				b <<= 1;
				b += carry;
				carry = carry2;
				mBytes[line+x] = b;
			}
			line += lineh;
		}
		
		updateText();
		
		redraw();
		
	}
	
	public void onShiftDown() {
		int rows = mGridHeight;
		int bytes = mGridWidth/8;
		int pos1 = rows*bytes;
		int pos = pos1-bytes;
		pos1--;
		pos--;
		for (int i=0;i<rows-1;i++) {
			for (int j=0;j<bytes;j++) {
				setSpriteByte(pos1--, getSpriteByte(pos--));
			}
			
			
		}
		for (int i=0;i<bytes;i++) setSpriteByte(mOffset+i,0);
		updateText();
		redraw();
		
	}

	public void onShiftUp() {
		int rows = getGridHeight();
		int bytes = getGridWidth();
		int pos = 0;
		int pos1 = bytes;
		for (int i=0;i<rows-1;i++) {
			for (int j=0;j<bytes;j++) {
				setSpriteByte(pos++, getSpriteByte(pos1++));
			}
		}
		for (int i=0;i<bytes;i++) setSpriteByte(pos++,0);
		updateText();
		redraw();
	}

	public void flipW() {
		int rows = mGridHeight;
		int bytes = mGridWidth / 8;
		int temp[] = new int[bytes];
		int pos = 0;
		for (int i=0;i<rows;i++) {
			int d = bytes-1;
			for (int j=0;j<bytes;j++) {
				int v = getSpriteByte(pos+j);
				v = reverse(v);
				temp[d] = v;
				d--;	
			}
			for (int j=0;j<bytes;j++) {
				setSpriteByte(pos+j,temp[j]);
			}
			pos+=bytes;
		}
		redraw();
		updateText();
		
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

	public void flipH() {
		int rows = mGridHeight;
		int bytes = mGridWidth/8;
		int temp[] = new int[bytes];
		int pos = mOffset;
		int j;
		int pos2 = mOffset+bytes*(rows-1);
		for (int i=0;i<rows/2;i++) {
			for (j=0;j<bytes;j++) temp[j] = getSpriteByte(pos+j);
			for (j=0;j<bytes;j++) setSpriteByte(pos+j, getSpriteByte(pos2+j));
			for (j=0;j<bytes;j++) setSpriteByte(pos2+j,temp[j]);
			pos+=bytes;
			pos2-=bytes;
			
		}
		redraw();
		updateText();
		
	}




	@Override
	protected void checkSubclass() {
		// Disable the check that prevents subclassing of SWT components
	}

	public int getGridHeight() {
		return mGridHeight;
	}
	public int getGridWidth() {
		return mGridWidth;
	}

	public int getSpriteSize() {
		return mGridHeight*mGridWidth/8;
	}

	public void setColumns(int int1) {
		mGridWidth = int1;
		mMatrixData.setTileW(int1);
		mBytes = mMatrixData.getFlatData(mMatrixData.getTile());
		
		redraw();
		
	}

	public void setRows(int int1) {
		mGridHeight = int1;
		mMatrixData.setTileH(int1);
		mBytes = mMatrixData.getFlatData(mMatrixData.getTile());
		redraw();
		
	}

	public void setMatrixData(ICanvasSpriteMatrixData matrixData) {
		mMatrixData = matrixData;
		if (matrixData != null)
			mBytes = matrixData.getFlatData(0);
		
	}
}

