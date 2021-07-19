import 'package:flutter/foundation.dart';

class WcInfoProvide with ChangeNotifier {
  String _dappName;
  String _dappUrl;
  String _dappIconUrl;
  String _wcInitUrl;
  String _sessionId;

  get dappName => _dappName;

  get dappUrl => _dappUrl;

  get dappIconUrl => _dappIconUrl;

  get wcInitUrl => _wcInitUrl;

  get sessionId => _sessionId;

  /*Check the completion of each call, clean up the data record*/
  void emptyData() {
    this._dappName = null;
    this._dappUrl = null;
    this._dappIconUrl = null;
    this._wcInitUrl = null;
    this._sessionId = null;
  }

  void setDappName(String info) {
    this._dappName = info;
  }

  void setDappUrl(String info) {
    this._dappUrl = info;
  }

  void setDappIconUrl(String info) {
    this._dappIconUrl = info;
  }

  void setWcInitUrl(String info) {
    this._wcInitUrl = info;
  }

  void setSessionId(String info) {
    this._sessionId = info;
  }
}
