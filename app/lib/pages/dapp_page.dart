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
import 'package:logger/logger.dart';
import 'package:app/util/qr_scan_util.dart';
import 'package:app/widgets/pwd_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:package_info/package_info.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:wallets/enums.dart';
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
  final cookieManager = new CookieManager();

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
                      // initialUrl:"http://192.168.2.57:9010/web_app/dapp/dapp.html",
                      initialUrl: "https://cashbox.scry.info/web_app/dapp/dapp.html#/",
                      // initialUrl: "http://192.168.2.97:8080",
                      // initialUrl: "http://192.168.2.12:9690/dapp.html#/",
                      // initialUrl: "http://59.110.231.223:9010/web_app/dapp/dapp.html#/",
                      // initialUrl: snapshot.data.toString(),
                      javascriptMode: JavascriptMode.unrestricted,
                      debuggingEnabled: true,
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
                        // todo chainType
                        /*{
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
                        }*/

                        /*{
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
*/
                        /*{
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
                        }*/
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
      context.read<SignInfoProvide>().setWaitToSignInfo(waitToSignInfo);
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
          var msg = Message.fromJson(jsonDecode(message.message));
          if (status.isGranted) {
            Future<String> qrResult = QrScanUtil.instance.qrscan();
            qrResult.then((t) {
              msg.data = t;
              this.callPromise(msg);
            }).catchError((e) {
              // Fluttertoast.showToast(msg: translate('scan_qr_unknown_error.toString());
            });
          } else {
            Map<Permission, PermissionStatus> statuses = await [Permission.camera, Permission.storage].request();
            if (statuses[Permission.camera] == PermissionStatus.granted) {
              Future<String> qrResult = QrScanUtil.instance.qrscan();
              qrResult.then((t) {
                msg.data = t;
                this.callPromise(msg);
              }).catchError((e) {
                // Fluttertoast.showToast(msg: translate('scan_qr_unknown_error.toString());
              });
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
                  var msg = Message.fromJson(jsonDecode(message.message));
                  Map map = await Wallets.instance.eeeTxSign(walletId, Uint8List.fromList(pwdFormat), msg.data);
                  if (map.containsKey("status")) {
                    int status = map["status"];
                    if (status == null || status != 200) {
                      Fluttertoast.showToast(msg: translate('tx_sign_failure').toString() + map["message"]);
                      NavigatorUtils.goBack(context);
                      return null;
                    } else {
                      var signResult = map["signedInfo"];
                      msg.data = signResult;
                      Fluttertoast.showToast(msg: translate('tx_sign_success').toString());
                      this.callPromise(msg);
                      NavigatorUtils.goBack(context);
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
          NavigatorUtils.push(context, '${Routes.ethHomePage}?isForceLoadFromJni=false', clearStack: true);
        }));
    jsChannelList.add(JavascriptChannel(
        name: "NativeSaveDappChainInfo",
        onMessageReceived: (JavascriptMessage message) async {
          print("NativeSignMsg 从NativeSaveDappChainInfo传回来的参数======>： ${message.message}");
          var subChainInfo = SubChainInfo.fromJson(jsonDecode(message.message));
          print("subChainInfo--->" + subChainInfo.toString());
          Map updateMap = await Wallets.instance.updateSubChainBasicInfo(
              "",
              subChainInfo.specVersion ?? 0,
              subChainInfo.txVersion ?? 0,
              subChainInfo.genesisHash ?? "",
              subChainInfo.metadata ?? "",
              subChainInfo.ss58Format ?? 0,
              subChainInfo.tokenDecimals ?? 0,
              subChainInfo.tokenSymbol ?? "",
              isDefault: false);
          print("dapp page updateSubChainBasicInfo--->" + updateMap.toString());
        }));

    jsChannelList.add(JavascriptChannel(
        name: "NativeEditOrLoadCA",
        onMessageReceived: (JavascriptMessage message) async {
          print("NativeEditOrLoadCA 传回来的参数======>： ${message.message}");
          Config config = await HandleConfig.instance.getConfig();
          var msg = Message.fromJson(jsonDecode(message.message));
          if (msg.data == null || msg.data.trim() == "") {
            msg.data = config.diamondCa;
            this.callPromise(msg);
          } else {
            config.diamondCa = msg.data;
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
            // if (wallet.walletType == WalletType.TEST_WALLET) {
            //   chainType = ChainType.ETH_TEST;
            // }
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
                    // todo
                    // if (wallet.walletType == WalletType.TEST_WALLET) {
                    //   chainType = ChainType.ETH_TEST;
                    // }
                    /*Wallets.instance
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
                    });*/
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
          // todo
          /*try {
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
            Logger().d("cashboxEthSendSignedTx===>", e.toString());
            msg.err = "inner error";
            this.callPromise(msg);
          }*/
        }));

    jsChannelList.add(JavascriptChannel(
        name: "cashboxEthCall",
        onMessageReceived: (JavascriptMessage message) async {
          var msg = Message.fromJson(jsonDecode(message.message));
          // todo
          /*try {
            List<String> data = msg.data.split(",");

            Wallet wallet = await Wallets.instance.getWalletByWalletId(await Wallets.instance.getNowWalletId());
            ChainType chainType = ChainType.ETH;
            if (wallet.walletType == WalletType.TEST_WALLET) {
              chainType = ChainType.ETH_TEST;
            }
            msg.data = await ethCall(chainType, data[0], data[1]);
            this.callPromise(msg);
          } catch (e) {
            Logger().d("cashboxEthCall===>", e.toString());
            msg.err = "inner error";
            this.callPromise(msg);
          }*/
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
                    // todo
                    /*if (wallet.walletType == WalletType.TEST_WALLET) {
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
                    });*/
                  } catch (e) {
                    Logger().d("cashboxEeeRawTxSign===>", e.toString());
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
    jsChannelList.add(JavascriptChannel(
        name: "cashboxEeePubkey",
        onMessageReceived: (JavascriptMessage message) {
          var msg = Message.fromJson(jsonDecode(message.message));
          msg.data = Wallets.instance.nowWallet.getChainByChainType(ChainType.EEE).pubKey.toString() ?? "";
          print("cashboxEeePubkey--->" + msg.data);
          this.callPromise(msg);
        }));
    jsChannelList.add(JavascriptChannel(
        name: "cashboxEeeSign",
        onMessageReceived: (JavascriptMessage message) {
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
                    var eeeSignMap = await Wallets.instance.eeeSign(Wallets.instance.nowWallet.walletId, Uint8List.fromList(pwdFormat), msg.data);
                    int status = eeeSignMap["status"];
                    if (status == null || status != 200) {
                      msg.err = eeeSignMap["message"];
                      if (msg.err == null || msg.err.length < 1) {
                        msg.err = "result nothing ";
                      } else {
                        msg.err = 'tx_sign_failure';
                        print("eeeTxSign: " + msg.err);
                      }
                      msg.data = "";
                      Fluttertoast.showToast(msg: translate('tx_sign_failure').toString() + eeeSignMap["message"]);
                    } else {
                      var signResult = eeeSignMap["signedInfo"];
                      msg.err = "";
                      msg.data = signResult;
                      Fluttertoast.showToast(msg: translate('tx_sign_success').toString());
                    }
                    this.callPromise(msg).then((value) {
                      NavigatorUtils.goBack(context);
                    });
                  } catch (e) {
                    Logger().d("cashboxEeeRawTxSign===>", e.toString());
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
        name: "cashboxAppVersion",
        onMessageReceived: (JavascriptMessage message) async {
          var msg = Message.fromJson(jsonDecode(message.message));
          PackageInfo packageInfo = await PackageInfo.fromPlatform();
          String apkVersion = packageInfo.version;
          msg.data = apkVersion;
          this.callPromise(msg);
        }));
    return jsChannelList.toSet();
  }

  Future<String> callPromise(Message msg) {
    String call = "${msg.callFun}(\'${jsonEncode(msg)}\')";
    return _controller?.evaluateJavascript(call);
  }

  @override
  void dispose() {
    super.dispose();
    cookieManager.clearCookies();
  }
}

// 注意与js处代码，格式定义一致
class SubChainInfo {
  int specVersion = 0;
  int txVersion = 0;
  String genesisHash = '';
  String metadata = '';
  int ss58Format = 0;
  int tokenDecimals = 0;
  String tokenSymbol = '';

  SubChainInfo.fromJson(Map<String, dynamic> json) {
    specVersion = json['specVersion'];
    txVersion = json['txVersion'];
    genesisHash = json['genesisHash'];
    metadata = json['metadata'];
    ss58Format = json['ss58Format'];
    tokenDecimals = json['tokenDecimals'];
    tokenSymbol = json['tokenSymbol'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['specVersion'] = this.specVersion;
    data['txVersion'] = this.txVersion;
    data['genesisHash'] = this.genesisHash;
    data['metadata'] = this.metadata;
    data['ss58Format'] = this.ss58Format;
    data['tokenDecimals'] = this.tokenDecimals;
    data['tokenSymbol'] = this.tokenSymbol;
    return data;
  }
}
