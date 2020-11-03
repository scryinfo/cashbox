import 'package:app/generated/i18n.dart';
import 'package:app/model/wallet.dart';
import 'package:app/model/wallets.dart';
import 'package:app/provide/create_wallet_process_provide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../../widgets/app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:typed_data';
import '../../res/styles.dart';
import '../../routers/routers.dart';
import 'package:app/routers/fluro_navigator.dart';
import '../../util/qr_scan_util.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CreateWalletConfirmPage extends StatefulWidget {
  @override
  _CreateWalletConfirmPageState createState() => _CreateWalletConfirmPageState();
}

class _CreateWalletConfirmPageState extends State<CreateWalletConfirmPage> {
  List<String> mnemonicList = [];
  var verifyString = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    initData();
  }

  initData() {
    setState(() {
      mnemonicList = String.fromCharCodes(Provider.of<CreateWalletProcessProvide>(context).mnemonic).split(" ");
      mnemonicList.sort((left, right) => left.length.compareTo(right.length)); //Out of order display Mnemonic
    });
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
          centerTitle: translate('verify_wallet'),
          backgroundColor: Colors.transparent,
        ),
        body: _buildConfirmMnemonic(),
      ),
    );
  }

  Widget _buildConfirmMnemonic() {
    return Container(
      width: ScreenUtil().setWidth(90),
      height: ScreenUtil().setHeight(160),
      alignment: Alignment.center,
      child: Container(
        width: ScreenUtil().setWidth(78.75),
        height: ScreenUtil().setWidth(160),
        child: Column(
          children: <Widget>[
            Gaps.scaleVGap(6),
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                translate('verify_backup_mnemonic'),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
            Gaps.scaleVGap(1.75),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 0, right: 0),
              child: Text(
                translate('verify_mnemonic_order'),
                textAlign: TextAlign.left,
                maxLines: 2,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  letterSpacing: 0.03,
                ),
              ),
            ),
            Gaps.scaleVGap(5.5),
            Container(
              alignment: Alignment.center,
              width: ScreenUtil().setWidth(78.75),
              height: ScreenUtil().setHeight(40),
              color: Color.fromRGBO(255, 255, 255, 0.06),
              child: Container(
                alignment: Alignment.center,
                child: _buildVerifyInputMnemonic(),
              ),
            ),
            Wrap(
              children: _buildRandomMnemonicBtn(),
            ),
            Gaps.scaleVGap(10.5),
            Container(
              alignment: Alignment.bottomCenter,
              width: ScreenUtil().setWidth(41),
              height: ScreenUtil().setHeight(9),
              color: Color.fromRGBO(26, 141, 198, 0.20),
              child: FlatButton(
                onPressed: () async {
                  var isSuccess = await _verifyMnemonicSame();
                  if (isSuccess) {
                    Provider.of<CreateWalletProcessProvide>(context)
                        .emptyData(); /**The creation of the wallet is completed, and the record information about the mnemonic words in the memory is clear*/
                    NavigatorUtils.push(context, '${Routes.ethPage}?isForceLoadFromJni=true', clearStack: true); //Reload walletList
                    //NavigatorUtils.push(context, Routes.eeePage, clearStack: true);
                  } else {
                    Fluttertoast.showToast(msg: translate('mnemonic_order_wrong'));
                  }
                },
                child: Text(
                  translate('verify_mnemonic_info'),
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

  Widget _buildVerifyInputMnemonic() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(
        left: ScreenUtil().setWidth(5),
        bottom: ScreenUtil().setWidth(5),
        right: ScreenUtil().setWidth(5),
      ),
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 0.06),
        border: Border.all(
          width: 0.5,
          color: Colors.black87,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Stack(
        children: <Widget>[
          Align(
            child: Text(
              this.verifyString,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                wordSpacing: 5,
              ),
              maxLines: 3,
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: GestureDetector(
              onTap: () async {
                var status = await Permission.camera.status;
                if (status.isGranted) {
                  _scanQrContent();
                } else {
                  Map<Permission, PermissionStatus> statuses = await [Permission.camera, Permission.storage].request();
                  if (statuses[Permission.camera] == PermissionStatus.granted) {
                    _scanQrContent();
                  } else {
                    Fluttertoast.showToast(msg: translate("camera_permission_deny"), toastLength: Toast.LENGTH_LONG, timeInSecForIosWeb: 8);
                  }
                }
              },
              child: Image.asset("assets/images/ic_scan.png"),
            ),
          ),
        ],
      ),
    );
  }

  void _scanQrContent() {
    Future<String> qrResult = QrScanUtil.instance.qrscan();
    qrResult.then((t) {
      setState(() {
        this.verifyString = t.toString();
      });
    }).catchError((e) {
      Fluttertoast.showToast(msg: translate('unknown_error_in_scan_qr_code'));
    });
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
              fontSize: 12,
            ),
          ),
          onPressed: () {
            setState(() {
              this.verifyString = this.verifyString + mnemonicList[index].toString() + " ";
              mnemonicList.removeAt(index);
            });
          },
        ),
      );
    });
    return randomWidgetList;
  }

  Future<bool> _verifyMnemonicSame() async {
    if (verifyString.isNotEmpty && Provider.of<CreateWalletProcessProvide>(context).mnemonic.length != 0) {
      if (verifyString.trim() == String.fromCharCodes(Provider.of<CreateWalletProcessProvide>(context).mnemonic).trim()) {
        var isSuccess = await Wallets.instance.saveWallet(Provider.of<CreateWalletProcessProvide>(context).walletName,
            Provider.of<CreateWalletProcessProvide>(context).pwd, Provider.of<CreateWalletProcessProvide>(context).mnemonic, WalletType.WALLET);
        if (isSuccess) {
          return true;
        } else {
          Fluttertoast.showToast(msg: translate('unknown_error_in_create_wallet'));
          return false;
        }
      }
      return false;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    super.dispose();
    Provider.of<CreateWalletProcessProvide>(context)
        .emptyData(); /**The creation of the wallet is completed, and the record information about the mnemonic words in the memory is clear*/
  }
}
