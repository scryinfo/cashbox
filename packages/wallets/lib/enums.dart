import 'package:logger/logger.dart';

enum ChainType { BTC, BtcTest, ETH, EthTest, EEE, EeeTest }

const _tag = "Wallets";

extension ChainTypeEx on ChainType {
  // static const valueMap = const <ChainType,int> {
  //   ChainType.BTC: 1,
  //   ChainType.BtcTest: 2,
  //   ChainType.ETH: 3,
  //   ChainType.EthTest: 4,
  //   ChainType.EEE: 5,
  //   ChainType.EeeTest: 6,
  // };

  int get value {
    int index = 1;
    switch (this) {
      case ChainType.BTC:
        index = 1;
        break;
      case ChainType.BtcTest:
        index = 2;
        break;
      case ChainType.ETH:
        index = 3;
        break;
      case ChainType.EthTest:
        index = 4;
        break;
      case ChainType.EEE:
        index = 5;
        break;
      case ChainType.EeeTest:
        index = 6;
        break;
    }
    return index;
  }

  static ChainType from(String chainType) {
    ChainType re = ChainType.EEE;
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
          Logger.getInstance()
              .f(_tag, "the str:$chainType can not be ChainType");
          throw new Exception("the str:$chainType can not be ChainType");
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

//由于与dart中的重名，所以增加一个s
enum AppPlatformTypes {
  any,
  aarch64_linux_android,
  armv7_linux_androideabi,
  i686_linux_android,
  x86_64_linux_android,
  x86_64_pc_windows_gnu,
  x86_64_pc_windows_msvc,
  x86_64_unknown_linux_gnu,
  aarch64_apple_ios,
  x86_64_apple_ios
}

extension AppPlatformTypesEx on AppPlatformTypes {
  static AppPlatformTypes from(String str) {
    AppPlatformTypes re;
    switch (str) {
      case "any":
        re = AppPlatformTypes.any;
        break;
      case "aarch64_linux_android":
        re = AppPlatformTypes.aarch64_linux_android;
        break;
      case "armv7_linux_androideabi":
        re = AppPlatformTypes.armv7_linux_androideabi;
        break;
      case "i686_linux_android":
        re = AppPlatformTypes.i686_linux_android;
        break;
      case "x86_64_linux_android":
        re = AppPlatformTypes.x86_64_linux_android;
        break;
      case "x86_64_pc_windows_gnu":
        re = AppPlatformTypes.x86_64_pc_windows_gnu;
        break;
      case "x86_64_pc_windows_msvc":
        re = AppPlatformTypes.x86_64_pc_windows_msvc;
        break;
      case "x86_64_unknown_linux_gnu":
        re = AppPlatformTypes.x86_64_unknown_linux_gnu;
        break;
      case "aarch64_apple_ios":
        re = AppPlatformTypes.aarch64_apple_ios;
        break;
      case "x86_64_apple_ios":
        re = AppPlatformTypes.x86_64_apple_ios;
        break;
      default:
        re = AppPlatformTypes.any;
      // var err = "the str:$plat_type can not be AppPlatformType";
      //todo log
    }
    return re;
  }

  String toEnumString() {
    String re = "";
    switch (this) {
      case AppPlatformTypes.any:
        re = "any";
        break;
      case AppPlatformTypes.aarch64_linux_android:
        re = "aarch64_linux_android";
        break;
      case AppPlatformTypes.armv7_linux_androideabi:
        re = "armv7_linux_androideabi";
        break;
      case AppPlatformTypes.i686_linux_android:
        re = "i686_linux_android";
        break;
      case AppPlatformTypes.x86_64_linux_android:
        re = "x86_64_linux_android";
        break;
      case AppPlatformTypes.x86_64_pc_windows_gnu:
        re = "x86_64_pc_windows_gnu";
        break;
      case AppPlatformTypes.x86_64_pc_windows_msvc:
        re = "x86_64_pc_windows_msvc";
        break;
      case AppPlatformTypes.x86_64_unknown_linux_gnu:
        re = "x86_64_unknown_linux_gnu";
        break;
      case AppPlatformTypes.aarch64_apple_ios:
        re = "aarch64_apple_ios";
        break;
      case AppPlatformTypes.x86_64_apple_ios:
        re = "x86_64_apple_ios";
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

  AppPlatformTypes toAppPlatformTypes() {
    return AppPlatformTypesEx.from(this);
  }
}
