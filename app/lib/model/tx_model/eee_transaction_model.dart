import 'package:app/model/tx_model/base_tx_model.dart';

class EeeTransactionModel extends BaseTxModel {
  String _inputMsg = "";
  String _gasFee = "";
  String _signer = "";
  String _blockHash = "";
  bool _isSuccess = false;

  bool get isSuccess => _isSuccess;

  set isSuccess(bool value) {
    _isSuccess = value;
  }

  String get blockHash => _blockHash;

  set blockHash(String value) {
    _blockHash = value;
  }

  String get signer => _signer;

  set signer(String value) {
    _signer = value;
  }

  String get gasFee => _gasFee;

  set gasFee(String value) {
    _gasFee = value;
  }

  String get inputMsg => _inputMsg;

  set inputMsg(String value) {
    _inputMsg = value;
  }
}
