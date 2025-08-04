package main;

public class ZX81CalcInputGenerator {
	 // Wandelt double in 5-Byte ZX FP um
    public static byte[] doubleToZXFloat(double value) {
        if (value == 0.0) {
            return new byte[] {0, 0, 0, 0, 0};
        }
        
        byte[] result = new byte[5];
        
        if (value == Math.floor(value)) { // int
        	result[0] = 0;
        	result[1] = 0;
        	result[2] = (byte)Math.floor(value % 256);
        	result[3] = (byte)Math.floor(value / 256);
        	result[4] = 0;
        	return result;
        }

        boolean negative = value < 0;
        if (negative) value = -value;

        // Zerlege in Mantisse und Exponent: value = m * 2^e, 0.5 <= m < 1
        int exponent = 0;
        double mantissa = value;
        while (mantissa >= 1.0) { mantissa /= 2.0; exponent++; }
        while (mantissa < 0.5)  { mantissa *= 2.0; exponent--; }

        // ZX-Exponent mit Bias
        result[0] = (byte) (exponent + 128);

        // Mantisse auf 32 Bit skalieren
        long mant = (long) (mantissa * (1L << 32));

        // Vorzeichenbit setzen (Bit 7 im ersten Mantissenbyte)
        if (negative) mant |= 0x80000000L;

        // Mantisse in Bytes
        result[1] = (byte) ((mant >> 24) & 0xFF);
        result[2] = (byte) ((mant >> 16) & 0xFF);
        result[3] = (byte) ((mant >> 8) & 0xFF);
        result[4] = (byte) (mant & 0xFF);

        return result;
    }

    // Kürzt rechte Nullbytes der Mantisse (mindestens 1 Mantissenbyte behalten)
    public static byte[] shortenMantissa(byte[] fp5) {
        if (fp5 == null || fp5.length != 5) throw new IllegalArgumentException("fp5 must be 5 bytes");

        int len = 5;
        while (len > 2 && fp5[len - 1] == 0) {
            len--;
        }
        byte[] shortened = new byte[len];
        System.arraycopy(fp5, 0, shortened, 0, len);
        return shortened;
    }

    public static void generateCalcInput(double value) {
        byte[] fullFP = doubleToZXFloat(value);
        byte[] shortened = shortenMantissa(fullFP);

        System.out.println("RST $28");
        System.out.print("DB $34");
        for (int i = 0; i < shortened.length; i++) {
            System.out.printf(", $%02X", shortened[i] & 0xFF);
        }
        System.out.println();
        System.out.println("DB $38 ; end-calc");
    }

    public static void main(String[] args) {
        double[] testValues = {0.0, 1.0, -1.0, 123.456, 3.1415926535, 0.5, 0.25, -0.125};

        for (double v : testValues) {
            System.out.printf("; Wert: %f\n", v);
            generateCalcInput(v);
            System.out.println();
        }
    }
}
