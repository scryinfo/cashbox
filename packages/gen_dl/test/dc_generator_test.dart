@TestOn('vm')
import 'package:build_test/build_test.dart';
import 'package:gen_dl/src/dc_generator.dart';
import 'package:source_gen/source_gen.dart';
import 'package:test/test.dart';

void main() {
  tearDown(() {
    _pkgCacheCount++;
  });
  test('Simple Generator test', () async {
    await _generateTest(const DCGenerator(), _testGenCode);
  });
}

const _testGenCode = r'''// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// DCGenerator
// **************************************************************************

import 'dart:ffi';
import 'package:ffi/ffi.dart' as ffi;

import 'wallets_c.dart' as clib;
import 'kits.dart';

class Error extends DC<clib.CError> {
  int code;
  String message;

  static freeInstance(clib.CError instance) {
    if (instance == null) {
      return;
    }
    if (instance.message != null && instance.message != nullptr) {
      ffi.calloc.free(instance.message);
    }
    instance.message = nullptr;
  }

  static free(Pointer<clib.CError> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }

  static Error fromC(Pointer<clib.CError> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new Error();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CError> toCPtr() {
    var ptr = allocateZero<clib.CError>();
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CError> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }

  @override
  toCInstance(clib.CError c) {
    if (c == null) {
      return;
    }
    c.code = code;
    if (c.message != null && c.message != nullptr) {
      ffi.calloc.free(c.message);
    }
    c.message = toUtf8Null(message);
  }

  @override
  toDart(Pointer<clib.CError> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CError c) {
    if (c == null) {
      return;
    }
    code = c.code;
    message = fromUtf8Null(c.message);
  }
}

class Address extends DC<clib.CAddress> {
  String name;
  Error err;
  Error instance;
  ArrayCAddress arrayCAddress;

  Address() {
    err = new Error();
    instance = new Error();
    arrayCAddress = new ArrayCAddress();
  }

  static freeInstance(clib.CAddress instance) {
    if (instance == null) {
      return;
    }
    if (instance.name != null && instance.name != nullptr) {
      ffi.calloc.free(instance.name);
    }
    instance.name = nullptr;
    Error.free(instance.err);
    instance.err = nullptr;
    if (instance.instance != null) {
      Error.freeInstance(instance.instance);
    }
    instance.instance = null;
    if (instance.arrayCAddress != null) {
      ArrayCAddress.freeInstance(instance.arrayCAddress);
    }
    instance.arrayCAddress = null;
  }

  static free(Pointer<clib.CAddress> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }

  static Address fromC(Pointer<clib.CAddress> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new Address();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CAddress> toCPtr() {
    var ptr = allocateZero<clib.CAddress>();
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CAddress> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }

  @override
  toCInstance(clib.CAddress c) {
    if (c == null) {
      return;
    }
    if (c.name != null && c.name != nullptr) {
      ffi.calloc.free(c.name);
    }
    c.name = toUtf8Null(name);
    if (c.err == null || c.err == nullptr) {
      c.err = allocateZero<clib.CError>();
    }
    err.toC(c.err);
    instance.toCInstance(c.instance);
    arrayCAddress.toCInstance(c.arrayCAddress);
  }

  @override
  toDart(Pointer<clib.CAddress> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CAddress c) {
    if (c == null) {
      return;
    }
    name = fromUtf8Null(c.name);
    err = new Error();
    err.toDart(c.err);
    instance = new Error();
    instance.toDartInstance(c.instance);
    arrayCAddress = new ArrayCAddress();
    arrayCAddress.toDartInstance(c.arrayCAddress);
  }
}

class ArrayCAddress extends DC<clib.CArrayCAddress> {
  List<Address> data;

  ArrayCAddress() {
    data = <Address>[];
  }

  static free(Pointer<clib.CArrayCAddress> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }

  static freeInstance(clib.CArrayCAddress instance) {
    if (instance == null) {
      return;
    }
    Address.free(instance.ptr);
    instance.ptr = nullptr;
  }

  static ArrayCAddress fromC(Pointer<clib.CArrayCAddress> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new ArrayCAddress();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CArrayCAddress> toCPtr() {
    var c = allocateZero<clib.CArrayCAddress>();
    toC(c);
    return c;
  }

  @override
  toC(Pointer<clib.CArrayCAddress> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }

  @override
  toCInstance(clib.CArrayCAddress c) {
    if (c == null) {
      return;
    }
    if (c.ptr != nullptr && c.ptr != null) {
      Address.free(c.ptr);
      c.ptr = nullptr;
    }
    c.ptr = allocateZero<clib.CAddress>(count: data.length);
    c.len = data.length;
    c.cap = data.length;
    for (var i = 0; i < data.length; i++) {
      data[i].toC(c.ptr.elementAt(i));
    }
  }

  @override
  toDart(Pointer<clib.CArrayCAddress> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CArrayCAddress c) {
    if (c == null) {
      return;
    }
    data = List.filled(c.len, null);
    for (var i = 0; i < data.length; i++) {
      data[i] = new Address();
      data[i].toDart(c.ptr.elementAt(i));
    }
  }
}

class ArrayInt32 extends DC<clib.CArrayInt32> {
  List<int> data;

  ArrayInt32() {
    data = <int>[];
  }

  static free(Pointer<clib.CArrayInt32> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }

  static freeInstance(clib.CArrayInt32 instance) {
    if (instance == null) {
      return;
    }
    instance.ptr.free();
    instance.ptr = nullptr;
  }

  static ArrayInt32 fromC(Pointer<clib.CArrayInt32> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new ArrayInt32();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CArrayInt32> toCPtr() {
    var c = allocateZero<clib.CArrayInt32>();
    toC(c);
    return c;
  }

  @override
  toC(Pointer<clib.CArrayInt32> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }

  @override
  toCInstance(clib.CArrayInt32 c) {
    if (c == null) {
      return;
    }
    if (c.ptr != nullptr && c.ptr != null) {
      c.ptr.free();
      c.ptr = nullptr;
    }
    c.ptr = allocateZero<Int32>(count: data.length);
    c.len = data.length;
    c.cap = data.length;
    for (var i = 0; i < data.length; i++) {
      c.ptr.elementAt(i).value = data[i];
    }
  }

  @override
  toDart(Pointer<clib.CArrayInt32> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CArrayInt32 c) {
    if (c == null) {
      return;
    }
    data = List.filled(c.len, null);
    for (var i = 0; i < data.length; i++) {
      data[i] = c.ptr.elementAt(i).value;
    }
  }
}

class NativeType extends DC<clib.CNativeType> {
  int ptrInt8;
  int ptrInt16;
  int ptrInt32;
  int ptrInt64;
  int ptrUInt8;
  int ptrUInt16;
  int ptrUInt32;
  int ptrUInt64;
  double ptrFloat;
  double ptrDouble;

  static freeInstance(clib.CNativeType instance) {
    if (instance == null) {
      return;
    }
    if (instance.ptrInt8 != null && instance.ptrInt8 != nullptr) {
      ffi.calloc.free(instance.ptrInt8);
    }
    instance.ptrInt8 = nullptr;
    if (instance.ptrInt16 != null && instance.ptrInt16 != nullptr) {
      ffi.calloc.free(instance.ptrInt16);
    }
    instance.ptrInt16 = nullptr;
    if (instance.ptrInt32 != null && instance.ptrInt32 != nullptr) {
      ffi.calloc.free(instance.ptrInt32);
    }
    instance.ptrInt32 = nullptr;
    if (instance.ptrInt64 != null && instance.ptrInt64 != nullptr) {
      ffi.calloc.free(instance.ptrInt64);
    }
    instance.ptrInt64 = nullptr;
    if (instance.ptrUInt8 != null && instance.ptrUInt8 != nullptr) {
      ffi.calloc.free(instance.ptrUInt8);
    }
    instance.ptrUInt8 = nullptr;
    if (instance.ptrUInt16 != null && instance.ptrUInt16 != nullptr) {
      ffi.calloc.free(instance.ptrUInt16);
    }
    instance.ptrUInt16 = nullptr;
    if (instance.ptrUInt32 != null && instance.ptrUInt32 != nullptr) {
      ffi.calloc.free(instance.ptrUInt32);
    }
    instance.ptrUInt32 = nullptr;
    if (instance.ptrUInt64 != null && instance.ptrUInt64 != nullptr) {
      ffi.calloc.free(instance.ptrUInt64);
    }
    instance.ptrUInt64 = nullptr;
    if (instance.ptrFloat != null && instance.ptrFloat != nullptr) {
      ffi.calloc.free(instance.ptrFloat);
    }
    instance.ptrFloat = nullptr;
    if (instance.ptrDouble != null && instance.ptrDouble != nullptr) {
      ffi.calloc.free(instance.ptrDouble);
    }
    instance.ptrDouble = nullptr;
  }

  static free(Pointer<clib.CNativeType> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }

  static NativeType fromC(Pointer<clib.CNativeType> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new NativeType();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CNativeType> toCPtr() {
    var ptr = allocateZero<clib.CNativeType>();
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CNativeType> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }

  @override
  toCInstance(clib.CNativeType c) {
    if (c == null) {
      return;
    }
    c.ptrInt8.value = ptrInt8;
    c.ptrInt16.value = ptrInt16;
    c.ptrInt32.value = ptrInt32;
    c.ptrInt64.value = ptrInt64;
    c.ptrUInt8.value = ptrUInt8;
    c.ptrUInt16.value = ptrUInt16;
    c.ptrUInt32.value = ptrUInt32;
    c.ptrUInt64.value = ptrUInt64;
    c.ptrFloat.value = ptrFloat;
    c.ptrDouble.value = ptrDouble;
  }

  @override
  toDart(Pointer<clib.CNativeType> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CNativeType c) {
    if (c == null) {
      return;
    }
    ptrInt8 = c.ptrInt8.value;
    ptrInt16 = c.ptrInt16.value;
    ptrInt32 = c.ptrInt32.value;
    ptrInt64 = c.ptrInt64.value;
    ptrUInt8 = c.ptrUInt8.value;
    ptrUInt16 = c.ptrUInt16.value;
    ptrUInt32 = c.ptrUInt32.value;
    ptrUInt64 = c.ptrUInt64.value;
    ptrFloat = c.ptrFloat.value;
    ptrDouble = c.ptrDouble.value;
  }
}

class ArrayCChar extends DC<clib.CArrayCChar> {
  List<String> data;

  ArrayCChar() {
    data = <String>[];
  }

  static free(Pointer<clib.CArrayCChar> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }

  static freeInstance(clib.CArrayCChar instance) {
    if (instance == null) {
      return;
    }
    instance.ptr.free(instance.len);
    instance.ptr = nullptr;
  }

  static ArrayCChar fromC(Pointer<clib.CArrayCChar> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new ArrayCChar();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CArrayCChar> toCPtr() {
    var c = allocateZero<clib.CArrayCChar>();
    toC(c);
    return c;
  }

  @override
  toC(Pointer<clib.CArrayCChar> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }

  @override
  toCInstance(clib.CArrayCChar c) {
    if (c == null) {
      return;
    }
    if (c.ptr != nullptr && c.ptr != null) {
      c.ptr.free(c.len);
      c.ptr = nullptr;
    }
    c.ptr = allocateZero<Pointer<ffi.Utf8>>(count: data.length);
    c.len = data.length;
    c.cap = data.length;
    for (var i = 0; i < data.length; i++) {
      c.ptr.elementAt(i).value = data[i].toCPtr();
    }
  }

  @override
  toDart(Pointer<clib.CArrayCChar> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CArrayCChar c) {
    if (c == null) {
      return;
    }
    data = List.filled(c.len, null);
    for (var i = 0; i < data.length; i++) {
      data[i] = fromUtf8Null(c.ptr.elementAt(i).value);
    }
  }
}

class FieldCArrayCChar extends DC<clib.CFieldCArrayCChar> {
  ArrayCChar strs;

  FieldCArrayCChar() {
    strs = new ArrayCChar();
  }

  static freeInstance(clib.CFieldCArrayCChar instance) {
    if (instance == null) {
      return;
    }
    ArrayCChar.free(instance.strs);
    instance.strs = nullptr;
  }

  static free(Pointer<clib.CFieldCArrayCChar> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }

  static FieldCArrayCChar fromC(Pointer<clib.CFieldCArrayCChar> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new FieldCArrayCChar();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CFieldCArrayCChar> toCPtr() {
    var ptr = allocateZero<clib.CFieldCArrayCChar>();
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CFieldCArrayCChar> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }

  @override
  toCInstance(clib.CFieldCArrayCChar c) {
    if (c == null) {
      return;
    }
    if (c.strs == null || c.strs == nullptr) {
      c.strs = allocateZero<clib.CArrayCChar>();
    }
    strs.toC(c.strs);
  }

  @override
  toDart(Pointer<clib.CFieldCArrayCChar> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CFieldCArrayCChar c) {
    if (c == null) {
      return;
    }
    strs = new ArrayCChar();
    strs.toDart(c.strs);
  }
}
''';

