import 'package:flutter/services.dart';

class Utils {
  ///复制信息
  static copyMsg(String msg) {
    Clipboard.setData(ClipboardData(text: msg));
  }

  ///粘贴信息
  static Future<ClipboardData> getCopyMsg() async {
    return Clipboard.getData(Clipboard.kTextPlain);
  }
}
