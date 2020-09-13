class BaseTxModel{
  String _from;
  String _to;
  String _value;
  String _timeStamp;

  String get timeStamp => _timeStamp;

  set timeStamp(String value) {
    _timeStamp = value;
  }

  String get from => _from;

  set from(String value) {
    _from = value;
  }

  String get value => _value;

  set value(String value) {
    _value = value;
  }

  String get to => _to;

  set to(String value) {
    _to = value;
  }
}