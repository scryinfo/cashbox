import 'dart:io';
import 'dart:typed_data';

import 'package:app/global_config/global_config.dart';
import 'package:app/util/log_util.dart';
import 'package:app/widgets/progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class Utils {
  ///Copy information
  static copyMsg(String msg) {
    Clipboard.setData(ClipboardData(text: msg));
  }

  ///Paste information
  static Future<ClipboardData> getCopyMsg() async {
    return Clipboard.getData(Clipboard.kTextPlain);
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

  static int hexToInt(String hex) {
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
      print(data);
      return data;
    } catch (e) {
      return "error";
    }
  }

  //Store data in a file
  static Future<File> writeFile(String filePath, String data) async {
    final file = await _localFile(filePath);
    return file.writeAsString(data);
  }
}

/// The default dialog background color is translucent black. Here, the source code is changed to transparent
Future<T> showTransparentDialog<T>({
  @required BuildContext context,
  bool barrierDismissible = true,
  WidgetBuilder builder,
}) {
  final ThemeData theme = Theme.of(context, shadowThemeOnly: true);
  return showGeneralDialog(
    context: context,
    pageBuilder: (BuildContext buildContext, Animation<double> animation, Animation<double> secondaryAnimation) {
      final Widget pageChild = Builder(builder: builder);
      return SafeArea(
        child: Builder(builder: (BuildContext context) {
          return theme != null ? Theme(data: theme, child: pageChild) : pageChild;
        }),
      );
    },
    barrierDismissible: barrierDismissible,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Color(0x00FFFFFF),
    transitionDuration: const Duration(milliseconds: 150),
    transitionBuilder: _buildMaterialDialogTransitions,
  );
}

Widget _buildMaterialDialogTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
  return FadeTransition(
    opacity: CurvedAnimation(
      parent: animation,
      curve: Curves.easeOut,
    ),
    child: child,
  );
}

//
void showProgressDialog(context, message, {bool outsideDismiss: false, bool backKeyPop: true}) {
  try {
    showTransparentDialog(
        context: context,
        barrierDismissible: outsideDismiss, //Click around, whether to cancel the dialog display. Select false for the progress bar
        builder: (_) {
          return WillPopScope(
            onWillPop: () async {
              // Intercept to return key, prove dialog is closed manually
              return Future.value(backKeyPop);
            },
            child: ProgressDialog(hintText: message),
          );
        });
  } catch (e) {
    LogUtil.e("showProgressDialog error is =>", e);
  }
}
