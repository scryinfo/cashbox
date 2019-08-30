import 'dart:async';

import 'package:app/util/log_util.dart';
import 'package:app/util/utils.dart';
import 'package:app/widgets/progress_dialog.dart';
import 'package:flutter/material.dart';

void showProgressDialog(context) {
  try {
    showTransparentDialog(
        context: context,
        barrierDismissible: false, //点击周围，要不要取消dialog显示。进度条的选 false
        builder: (_) {
          return WillPopScope(
            onWillPop: () async {
              // 拦截到返回键，证明dialog被手动关闭
              return Future.value(true);
            },
            child: ProgressDialog(hintText: "正在加载..."),
          );
        });
    /*
    const timeout = Duration(seconds: 5);
    Timer(timeout, () {
      Navigator.pop(context); ///通过取消dialog显示
    });
    */
  } catch (e) {
    LogUtil.e("showProgressDialog error is =>", e);
  }
}
