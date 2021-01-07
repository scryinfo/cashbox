import 'package:wallets/wallets_c.dc.dart';

import 'enums.dart';
import 'kits.dart';

class DlResult1<T1> {
  Error err;
  T1 data1;

  DlResult1(this.data1, this.err);

  bool isSuccess() => err.isSuccess();
}

class DlResult2<T1, T2> {
  Error err;
  T1 data1;
  T2 data2;

  DlResult2(this.data1, this.data2, this.err);

  bool isSuccess() => err.isSuccess();
}

class DlResult3<T1, T2, T3> {
  Error err;
  T1 data1;
  T2 data2;
  T3 data3;

  DlResult3(this.data1, this.data2, this.err);

  bool isSuccess() => err.isSuccess();
}

class CurrentWallet {
  String walletId;
  ChainType chainType;

  CurrentWallet(this.walletId, this.chainType);
}
