import 'package:app/global_config/global_config.dart';
import 'package:app/global_config/vendor_config.dart';
import 'package:app/net/net_util.dart';
import 'package:app/res/resources.dart';
import 'package:app/routers/fluro_navigator.dart';
import 'package:app/routers/routers.dart';
import 'package:app/util/log_util.dart';
import 'package:app/util/sharedpreference_util.dart';
import 'package:app/util/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:app/model/wallets.dart';
import 'package:flutter/material.dart';
import 'package:app/page/eth_page/eth_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert' as convert;

class EntryPage extends StatefulWidget {
  @override
  _EntryPageState createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage> {
  var allWalletList = List();
  bool _agreeServiceProtocol = true;
  bool _isContainWallet = false;
  Future future;
  String _languageTextValue = "";
  List<String> languagesKeyList = [];
  Map<String, String> languageMap = {};
  int checkConfigInterval = 1000 * 5; //every 5 seconds allow to check config Ip

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    await initAppConfigInfo(); //case: After deleting the wallet, there is no wallet, return to entryPage, check every time
    var spUtil = await SharedPreferenceUtil.instance;
    _languageTextValue = languageMap[spUtil.getString(GlobalConfig.savedLocaleKey)];
    future = _checkIsContainWallet();
    _checkAndUpdateAppConfig();
  }

  initAppConfigInfo() async {
    languagesKeyList = [];
    languagesKeyList = GlobalConfig.globalLanguageMap.keys.toList();
    languageMap = {};
    languageMap.addAll(GlobalConfig.globalLanguageMap);
    /*  Initialize to local file
        1. Interface ip, version information, etc. Save to local file
        2. Database information, etc.
        3. Default digits
        4. Application language type (Chinese and English)
        */
    await Wallets.instance.initAppConfig();
  }

