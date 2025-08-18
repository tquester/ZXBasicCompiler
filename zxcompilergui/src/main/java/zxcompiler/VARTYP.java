package zxcompiler;

public enum VARTYP {
		TYPE_INT("INT"),
		TYPE_STRING("STRING"),
		TYPE_FLOAT("FLOAT"),
		TYPE_FIXSTRING("FIXSTR"),
		TYPE_UNDEF("UNDEF");
	private String description;
	
		VARTYP(String string) {
			description = string;
		}
}
