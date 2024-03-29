import 'dart:convert';

import 'package:app/configv/config/config.dart';
import 'package:app/configv/config/handle_config.dart';
import 'package:app/control/app_info_control.dart';
import 'package:app/control/eee_chain_control.dart';
import 'package:app/control/eth_chain_control.dart';
import 'package:app/control/qr_scan_control.dart';
import 'package:app/control/wallets_control.dart';
import 'package:app/net/etherscan_util.dart';
import 'package:app/provide/sign_info_provide.dart';
import 'package:app/routers/fluro_navigator.dart';
import 'package:app/routers/routers.dart';
import 'package:app/widgets/pwd_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:wallets/enums.dart';
import 'package:wallets/kits.dart';
import 'package:wallets/wallets_c.dc.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webviews/webviews.dart';

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
  String id = "";

  // message data, 自定义格式
  String data = "";

  // message 消息完成后调用的函数，此函数直接在window下面
  String callFun = "";

  // 出错误信息，没有出错时为零长度字符串
  String err = "";

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
  WebviewScryController _controller = WebviewScryController.create();
  final cookieManager = new WebViewCookieManager();

  Future<String> _loadDappUrl() async {
    Config config = await HandleConfig.instance.getConfig();
    return config.privateConfig.dappOpenUrl;
  }

  @override
  void initState() {
    var calls = makeJsChannelsSet();
    for (var it in calls.entries) {
      _controller.addJavaScriptChannel(it.key, onMessageReceived: it.value);
    }
    _controller.setNavigationDelegate(NavigationDelegate(
      onPageFinished: (String url) async {
        {
          //eee
          String? address = '';
          address = WalletsControl.getInstance().currentWallet()?.eeeChain.chainShared.walletAddress.address;
          if (address != null && address.isNotEmpty) {
            String script = 'if(window.$CashboxEeeName){$CashboxEeeName.$setAddress("$address")}';
            _controller.runJavaScript(script).then((result) {}); //Pass the wallet EEE chain address to DApp record storage
          } else {
            Logger.getInstance().w("dapp interaction ", ':eee address is null');
          }
        }

        {
          //eth
          String? address = '';
          address = WalletsControl.getInstance().currentWallet()?.ethChain.chainShared.walletAddress.address;
          if (address != null && address.isNotEmpty) {
            String script = 'if(window.$CashboxEthName){$CashboxEthName.$setAddress("$address")}';
            _controller.runJavaScript(script).then((result) {}); //Pass the wallet EEE chain address to DApp record storage
          } else {
            Logger.getInstance().w("dapp interaction ", ':eth address is null');
          }
        }
        {
          //btc
          String? address = '';
          address = address = WalletsControl.getInstance().currentWallet()?.btcChain.chainShared.walletAddress.address;
          if (address != null && address.isNotEmpty) {
            String script = 'if(window.$CashboxBtcName){$CashboxBtcName.$setAddress("$address")}';
            _controller.runJavaScript(script).then((result) {}); //Pass the wallet EEE chain address to DApp record storage
          } else {
            Logger.getInstance().w("dapp interaction ", ':btc address is null');
          }
        }
        print('Page finished loading================================>: $url');
      },
    ));
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
                  _controller.loadRequest(Uri.http(snapshot.data.toString()));
                  return Container(
                    margin: EdgeInsets.only(top: ScreenUtil().setHeight(4.5)),
                    child: _controller.makeWebview(),
                  );
                } else {
                  return Text("no data yet,please to refresh page");
                }
              })),
    );
  }

  void _scanNativeQrSignToQR() {
    Future<String> qrResult = QrScanControl.instance.qrscan();
    qrResult.then((qrInfo) {
      Map paramsMap = QrScanControl.instance.checkQrInfoByDiamondSignAndQr(qrInfo, context);
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
    QrScanControl.instance.qrscan().then((t) {
      msg.data = t;
      this.callPromise(msg);
    }).catchError((e) {
      msg.err = "inner error";
      this.callPromise(msg);
    });
  }

  Map<String, void Function(JavaScriptMessage)> makeJsChannelsSet() {
    Map<String, void Function(JavaScriptMessage)> jsChannelList = {};
    jsChannelList["NativeQrScanToJs"] = (JavaScriptMessage message) async {
      var status = await Permission.camera.status;
      var msg = Message.fromJson(jsonDecode(message.message));
      if (status.isGranted) {
        Future<String> qrResult = QrScanControl.instance.qrscan();
        qrResult.then((t) {
          msg.data = t;
          this.callPromise(msg);
        }).catchError((e) {
          // Fluttertoast.showToast(msg: translate('scan_qr_unknown_error.toString());
        });
      } else {
        Map<Permission, PermissionStatus> statuses = await [Permission.camera].request();
        if (statuses[Permission.camera] == PermissionStatus.granted) {
          Future<String> qrResult = QrScanControl.instance.qrscan();
          qrResult.then((t) {
            msg.data = t;
            this.callPromise(msg);
          }).catchError((e) {
            // Fluttertoast.showToast(msg: translate('scan_qr_unknown_error.toString());
          });
        } else {
          Fluttertoast.showToast(
              msg: translate("camera_permission_deny"), toastLength: Toast.LENGTH_LONG, timeInSecForIosWeb: 8);
        }
      }
    };

    jsChannelList["NativeQrScanAndPwdAndSignToQR"] = (JavaScriptMessage message) async {
      var status = await Permission.camera.status;
      if (status.isGranted) {
        _scanNativeQrSignToQR();
      } else {
        Map<Permission, PermissionStatus> statuses = await [Permission.camera].request();
        if (statuses[Permission.camera] == PermissionStatus.granted) {
          _scanNativeQrSignToQR();
        } else {
          Fluttertoast.showToast(
              msg: translate("camera_permission_deny"), toastLength: Toast.LENGTH_LONG, timeInSecForIosWeb: 8);
        }
      }
    };

    jsChannelList["NativeSignMsgToJs"] = (JavaScriptMessage message) {
      print("NativeSignMsg 从Webview传回来的参数======>： ${message.message}");
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return PwdDialog(
            title: translate('wallet_pwd').toString(),
            hintContent: translate('dapp_sign_hint_content') + (WalletsControl.getInstance().currentWallet()?.name ?? ""),
            hintInput: translate('input_pwd_hint').toString(),
            onPressed: (pwd) async {
              var msg = Message.fromJson(jsonDecode(message.message));
              RawTxParam rawTxParam = RawTxParam()
                ..walletId = WalletsControl.getInstance().currentWallet()?.id ?? ""
                ..password = pwd
                ..rawTx = msg.data;
              var signResult = EeeChainControl.getInstance().txSign(rawTxParam);
              if (signResult == null || signResult.trim().isEmpty) {
                Fluttertoast.showToast(msg: translate('tx_sign_failure').toString());
                NavigatorUtils.goBack(context);
                return null;
              }
              msg.data = signResult;
              Fluttertoast.showToast(msg: translate('tx_sign_success').toString());
              this.callPromise(msg);
              NavigatorUtils.goBack(context);
            },
          );
        },
      );
    };

    jsChannelList["NativeGoBack"] = (JavaScriptMessage message) {
      print("NativeSignMsg 从NativeGoBack传回来的参数======>： ${message.message}");
      NavigatorUtils.push(context, '${Routes.ethHomePage}?isForceLoadFromJni=false', clearStack: true);
    };
    jsChannelList["NativeSaveDappChainInfo"] = (JavaScriptMessage message) async {
      print("NativeSignMsg 从NativeSaveDappChainInfo传回来的参数======>： ${message.message}");
      var subChainInfo = SubChainInfo.fromJson(jsonDecode(message.message));
      print("subChainInfo--->" + subChainInfo.toString());
      SubChainBasicInfo subChainBasicInfo = SubChainBasicInfo()
        ..runtimeVersion = subChainInfo.specVersion
        ..txVersion = subChainInfo.txVersion
        ..genesisHash = subChainInfo.genesisHash
        ..metadata = subChainInfo.metadata
        ..ss58FormatPrefix = subChainInfo.ss58Format
        ..tokenDecimals = subChainInfo.tokenDecimals
        ..tokenSymbol = subChainInfo.tokenSymbol
        ..isDefault = false.toInt();
      bool isUpdateOk = EeeChainControl.getInstance().updateBasicInfo(subChainBasicInfo);
      if (!isUpdateOk) {
        Logger.getInstance().e("isUpdateOk", isUpdateOk.toString());
      }
    };

    jsChannelList["NativeEditOrLoadCA"] = (JavaScriptMessage message) async {
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
    };
    jsChannelList["cashboxScan"] = (JavaScriptMessage message) async {
      var msg = Message.fromJson(jsonDecode(message.message));
      var status = await Permission.camera.status;
      if (status.isGranted) {
        _scanCashboxScan(msg);
      } else {
        Map<Permission, PermissionStatus> statuses = await [Permission.camera].request();
        if (statuses[Permission.camera] == PermissionStatus.granted) {
          _scanCashboxScan(msg);
        } else {
          Fluttertoast.showToast(
              msg: translate("camera_permission_deny"), toastLength: Toast.LENGTH_LONG, timeInSecForIosWeb: 8);
        }
      }
    };
    jsChannelList["cashboxTextToClipboard"] = (JavaScriptMessage message) async {
      var msg = Message.fromJson(jsonDecode(message.message));
      try {
        Clipboard.setData(ClipboardData(text: msg.data));
        msg.data = '';
        msg.err = '';
      } catch (e) {
        msg.err = 'cashboxTextToClipboard error';
      }
      this.callPromise(msg);
    };
    jsChannelList["cashboxTextFromClipboard"] = (JavaScriptMessage message) async {
      var msg = Message.fromJson(jsonDecode(message.message));
      try {
        var data = await Clipboard.getData(Clipboard.kTextPlain);
        msg.data = data?.text ?? "";
        msg.err = '';
      } catch (e) {
        msg.err = 'cashboxTextFromClipboard error';
        Logger.getInstance().e("cashboxTextFromClipboard: ", e.toString());
      }
      this.callPromise(msg);
    };
    jsChannelList["cashboxEthNonce"] = (JavaScriptMessage message) async {
      var msg = Message.fromJson(jsonDecode(message.message));
      try {
        EthChain ethChain = WalletsControl.getInstance().currentWallet()!.ethChain;
        loadTxAccount(ethChain.chainShared.walletAddress.address, ethChain.chainShared.chainType.toChainType())
            .then((nonce) {
          msg.data = nonce;
          this.callPromise(msg);
        });
      } catch (e) {
        msg.err = "inner error";
        Logger.getInstance().e("cashboxEthNonce: ", e.toString());
        this.callPromise(msg);
      }
    };

    jsChannelList["cashboxEthRawTxSign"] = (JavaScriptMessage message) {
      print("cashboxEthRawTxSign 从Webview传回来的参数======>： ${message.message}");
      var msg = Message.fromJson(jsonDecode(message.message));
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return PwdDialog(
            title: translate('wallet_pwd').toString(),
            hintContent: translate('dapp_sign_hint_content') + (WalletsControl.getInstance().currentWallet()?.name ?? ""),
            hintInput: translate('input_pwd_hint').toString(),
            onPressed: (pwd) async {
              try {
                EthChain ethChain = WalletsControl.getInstance().currentWallet()!.ethChain;
                EthRawTxPayload ethRawTxPayload = EthRawTxPayload()
                  ..rawTx = msg.data
                  ..fromAddress = ethChain.chainShared.walletAddress.address;
                String signResult = EthChainControl.getInstance().rawTxSign(ethRawTxPayload, pwd);
                if (signResult == null || signResult.trim().isEmpty) {
                  Fluttertoast.showToast(msg: translate('tx_sign_failure').toString());
                  return;
                }
                msg.err = "";
                msg.data = signResult;
                Fluttertoast.showToast(msg: translate('tx_sign_success').toString());
                this.callPromise(msg).then((value) {
                  NavigatorUtils.goBack(context);
                });
              } catch (e) {
                Logger.getInstance().e("cashboxEthRawTxSign: ", e.toString());
                msg.err = "inner error";
                this.callPromise(msg).whenComplete(() {
                  NavigatorUtils.goBack(context);
                });
              }
            },
          );
        },
      );
    };

    jsChannelList["cashboxEthSendSignedTx"] = (JavaScriptMessage message) async {
      var msg = Message.fromJson(jsonDecode(message.message));
      try {
        ChainType chainType =
            WalletsControl.getInstance().currentWallet()?.ethChain.chainShared.chainType.toChainType() ?? ChainType.None;
        sendRawTx(chainType, msg.data).then((str) {
          msg.data = str;
          this.callPromise(msg);
        });
      } catch (e) {
        Logger().e("cashboxEthSendSignedTx===>", e.toString());
        msg.err = "inner error";
        this.callPromise(msg);
      }
    };

    jsChannelList["cashboxEthCall"] = (JavaScriptMessage message) async {
      var msg = Message.fromJson(jsonDecode(message.message));
      try {
        List<String> data = msg.data.split(",");
        ChainType chainType =
            WalletsControl.getInstance().currentWallet()?.ethChain.chainShared.chainType.toChainType() ?? ChainType.None;
        msg.data = await ethCall(chainType, data[0], data[1]);
        this.callPromise(msg);
      } catch (e) {
        Logger().e("cashboxEthCall===>", e.toString());
        msg.err = "inner error";
        this.callPromise(msg);
      }
    };

    //eee start
    jsChannelList["cashboxEeeRawTxSign"] = (JavaScriptMessage message) {
      print("cashboxEeeRawTxSign 从Webview传回来的参数======>： ${message.message}");
      var msg = Message.fromJson(jsonDecode(message.message));
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return PwdDialog(
            title: translate('wallet_pwd').toString(),
            hintContent: translate('dapp_sign_hint_content') + (WalletsControl.getInstance().currentWallet()?.name ?? ""),
            hintInput: translate('input_pwd_hint').toString(),
            onPressed: (pwd) async {
              try {
                RawTxParam rawTxParam = RawTxParam()
                  ..rawTx = msg.data
                  ..password = pwd
                  ..walletId = WalletsControl.getInstance().currentWallet()?.id ?? "";
                String signResult = EeeChainControl.getInstance().txSign(rawTxParam);
                if (signResult == null || signResult.trim().isEmpty) {
                  msg.err = 'tx_sign_failure';
                  print("eeeTxSign: " + msg.err);
                  msg.data = "";
                  Fluttertoast.showToast(msg: translate('tx_sign_failure').toString());
                } else {
                  msg.err = "";
                  msg.data = signResult;
                  Fluttertoast.showToast(msg: translate('tx_sign_success').toString());
                }
                this.callPromise(msg).then((value) {
                  NavigatorUtils.goBack(context);
                });
              } catch (e) {
                Logger().e("cashboxEeeRawTxSign===>", e.toString());
                msg.err = "inner error";
                this.callPromise(msg).whenComplete(() {
                  NavigatorUtils.goBack(context);
                });
              }
            },
          );
        },
      );
    };
    //eee end
    jsChannelList["cashboxEeePubkey"] = (JavaScriptMessage message) {
      var msg = Message.fromJson(jsonDecode(message.message));
      try {
        msg.data = WalletsControl.getInstance().currentWallet()?.eeeChain.chainShared.walletAddress.publicKey ?? "";
        Logger.getInstance().i("cashboxEeePubkey--->", msg.data);
        this.callPromise(msg);
      } catch (e) {
        msg.data = "";
        msg.err = e.toString();
        Logger.getInstance().e("cashboxEeePubkey error is --->", e.toString());
        this.callPromise(msg);
      }
    };
    jsChannelList["cashboxEeeSign"] = (JavaScriptMessage message) {
      var msg = Message.fromJson(jsonDecode(message.message));
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return PwdDialog(
            title: translate('wallet_pwd').toString(),
            hintContent: translate('dapp_sign_hint_content') + (WalletsControl.getInstance().currentWallet()?.name ?? ""),
            hintInput: translate('input_pwd_hint').toString(),
            onPressed: (pwd) async {
              try {
                RawTxParam rawTxParam = RawTxParam()
                  ..walletId = WalletsControl.getInstance().currentWallet()?.id ?? ""
                  ..password = pwd
                  ..rawTx = msg.data;
                String signResult = EeeChainControl.getInstance().txSign(rawTxParam);
                if (signResult == null || signResult.trim().isEmpty) {
                  msg.err = 'tx_sign_failure';
                  msg.data = "";
                  Fluttertoast.showToast(msg: translate('tx_sign_failure').toString());
                } else {
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
    };
    jsChannelList["cashboxAppVersion"] = (JavaScriptMessage message) async {
      var msg = Message.fromJson(jsonDecode(message.message));
      msg.data = await AppInfoControl.instance.getAppVersion();
      this.callPromise(msg);
    };
    return jsChannelList;
  }

  Future<String> callPromise(Message msg) async {
    String call = "${msg.callFun}(\'${jsonEncode(msg)}\')";
    var data = await _controller.runJavaScriptReturningResult(call);
    return data.toString();
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
