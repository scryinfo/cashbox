package info.scry.walletassist;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import info.scry.walletassist.NativeLib.*;

import android.util.Log;

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

//    public static class Mnemonic {
//        public int status;
//        public byte[] mn;
//        public String mnId; //todo mnID的生成规则？ uuid or hash
//    }

    @Override
    public void onMethodCall(MethodCall call, Result result) {
        if (call.method.equals("getPlatformVersion")) {
            result.success("Android " + android.os.Build.VERSION.RELEASE);
        } else if (call.method.equals("mnemonicGenerate")) {
            Log.d("nativeLib=>", "begin in~~~");

            Mnemonic mnemonic;
            try {
                NativeLib.mnemonicGenerate(12);
            } catch (Exception exception) {
                Log.d("nativeLib=>", "exception is " + exception);
            }
            //Log.d("nativeLib=>", "mnemonic" + mnemonic);
            //result.success("mnemonicGenerate" + mnemonic);
        } else {
            result.notImplemented();
        }
    }
}
