# app
用flutter技术开发的移动端钱包项目

## Getting Started
关于flutter技术，下面有几个参考链接，能帮助你入门了解flutter
- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

flutter官方启动教程如下：
For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), 包含教程、示例、移动端开发的说明和api相关。


cashbox目录结构说明：
 主要分为三个目录:
    1、app --- 用flutter开发钱包的主体功能代码。
    2、bc --- 提供生成动态库。 可以提供加密、解密、私钥生成、保存等底层独立的安全的相关功能。
    3、packages --- 功能插件，帮助扩展app处的功能，如提供钱包管理功能，webview功能。

---目录app之下，项目结构说明------------------------------
    android： android部分代码实现。创建flutter项目时，会自动生成这部分。
    ios：ios部分代码实现。创建flutter项目时，会自动生成这部分。
    res： 多语言字段配置文件。由插件flutter_localizations生成。
    test： 测试代码部分。
    lib目录下，结构说明：
        ---demo        功能调研测试代码
        ---generated   多语言插件，对应生成dart文件
        ---model       数据结构层
        ---net         网络访问工具
        ---page        界面样式内容
        ---provide     数据状态管理层，类似vuex 、redux
        ---res         常用资源层，跟外部asset文件夹区分
        ---routers     路由功能目录
        ---test        内部测试代码
        ---util        常用的一些工具代码，和通过Channel与原生交互的功能
        ---widgets     通用widget组件
        pubspec.yaml   项目配置文件

---目录bc下，项目功能说明----------------------
- [bc部分说明](https://github.com/scryinfo/cashbox/blob/master/bc/README.md)