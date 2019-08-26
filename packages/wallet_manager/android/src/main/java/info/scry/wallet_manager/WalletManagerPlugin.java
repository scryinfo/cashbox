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
            case "isContainWallet":
                Log.d("nativeLib=>", "isContainWallet is enter =>");
                WalletState walletState = new NativeLib.WalletState();
                try {
                    walletState = (NativeLib.WalletState) (NativeLib.isContainWallet());
                } catch (Exception exception) {
                    Log.d("nativeLib=>", "exception is " + exception);
                }
                Log.d("nativeLib=>", "isContainWallet is =>" + walletState.isContainWallet);
            case "saveWallet":
                Wallet wallet = new NativeLib.Wallet();
                Log.d("nativeLib=>", "saveWallet is enter =>");
                try {
                    wallet = (NativeLib.Wallet) (NativeLib.saveWallet((String)(call.argument("walletName")),(byte[])(call.argument("pwd")),(byte[])(call.argument("mnemonic"))));
                } catch (Exception exception) {
                    Log.d("nativeLib=>", "exception is " + exception);
                }
                Log.d("nativeLib=>", "saveWallet.status is =>" + wallet.status);
                Log.d("nativeLib=>", "saveWallet.walletNmae is =>" + wallet.walletName);
                Log.d("nativeLib=>", "saveWallet.walletNmae is =>" + wallet.message);
                HashMap hashMap = new HashMap();
                hashMap.put("status", wallet.status);
                hashMap.put("walletId", wallet.walletId);
                hashMap.put("walletName", wallet.walletName);
                result.success(hashMap);
                break;
            case "mnemonicGenerate": {
                Mnemonic mnemonicCls = new NativeLib.Mnemonic();
                try {
                    mnemonicCls = (NativeLib.Mnemonic) (NativeLib.mnemonicGenerate((int) (call.argument("count"))));
                } catch (Exception exception) {
                    Log.d("nativeLib=>", "exception is " + exception);
                }
                HashMap hashMap1 = new HashMap();
                hashMap1.put("mn", mnemonicCls.mn);
                hashMap1.put("mnId", mnemonicCls.mnId);
                hashMap1.put("status", mnemonicCls.status);
                result.success(hashMap1);
                break;
            }
            case "loadAllWalletList":
                ArrayList arrayList = new ArrayList();
                HashMap hashMap2 = new HashMap();
                try {
                    NativeLib.loadAllWalletList();
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
