enum ChainType { BTC, BtcTest, ETH, EthTest, EEE, EeeTest }

extension ChainTypeEx on ChainType {
  static const valueMap = const {
    ChainType.BTC: 1,
    ChainType.BtcTest: 2,
    ChainType.ETH: 3,
    ChainType.EthTest: 4,
    ChainType.EEE: 5,
    ChainType.EeeTest: 6,
  };

  int get value => valueMap[this];

  static ChainType from(String chainType) {
    ChainType re;
    switch (chainType) {
      case "BTC":
        re = ChainType.BTC;
        break;
      case "BtcTest":
        re = ChainType.BtcTest;
        break;
      case "ETH":
        re = ChainType.ETH;
        break;
      case "EthTest":
        re = ChainType.EthTest;
        break;
      case "EEE":
        re = ChainType.EEE;
        break;
      case "EeeTest":
        re = ChainType.EeeTest;
        break;
      default:
        {
          //todo log
          // let err = format!("the str:{} can not be ChainType", chain_type);
          // log.error!("{}", err);
          re = null;
        }
    }
    return re;
  }

  String toEnumString() {
    String re;
    switch (this) {
      case ChainType.BTC:
        re = "BTC";
        break;
      case ChainType.BtcTest:
        re = "BtcTest";
        break;
      case ChainType.ETH:
        re = "ETH";
        break;
      case ChainType.EthTest:
        re = "EthTest";
        break;
      case ChainType.EEE:
        re = "EEE";
        break;
      case ChainType.EeeTest:
        re = "EeeTest";
        break;
    }
    return re;
  }
}

enum WalletType {
  Normal,
  //钱包
  Test, //测试钱包，对应的链为测试链
}

extension WalletTypeEx on WalletType {
  static WalletType from(String walletType) {
    WalletType re;
    switch (walletType) {
      case "Normal":
        re = WalletType.Normal;
        break;
      case "Test":
        re = WalletType.Test;
        break;
      default:
        {
          //todo log
// log.error!("the str:{} can not be WalletType", wallet_type);
          re = WalletType.Test;
        }
    }
    return re;
  }

  String toEnumString() {
    String re;
    switch (this) {
      case WalletType.Normal:
        re = "Normal";
        break;
      case WalletType.Test:
        re = "Test";
        break;
    }
    return re;
  }
}

//
// /// 用来切换钱包的网络时使用的
// ///
// /// [WalletType.Test] 可以切换为 [NetType.Test]， [NetType.Private] ，[NetType.PrivateTest]
// ///
// /// [WalletType.Normal] 只能为 [NetType.Main]
// ///
// /// 测试钱包不能切换到主网，这样做是为了避免用户弄错了
// ///
// /// [WalletType.Test]:WalletType.TEST
// /// [WalletType.Normal]:WalletType.Normal
// /// [NetType.Main]:NetType.Main
// /// [NetType.Test]:NetType.Test
// /// [NetType.Test]:NetType.Test
// /// [NetType.PrivateTest]:NetType.PrivateTest

enum NetType {
  Main,
  Test,
  Private,
  PrivateTest,
}

extension NetTypeEx on NetType {
  static NetType defaultNetType(WalletType walletType) {
    NetType re;
    switch (walletType) {
      case WalletType.Normal:
        re = NetType.Main;
        break;
      case WalletType.Test:
        re = NetType.Test;
        break;
    }
    return re;
  }

  static NetType from(String netType) {
    NetType re;
    switch (netType) {
      case "Main":
        re = NetType.Main;
        break;
      case "Test":
        re = NetType.Test;
        break;
      case "Private":
        re = NetType.Private;
        break;
      case "PrivateTest":
        re = NetType.PrivateTest;
        break;
      default:
        {
          //todo log
// log.error!("the str:{} can not be NetType", net_type);
          re = NetType.Test;
        }
    }
    return re;
  }

  String toEnumString() {
    String re;
    switch (this) {
      case NetType.Main:
        re = "Main";
        break;
      case NetType.Test:
        re = "Test";
        break;
      case NetType.Private:
        re = "Private";
        break;
      case NetType.PrivateTest:
        re = "PrivateTest";
        break;
    }
    return re;
  }
}

extension StringEx on String {
  ChainType toChainType() {
    return ChainTypeEx.from(this);
  }

  WalletType toWalletType() {
    return WalletTypeEx.from(this);
  }

  NetType toNetType() {
    return NetTypeEx.from(this);
  }
}
