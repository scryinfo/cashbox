# 使用说明

## wallet-test

用于将wallet lib编译成普通X86平台so文件，用于测试jni功能编写正确与否，可以将调试通过的代码，直接用于bc/device_app_lib。动态库的编译，直接在根目录下使用`cargo build --release`即可。

## wallet-jni-test

用于调用在`wallet-test`编译出来的`libwallets.so`,验证输入输出是否满足设计要求；
要正常使用该测试程序，有以下内容需要注意：

- 测试程序使用java编写，确保当前环境已经正确配置了`JAVA_HOME`、`Path`、`class_path`等java开发环境。
- 测试程序使用Maven方式构建，在使用时需要根据当前环境改变根目录下`pom.xml`中`-Djava.library.path`定义的值，指向实际编译出来的`so`路径.根据需要编写对应的测试功能，在项目的根目录下使用终端运行命令`mvn compile`进行编译，使用`mvn exec:exec`运行。
- 要测试Eth相关功能需要在本地搭建一个开发链或者私链都行，若是使用Parity 版本客户端，则直接使用`parity --config dev`即可以启动开发链；

**注意：** 若是修改了`JNI`[定义文件](../packages/wallet_manager/android/src/main/java/info/scry/wallet_manager/NativeLib.java)，为确保测试功能的同步还需要更新`NativeLib.java`文件。