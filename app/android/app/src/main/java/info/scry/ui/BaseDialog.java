package info.scry.ui;

import android.app.Dialog;
import android.content.Context;


public class BaseDialog extends Dialog {
    private int res;

    public BaseDialog(Context context, int theme, int res) {
        super(context, theme);
        // TODO automatically generated constructor stub
        setContentView(res);
        this.res = res;
        setCanceledOnTouchOutside(false);
    }

}