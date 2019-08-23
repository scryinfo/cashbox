import 'package:flutter/services.dart';

class Utils {
  static copyMsg(String msg) {
    Clipboard.setData(ClipboardData(text: msg));
  }

  static Future<ClipboardData> getCopyMsg() async {
    return Clipboard.getData(Clipboard.kTextPlain);
  }
}
