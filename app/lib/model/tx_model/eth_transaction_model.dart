import 'package:app/model/tx_model/base_tx_model.dart';

class EthTransactionModel extends BaseTxModel {
  String _blockNumber;
  String _hash;
  String _nonce;
  String _blockHash;
  String _transactionIndex;
  String _gas;
  String _gasPrice;
  String _isError;
  String _txreceipt_status;
  String _input;
  String _contractAddress;
  String _cumulativeGasUsed;
  String _gasUsed;
  String _confirmations;

  String get blockNumber => _blockNumber;

  set blockNumber(String value) {
    this._blockNumber = value;
  }

  setBlockNumber(String value) {
    this.blockNumber = value;
  }

  String get confirmations => _confirmations;

  set confirmations(String value) {
    _confirmations = value;
  }

  String get gasUsed => _gasUsed;

  set gasUsed(String value) {
    _gasUsed = value;
  }

  String get cumulativeGasUsed => _cumulativeGasUsed;

  set cumulativeGasUsed(String value) {
    _cumulativeGasUsed = value;
  }

  String get contractAddress => _contractAddress;

  set contractAddress(String value) {
    _contractAddress = value;
  }

  String get input => _input;

  set input(String value) {
    _input = value;
  }

  String get txreceipt_status => _txreceipt_status;

  set txreceipt_status(String value) {
    _txreceipt_status = value;
  }

  String get isError => _isError;

  set isError(String value) {
    _isError = value;
  }

  String get gasPrice => _gasPrice;

  set gasPrice(String value) {
    _gasPrice = value;
  }

  String get gas => _gas;

  set gas(String value) {
    _gas = value;
  }

  String get transactionIndex => _transactionIndex;

  set transactionIndex(String value) {
    _transactionIndex = value;
  }

  String get blockHash => _blockHash;

  set blockHash(String value) {
    _blockHash = value;
  }

  String get nonce => _nonce;

  set nonce(String value) {
    _nonce = value;
  }

  String get hash => _hash;

  set hash(String value) {
    _hash = value;
  }
}