String get _pkgName => 'pkg$_pkgCacheCount';
int _pkgCacheCount = 1;
const _testLibCode = r'''
library test_lib;
import 'dart:ffi';
import 'package:ffi/ffi.dart' as ffi;
part 'test_lib.foo.dart';
class CError extends Struct {
  @Uint64()
  int code;
  Pointer<ffi.Utf8> message;
  static Pointer<CError> allocate() {
    return ffi.allocate<CError>();
  }
  static CError from(int ptr) {
    return Pointer<CError>.fromAddress(ptr).ref;
  }
}
/// C struct `CAddress`.
class CAddress extends Struct {
  Pointer<ffi.Utf8> name;
  Pointer<CError> err;
  CError instance;
  CArrayCAddress arrayCAddress;
}
/// C Array.
class CArrayCAddress extends Struct {
  Pointer<CAddress> ptr;
  @Uint64()
  int len;
  @Uint64()
  int cap;
}
/// C Array.
class CArrayInt32 extends Struct {
  Pointer<Int32> ptr;
  @Uint64()
  int len;
  @Uint64()
  int cap;
}
/// native type.
class CNativeType extends Struct {
  Pointer<Int8> ptrInt8;
  Pointer<Int16> ptrInt16;
  Pointer<Int32> ptrInt32;
  Pointer<Int64> ptrInt64;
  Pointer<Uint8> ptrUInt8;
  Pointer<Uint16> ptrUInt16;
  Pointer<Uint32> ptrUInt32;
  Pointer<Uint64> ptrUInt64;
  Pointer<Float> ptrFloat;
  Pointer<Double> ptrDouble;
}
/// array string
class CArrayCChar extends Struct {
  Pointer<Pointer<ffi.Utf8>> ptr;
  @Uint64()
  int len;
  @Uint64()
  int cap;
}
//field array string
class CFieldCArrayCChar extends Struct {
  Pointer<CArrayCChar> strs;
}
''';

Future _generateTest(DCGenerator gen, String expectedContent) async {
  final srcs = {
    '$_pkgName|lib/test_lib.dart': _testLibCode,
  };
  final builder = LibraryBuilder(gen, generatedExtension: '.dc.dart');

  await testBuilder(
    builder,
    srcs,
    reader: await PackageAssetReader.currentIsolate(),
    generateFor: {'$_pkgName|lib/test_lib.dart'},
    outputs: {
      '$_pkgName|lib/test_lib.dc.dart': decodedMatches(expectedContent),
    },
    onLog: (log) {
      if (log.message.contains(
        'Your current `analyzer` version may not fully support your current '
        'SDK version.',
      )) {
        // This may happen with pre-release SDKs. Not an error.
        return;
      }
      // fail('Unexpected log message: ${log.message}');
    },
  );
}
