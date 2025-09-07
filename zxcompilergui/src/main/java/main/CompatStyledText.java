package main;

import org.eclipse.swt.widgets.Composite;
import org.eclipse.swt.custom.StyledText;
import org.eclipse.swt.graphics.Point;
import org.eclipse.swt.SWT;

public class CompatStyledText extends StyledText {

    public CompatStyledText(Composite parent, int style) {
        super(parent, style);
    }

    // Alte Methode für JFaceTextUtil
    public int getOffsetAtPoint(Point p) {
        try {
            return getOffsetAtLocation(p); // verwendet die neue SWT-Methode
        } catch (IllegalArgumentException e) {
            return -1;
        }
    }
}
