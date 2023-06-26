// AUTO GENERATED FILE, DO NOT EDIT.
//
// Generated by `package:ffigen`.
// ignore_for_file: type=lint
import 'dart:ffi' as ffi;

class Cdl {
  /// Holds the symbol lookup function.
  final ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName)
      _lookup;

  /// The symbols are looked up in [dynamicLibrary].
  Cdl(ffi.DynamicLibrary dynamicLibrary) : _lookup = dynamicLibrary.lookup;

  /// The symbols are looked up with [lookup].
  Cdl.fromLookup(
      ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName)
          lookup)
      : _lookup = lookup;

  int add(
    int a,
    int b,
  ) {
    return _add(
      a,
      b,
    );
  }

  late final _addPtr =
      _lookup<ffi.NativeFunction<ffi.Int Function(ffi.Int, ffi.Int)>>('add');
  late final _add = _addPtr.asFunction<int Function(int, int)>();

  int multi_i32(
    ffi.Pointer<ffi.Pointer<ffi.Int32>> v,
  ) {
    return _multi_i32(
      v,
    );
  }

  late final _multi_i32Ptr = _lookup<
      ffi.NativeFunction<
          ffi.Uint32 Function(
              ffi.Pointer<ffi.Pointer<ffi.Int32>>)>>('multi_i32');
  late final _multi_i32 = _multi_i32Ptr
      .asFunction<int Function(ffi.Pointer<ffi.Pointer<ffi.Int32>>)>();

  ffi.Pointer<ffi.Char> addStr(
    ffi.Pointer<ffi.Char> cs,
  ) {
    return _addStr(
      cs,
    );
  }

  late final _addStrPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Char> Function(ffi.Pointer<ffi.Char>)>>('addStr');
  late final _addStr = _addStrPtr
      .asFunction<ffi.Pointer<ffi.Char> Function(ffi.Pointer<ffi.Char>)>();

  void Str_free(
    ffi.Pointer<ffi.Char> cs,
  ) {
    return _Str_free(
      cs,
    );
  }

  late final _Str_freePtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<ffi.Char>)>>(
          'Str_free');
  late final _Str_free =
      _Str_freePtr.asFunction<void Function(ffi.Pointer<ffi.Char>)>();

  ffi.Pointer<Data> Data_new() {
    return _Data_new();
  }

  late final _Data_newPtr =
      _lookup<ffi.NativeFunction<ffi.Pointer<Data> Function()>>('Data_new');
  late final _Data_new =
      _Data_newPtr.asFunction<ffi.Pointer<Data> Function()>();

  void Data_free(
    ffi.Pointer<Data> cd,
  ) {
    return _Data_free(
      cd,
    );
  }

  late final _Data_freePtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<Data>)>>(
          'Data_free');
  late final _Data_free =
      _Data_freePtr.asFunction<void Function(ffi.Pointer<Data>)>();

  ffi.Pointer<Data> Data_use(
    ffi.Pointer<Data> cd,
  ) {
    return _Data_use(
      cd,
    );
  }

  late final _Data_usePtr = _lookup<
          ffi.NativeFunction<ffi.Pointer<Data> Function(ffi.Pointer<Data>)>>(
      'Data_use');
  late final _Data_use =
      _Data_usePtr.asFunction<ffi.Pointer<Data> Function(ffi.Pointer<Data>)>();

  Data Data_noPtr() {
    return _Data_noPtr();
  }

  late final _Data_noPtrPtr =
      _lookup<ffi.NativeFunction<Data Function()>>('Data_noPtr');
  late final _Data_noPtr = _Data_noPtrPtr.asFunction<Data Function()>();

  ffi.Pointer<ffi.Pointer<CSample>> CSample_dAlloc() {
    return _CSample_dAlloc();
  }

  late final _CSample_dAllocPtr =
      _lookup<ffi.NativeFunction<ffi.Pointer<ffi.Pointer<CSample>> Function()>>(
          'CSample_dAlloc');
  late final _CSample_dAlloc = _CSample_dAllocPtr.asFunction<
      ffi.Pointer<ffi.Pointer<CSample>> Function()>();

  void CSample_dFree(
    ffi.Pointer<ffi.Pointer<CSample>> ptr,
  ) {
    return _CSample_dFree(
      ptr,
    );
  }

  late final _CSample_dFreePtr = _lookup<
      ffi.NativeFunction<
          ffi.Void Function(
              ffi.Pointer<ffi.Pointer<CSample>>)>>('CSample_dFree');
  late final _CSample_dFree = _CSample_dFreePtr.asFunction<
      void Function(ffi.Pointer<ffi.Pointer<CSample>>)>();

  void CSample_create(
    ffi.Pointer<ffi.Pointer<CSample>> ptr,
  ) {
    return _CSample_create(
      ptr,
    );
  }

  late final _CSample_createPtr = _lookup<
      ffi.NativeFunction<
          ffi.Void Function(
              ffi.Pointer<ffi.Pointer<CSample>>)>>('CSample_create');
  late final _CSample_create = _CSample_createPtr.asFunction<
      void Function(ffi.Pointer<ffi.Pointer<CSample>>)>();
}

