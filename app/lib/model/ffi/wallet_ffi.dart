import 'dart:ffi' as ffi;
import 'dart:io' show Platform;
import "package:ffi/ffi.dart";

typedef assemble_tx_func = ffi.Pointer<Utf8> Function(
    ffi.Pointer<Utf8> fromAddress, ffi.Pointer<Utf8> toAddress, ffi.Pointer<Utf8> value, ffi.Pointer<Utf8> backupMsg);
typedef AssembleTx = ffi.Pointer<Utf8> Function(
    ffi.Pointer<Utf8> fromAddress, ffi.Pointer<Utf8> toAddress, ffi.Pointer<Utf8> value, ffi.Pointer<Utf8> backupMsg);

class WalletFFI {
  static WalletFFI _instance;

  //工厂单例类实现
  factory WalletFFI() => _getInstance();

  static WalletFFI get instance => _getInstance();

  static WalletFFI _getInstance() {
    if (_instance == null) {
      _instance = new WalletFFI._internal();
    }
    return _instance;
  }

  var path = "./wallet.so";                   //todo
  static const assembleEthTxFunctionName = ""; //todo

  WalletFFI._internal() {
    //init data
    if (Platform.isMacOS) path = "./primitives_library/libprimtives.dylib";
    if (Platform.isWindows) path = 'primitives_library\libprimitives.dll';
    path = "./libwallet.so";
  }

  String assembleEthTx(String walletId, String value, String fromAddress, String toAddress, String backupMsg) { //todo eth nonce获取位置 待定
    try {
      final dylib = ffi.DynamicLibrary.open(path);
      final AssembleTx assembleTx = dylib.lookup<ffi.NativeFunction<assemble_tx_func>>(assembleEthTxFunctionName).asFunction();
      return Utf8.fromUtf8(assembleTx(Utf8.toUtf8(fromAddress), Utf8.toUtf8(toAddress), Utf8.toUtf8(value), Utf8.toUtf8(backupMsg)));
    } catch (e) {
      print("e===============>" + e);
    }
    return "";
  }
}
