package info.scry.walletassist;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import info.scry.walletassist.NativeLib.*;

import android.util.Log;

import java.util.HashMap;

/**
 * WalletassistPlugin
 */
public class WalletassistPlugin implements MethodCallHandler {
    /**
     * Plugin registration.
     */
    public static void registerWith(Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "walletassist");
        channel.setMethodCallHandler(new WalletassistPlugin());
    }

    @Override
    public void onMethodCall(MethodCall call, Result result) {
        if (call.method.equals("mnemonicGenerate")) {
            Mnemonic mnemonicCls = new NativeLib.Mnemonic();
            try {
                mnemonicCls = (NativeLib.Mnemonic) (NativeLib.mnemonicGenerate(12));
            } catch (Exception exception) {
                Log.d("nativeLib=>", "exception is " + exception);
            }
            HashMap hashMap = new HashMap();
            hashMap.put("mn", mnemonicCls.mn);
            hashMap.put("mnId", mnemonicCls.mnId);
            hashMap.put("status", mnemonicCls.status);
            result.success(hashMap);
        } else {
            result.notImplemented();
        }
    }
}
