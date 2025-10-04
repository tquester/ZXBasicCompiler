package main;

import java.io.*;
import java.net.URL;
import java.nio.channels.Channels;
import java.nio.channels.ReadableByteChannel;
import java.nio.file.*;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;

import org.eclipse.swt.SWT;
import org.eclipse.swt.widgets.Display;
import org.eclipse.swt.widgets.MessageBox;
import org.eclipse.swt.widgets.Shell;

public class CDownloadAndInstallAssembler {
    
    private static final String ASSEMBLER_URL = "https://github.com/z00m128/sjasmplus/releases/download/v1.21.0/sjasmplus-1.21.0.win.zip";
    private static final String ASSEMBLER_DIR = "tools/sjasmplus";
    private static final String LOCAL_ASSEMBLER_DIR = "tools/sjasmplus/sjasmplus-1.21.0.win";
    private static final String ASSEMBLER_EXE = "sjasmplus.exe";
    private static final String ZIP_FILE = "sjasmplus.zip";
    
    public boolean checkAssembler() {
    	CSettings set = CSettings.instance();
    	File file = new File(set.mAssembler);
    	return file.exists();
    }
    
    public void assertAssemblerInstalled(Shell shell) {
    	 if (checkAssembler()) return;

         // Create a MessageBox instance
         MessageBox messageBox = new MessageBox(shell, SWT.ICON_QUESTION | SWT.YES | SWT.NO);
         messageBox.setMessage("Download and install Assembler (sjasmplus)");
         int response = messageBox.open();
         if (response == SWT.YES)
        	 checkAndInstallAssembler(shell);
    }
    
    
    
    public static void checkAndInstallAssembler(Shell shell) {
        try {
        	String currentDirectory = System.getProperty("user.home");
        	String appData = System.getenv("APPDATA");
        	if (appData != null) {
        		currentDirectory = appData+File.separator+"ZXCompiler";
        		File f = new File(currentDirectory);
        		f.mkdirs();
        	}
            Path assemblerPath = Paths.get(currentDirectory,ASSEMBLER_DIR, ASSEMBLER_EXE);
            Path localassemblerPath = Paths.get(currentDirectory,LOCAL_ASSEMBLER_DIR, ASSEMBLER_EXE);
            CSettings set = CSettings.instance();
            set.mAssembler = localassemblerPath.toString();
           // set.mTapFile = currentDirectory+"\\compiled.tap";
            set.save();
            
            if (!Files.exists(assemblerPath)) {
                System.out.println("Assembler nicht gefunden. Lade herunter...");
                downloadAndExtractAssembler(currentDirectory,shell);
            } else {
                System.out.println("Assembler bereits vorhanden: " + assemblerPath.toAbsolutePath());
            }
            
        } catch (Exception e) {
            System.err.println("Fehler beim Überprüfen/Installieren des Assemblers: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    
    
    private static void downloadAndExtractAssembler(String currentDirectory, Shell shell) throws IOException {
        // Verzeichnis erstellen falls nicht vorhanden
        Path toolsDir = Paths.get(currentDirectory,ASSEMBLER_DIR);
        Files.createDirectories(toolsDir);
        
        Path zipPath = Paths.get(currentDirectory,ZIP_FILE);
        
        // Download
        downloadFile(ASSEMBLER_URL, zipPath);
        
        // Extrahieren
        extractZip(zipPath, toolsDir);
        
        // ZIP-Datei löschen
        Files.deleteIfExists(zipPath);
        
        MessageBox messageBox = new MessageBox(shell, SWT.ICON_QUESTION | SWT.OK);
        messageBox.setMessage("Assembler installed");
        int response = messageBox.open();

        
        System.out.println("Assembler erfolgreich installiert!");
    }
    
    private static void downloadFile(String url, Path destination) throws IOException {
        System.out.println("Lade herunter: " + url);
        
        try (ReadableByteChannel rbc = Channels.newChannel(new URL(url).openStream());
             FileOutputStream fos = new FileOutputStream(destination.toFile())) {
            
            fos.getChannel().transferFrom(rbc, 0, Long.MAX_VALUE);
        }
        
        System.out.println("Download abgeschlossen: " + destination.getFileName());
    }
    
    private static void extractZip(Path zipPath, Path extractDir) throws IOException {
        System.out.println("Extrahiere ZIP-Datei...");
        
        try (ZipInputStream zis = new ZipInputStream(new FileInputStream(zipPath.toFile()))) {
            ZipEntry entry;
            
            while ((entry = zis.getNextEntry()) != null) {
                Path entryPath = extractDir.resolve(entry.getName());
                
                if (entry.isDirectory()) {
                    Files.createDirectories(entryPath);
                } else {
                    // Übergeordnete Verzeichnisse erstellen falls nötig
                    Files.createDirectories(entryPath.getParent());
                    
                    // Datei extrahieren
                    try (FileOutputStream fos = new FileOutputStream(entryPath.toFile())) {
                        byte[] buffer = new byte[1024];
                        int length;
                        while ((length = zis.read(buffer)) > 0) {
                            fos.write(buffer, 0, length);
                        }
                    }
                    
                    // Ausführbare Berechtigung setzen (falls auf Unix-System)
                    if (entry.getName().endsWith(".exe") || !System.getProperty("os.name").toLowerCase().contains("win")) {
                        entryPath.toFile().setExecutable(true);
                    }
                }
                zis.closeEntry();
            }
        }
        
        System.out.println("Extraktion abgeschlossen!");
    }
    
    // Methode um den Pfad zum Assembler zu erhalten
    public static String getAssemblerPath() {
        Path assemblerPath = Paths.get(ASSEMBLER_DIR, ASSEMBLER_EXE);
        return assemblerPath.toAbsolutePath().toString();
    }
    
    // Methode um zu testen ob der Assembler funktioniert
    public static boolean testAssembler() {
        try {
            ProcessBuilder pb = new ProcessBuilder(getAssemblerPath(), "--version");
            Process process = pb.start();
            int exitCode = process.waitFor();
            return exitCode == 0;
        } catch (Exception e) {
            return false;
        }
    }
}

