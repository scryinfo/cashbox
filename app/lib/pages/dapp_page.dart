import 'dart:convert';
import 'dart:typed_data';

import 'package:app/configv/config/config.dart';
import 'package:app/configv/config/handle_config.dart';
import 'package:app/model/chain.dart';
import 'package:app/model/wallet.dart';
import 'package:app/model/wallets.dart';
import 'package:app/net/etherscan_util.dart';
import 'package:app/provide/sign_info_provide.dart';
import 'package:app/routers/fluro_navigator.dart';
import 'package:app/routers/routers.dart';
import 'package:app/util/log_util.dart';
import 'package:app/util/qr_scan_util.dart';
import 'package:app/widgets/pwd_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DappPage extends StatefulWidget {
  @override
  _DappPageState createState() => _DappPageState();
}

const CashboxName = '__cashbox';
const CashboxEeeName = '__cashbox_eee';
const CashboxEthName = '__cashbox_eth';
const CashboxBtcName = '__cashbox_btc';
const setAddress = 'setAddress';

class Message {
  // message id
  String id;

  // message data, 自定义格式
  String data;

  // message 消息完成后调用的函数，此函数直接在window下面
  String callFun;

  // 出错误信息，没有出错时为零长度字符串
  String err;

  Message.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    data = json['data'];
    callFun = json['callFun'];
    err = json['err'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['data'] = this.data;
    data['callFun'] = this.callFun;
    data['err'] = this.err;
    return data;
  }
}

class _DappPageState extends State<DappPage> {
  WebViewController _controller;
  Wallet nowWallet;

