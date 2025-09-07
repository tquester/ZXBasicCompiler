package main.spriteed;

import java.util.ArrayList;
import java.util.TreeMap;

import org.eclipse.swt.custom.StyledText;
import org.eclipse.swt.graphics.Point;



public class CResources {
	
	public TreeMap<String, ArrayList<byte[]>> mMapUdgSets = new TreeMap<>();
	public ArrayList<byte[]> mSprites = new ArrayList<>();
	public ArrayList<CSpriteData> mTilesets = new ArrayList<>();
	
	StyledText mCurrentEditor = null;

	
	public void readSourcecode(StyledText editor) {
		String text = editor.getText();
		String[] lines = text.split("\n");
		String name;
		int iline = 0;
		int p;
		while (iline < lines.length) {
			String line = lines[iline++].trim();
			if (line.isEmpty() || line.startsWith(";") || line.startsWith("//")) continue;
			if (line.startsWith("#UDG")) {
				p = line.indexOf(':');
				name="null";
				if (p != -1) name = line.substring(p+1).trim();
				ArrayList<byte[]> udgs = new ArrayList<byte[]>();
				mMapUdgSets.put(name, udgs);
				while (iline < lines.length) {
					line = lines[iline++].trim();
					if (line.isEmpty()) continue;
					if (line.startsWith(";") || line.startsWith("//") || line.startsWith("REM ")) continue;
					if (!line.startsWith("DATA "))  {
						iline--;
						break;
					}
					p = line.lastIndexOf("//");
					if (p != -1) line = line.substring(0,p).trim();
					line = line.substring(5);
					
					String[] parts = line.split(",");
					byte[] udg = new byte[parts.length];
					udgs.add(udg);
					for (int i=0;i<parts.length;i++) {
						try {
							udg[i] = (byte)Integer.parseInt(parts[i].trim());
							
						}
						catch(Exception e) {
							udg[i] = 0;
						}
					}
					
				}
			}
		}
	
	}


	


	private void getDimen(CSpriteData sdata, String lit) {
		int p = lit.indexOf(':');
		if (p != -1) {
			int nr = 0;
			sdata.width = 0;
			sdata.height = 0;
			int pos=0;
			while (p < lit.length()) {
				char c = lit.charAt(p++);
				if (c == 'x') pos++;
				if (c >= '0' && c <= '9') {
					if (pos == 0) 
						sdata.width = sdata.width*10 + c-'0';
					else
						sdata.height = sdata.height*10 + c-'0';
				}
					
			}
		}
		
	}


	public boolean save(CSpriteData mCurrentTileMap) {
		
		
		
		return false;
		
	}
	
	public boolean saveTileset(CSpriteData mCurrentTileMap) {
			return false;
		
	}


}
