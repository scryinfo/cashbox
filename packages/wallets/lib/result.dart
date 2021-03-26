import 'package:wallets/wallets_c.dc.dart';

import 'enums.dart';
import 'kits.dart';

//动态库一个返回值，由于dart函数不支持返回多个值，所以增加class来处理返回多个值的情况
class DlResult1<T1> {
  Error err;
  T1 data1;

  DlResult1(this.data1, this.err);

  bool isSuccess() => err.isSuccess();
}

//动态库两个返回值
class DlResult2<T1, T2> {
  Error err;
  T1 data1;
  T2 data2;

  DlResult2(this.data1, this.data2, this.err);

  bool isSuccess() => err.isSuccess();
}

//动态库三个返回值
class DlResult3<T1, T2, T3> {
  Error err;
  T1 data1;
  T2 data2;
  T3 data3;

  DlResult3(this.data1, this.data2, this.data3, this.err);

  bool isSuccess() => err.isSuccess();
}

//当前钱包
class CurrentWallet {
  String walletId;
  ChainType chainType;

  CurrentWallet(this.walletId, this.chainType);

  factory CurrentWallet.initValue() {
    return new CurrentWallet("", ChainType.EEE); //null safe, just any type
  }
}
