# 文件说明

- wallet-test:用于将wallet lib编译成普通X86平台so文件，用于测试jni功能编写正确与否，可以将调试通过的代码，直接用于bc/device_app_lib
- wallet-jni-test:用于调用上面编译的libwallets.so,验证输入输出是否满足设计要求；在使用时，需要根据当前环境改变`pom.xml`中`-Djava.library.path`定义的值，指向实际编译出来的`so`路径，使用命令`mvn compile`进行编译，使用`mvn exec:exec`运行。**注意：** 若是修改了`JNI`定义文件，则还需要同步更新`NativeLib.java`文件