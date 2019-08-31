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
import java.util.Map;

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
            // apiNo:MM00
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
            // apiNo:WM03
            case "saveWallet": {
                Wallet wallet = new NativeLib.Wallet();
                Log.d("nativeLib=>", "saveWallet is enter =>");
                try {
                    wallet = (NativeLib.Wallet) (NativeLib.saveWallet((String) (call.argument("walletName")),
                            (byte[]) (call.argument("pwd")), (byte[]) (call.argument("mnemonic")), (int) (call.argument("walletType"))));
                } catch (Exception exception) {
                    Log.d("nativeLib=>", "exception is " + exception);
                }
                Log.d("nativeLib=>", "saveWallet.status is =>" + wallet.status);
                Log.d("nativeLib=>", "saveWallet.walletNmae is =>" + wallet.walletName);
                Log.d("nativeLib=>", "saveWallet.walletId is =>" + wallet.walletId);
                Log.d("nativeLib=>", "saveWallet.message is =>" + wallet.message);
                HashMap hashMap = new HashMap();
                hashMap.put("status", wallet.status);
                hashMap.put("walletId", wallet.walletId);
                hashMap.put("walletName", wallet.walletName);
                result.success(hashMap);
                break;
            }
            // apiNo:WM01
            case "isContainWallet": {
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
            // apiNo:WM02
            case "loadAllWalletList": {
                List<Map<String, Object>> resultWalletList = new ArrayList<>();  ///返回数据，拼装List<Map>
                List<Wallet> walletList = new ArrayList<Wallet>();               ///JNI拿到的数据List<Wallet>
                try {
                    walletList = NativeLib.loadAllWalletList();
                    Log.d("nativeLib=>", "walletList.size() is =>" + walletList.size());
                } catch (Exception exception) {
                    Log.d("nativeLib=>", "exception is " + exception);
                }
                if (walletList.isEmpty() || walletList.size() == 0) {
                    result.success(resultWalletList); ///empty wallet
                }
                for (int i = 0; i < walletList.size(); i++) {
                    Map<String, Object> walletMap = new HashMap<String, Object>();

                    walletMap.put("walletId", walletList.get(i).walletId);
                    walletMap.put("walletName", walletList.get(i).walletName);
                    //walletMap.put("walletType", walletList.get(i).walletType);
                    walletMap.put("nowChainId", walletList.get(i).nowChainId);
                    walletMap.put("creationTime", walletList.get(i).creationTime);

                    /*-------------------------组装eee链上数据 start-------------------------*/
                    Map<String, Object> resultEeeChain = new HashMap<>();
                    resultEeeChain.put("chainAddress", walletList.get(i).eeeChain.chainAddress);
                    resultEeeChain.put("chainId", walletList.get(i).eeeChain.chainId);
                    resultEeeChain.put("chainType", walletList.get(i).eeeChain.chainType);
                    resultEeeChain.put("isVisible", walletList.get(i).eeeChain.isVisible);
                    resultEeeChain.put("status", walletList.get(i).eeeChain.status);
                    resultEeeChain.put("walletId", walletList.get(i).eeeChain.walletId);
                    List<Map<String, Object>> eeeChainDigitList = new ArrayList<>();
                    List<EeeDigit> eeeDigitList = walletList.get(i).eeeChain.digitList;
                    for (int j = 0; j < eeeDigitList.size(); j++) {
                        Map<String, Object> digitMap = new HashMap<String, Object>();
                        digitMap.put("status", eeeDigitList.get(j).status);
                        digitMap.put("digitId", eeeDigitList.get(j).digitId);
                        digitMap.put("chainId", eeeDigitList.get(j).chainId);
                        digitMap.put("address", eeeDigitList.get(j).address);
                        digitMap.put("contractAddress", eeeDigitList.get(j).contractAddress);
                        digitMap.put("shortName", eeeDigitList.get(j).shortName);
                        digitMap.put("fullName", eeeDigitList.get(j).fullName);
                        digitMap.put("balance", eeeDigitList.get(j).balance);
                        digitMap.put("isVisible", eeeDigitList.get(j).isVisible);
                        digitMap.put("decimal", eeeDigitList.get(j).decimal);
                        digitMap.put("imgUrl", eeeDigitList.get(j).imgUrl);
                        eeeChainDigitList.add(digitMap);
                    }
                    resultEeeChain.put("eeeChainDigitList", eeeChainDigitList);
                    Log.d("nativeLib=>", "组装完EEE result resultEeeChain is ===>" + resultEeeChain.toString());
                    /*-------------------------组装eee链上数据 end---------------------------*/

                    /*-------------------------组装ETH链上数据 start-------------------------*/
                    List<Map<String, Object>> resultEthChain = new ArrayList<>();
                    if (walletList.get(i).ethChain != null) {
                        List<EthDigit> ethDigitList = walletList.get(i).ethChain.digitList;
                        for (int j = 0; j < ethDigitList.size(); j++) {
                            //todo
                        }
                    }
                    /*-------------------------组装ETH链上数据 end---------------------------*/

                    /*-------------------------组装BTC链上数据 start-------------------------*/
                    List<Map<String, Object>> resultBtcChain = new ArrayList<>();
                    if (walletList.get(i).btcChain != null) {
                        List<BtcDigit> btcDigitList = walletList.get(i).btcChain.digitList;
                        for (int j = 0; j < btcDigitList.size(); j++) {
                            //todo
                        }
                    }
                    /*-------------------------组装BTC链上数据 end -------------------------*/

                    ///每个钱包再加入组装好的各条链的信息
                    walletMap.put("eeeChain", resultEeeChain);
                    walletMap.put("ethChain", resultEthChain);
                    walletMap.put("btcChain", resultBtcChain);

                    ///钱包列表，加入拼装好的钱包
                    resultWalletList.add(walletMap);
                    Log.d("nativeLib=>", "拼装好的钱包  resultWalletList is ===>" + resultWalletList.toString());
                }
                result.success(resultWalletList);
                break;
            }
            // apiNo:WM06
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
            // apiNo:WM05
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
            // apiNo:WM07
            case "deleteWallet": {
                Log.d("nativeLib=>", "begin to deleteWallet =>");
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
            // apiNo:WM08
            case "resetPwd": {
                Log.d("nativeLib=>", "begin to resetPwd =>");
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
            // apiNo:WM04
            case "exportWallet": {
                Log.d("nativeLib=>", "begin to exportWallet =>");
                Wallet wallet = new Wallet();
                try {
                    wallet = NativeLib.exportWallet((String) (call.argument("walletId")), (byte[]) (call.argument("pwd")));
                } catch (Exception exception) {
                    Log.d("nativeLib=>", "exception is " + exception);
                }
                Log.d("nativeLib=>", "wallet.status is " + wallet.status);
                if (wallet.status == 200) {
                    //todo
                    //result.success(wallet.isResetPwd);
                } else {
                    result.error("something wrong", "", "");
                }

                break;
            }
            // apiNo:WM09 fixed
            case "rename": {
                Log.d("nativeLib=>", "begin to rename =>");
                WalletState walletState = new WalletState();
                try {
                    walletState = NativeLib.rename((String) (call.argument("walletId")), (String) (call.argument("walletName")));
                } catch (Exception exception) {
                    Log.d("nativeLib=>", "exception is " + exception);
                }
                Log.d("nativeLib=>", "walletState.status is " + walletState.status);
                if (walletState.status == 200) {
                    //todo
                    result.success(walletState.isRename);
                } else {
                    result.error("something wrong", "", "");
                }
                break;
            }
            // apiNo:WM10
            case "showChain": {
                Log.d("nativeLib=>", "begin to showChain =>");
                WalletState walletState = new WalletState();
                break;
            }
            // apiNo:WM11
            case "hideChain": {
                Log.d("nativeLib=>", "begin to hideChain =>");
                WalletState walletState = new WalletState();
                break;
            }
            // apiNo:WM12
            case "getNowChain": {
                Log.d("nativeLib=>", "begin to getNowChain =>");
                WalletState walletState = new WalletState();
                break;
            }
            // apiNo:WM13
            case "setNowChain": {
                Log.d("nativeLib=>", "begin to setNowChain =>");
                WalletState walletState = new WalletState();
                break;
            }
            // apiNo:WM14
            case "showDigit": {
                Log.d("nativeLib=>", "begin to showDigit =>");
                WalletState walletState = new WalletState();
                break;
            }
            // apiNo:WM15
            case "hideDigit": {
                Log.d("nativeLib=>", "begin to hideDigit =>");
                WalletState walletState = new WalletState();
                break;
            }
            default:
                result.notImplemented();
                break;
        }
    }
}
