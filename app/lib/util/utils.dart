import 'dart:typed_data';

import 'package:flutter/material.dart';
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

  //记录方法执行耗时
  static int recordExecuteTime(Function f) {
    var start = DateTime.now();
    f();
    var end = DateTime.now();
    var duration = end.difference(start);
    return duration.inSeconds;
  }

  //double类型的值，取后面几位小数
  static double formatDouble(double num, int position) {
    if ((num.toString().length - num.toString().lastIndexOf(".") - 1) < position) {
      //小数点后有几位小数
      print("< position===>" + num.toStringAsFixed(position).substring(0, num.toString().lastIndexOf(".") + position + 1));
      return double.parse(num.toStringAsFixed(position).substring(0, num.toString().lastIndexOf(".") + position + 1));
    } else {
      print("> position===>" + num.toString().substring(0, num.toString().lastIndexOf(".") + position + 1));
      return double.parse(num.toString().substring(0, num.toString().lastIndexOf(".") + position + 1));
    }
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
