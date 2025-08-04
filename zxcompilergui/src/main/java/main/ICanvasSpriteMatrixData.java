package main;

public interface ICanvasSpriteMatrixData {
	int getTileW();
	int getTileH();
	int[] getTileData();
	void onSpriteSelected(int pos);
}
