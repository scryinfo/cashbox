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
    final productNames = library.classes;

    final s = Struct;
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
    List<String> classBody = [];
    var typePointer = TypeChecker.fromRuntime(Pointer);
    var typeUtf8 = TypeChecker.fromRuntime(ffi.Utf8);
    var typeStruct = TypeChecker.fromRuntime(Struct);
    List<_FieldMeta> fieldMeta = [];

    for (var f in c.fields) {
      if (typePointer.isExactly(f.type.element)) {
        {
          var element = f.type as ParameterizedType;
          if (element != null &&
              element.typeArguments != null &&
              element.typeArguments.isNotEmpty) {
            var one = element.typeArguments.first;
            if (typeUtf8.isExactly(one.element)) {
              fieldMeta
                  .add(_FieldMeta(_FieldType.string, f.name, one.element.name));
            } else if (typeStruct
                .isExactly((one.element as ClassElement).supertype.element)) {
              fieldMeta
                  .add(_FieldMeta(_FieldType.struct, f.name, one.element.name));
            } else {
              print("can not handle the type ${f.type} in class ${c.name}");
            }
          } else {
            print("can not handle the type ${f.type} in class ${c.name}");
          }
        }
      } else {
        fieldMeta
            .add(_FieldMeta(_FieldType.baseType, f.name, f.type.element.name));
      }
    }

    for (var f in fieldMeta) {
      switch (f.fieldType) {
        case _FieldType.baseType:
          {
            classBody.add('${_blankOne}${f.typeName} ${f.name};');
          }
          break;
        case _FieldType.string:
          {
            classBody.add('${_blankOne}String ${f.name};');
          }
          break;
        case _FieldType.struct:
          {
            classBody.add('${_blankOne}${toClassName(f.typeName)} ${f.name};');
          }
      }
    }
    {
      //free
      List<String> free = [];
      for (var f in fieldMeta) {
        if (f.fieldType == _FieldType.struct) {
          free.add(
              '${_blankTwo}${toClassName(f.typeName)}.free(ptr.ref.${f.name});');
        } else if (f.fieldType == _FieldType.string) {
          free.add('${_blankTwo}ffi.free(ptr.ref.${f.name});');
        }
      }
      classBody.add('''

  static free(Pointer<clib.${c.name}> ptr) {
${free.join(_newLine)}
${_blankTwo}ffi.free(ptr);
  }
''');
    }

    {
      classBody.add('''

  static ${toClassName(c.name)} fromC(Pointer<clib.${c.name}> ptr) {
${_blankTwo}var d = new ${toClassName(c.name)}();
${_blankTwo}d.toDart(ptr);
${_blankTwo}return d;
  }
''');
    }

    {
      //impl DC
      List<String> toC = [];
      List<String> toDart = [];
      for (var f in fieldMeta) {
        switch (f.fieldType) {
          case _FieldType.struct:
            {
              toC.add('${_blankTwo}c.ref.${f.name} = ${f.name}.toC();');
              toDart.add(
                  '${_blankTwo}${f.name} = new ${toClassName(f.typeName)}();');
              toDart.add('${_blankTwo}${f.name}.toDart(c.ref.${f.name});');
            }
            break;
          case _FieldType.string:
            {
              toC.add(
                  '${_blankTwo}c.ref.${f.name} = ffi.Utf8.toUtf8(${f.name});');
              toDart.add(
                  '${_blankTwo}${f.name} = ffi.Utf8.fromUtf8(c.ref.${f.name});');
            }
            break;
          case _FieldType.baseType:
            {
              toC.add('${_blankTwo}c.ref.${f.name} = ${f.name};');
              toDart.add('${_blankTwo}${f.name} = c.ref.${f.name};');
            }
            break;
        }
      }
      classBody.add('''
  @override
  Pointer<clib.${c.name}> toC() {
${_blankTwo}var c = clib.${c.name}.allocate();
${toC.join(_newLine)}
${_blankTwo}return c;
  }

  @override
  toDart(Pointer<clib.${c.name}> c) {
${toDart.join(_newLine)}
  }''');
    }

    //LineSplitter().toString()
    String classStr = '''
class ${toClassName(c.name)} extends DC<clib.${c.name}>{
${classBody.join(_newLine)}
}
''';
    return classStr;
  }

  String toClassName(String cName) {
    String name = cName;
    if (name[0] == 'C') {
      name = name.substring(1);
    }
    return name;
  }
}
