/*import 'dart:ffi' as ffi;
import 'dart:io' show Platform;

typedef hello_world_func = ffi.Void Function();

typedef HelloWorld = void Function();

class FfiDemoClass {
  static void hello() {
    var path = "./wallet.so";
    if (Platform.isWindows) {
      print("isWindows");
      path = "./libwallet.so";
    } else {
      print("not isWindows:===>" + path);
    }
    //if (Platform.isMacOS) path = "hello_library\libhello.dll";
    try {
      final dylib = ffi.DynamicLibrary.open(path);
      final HelloWorld helloExe = dylib.lookup<ffi.NativeFunction<hello_world_func>>('hello_world').asFunction();
      helloExe();
    } catch (e) {
      print("e===>" + e);
    }
  }

  static AssembleEthTx(String walletId, String value, String fromAddress, String toAddress) {

  }
}*/
// WalletFFI walletFFI = new WalletFFI();
// // todo ffi  assemble TX
// var txResultString = walletFFI.assembleEthTx(walletId, value, fromAddress, toAddress, backup);
// if (txResultString.isEmpty || txResultString.trim() == "") {
//   LogUtil.e("ethTxSign=======>", "txResultString.isEmpty");
//   return new Map();
// }