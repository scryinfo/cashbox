import 'dart:typed_data';

import 'package:app/control/wallets_control.dart';
import 'package:app/provide/create_wallet_process_provide.dart';
import 'package:app/provide/qr_info_provide.dart';
import 'package:app/routers/fluro_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../../res/styles.dart';
import '../../routers/routers.dart';
import '../../widgets/app_bar.dart';

class CreateWalletMnemonicPage extends StatefulWidget {
  @override
  _CreateWalletMnemonicPageState createState() => _CreateWalletMnemonicPageState();
}

class _CreateWalletMnemonicPageState extends State<CreateWalletMnemonicPage> {
  String walletName = "";
  List<String> mnemonicList = [];

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
    var mnemonic = WalletsControl.getInstance().generateMnemonic(12);
    if (mnemonic.isEmpty) {
      Logger().e("CreateWalletMnemonicPage=>", "mnemonic is null");
      return;
    }
    setState(() {
      mnemonicList = mnemonic.split(" ");
      walletName = Provider.of<CreateWalletProcessProvide>(context, listen: false).walletName;
    });
    context.read<CreateWalletProcessProvide>().setMnemonic(Uint8List.fromList(mnemonic.codeUnits));
    mnemonic = ""; /*Mnemonic words, free when used up*/
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
          centerTitle: translate('create_wallet'),
          backgroundColor: Colors.transparent,
          onPressed: () {},
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
                translate('backup_mnemonic'),
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
                translate('mnemonic_info_hint'),
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
                            translate('change_another_group'),
                            style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 0.9),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gaps.scaleHGap(20),
                  Container(
                    child: GestureDetector(
                        onTap: () {
                          _showAddressInQR(
                              context, walletName, translate('mnemonic_qr_info'), mnemonicList.join(" ").toString());
                        },
                        child: Container(
                          width: ScreenUtil().setWidth(20),
                          child: Text(
                            translate('qr_backup'),
                            maxLines: 2,
                            overflow: TextOverflow.visible,
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 0.9),
                            ),
                          ),
                        )),
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
              child: TextButton(
                onPressed: () {
                  NavigatorUtils.push(context, Routes.createWalletConfirmPage);
                },
                child: Text(
                  translate('mnemonic_backup_ok'),
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
        width: ScreenUtil().setWidth(25),
        color: Colors.black26,
        child: TextButton(
          child: Text(
            mnemonicList[index].toString(),
            maxLines: 1,
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
    //Temporary use of data state management processing, routing function fluro Chinese pass value will have problems.
    context.read<QrInfoProvide>().setTitle(walletName);
    context.read<QrInfoProvide>().setHintInfo(qrHintInfo);
    context.read<QrInfoProvide>().setContent(mnemonicString);
    NavigatorUtils.push(context, Routes.qrInfoPage);
  }
}
