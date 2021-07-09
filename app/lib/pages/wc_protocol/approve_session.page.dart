import 'package:app/control/wallets_control.dart';
import 'package:app/control/wc_protocol_control.dart';
import 'package:app/provide/qr_info_provide.dart';
import 'package:app/res/styles.dart';
import 'package:app/routers/fluro_navigator.dart';
import 'package:app/routers/routers.dart';
import 'package:app/widgets/app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';

class ApproveSessionPage extends StatefulWidget {
  const ApproveSessionPage({this.qrInfo}) : super();

  final String qrInfo;

  @override
  _ApproveSessionState createState() => _ApproveSessionState();
}

class _ApproveSessionState extends State<ApproveSessionPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WcProtocolControl.getInstance()
        .initSession(Provider.of<QrInfoProvide>(context).content)
        .then((value) => {print("initSession value is --->" + value.toString())});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(90),
      height: ScreenUtil().setHeight(160),
      alignment: Alignment.topCenter,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: MyAppBar(
          centerTitle: "WalletConnect",
          backgroundColor: Colors.transparent,
          onPressed: () async {
            NavigatorUtils.push(context, Routes.entrancePage, clearStack: true);
          },
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
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Gaps.scaleVGap(8),
          _buildHeadIconWidget(),
          _buildPermissionWidget(),
          _buildChooseBtnWidget(),
        ],
      ),
    );
  }

  Widget _buildHeadIconWidget() {
    return SingleChildScrollView(
        child: Column(
      children: [
        Gaps.scaleVGap(8),
        Image.asset("assets/images/ic_logo.png"),
        Text(
          "dd",
          style: TextStyle(decoration: TextDecoration.none, color: Colors.blue, fontSize: ScreenUtil().setSp(4), fontStyle: FontStyle.normal),
        ),
      ],
    ));
  }

  Widget _buildPermissionWidget() {
    return SingleChildScrollView(
        child: Column(
      children: [
        Gaps.scaleVGap(8),
        Text(
          "允许获取当前钱包地址",
          style: TextStyle(decoration: TextDecoration.none, color: Colors.blue, fontSize: ScreenUtil().setSp(4), fontStyle: FontStyle.normal),
        ),
        Text(
          "允许获取当前钱包请求签名",
          style: TextStyle(decoration: TextDecoration.none, color: Colors.blue, fontSize: ScreenUtil().setSp(4), fontStyle: FontStyle.normal),
        ),
      ],
    ));
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
          },
        ),
        ProgressButton(
          width: ScreenUtil().setWidth(30),
          defaultWidget: const Text('Confirm'),
          progressWidget: const CircularProgressIndicator(),
          onPressed: () async {
            // Do some background task
            // String resultStr = await WcProtocolControl.getInstance().approveLogIn("0xd0B9c7C61494524620Fa8c14E121FE1A9dB49474");
            String resultStr = await WcProtocolControl.getInstance()
                .approveLogIn(WalletsControl.getInstance().currentWallet().ethChain.chainShared.walletAddress.address);
            if (resultStr == "Approved") {
              // todo change uI
              NavigatorUtils.push(context, Routes.wcConnectedPage);
            }
            // WcProtocolControl.getInstance().approveLogIn(WalletsControl.getInstance().currentWallet().ethChain.chainShared.walletAddress.address);
          },
        ),
      ],
    ));
  }
}
