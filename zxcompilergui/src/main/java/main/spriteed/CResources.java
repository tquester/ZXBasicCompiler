package main.spriteed;

import java.util.ArrayList;

import org.eclipse.swt.custom.StyledText;
import org.eclipse.swt.graphics.Point;



public class CResources {
	
	public ArrayList<CUdgMatrixData> mSprites = new ArrayList<>();
	public ArrayList<CSpriteData> mTilesets = new ArrayList<>();
	
	StyledText mCurrentEditor = null;

	
	public void readSourcecode(StyledText editor) {
		String text = editor.getText();
		String[] lines = text.split("\n");
		int iline = 0;
		while (iline < lines.length) {
			String line = lines[iline++].trim();
			if (line.isEmpty() || line.startsWith(";") || line.startsWith("//")) continue;
			if (line.startsWith("#")) {
				
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
