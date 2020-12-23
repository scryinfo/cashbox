package info.scry.wallet_manager;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import info.scry.wallet_manager.NativeLib.*;
// import info.scry.wallet_manager.BtcLib.*;
import info.scry.wallet_manager.ScryWalletLog;

import java.util.ArrayList;
import java.util.List;
import java.util.HashMap;
import java.util.Map;

import android.util.Log;

public class WalletManagerPlugin implements MethodCallHandler {
    private static Registrar registrar;

    /**
     * Plugin registration.
     */
    public static void registerWith(Registrar registrar) {
        WalletManagerPlugin.registrar = registrar;
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
                    mnemonicCls =
                            (NativeLib.Mnemonic) (NativeLib.mnemonicGenerate((int) (call.argument("count"))));
                } catch (Exception exception) {
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>", "exception is " + exception);
                }
                HashMap hashMap1 = new HashMap();

                hashMap1.put("status", mnemonicCls.status);
                if (mnemonicCls.status == 200) {
                    hashMap1.put("mn", mnemonicCls.mn);
                    hashMap1.put("mnId", mnemonicCls.mnId);
                } else {
                    hashMap1.put("message", mnemonicCls.message);
                }
                result.success(hashMap1);
                break;
            }
            // apiNo:WM03
            case "saveWallet": {
                Wallet wallet = new NativeLib.Wallet();
                ScryWalletLog.d(registrar.activity(), "nativeLib=>", "saveWallet is enter =>");
                // String mne = new String((byte[]) (call.argument("mnemonic")));
                try {
                    wallet = (NativeLib.Wallet) (NativeLib.saveWallet((String) (call.argument(
                            "walletName")),
                            (byte[]) (call.argument("pwd")), (byte[]) (call.argument("mnemonic"))
                            , (int) (call.argument("walletType"))));
                } catch (Exception exception) {
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>", "exception is " + exception);
                }
                ScryWalletLog.d(registrar.activity(), "nativeLib=>", "saveWallet is =>" + wallet);
                ScryWalletLog.d(registrar.activity(), "nativeLib=>", "saveWallet.status is =>" + wallet.status);
                ScryWalletLog.d(registrar.activity(), "nativeLib=>", "saveWallet.walletName is =>" + wallet.walletName);
                ScryWalletLog.d(registrar.activity(), "nativeLib=>", "saveWallet.walletId is =>" + wallet.walletId);
                ScryWalletLog.d(registrar.activity(), "nativeLib=>", "saveWallet.message is =>" + wallet.message);
                HashMap hashMap = new HashMap();
                hashMap.put("status", wallet.status);  ///todo 后续空时间调整，返回类型不用wallet，只需状态码。
                result.success(hashMap);
                break;
            }
            // apiNo:WM01
            case "isContainWallet": {
                WalletState walletState = new NativeLib.WalletState();
                try {
                    walletState = (NativeLib.WalletState) (NativeLib.isContainWallet());
                } catch (Exception exception) {
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>", "isContainWallet exception is " + exception);
                }
                ScryWalletLog.d(registrar.activity(), "nativeLib=>", "isContainWallet.status is =>" + walletState.status);
                HashMap hashMap = new HashMap();
                hashMap.put("status", walletState.status);
                if (walletState.status == 200) {
                    hashMap.put("isContainWallet", walletState.isContainWallet);
                } else {
                    hashMap.put("message", walletState.message);
                }
                result.success(hashMap);
                break;
            }
            // apiNo:WM02
            case "loadAllWalletList": {
                List<Map<String, Object>> resultWalletList = new ArrayList<>();  ///返回数据，拼装List<Map>
                List<Wallet> walletList = new ArrayList<Wallet>();               ///JNI拿到的数据List
                // <Wallet>
                try {
                    walletList = NativeLib.loadAllWalletList();
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>", "walletList.size() is =>" + walletList.size());
                } catch (Exception exception) {
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>", "exception is " + exception);
                }
                if (walletList.isEmpty() || walletList.size() == 0) {
                    result.success(resultWalletList); ///empty wallet
                }
                for (int i = 0; i < walletList.size(); i++) {
                    int walletIndex = i;
                    Map<String, Object> walletMap = new HashMap<String, Object>();
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>",
                            "walletList.get(walletIndex) =>" + walletList.get(walletIndex).toString());
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>",
                            "walletList.get(walletIndex).walletType is ===>" + walletList.get(walletIndex).walletType);
                    if (walletList.get(walletIndex).walletType == WalletType.TEST_WALLET) {
                        walletMap.put("walletType", 0);
                    } else {
                        walletMap.put("walletType", 1);
                    }
                    walletMap.put("status", walletList.get(walletIndex).status);
                    walletMap.put("walletId", walletList.get(walletIndex).walletId);
                    walletMap.put("walletName", walletList.get(walletIndex).walletName);
                    walletMap.put("isNowWallet", walletList.get(walletIndex).isNowWallet);
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>",
                            "isNowWallet is =>" + walletList.get(walletIndex).isNowWallet + "");
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>",
                            "nowChainId is =>" + walletList.get(walletIndex).nowChainId);
                    walletMap.put("nowChainId", walletList.get(walletIndex).nowChainId);
                    walletMap.put("creationTime", walletList.get(walletIndex).creationTime);

                    /*-------------------------组装eee链上数据 start-------------------------*/
                    Map<String, Object> resultEeeChain = new HashMap<>();
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>", "walletList.get(walletIndex).eeeChain is =>" + walletList.get(walletIndex).eeeChain.toString());
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>", "walletList.get(walletIndex).ethChain is =>" + walletList.get(walletIndex).ethChain.toString());
                    resultEeeChain.put("chainAddress",
                            walletList.get(walletIndex).eeeChain.address);
                    resultEeeChain.put("chainId", walletList.get(walletIndex).eeeChain.chainId);
                    resultEeeChain.put("chainType", walletList.get(walletIndex).eeeChain.chainType);
                    resultEeeChain.put("isVisible", walletList.get(walletIndex).eeeChain.isVisible);
                    resultEeeChain.put("status", walletList.get(walletIndex).eeeChain.status);
                    resultEeeChain.put("pubkey", walletList.get(walletIndex).eeeChain.pubkey);
                    resultEeeChain.put("walletId", walletList.get(walletIndex).eeeChain.walletId);
                    List<Map<String, Object>> eeeChainDigitList = new ArrayList<>();
                    List<EeeDigit> eeeDigitList = walletList.get(walletIndex).eeeChain.digitList;
                    for (int j = 0; j < eeeDigitList.size(); j++) {
                        int digitIndex = j;
                        Map<String, Object> digitMap = new HashMap<String, Object>();

                        digitMap.put("status", eeeDigitList.get(digitIndex).status);
                        digitMap.put("digitId", eeeDigitList.get(digitIndex).digitId);
                        digitMap.put("chainId", eeeDigitList.get(digitIndex).chainId);
                        digitMap.put("contractAddress",
                                eeeDigitList.get(digitIndex).contractAddress);
                        digitMap.put("shortName", eeeDigitList.get(digitIndex).shortName);
                        digitMap.put("fullName", eeeDigitList.get(digitIndex).fullName);
                        digitMap.put("balance", eeeDigitList.get(digitIndex).balance);
                        digitMap.put("isVisible", eeeDigitList.get(digitIndex).isVisible);
                        digitMap.put("decimal", eeeDigitList.get(digitIndex).decimal);
                        digitMap.put("imgUrl", eeeDigitList.get(digitIndex).imgUrl);
                        eeeChainDigitList.add(digitMap);
                    }
                    resultEeeChain.put("eeeChainDigitList", eeeChainDigitList);
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>", "组装完EEE链 result resultEeeChain is ===>" + resultEeeChain.toString());
                    /*-------------------------组装eee链上数据 end---------------------------*/

                    /*-------------------------组装ETH链上数据 start-------------------------*/
                    Map<String, Object> resultEthChain = new HashMap<>();
                    resultEthChain.put("chainAddress",
                            walletList.get(walletIndex).ethChain.address);
                    //ScryWalletLog.d(registrar.activity(),"nativeLib=>","Eth链 chainAddresss ===>" + walletList.get(walletIndex).ethChain.address.toString());
                    resultEthChain.put("chainId", walletList.get(walletIndex).ethChain.chainId);
                    resultEthChain.put("chainType", walletList.get(walletIndex).ethChain.chainType);
                    resultEthChain.put("isVisible", walletList.get(walletIndex).ethChain.isVisible);
                    resultEthChain.put("status", walletList.get(walletIndex).ethChain.status);
                    resultEthChain.put("pubkey", walletList.get(walletIndex).ethChain.pubkey);
                    resultEthChain.put("walletId", walletList.get(walletIndex).ethChain.walletId);
                    if (walletList.get(walletIndex).ethChain != null) {
                        List<EthDigit> ethDigitList =
                                walletList.get(walletIndex).ethChain.digitList;
                        List<Map<String, Object>> ethChainDigitList = new ArrayList<>();
                        for (int j = 0; j < ethDigitList.size(); j++) {
                            int digitIndex = j;
                            Map<String, Object> digitMap = new HashMap<String, Object>();

                            digitMap.put("status", ethDigitList.get(digitIndex).status);
                            digitMap.put("digitId", ethDigitList.get(digitIndex).digitId);
                            digitMap.put("chainId", ethDigitList.get(digitIndex).chainId);
                            digitMap.put("contractAddress",
                                    ethDigitList.get(digitIndex).contractAddress);
                            digitMap.put("shortName", ethDigitList.get(digitIndex).shortName);
                            digitMap.put("fullName", ethDigitList.get(digitIndex).fullName);
                            digitMap.put("balance", ethDigitList.get(digitIndex).balance);
                            digitMap.put("isVisible", ethDigitList.get(digitIndex).isVisible);
                            digitMap.put("decimal", ethDigitList.get(digitIndex).decimal);
                            digitMap.put("imgUrl", ethDigitList.get(digitIndex).imgUrl);
                            ethChainDigitList.add(digitMap);
                        }
                        //ScryWalletLog.d(registrar.activity(),"nativeLib=>","Eth链 ethChainDigitList.toString() ===>" + ethChainDigitList.toString());
                        resultEthChain.put("ethChainDigitList", ethChainDigitList);
                    }
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>", "组装完ETh链 result resultEthChain is ===>" + resultEthChain.toString());
                    /*-------------------------组装ETH链上数据 end---------------------------*/

                    /*-------------------------组装BTC链上数据 start-------------------------*/
                    Map<String, Object> resultBtcChain = new HashMap<>();
                    resultBtcChain.put("chainAddress", walletList.get(walletIndex).btcChain.address);
                    resultBtcChain.put("chainId", walletList.get(walletIndex).btcChain.chainId);
                    resultBtcChain.put("chainType", walletList.get(walletIndex).btcChain.chainType);
                    resultBtcChain.put("isVisible", walletList.get(walletIndex).btcChain.isVisible);
                    resultBtcChain.put("status", walletList.get(walletIndex).btcChain.status);
                    resultBtcChain.put("pubkey", walletList.get(walletIndex).btcChain.pubkey);
                    resultBtcChain.put("walletId", walletList.get(walletIndex).btcChain.walletId);
                    if (walletList.get(walletIndex).btcChain != null) {
                        List<BtcDigit> btcDigitList = walletList.get(walletIndex).btcChain.digitList;
                        ScryWalletLog.d(registrar.activity(), "nativeLib=>", "btcDigitList.size().toString() ===>" + btcDigitList.size());
                        List<Map<String, Object>> btcChainDigitList = new ArrayList<>();
                        for (int j = 0; j < btcDigitList.size(); j++) {
                            int digitIndex = j;
                            Map<String, Object> digitMap = new HashMap<String, Object>();
                            digitMap.put("status", btcDigitList.get(digitIndex).status);
                            digitMap.put("digitId", btcDigitList.get(digitIndex).digitId);
                            digitMap.put("chainId", btcDigitList.get(digitIndex).chainId);
                            digitMap.put("shortName", btcDigitList.get(digitIndex).shortName);
                            digitMap.put("fullName", btcDigitList.get(digitIndex).fullName);
                            digitMap.put("balance", btcDigitList.get(digitIndex).balance);
                            digitMap.put("isVisible", btcDigitList.get(digitIndex).isVisible);
                            digitMap.put("decimal", btcDigitList.get(digitIndex).decimal);
                            digitMap.put("imgUrl", btcDigitList.get(digitIndex).imgUrl);
                            btcChainDigitList.add(digitMap);
                        }
                        ScryWalletLog.d(registrar.activity(), "nativeLib=>", "Btc链 btcChainDigitList.toString() ===>" + btcChainDigitList.toString());
                        resultBtcChain.put("btcChainDigitList", btcChainDigitList);
                    }
                    /*-------------------------组装BTC链上数据 end -------------------------*/

                    ///每个钱包再加入组装好的各条链的信息
                    walletMap.put("eeeChain", resultEeeChain);
                    walletMap.put("ethChain", resultEthChain);
                    walletMap.put("btcChain", resultBtcChain);

                    ///钱包列表，加入拼装好的钱包
                    resultWalletList.add(walletMap);
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>",
                            "拼装好一个 walletMap  index is===>" + walletIndex + " ||  " + "walletMap " +
                                    " is ===>" + walletMap.toString());
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>",
                            "拼装好zong内部钱包个数.siez()is===>" + resultWalletList.size() + " || " +
                                    "resultWalletList is ===>" + resultWalletList.toString());
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
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>", "exception is " + exception);
                }
                HashMap hashMap = new HashMap();
                hashMap.put("status", walletState.status);
                if (walletState.status == 200) {
                    hashMap.put("isSetNowWallet", walletState.isSetNowWallet);
                } else {
                    hashMap.put("message", walletState.message);
                }
                result.success(hashMap);
                break;
            }
            // apiNo:WM05
            case "getNowWallet": {
                WalletState walletState = new WalletState();
                try {
                    walletState = NativeLib.getNowWallet();
                } catch (Exception exception) {
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>", "exception is " + exception);
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
                ScryWalletLog.d(registrar.activity(), "nativeLib=>", "begin to deleteWallet =>");
                WalletState walletState = new WalletState();
                try {
                    walletState = NativeLib.deleteWallet((String) (call.argument("walletId")),
                            (byte[]) (call.argument("pwd")));
                } catch (Exception exception) {
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>", "exception is " + exception);
                }
                Map resultMap = new HashMap();
                resultMap.put("status", walletState.status);
                if (walletState.status == 200) {
                    resultMap.put("isDeletWallet", walletState.isDeletWallet);
                } else {
                    resultMap.put("message", walletState.message);
                }
                result.success(resultMap);
                break;
            }
            // apiNo:WM08
            case "resetPwd": {
                ScryWalletLog.d(registrar.activity(), "nativeLib=>", "begin to resetPwd =>");
                WalletState walletState = new WalletState();
                try {
                    walletState = NativeLib.resetPwd((String) (call.argument("walletId")),
                            (byte[]) (call.argument("newPwd")),
                            (byte[]) (call.argument("oldPwd")));
                } catch (Exception exception) {
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>", "exception is " + exception);
                }
                ScryWalletLog.d(registrar.activity(), "nativeLib=>", "walletState.status is " + walletState.status);
                ScryWalletLog.d(registrar.activity(), "nativeLib=>",
                        "walletState.isResetPwd is " + walletState.isResetPwd);
                ScryWalletLog.d(registrar.activity(), "nativeLib=>", "walletState.message is " + walletState.message);
                Map resultMap = new HashMap();
                resultMap.put("status", walletState.status);
                if (walletState.status == 200) {
                    resultMap.put("isResetPwd", walletState.isResetPwd);
                } else {
                    resultMap.put("message", walletState.message);
                }
                result.success(resultMap);
                break;
            }
            // apiNo:WM04
            case "exportWallet": {
                ScryWalletLog.d(registrar.activity(), "nativeLib=>", "begin to exportWallet =>");
                Mnemonic mnemonic = new Mnemonic();
                try {
                    mnemonic = NativeLib.exportWallet((String) (call.argument("walletId")),
                            (byte[]) (call.argument("pwd")));
                } catch (Exception exception) {
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>", "exception is " + exception);
                }
                ScryWalletLog.d(registrar.activity(), "nativeLib=>", "mnemonic.status is " + mnemonic.status);
                Map resultMap = new HashMap();
                resultMap.put("status", mnemonic.status);
                if (mnemonic.status == 200) {
                    resultMap.put("mnId", mnemonic.mnId);
                    resultMap.put("mn", mnemonic.mn);
                } else {
                    resultMap.put("message", mnemonic.message);
                }
                result.success(resultMap);
                break;
            }
            // apiNo:WM09
            case "rename": {
                ScryWalletLog.d(registrar.activity(), "nativeLib=>", "begin to rename =>");
                ScryWalletLog.d(registrar.activity(), "nativeLib=>", "new walletName is =>" + (String) (call.argument(
                        "walletName"
                )));
                ScryWalletLog.d(registrar.activity(), "nativeLib=>", " walletId is =>" + (String) (call.argument(
                        "walletId")));
                WalletState walletState = new WalletState();
                try {
                    walletState = NativeLib.rename((String) (call.argument("walletId")),
                            (String) (call.argument("walletName")));
                } catch (Exception exception) {
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>", "exception is " + exception);
                }
                ScryWalletLog.d(registrar.activity(), "nativeLib=>", "walletState.status is " + walletState.status);
                ScryWalletLog.d(registrar.activity(), "nativeLib=>", "walletState.isRename is " + walletState.isRename);
                Map resultMap = new HashMap();
                resultMap.put("status", walletState.status);
                if (walletState.status == 200) {
                    resultMap.put("isRename", walletState.isRename);
                } else {
                    resultMap.put("message", walletState.message);
                }
                result.success(resultMap);
                break;
            }
            // apiNo:WM10
            case "showChain": {
                ScryWalletLog.d(registrar.activity(), "nativeLib=>", "begin to showChain =>");
                ScryWalletLog.d(registrar.activity(), "nativeLib=>", "walletId is =>" + (String) (call.argument(
                        "walletId")));
                WalletState walletState = new WalletState();
                try {
                    walletState = NativeLib.showChain((String) (call.argument("walletId")),
                            (int) (call.argument("chainType")));
                } catch (Exception exception) {
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>", "exception is " + exception);
                }
                Map resultMap = new HashMap();
                resultMap.put("status", walletState.status);
                if (walletState.status == 200) {
                    resultMap.put("isShowChain", walletState.isShowChain);
                } else {
                    resultMap.put("message", walletState.message);
                }
                result.success(resultMap);
                break;
            }
            // apiNo:WM11
            case "hideChain": {
                ScryWalletLog.d(registrar.activity(), "nativeLib=>", "begin to hideChain =>");
                ScryWalletLog.d(registrar.activity(), "nativeLib=>", "walletId is =>" + (String) (call.argument(
                        "walletId")));
                WalletState walletState = new WalletState();
                try {
                    walletState = NativeLib.hideChain((String) (call.argument("walletId")),
                            (int) (call.argument("chainType")));
                } catch (Exception exception) {
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>", "exception is " + exception);
                }
                Map resultMap = new HashMap();
                resultMap.put("status", walletState.status);
                if (walletState.status == 200) {
                    resultMap.put("isHideChain", walletState.isHideChain);
                } else {
                    resultMap.put("message", walletState.message);
                }
                result.success(resultMap);
                break;
            }
            // apiNo:WM12
            case "getNowChain": {
                ScryWalletLog.d(registrar.activity(), "nativeLib=>", "begin to getNowChain =>");
                WalletState walletState = new WalletState();
                try {
                    walletState = NativeLib.getNowChainType((String) (call.argument("walletId")));
                } catch (Exception exception) {
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>", "exception is " + exception);
                }
                Map resultMap = new HashMap();
                resultMap.put("status", walletState.status);
                if (walletState.status == 200) {
                    resultMap.put("getNowChainType", walletState.getNowChainType);
                } else {
                    resultMap.put("message", walletState.message);
                }
                result.success(resultMap);
                break;
            }
            // apiNo:WM13
            case "setNowChainType": {
                ScryWalletLog.d(registrar.activity(), "nativeLib=>", "begin to setNowChain =>");
                WalletState walletState = new WalletState();
                try {
                    walletState = NativeLib.setNowChainType((String) (call.argument("walletId")),
                            (int) (call.argument("chainType")));
                } catch (Exception exception) {
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>", "exception is " + exception);
                }
                Map resultMap = new HashMap();
                ScryWalletLog.d(registrar.activity(), "nativeLib=>", "walletState.status is " + walletState.status);
                ScryWalletLog.d(registrar.activity(), "nativeLib=>", "walletState.message is " + walletState.message);
                resultMap.put("status", walletState.status);
                if (walletState.status == 200) {
                    resultMap.put("isSetNowChain", walletState.isSetNowChain);
                } else {
                    resultMap.put("message", walletState.message);
                }
                result.success(resultMap);
                break;
            }
            // apiNo:WM14
            case "showDigit": {
                ScryWalletLog.d(registrar.activity(), "nativeLib=>", "begin to showDigit =>");
                WalletState walletState = new WalletState();
                try {
                    walletState = NativeLib.showDigit((String) (call.argument("walletId")), (int) (call.argument("chainType")),
                            (String) (call.argument("digitId")));
                } catch (Exception exception) {
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>", "showDigit exception is " + exception);
                }
                Map resultMap = new HashMap();
                resultMap.put("status", walletState.status);
                resultMap.put("isShowDigit", walletState.isShowDigit);
                result.success(resultMap);
                break;
            }
            // apiNo:WM15
            case "hideDigit": {
                ScryWalletLog.d(registrar.activity(), "nativeLib=>", "begin to hideDigit =>");
                WalletState walletState = new WalletState();
                try {
                    walletState = NativeLib.hideDigit((String) (call.argument("walletId")), (int) (call.argument("chainType")),
                            (String) (call.argument("digitId")));
                } catch (Exception exception) {
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>", "hideDigit exception is " + exception);
                }
                Map resultMap = new HashMap();
                resultMap.put("status", walletState.status);
                resultMap.put("isHideDigit", walletState.isHideDigit);
                result.success(resultMap);
                break;
            }
            case "tokenXTransfer": { //todo change parameter
                ScryWalletLog.d(registrar.activity(), "nativeLib=>", "tokenXTransfer =>");
                Message message = new Message();
                // ScryWalletLog.d(registrar.activity(),"nativeLib=>", "from==>" + (String) (call.argument("from")) + "||to" + (String) (call.argument("to")) + "||value" + call.argument("value"));
                // ScryWalletLog.d(registrar.activity(),"nativeLib=>", "extData==>" + call.argument("extData"));
                // ScryWalletLog.d(registrar.activity(),"nativeLib=>", "genesisHash==>" + call.argument("genesisHash"));
                // ScryWalletLog.d(registrar.activity(),"nativeLib=>", "index==>" + (int) (call.argument("index")));
                // ScryWalletLog.d(registrar.activity(),"nativeLib=>", "runtime_version==>" + (int) (call.argument("runtime_version")));
                // ScryWalletLog.d(registrar.activity(),"nativeLib=>", "tx_version==>" + (int) (call.argument("tx_version")));

                try {
                    message = NativeLib.tokenXTransfer((String) (call.argument("from")),
                            (String) (call.argument("to")), (String) (call.argument("value")), (String) (call.argument("extData")),
                            (int) (call.argument("index")), (byte[]) (call.argument("pwd")));
                } catch (Exception exception) {
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>", "eeeEnergyTransfer exception is " + exception);
                }
                Map resultMap = new HashMap();
                resultMap.put("status", message.status);
                if (message.status == 200) {
                    resultMap.put("signedInfo", message.signedInfo);
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>",
                            "message.signedInfo is " + message.signedInfo.toString());
                } else {
                    resultMap.put("message", message.message);
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>", "message.status is " + message.status + "||message.message is " + message.message.toString());
                }
                result.success(resultMap);
                break;
            }
            case "loadEeeChainTxListHistory": {
                ScryWalletLog.d(registrar.activity(), "nativeLib=>", "loadEeeChainTxListHistory =>");
                EeeChainTxListHistory eeeChainTxListHistory = new EeeChainTxListHistory();
                try {
                    eeeChainTxListHistory = NativeLib.loadEeeChainTxListHistory((String) (call.argument("account")),
                            (String) (call.argument("tokenName")), (int) (call.argument("startIndex")), (int) (call.argument("offset")));
                } catch (Exception exception) {
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>", "loadEeeChainTxListHistory exception is " + exception);
                }
                Map resultMap = new HashMap();
                resultMap.put("status", eeeChainTxListHistory.status);
                List<Map<String, Object>> resultEeeChainTxList = new ArrayList<>();  ///返回数据，拼装List<Map>
                if (eeeChainTxListHistory.status == 200) {
                    for (int i = 0; i < eeeChainTxListHistory.eeeChainTxDetail.size(); i++) {
                        Map<String, Object> detailMap = new HashMap<>();
                        detailMap.put("blockHash", eeeChainTxListHistory.eeeChainTxDetail.get(i).blockHash);
                        detailMap.put("from", eeeChainTxListHistory.eeeChainTxDetail.get(i).from);
                        detailMap.put("to", eeeChainTxListHistory.eeeChainTxDetail.get(i).to);
                        detailMap.put("value", eeeChainTxListHistory.eeeChainTxDetail.get(i).value);
                        detailMap.put("txHash", eeeChainTxListHistory.eeeChainTxDetail.get(i).txHash);
                        detailMap.put("inputMsg", eeeChainTxListHistory.eeeChainTxDetail.get(i).inputMsg);
                        detailMap.put("gasFee", eeeChainTxListHistory.eeeChainTxDetail.get(i).gasFee);
                        detailMap.put("signer", eeeChainTxListHistory.eeeChainTxDetail.get(i).signer);
                        detailMap.put("isSuccess", eeeChainTxListHistory.eeeChainTxDetail.get(i).isSuccess);
                        detailMap.put("timestamp", eeeChainTxListHistory.eeeChainTxDetail.get(i).timestamp);
                        resultEeeChainTxList.add(detailMap);
                    }
                    resultMap.put("eeeChainTxDetail", resultEeeChainTxList);
                } else {
                    resultMap.put("message", eeeChainTxListHistory.message);
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>", "eeeChainTxListHistory.status is " + eeeChainTxListHistory.status +
                            "||eeeChainTxListHistory.message is " + eeeChainTxListHistory.message.toString());
                }
                result.success(resultMap);
                break;
            }
            case "eeeTxSign": {
                ScryWalletLog.d(registrar.activity(), "nativeLib=>", "eeeTxSign is enter =>");
                Message message = new Message();
                ScryWalletLog.d(registrar.activity(), "nativeLib=>",
                        (String) (call.argument("rawTx")) + "||" + (String) (call.argument("mnId")) + "||" + call.argument("pwd"));
                try {
                    message = NativeLib.eeeTxSign((String) (call.argument("rawTx")),
                            (String) (call.argument("mnId")),
                            (byte[]) (call.argument("pwd")));
                } catch (Exception exception) {
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>", "eeeTxSign exception is " + exception);
                }
                Map resultMap = new HashMap();
                resultMap.put("status", message.status);
                if (message.status == 200) {
                    resultMap.put("signedInfo", message.signedInfo);
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>",
                            "message.signedInfo is " + message.signedInfo.toString());
                } else {
                    resultMap.put("message", message.message);
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>", "message.status is " + message.status +
                            "||message.message is " + message.message.toString());
                }
                result.success(resultMap);
                break;
            }
            case "ethTxSign": {
                ScryWalletLog.d(registrar.activity(), "nativeLib=>", "ethTxSign is enter =>");
                Message message = new Message();
                // ScryWalletLog.d(registrar.activity(),"nativeLib=>",
                //         "mnId is enter =>" + (call.argument("mnId")).toString());
                // ScryWalletLog.d(registrar.activity(),"nativeLib=>",
                //         "chainType is enter =>" + (call.argument("chainType")).toString());
                // ScryWalletLog.d(registrar.activity(),"nativeLib=>",
                //         "fromAddress is enter =>" + (call.argument("fromAddress")).toString());
                // ScryWalletLog.d(registrar.activity(),"nativeLib=>",
                //         "toAddress is enter =>" + (call.argument("toAddress")).toString());
                // ScryWalletLog.d(registrar.activity(),"nativeLib=>",
                //         "contractAddress is enter =>" + (call.argument("contractAddress")).toString());
                // ScryWalletLog.d(registrar.activity(),"nativeLib=>",
                //         "value is enter =>" + (call.argument("value")).toString());
                // ScryWalletLog.d(registrar.activity(),"nativeLib=>",
                //         "gasPrice is enter =>" + (call.argument("gasPrice")).toString());
                // ScryWalletLog.d(registrar.activity(),"nativeLib=>",
                //         "gasLimit is enter =>" + (call.argument("gasLimit")).toString());
                // ScryWalletLog.d(registrar.activity(),"nativeLib=>",
                //         "nonce is enter =>" + (call.argument("nonce")).toString());
                // ScryWalletLog.d(registrar.activity(),"nativeLib=>", "decimal is enter =>" + ((int) (call.argument(
                //         "decimal"))));
                message = NativeLib.ethTxSign((String) (call.argument("mnId")),
                        (int) (call.argument("chainType")),
                        (String) (call.argument("fromAddress")),
                        (String) (call.argument("toAddress")),
                        (String) (call.argument("contractAddress")),
                        (String) (call.argument("value")),
                        (String) (call.argument("backup")),
                        (byte[]) (call.argument("pwd")),
                        (String) (call.argument("gasPrice")),
                        (String) (call.argument("gasLimit")),
                        (String) (call.argument("nonce")),
                        (int) (call.argument("decimal")));
                Map resultMap = new HashMap();
                resultMap.put("status", message.status);
                if (message.status == 200) {
                    resultMap.put("ethSignedInfo", message.ethSignedInfo);
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>",
                            "message.signedInfo is " + message.ethSignedInfo.toString());
                } else {
                    resultMap.put("message", message.message);
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>", "message.status is " + message.status);
                }
                result.success(resultMap);
                break;
            }
            case "eeeTransfer": {
                ScryWalletLog.d(registrar.activity(), "nativeLib=>", "eeeTransfer is enter =>");
                Message message = new Message();
                // ScryWalletLog.d(registrar.activity(),"nativeLib=>", "eeeTransfer is from =>" + (call.argument("from")).toString());
                // ScryWalletLog.d(registrar.activity(),"nativeLib=>", "eeeTransfer is to =>" + (call.argument("to")).toString());
                // ScryWalletLog.d(registrar.activity(),"nativeLib=>", "eeeTransfer is value =>" + (call.argument("value")).toString());
                // ScryWalletLog.d(registrar.activity(),"nativeLib=>", "index is index =>" + ((int) (call.argument("index"))));
                message = NativeLib.eeeTransfer(
                        (String) (call.argument("from")),
                        (String) (call.argument("to")),
                        (String) (call.argument("value")),
                        (int) (call.argument("index")),
                        (byte[]) (call.argument("pwd")));
                Map resultMap = new HashMap();
                resultMap.put("status", message.status);
                ScryWalletLog.d(registrar.activity(), "nativeLib=>", "message is " + message.toString());
                if (message.status == 200) {
                    resultMap.put("signedInfo", message.signedInfo);
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>",
                            "message.signedInfo is " + message.signedInfo.toString());
                } else {
                    resultMap.put("message", message.message);
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>", "message.status is " + message.status);
                }
                result.success(resultMap);
                break;
            }
            case "ethRawTxSign": {
                ScryWalletLog.d(registrar.activity(), "nativeLib=>", "ethRawTxSign is enter =>");
                Message message = new Message();
                ScryWalletLog.d(registrar.activity(), "nativeLib=>",
                        "ethRawTxSign is enter =>" + (call.argument("rawTx")).toString());
                ScryWalletLog.d(registrar.activity(), "nativeLib=>",
                        "ethRawTxSign is enter =>" + (call.argument("chainType")).toString());
                ScryWalletLog.d(registrar.activity(), "nativeLib=>",
                        "ethRawTxSign is enter =>" + (call.argument("fromAddress")).toString());
                message = NativeLib.ethRawTxSign((String) (call.argument("rawTx")),
                        (int) (call.argument("chainType")),
                        (String) (call.argument("fromAddress")),
                        (byte[]) (call.argument("pwd")));
                Map resultMap = new HashMap();
                resultMap.put("status", message.status);
                if (message.status == 200) {
                    resultMap.put("ethSignedInfo", message.ethSignedInfo);
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>",
                            "message.signedInfo is " + message.ethSignedInfo.toString());
                } else {
                    resultMap.put("message", message.message);
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>", "message.status is " + message.status);
                }
                result.success(resultMap);
                break;
            }
            case "eeeSign": {
                ScryWalletLog.d(registrar.activity(), "nativeLib=>", "eeeSign is enter =>");
                Message message = new Message();
                ScryWalletLog.d(registrar.activity(), "nativeLib=>", (String) (call.argument("rawTx")) + "||" + (String) (call.argument("mnId")) + "||" + call.argument("pwd"));
                try {
                    message = NativeLib.eeeSign((String) (call.argument("rawTx")),
                            (String) (call.argument("mnId")),
                            (byte[]) (call.argument("pwd")));
                } catch (Exception exception) {
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>", "eeeSign exception is " + exception);
                }
                ScryWalletLog.d(registrar.activity(), "nativeLib=>", "message.status is " + message.status);
                Map resultMap = new HashMap();
                resultMap.put("status", message.status);
                if (message.status == 200) {
                    resultMap.put("signedInfo", message.signedInfo);
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>",
                            "message.signedInfo is " + message.signedInfo.toString());
                } else {
                    resultMap.put("message", message.message);
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>",
                            "message.message is " + message.message.toString());
                }
                result.success(resultMap);
                break;
            }
            case "decodeAdditionData": {
                ScryWalletLog.d(registrar.activity(), "nativeLib=>", "decodeAdditionData is enter =>");
                Message message = new Message();
                ScryWalletLog.d(registrar.activity(), "nativeLib=>", (String) (call.argument("input")));
                try {
                    message = NativeLib.decodeAdditionData((String) (call.argument("input")));
                } catch (Exception exception) {
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>", "decodeAdditionData exception is " + exception);
                }
                ScryWalletLog.d(registrar.activity(), "nativeLib=>", "message.status is " + message.status);
                Map resultMap = new HashMap();
                resultMap.put("status", message.status);
                if (message.status == 200) {
                    resultMap.put("inputInfo", message.inputInfo);
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>",
                            "message.inputInfo is " + message.inputInfo.toString());
                } else {
                    resultMap.put("message", message.message);
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>",
                            "message.message is " + message.message.toString());
                }
                result.success(resultMap);
                break;
            }
            case "updateDigitBalance": {
                ScryWalletLog.d(registrar.activity(), "nativeLib=>", "updateDigitBalance is enter =>");
                WalletState walletState = new WalletState();
                ScryWalletLog.d(registrar.activity(), "nativeLib=>", (String) (call.argument("address")));
                ScryWalletLog.d(registrar.activity(), "nativeLib=>", (String) (call.argument("digitId")));
                ScryWalletLog.d(registrar.activity(), "nativeLib=>", (String) (call.argument("balance")));
                try {
                    walletState = NativeLib.updateDigitBalance((String) (call.argument("address")),
                            (String) (call.argument("digitId")), (String) (call.argument("balance"
                            )));
                } catch (Exception exception) {
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>", "decodeAdditionData exception is " + exception);
                }
                ScryWalletLog.d(registrar.activity(), "nativeLib=>", "walletState.status is " + walletState.status);
                Map resultMap = new HashMap();
                resultMap.put("status", walletState.status);
                if (walletState.status == 200) {
                    resultMap.put("isUpdateDigitBalance", walletState.isUpdateDigitBalance);
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>",
                            "message.isUpdateDigitBalance is " + walletState.isUpdateDigitBalance);
                } else {
                    resultMap.put("message", walletState.message);
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>",
                            "message.message is " + walletState.message.toString());
                }
                result.success(resultMap);
                break;
            }
            case "addDigit": {
                ScryWalletLog.d(registrar.activity(), "nativeLib=>", "addDigit is enter =>");
                WalletState walletState = new WalletState();
                ScryWalletLog.d(registrar.activity(), "nativeLib=>", (String) (call.argument("walletId")));
                ScryWalletLog.d(registrar.activity(), "nativeLib=>", (int) (call.argument("chainType")));
                ScryWalletLog.d(registrar.activity(), "nativeLib=>", (String) (call.argument("digitId")));
                try {
                    walletState = NativeLib.addDigit((String) (call.argument("walletId")),
                            (int) (call.argument("chainType")),
                            (String) (call.argument("digitId")));
                } catch (Exception exception) {
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>", "decodeAdditionData exception is " + exception);
                }
                ScryWalletLog.d(registrar.activity(), "nativeLib=>", "walletState.status is " + walletState.status);
                Map resultMap = new HashMap();
                resultMap.put("status", walletState.status);
                if (walletState.status == 200) {
                    resultMap.put("isAddDigit", walletState.isAddDigit);
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>",
                            "message.isAddDigit is " + walletState.isAddDigit);
                } else {
                    resultMap.put("message", walletState.message);
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>",
                            "walletState.message is " + walletState.message.toString());
                }
                result.success(resultMap);
                break;
            }
            case "decodeAccountInfo": {
                ScryWalletLog.d(registrar.activity(), "nativeLib=>", "decodeAccountInfo is enter =>");
                Message message = new Message();
                // ScryWalletLog.d(registrar.activity(),"nativeLib=>", (String) (call.argument("encodeData")));
                try {
                    message = NativeLib.decodeAccountInfo((String) (call.argument("encodeData")));
                } catch (Exception exception) {
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>", "decodeAccountInfo exception is " + exception);
                }
                Map resultMap = new HashMap();
                resultMap.put("status", message.status);
                if (message.status == 200) {
                    resultMap.put("nonce", message.accountInfo.nonce);
                    resultMap.put("refcount", message.accountInfo.refcount);
                    resultMap.put("free", message.accountInfo.free);
                    resultMap.put("reserved", message.accountInfo.reserved);
                    resultMap.put("misc_frozen", message.accountInfo.misc_frozen);
                    resultMap.put("fee_frozen", message.accountInfo.fee_frozen);
                } else {
                    resultMap.put("message", message.message);
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>", "message.message is " + message.message.toString());
                }
                result.success(resultMap);
                break;
            }
            case "eeeStorageKey": {
                ScryWalletLog.d(registrar.activity(), "nativeLib=>", "eeeStorageKey is enter =>");
                Message message = new Message();
                //ScryWalletLog.d(registrar.activity(),"nativeLib module =>", (String) (call.argument("module")));
                //ScryWalletLog.d(registrar.activity(),"nativeLib storageItem =>", (String) (call.argument("storageItem")));
                //ScryWalletLog.d(registrar.activity(),"nativeLib account_str =>", (String) (call.argument("account_str")));
                try {
                    message = NativeLib.eeeStorageKey((String) (call.argument("module")), (String) (call.argument("storageItem")), (String) (call.argument("account_str")));
                } catch (Exception exception) {
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>", "decodeAccountInfo exception is " + exception);
                }
                Map resultMap = new HashMap();
                resultMap.put("status", message.status);
                if (message.status == 200) {
                    resultMap.put("storageKeyInfo", message.storageKeyInfo);
                } else {
                    resultMap.put("message", message.message);
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>", "message.message is " + message.message.toString());
                }
                result.success(resultMap);
                break;
            }
            case "getEeeSyncRecord": {
                ScryWalletLog.d(registrar.activity(), "nativeLib=>", "getEeeSyncRecord is enter =>");
                SyncStatus syncStatus = new SyncStatus();
                try {
                    syncStatus = NativeLib.getEeeSyncRecord();
                } catch (Exception exception) {
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>", "getEeeSyncRecord exception is " + exception);
                }
                //ScryWalletLog.d(registrar.activity(),"nativeLib=>", "syncStatus.status is " + syncStatus.status);
                Map resultMap = new HashMap();
                resultMap.put("status", syncStatus.status);
                if (syncStatus.status == 200) {
                    Map<String, AccountRecord> recordsMap = syncStatus.records;
                    //ScryWalletLog.d(registrar.activity(),"nativeLib=>", "recordsMap is " + recordsMap);
                    if (recordsMap == null || recordsMap.size() == 0) {
                        resultMap.put("records", null);
                    } else {
                        Map accountMap = new HashMap();
                        for (Map.Entry<String, AccountRecord> entry : recordsMap.entrySet()) {
                            System.out.println("key = " + entry.getKey() + ", value = " + entry.getValue());
                            Map accountDetailMap = new HashMap();
                            accountDetailMap.put("accountkey", entry.getKey());
                            accountDetailMap.put("account", entry.getValue().account);
                            accountDetailMap.put("chainType", entry.getValue().chainType);
                            accountDetailMap.put("blockNum", entry.getValue().blockNum);
                            accountDetailMap.put("blockHash", entry.getValue().blockHash);
                            accountMap.put(entry.getKey(), accountDetailMap);
                        }
                        resultMap.put("records", accountMap);
                    }
                } else {
                    resultMap.put("message", syncStatus.message);
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>", "getEeeSyncRecord syncStatus.message is " + syncStatus.message.toString());
                }
                result.success(resultMap);
                break;
            }


            case "updateEeeSyncRecord": {
                //ScryWalletLog.d(registrar.activity(),"nativeLib=>", "updateEeeSyncRecord is enter =>");
                Message message = new Message();
                //ScryWalletLog.d(registrar.activity(),"nativeLib=>", "updateEeeSyncRecord is enter =>");
                //ScryWalletLog.d(registrar.activity(),"nativeLib account   =>", (String) (call.argument("account")));
                //ScryWalletLog.d(registrar.activity(),"nativeLib chain_type=>", (int) (call.argument("chain_type")));
                //ScryWalletLog.d(registrar.activity(),"nativeLib block_num =>", (int) (call.argument("block_num")));
                //ScryWalletLog.d(registrar.activity(),"nativeLib block_hash=>", (String) (call.argument("block_hash")));
                try {
                    message = NativeLib.updateEeeSyncRecord((String) (call.argument("account")),
                            (int) (call.argument("chain_type")), (int) (call.argument("block_num")),
                            (String) (call.argument("block_hash")));
                } catch (Exception exception) {
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>", "updateEeeSyncRecord exception is " + exception);
                }
                //ScryWalletLog.d(registrar.activity(),"nativeLib=>", "updateEeeSyncRecord message.status is " + message.status);
                Map resultMap = new HashMap();
                resultMap.put("status", message.status);
                resultMap.put("message", message.message);
                result.success(resultMap);
                break;
            }
            case "saveExtrinsicDetail": {
                ScryWalletLog.d(registrar.activity(), "nativeLib=>", "saveExtrinsicDetail is enter =>");
                // ScryWalletLog.d(registrar.activity(),"nativeLib accountId   =>", (String) (call.argument("accountId")));
                // ScryWalletLog.d(registrar.activity(),"nativeLib eventDetail   =>", (String) (call.argument("eventDetail")));
                // ScryWalletLog.d(registrar.activity(),"nativeLib blockHash   =>", (String) (call.argument("blockHash")));
                // ScryWalletLog.d(registrar.activity(),"nativeLib extrinsics   =>", (String) (call.argument("extrinsics")));
                Message message = new Message();
                try {
                    message = NativeLib.saveExtrinsicDetail((String) (call.argument("infoId")), (String) (call.argument("accountId")), (String) (call.argument("eventDetail")),
                            (String) (call.argument("blockHash")), (String) (call.argument("extrinsics")));
                } catch (Exception exception) {
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>", "saveExtrinsicDetail exception is " + exception);
                }
                ScryWalletLog.d(registrar.activity(), "nativeLib=>", "message.status is " + message.status);
                Map resultMap = new HashMap();
                resultMap.put("status", message.status);
                resultMap.put("message", message.message);
                result.success(resultMap);
                break;
            }
            case "initWalletBasicData": {
                ScryWalletLog.d(registrar.activity(), "nativeLib=>", "initWalletBasicData is enter =>");
                WalletState walletState = new WalletState();
                try {
                    walletState = NativeLib.initWalletBasicData();
                } catch (Exception exception) {
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>", "initWalletBasicData exception is " + exception);
                }
                ScryWalletLog.d(registrar.activity(), "nativeLib=>", "walletState.status is " + walletState.status);
                Map resultMap = new HashMap();
                resultMap.put("status", walletState.status);
                if (walletState.status == 200) {
                    resultMap.put("isInitWalletBasicData", walletState.isInitWalletBasicData);
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>",
                            "walletState.isInitWalletBasicData is " + walletState.isInitWalletBasicData);
                } else {
                    resultMap.put("message", walletState.message);
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>",
                            "initWalletBasicData walletState.message is " + walletState.message.toString());
                }
                result.success(resultMap);
                break;
            }
            case "updateWalletDbData": {
                ScryWalletLog.d(registrar.activity(), "nativeLib=>", "updateWalletDbData is enter =>");
                WalletState walletState = new WalletState();
                try {
                    walletState = NativeLib.updateWalletDbData((String) (call.argument("newVersion")));
                } catch (Exception exception) {
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>", "updateWalletDbData exception is " + exception);
                }
                ScryWalletLog.d(registrar.activity(), "nativeLib=>", "walletState.status is " + walletState.status);
                Map resultMap = new HashMap();
                resultMap.put("status", walletState.status);
                if (walletState.status == 200) {
                    resultMap.put("isUpdateDbData", walletState.isUpdateDbData);
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>",
                            "walletState.isUpdateDbData is " + walletState.isUpdateDbData);
                } else {
                    resultMap.put("message", walletState.message);
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>",
                            "isUpdateDbData walletState.message is " + walletState.message.toString());
                }
                result.success(resultMap);
                break;
            }
            case "updateDefaultDigitList": {
                ScryWalletLog.d(registrar.activity(), "nativeLib=>", "updateDefaultDigitList is enter =>" + call.argument("digitData").toString());
                WalletState walletState = new WalletState();
                try {
                    walletState = NativeLib.updateDefaultDigitList((String) (call.argument("digitData")));
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>",
                            "walletState is " + walletState.toString());
                } catch (Exception exception) {
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>", "updateAuthDigitList exception is " + exception);
                }

                ScryWalletLog.d(registrar.activity(), "nativeLib=>", "walletState.status is " + walletState.status);
                Map resultMap = new HashMap();
                resultMap.put("status", walletState.status);
                if (walletState.status == 200) {
                    resultMap.put("isUpdateDefaultDigit", walletState.isUpdateDefaultDigit);
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>",
                            "message.isUpdateDefaultDigit is " + walletState.isUpdateDefaultDigit + "||walletState.message is -->" + walletState.message);
                } else {
                    resultMap.put("message", walletState.message);
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>",
                            "walletState.message is " + walletState.message.toString());
                }
                result.success(resultMap);
                break;
            }
            case "updateAuthDigitList": {
                ScryWalletLog.d(registrar.activity(), "nativeLib=>", "updateAuthDigitList is enter =>" + call.argument("digitData").toString());
                WalletState walletState = new WalletState();
                try {
                    walletState = NativeLib.updateAuthDigitList((String) (call.argument("digitData")));
                } catch (Exception exception) {
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>", "updateAuthDigitList exception is " + exception);
                }
                ScryWalletLog.d(registrar.activity(), "nativeLib=>", "walletState.status is " + walletState.status);
                Map resultMap = new HashMap();
                resultMap.put("status", walletState.status);
                if (walletState.status == 200) {
                    resultMap.put("isUpdateAuthDigit", walletState.isUpdateAuthDigit);
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>",
                            "message.isUpdateAuthDigit is " + walletState.isUpdateAuthDigit);
                } else {
                    resultMap.put("message", walletState.message);
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>",
                            "walletState.message is " + walletState.message.toString());
                }
                result.success(resultMap);
                break;
            }
            case "getDigitList": {
                ScryWalletLog.d(registrar.activity(), "nativeLib=>", "getAuthDigitList is enter =>");
                DigitList authList = new DigitList();
                ScryWalletLog.d(registrar.activity(), "nativeLib=>", (int) (call.argument("chainType")));
                ScryWalletLog.d(registrar.activity(), "nativeLib=>", (boolean) (call.argument("isAuth")));
                ScryWalletLog.d(registrar.activity(), "nativeLib=>", (int) (call.argument("startIndex")));
                ScryWalletLog.d(registrar.activity(), "nativeLib=>", (int) (call.argument("pageSize")));
                try {
                    authList = NativeLib.getDigitList((int) (call.argument("chainType")), (boolean) (call.argument("isAuth")), (int) (call.argument(
                            "startIndex")), (int) (call.argument("pageSize")));
                } catch (Exception exception) {
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>", "getAuthDigitList exception is " + exception);
                }
                Map resultMap = new HashMap();
                resultMap.put("status", authList.status);
                if (authList.status == 200) {
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>", "count=" + authList.count + "startItem=" + authList.startItem + "size==>" + authList.ethTokens.size());
                    List<EthToken> authDigitList = authList.ethTokens;
                    resultMap.put("count", authList.count);
                    resultMap.put("startItem", authList.startItem);
                    List<Map<String, Object>> resultAuthDigitList = new ArrayList<>();
                    if (authDigitList == null || authDigitList.size() == 0) {
                        ScryWalletLog.d(registrar.activity(), "nativeLib=>", "authDigitList is null ==> ");
                        result.success(resultMap); ///empty wallet
                        resultMap.put("authDigit", resultAuthDigitList);
                    }
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>", "authDigitList is ==> " + authDigitList.size());
                    for (int i = 0; i < authDigitList.size(); i++) {
                        Map digitMap = new HashMap();
                        int index = i;
                        EthToken authDigit = authDigitList.get(index);
                        digitMap.put("id", authDigit.id);
                        digitMap.put("symbol", authDigit.symbol);
                        digitMap.put("name", authDigit.name);
                        digitMap.put("publisher", authDigit.publisher);
                        digitMap.put("project", authDigit.project);
                        digitMap.put("logoUrl", authDigit.logoUrl);
                        digitMap.put("logoBytes", authDigit.logoBytes);
                        digitMap.put("decimal", authDigit.decimal);
                        digitMap.put("gasLimit", authDigit.gasLimit);
                        digitMap.put("contract", authDigit.contract);
                        digitMap.put("acceptId", authDigit.acceptId);
                        digitMap.put("chainType", authDigit.chainType);
                        digitMap.put("mark", authDigit.mark);
                        digitMap.put("updateTime", authDigit.updateTime);
                        digitMap.put("createTime", authDigit.createTime);
                        digitMap.put("version", authDigit.version);
                        resultAuthDigitList.add(digitMap);
                        ScryWalletLog.d(registrar.activity(), "nativeLib=>", "resultAuthDigitList.add(authDigit) ==> " + digitMap.toString());
                    }
                    resultMap.put("authDigit", resultAuthDigitList);
                } else {
                    resultMap.put("message", authList.message);
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>", "authList.message is " + authList.message.toString());
                }
                result.success(resultMap);
                break;
            }
            case "queryDigit": {
                ScryWalletLog.d(registrar.activity(), "nativeLib=>", "queryDigit is enter ===>");
                DigitList authList = new DigitList();
                try {
                    authList = NativeLib.queryDigit((int) (call.argument("chainType")), (String) (call.argument("name")), (String) (call.argument(
                            "contract_addr")));
                } catch (Exception exception) {
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>", "queryDigit exception is " + exception);
                }
                Map resultMap = new HashMap();
                resultMap.put("status", authList.status);
                if (authList.status == 200) {
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>", "count " + authList.count + "startItem " + authList.startItem + "size==> " + authList.ethTokens.size());
                    List<EthToken> authDigitList = authList.ethTokens;
                    if (authDigitList.isEmpty() || authDigitList.size() == 0) {
                        result.success(resultMap); ///empty wallet
                        return;
                    }
                    resultMap.put("count", authList.count);
                    resultMap.put("startItem", authList.startItem);
                    List<Map<String, Object>> resultAuthDigitList = new ArrayList<>();
                    for (int i = 0; i < authDigitList.size(); i++) {
                        Map digitMap = new HashMap();
                        int index = i;
                        EthToken authDigit = authDigitList.get(index);
                        digitMap.put("id", authDigit.id);
                        digitMap.put("symbol", authDigit.symbol);
                        digitMap.put("name", authDigit.name);
                        digitMap.put("publisher", authDigit.publisher);
                        digitMap.put("project", authDigit.project);
                        digitMap.put("logoUrl", authDigit.logoUrl);
                        digitMap.put("logoBytes", authDigit.logoBytes);
                        digitMap.put("decimal", authDigit.decimal);
                        digitMap.put("gasLimit", authDigit.gasLimit);
                        digitMap.put("contract", authDigit.contract);
                        digitMap.put("acceptId", authDigit.acceptId);
                        digitMap.put("chainType", authDigit.chainType);
                        digitMap.put("mark", authDigit.mark);
                        digitMap.put("updateTime", authDigit.updateTime);
                        digitMap.put("createTime", authDigit.createTime);
                        digitMap.put("version", authDigit.version);
                        resultAuthDigitList.add(digitMap);
                        //ScryWalletLog.d(registrar.activity(),"nativeLib=>", "resultAuthDigitList.add(authDigit) ==> " + digitMap.toString());
                    }
                    resultMap.put("authDigit", resultAuthDigitList);
                } else {
                    resultMap.put("message", authList.message);
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>", "authList.message is " + authList.message.toString());
                }
                result.success(resultMap);
                break;
            }
            /*case "btcStart": {
                ScryWalletLog.d(registrar.activity(),"BtcLib=>", "btcStart is enter ===>");
                try {
                    // BtcLib.btcStart((String) (call.argument("network")));
                    BtcLib.btcStart("Testnet");
                } catch (Exception exception) {
                    ScryWalletLog.d(registrar.activity(),"BtcLib=>", "btcStart exception is " + exception);
                }
                ScryWalletLog.d(registrar.activity(),"BtcLib=>", "btcStart is end~~~ ===");
                break;
            }*/
            case "getSubChainBasicInfo": {
                ScryWalletLog.d(registrar.activity(), "nativeLib=>", "getSubChainBasicInfo is enter ===>");
                Message message = new Message();
                // ScryWalletLog.d(registrar.activity(),"nativeLib genesisHash   =>", (String) (call.argument("genesisHash")));
                // ScryWalletLog.d(registrar.activity(),"nativeLib=>", "specVersion==>" + (int) (call.argument("specVersion")));
                // ScryWalletLog.d(registrar.activity(),"nativeLib=>", "txVersion==>" + (int) (call.argument("txVersion")));
                try {
                    message = NativeLib.getSubChainBasicInfo((String) (call.argument("genesisHash")), (int) (call.argument("specVersion")), (int) (call.argument("txVersion")));
                } catch (Exception exception) {
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>", "getSubChainBasicInfo exception is " + exception);
                }
                ScryWalletLog.d(registrar.activity(), "nativeLib=>", "message is  ===>" + message.toString());
                Map resultMap = new HashMap();
                resultMap.put("status", message.status);
                int status = message.status;
                if (status == 200) {
                    resultMap.put("infoId", message.chainInfo.infoId);
                    resultMap.put("genesisHash", message.chainInfo.genesisHash);
                    resultMap.put("metadata", message.chainInfo.metadata);
                    resultMap.put("runtimeVersion", message.chainInfo.runtimeVersion);
                    resultMap.put("txVersion", message.chainInfo.txVersion);
                    resultMap.put("ss58Format", message.chainInfo.ss58Format);
                    resultMap.put("tokenDecimals", message.chainInfo.tokenDecimals);
                    resultMap.put("tokenSymbol", message.chainInfo.tokenSymbol);
                } else {
                    resultMap.put("message", message.message);
                }
                result.success(resultMap);
                break;
            }
            case "updateSubChainBasicInfo": {
                ScryWalletLog.d(registrar.activity(), "nativeLib=>", "updateSubChainBasicInfo is enter ===>");
                // ScryWalletLog.d(registrar.activity(),"nativeLib=>", "updateSubChainBasicInfo is infoId ===>"+(String) (call.argument("infoId")));
                // ScryWalletLog.d(registrar.activity(),"nativeLib=>", "updateSubChainBasicInfo is genesisHash ===>"+(String) (call.argument("genesisHash")));
                // ScryWalletLog.d(registrar.activity(),"nativeLib=>", "updateSubChainBasicInfo is isDefault ===>"+(call.argument("isDefault")));
                Message message = new Message();
                SubChainBasicInfo chainInfo = new NativeLib.SubChainBasicInfo();
                chainInfo.infoId = (String) (call.argument("infoId"));
                chainInfo.runtimeVersion = (int) (call.argument("runtimeVersion"));
                chainInfo.txVersion = (int) (call.argument("txVersion"));
                chainInfo.genesisHash = (String) (call.argument("genesisHash"));
                chainInfo.metadata = (String) (call.argument("metadata"));
                chainInfo.ss58Format = (int) (call.argument("ss58Format"));
                chainInfo.tokenDecimals = (int) (call.argument("tokenDecimals"));
                chainInfo.tokenSymbol = (String) (call.argument("tokenSymbol"));
                try {
                    message = NativeLib.updateSubChainBasicInfo(chainInfo, (boolean) (call.argument("isDefault")));
                } catch (Exception exception) {
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>", "updateSubChainBasic exception is " + exception);
                }
                Map resultMap = new HashMap();
                resultMap.put("status", message.status);
                result.success(resultMap);
                break;
            }
            case "cleanWalletsDownloadData": {
                ScryWalletLog.d(registrar.activity(), "nativeLib=>", "cleanWalletsDownloadData is enter ===>");
                WalletState walletState = new WalletState();
                try {
                    walletState = NativeLib.cleanWalletsDownloadData();
                } catch (Exception exception) {
                    ScryWalletLog.d(registrar.activity(), "nativeLib=>", "cleanWalletsDownloadData exception is " + exception);
                }
                Map resultMap = new HashMap();
                int status = walletState.status;
                resultMap.put("status", status);
                if (status == 200) {
                    resultMap.put("isCleanWalletsData", walletState.isCleanWalletsData);
                } else {
                    resultMap.put("message", walletState.message);
                }
                result.success(resultMap);
                break;
            }
            default:
                result.notImplemented();
                break;
        }
    }
}
