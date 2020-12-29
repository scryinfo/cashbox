import 'dart:convert';
import 'dart:math';
import 'dart:mirrors';

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'dart:ffi';
import 'package:ffi/ffi.dart' as ffi;

enum _FieldType {
  string,
  struct,
  baseType,
}

class _FieldMeta {
  _FieldType fieldType;
  String name;
  String typeName;

  _FieldMeta(this.fieldType, this.name, this.typeName);
}

const _newLine = "\n";
const _blankOne = "  ";
const _blankTwo = "    ";

class DCGenerator extends Generator {
  const DCGenerator();

  @override
  String generate(LibraryReader library, BuildStep buildStep) {
    List<String> code = [];
    {
      //import
      code.add('''
import 'dart:ffi';
import 'package:ffi/ffi.dart' as ffi;

import 'wallets_c.dart' as clib;
import 'kits.dart';
''');
    }
    var typeStruct = TypeChecker.fromRuntime(Struct);
    for (var c in library.classes) {
      if (typeStruct.isExactly(c.supertype.element)) {
        code.add(_class(c));
      }
    }
    return code.join(_newLine);
  }

  String _class(ClassElement c) {
    StringBuffer classCode = new StringBuffer();
    var typePointer = TypeChecker.fromRuntime(Pointer);
    var typeUtf8 = TypeChecker.fromRuntime(ffi.Utf8);
    var typeStruct = TypeChecker.fromRuntime(Struct);

    classCode
        .writeln('class ${toClassName(c.name)} extends DC<clib.${c.name}>{');

    List<_FieldMeta> fieldMetas = [];
    for (var f in c.fields) {
      if (typePointer.isExactly(f.type.element)) {
        var parameterized = f.type as ParameterizedType;
        if (parameterized != null &&
            parameterized.typeArguments != null &&
            parameterized.typeArguments.isNotEmpty) {
          var first = parameterized.typeArguments.first;
          if (typeUtf8.isExactly(first.element)) {
            fieldMetas
                .add(_FieldMeta(_FieldType.string, f.name, first.element.name));
          } else if (typeStruct
              .isExactly((first.element as ClassElement).supertype.element)) {
            fieldMetas
                .add(_FieldMeta(_FieldType.struct, f.name, first.element.name));
          } else {
            print("can not handle the type ${f.type} in class ${c.name}");
          }
        } else {
          print("can not handle the type ${f.type} in class ${c.name}");
        }
      } else {
        var fm = _FieldMeta(_FieldType.baseType, f.name, f.type.element.name);
        fieldMetas.add(fm);
      }
    }

    StringBuffer free = new StringBuffer();
    StringBuffer toC = new StringBuffer();
    StringBuffer toDart = new StringBuffer();
    for (var f in fieldMetas) {
      switch (f.fieldType) {
        case _FieldType.baseType:
          {
            classCode.writeln('${_blankOne}${f.typeName} ${f.name};');

            //base type do not free

            toC.writeln('${_blankTwo}c.ref.${f.name} = ${f.name};');
            toDart.writeln('${_blankTwo}${f.name} = c.ref.${f.name};');
          }
          break;
        case _FieldType.string:
          {
            classCode.writeln('${_blankOne}String ${f.name};');

            free.writeln('${_blankTwo}ffi.free(ptr.ref.${f.name});');

            toC.writeln(
                '${_blankTwo}c.ref.${f.name} = ffi.Utf8.toUtf8(${f.name});');
            toDart.writeln(
                '${_blankTwo}${f.name} = ffi.Utf8.fromUtf8(c.ref.${f.name});');
          }
          break;
        case _FieldType.struct:
          {
            var className = toClassName(f.typeName);
            classCode.writeln('${_blankOne}${className} ${f.name};');

            free.writeln('${_blankTwo}${className}.free(ptr.ref.${f.name});');

            toC.writeln('${_blankTwo}c.ref.${f.name} = ${f.name}.toC();');
            toDart.writeln('${_blankTwo}${f.name} = new ${className}();');
            toDart.writeln('${_blankTwo}${f.name}.toDart(c.ref.${f.name});');
          }
      }
    }
    //free
    classCode.writeln('''

  static free(Pointer<clib.${c.name}> ptr) {
${free.toString()}${_blankTwo}ffi.free(ptr);
  }
''');

    //static fromC
    classCode.writeln('''

  static ${toClassName(c.name)} fromC(Pointer<clib.${c.name}> ptr) {
${_blankTwo}var d = new ${toClassName(c.name)}();
${_blankTwo}d.toDart(ptr);
${_blankTwo}return d;
  }
''');

    //impl DC
    classCode.writeln('''
  @override
  Pointer<clib.${c.name}> toC() {
${_blankTwo}var c = clib.${c.name}.allocate();
${toC.toString()}${_blankTwo}return c;
  }

  @override
  toDart(Pointer<clib.${c.name}> c) {
${toDart.toString()}  }''');

    classCode.writeln('}');
    return classCode.toString();
  }

  String toClassName(String cName) {
    String name = cName;
    if (name[0] == 'C') {
      name = name.substring(1);
    }
    return name;
  }
}
