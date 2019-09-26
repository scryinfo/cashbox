import 'package:flutter/foundation.dart';

class SignInfoProvide with ChangeNotifier {
  String _waitToSignInfo;

  get waitToSignInfo => _waitToSignInfo;

  /*检查每次调用完毕，清理数据记录*/
  void emptyData() {
    this._waitToSignInfo = null;
  }

  void setWaitToSignInfo(String waitToSignInfo) {
    this._waitToSignInfo = waitToSignInfo;
  }
}
