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
    ffi.free(ptr.ref.message);
    ffi.free(ptr);
  }

  static Error fromC(Pointer<clib.CError> ptr) {
    var d = new Error();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CError> toCPtr() {
    var ptr = clib.CError.allocate();
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CError> c) {
    c.ref.code = code;
    c.ref.message = toUtf8Null(message);
  }

  @override
  toDart(Pointer<clib.CError> c) {
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
    ffi.free(ptr.ref.name);
    Error.free(ptr.ref.err);
    ffi.free(ptr);
  }

  static Address fromC(Pointer<clib.CAddress> ptr) {
    var d = new Address();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CAddress> toCPtr() {
    var ptr = clib.CAddress.allocate();
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CAddress> c) {
    c.ref.name = toUtf8Null(name);
    err.toC(c.ref.err);
  }

  @override
  toDart(Pointer<clib.CAddress> c) {
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
    Address.free(ptr.ref.ptr);
    ffi.free(ptr);
  }

  static ArrayCAddress fromC(Pointer<clib.CArrayCAddress> ptr) {
    var d = new ArrayCAddress();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CArrayCAddress> toCPtr() {
    var c = clib.CArrayCAddress.allocate();
    toC(c);
    return c;
  }

  @override
  toC(Pointer<clib.CArrayCAddress> c) {
    if (c.ref.ptr != nullptr && c.ref.ptr != null) {
      Address.free(c.ref.ptr);
    }
    c.ref.ptr = ffi.allocate<clib.CAddress>(count: data.length);
    c.ref.len = data.length;
    c.ref.cap = data.length;
    for (var i = 0; i < data.length; i++) {
      data[i].toC(c.ref.ptr.elementAt(i));
    }
  }

  @override
  toDart(Pointer<clib.CArrayCAddress> c) {
    data = new List<Address>(c.ref.len);
    for (var i = 0; i < data.length; i++) {
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
    ffi.free(ptr.ref.ptr);
    ffi.free(ptr);
  }

  static ArrayInt32 fromC(Pointer<clib.CArrayInt32> ptr) {
    var d = new ArrayInt32();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CArrayInt32> toCPtr() {
    var c = clib.CArrayInt32.allocate();
    toC(c);
    return c;
  }

  @override
  toC(Pointer<clib.CArrayInt32> c) {
    if (c.ref.ptr != nullptr && c.ref.ptr != null) {
      ffi.free(c.ref.ptr);
    }
    c.ref.ptr = ffi.allocate<Int32>(count: data.length);
    c.ref.len = data.length;
    c.ref.cap = data.length;
    for (var i = 0; i < data.length; i++) {
      c.ref.ptr.elementAt(i).value = data[i];
    }
  }

  @override
  toDart(Pointer<clib.CArrayInt32> c) {
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
    ffi.free(ptr.ref.ptrInt8);
    ffi.free(ptr.ref.ptrInt16);
    ffi.free(ptr.ref.ptrInt32);
    ffi.free(ptr.ref.ptrInt64);
    ffi.free(ptr.ref.ptrUInt8);
    ffi.free(ptr.ref.ptrUInt16);
    ffi.free(ptr.ref.ptrUInt32);
    ffi.free(ptr.ref.ptrUInt64);
    ffi.free(ptr.ref.ptrFloat);
    ffi.free(ptr.ref.ptrDouble);
    ffi.free(ptr);
  }

  static NativeType fromC(Pointer<clib.CNativeType> ptr) {
    var d = new NativeType();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CNativeType> toCPtr() {
    var ptr = clib.CNativeType.allocate();
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CNativeType> c) {
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
      fail('Unexpected log message: ${log.message}');
    },
  );
}
