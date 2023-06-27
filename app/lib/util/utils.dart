import 'dart:io';

import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

class Utils {
  ///Copy information
  static copyMsg(String msg) {
    Clipboard.setData(ClipboardData(text: msg));
  }

  ///Paste information
  static Future<ClipboardData> getCopyMsg() async {
    var t = await Clipboard.getData(Clipboard.kTextPlain);
    if (t == null) {
      t = ClipboardData(text: "");
    }
    return t;
  }

  //Time-consuming execution of the recording method
  static int recordExecuteTime(Function f) {
    var start = DateTime.now();
    f();
    var end = DateTime.now();
    var duration = end.difference(start);
    return duration.inSeconds;
  }

  //Double type value, take the next few decimal places. Default progress: 8
  static double formatDouble(double num, {int precision = 8}) {
    if ((num.toString().length - num.toString().lastIndexOf(".") - 1) < precision) {
      //There are a few decimal places after the decimal point
      return double.parse(num.toStringAsFixed(precision).substring(0, num.toString().lastIndexOf(".") + precision + 1));
    } else {
      return double.parse(num.toString().substring(0, num.toString().lastIndexOf(".") + precision + 1));
    }
  }

  static Uint8List hexStrToUnitList(String originHexString) {
    var str = originHexString;
    if (originHexString.toLowerCase().startsWith("0x")) {
      str = originHexString.substring(2);
    }
    int length = str.length;
    if (length % 2 != 0) {
      str = "0" + str;
      length++;
    }
    List<int> s = str.toUpperCase().codeUnits;
    Uint8List bArr = Uint8List(length >> 1);
    try {
      for (int i = 0; i < length; i += 2) {
        bArr[i >> 1] = ((hex(s[i]) << 4) | hex(s[i + 1]));
      }
    } catch (e) {
      return bArr;
    }
    return bArr;
  }

  static hex(int c) {
    if (c >= '0'.codeUnitAt(0) && c <= '9'.codeUnitAt(0)) {
      return c - '0'.codeUnitAt(0);
    }
    if (c >= 'A'.codeUnitAt(0) && c <= 'F'.codeUnitAt(0)) {
      return (c - 'A'.codeUnitAt(0)) + 10;
    }
  }

  static String uint8ListToHex(Uint8List bArr) {
    int length;
    if (bArr == null || (length = bArr.length) <= 0) {
      return "";
    }
    Uint8List cArr = new Uint8List(length << 1);
    int i = 0;
    for (int i2 = 0; i2 < length; i2++) {
      int i3 = i + 1;
      var cArr2 = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F'];
      var index = (bArr[i2] >> 4) & 15;
      cArr[i] = cArr2[index].codeUnitAt(0);
      i = i3 + 1;
      cArr[i3] = cArr2[bArr[i2] & 15].codeUnitAt(0);
    }
    return new String.fromCharCodes(cArr);
  }

  static int hexToInt(String originHexString) {
    var hex = originHexString;
    if (originHexString.toLowerCase().startsWith("0x")) {
      hex = originHexString.substring(2);
    }
    int val = 0;
    int len = hex.length;
    for (int i = 0; i < len; i++) {
      int hexDigit = hex.codeUnitAt(i);
      if (hexDigit >= 48 && hexDigit <= 57) {
        val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 65 && hexDigit <= 70) {
        // A..F
        val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 97 && hexDigit <= 102) {
        // a..f
        val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
      } else {
        throw new FormatException("Invalid hexadecimal value");
      }
    }
    return val;
  }

  static double hexToDouble(String originHexString) {
    var hex = originHexString;
    if (originHexString.toLowerCase().startsWith("0x")) {
      hex = originHexString.substring(2);
    }
    double val = 0;
    int len = hex.length;
    for (int i = 0; i < len; i++) {
      int hexDigit = hex.codeUnitAt(i);
      if (hexDigit >= 48 && hexDigit <= 57) {
        val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 65 && hexDigit <= 70) {
        // A..F
        val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 97 && hexDigit <= 102) {
        // a..f
        val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
      } else {
        throw new FormatException("Invalid hexadecimal value");
      }
    }
    return val;
  }

  static String reverseHexValue2SmallEnd(String originValue) {
    String resultString = "0";
    if (originValue == null || originValue.trim() == "") {
      return resultString;
    }
    if (originValue.toLowerCase().startsWith("0x")) {
      String formatString = originValue.substring(2);
      String tempString = formatString;
      for (int i = 0; i < formatString.length / 2; i = i + 2) {
        String rightPartial = tempString.substring(tempString.length - i - 2, tempString.length - i);
        String leftPartial = tempString.substring(i, i + 2);
        tempString = tempString.replaceRange(i, i + 2, rightPartial);
        tempString = tempString.replaceRange(tempString.length - i - 2, tempString.length - i, leftPartial);
      }
      resultString = tempString;
    }
    return resultString;
  }

  //Exponential method math.pow(x,y)
  static BigInt mathPow(int x, int y) {
    BigInt result = BigInt.from(1);
    while (y != 0) {
      result = result * BigInt.from(x);
      y--;
    }
    return result;
  }

  //In Ethereum address format, check whether the string format conforms. Length starts with 42 0x
  static bool checkByEthAddressFormat(String address) {
    const ethStandardAddressLength = 42; //Ethereum standard address 42 bits
    if (address.isNotEmpty && (address.length == ethStandardAddressLength) && (address.toLowerCase().startsWith("0x"))) {
      return true;
    }
    return false;
  }

  // Obtain application documentation Corresponding path
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  // Returns the file path corresponding to the application file
  static Future<File> _localFile(String filePath) async {
    final appPath = await _localPath;
    var directory = new Directory('$appPath');
    var isDirectoryExists = await directory.exists();
    if (!isDirectoryExists) {
      await directory.create();
    }
    final file = new File('$appPath' + "/" + filePath);
    var isFileExists = await file.exists();
    if (!isFileExists) {
      await file.create();
    }
    return file;
  }

  //Read the data in the file
  static Future<String> readFile(String path) async {
    try {
      final file = await _localFile(path);
      String data = await file.readAsString();
      return data;
    } catch (e) {
      Logger().e("readFile error is ===>", e.toString());
      return "error";
    }
  }

  //Store data in a file
  static Future<File> writeFile(String filePath, String data) async {
    final file = await _localFile(filePath);
    return file.writeAsString(data);
  }
}
