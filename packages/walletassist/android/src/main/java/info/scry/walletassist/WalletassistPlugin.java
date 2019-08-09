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
    public static void registerWith(Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "walletassist");
        channel.setMethodCallHandler(new WalletassistPlugin());
    }

    @Override
    public void onMethodCall(MethodCall call, Result result) {
        switch (call.method) {
            case "mnemonicGenerate": {
                Mnemonic mnemonicCls = new NativeLib.Mnemonic();
                try {
                    mnemonicCls = (NativeLib.Mnemonic) (NativeLib.mnemonicGenerate(call.argument("count")));
                } catch (Exception exception) {
                    Log.d("nativeLib=>", "exception is " + exception);
                }
                HashMap hashMap = new HashMap();
                hashMap.put("mn", mnemonicCls.mn);
                hashMap.put("mnId", mnemonicCls.mnId);
                hashMap.put("status", mnemonicCls.status);
                result.success(hashMap);
                break;
            }
            case "loadAllWalletList":
                ArrayList arrayList = new ArrayList();
                HashMap hashMap = new HashMap();
                try {
                     NativeLib.loadAllWalletList();
                } catch (Exception exception) {
                    Log.d("nativeLib=>", "exception is " + exception);
                }
                result.success(arrayList);
                break;
            case "setNowWallet":
                var walletId = call.argument("walletId");
                //todo 传参 调用 流程
                break;
            default:
                result.notImplemented();
                break;
        }
    }
}
