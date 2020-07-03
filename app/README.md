
## 技术选型说明
关于flutter技术，下面有几个参考链接，能帮助你入门了解flutter
- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

### flutter官方启动教程如下：
- [online documentation](https://flutter.dev/docs) 包含教程、示例、移动端开发的说明和api相关。

### 目录app之下，项目结构说明
-  android： android部分代码实现。创建flutter项目时，会自动生成这部分。
-  ios：ios部分代码实现。创建flutter项目时，会自动生成这部分。
-  res： 多语言字段配置文件。由插件flutter_localizations生成。
-  test： 测试代码部分。
-  lib目录下，结构说明：
   - demo        功能调研测试代码
   - generated   多语言插件，对应生成dart文件
   - model       数据结构层
   - net         网络访问工具
   - page        界面样式内容
   - provide     数据状态管理层，类似vuex 、redux
   - res         常用资源层，跟外部asset文件夹区分
   - routers     路由功能目录
   - test        内部测试代码
   - util        常用的一些工具代码，和通过Channel与原生交互的功能
     - widgets     通用widget组件

     pubspec.yaml   项目配置文件

####
    生成签名文件
    keytool -genkey -v -keystore 秘钥文件目录/名称.jks -keyalg RSA -keysize 2048 -validity 有效天数 -alias 昵称

    查看andriod apk签名信息
    先安装jdk并配置好环境变量，然后运行->CMD->输入以下命令
    keytool -list -printcert -jarfile D:......\target.apk