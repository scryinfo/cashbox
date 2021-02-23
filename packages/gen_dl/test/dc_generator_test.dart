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

  static free(Pointer<clib.CError> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    if (ptr.ref.message != null && ptr.ref.message != nullptr) {
      ffi.free(ptr.ref.message);
    }
    ptr.ref.message = nullptr;
    ffi.free(ptr);
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
    c.ref.code = code;
    if (c.ref.message != null && c.ref.message != nullptr) {
      ffi.free(c.ref.message);
    }
    c.ref.message = toUtf8Null(message);
  }

  @override
  toDart(Pointer<clib.CError> c) {
    if (c == null || c == nullptr) {
      return;
    }
    code = c.ref.code;
    message = fromUtf8Null(c.ref.message);
  }
}

class Address extends DC<clib.CAddress> {
  String name;
  Error err;

  Address() {
    err = new Error();
  }

  static free(Pointer<clib.CAddress> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    if (ptr.ref.name != null && ptr.ref.name != nullptr) {
      ffi.free(ptr.ref.name);
    }
    ptr.ref.name = nullptr;
    Error.free(ptr.ref.err);
    ptr.ref.err = nullptr;
    ffi.free(ptr);
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
    if (c.ref.name != null && c.ref.name != nullptr) {
      ffi.free(c.ref.name);
    }
    c.ref.name = toUtf8Null(name);
    if (c.ref.err == null || c.ref.err == nullptr) {
      c.ref.err = allocateZero<clib.CError>();
    }
    err.toC(c.ref.err);
  }

  @override
  toDart(Pointer<clib.CAddress> c) {
    if (c == null || c == nullptr) {
      return;
    }
    name = fromUtf8Null(c.ref.name);
    err = new Error();
    err.toDart(c.ref.err);
  }
}

class ArrayCAddress extends DC<clib.CArrayCAddress> {
  List<Address> data;

  ArrayCAddress() {
    data = new List<Address>();
  }

  static free(Pointer<clib.CArrayCAddress> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    Address.free(ptr.ref.ptr);
    ptr.ref.ptr = nullptr;
    ffi.free(ptr);
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
    if (c.ref.ptr != nullptr && c.ref.ptr != null) {
      Address.free(c.ref.ptr);
      c.ref.ptr = nullptr;
    }
    c.ref.ptr = allocateZero<clib.CAddress>(count: data.length);
    c.ref.len = data.length;
    c.ref.cap = data.length;
    for (var i = 0; i < data.length; i++) {
      data[i].toC(c.ref.ptr.elementAt(i));
    }
  }

  @override
  toDart(Pointer<clib.CArrayCAddress> c) {
    if (c == null || c == nullptr) {
      return;
    }
    data = new List<Address>(c.ref.len);
    for (var i = 0; i < data.length; i++) {
      data[i] = new Address();
      data[i].toDart(c.ref.ptr.elementAt(i));
    }
  }
}

class ArrayInt32 extends DC<clib.CArrayInt32> {
  List<int> data;

  ArrayInt32() {
    data = new List<int>();
  }

  static free(Pointer<clib.CArrayInt32> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    ptr.ref.ptr.free();
    ptr.ref.ptr = nullptr;
    ffi.free(ptr);
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
    if (c.ref.ptr != nullptr && c.ref.ptr != null) {
      c.ref.ptr.free();
      c.ref.ptr = nullptr;
    }
    c.ref.ptr = allocateZero<Int32>(count: data.length);
    c.ref.len = data.length;
    c.ref.cap = data.length;
    for (var i = 0; i < data.length; i++) {
      c.ref.ptr.elementAt(i).value = data[i];
    }
  }

