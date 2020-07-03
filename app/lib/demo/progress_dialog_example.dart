import 'dart:async';

import 'package:app/util/log_util.dart';
import 'package:app/util/utils.dart';
import 'package:app/widgets/progress_dialog.dart';
import 'package:flutter/material.dart';

void showProgressDialog(context) {
  try {
    showTransparentDialog(
        context: context,
        barrierDismissible: false, //Click around, whether to cancel the dialog display. Select false for the progress bar
        builder: (_) {
          return WillPopScope(
            onWillPop: () async {
              // Intercept to return key, prove dialog is closed manually
              return Future.value(true);
            },
            child: ProgressDialog(hintText: "loading..."),
          );
        });
    /*
    const timeout = Duration(seconds: 5);
    Timer(timeout, () {
      Navigator.pop(context); ///By canceling the dialog display
    });
    */
  } catch (e) {
    LogUtil.e("showProgressDialog error is =>", e);
  }
}
