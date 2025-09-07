package main;
import java.io.*;
import java.nio.file.*;
import java.util.Stack;

import org.eclipse.swt.custom.CTabFolder;
import org.eclipse.swt.custom.CTabItem;
import org.eclipse.swt.custom.StyledText;
import org.eclipse.swt.events.KeyAdapter;
import org.eclipse.swt.events.KeyEvent;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.swt.widgets.Shell;
import org.eclipse.swt.widgets.TabFolder;
import org.eclipse.swt.widgets.TabItem;

public class EditManager {
    static class Edit {
        int start;
        String replacedText;
        String newText;
        Edit(int start, String replacedText, String newText) {
            this.start = start;
            this.replacedText = replacedText;
            this.newText = newText;
        }
    }

    private final StyledText styledText;
    private final Stack<Edit> undoStack = new Stack<>();
    private final Stack<Edit> redoStack = new Stack<>();

    private Path filePath;
    private boolean dirty = false;

    public EditManager(StyledText styledText, String filePath) {
        this.styledText = styledText;
        this.filePath = Paths.get(filePath);
        
        styledText.setData(this);
        hookListeners();
    }

    private void hookListeners() {
        styledText.addExtendedModifyListener(e -> {
            String newText = styledText.getTextRange(e.start, e.length);
            String replacedText = e.replacedText;
            if (!newText.equals(replacedText)) {
                undoStack.push(new Edit(e.start, replacedText, newText));
                redoStack.clear();
                dirty = true;
            }
        });

        styledText.addKeyListener(new KeyAdapter() {
            @Override
            public void keyPressed(KeyEvent e) {
                if ((e.stateMask & org.eclipse.swt.SWT.CTRL) != 0) {
                    if (e.keyCode == 'z') {
                        undo();
                        e.doit = false;
                    } else if (e.keyCode == 'y') {
                        redo();
                        e.doit = false;
                    }
                }
            }
        });
    }

    // --- Undo / Redo ---
    public void undo() {
        if (!undoStack.isEmpty()) {
            Edit edit = undoStack.pop();
            styledText.replaceTextRange(edit.start, edit.newText.length(), edit.replacedText);
            redoStack.push(edit);
            dirty = true;
        }
    }

    public void redo() {
        if (!redoStack.isEmpty()) {
            Edit edit = redoStack.pop();
            styledText.replaceTextRange(edit.start, edit.replacedText.length(), edit.newText);
            undoStack.push(edit);
            dirty = true;
        }
    }
    
    private void updateTitle() {
        Composite parent = styledText.getParent();
        

        // Falls Editor direkt in einer Shell liegt
        if (parent instanceof Shell ) {
        	Shell shell = (Shell)parent;
            String base = filePath != null ? filePath.getFileName().toString() : "Unbenannt";
            shell.setText(dirty ? base + "*" : base);
        }

        // Falls Editor in einem TabItem liegt
        else if (parent instanceof CTabFolder ) {
        	CTabFolder folder = (CTabFolder)parent;
            for (CTabItem item : folder.getItems()) {
                if (item.getControl() == styledText) {
                    String base = filePath != null ? filePath.getFileName().toString() : "Unbenannt";
                    item.setText(dirty ? base + "*" : base);
                    break;
                }
            }
        }

        else if (parent instanceof TabFolder) {
        	TabFolder folder = (TabFolder)parent;
            for (TabItem item : folder.getItems()) {
                if (item.getControl() == styledText) {
                    String base = filePath != null ? filePath.getFileName().toString() : "Unbenannt";
                    item.setText(dirty ? base + "*" : base);
                    break;
                }
            }
        }
    }


	public void setFilename(String filename) {
		filePath = Paths.get(filename);
	}
	
	public String getFilename() {
		String r = filePath.toString();
		return r;
	}
		// TODO Auto-generated method stub
		
	}
