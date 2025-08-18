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
	
	/*
	 * Byte	Length	Description
		0	1	Type (0,1,2 or 3)
		1	10	Filename (padded with blanks)
		11	2	Length of data block
		13	2	Parameter 1
		15	2	Parameter 2
	 */
	private void readEntries(byte[] data) {
		int pos=0;
		try {
		mTapeEntries = new ArrayList<ZXTape.TapeEntry>();
		while (pos < data.length) {
			TapeEntry e = new TapeEntry();
			mTapeEntries.add(e);
			int headerLen = b2int(data[pos])+b2int(data[pos+1])*256;
			int blocktyp = b2int(data[pos+2]);
			int subtyp = b2int(data[pos+3]);
			if (blocktyp == 0) { // header 
				int lpos = pos+3;
				String text = "";
				int i;
				for (i=lpos+1;i<=lpos+10;i++) {
					char c = (char)data[i];
					text += c;
				}
				e.name = text.trim();
				System.out.println(text);
				
				int blocklen = b2int(data[lpos+11])+b2int(data[lpos+12])*256;
				int start    = b2int(data[lpos+13])+b2int(data[lpos+14])*256;
				int par2     = b2int(data[lpos+15])+b2int(data[lpos+16])*256;
				e.len = par2;
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
		} catch(Exception e) {
		e.printStackTrace();
		}
	}
	
	TapeEntry get(String name) {
		TapeEntry result=null;
		name=name.trim();
		for (int i=mTapeEntries.size()-1;i>=0;i--) {
			TapeEntry e = mTapeEntries.get(i);
			if (e.name == null) continue;
			if (e.name.trim().compareTo(name) == 0) {
				result = e;
				break;
			}
		}
		return result;
	}
}