  Future<String> _loadDappUrl() async {
    Config config = await HandleConfig.instance.getConfig();
    return config.privateConfig.dappOpenUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: ScreenUtil().setWidth(90),
          height: ScreenUtil().setHeight(160),
          child: FutureBuilder(
              future: _loadDappUrl(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("sorry,some error happen!");
                }
                if (snapshot.hasData) {
                  return Container(
                    margin: EdgeInsets.only(top: ScreenUtil().setHeight(4.5)),
                    child: WebView(
                      // initialUrl: "https://cashbox.scry.info/web_app/dapp/eth_tools.html#/",
                      // initialUrl:"http://192.168.1.12:9010/web_app/dapp/dapp.html",
                      //initialUrl:"http://192.168.1.5:9690/home.html",
                      initialUrl: snapshot.data.toString(),
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
                        {
                          //eee
                          String address = '';
                          {
                            address = nowWallet.getChainByChainType(ChainType.EEE)?.chainAddress;
                            if (address == null || address.isEmpty) {
                              address = nowWallet.getChainByChainType(ChainType.EEE_TEST)?.chainAddress;
                            }
                          }
                          if (address != null && address.isNotEmpty) {
                            // _controller?.evaluateJavascript('nativeChainAddressToJsResult("$address")')?.then((
                            //     result) {}); //Pass the wallet EEE chain address to DApp record storage, this will be remove
                            String script = 'if(window.$CashboxEeeName){$CashboxEeeName.$setAddress("$address")}';
                            _controller?.evaluateJavascript(script)?.then((result) {}); //Pass the wallet EEE chain address to DApp record storage
                          } else {
                            print('Page finished loading================================>:eee address is null');
                          }
                        }

                        {
                          //eth
                          String address = '';
                          {
                            address = nowWallet.getChainByChainType(ChainType.ETH)?.chainAddress;
                            if (address == null || address.isEmpty) {
                              address = nowWallet.getChainByChainType(ChainType.ETH_TEST)?.chainAddress;
                            }
                          }
                          if (address != null && address.isNotEmpty) {
                            String script = 'if(window.$CashboxEthName){$CashboxEthName.$setAddress("$address")}';
                            _controller?.evaluateJavascript(script)?.then((result) {}); //Pass the wallet EEE chain address to DApp record storage
                          } else {
                            print('Page finished loading================================>:eth address is null');
                          }
                        }

                        {
                          //btc
                          String address = '';
                          {
                            address = nowWallet.getChainByChainType(ChainType.BTC)?.chainAddress;
                            if (address == null || address.isEmpty) {
                              address = nowWallet.getChainByChainType(ChainType.BTC_TEST)?.chainAddress;
                            }
                          }
                          if (address != null && address.isNotEmpty) {
                            String script = 'if(window.$CashboxBtcName){$CashboxBtcName.$setAddress("$address")}';
                            _controller?.evaluateJavascript(script)?.then((result) {}); //Pass the wallet EEE chain address to DApp record storage
                          } else {
                            print('Page finished loading================================>:btc address is null');
                          }
                        }
                        print('Page finished loading================================>: $url');
                      },
                    ),
                  );
                } else {
                  return Text("no data yet,please to refresh page");
                }
              })),
    );
  }

  void _scanNativeQrScanToJs() {
    Future<String> qrResult = QrScanUtil.instance.qrscan();
    qrResult.then((t) {
      _controller?.evaluateJavascript('nativeQrScanToJsResult("$t")')?.then((result) {});
    }).catchError((e) {
      // Fluttertoast.showToast(msg: translate('scan_qr_unknown_error.toString());
    });
  }

  void _scanNativeQrSignToQR() {
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
  }

  void _scanCashboxScan(Message msg) {
    QrScanUtil.instance.qrscan().then((t) {
      msg.data = t;
      this.callPromise(msg);
    }).catchError((e) {
      msg.err = "inner error";
      this.callPromise(msg);
    });
  }

  Set<JavascriptChannel> makeJsChannelsSet() {
    List<JavascriptChannel> jsChannelList = [];
    jsChannelList.add(JavascriptChannel(
        name: "NativeQrScanToJs",
        onMessageReceived: (JavascriptMessage message) async {
          var status = await Permission.camera.status;
          if (status.isGranted) {
            _scanNativeQrScanToJs();
          } else {
            Map<Permission, PermissionStatus> statuses = await [Permission.camera, Permission.storage].request();
            if (statuses[Permission.camera] == PermissionStatus.granted) {
              _scanNativeQrScanToJs();
            } else {
              Fluttertoast.showToast(msg: translate("camera_permission_deny"), toastLength: Toast.LENGTH_LONG, timeInSecForIosWeb: 8);
            }
          }
        }));

    jsChannelList.add(JavascriptChannel(
        name: "NativeQrScanAndPwdAndSignToQR",
        //Remarks. Execute scan here, execute pwdAndSign on sign_tx_page, then toQR
        onMessageReceived: (JavascriptMessage message) async {
          var status = await Permission.camera.status;
          if (status.isGranted) {
            _scanNativeQrSignToQR();
          } else {
            Map<Permission, PermissionStatus> statuses = await [Permission.camera, Permission.storage].request();
            if (statuses[Permission.camera] == PermissionStatus.granted) {
              _scanNativeQrSignToQR();
            } else {
              Fluttertoast.showToast(msg: translate("camera_permission_deny"), toastLength: Toast.LENGTH_LONG, timeInSecForIosWeb: 8);
            }
          }
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
          NavigatorUtils.push(context, '${Routes.homePage}?isForceLoadFromJni=false', clearStack: true);
        }));

    jsChannelList.add(JavascriptChannel(
        name: "NativeEditOrLoadCA",
        onMessageReceived: (JavascriptMessage message) async {
          print("NativeEditOrLoadCA 传回来的参数======>： ${message.message}");
          Config config = await HandleConfig.instance.getConfig();
          if (message.message == null || message.message.trim() == "") {
            _controller?.evaluateJavascript('nativeCAInfo("$config.diamondCa")')?.then((result) {});
          } else {
            config.diamondCa = message.message;
            HandleConfig.instance.saveConfig(config);
          }
        }));
    jsChannelList.add(JavascriptChannel(
        name: "cashboxScan",
        onMessageReceived: (JavascriptMessage message) async {
          var msg = Message.fromJson(jsonDecode(message.message));
          var status = await Permission.camera.status;
          if (status.isGranted) {
            _scanCashboxScan(msg);
          } else {
            Map<Permission, PermissionStatus> statuses = await [Permission.camera, Permission.storage].request();
            if (statuses[Permission.camera] == PermissionStatus.granted) {
              _scanCashboxScan(msg);
            } else {
              Fluttertoast.showToast(msg: translate("camera_permission_deny"), toastLength: Toast.LENGTH_LONG, timeInSecForIosWeb: 8);
            }
          }
        }));
    jsChannelList.add(JavascriptChannel(
        name: "cashboxTextToClipboard",
        onMessageReceived: (JavascriptMessage message) async {
          var msg = Message.fromJson(jsonDecode(message.message));
          try {
            Clipboard.setData(ClipboardData(text: msg.data));
            msg.data = '';
            msg.err = '';
          } catch (e) {
            msg.err = 'cashboxTextToClipboard error';
          }
          this.callPromise(msg);
        }));
    jsChannelList.add(JavascriptChannel(
        name: "cashboxTextFromClipboard",
        onMessageReceived: (JavascriptMessage message) async {
          var msg = Message.fromJson(jsonDecode(message.message));
          try {
            var data = await Clipboard.getData(Clipboard.kTextPlain);
            msg.data = data.text;
            msg.err = '';
          } catch (e) {
            msg.err = 'cashboxTextFromClipboard error';
          }
          this.callPromise(msg);
        }));
    jsChannelList.add(JavascriptChannel(
        name: "cashboxEthNonce",
        onMessageReceived: (JavascriptMessage message) async {
          var msg = Message.fromJson(jsonDecode(message.message));
          try {
            Wallet wallet = await Wallets.instance.getWalletByWalletId(await Wallets.instance.getNowWalletId());
            ChainType chainType = ChainType.ETH;
            if (wallet.walletType == WalletType.TEST_WALLET) {
              chainType = ChainType.ETH_TEST;
            }
            loadTxAccount(wallet.getChainByChainType(chainType).chainAddress, chainType).then((nonce) {
              msg.data = nonce;
              this.callPromise(msg);
            });
          } catch (e) {
            msg.err = "inner error";
            print("cashboxEthNonce: " + e.toString());
            this.callPromise(msg);
          }
        }));

    jsChannelList.add(JavascriptChannel(
        name: "cashboxEthRawTxSign",
        onMessageReceived: (JavascriptMessage message) {
          print("cashboxEthRawTxSign 从Webview传回来的参数======>： ${message.message}");
          var msg = Message.fromJson(jsonDecode(message.message));
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return PwdDialog(
                title: translate('wallet_pwd').toString(),
                hintContent: translate('dapp_sign_hint_content') + nowWallet.walletName ?? "",
                hintInput: translate('input_pwd_hint').toString(),
                onPressed: (pwd) async {
                  try {
                    var pwdFormat = pwd.codeUnits;
                    Wallet wallet = await Wallets.instance.getWalletByWalletId(await Wallets.instance.getNowWalletId());
                    ChainType chainType = ChainType.ETH;
                    if (wallet.walletType == WalletType.TEST_WALLET) {
                      chainType = ChainType.ETH_TEST;
                    }
                    Wallets.instance
                        .ethRawTxSign(msg.data, Chain.chainTypeToInt(chainType), wallet.getChainByChainType(chainType).chainAddress,
                            Uint8List.fromList(pwdFormat))
                        .then((map) {
                      int status = map["status"];
                      if (status == null || status != 200) {
                        msg.err = map["message"];
                        if (msg.err == null || msg.err.length < 1) {
                          msg.err = "result nothing ";
                        }
                        msg.data = "";
                        Fluttertoast.showToast(msg: translate('tx_sign_failure').toString() + map["message"]);
                      } else {
                        var signResult = map["ethSignedInfo"];
                        msg.err = "";
                        msg.data = signResult;
                        Fluttertoast.showToast(msg: translate('tx_sign_success').toString());
                      }
                      this.callPromise(msg).then((value) {
                        NavigatorUtils.goBack(context);
                      });
                    });
                  } catch (e) {
                    print("cashboxEthRawTxSign: " + e.toString());
                    msg.err = "inner error";
                    this.callPromise(msg).whenComplete(() {
                      NavigatorUtils.goBack(context);
                    });
                  }
                },
              );
            },
          );
        }));

    jsChannelList.add(JavascriptChannel(
        name: "cashboxEthSendSignedTx",
        onMessageReceived: (JavascriptMessage message) async {
          var msg = Message.fromJson(jsonDecode(message.message));
          try {
            Wallet wallet = await Wallets.instance.getWalletByWalletId(await Wallets.instance.getNowWalletId());
            ChainType chainType = ChainType.ETH;
            if (wallet.walletType == WalletType.TEST_WALLET) {
              chainType = ChainType.ETH_TEST;
            }
            sendRawTx(chainType, msg.data).then((str) {
              msg.data = str;
              this.callPromise(msg);
            });
          } catch (e) {
            LogUtil.instance.d("cashboxEthSendSignedTx===>", e.toString());
            msg.err = "inner error";
            this.callPromise(msg);
          }
        }));

    jsChannelList.add(JavascriptChannel(
        name: "cashboxEthCall",
        onMessageReceived: (JavascriptMessage message) async {
          var msg = Message.fromJson(jsonDecode(message.message));
          try {
            List<String> data = msg.data.split(",");

            Wallet wallet = await Wallets.instance.getWalletByWalletId(await Wallets.instance.getNowWalletId());
            ChainType chainType = ChainType.ETH;
            if (wallet.walletType == WalletType.TEST_WALLET) {
              chainType = ChainType.ETH_TEST;
            }
            msg.data = await ethCall(chainType, data[0], data[1]);
            this.callPromise(msg);
          } catch (e) {
            LogUtil.instance.d("cashboxEthCall===>", e.toString());
            msg.err = "inner error";
            this.callPromise(msg);
          }
        }));

    //eee start
    jsChannelList.add(JavascriptChannel(
        name: "cashboxEeeRawTxSign",
        onMessageReceived: (JavascriptMessage message) {
          print("cashboxEeeRawTxSign 从Webview传回来的参数======>： ${message.message}");
          var msg = Message.fromJson(jsonDecode(message.message));
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return PwdDialog(
                title: translate('wallet_pwd').toString(),
                hintContent: translate('dapp_sign_hint_content') + nowWallet.walletName ?? "",
                hintInput: translate('input_pwd_hint').toString(),
                onPressed: (pwd) async {
                  try {
                    var pwdFormat = pwd.codeUnits;
                    Wallet wallet = await Wallets.instance.getWalletByWalletId(await Wallets.instance.getNowWalletId());
                    ChainType chainType = ChainType.EEE;
                    if (wallet.walletType == WalletType.TEST_WALLET) {
                      chainType = ChainType.EEE_TEST;
                    }
                    Wallets.instance.eeeTxSign(wallet.walletId, Uint8List.fromList(pwdFormat), msg.data).then((map) {
                      int status = map["status"];
                      if (status == null || status != 200) {
                        msg.err = map["message"];
                        if (msg.err == null || msg.err.length < 1) {
                          msg.err = "result nothing ";
                        } else {
                          msg.err = 'tx_sign_failure';
                          print("eeeTxSign: " + msg.err);
                        }
                        msg.data = "";
                        Fluttertoast.showToast(msg: translate('tx_sign_failure').toString() + map["message"]);
                      } else {
                        var signResult = map["signedInfo"];
                        msg.err = "";
                        msg.data = signResult;
                        Fluttertoast.showToast(msg: translate('tx_sign_success').toString());
                      }
                      this.callPromise(msg).then((value) {
                        NavigatorUtils.goBack(context);
                      });
                    });
                  } catch (e) {
                    LogUtil.instance.d("cashboxEeeRawTxSign===>", e.toString());
                    msg.err = "inner error";
                    this.callPromise(msg).whenComplete(() {
                      NavigatorUtils.goBack(context);
                    });
                  }
                },
              );
            },
          );
        }));
    //eee end

    return jsChannelList.toSet();
  }

  Future<String> callPromise(Message msg) {
    String call = "${msg.callFun}(\'${jsonEncode(msg)}\')";
    return _controller?.evaluateJavascript(call);
  }
}
