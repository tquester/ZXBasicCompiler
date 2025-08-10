package main.spriteed;

public interface ICanvasSpriteMatrixData {
	int getByte(int x, int y);		// get the byte at sprite pos x/y (pixel pos)
	int getTileW();
	int getTileH();
	void setTileW(int w);
	void setTileH(int h);
	int[] getTileData();
	void onSpriteSelected(int pos);
	public String toString();
	byte[] getFlatData(int tile);
	void setFlatData(byte[] data);
	int getTile();
	void parseText(String text);
	int  getElemW();					// Breite der Elemente (z.B. UDG=8)
	int  getElemH();					// Höhe de Elemente (z.B. UDG=8)
	int  getElemCount();				// Anzahl der ELemente (z.B. UDG=21)
	byte[] getElem(int nr);				// Element in "screen"-Format
}
