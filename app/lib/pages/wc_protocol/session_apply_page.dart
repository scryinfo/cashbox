import 'package:app/control/wallets_control.dart';
import 'package:app/control/wc_protocol_control.dart';
import 'package:app/provide/wc_info_provide.dart';
import 'package:app/res/styles.dart';
import 'package:app/routers/fluro_navigator.dart';
import 'package:app/routers/routers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

class SessionApplyPage extends StatefulWidget {
  const SessionApplyPage() : super();

  @override
  _SessionApplyState createState() => _SessionApplyState();
}

class _SessionApplyState extends State<SessionApplyPage> {
  late Future sessionStateFuture;
  static const wcSessionPlugin = const EventChannel('wc_session_info_channel');
  Map txInfoMap = Map();
  String dappName = "";
  String dappUrl = "";
  String dappIconUrl = "";

  @override
  void initState() {
    super.initState();
    registryListen();
  }

  registryListen() {
    wcSessionPlugin.receiveBroadcastStream().listen(
        (event) {
          Logger().d("receiveBoard event", event.toString());
          txInfoMap = Map.from(event);
          Logger().d("txInfoMap ---> ", txInfoMap.toString());
          if (txInfoMap.containsKey("name")) {
            dappName = txInfoMap["name"];
          }
          if (txInfoMap.containsKey("url")) {
            dappUrl = txInfoMap["url"];
          }
          if (txInfoMap.containsKey("iconUrl")) {
            dappIconUrl = txInfoMap["iconUrl"];
          }
          if (mounted) {
            setState(() {
              this.dappName = dappName;
              this.dappUrl = dappUrl;
              this.dappIconUrl = dappIconUrl;
            });
          }
        },
        onDone: () {},
        onError: (obj) {
          Logger().e("receiveBoard onError", obj.toString());
        });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    String qrInfo = Provider.of<WcInfoProvide>(context, listen: false).wcInitUrl;
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
            child: Image.asset("assets/images/ic_back.png"),
          ),
          centerTitle: true,
          title: Text("WalletConnect", style: TextStyle(fontSize: 20)),
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
    return Container(
      width: ScreenUtil().setWidth(90),
      height: ScreenUtil().setHeight(160),
      child: FutureBuilder(
        future: sessionStateFuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            Logger().e("approveWidget future snapshot.hasError is +>", snapshot.error.toString());
            return Center(
              child: Text(
                translate('failure_to_load_data_pls_retry'),
                style: TextStyle(color: Colors.white70),
              ),
            );
          }
          if (snapshot.hasData) {
            switch (snapshot.data.toString()) {
              case "Connected": // todo use like Enum
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
              default:
                {
                  WcProtocolControl.getInstance().rejectLogIn();
                  Fluttertoast.showToast(msg: translate("wc_connecting_error"));
                  NavigatorUtils.push(context, Routes.entrancePage, clearStack: true);
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
        width: ScreenUtil().setWidth(25),
        height: ScreenUtil().setHeight(25),
        placeholder: (context, url) => Container(
            alignment: Alignment.center,
            width: ScreenUtil().setWidth(25),
            height: ScreenUtil().setHeight(25),
            child: Center(
              child: Column(
                children: [
                  CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                  Gaps.scaleVGap(3),
                  Text("Icon loading"),
                ],
              ),
            )),
        errorWidget: (context, url, error) =>
            Container(width: ScreenUtil().setWidth(25), height: ScreenUtil().setHeight(25), child: Icon(Icons.error)),
        fit: BoxFit.scaleDown);
  }

  Widget _buildHeadIconWidget() {
    return SingleChildScrollView(
        child: Column(
      children: [
        Gaps.scaleVGap(2),
        _buildDappIconWidget(),
        Text(
          dappName ?? "",
          style: TextStyle(
              decoration: TextDecoration.none,
              color: Colors.blue,
              fontSize: ScreenUtil().setSp(4),
              fontStyle: FontStyle.normal),
        ),
        Text(
          dappUrl ?? "",
          style: TextStyle(
              decoration: TextDecoration.none,
              color: Colors.blueGrey,
              fontSize: ScreenUtil().setSp(3),
              fontStyle: FontStyle.normal),
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
          padding: EdgeInsets.only(top: ScreenUtil().setHeight(0.5)),
          child: Text(
            translate("app_permission_ask"),
            textAlign: TextAlign.left,
            style: TextStyle(
                decoration: TextDecoration.none,
                color: Colors.blueGrey,
                fontSize: ScreenUtil().setSp(4),
                fontStyle: FontStyle.normal),
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
            translate("allow_check_chain_info"),
            textAlign: TextAlign.left,
            style: TextStyle(
                decoration: TextDecoration.none,
                color: Colors.blue,
                fontSize: ScreenUtil().setSp(3.5),
                fontStyle: FontStyle.normal),
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
            translate("allow_send_tx_req"),
            textAlign: TextAlign.left,
            style: TextStyle(
                decoration: TextDecoration.none,
                color: Colors.blue,
                fontSize: ScreenUtil().setSp(3.5),
                fontStyle: FontStyle.normal),
          ),
        ),
        Container(
          width: ScreenUtil().setWidth(75),
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(
            top: ScreenUtil().setHeight(0.5),
          ),
          child: Text(
            translate("not_split_hint"),
            textAlign: TextAlign.left,
            style: TextStyle(
                decoration: TextDecoration.none,
                color: Colors.blueGrey,
                fontSize: ScreenUtil().setSp(3),
                fontStyle: FontStyle.normal),
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
            ProgressDialog pr = ProgressDialog(context: context);
            pr.show(msg: translate("handle_allow_connecting"));
            String resultStr = await WcProtocolControl.getInstance().approveLogIn(
                WalletsControl.getInstance().currentWallet().ethChain.chainShared.walletAddress.address,
                WalletsControl.getInstance().currentWallet().ethChain.chainShared.chainType);
            if (resultStr == "Approved") {
              pr.close();
              context.read<WcInfoProvide>()
                ..setDappName(dappName)
                ..setDappUrl(dappUrl)
                ..setDappIconUrl(dappIconUrl);
              NavigatorUtils.push(context, Routes.wcConnectedPage, clearStack: false);
            }
            // todo other router
          },
        ),
      ],
    ));
  }
}
