import 'dart:convert';
import 'dart:ffi';
import 'dart:io' show Platform;

import 'dart:typed_data';
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
 文件位置？？？
 交互数据类型？？？
 string       ok
 list         ok
 bool         ok
 byte[]       ok
 int          ok

 返回类型      解析Pointer  ok

*/

//用法
final DynamicLibrary nativeAddLib = Platform.isAndroid
    ? DynamicLibrary.open("libsome.so") //android目录下 so包名
    : DynamicLibrary.open("some.framework/some");

final int Function(int x, int y) nativeAdd = nativeAddLib.lookup<NativeFunction<Int32 Function(Int32, Int32)>>("native_add").asFunction();

void testFunc(num a, num b) {
  nativeAdd(a, b);
  Int8 test = Int8();
}

/*---------------------------------- ffi参数string类型的实现-------------------------------------*/
const int _kMaxSmi64 = (1 << 62) - 1;
const int _kMaxSmi32 = (1 << 30) - 1;
final int _maxSize = sizeOf<IntPtr>() == 8 ? _kMaxSmi64 : _kMaxSmi32;

class Utf8 extends Struct {
  static int strLen(Pointer<Utf8> string) {
    final Pointer<Uint8> array = string.cast<Uint8>();
    final Uint8List nativeString = array.asTypedList(_maxSize);
    return nativeString.indexWhere((char) => char == 0);
  }

  static String fromUtf8(Pointer<Utf8> string) {
    final int length = strLen(string);
    return utf8.decode(Uint8List.view(string.cast<Uint8>().asTypedList(length).buffer, 0, length));
  }

  /*{
  // todo 字符串数组
    allocate<Pointer<Uint8>>(count: 100);
  }*/
  // 将dart中的字符串，转换成 指针
  static Pointer<Utf8> toUtf8(String string) {
    final units = utf8.encode(string); // 算出string在utf8格式下，占得 字节uInt数
    final Pointer<Uint8> result = allocate<Uint8>(count: units.length + 1);
    final Uint8List nativeString = result.asTypedList(units.length + 1);
    nativeString.setAll(0, units);
    nativeString[units.length] = 0;
    return result.cast();
  }

  String toString() => fromUtf8(addressOf);
}

typedef PosixMallocNative = Pointer Function(IntPtr);
typedef PosixMalloc = Pointer Function(int);

Pointer<T> allocate<T extends NativeType>({int count = 1}) {
  //调用C的 malloc方法，分配内存大小
  final PosixMalloc posixMalloc = nativeAddLib.lookupFunction<PosixMallocNative, PosixMalloc>("malloc");
  final int totalSize = count * sizeOf<T>();
  Pointer<T> result;
  if (Platform.isWindows) {
    // result = winHeapAlloc(processHeap, /*flags=*/ 0, totalSize).cast();
  } else {
    result = posixMalloc(totalSize).cast();
  }
  if (result.address == 0) {
    throw ArgumentError("Could not allocate $totalSize bytes.");
  }
  return result;
}

//写入string类型 log内容
typedef WriteLogDart = void Function(int, Pointer<Utf8>, int, Pointer<Utf8>, int, int);
typedef WriteLog = Void Function(Int32, Pointer<Utf8>, Int64, Pointer<Utf8>, Int64, Int64);

void write(int flag, String log, int time, String threadName, int threadId, bool isMainThread) {
  final writeLogan = nativeAddLib.lookup<NativeFunction<WriteLog>>('writeLog');
  final write = writeLogan.asFunction<WriteLogDart>();
  write(flag, Utf8.toUtf8(log), time, Utf8.toUtf8(threadName), threadId, isMainThread ? 0 : 1);
}
/*----------------------------------------------end-------------------------------------------------*/
