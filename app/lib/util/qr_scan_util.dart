
import 'package:flutter/services.dart';

class QrScanUtil {
  static const methodPlugin = const MethodChannel('qr_scan_channel');

  static Future<String> qrscan() async {
    String callbackResult = await methodPlugin.invokeMethod('qr_scan_method');
    return callbackResult;
  }
}
