package main;

import org.eclipse.jface.text.Document;
import org.eclipse.jface.text.IDocument;
import org.eclipse.jface.text.ITextViewer;
import org.eclipse.jface.text.contentassist.CompletionProposal;
import org.eclipse.jface.text.contentassist.ContentAssistant;
import org.eclipse.jface.text.contentassist.ICompletionProposal;
import org.eclipse.jface.text.contentassist.IContentAssistProcessor;
import org.eclipse.jface.text.contentassist.IContextInformation;
import org.eclipse.jface.text.contentassist.IContextInformationValidator;
import org.eclipse.jface.text.source.SourceViewer;
import org.eclipse.swt.*;
import org.eclipse.swt.layout.FillLayout;
import org.eclipse.swt.widgets.*;
import org.eclipse.swt.widgets.List;

import zxcompiler.ZXToken;

import java.util.*;
import java.util.regex.*;


public class ContentAssistTokens {
    public static void install(SourceViewer viewer) {
        Display display = new Display();
        Shell shell = new Shell(display);
        shell.setLayout(new FillLayout());

        //SourceViewer viewer = new SourceViewer(shell, null, SWT.BORDER | SWT.V_SCROLL | SWT.H_SCROLL);
        viewer.setDocument(new Document("PR\nLET A=5\nPLOT 10,20\n"));

        ZXToken tokens = new ZXToken();

        ContentAssistant assistant = new ContentAssistant();
        assistant.setContentAssistProcessor(new IContentAssistProcessor() {
            @Override
            public ICompletionProposal[] computeCompletionProposals(ITextViewer textViewer, int offset) {
                String content = textViewer.getDocument().get();

                // --- Präfix bestimmen ---
                int start = offset;
                while (start > 0) {
                    char c = content.charAt(start - 1);
                    if (!Character.isLetterOrDigit(c) && c != '_') break;
                    start--;
                }
                String prefix = content.substring(start, offset);

                // --- Vorschläge sammeln ---
                Set<String> words = new TreeSet<>(String.CASE_INSENSITIVE_ORDER);

                // 1. Wörter aus dem Dokument
                Matcher matcher = Pattern.compile("\\b\\w+\\b").matcher(content);
                while (matcher.find()) {
                    words.add(matcher.group());
                }

                // 2. Tokens aus ZXTokens
                words.addAll(tokens.mMapRTokens.keySet());

                // --- Vorschläge filtern ---
                ArrayList<ICompletionProposal> proposals = new ArrayList<>();
                for (String word : words) {
                    if (prefix.isEmpty() || word.toUpperCase().startsWith(prefix.toUpperCase())) {
                        proposals.add(new CompletionProposal(
                                word,
                                start,
                                prefix.length(),
                                word.length()
                        ));
                    }
                }

                return proposals.toArray(new ICompletionProposal[0]);
            }

            @Override
            public IContextInformation[] computeContextInformation(ITextViewer viewer, int offset) { return null; }
            @Override
            public char[] getCompletionProposalAutoActivationCharacters() { return null; }
            @Override
            public char[] getContextInformationAutoActivationCharacters() { return null; }
            @Override
            public String getErrorMessage() { return null; }
            @Override
            public IContextInformationValidator getContextInformationValidator() { return null; }
        }, IDocument.DEFAULT_CONTENT_TYPE);

        assistant.install(viewer);

        shell.setSize(500, 400);
        shell.open();
        while (!shell.isDisposed()) {
            if (!display.readAndDispatch()) display.sleep();
        }
        display.dispose();
    }
}