final class __fsid_t extends ffi.Struct {
  @ffi.Array.multi([2])
  external ffi.Array<ffi.Int> __val;
}

final class Data extends ffi.Struct {
  @ffi.Int()
  external int intType;

  external ffi.Pointer<ffi.Char> charType;

  external ffi.Pointer<ffi.Int> arrayInt;

  @ffi.UnsignedLongLong()
  external int arrayIntLength;

  external ffi.Pointer<Data> arrayData;

  @ffi.UnsignedLongLong()
  external int arrayDataLength;

  external ffi.Pointer<Data> pointData;
}

/// c的数组需要定义两个字段，所定义一个结构体进行统一管理
/// 注：c不支持范型，所以cbindgen工具会使用具体的类型来代替
final class CArrayCChar extends ffi.Struct {
  external ffi.Pointer<ffi.Pointer<ffi.Char>> ptr;

  @CU64()
  external int len;

  @CU64()
  external int cap;
}

typedef CU64 = ffi.Uint64;

final class CSample extends ffi.Struct {
  @ffi.Uint32()
  external int len;

  external ffi.Pointer<ffi.Char> name;

  external CArrayCChar list;
}

const int _STDINT_H = 1;

const int _FEATURES_H = 1;

const int _DEFAULT_SOURCE = 1;

const int __GLIBC_USE_ISOC2X = 1;

const int __USE_ISOC11 = 1;

const int __USE_ISOC99 = 1;

const int __USE_ISOC95 = 1;

const int _POSIX_SOURCE = 1;

const int _POSIX_C_SOURCE = 200809;

const int __USE_POSIX = 1;

const int __USE_POSIX2 = 1;

const int __USE_POSIX199309 = 1;

const int __USE_POSIX199506 = 1;

const int __USE_XOPEN2K = 1;

const int __USE_XOPEN2K8 = 1;

const int _ATFILE_SOURCE = 1;

const int __WORDSIZE = 64;

const int __WORDSIZE_TIME64_COMPAT32 = 1;

const int __SYSCALL_WORDSIZE = 64;

const int __TIMESIZE = 64;

const int __USE_MISC = 1;

const int __USE_ATFILE = 1;

const int __USE_FORTIFY_LEVEL = 0;

const int __GLIBC_USE_DEPRECATED_GETS = 0;

const int __GLIBC_USE_DEPRECATED_SCANF = 0;

const int _STDC_PREDEF_H = 1;

const int __STDC_IEC_559__ = 1;

const int __STDC_IEC_559_COMPLEX__ = 1;

const int __STDC_ISO_10646__ = 201706;

const int __GNU_LIBRARY__ = 6;

const int __GLIBC__ = 2;

const int __GLIBC_MINOR__ = 31;

