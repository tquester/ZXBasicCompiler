package main;

public class COSDetector {
	public enum OS {
		UNKNOWN,
		WINDOWS,
		LINUX,
		MACOS
	}
	
	static OS detectOS() {
        String os = System.getProperty("os.name").toLowerCase();

        if (os.contains("win")) return OS.WINDOWS;
        else if (os.contains("mac")) return OS.MACOS;
        else if (os.contains("nix") || os.contains("nux") || os.contains("aix")) return OS.LINUX;
        return OS.UNKNOWN;
	}

}
