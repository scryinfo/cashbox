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
            case "saveWallet": {
                Wallet wallet = new NativeLib.Wallet();
                Log.d("nativeLib=>", "saveWallet is enter =>");
                try {
                    wallet = (NativeLib.Wallet) (NativeLib.saveWallet((String) (call.argument("walletName")), (byte[]) (call.argument("pwd")), (byte[]) (call.argument("mnemonic"))));
                } catch (Exception exception) {
                    Log.d("nativeLib=>", "exception is " + exception);
                }
                Log.d("nativeLib=>", "saveWallet.status is =>" + wallet.status);
                Log.d("nativeLib=>", "saveWallet.walletNmae is =>" + wallet.walletName);
                Log.d("nativeLib=>", "saveWallet.message is =>" + wallet.message);
                Log.d("nativeLib=>", "saveWallet.chainList.size() is =>" + wallet.chainList.size());//todo 暂时无链部分
                HashMap hashMap = new HashMap();
                hashMap.put("status", wallet.status);
                hashMap.put("walletId", wallet.walletId);
                hashMap.put("walletName", wallet.walletName);
                result.success(hashMap);
                break;
            }
            case "isContainWallet": {
                Log.d("nativeLib=>", "isContainWallet is enter =>");
                WalletState walletState = new NativeLib.WalletState();
                try {
                    walletState = (NativeLib.WalletState) (NativeLib.isContainWallet());
                } catch (Exception exception) {
                    Log.d("nativeLib=>", "exception is " + exception);
                }
                Log.d("nativeLib=>", "isContainWallet.status is =>" + walletState.status);
                Log.d("nativeLib=>", "isContainWallet is =>" + walletState.isContainWallet);
                HashMap hashMap = new HashMap();
                hashMap.put("isContainWallet", walletState.isContainWallet);
                result.success(hashMap);
                break;
            }
            case "loadAllWalletList": {
                List<Wallet> arrayList = new ArrayList<Wallet>();
                HashMap hashMap2 = new HashMap();
                try {
                    arrayList = NativeLib.loadAllWalletList();
                } catch (Exception exception) {
                    Log.d("nativeLib=>", "exception is " + exception);
                }
                Log.d("nativeLib=>", "arrayList.size() is =>" + arrayList.size());
                for (int i = 0; i < arrayList.size(); i++) {
                    Wallet wallet = new Wallet();
                    //arrayList.get(i).walletName;
                    Log.d("nativeLib=>", "arrayList.get(i) is =>" + arrayList.get(i).toString());
                    Log.d("nativeLib=>", "arrayList.get(i).walletId is =>" + arrayList.get(i).walletId);
                    Log.d("nativeLib=>", "arrayList.get(i).walletName is =>" + arrayList.get(i).walletName);
                }
                result.success(arrayList);
                break;
            }
            case "setNowWallet": {
                WalletState walletState = new WalletState();
                try {
                    walletState = NativeLib.setNowWallet((String) (call.argument("walletId")));
                } catch (Exception exception) {
                    Log.d("nativeLib=>", "exception is " + exception);
                }
                if (walletState.status == 200) {
                    result.success(walletState.isSetNowWallet);
                } else {
                    result.error("something wrong", "", "");
                }
                break;
            }

            case "getNowWallet": {
                WalletState walletState = new WalletState();
                try {
                    walletState = NativeLib.getNowWallet();
                } catch (Exception exception) {
                    Log.d("nativeLib=>", "exception is " + exception);
                }
                if (walletState.status == 200) {
                    result.success(walletState.walletId);
                } else {
                    result.error("something wrong", "", "");
                }
                break;
            }

            case "deleteWallet": {
                WalletState walletState = new WalletState();
                try {
                    walletState = NativeLib.deleteWallet((String) (call.argument("walletId")));
                } catch (Exception exception) {
                    Log.d("nativeLib=>", "exception is " + exception);
                }
                if (walletState.status == 200) {
                    Log.d("nativeLib=>", "walletState.status is " + walletState.status);
                    result.success(walletState.isDeletWallet);
                } else {
                    result.error("something wrong", "", "");
                }
                break;
            }
            case "resetPwd": {
                WalletState walletState = new WalletState();
                try {
                    walletState = NativeLib.resetPwd((String) (call.argument("walletId")), (byte[]) (call.argument("newPwd")), (byte[]) (call.argument("oldPwd")));
                } catch (Exception exception) {
                    Log.d("nativeLib=>", "exception is " + exception);
                }
                if (walletState.status == 200) {
                    Log.d("nativeLib=>", "walletState.status is " + walletState.status);
                    result.success(walletState.isResetPwd);
                } else {
                    result.error("something wrong", "", "");
                }
                break;
            }

            default:
                result.notImplemented();
                break;
        }
    }
}
