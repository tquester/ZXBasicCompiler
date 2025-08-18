package main;

import java.io.*;

public class ZXBasicFileWriter {
    private int checksum;
    
    private void writeByte(int value, OutputStream out) throws IOException {
        out.write(value);
        checksum ^= value;
    }
    
    private void writeDoubleByte(int size, OutputStream out) throws IOException {
        writeByte(size & 0xFF, out);
        writeByte((size / 0x100) & 0xFF, out);
    }
    
    public void writeFile(int size, String name, byte[] buf, OutputStream out, int startLine) throws IOException {
        int len = name.length();
        
        // writing the header packet
        writeByte(0x13, out);
        checksum = 0;
        writeByte(0, out);
        writeByte(0, out);
        writeByte(0, out);
        
        for (int i = 0; i < len && i < 10; i++) {
            writeByte(name.charAt(i), out);
        }
        
        for (int i = len; i < 10; i++) {
            writeByte(' ', out);
        }
        
        writeDoubleByte(size, out);
        if (startLine == 0)
        	writeDoubleByte(0x8000, out);
        else
        	writeDoubleByte(startLine, out);
        writeDoubleByte(size, out);
        writeByte(checksum, out);
        // the header ends here
        
        // writing data packet
        writeDoubleByte(size + 2, out);
        checksum = 0;
        writeByte(0xFF, out);
        
        // writing raw data
        for (int i = 0; i < size; i++) {
            writeByte(buf[i] & 0xFF, out); // & 0xFF to handle signed byte conversion
        }
        
        writeByte(checksum, out);
    }
    
    public void writeZXBasic(String filename, String name, byte[] data, int startLine) {
    	int size = data.length;
    	FileOutputStream fos;
		try {
			fos = new FileOutputStream(filename);
	    	writeFile(size, name, data, fos, startLine);
	    	fos.close();
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
}
