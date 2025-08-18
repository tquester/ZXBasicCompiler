package main;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.eclipse.swt.SWT;
import org.eclipse.swt.graphics.Image;
import org.eclipse.swt.widgets.Display;
import org.eclipse.swt.widgets.Tree;
import org.eclipse.swt.widgets.TreeItem;

/**
 * Klasse zum Füllen eines SWT Tree mit Dateisystem-Daten
 */
public class FileSystemTreePopulator {
    
    private static final String DEFAULT_PATH = System.getProperty("user.home");
    private Tree tree;
    private Display display;
    
    // Optional: Icons für Ordner und Dateien
    private Image folderIcon;
    private Image fileIcon;
    
    /**
     * Konstruktor
     * @param tree Das SWT Tree Widget
     */
    public FileSystemTreePopulator(Tree tree) {
        this.tree = tree;
        this.display = tree.getDisplay();
        initializeIcons();
    }
    
    /**
     * Initialisiert die Icons (optional)
     */
    private void initializeIcons() {
        try {
            // Hier können Sie eigene Icons laden
            // folderIcon = new Image(display, "folder.png");
            // fileIcon = new Image(display, "file.png");
        } catch (Exception e) {
            // Icons sind optional, bei Fehler einfach ohne Icons arbeiten
        }
    }
    
    /**
     * Füllt den Tree mit Dateisystem-Daten
     * @param rootPath Der Pfad zum Wurzelverzeichnis (null für Default-Pfad)
     */
    public void populateTree(String rootPath) {
        // Verwende Default-Pfad wenn rootPath null ist
        String pathToUse = (rootPath != null) ? rootPath : DEFAULT_PATH;
        
        try {
            Path path = Paths.get(pathToUse);
            File rootFile = path.toFile();
            
            if (!rootFile.exists() || !rootFile.isDirectory()) {
                throw new IllegalArgumentException("Pfad existiert nicht oder ist kein Verzeichnis: " + pathToUse);
            }
            
            // Tree leeren
            tree.removeAll();
            
            // Wurzel-Element erstellen
            TreeItem rootItem = new TreeItem(tree, SWT.NONE);
            rootItem.setText(rootFile.getName().isEmpty() ? rootFile.getAbsolutePath() : rootFile.getName());
            rootItem.setData(rootFile);
            
            if (folderIcon != null) {
                rootItem.setImage(folderIcon);
            }
            
            // Rekursiv Unterverzeichnisse und Dateien hinzufügen
            populateTreeItem(rootItem, rootFile);
            
            // Wurzel-Element expandieren
            rootItem.setExpanded(true);
            
        } catch (Exception e) {
            System.err.println("Fehler beim Füllen des Trees: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    /**
     * Füllt ein TreeItem rekursiv mit Unterverzeichnissen und Dateien
     * @param parentItem Das übergeordnete TreeItem
     * @param directory Das Verzeichnis
     */
    private void populateTreeItem(TreeItem parentItem, File directory) {
        if (!directory.isDirectory()) {
            return;
        }
        
        File[] files = directory.listFiles();
        if (files == null) {
            return;
        }
        
        // Erst Verzeichnisse, dann Dateien
        for (File file : files) {
            if (file.isDirectory()) {
                TreeItem item = new TreeItem(parentItem, SWT.NONE);
                item.setText(file.getName());
                item.setData(file);
                
                if (folderIcon != null) {
                    item.setImage(folderIcon);
                }
                
                // Rekursiv Unterverzeichnisse hinzufügen
                populateTreeItem(item, file);
            }
        }
        
        // Dateien hinzufügen
        for (File file : files) {
            if (file.isFile()) {
                TreeItem item = new TreeItem(parentItem, SWT.NONE);
                item.setText(file.getName());
                item.setData(file);
                
                if (fileIcon != null) {
                    item.setImage(fileIcon);
                }
            }
        }
    }
    
    /**
     * Alternative Methode mit Path-Parameter
     * @param rootPath Der Pfad als Path-Objekt (null für Default-Pfad)
     */
    public void populateTree(Path rootPath) {
        String pathString = (rootPath != null) ? rootPath.toString() : null;
        populateTree(pathString);
    }
    
    /**
     * Füllt den Tree mit dem Default-Pfad
     */
    public void populateTreeWithDefault() {
        populateTree((String) null);
    }
    
    /**
     * Gibt den aktuell verwendeten Default-Pfad zurück
     * @return Der Default-Pfad
     */
    public String getDefaultPath() {
        return DEFAULT_PATH;
    }
    
    /**
     * Gibt die ausgewählte Datei/Verzeichnis zurück
     * @return Die ausgewählte Datei oder null
     */
    public File getSelectedFile() {
        TreeItem[] selection = tree.getSelection();
        if (selection.length > 0) {
            return (File) selection[0].getData();
        }
        return null;
    }
    
    /**
     * Ressourcen freigeben
     */
    public void dispose() {
        if (folderIcon != null && !folderIcon.isDisposed()) {
            folderIcon.dispose();
        }
        if (fileIcon != null && !fileIcon.isDisposed()) {
            fileIcon.dispose();
        }
    }
}
