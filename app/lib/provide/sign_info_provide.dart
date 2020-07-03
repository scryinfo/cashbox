import 'package:flutter/foundation.dart';

class SignInfoProvide with ChangeNotifier {
  String _waitToSignInfo;

  get waitToSignInfo => _waitToSignInfo;

  /*Check the completion of each call, clean up the data record*/
  void emptyData() {
    this._waitToSignInfo = null;
  }

  void setWaitToSignInfo(String waitToSignInfo) {
    this._waitToSignInfo = waitToSignInfo;
  }
}
