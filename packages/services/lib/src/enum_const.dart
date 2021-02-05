// type AppPlatformType string
//
// //命名使用 rustup target list中的名字
// const (
// AppPlatformType_any                      AppPlatformType = "any"
// AppPlatformType_aarch64_linux_android    AppPlatformType = "aarch64-linux-android"
// AppPlatformType_armv7_linux_androideabi  AppPlatformType = "armv7-linux-androideabi"
// AppPlatformType_i686_linux_android       AppPlatformType = "i686-linux-android"
// AppPlatformType_x86_64_linux_android     AppPlatformType = "x86_64-linux-android"
// AppPlatformType_x86_64_pc_windows_gnu    AppPlatformType = "x86_64-pc-windows-gnu"
// AppPlatformType_x86_64_unknown_linux_gnu AppPlatformType = "x86_64-unknown-linux-gnu"
// )

enum AppPlatformType {
  any,
  aarch64_linux_android,
  armv7_linux_androideabi,
  i686_linux_android,
  x86_64_linux_android,
  x86_64_pc_windows_gnu,
  x86_64_unknown_linux_gnu
}

extension AppPlatformTypeEx on AppPlatformType {
  static AppPlatformType from(String chainType) {
    AppPlatformType re;
    switch (chainType) {
      case "any":
        re = AppPlatformType.any;
        break;
      case "aarch64_linux_android":
        re = AppPlatformType.aarch64_linux_android;
        break;
      case "armv7_linux_androideabi":
        re = AppPlatformType.armv7_linux_androideabi;
        break;
      case "i686_linux_android":
        re = AppPlatformType.i686_linux_android;
        break;
      case "x86_64_linux_android":
        re = AppPlatformType.x86_64_linux_android;
        break;
      case "x86_64_pc_windows_gnu":
        re = AppPlatformType.x86_64_pc_windows_gnu;
        break;
      case "x86_64_unknown_linux_gnu":
        re = AppPlatformType.x86_64_unknown_linux_gnu;
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
      case AppPlatformType.any:
        re = "any";
        break;
      case AppPlatformType.aarch64_linux_android:
        re = "aarch64_linux_android";
        break;
      case AppPlatformType.armv7_linux_androideabi:
        re = "armv7_linux_androideabi";
        break;
      case AppPlatformType.i686_linux_android:
        re = "i686_linux_android";
        break;
      case AppPlatformType.x86_64_linux_android:
        re = "x86_64_linux_android";
        break;
      case AppPlatformType.x86_64_pc_windows_gnu:
        re = "x86_64_pc_windows_gnu";
        break;
      case AppPlatformType.x86_64_unknown_linux_gnu:
        re = "x86_64_unknown_linux_gnu";
        break;
    }
    return re;
  }
}

extension StringEx on String {
  AppPlatformType toAppPlatformType() {
    return AppPlatformTypeEx.from(this);
  }
}