  @override
  toDart(Pointer<clib.CArrayInt32> c) {
    if (c == null || c == nullptr) {
      return;
    }
    data = new List<int>(c.ref.len);
    for (var i = 0; i < data.length; i++) {
      data[i] = c.ref.ptr.elementAt(i).value;
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

  static free(Pointer<clib.CNativeType> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    if (ptr.ref.ptrInt8 != null && ptr.ref.ptrInt8 != nullptr) {
      ffi.free(ptr.ref.ptrInt8);
    }
    ptr.ref.ptrInt8 = nullptr;
    if (ptr.ref.ptrInt16 != null && ptr.ref.ptrInt16 != nullptr) {
      ffi.free(ptr.ref.ptrInt16);
    }
    ptr.ref.ptrInt16 = nullptr;
    if (ptr.ref.ptrInt32 != null && ptr.ref.ptrInt32 != nullptr) {
      ffi.free(ptr.ref.ptrInt32);
    }
    ptr.ref.ptrInt32 = nullptr;
    if (ptr.ref.ptrInt64 != null && ptr.ref.ptrInt64 != nullptr) {
      ffi.free(ptr.ref.ptrInt64);
    }
    ptr.ref.ptrInt64 = nullptr;
    if (ptr.ref.ptrUInt8 != null && ptr.ref.ptrUInt8 != nullptr) {
      ffi.free(ptr.ref.ptrUInt8);
    }
    ptr.ref.ptrUInt8 = nullptr;
    if (ptr.ref.ptrUInt16 != null && ptr.ref.ptrUInt16 != nullptr) {
      ffi.free(ptr.ref.ptrUInt16);
    }
    ptr.ref.ptrUInt16 = nullptr;
    if (ptr.ref.ptrUInt32 != null && ptr.ref.ptrUInt32 != nullptr) {
      ffi.free(ptr.ref.ptrUInt32);
    }
    ptr.ref.ptrUInt32 = nullptr;
    if (ptr.ref.ptrUInt64 != null && ptr.ref.ptrUInt64 != nullptr) {
      ffi.free(ptr.ref.ptrUInt64);
    }
    ptr.ref.ptrUInt64 = nullptr;
    if (ptr.ref.ptrFloat != null && ptr.ref.ptrFloat != nullptr) {
      ffi.free(ptr.ref.ptrFloat);
    }
    ptr.ref.ptrFloat = nullptr;
    if (ptr.ref.ptrDouble != null && ptr.ref.ptrDouble != nullptr) {
      ffi.free(ptr.ref.ptrDouble);
    }
    ptr.ref.ptrDouble = nullptr;
    ffi.free(ptr);
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
    c.ref.ptrInt8.value = ptrInt8;
    c.ref.ptrInt16.value = ptrInt16;
    c.ref.ptrInt32.value = ptrInt32;
    c.ref.ptrInt64.value = ptrInt64;
    c.ref.ptrUInt8.value = ptrUInt8;
    c.ref.ptrUInt16.value = ptrUInt16;
    c.ref.ptrUInt32.value = ptrUInt32;
    c.ref.ptrUInt64.value = ptrUInt64;
    c.ref.ptrFloat.value = ptrFloat;
    c.ref.ptrDouble.value = ptrDouble;
  }

  @override
  toDart(Pointer<clib.CNativeType> c) {
    if (c == null || c == nullptr) {
      return;
    }
    ptrInt8 = c.ref.ptrInt8.value;
    ptrInt16 = c.ref.ptrInt16.value;
    ptrInt32 = c.ref.ptrInt32.value;
    ptrInt64 = c.ref.ptrInt64.value;
    ptrUInt8 = c.ref.ptrUInt8.value;
    ptrUInt16 = c.ref.ptrUInt16.value;
    ptrUInt32 = c.ref.ptrUInt32.value;
    ptrUInt64 = c.ref.ptrUInt64.value;
    ptrFloat = c.ref.ptrFloat.value;
    ptrDouble = c.ref.ptrDouble.value;
  }
}

class ArrayCChar extends DC<clib.CArrayCChar> {
  List<String> data;

  ArrayCChar() {
    data = new List<String>();
  }

  static free(Pointer<clib.CArrayCChar> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    ptr.ref.ptr.free(ptr.ref.len);
    ptr.ref.ptr = nullptr;
    ffi.free(ptr);
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
    if (c.ref.ptr != nullptr && c.ref.ptr != null) {
      c.ref.ptr.free(c.ref.len);
      c.ref.ptr = nullptr;
    }
    c.ref.ptr = allocateZero<Pointer<ffi.Utf8>>(count: data.length);
    c.ref.len = data.length;
    c.ref.cap = data.length;
    for (var i = 0; i < data.length; i++) {
      c.ref.ptr.elementAt(i).value = data[i].toCPtr();
    }
  }

  @override
  toDart(Pointer<clib.CArrayCChar> c) {
    if (c == null || c == nullptr) {
      return;
    }
    data = new List<String>(c.ref.len);
    for (var i = 0; i < data.length; i++) {
      data[i] = fromUtf8Null(c.ref.ptr.elementAt(i).value);
    }
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
