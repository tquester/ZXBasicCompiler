package main;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.util.Arrays;

public class ZXTapWriter {

    public static void writeBasicTap(String tapename, String basname, byte[] code, int autostartLine) throws IOException {
        try (FileOutputStream out = new FileOutputStream(tapename)) {
            // HEADERBLOCK schreiben
            byte[] header = createHeaderBlock(basname, code.length, autostartLine);
            writeBlock(out, header);

            // DATABLOCK schreiben
            byte[] datablock = createDataBlock(code);
            writeBlock(out, datablock);
           
        }
    }

    private static byte[] createHeaderBlock(String name, int length, int autostart) throws IOException {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        baos.write(0x00); // Header-Flag
        baos.write(0x00); // Typ 0 = BASIC

        // Name (max 10 Zeichen, mit Spaces auffüllen)
        while (name.length()<10) name += " ";
        if (name.length() > 10) name = name.substring(0,10);
        byte[] nameBytes = Arrays.copyOf(name.getBytes(StandardCharsets.ISO_8859_1), 10);
        baos.write(nameBytes);
        
              // Länge des Datenblocks
        baos.write(length & 0xFF);
        baos.write((length >> 8) & 0xFF);

        // Autostart-Zeile
        baos.write(autostart & 0xFF);
        baos.write((autostart >> 8) & 0xFF);

        // Unused (für BASIC immer 0)
        baos.write(0x15);
        baos.write(0x00);

        // Checksumme
        byte[] raw = baos.toByteArray();
        baos.write(calcChecksum(raw));
        raw = baos.toByteArray();
        return wrapWithLength(raw);
    }

    private static byte[] createDataBlock(byte[] code) throws IOException {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        baos.write(0xFF); // Daten-Flag
        baos.write(code); // BASIC-Bytes
        baos.write(0x5e);
        byte[] raw = baos.toByteArray();
        baos.write(calcChecksum(raw));
        return wrapWithLength(raw);
    }

    private static byte[] wrapWithLength(byte[] block) throws IOException {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        int length = block.length;
        baos.write(length & 0xFF);
        baos.write((length >> 8) & 0xFF);
        baos.write(block);
        return baos.toByteArray();
    }

    private static int calcChecksum(byte[] block) {
        int sum = 0;
        for (byte b : block) sum ^= (b & 0xFF);
        return sum & 0xFF;
    }

    private static void writeBlock(OutputStream out, byte[] block) throws IOException {
        out.write(block);
    }


}
