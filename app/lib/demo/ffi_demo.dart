import 'dart:ffi';
import 'dart:io' show Platform;
/*
* flutter直接引用so动态库，不需要管通过cmake等编译生成so的流程。
*
* 配置： 引入so库
*     android平台：
*         android/build.gradle文件
*         sourceSets{
            // ...
            main.jniLibs.srcDirs = ['libs']
          }
      ios平台：
          修改flutter_no_cpp_src.podspec文件
          s.vendored_frameworks = 'some.framework'
*  */

/*
 preview：需要事先定义

 1、   C函数方法名 和 参数。
 即：  "native_add"     和     Int32,Int32
 文件位置？？
*/

//用法
final DynamicLibrary nativeAddLib = Platform.isAndroid
    ? DynamicLibrary.open("libsome.so") //android目录下 so包名
    : DynamicLibrary.open("some.framework/some");
final int Function(int x, int y) nativeAdd = nativeAddLib.lookup<NativeFunction<Int32 Function(Int32, Int32)>>("native_add").asFunction();

void testFunc(num a, num b) {
  nativeAdd(a, b);
}
