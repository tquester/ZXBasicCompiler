package main.spriteed;

import main.CBASICTokenizer;
import zxcompiler.ZXToken;

public class CUdgMatrixData implements ICanvasSpriteMatrixData {
	
	byte[] mData = new byte[22 * 8];			// 21 UDG characters
	int tileW = 8;
	int tileH = 8;
	private int mTile;
	CBASICTokenizer tokenizer = new CBASICTokenizer();
	public String name="";
	
	public int getByte(int x, int y) {
		int bytesPerRow = getTileW() / 8;
		return mData[x + y*bytesPerRow];
	}

	@Override
	public int getTileW() {
		return tileW;
	}

	@Override
	public int getTileH() {
		return tileH;
	}

	@Override
	public int[] getTileData() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void onSpriteSelected(int udg) {
		// TODO Auto-generated method stub

	}

	@Override
	public void setTileW(int w) {
		tileW = w;
		
	}

	@Override
	public void setTileH(int h) {
		tileH = h;
	}
	
	
	
	public String toString() {
		if (mData == null) return "";
		StringBuilder sb = new StringBuilder();
		sb.append("#UDG.A#UDG\n");
		int max = -1;
		int ofs = 0;
		for (int udg=0;udg<21;udg++) {
			for (int j=ofs;j<=ofs+8;j++) { 
				if (mData[j] != 0) {
					max = udg;
					break;
				}
			}
			ofs += 8;
		}
		ofs = 0;
		for (int udg=0;udg<=max;udg++) {
			sb.append("DATA ");
			for (int j=ofs;j<ofs+8;j++) {
				if (j != ofs) sb.append(", ");
				int bt = mData[j];
				if (bt < 0) bt+=256;
				sb.append(String.format("%d", bt));
			}
			ofs+=8;
			sb.append("\n");
		}
		
		return sb.toString();
		
	}

	// returns the data for the sprite editor
	// for example if we display 4x4 udg the data is 
	//  0 8
	//  1 9
	//  2 10
	// ...
	//  7 15
	//  16 24 
	//  ..
	//  23 31
	@Override
	public byte[] getFlatData(int tile) {
		mTile = tile;
		int size = tileH * tileW/8;
		byte[] data = new byte[size];
		int chars = tileH / 8 + tileW / 8;
		int lineBytes = tileW / 8;
		int ichar=0;
		int srcofs = 8*tile;
		int linestart=0;
		for (int y=0;y<tileH/8;y++) {
			
			for (int x=0;x<tileW/8;x++) {
				int ofs = linestart+x;
				System.out.println(String.format("x=%d y=%d ofs=%d",x,y,ofs));
				for (int b=0;b<=7;b++) {
					if (ofs < data.length)
						data[ofs] = mData[srcofs++];
					ofs += lineBytes;
				}
			}
			linestart += 8*lineBytes;
		}
		return data;
	}

	@Override
	public void setFlatData(byte[] data) {
		int bw = tileW/8;
		int bh = tileH/8;
		int linestart=0;
		int lineBytes = tileW / 8;
		int pos=8*mTile;
		for (int y=0;y<bw;y++) {
			for (int x=0;x<bw;x++) {
				int ofs = linestart+x;
				for (int ib=0;ib<=7;ib++) {
					mData[pos++] = data[ofs];
					ofs+=lineBytes;
				}
	
			}
			linestart+=8*lineBytes;
		}
		System.out.println("Stop");
	}

	@Override
	public int getTile() {
		
		return mTile;
	}

	@Override
	public void parseText(String text) {
		int bpos = 0;
		String lines[] = text.split("\n");
		int iline = 0;
		while (iline < lines.length) {
			String line = lines[iline++];
			int p = line.lastIndexOf("//");
			if (p != -1) 
				line = line.substring(0,p);
			String uline = line.trim().toUpperCase();
			if (line.startsWith("#UDG")) {
				while (iline<lines.length) {
					line = lines[iline++];
					uline = line.trim().toUpperCase();
					if (line.startsWith("#")) {
						iline--;
						break;
					}
					if (line.startsWith("DATA")) {
						line = line.substring(4);
						p = line.lastIndexOf("//");
						if (p != -1) 
							line = line.substring(0,p);						
						tokenizer.init(line);
						CBASICTokenizer.BASICToken token = new CBASICTokenizer.BASICToken();
						while (tokenizer.nextToken(token)) {
							if (token.typ == CBASICTokenizer.BASICTokenTyp.isNumber) {
								int nr = Integer.parseInt(token.literal);
								if (bpos < mData.length)
									mData[bpos++] = (byte)nr;
							}
						}
					}
				}
			}
		}
		System.out.println("Stop");			
	}

	@Override
	public int getElemW() {
		return 8;
	}

	@Override
	public int getElemH() {
		return 8;
	}

	@Override
	public int getElemCount() {
		return 21;
	}

	@Override
	public byte[] getElem(int nr) {
		byte[] result=new byte[8];
		int ofs = nr*8;
		for (int i=0;i<=7;i++)
			result[i] = mData[ofs+i];
		return result;
	}

}
