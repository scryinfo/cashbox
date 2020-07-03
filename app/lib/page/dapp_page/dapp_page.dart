import 'dart:typed_data';

import 'package:app/generated/i18n.dart';
import 'package:app/global_config/global_config.dart';
import 'package:app/model/chain.dart';
import 'package:app/model/wallet.dart';
import 'package:app/model/wallets.dart';
import 'package:app/provide/sign_info_provide.dart';
import 'package:app/routers/fluro_navigator.dart';
import 'package:app/routers/routers.dart';
import 'package:app/util/qr_scan_util.dart';
import 'package:app/util/sharedpreference_util.dart';
import 'package:app/util/utils.dart';
import 'package:app/widgets/pwd_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:scry_webview/scry_webview.dart';

class DappPage extends StatefulWidget {
  @override
  _DappPageState createState() => _DappPageState();
}

class _DappPageState extends State<DappPage> {
  WebViewController _controller;
  Wallet nowWallet;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: ScreenUtil.instance.setWidth(90),
        height: ScreenUtil.instance.setHeight(160),
        child: Container(
          margin: EdgeInsets.only(top: ScreenUtil.instance.setHeight(4.5)),
          child: WebView(
            initialUrl: "file:///android_asset/flutter_assets/assets/dist/index.html",
            //initialUrl: "http://192.168.1.3:8080/",
            javascriptMode: JavascriptMode.unrestricted,
            userAgent:
            "Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36",
            //JS execution mode Whether to allow JS execution
            onWebViewCreated: (WebViewController webViewController) {
              _controller = webViewController;
              //_loadHtmlFromAssets(_controller); //Load local html file
            },
            javascriptChannels: makeJsChannelsSet(),
            navigationDelegate: (NavigationRequest request) {
              print("navigationDelegate ===============================>:  $request");
              return NavigationDecision.navigate;
            },
            onPageFinished: (String url) async {
              await Wallets.instance.loadAllWalletList(isForceLoadFromJni: false);
              nowWallet = Wallets.instance.nowWallet;
              Chain chainEEE = nowWallet.getChainByChainType(ChainType.EEE);
              if (chainEEE != null && chainEEE.chainAddress != null && chainEEE.chainAddress.trim() != "") {
                String chainEEEAddress = chainEEE.chainAddress;
                _controller?.evaluateJavascript('nativeChainAddressToJsResult("$chainEEEAddress")')?.then((result) {}); //Pass the wallet EEE chain address to DApp record storage
                print('Page finished loading================================>: $url');
              } else {
                print('Page finished loading================================>:address is null');
              }
            },
          ),
        ),
      ),
    );
  }

  Set<JavascriptChannel> makeJsChannelsSet() {
    List<JavascriptChannel> jsChannelList = [];
    jsChannelList.add(JavascriptChannel(
        name: "NativeQrScanToJs",
        onMessageReceived: (JavascriptMessage message) {
          Future<String> qrResult = QrScanUtil.instance.qrscan();
          qrResult.then((t) {
            _controller?.evaluateJavascript('nativeQrScanToJsResult("$t")')?.then((result) {});
          }).catchError((e) {
            // Fluttertoast.showToast(msg: translate('scan_qr_unknown_error.toString());
          });
        }));

    jsChannelList.add(JavascriptChannel(
        name: "NativeQrScanAndPwdAndSignToQR", //Remarks. Execute scan here, execute pwdAndSign on sign_tx_page, then toQR
        onMessageReceived: (JavascriptMessage message) {
          Future<String> qrResult = QrScanUtil.instance.qrscan();
          qrResult.then((qrInfo) {
            Map paramsMap = QrScanUtil.instance.checkQrInfoByDiamondSignAndQr(qrInfo, context);
            if (paramsMap == null) {
              Fluttertoast.showToast(msg: translate('not_follow_diamond_rule').toString());
              NavigatorUtils.goBack(context);
              return;
            }
            var waitToSignInfo = "dtt=" + paramsMap["dtt"] + ";" + "v=" + paramsMap["v"]; //Transaction information to be signed
            Provider.of<SignInfoProvide>(context).setWaitToSignInfo(waitToSignInfo);
            NavigatorUtils.push(context, Routes.signTxPage);
          }).catchError((e) {
            // Fluttertoast.showToast(msg: translate('scan_qr_unknown_error.toString());
          });
        }));

    jsChannelList.add(JavascriptChannel(
        name: "NativeSignMsgToJs",
        onMessageReceived: (JavascriptMessage message) {
          print("NativeSignMsg 从Webview传回来的参数======>： ${message.message}");
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return PwdDialog(
                title: translate('wallet_pwd').toString(),
                hintContent: translate('dapp_sign_hint_content') + nowWallet.walletName ?? "",
                hintInput: translate('input_pwd_hint').toString(),
                onPressed: (pwd) async {
                  var pwdFormat = pwd.codeUnits;
                  String walletId = await Wallets.instance.getNowWalletId();
                  Map map = await Wallets.instance.eeeTxSign(walletId, Uint8List.fromList(pwdFormat), message.message);
                  if (map.containsKey("status")) {
                    int status = map["status"];
                    if (status == null || status != 200) {
                      Fluttertoast.showToast(msg: translate('tx_sign_failure').toString() + map["message"]);
                      NavigatorUtils.goBack(context);
                      return null;
                    } else {
                      var signResult = map["signedInfo"];
                      Fluttertoast.showToast(msg: translate('tx_sign_success').toString());
                      _controller?.evaluateJavascript('nativeSignMsgToJsResult("$signResult")')?.then((result) {
                        NavigatorUtils.goBack(context); //The signature is completed, the password box is closed
                      });
                    }
                  } else {
                    Fluttertoast.showToast(msg: translate('tx_sign_failure').toString());
                    NavigatorUtils.goBack(context);
                  }
                },
              );
            },
          );
        }));

    jsChannelList.add(JavascriptChannel(
        name: "NativeGoBack",
        onMessageReceived: (JavascriptMessage message) {
          print("NativeSignMsg 从NativeGoBack传回来的参数======>： ${message.message}");
          NavigatorUtils.push(context, '${Routes.ethPage}?isForceLoadFromJni=false', clearStack: true);
        }));

    jsChannelList.add(JavascriptChannel(
        name: "NativeEditOrLoadCA",
        onMessageReceived: (JavascriptMessage message) async {
          print("NativeEditOrLoadCA 传回来的参数======>： ${message.message}");
          if (message.message == null || message.message.trim() == "") {
            String caInfo = await loadDiamondCa();
            _controller?.evaluateJavascript('nativeCAInfo("$caInfo")')?.then((result) {});
          } else {
            editDiamondCaToFile(message.message);
          }
        }));

    return jsChannelList.toSet();
  }

  Future<String> loadDiamondCa() async {
    var spUtil = await SharedPreferenceUtil.instance;
    var resultCa = spUtil.getString(GlobalConfig.dappCaKey1);
    return resultCa;
  }

  editDiamondCaToFile(String caInfo) async {
    var spUtil = await SharedPreferenceUtil.instance;
    spUtil.setString(GlobalConfig.dappCaKey1, caInfo);
  }
}