  _checkAndUpdateAppConfig() async {
    var spUtil = await SharedPreferenceUtil.instance;
    //check and update DB
    if (true) {
      // handle case : DB upgrade.   DB initial installation already finish in func -> initAppConfigInfo()->initDatabaseAndDefaultDigits()
      String recordDbVersion = spUtil.getString(VendorConfig.nowDbVersionKey);
      if (recordDbVersion != GlobalConfig.dbVersion1_1_0) {
        Map resultMap = await Wallets.instance.updateWalletDbData(GlobalConfig.dbVersion1_1_0);
        if (resultMap != null && (resultMap["isUpdateDbData"] == true)) {
          print("_checkAndUpdateAppConfig===>update database successful===>" + GlobalConfig.dbVersion1_1_0);
          spUtil.setString(VendorConfig.nowDbVersionKey, GlobalConfig.dbVersion1_1_0); // !!! important,remember to update DbVersion record
        }
      }
    }

    String lastCheckTime = spUtil.getString(VendorConfig.lastTimeCheckConfigKey);
    int nowTimeStamp = DateTime.now().millisecondsSinceEpoch;
    try {
      if (lastCheckTime == null || ((nowTimeStamp - int.parse(lastCheckTime)) - checkConfigInterval > 0)) {
        spUtil.setString(VendorConfig.lastTimeCheckConfigKey, nowTimeStamp.toString());
        String serverConfigIp = spUtil.getString(VendorConfig.appServerConfigIpKey) ?? VendorConfig.appServerConfigIpValue;
        // print("serverConfigIp===============>" + serverConfigIp);
        var result = await requestWithConfigCheckParam(serverConfigIp);
        var resultCode = result["code"];
        var resultData = result["data"];
        if (result != null && resultCode != null && resultCode == 0) {
          var isLatestConfig = resultData["isLatestConfig"];
          var isLatestApk = resultData["isLatestApk"];

          ///update config information
          if (isLatestConfig == null || !isLatestConfig) {
            var latestConfigObj = resultData["latestConfig"];
            LogUtil.i("_checkServerAppConfig latestConfigObj======>", latestConfigObj.toString());
            var isLatestAuthToken = resultData["isLatestAuthToken"];
            LogUtil.i("_checkServerAppConfig isLatestAuthToken======>", isLatestAuthToken.toString());

            ///update auth digit list
            if (!isLatestAuthToken) {
              List authTokenUrl = latestConfigObj["authTokenUrl"];
              print("_checkServerAppConfig authTokenUrl======>" + authTokenUrl.toString());
              if (authTokenUrl != null && authTokenUrl.length > 0 && authTokenUrl[0].toString().isNotEmpty) {
                spUtil.setString(VendorConfig.authDigitsIpKey, authTokenUrl[0].toString());
              }
            }
            var isLatestDefaultToken = resultData["isLatestDefaultToken"];

            ///update default digit list
            if (!isLatestDefaultToken) {
              List defaultTokenUrl = latestConfigObj["defaultTokenUrl"];
              print("_checkServerAppConfig defaultTokenUrl======>" + defaultTokenUrl.toString());
              if (defaultTokenUrl != null && (defaultTokenUrl.length > 0) && defaultTokenUrl[0].toString().isNotEmpty) {
                spUtil.setString(VendorConfig.defaultDigitsIpKey, defaultTokenUrl[0].toString());
                //update defaultDigitList to native
                try {
                  var defaultDigitParam = await requestWithDeviceId(defaultTokenUrl[0].toString());
                  if (defaultDigitParam["code"] != null && defaultDigitParam["code"] == 0) {
                    String paramString = convert.jsonEncode(defaultDigitParam["data"]);
                    print("loadServerDigitsData paramString======>" + paramString.toString());
                    var updateMap = await Wallets.instance.updateDefaultDigitList(paramString);
                    print("updateMap[isUpdateDefaultDigit](),=====>" + updateMap["status"].toString() + updateMap["isUpdateDefaultDigit"].toString());
                  }
                } catch (e) {
                  print("updateDefaultDigitList,error is ===>" + e.toString());
                }
              }
            }

            ///update digit Rate
            var tokenToLegalTenderExchangeRateIp = latestConfigObj["tokenToLegalTenderExchangeRateIp"];
            print("_checkServerAppConfig tokenToLegalTenderExchangeRateIp======>" + tokenToLegalTenderExchangeRateIp.toString());
            if (tokenToLegalTenderExchangeRateIp != null && tokenToLegalTenderExchangeRateIp.toString().isNotEmpty) {
              spUtil.setString(VendorConfig.rateDigitIpKey, tokenToLegalTenderExchangeRateIp);
            }

            ///update scryX
            var scryXChainUrl = latestConfigObj["scryXChainUrl"];
            print("_checkServerAppConfig scryXChainUrl======>" + scryXChainUrl.toString());
            if (scryXChainUrl != null && scryXChainUrl.toString().isNotEmpty) {
              spUtil.setString(VendorConfig.scryXIpKey, scryXChainUrl);
            }

            ///update announcementUrl
            var announcementUrl = latestConfigObj["announcementUrl"];
            print("_checkServerAppConfig announcementUrl======>" + announcementUrl.toString());
            if (announcementUrl != null && announcementUrl.toString().isNotEmpty) {
              spUtil.setString(VendorConfig.publicIpKey, announcementUrl);
            }

            ///update downloadUrl
            var apkDownloadLink = latestConfigObj["apkDownloadLink"];
            print("_checkServerAppConfig apkDownloadLink======>" + apkDownloadLink.toString());
            if (apkDownloadLink != null && apkDownloadLink.toString().isNotEmpty) {
              spUtil.setString(VendorConfig.downloadLatestVersionIpKey, apkDownloadLink);
            }

            ///update appConfigVersion
            var appConfigVersion = latestConfigObj["appConfigVersion"];
            print("_checkServerAppConfig appConfigVersion======>" + appConfigVersion.toString());
            if (appConfigVersion != null && appConfigVersion.toString().isNotEmpty) {
              spUtil.setString(VendorConfig.appConfigVersionKey, appConfigVersion);
            }

            ///update appConfigVersion
            var dappOpenUrlValue = latestConfigObj[VendorConfig.dappOpenUrlKey];
            print("_checkServerAppConfig dappOpenUrlValue======>" + dappOpenUrlValue.toString());
            if (dappOpenUrlValue != null && dappOpenUrlValue.toString().isNotEmpty) {
              spUtil.setString(VendorConfig.dappOpenUrlKey, dappOpenUrlValue);
              VendorConfig.dappOpenUrValue = dappOpenUrlValue.toString();
            }
          }
          print("_checkServerAppConfig isLatestApk======>" + isLatestApk.toString());
          if (isLatestApk == null || !isLatestApk) {
            var latestApkObj = resultData["latestApk"];
            LogUtil.i("_checkServerAppConfig latestApkObj======>", latestApkObj.toString());
            String apkVersion = latestApkObj["apkVersion"].toString();
            LogUtil.i("_checkServerAppConfig apkVersion======>", apkVersion.toString());
            if (apkVersion != null && apkVersion.isNotEmpty) {
              spUtil.setString(VendorConfig.serverApkVersionKey, apkVersion);
            }
          }
        } else {
          LogUtil.i("_checkAndUpdateAppConfig() requestWithVersionParam", "result status is not ok");
        }
      } else {
        print(
            "_checkAndUpdateAppConfig() time is not ok, nowTimeStamp=>" + nowTimeStamp.toString() + "||lastChangeTime=>" + lastCheckTime.toString());
        print("_checkAndUpdateAppConfig() time is not ok, nowTimeStamp=>" + (nowTimeStamp - int.parse(lastCheckTime)).toString());
      }
    } catch (e) {
      LogUtil.i("_checkServerAppConfig(), error is =======>", e.toString());
    }
  }

