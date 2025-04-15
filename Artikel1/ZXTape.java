package zxcompiler;

import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;

public class ZXTape {
	static public class TapeEntry {
		public String name;
		public int    typ;
		public int    len;
		public int    start;
		public byte[] data;
	}
	ArrayList<TapeEntry> mTapeEntries = null;
	void load(String filename) {
		File file = new File(filename);
	    byte[] fileData = new byte[(int) file.length()];
	    DataInputStream dis;
		try {
			dis = new DataInputStream(new FileInputStream(file));
		    dis.readFully(fileData);
		    readEntries(fileData);
		    dis.close();
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	int b2int(byte b) {
		if (b < 0) return b+256;
		return b;
	}
	
	private void readEntries(byte[] data) {
		int pos=0;
		mTapeEntries = new ArrayList<ZXTape.TapeEntry>();
		while (pos < data.length) {
			TapeEntry e = new TapeEntry();
			mTapeEntries.add(e);
			int headerLen = b2int(data[pos])+b2int(data[pos+1])*256;
			int blocktyp = b2int(data[pos+2]);
			int subtyp = b2int(data[pos+3]);
			if (blocktyp == 0) { // header 
				String text = "";
				int i;
				for (i=pos+4;i<=pos+13;i++) {
					char c = (char)data[i];
					text += c;
				}
				e.name = text.trim();
				System.out.println(text);
				
				int blocklen = b2int(data[pos+14])+b2int(data[pos+15])*256;
				int start    = b2int(data[pos+16])+b2int(data[pos+17])*256;
				e.len = blocklen;
				e.start = start;
				e.data = new byte[blocklen];
				for (i=0;i<blocklen;i++) {
					e.data[i] = data[pos+i+headerLen];
				}
				pos += blocklen+headerLen+6;
			}
			else 
				pos += headerLen+2;
			}
		}
	
	TapeEntry get(String name) {
		TapeEntry result=null;
		for (TapeEntry e: mTapeEntries) {
			if (e.name == null) continue;
			if (e.name.compareTo(name) == 0) {
				result = e;
				break;
			}
		}
		return result;
		
	}
}