const int _SYS_CDEFS_H = 1;

const int __glibc_c99_flexarr_available = 1;

const int __HAVE_GENERIC_SELECTION = 0;

const int __GLIBC_USE_LIB_EXT2 = 1;

const int __GLIBC_USE_IEC_60559_BFP_EXT = 1;

const int __GLIBC_USE_IEC_60559_BFP_EXT_C2X = 1;

const int __GLIBC_USE_IEC_60559_FUNCS_EXT = 1;

const int __GLIBC_USE_IEC_60559_FUNCS_EXT_C2X = 1;

const int __GLIBC_USE_IEC_60559_TYPES_EXT = 1;

const int _BITS_TYPES_H = 1;

const int _BITS_TYPESIZES_H = 1;

const int __OFF_T_MATCHES_OFF64_T = 1;

const int __INO_T_MATCHES_INO64_T = 1;

const int __RLIM_T_MATCHES_RLIM64_T = 1;

const int __STATFS_MATCHES_STATFS64 = 1;

const int __FD_SETSIZE = 1024;

const int _BITS_TIME64_H = 1;

const int _BITS_WCHAR_H = 1;

const int __WCHAR_MAX = 2147483647;

const int __WCHAR_MIN = -2147483648;

const int _BITS_STDINT_INTN_H = 1;

const int _BITS_STDINT_UINTN_H = 1;

const int INT8_MIN = -128;

const int INT16_MIN = -32768;

const int INT32_MIN = -2147483648;

const int INT64_MIN = -9223372036854775808;

const int INT8_MAX = 127;

const int INT16_MAX = 32767;

const int INT32_MAX = 2147483647;

const int INT64_MAX = 9223372036854775807;

const int UINT8_MAX = 255;

const int UINT16_MAX = 65535;

const int UINT32_MAX = 4294967295;

const int UINT64_MAX = -1;

const int INT_LEAST8_MIN = -128;

const int INT_LEAST16_MIN = -32768;

const int INT_LEAST32_MIN = -2147483648;

const int INT_LEAST64_MIN = -9223372036854775808;

const int INT_LEAST8_MAX = 127;

const int INT_LEAST16_MAX = 32767;

const int INT_LEAST32_MAX = 2147483647;

const int INT_LEAST64_MAX = 9223372036854775807;

const int UINT_LEAST8_MAX = 255;

const int UINT_LEAST16_MAX = 65535;

const int UINT_LEAST32_MAX = 4294967295;

const int UINT_LEAST64_MAX = -1;

const int INT_FAST8_MIN = -128;

const int INT_FAST16_MIN = -9223372036854775808;

const int INT_FAST32_MIN = -9223372036854775808;

const int INT_FAST64_MIN = -9223372036854775808;

const int INT_FAST8_MAX = 127;

const int INT_FAST16_MAX = 9223372036854775807;

const int INT_FAST32_MAX = 9223372036854775807;

const int INT_FAST64_MAX = 9223372036854775807;

const int UINT_FAST8_MAX = 255;

const int UINT_FAST16_MAX = -1;

const int UINT_FAST32_MAX = -1;

const int UINT_FAST64_MAX = -1;

const int INTPTR_MIN = -9223372036854775808;

const int INTPTR_MAX = 9223372036854775807;

const int UINTPTR_MAX = -1;

const int INTMAX_MIN = -9223372036854775808;

const int INTMAX_MAX = 9223372036854775807;

const int UINTMAX_MAX = -1;

const int PTRDIFF_MIN = -9223372036854775808;

const int PTRDIFF_MAX = 9223372036854775807;

const int SIG_ATOMIC_MIN = -2147483648;

const int SIG_ATOMIC_MAX = 2147483647;

const int SIZE_MAX = -1;

const int WCHAR_MIN = -2147483648;

const int WCHAR_MAX = 2147483647;

const int WINT_MIN = 0;

const int WINT_MAX = 4294967295;

const int CFalse = 0;

const int CTrue = 1;
