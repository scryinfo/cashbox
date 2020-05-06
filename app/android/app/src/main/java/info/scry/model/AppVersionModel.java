package info.scry.model;

public class AppVersionModel {
    private double version;
    private int code;
    public static final int Success = 0;
    public static final int Failure = 1;

    public double getVersion() {
        return version;
    }

    public void setVersion(int version) {
        this.version = version;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }
}
