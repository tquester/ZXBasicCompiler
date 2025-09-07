package main.spriteed;

import java.util.ArrayList;
import java.util.List;

public class CTileParser {

    private int currentInk = 0;
    private int currentPaper = 0;
    private boolean currentBright = false;
    private boolean currentFlash = false;

    public CTile[][] parse(String scene, int width, int height) {
        CTile[][] tiles = new CTile[height][width];
        int x = 0, y = 0;

        for (int i = 0; i < scene.length(); ) {
            if (scene.charAt(i) == '\\') {
                // Direktive
                int next = scene.indexOf('\\', i + 1);
                if (next == -1) next = scene.length();
                String token = scene.substring(i + 1, next).trim();

                if (token.startsWith("INK")) {
                    currentInk = readInt(token.substring(3));
                } else if (token.startsWith("PAPER")) {
                    currentPaper = readInt(token.substring(5));
                } else if (token.startsWith("BRIGHT")) {
                    currentBright = readInt(token.substring(6)) != 0;
                } else if (token.startsWith("FLASH")) {
                    currentFlash = readInt(token.substring(5)) != 0;
                } else {
                    // evtl \000.. Zahl
                    if (!token.isEmpty()) {
	                        int val = readInt(token);
	                        tiles[y][x] = new CTile();
	                        tiles[y][x].tile = (char) val;
	                        tiles[y][x].ink = currentInk;
	                        tiles[y][x].paper = currentPaper;
	                        tiles[y][x].bright = currentBright;
	                        tiles[y][x].flash = currentFlash;
	                        x++;
	                        if (x >= width) { x = 0; y++; }
                    }
                }
                i = next;
            } else {
                // normales Zeichen
                char c = scene.charAt(i);
                if (c == '\013') { // Zeilenende
                    x = 0;
                    y++;
                } else {
                    tiles[y][x] = new CTile();
                    tiles[y][x].tile = c;
                    tiles[y][x].ink = currentInk;
                    tiles[y][x].paper = currentPaper;
                    tiles[y][x].bright = currentBright;
                    tiles[y][x].flash = currentFlash;
                    x++;
                    if (x >= width) { x = 0; y++; }
                }
                i++;
            }
        }

        return tiles;
    }

    private int readInt(String substring) {
		try {
			return Integer.parseInt(substring);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	public String toString(CTile[][] tiles) {
        StringBuilder sb = new StringBuilder();
        int lastInk = -1, lastPaper = -1;
        boolean lastBright = false, lastFlash = false;

        for (int y = 0; y < tiles.length; y++) {
            for (int x = 0; x < tiles[y].length; x++) {
                CTile t = tiles[y][x];
                if (t == null) continue;

                if (t.ink != lastInk) {
                    sb.append("\\INK").append(t.ink);
                    lastInk = t.ink;
                }
                if (t.paper != lastPaper) {
                    sb.append("\\PAPER").append(t.paper);
                    lastPaper = t.paper;
                }
                if (t.bright != lastBright) {
                    sb.append("\\BRIGHT").append(t.bright ? "001" : "000");
                    lastBright = t.bright;
                }
                if (t.flash != lastFlash) {
                    sb.append("\\FLASH").append(t.flash ? "001" : "000");
                    lastFlash = t.flash;
                }

                if (t.tile < 32 || t.tile > 126) {
                    sb.append("\\").append((int) t.tile);
                } else {
                    sb.append(t.tile);
                }
            }
            sb.append("\\013"); // Zeilenende
        }
        return sb.toString();
    }
}