  //Check if a wallet has been created
  Future<bool> _checkIsContainWallet() async {
    _isContainWallet = await Wallets.instance.isContainWallet();
    return _isContainWallet;
  }

  @override
  Widget build(BuildContext context) {
    ///Initialize the screen aspect ratio, based on the cashbox cut-out, marked with XXXHDPI@4x
    ScreenUtil.init(context, designSize: Size(90, 160), allowFontScaling: false);

    return Container(
      child: FutureBuilder(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print("entryPage snapshot.error==>" + snapshot.error.toString());
              LogUtil.e("entryPage future snapshot.hasError is +>", snapshot.error.toString());
              return Center(
                child: Text(
                  translate('wallet_load_error'),
                  style: TextStyle(color: Colors.white70),
                ),
              );
            }
            if (snapshot.hasData) {
              bool isContainWallet = snapshot.data;
              if (isContainWallet) {
                return EthPage();
              } else {
                return _buildProtocolLayout(context);
              }
            }
            return Container(
              child: Text(""),
            );
          }),
    );
  }

  Widget _buildProtocolLayout(context) {
    return Material(
      child: Container(
        width: ScreenUtil().setWidth(90),
        height: ScreenUtil().setHeight(160),
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/bg_loading.png"), fit: BoxFit.fill),
        ),
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Gaps.scaleVGap(10),
              _buildChangeLanguageWidget(context),
              Gaps.scaleVGap(20),
              _buildLogoWidget(),
              //Gaps.scaleVGap(2.5),
              _buildLogoTextWidget(),
              Gaps.scaleVGap(28.5),
              _buildCreateWalletWidget(),
              Gaps.scaleVGap(6.5),
              _buildImportWalletWidget(),
              Gaps.scaleVGap(10),
              _buildProtocolCheckBoxWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChangeLanguageWidget(context) {
    return Container(
      margin: EdgeInsets.only(left: ScreenUtil().setWidth(50)),
      width: ScreenUtil().setWidth(25),
      color: Color.fromRGBO(0, 0, 0, 0.05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(
            this._languageTextValue ?? "",
            style: TextStyle(color: Colors.lightBlue),
          ),
          PopupMenuButton<String>(
            color: Colors.black12,
            icon: Icon(Icons.keyboard_arrow_down),
            itemBuilder: (BuildContext context) => _makePopMenuList(),
            onSelected: (String value) async {
              setState(() {
                this._languageTextValue = languageMap[value];
              });
              print("changeLocale===>" + value);
              {
                changeLocale(context, value);
                var spUtil = await SharedPreferenceUtil.instance;
                spUtil.setString(GlobalConfig.savedLocaleKey, value);
              }
            },
          )
        ],
      ),
    );
  }

  List<PopupMenuItem<String>> _makePopMenuList() {
    List<PopupMenuItem<String>> popMenuList = List.generate(languagesKeyList.length, (index) {
      return PopupMenuItem<String>(
          value: languagesKeyList[index] ?? "",
          child: new Text(
            languageMap[languagesKeyList[index]] ?? "",
            style: new TextStyle(color: Colors.white54),
          ));
    });
    return popMenuList;
  }

  Widget _buildLogoWidget() {
    return Container(
      child: Image.asset("assets/images/ic_logo.png"),
    );
  }

  Widget _buildLogoTextWidget() {
    return Container(
      child: Image.asset("assets/images/ic_logotxt.png"),
    );
  }

  Widget _buildCreateWalletWidget() {
    return Container(
      child: GestureDetector(
        onTap: () {
          if (!_agreeServiceProtocol) {
            Fluttertoast.showToast(msg: translate('make_sure_service_protocol'));
            return;
          }
          NavigatorUtils.push(context, Routes.createWalletNamePage);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Image.asset("assets/images/ic_add.png"),
            ),
            Gaps.scaleHGap(2.5),
            Text(
              translate('add_wallet'),
              style:
                  TextStyle(decoration: TextDecoration.none, color: Colors.blue, fontSize: ScreenUtil().setSp(4), fontStyle: FontStyle.normal),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImportWalletWidget() {
    return Container(
      child: GestureDetector(
        onTap: () {
          if (!_agreeServiceProtocol) {
            Fluttertoast.showToast(msg: translate('make_sure_service_protocol'));
            return;
          }
          NavigatorUtils.push(context, Routes.importWalletPage);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Image.asset("assets/images/ic_import.png"),
            ),
            Gaps.scaleHGap(2.5),
            Text(
              translate('import_wallet'),
              style:
                  TextStyle(decoration: TextDecoration.none, color: Colors.blue, fontSize: ScreenUtil().setSp(4), fontStyle: FontStyle.normal),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProtocolCheckBoxWidget() {
    return Container(
      width: ScreenUtil().setWidth(85),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Checkbox(
            value: _agreeServiceProtocol,
            onChanged: (newValue) {
              setState(
                () {
                  _agreeServiceProtocol = newValue;
                },
              );
            },
          ),
          Container(
              alignment: Alignment.centerLeft,
              height: ScreenUtil().setHeight(14),
              width: ScreenUtil().setWidth(70),
              child: RichText(
                text: TextSpan(children: <TextSpan>[
                  TextSpan(
                    text: translate('agree_service_prefix'),
                    style: TextStyle(
                        decoration: TextDecoration.none, color: Colors.white70, fontSize: ScreenUtil().setSp(3), fontStyle: FontStyle.normal),
                  ),
                  TextSpan(
                      text: translate('service_protocol_tag'),
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.white70,
                          fontSize: ScreenUtil().setSp(3),
                          fontStyle: FontStyle.normal),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          NavigatorUtils.push(context, Routes.serviceAgreementPage);
                        }),
                  TextSpan(
                    text: "、",
                    style: TextStyle(
                        decoration: TextDecoration.none, color: Colors.white70, fontSize: ScreenUtil().setSp(3), fontStyle: FontStyle.normal),
                  ),
                  TextSpan(
                      text: translate('privacy_protocol_tag'),
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.white70,
                          fontSize: ScreenUtil().setSp(3),
                          fontStyle: FontStyle.normal),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          NavigatorUtils.push(context, Routes.privacyStatementPage);
                        }),
                ]),
              )),
        ],
      ),
    );
  }
}
