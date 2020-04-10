import 'dart:io';
import 'dart:typed_data';

import 'package:app/global_config/global_config.dart';
import 'package:app/util/log_util.dart';
import 'package:app/widgets/progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class Utils {
  ///复制信息
  static copyMsg(String msg) {
    Clipboard.setData(ClipboardData(text: msg));
  }

  ///粘贴信息
  static Future<ClipboardData> getCopyMsg() async {
    return Clipboard.getData(Clipboard.kTextPlain);
  }

  //记录方法执行耗时
  static int recordExecuteTime(Function f) {
    var start = DateTime.now();
    f();
    var end = DateTime.now();
    var duration = end.difference(start);
    return duration.inSeconds;
  }

  //double类型的值，取后面几位小数。  默认进度:8
  static double formatDouble(double num, {int precision = 8}) {
    if ((num.toString().length - num.toString().lastIndexOf(".") - 1) < precision) {
      //小数点后有几位小数
      return double.parse(num.toStringAsFixed(precision).substring(0, num.toString().lastIndexOf(".") + precision + 1));
    } else {
      return double.parse(num.toString().substring(0, num.toString().lastIndexOf(".") + precision + 1));
    }
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

  //指数方法math.pow(x,y)
  static BigInt mathPow(int x, int y) {
    BigInt result = BigInt.from(1);
    while (y != 0) {
      result = result * BigInt.from(x);
      y--;
    }
    return result;
  }

  //以以太坊地址格式，检查字符串格式是否符合. 长度42  0x开头
  static bool checkByEthAddressFormat(String address) {
    const ethStandardAddressLength = 42; //以太坊标准地址42位
    if (address.isNotEmpty && (address.length == ethStandardAddressLength) && (address.toLowerCase().startsWith("0x"))) {
      return true;
    }
    return false;
  }

  // 获取应用文档 对应路径
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  // 返回应用文档路径对应File
  static Future<File> get _localFile async {
    final appPath = await _localPath;
    var directory = new Directory('$appPath');
    var isDirectoryExists = await directory.exists();
    if (!isDirectoryExists) {
      await directory.create();
    }
    final file = new File('$appPath' + "/" + GlobalConfig.diamondCaFileName);
    var isFileExists = await file.exists();
    if (!isFileExists) {
      await file.create();
    }
    return file;
  }

  //读取文件中的数据
  static Future<String> readFile() async {
    try {
      final file = await _localFile;
      String data = await file.readAsString();
      print(data);
      return data;
    } catch (e) {
      return "error";
    }
  }

  //将数据存储到文件中
  static Future<File> writeFile(String data) async {
    final file = await _localFile;
    return file.writeAsString(data);
  }
}

/// 默认dialog背景色为半透明黑色，这里修改源码改为透明
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
        barrierDismissible: outsideDismiss, //点击周围，要不要取消dialog显示。进度条的选 false
        builder: (_) {
          return WillPopScope(
            onWillPop: () async {
              // 拦截到返回键，证明dialog被手动关闭
              return Future.value(backKeyPop);
            },
            child: ProgressDialog(hintText: message),
          );
        });
  } catch (e) {
    LogUtil.e("showProgressDialog error is =>", e);
  }
}
