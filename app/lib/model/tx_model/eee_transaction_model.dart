class EeeTransactionModel {
  String _from;
  String _to;
  String _value;
  String _inputMsg;
  String _gasFee;
  String _signer;

  String get signer => _signer;

  set signer(String value) {
    _signer = value;
  }

  String get from => _from;

  set from(String value) {
    _from = value;
  }

  String get to => _to;

  String get gasFee => _gasFee;

  set gasFee(String value) {
    _gasFee = value;
  }

  String get inputMsg => _inputMsg;

  set inputMsg(String value) {
    _inputMsg = value;
  }

  String get value => _value;

  set value(String value) {
    _value = value;
  }

  set to(String value) {
    _to = value;
  }
}