
public class Native{
    static {
        System.loadLibrary("wallet");
    }

    public static native String mnemonicGenerate(int count);

}