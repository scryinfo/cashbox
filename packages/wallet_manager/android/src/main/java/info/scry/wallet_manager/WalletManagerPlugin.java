package info.scry.wallet_manager;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import info.scry.wallet_manager.NativeLib.*;

import java.util.ArrayList;
import java.util.List;
import java.util.HashMap;

import android.util.Log;

public class WalletManagerPlugin implements MethodCallHandler {
    /**
     * Plugin registration.
     */
    public static void registerWith(Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "wallet_manager");
        channel.setMethodCallHandler(new WalletManagerPlugin());
    }

    @Override
    public void onMethodCall(MethodCall call, Result result) {
        switch (call.method) {
            case "createNewWallet":
                break;
            case "mnemonicGenerate": {
                Mnemonic mnemonicCls = new NativeLib.Mnemonic();
                try {
                    mnemonicCls = (NativeLib.Mnemonic) (NativeLib.mnemonicGenerate((int) (call.argument("count"))));
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
                    NativeLib.WalletLoadAllWalletList();
                } catch (Exception exception) {
                    Log.d("nativeLib=>", "exception is " + exception);
                }
                result.success(arrayList);
                break;
            case "setNowWallet":
                String walletId = call.argument("walletId");
                //todo 传参 调用 流程
                break;
            default:
                result.notImplemented();
                break;
        }
    }
}
