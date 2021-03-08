import 'package:logger/logger.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../res/resources.dart';

class ProgressDialog extends Dialog {
  ProgressDialog({Key key, this.hintText}) : super(key: key);

  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          height: ScreenUtil().setHeight(120),
          width: ScreenUtil().setWidth(75),
          decoration: ShapeDecoration(color: Color(0xFFD7E5E9), shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0)))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CupertinoActivityIndicator(radius: 14.0),
              Gaps.vGap8,
              Text(
                hintText,
                style: TextStyle(color: Colors.black87),
              )
            ],
          ),
        ),
      ),
    );
  }

  static void showProgressDialog(context, message, {bool outsideDismiss: false, bool backKeyPop: true}) {
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
      Logger().e("showProgressDialog error is =>", e);
    }
  }

  /// The default dialog background color is translucent black. Here, the source code is changed to transparent
  static Future<T> showTransparentDialog<T>({
    @required BuildContext context,
    bool barrierDismissible = true,
    WidgetBuilder builder,
  }) {
    final ThemeData theme = Theme.of(context); // Theme.of(context, shadowThemeOnly: true);
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

  static Widget _buildMaterialDialogTransitions(
      BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
      opacity: CurvedAnimation(
        parent: animation,
        curve: Curves.easeOut,
      ),
      child: child,
    );
  }
}
