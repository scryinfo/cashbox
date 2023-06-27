import 'dart:typed_data';

import 'package:app/control/wallets_control.dart';
import 'package:app/provide/create_wallet_process_provide.dart';
import 'package:app/provide/wallet_manager_provide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:wallets/enums.dart' as EnumKit;

import '../../res/resources.dart';
import '../../res/styles.dart';
import '../../routers/fluro_navigator.dart';
import '../../routers/routers.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/list_item.dart';
import '../../widgets/pwd_dialog.dart';

class WalletManagerPage extends StatefulWidget {
  @override
  _WalletManagerPageState createState() => _WalletManagerPageState();
}

class _WalletManagerPageState extends State<WalletManagerPage> {
  TextEditingController _walletNameController = TextEditingController();
  FocusNode _walletNameFocus = FocusNode();
  String walletName;
  bool isNameEditable = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initData(context);
  }

  void _initData(BuildContext context) {
    walletName = Provider.of<WalletManagerProvide>(context).walletName;
    _walletNameController.text = walletName;
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
                fontSize: ScreenUtil().setSp(3.5),
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
                    style: TextStyle(color: Colors.white70),
                    decoration: InputDecoration(
                      fillColor: Color.fromRGBO(101, 98, 98, 0.4),
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
                        if (_walletNameController.text == null || _walletNameController.text.isEmpty) {
                          Logger().d("getWalletByWalletId error ===>", "wallet name is null");
                          return;
                        }
                        bool isRenameOk = WalletsControl.getInstance().renameWallet(
                            Provider.of<WalletManagerProvide>(context, listen: false).walletId, _walletNameController.text);
                        if (!isRenameOk) {
                          Fluttertoast.showToast(msg: translate('failure_change_wallet_name').toString());
                          return;
                        }
                        Fluttertoast.showToast(msg: translate('success_change_wallet_name').toString());
                        setState(() {
                          isNameEditable = false;
                          walletName = _walletNameController.text;
                        });
                      },
                      color: Colors.white30,
                      child: isNameEditable
                          ? Text(
                              translate('confirm'),
                              style: TextStyle(color: Colors.white70, fontSize: 14),
                            )
                          : Text(
                              translate('compile_wallet_name'),
                              style: TextStyle(color: Colors.white70, fontSize: 14),
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
        var curWallet = WalletsControl.getInstance().currentWallet();
        if (curWallet.id == Provider.of<WalletManagerProvide>(context, listen: false).walletId) {
          Fluttertoast.showToast(
              msg: translate('prefix_abandon_del_wallet') + curWallet.name + translate('suffix_abandon_del_wallet'));
          return;
        }

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
            bool isRemoved = WalletsControl.getInstance().removeWallet(
                Provider.of<WalletManagerProvide>(context, listen: false).walletId,
                Uint8List.fromList(value.toString().codeUnits));
            if (!isRemoved) {
              Fluttertoast.showToast(msg: translate('wrong_pwd_failure_in_delete_wallet'));
              return;
            }

            // if curNetType is NetType.Test, and not exist any left wallet, change it to NetType.Main.
            var curNetType = WalletsControl.getInstance().getCurrentNetType();
            if (curNetType == EnumKit.NetType.Test && !WalletsControl.getInstance().hasAny()) {
              WalletsControl.getInstance().changeNetType(EnumKit.NetType.Main);
            }
            Fluttertoast.showToast(msg: translate('success_in_delete_wallet'));
            _navigateToNextPage();
          },
        );
      },
    );
  }

  void _navigateToNextPage() {
    if (!WalletsControl.getInstance().hasAny()) {
      NavigatorUtils.push(context, Routes.entrancePage, clearStack: true);
      return;
    }
    // loadAll，and use first wallet as default
    bool isSaveOk = false;
    var curNetType = WalletsControl.getInstance().getCurrentNetType();
    switch (curNetType) {
      case EnumKit.NetType.Main:
        isSaveOk = WalletsControl.getInstance()
            .saveCurrentWalletChain(WalletsControl.getInstance().walletsAll().first.walletId, EnumKit.ChainType.ETH);
        break;
      case EnumKit.NetType.Test:
        isSaveOk = WalletsControl.getInstance()
            .saveCurrentWalletChain(WalletsControl.getInstance().walletsAll().first.walletId, EnumKit.ChainType.EthTest);
        break;
      default:
        Fluttertoast.showToast(
            msg: translate('verify_failure_to_mnemonic'), toastLength: Toast.LENGTH_LONG, timeInSecForIosWeb: 5);
        return;
        break;
    }
    if (!isSaveOk) {
      Fluttertoast.showToast(
          msg: translate('failure_to_change_wallet'), toastLength: Toast.LENGTH_LONG, timeInSecForIosWeb: 5);
      return;
    }
    NavigatorUtils.push(context, '${Routes.ethHomePage}?isForceLoadFromJni=false', clearStack: true);
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
            String mne = WalletsControl.getInstance().exportWallet(
                Provider.of<WalletManagerProvide>(context, listen: false).walletId,
                Uint8List.fromList(value.toString().codeUnits));
            if (mne == null) {
              Logger.getInstance().e("_buildRecoverWalletWidget=>", "exportWallet is failure =>");
              Fluttertoast.showToast(msg: translate('wrong_pwd_failure_in_recover_wallet_hint'));
              return;
            }
            context.read<CreateWalletProcessProvide>().setMnemonic(Uint8List.fromList(mne.codeUnits));
            NavigatorUtils.push(context, Routes.recoverWalletPage);
          },
        );
      },
    );
  }
}
