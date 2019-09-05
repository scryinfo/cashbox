import 'package:app/model/mnemonic.dart';
import 'package:app/model/wallets.dart';
import 'package:app/provide/create_wallet_process_provide.dart';
import 'package:app/routers/application.dart';
import 'package:app/routers/fluro_navigator.dart';
import 'package:app/util/log_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../widgets/app_bar.dart';
import '../../res/styles.dart';
import '../../routers/routers.dart';

class CreateWalletMnemonicPage extends StatefulWidget {
  @override
  _CreateWalletMnemonicPageState createState() => _CreateWalletMnemonicPageState();
}

class _CreateWalletMnemonicPageState extends State<CreateWalletMnemonicPage> {
  String walletName = "";
  List<String> mnemonicList = [];
  final String qrHintInfo = "这是您助记词信息生成的二维码";

  @override
  initState() {
    super.initState();
    _initMnemonicData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  _initMnemonicData() async {
    var mnemonic = await Wallets.instance.createMnemonic(12);
    if (mnemonic == null) {
      LogUtil.e("CreateWalletMnemonicPage=>", "mnemonic is null");
      return;
    }
    print("mnemonic createWalletMnemonicPage===>" + String.fromCharCodes(mnemonic));
    setState(() {
      mnemonicList = String.fromCharCodes(mnemonic).split(" ");
      walletName = Provider.of<CreateWalletProcessProvide>(context).walletName;
    });
    Provider.of<CreateWalletProcessProvide>(context).setMnemonic(mnemonic);
    mnemonic = null; /*助记词，用完就释放*/
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/images/bg_graduate.png"), fit: BoxFit.fill),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: MyAppBar(
          centerTitle: "添加钱包",
          backgroundColor: Colors.transparent,
        ),
        body: _buildCreateWalletMnemonic(),
      ),
    );
  }

  _buildCreateWalletMnemonic() {
    return Container(
      width: ScreenUtil().setWidth(90),
      height: ScreenUtil().setHeight(160),
      alignment: Alignment.center,
      child: Container(
        width: ScreenUtil().setWidth(78.75),
        height: ScreenUtil().setWidth(160),
        child: Column(
          children: <Widget>[
            Gaps.scaleVGap(8.75),
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                "备份助记词",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
            Gaps.scaleVGap(1.75),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 0, right: 0),
              child: Text(
                """以下是钱包的助记词，请您务必认真抄写下来并导出至安全的地方存放。
注意：一旦丢失，无法找回。""",
                textAlign: TextAlign.left,
                maxLines: 4,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  letterSpacing: 0.03,
                ),
              ),
            ),
            Gaps.scaleVGap(5.5),
            Container(
              width: ScreenUtil().setWidth(78.75),
              height: ScreenUtil().setHeight(40),
              decoration: BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 0.06),
                border: Border.all(
                  width: 0.5,
                  color: Colors.black87,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Center(
                child: Wrap(
                  children: _buildRandomMnemonicBtn(),
                ),
              ),
            ),
            Gaps.scaleVGap(6.2),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      _initMnemonicData();
                    },
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Image.asset("assets/images/ic_refresh.png"),
                        ),
                        Container(
                          child: Text(
                            "换一组",
                            style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 0.9),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gaps.scaleHGap(42),
                  Container(
                    child: GestureDetector(
                      onTap: () {
                        _showAddressInQR(context, walletName, qrHintInfo, mnemonicList.join(" ").toString());
                      },
                      child: Text(
                        "二维码备份",
                        style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 0.9),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Gaps.scaleVGap(38),
            Container(
              alignment: Alignment.bottomCenter,
              width: ScreenUtil().setWidth(41),
              height: ScreenUtil().setHeight(9),
              color: Color.fromRGBO(26, 141, 198, 0.20),
              child: FlatButton(
                onPressed: () {
                  print("clicked the add wallet btn");

                  NavigatorUtils.push(context, Routes.createWalletConfirmPage);
                },
                child: Text(
                  "助记词已经记好",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.blue,
                    letterSpacing: 0.03,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildRandomMnemonicBtn() {
    List<Widget> randomWidgetList = List.generate(mnemonicList.length, (index) {
      return Container(
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(18.75),
        child: FlatButton(
          child: Text(
            mnemonicList[index].toString(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 0.9),
              fontSize: 14,
            ),
          ),
          onPressed: () {},
        ),
      );
    });
    return randomWidgetList;
  }

  _showAddressInQR(BuildContext context, String walletName, String qrHintInfo, String mnemonicString) {
    String target = "addresspage?walletName=" +
        "${walletName}" +
        "&title=" +
        "" + //todo 中文参数显示异常
        "&content=" +
        "${mnemonicString}";
    print("target==>" + target);
    Application.router.navigateTo(context, "$target");
    //NavigatorUtils.push(context,target,);
  }
}
