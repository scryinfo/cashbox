@TestOn('vm')
import 'dart:convert';

import 'package:build_test/build_test.dart';
import 'package:gen_dl/src/dc_generator.dart';
import 'package:source_gen/source_gen.dart';
import 'package:test/test.dart';

void main() {
  tearDown(() {
    // Increment this after each test so the next test has it's own package
    _pkgCacheCount++;
  });
  test('Simple Generator test', () async {
    await _generateTest(const DCGenerator(), _testGenPartContent);
  });
}

const _testGenPartContent = r'''// GENERATED CODE - DO NOT MODIFY BY HAND

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

  @override
  Pointer<clib.CError> toC() {
    var c = clib.CError.allocate();
    c.ref.code = code;
    c.ref.message = ffi.Utf8.toUtf8(message);
    return c;
  }

  @override
  toDart(Pointer<clib.CError> c) {
    code = c.ref.code;
    message = ffi.Utf8.fromUtf8(c.ref.message);
  }
}

class Address extends DC<clib.CAddress> {
  String name;
  Error err;

  static free(Pointer<clib.CAddress> ptr) {
    ffi.free(ptr.ref.name);
    Error.free(ptr.ref.err);
    ffi.free(ptr);
  }

  @override
  Pointer<clib.CAddress> toC() {
    var c = clib.CAddress.allocate();
    c.ref.name = ffi.Utf8.toUtf8(name);
    c.ref.err = err.toC();
    return c;
  }

  @override
  toDart(Pointer<clib.CAddress> c) {
    name = ffi.Utf8.fromUtf8(c.ref.name);
    err = new Error();
    err.toDart(c.ref.err);
  }
}
''';

String get _pkgName => 'pkg$_pkgCacheCount';
int _pkgCacheCount = 1;
const _testLibContent = r'''
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
''';

Future _generateTest(DCGenerator gen, String expectedContent) async {
  final srcs = _createPackageStub();
  final builder = LibraryBuilder(gen, generatedExtension: '.foo.dart');

  await testBuilder(
    builder,
    srcs,
    reader: await PackageAssetReader.currentIsolate(),
    generateFor: {'$_pkgName|lib/test_lib.dart'},
    outputs: {
      '$_pkgName|lib/test_lib.foo.dart': decodedMatches(expectedContent),
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

Map<String, String> _createPackageStub(
        {String testLibContent, String testLibPartContent}) =>
    {
      '$_pkgName|lib/test_lib.dart': testLibContent ?? _testLibContent,
    };
