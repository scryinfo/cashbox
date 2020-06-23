# 项目说明
本项目为一款开源钱包 Cashbox，主要是实现移动端平台(android、ios)功能的开发。

## 技术选型说明
Cashbox钱包技术选型上，上层ui部分用flutter来实现，用rust编写的动态库，来实现底层的钱包管理、加密等功能。

### 环境和配置
#### 预配置信息（功能可选，不用的参数或接口，可先屏蔽掉）
-  定位到全项目中，搜索用到VendorGlobalConfig的地方，都需要替换成开发者自己，对应功能的ip。
-  申请测试币，和注册[etherscan](https://etherscan.io/)开发api。在etherscan_util文件中配置你的apikey
-  添加一些需要的默认配置信息，如法币对应价格的后端ip，其他公共接口ip等。位置在：app/lib/util/sharedpreference_util.dart
-  更改获取对应法币价格的接口。位置在app/lib/net/rate_util.dart。

#### 环境安装
-  安装开发工具[AndroidStudio](https://developer.android.com/studio/index.html)
-  安装[flutter SDK](https://flutterchina.club/get-started/install/)
-  编译动态库，具体在[bc](https://github.com/scryinfo/cashbox/blob/master/bc/README.md)（由rust语言编写），目录下有详细说明动态库的生成流程。

### 项目运行
   - 以android为例： 将编译好的动态库。 放在对应目录packages/wallet_manager/android/src/main/jniLibs/arm64-v8a下。
   - 进入到app目录下，先执行flutter pub get 同步依赖的工具包。
   - 电脑连接上android设备后， 执行flutter run    可运行起开发版的android应用。
   - flutter run --release 运行release版的应用（具体参数可根据开发需求来改变）
   - flutter run --dev
   - flutter build

## Cashbox项目结构说明：
### 主要分三个目录:
- 1、app --- 用flutter开发钱包的主体功能代码。
- 2、bc --- 提供生成动态库。 可以提供加密、解密、私钥生成、保存等底层独立的安全的相关功能。
- 3、packages --- 功能插件，帮助扩展app处的功能，如提供钱包管理功能，webview功能。

具体各功能模块，可进入对应模块查看说明文档
- [app部分说明](https://github.com/scryinfo/cashbox/blob/master/app/README.md)
- [bc部分说明](https://github.com/scryinfo/cashbox/blob/master/bc/README.md)

