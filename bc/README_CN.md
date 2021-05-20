## 项目结构说明

bc是blockchain的简称，为cashbox钱包提供链相关功能实现，通过编译成动态库与客户端程序进行交互。目前实现的功能包含钱包管理，Ethereum,Scryx（基于[Substrate](https://github.com/paritytech/substrate)实现的链）交易生成，签名等钱包最基础的核心功能。（目前bitcoin相关内容还未整合进来）

## 代码组织结构

当前代码主要由以下模块组成：

- `chain`:它主要为钱包支持的链提供交易签名，地址生成，交易记录解码等功能，当前支持的链有`Bitcion`,`Ethereum`,基于`Substate`开发的链；
- `mav`：目前动态库使用`rbatis`库实现数据访问。 为了操作方便，在此位置定义了与数据库交互的数据模型层。
- `wallets`:实现了钱包的管理功能，比如助记词的管理、代币的管理；通过`wallets_cdl`中暴露出去的方法与用户交互，实现了用户数据的存储；
- `util`:实现了wallet中操作需要的一些通用但是跟钱包业务关系不是很紧密的功能，可以独立于钱包的存在，数据的加解密、密钥协商；
- `wallets_cdl`:用于封装最终适配平台的功能，并通过本机函数调用提供给Android平台;
- `wallets_macro`:在整个动态库中定义各种宏，以简化代码编写； 例如，在使用C接口参数时，有必要转换`C`定义的数据结构和`Rust`数据类型，以及在数据模型层结构的定义中广泛使用的子结构；
- `wallet_types`:用于定义在`wallets_cdl`中方法参数相对应的Rust类型；

## 开发环境搭建

### Rust编译

bc功能是使用`rust`实现，程序编译需要依赖rust的编译环境。关于rust编译环境的搭建，可以[点击这里](https://www.rust-lang.org/tools/install),官方提供了各种安装方式的安装教程。建议使用脚本一键安装，为确保能够快速安装成功，**需要将命令行开启代理**。

### 动态库编译

使用rust提供的工具能够快速的搭建交叉编译环境，为不同的硬件平台提供满足要求的动态库。

- 确保已安装`Android NDK`
  - 您可能还需要SDK管理器提供的LLVM，使用版本为 [NDK21](https://developer.android.com/ndk/downloads?hl=zh-cn)。根据操作系统类型选择对应的版本下载对应的版本即可,建议下载最新的稳定版本；
- 确保环境变量`$ANDROID_NDK`指向`NDK`根目录：
    - 在 MacOs平台下类似这样的路径 `/Users/xxx/Library/Android/sdk/ndk-bundle`;
    - 在Linux平台下路径：`/home/xxx/dev/android/ndk-bundle`;

- 添加支持的平台
```
rustup target add aarch64-apple-ios x86_64-apple-ios
rustup target add aarch64-linux-android armv7-linux-androideabi i686-linux-android x86_64-linux-android
rustup target add x86_64-pc-windows-gnu
rustup target add x86_64-unknown-linux-gnu
```

关于搭建使用Rust来搭建Android、IOS交叉编译环境，更详细的操作过程[参考这里](https://dev.to/robertohuertasm/rust-once-and-share-it-with-android-ios-and-flutter-286o)。

### Dart文件生成
当`Flutter`通过`FFI`方法调用动态库提供的C接口时，它需要使用在Rust中定义接口的相应Dart文件。可以使用如下命令直接安装：

- cargo install --force cbindgen  //[更多介绍](https://github.com/eqrion/cbindgen/)
- cargo install --force dart-bindgen --features cli //[更多介绍](https://github.com/sunshine-protocol/dart-bindgen)
- 在`windows`平台还需要安装
    - 安装[LLvm](https://releases.llvm.org/)
    - 设置环境变量: `LIBCLANG_PATH = D:\lang\LLVM\bin`

## 动态库编译

- 根据要编译的目标平台，在./wallets_cdl/script/中选择相应的编译脚本。最终生成的动态库位于目标目录中。
- 执行脚本`gen.bat`或`gen.sh`，它将在目录../wallets_cdl/script中生成.h，.dart文件并将其复制到正确的位置。