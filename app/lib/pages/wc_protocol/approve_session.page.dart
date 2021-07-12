import 'package:app/control/wallets_control.dart';
import 'package:app/control/wc_protocol_control.dart';
import 'package:app/provide/dapp_info_provide.dart';
import 'package:app/provide/qr_info_provide.dart';
import 'package:app/res/styles.dart';
import 'package:app/routers/fluro_navigator.dart';
import 'package:app/routers/routers.dart';
import 'package:app/widgets/app_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_translate/global.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class ApproveSessionPage extends StatefulWidget {
  const ApproveSessionPage() : super();

  @override
  _ApproveSessionState createState() => _ApproveSessionState();
}

class _ApproveSessionState extends State<ApproveSessionPage> {
  Future sessionStateFuture;
  ProgressDialog pr;
  static const wcSessionPlugin = const EventChannel('wc_session_info_channel');
  Map txInfoMap = Map();
  String dappName;
  String dappUrl;
  String dappIconUrl;

  @override
  void initState() {
    super.initState();
    pr = ProgressDialog(context);
    pr.style(
        message: 'Downloading file...',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));
    registryListen();
  }

  registryListen() {
    wcSessionPlugin.receiveBroadcastStream().listen((event) {
      print("receiveBoard event ------->" + event.toString());
      txInfoMap = Map.from(event);
      print("txInfoMap------->" + txInfoMap.toString());
      if (txInfoMap.containsKey("name")) {
        dappName = txInfoMap["name"];
      }
      if (txInfoMap.containsKey("url")) {
        dappUrl = txInfoMap["url"];
      }
      if (txInfoMap.containsKey("iconUrl")) {
        dappIconUrl = txInfoMap["iconUrl"];
      }
      setState(() {
        this.dappName = dappName;
        this.dappUrl = dappUrl;
        this.dappIconUrl = dappIconUrl;
        print("receiveBoard dappIconUrl------》" + dappIconUrl.toString());
      });
    }, onDone: () {
      print("receiveBoard onDone------》");
    }, onError: (obj) {
      print("receiveBoard onError------>" + obj.toString());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    String qrInfo = Provider.of<QrInfoProvide>(context).content;
    sessionStateFuture = WcProtocolControl.getInstance().initSession(qrInfo);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(90),
      height: ScreenUtil().setHeight(160),
      alignment: Alignment.topCenter,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                print("WalletConnect myAppBar clicked");
                NavigatorUtils.push(context, Routes.entrancePage, clearStack: true);
              },
              child: Image.asset("assets/images/ic_back.png")),
          title: Text("WalletConnect"),
          backgroundColor: Colors.black12,
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/images/bg_graduate.png"), fit: BoxFit.fill),
          ),
          child: _buildApproveWidget(),
        ),
      ),
    );
  }

  Widget _buildApproveWidget() {
    /*return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Gaps.scaleVGap(8),
          _buildHeadIconWidget(),
          Gaps.scaleVGap(5),
          _buildPermissionWidget(),
          Gaps.scaleVGap(5),
          _buildChooseBtnWidget(),
        ],
      ),
    );*/
    return Container(
      width: ScreenUtil().setWidth(90),
      height: ScreenUtil().setHeight(160),
      child: FutureBuilder(
        future: sessionStateFuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            pr.hide();
            Logger().e("approveWidget future snapshot.hasError is +>", snapshot.error.toString());
            return Center(
              child: Text(
                translate('failure_to_load_data_pls_retry'),
                style: TextStyle(color: Colors.white70),
              ),
            );
          }
          if (snapshot.hasData) {
            Logger().d("approveWidget future snapshot.data is --->", snapshot.data.toString());
            pr.hide();
            switch (snapshot.data.toString()) {
              case "Connected":
                {
                  return SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Gaps.scaleVGap(2),
                        _buildHeadIconWidget(),
                        Gaps.scaleVGap(20),
                        _buildPermissionWidget(),
                        Gaps.scaleVGap(30),
                        _buildChooseBtnWidget(),
                      ],
                    ),
                  );
                }
              case "Approved":
                {
                  return Text("Approved");
                }
              case "Closed":
                {
                  return Text("Closed");
                }
              case "Disconnected":
                {
                  return Text("Disconnected");
                }
              default:
                {
                  return Text("unknown format info");
                }
            }
          }
          return Text("");
        },
      ),
    );
  }

  Widget _buildDappIconWidget() {
    return CachedNetworkImage(
        imageUrl: dappIconUrl,
        placeholder: (context, url) => Container(
              alignment: Alignment.center,
              width: ScreenUtil().setWidth(60),
              height: ScreenUtil().setHeight(30),
              child: Center(
                child: Column(
                  children: [
                    CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                    Gaps.scaleVGap(1),
                    Text("Dapp Icon loading"),
                  ],
                ),
              ),
            ),
        errorWidget: (context, url, error) => Container(
              width: ScreenUtil().setWidth(30),
              height: ScreenUtil().setHeight(30),
              child: Icon(Icons.error),
            ),
        fit: BoxFit.cover);
  }

  Widget _buildHeadIconWidget() {
    return SingleChildScrollView(
        child: Column(
      children: [
        _buildDappIconWidget(),
        Text(
          dappName ?? "",
          style: TextStyle(decoration: TextDecoration.none, color: Colors.blue, fontSize: ScreenUtil().setSp(4), fontStyle: FontStyle.normal),
        ),
        Text(
          dappUrl ?? "",
          style: TextStyle(decoration: TextDecoration.none, color: Colors.blueGrey, fontSize: ScreenUtil().setSp(3), fontStyle: FontStyle.normal),
        ),
      ],
    ));
  }

  Widget _buildPermissionWidget() {
    return Column(
      children: [
        Container(
          width: ScreenUtil().setWidth(75),
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(
            top: ScreenUtil().setHeight(0.5),
          ),
          child: Text(
            "应用权限申请:",
            textAlign: TextAlign.left,
            style: TextStyle(decoration: TextDecoration.none, color: Colors.blueGrey, fontSize: ScreenUtil().setSp(4), fontStyle: FontStyle.normal),
          ),
        ),
        Gaps.scaleVGap(1),
        Container(
          width: ScreenUtil().setWidth(75),
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(
            top: ScreenUtil().setHeight(0.5),
          ),
          child: Text(
            "允许获取当前钱包地址的链上信息",
            textAlign: TextAlign.left,
            style: TextStyle(decoration: TextDecoration.none, color: Colors.blue, fontSize: ScreenUtil().setSp(3.5), fontStyle: FontStyle.normal),
          ),
        ),
        Gaps.scaleVGap(0.5),
        Container(
          width: ScreenUtil().setWidth(75),
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(
            top: ScreenUtil().setHeight(0.5),
          ),
          child: Text(
            "允许向您发起交易请求",
            textAlign: TextAlign.left,
            style: TextStyle(decoration: TextDecoration.none, color: Colors.blue, fontSize: ScreenUtil().setSp(3.5), fontStyle: FontStyle.normal),
          ),
        ),
        Container(
          width: ScreenUtil().setWidth(75),
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(
            top: ScreenUtil().setHeight(0.5),
          ),
          child: Text(
            "提示：该操作不会泄露您的私钥信息",
            textAlign: TextAlign.left,
            style: TextStyle(decoration: TextDecoration.none, color: Colors.blueGrey, fontSize: ScreenUtil().setSp(3), fontStyle: FontStyle.normal),
          ),
        ),
      ],
    );
  }

  Widget _buildChooseBtnWidget() {
    return SingleChildScrollView(
        child: Row(
      children: [
        Gaps.scaleHGap(8),
        ProgressButton(
          width: ScreenUtil().setWidth(30),
          defaultWidget: const Text('Cancel'),
          progressWidget: const CircularProgressIndicator(),
          height: 40,
          onPressed: () async {
            // Do some background task
            WcProtocolControl.getInstance().rejectLogIn();
            NavigatorUtils.push(context, Routes.entrancePage, clearStack: true);
          },
        ),
        Gaps.scaleHGap(8),
        ProgressButton(
          width: ScreenUtil().setWidth(30),
          defaultWidget: const Text('Confirm'),
          progressWidget: const CircularProgressIndicator(),
          onPressed: () async {
            pr.update(message: "同意连接处理中... ");
            pr.show();

            String resultStr = await WcProtocolControl.getInstance()
                .approveLogIn(WalletsControl.getInstance().currentWallet().ethChain.chainShared.walletAddress.address);
            if (resultStr == "Approved") {
              pr.hide();
              DappInfoProvide;
              context.read<DappInfoProvide>()
                ..setDappName(dappName)
                ..setDappUrl(dappUrl)
                ..setDappIconUrl(dappIconUrl);
              NavigatorUtils.push(context, Routes.wcConnectedPage, clearStack: false);
            }
            // WcProtocolControl.getInstance().approveLogIn(WalletsControl.getInstance().currentWallet().ethChain.chainShared.walletAddress.address);
          },
        ),
      ],
    ));
  }
}
