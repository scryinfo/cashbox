import 'package:flutter/foundation.dart';

class QrInfoProvide with ChangeNotifier {
  String _title = "";
  String _hintInfo = "";
  String _content = "";
  String _btnContent = "";

  get title => _title;

  get hintInfo => _hintInfo;

  get content => _content;

  get btnContent => _btnContent;

  /*Check the completion of each call, clean up the data record*/
  void emptyData() {
    this._title = "";
    this._hintInfo = "";
    this._content = "";
    this._btnContent = "";
  }

  void setTitle(String title) {
    this._title = title;
  }

  void setHintInfo(String hintInfo) {
    this._hintInfo = hintInfo;
  }

  void setContent(String content) {
    this._content = content;
  }

  void setBtnContent(String content) {
    this._btnContent = content;
  }
}
