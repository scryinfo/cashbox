import 'dart:typed_data';

import 'package:app/generated/i18n.dart';
import 'package:app/model/wallet.dart';
import 'package:app/model/wallets.dart';
import 'package:app/provide/create_wallet_process_provide.dart';
import 'package:app/provide/wallet_manager_provide.dart';
import 'package:app/util/log_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../res/resources.dart';
import '../../routers/routers.dart';
import '../../routers/fluro_navigator.dart';
import '../../res/styles.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/list_item.dart';
import '../../widgets/pwd_dialog.dart';

class WalletManagerPage extends StatefulWidget {
  @override
  _WalletManagerPageState createState() => _WalletManagerPageState();
}

class _WalletManagerPageState extends State<WalletManagerPage> {
  final List funcRouter = [Routes.resetPwdPage, Routes.recoverWalletPage];
  final TextEditingController _walletNameController = TextEditingController();
  final FocusNode _walletNameFocus = FocusNode();
  String walletId;
  String walletName;
  bool isNameEditable = false;

  @override
  void initState() {
    super.initState();
    _walletNameController.addListener(_listenWalletName);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initData(context);
  }

  void _initData(BuildContext context) {
    walletId = Provider.of<WalletManagerProvide>(context).walletId;
    walletName = Provider.of<WalletManagerProvide>(context).walletName;
    _walletNameController.text = walletName;
  }

  void _listenWalletName() {
    String newWalletName = _walletNameController.text;
    print("_listenWalletName===>" + newWalletName + "||" + walletName);
  }

  @override
  Widget build(BuildContext context) {
    return _buildWalletManagerLayout(context);
  }

  Widget _buildWalletManagerLayout(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: MyAppBar(
          centerTitle: translate('wallet_manager'),
          backgroundColor: Colors.transparent,
        ),
        body: GestureDetector(
          onTap: () async {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Container(
            width: ScreenUtil().setWidth(90),
            height: ScreenUtil().setHeight(160),
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("assets/images/bg_graduate.png"),
              ),
            ),
            child: Column(
              children: <Widget>[
                Gaps.scaleVGap(5),
                _buildWalletNameWidget(context),
                _buildResetPwdWidget(context),
                _buildRecoverWalletWidget(context),
                _buildDeleteWalletWidget(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWalletNameWidget(context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            width: ScreenUtil().setWidth(80),
            padding: EdgeInsets.only(left: ScreenUtil().setWidth(3)),
            child: Text(
              translate('wallet_name'),
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 1),
                fontSize: ScreenUtil.instance.setSp(3.5),
              ),
            ),
          ),
          Gaps.scaleVGap(2),
          Container(
            width: ScreenUtil().setWidth(78),
            alignment: Alignment.center,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    autofocus: false,
                    enabled: isNameEditable,
                    textAlign: TextAlign.start,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      fillColor: Color.fromRGBO(101, 98, 98, 0.50),
                      filled: true,
                      hintStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                      contentPadding: EdgeInsets.only(
                        left: ScreenUtil().setWidth(2),
                        top: ScreenUtil().setHeight(8),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black87),
                        borderRadius: BorderRadius.circular(
                          ScreenUtil().setWidth(1.0),
                        ),
                      ),
                    ),
                    focusNode: _walletNameFocus,
                    controller: _walletNameController,
                  ),
                ),
                Gaps.scaleHGap(1.5),
                Container(
                  width: ScreenUtil().setWidth(15),
                  height: ScreenUtil().setHeight(8),
                  padding: EdgeInsets.all(0),
                  child: Opacity(
                    opacity: isNameEditable ? 1 : 0.8,
                    child: RaisedButton(
                      onPressed: () async {
                        if (!isNameEditable) {
                          setState(() {
                            this.isNameEditable = true;
                            FocusScope.of(context).requestFocus(_walletNameFocus);
                          });
                          return;
                        }
                        Wallet chooseWallet = await Wallets.instance.getWalletByWalletId(Provider.of<WalletManagerProvide>(context).walletId);
                        if (_walletNameController.text == null || _walletNameController.text.isEmpty) {
                          print("钱包名为空");
                          return;
                        }
                        bool isRenameSuccess = await chooseWallet.rename(_walletNameController.text);
                        if (isRenameSuccess) {
                          Fluttertoast.showToast(msg: translate('success_change_wallet_name').toString());
                          setState(() {
                            isNameEditable = false;
                            walletName = _walletNameController.text;
                          });
                        } else {
                          Fluttertoast.showToast(msg: translate('failure_change_wallet_name').toString());
                        }
                      },
                      color: Colors.white30,
                      child: isNameEditable
                          ? Text(
                              translate('confirm'),
                              style: TextStyle(color: Colors.white70, fontSize: 15),
                            )
                          : Text(
                              translate('compile_wallet_name'),
                              style: TextStyle(color: Colors.white70, fontSize: 15),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResetPwdWidget(context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          NavigatorUtils.push(context, Routes.resetPwdPage);
        },
        child: Container(
          child: Column(
            children: <Widget>[
              Gaps.scaleVGap(5),
              Container(
                child: ItemOfListWidget(
                  leftText: translate('reset_pwd'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecoverWalletWidget(context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          _showRecoverDialog(context);
        },
        child: Container(
          child: Column(
            children: <Widget>[
              Gaps.scaleVGap(5),
              Container(
                child: ItemOfListWidget(
                  leftText: translate('recover_wallet'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDeleteWalletWidget(context) {
    return GestureDetector(
      onTap: () {
        _showDeleteDialog(context);
      },
      child: Column(
        children: <Widget>[
          Gaps.scaleVGap(5),
          Container(
            child: ItemOfListWidget(
              leftText: translate('delete_wallet'),
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PwdDialog(
          title: translate('delete_wallet'),
          hintContent: translate('delete_wallet_hint'),
          hintInput: translate('pls_input_wallet_pwd'),
          onPressed: (value) async {
            Map deleteMap = await Wallets.instance.deleteWallet(walletId, Uint8List.fromList(value.toString().codeUnits));
            print("to do verify pwd,delete wallet");
            int status = deleteMap["status"];
            bool isSuccess = deleteMap["isDeletWallet"];
            if (status == 200 && isSuccess) {
              Fluttertoast.showToast(msg: translate('success_in_delete_wallet'));
              NavigatorUtils.push(context, Routes.entryPage, clearStack: true);
            } else {
              LogUtil.e("_buildDeleteWalletWidget=>", "status is=>" + status.toString() + "message=>" + deleteMap["message"]);
              Fluttertoast.showToast(msg: translate('wrong_pwd_failure_in_delete_wallet'));
            }
          },
        );
      },
    );
  }

  void _showRecoverDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PwdDialog(
          title: translate('recover_wallet'),
          hintContent: translate('recover_wallet_hint'),
          hintInput: translate('pls_input_wallet_pwd'),
          onPressed: (value) async {
            Map mnemonicMap = await Wallets.instance.exportWallet(walletId, Uint8List.fromList(value.toString().codeUnits));
            int status = mnemonicMap["status"];
            if (status == 200) {
              Provider.of<CreateWalletProcessProvide>(context).setMnemonic(mnemonicMap["mn"]);
              mnemonicMap = null; //跟助记词相关,用完置空
              NavigatorUtils.push(context, Routes.recoverWalletPage);
            } else {
              LogUtil.e("_buildRecoverWalletWidget=>", "status is=>" + status.toString() + "message=>" + mnemonicMap["message"]);
              Fluttertoast.showToast(msg: translate('wrong_pwd_failure_in_recover_wallet_hint'));
            }
          },
        );
      },
    );
  }
}
