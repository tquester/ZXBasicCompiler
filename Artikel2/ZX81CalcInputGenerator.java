package zxcompiler;

public class ZX81CalcInputGenerator {
	 // Wandelt double in 5-Byte ZX FP um
    public static byte[] doubleToZXFloat(double value) {
        if (value == 0.0) {
            return new byte[] {0, 0, 0, 0, 0};
        }

        int sign = 0;
        if (value < 0) {
            sign = 0x80;
            value = -value;
        }

        int exp = 0;
        double mantissa = value;

        // Normalisiere Mantisse auf [1.0, 2.0)
        while (mantissa >= 2.0) {
            mantissa /= 2.0;
            exp++;
        }
        while (mantissa < 1.0) {
            mantissa *= 2.0;
            exp--;
        }

        // Exponent mit Bias 128 und Vorzeichenbit
        int expByte = (exp + 128) & 0x7F;
        expByte |= sign;

        mantissa -= 1.0; // implizite 1 entfernen

        long mantissaInt = (long)(mantissa * (1L << 32));

        byte[] result = new byte[5];
        result[0] = (byte) expByte;
        result[1] = (byte) ((mantissaInt >> 24) & 0xFF);
        result[2] = (byte) ((mantissaInt >> 16) & 0xFF);
        result[3] = (byte) ((mantissaInt >> 8) & 0xFF);
        result[4] = (byte) (mantissaInt & 0xFF);

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
