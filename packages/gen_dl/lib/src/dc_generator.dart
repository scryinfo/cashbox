import 'dart:ffi';

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:ffi/ffi.dart' as ffi;
import 'package:source_gen/source_gen.dart';

enum _FieldType {
  pointerString,
  pointerStruct,
  baseType, // int double ...
  pointerNativeType, // Int32 UInt32 Float ...
  struct, // extend Struct, not pointer
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
        String classCode;
        if (isArray(c)) {
          classCode = _classArray(c);
        } else {
          classCode = _class(c);
        }
        code.add(classCode);
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
        var parameterized = (f.type as ParameterizedType)?.typeArguments;
        if (parameterized != null && parameterized.isNotEmpty) {
          var first = parameterized.first;
          if (typeUtf8.isExactly(first.element)) {
            fieldMetas.add(_FieldMeta(
                _FieldType.pointerString, f.name, first.element.name));
          } else if (typeStruct
              .isExactly((first.element as ClassElement).supertype.element)) {
            fieldMetas.add(_FieldMeta(
                _FieldType.pointerStruct, f.name, first.element.name));
          } else {
            fieldMetas.add(_FieldMeta(
                _FieldType.pointerNativeType, f.name, first.element.name));
          }
        } else {
          print("can not handle the type ${f.type} in class ${c.name}");
        }
      } else {
        var first = f.type;
        if (typeStruct
            .isExactly((first.element as ClassElement).supertype.element)) {
          fieldMetas
              .add(_FieldMeta(_FieldType.struct, f.name, first.element.name));
        } else {
          fieldMetas.add(
              _FieldMeta(_FieldType.baseType, f.name, f.type.element.name));
        }
      }
    }

    StringBuffer free = new StringBuffer();
    StringBuffer toC = new StringBuffer();
    StringBuffer toDart = new StringBuffer();
    StringBuffer subStruct = new StringBuffer();
    for (var f in fieldMetas) {
      switch (f.fieldType) {
        case _FieldType.baseType:
          {
            classCode.writeln('${_blankOne}${f.typeName} ${f.name};');

            //base type do not free

            toC.writeln('${_blankTwo}c.${f.name} = ${f.name}??0;');
            toDart.writeln('${_blankTwo}${f.name} = c.${f.name};');
          }
          break;
        case _FieldType.pointerString:
          {
            classCode.writeln('${_blankOne}String ${f.name};');

            free.writeln(
                '${_blankTwo}if (instance.${f.name} != null && instance.${f.name} != nullptr) {ffi.calloc.free(instance.${f.name});}');
            free.writeln('${_blankTwo}instance.${f.name} = nullptr;');

            toC.writeln(
                '''${_blankTwo}if(c.${f.name} != null && c.${f.name} != nullptr) { ffi.calloc.free(c.${f.name});}''');
            toC.writeln('${_blankTwo}c.${f.name} = toUtf8Null(${f.name});');
            toDart
                .writeln('${_blankTwo}${f.name} = fromUtf8Null(c.${f.name});');
          }
          break;
        case _FieldType.pointerStruct:
          {
            var className = toClassName(f.typeName);
            classCode.writeln('${_blankOne}${className} ${f.name};');

            free.writeln('${_blankTwo}${className}.free(instance.${f.name});');
            free.writeln('${_blankTwo}instance.${f.name} = nullptr;');

            toC.writeln(
                '${_blankTwo}if (c.${f.name} == null || c.${f.name} == nullptr) {c.${f.name} = allocateZero<clib.${f.typeName}>();}');
            toC.writeln('${_blankTwo}${f.name}.toC(c.${f.name});');
            toDart.writeln('${_blankTwo}${f.name} = new ${className}();');
            toDart.writeln('${_blankTwo}${f.name}.toDart(c.${f.name});');

            subStruct.writeln('${_blankTwo}${f.name} = new ${className}();');
          }
          break;
        case _FieldType.pointerNativeType:
          {
            var className = mapNativeType(f.typeName);
            classCode.writeln('${_blankOne}${className} ${f.name};');

            free.writeln(
                '${_blankTwo}if (instance.${f.name} != null && instance.${f.name} != nullptr) {ffi.calloc.free(instance.${f.name});}');
            free.writeln('${_blankTwo}instance.${f.name} = nullptr;');

            toC.writeln('${_blankTwo}c.${f.name}.value = ${f.name};');
            toDart.writeln('${_blankTwo}${f.name} = c.${f.name}.value;');

            // subStruct.writeln('${_blankTwo}${f.name} = new ${className}();');
          }
          break;
        case _FieldType.struct:
          var className = toClassName(f.typeName);
          classCode.writeln('${_blankOne}${className} ${f.name};');
          free.writeln(
              '${_blankTwo}if (instance.${f.name} != null ) {${className}.freeInstance(instance.${f.name});}');
          // free.writeln('${_blankTwo}instance.${f.name} = null;');

          toC.writeln('${_blankTwo}${f.name}.toCInstance(c.${f.name});');
          toDart.writeln('${_blankTwo}${f.name} = new ${className}();');
          toDart.writeln('${_blankTwo}${f.name}.toDartInstance(c.${f.name});');

          subStruct.writeln('${_blankTwo}${f.name} = new ${className}();');
          break;
      }
    }
    //new
    if (subStruct.isNotEmpty) {
      classCode.writeln('''

  ${toClassName(c.name)}() {
${subStruct.toString()}$_blankOne}
''');
    }
    //free
    classCode.writeln('''

  static freeInstance(clib.${c.name} instance) {
    if (instance == null) {
      return;
    }
${free.toString()}
  }
    
  static free(Pointer<clib.${c.name}> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }
''');

    //static fromC
    classCode.writeln('''

  static ${toClassName(c.name)} fromC(Pointer<clib.${c.name}> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
${_blankTwo}var d = new ${toClassName(c.name)}();
${_blankTwo}d.toDart(ptr);
${_blankTwo}return d;
  }
''');

    //impl DC
    classCode.writeln('''
  @override
  Pointer<clib.${c.name}> toCPtr() {
${_blankTwo}var ptr = allocateZero<clib.${c.name}>();
${_blankTwo}toC(ptr);
${_blankTwo}return ptr;
  }

  @override
  toC(Pointer<clib.${c.name}> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }
  
  @override
  toCInstance(clib.${c.name} c) {
    if (c == null) {
      return;
    }
${toC.toString()}
  }

  @override
  toDart(Pointer<clib.${c.name}> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.${c.name} c) {
    if (c == null) {
      return;
    }
${toDart.toString()}  }''');

    classCode.writeln('}');
    return classCode.toString();
  }

  String _classArray(ClassElement c) {
    StringBuffer classCode = new StringBuffer();

    ClassElement el;
    bool nativeType = false;
    bool nativeTypeArray = false;
    StringBuffer free = new StringBuffer();
    StringBuffer toC = new StringBuffer();
    StringBuffer toDart = new StringBuffer();
    {
      var typePointer = TypeChecker.fromRuntime(Pointer);
      var typeStruct = TypeChecker.fromRuntime(Struct);
      var typeUtf8 = TypeChecker.fromRuntime(ffi.Utf8);
      for (var f in c.fields) {
        if (f.name == ArrayLen) {
          ;
        } else if (f.name == ArrayCap) {
          ;
        } else if (f.name == ArrayPtr) {
          if (typePointer.isExactly(f.type.element)) {
            var parameterized = (f.type as ParameterizedType)?.typeArguments;
            var first = parameterized != null && parameterized.isNotEmpty
                ? parameterized.first
                : null;
            if (first != null) {
              parameterized = (first as ParameterizedType)?.typeArguments;
              var firstFirst = parameterized != null && parameterized.isNotEmpty
                  ? parameterized.first
                  : null;
              if (typeStruct.isExactly(
                  (first.element as ClassElement).supertype.element)) {
                el = first.element as ClassElement;
              } else if (typePointer.isExactly(first.element) &&
                  typeUtf8.isExactly(firstFirst?.element)) {
                el = first.element as ClassElement;
                nativeTypeArray = true;
              } else {
                nativeType = true;
                el = first.element as ClassElement;
              }
            } else {
              print("can not handle the type ${f.type} in class ${c.name}");
            }
          }
        } else {
          //todo not a array
        }
      }
    }

    var elName = !nativeType ? toClassName(el.name) : mapNativeType(el.name);
    var elNameAllocate = el.name;
    if (nativeTypeArray) {
      elName = "String";
      elNameAllocate = "Pointer<ffi.Utf8>";
    } else if (!nativeType) {
      elNameAllocate = "clib." + elNameAllocate;
    }
    var className = toClassName(c.name);
    classCode.writeln('''class ${className} extends DC<clib.${c.name}>{
  List<$elName> data;
  
  ${className}() {
    data = <$elName>[];
  }
  
  static free(Pointer<clib.${c.name}> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }
  
  static freeInstance(clib.${c.name} instance) {
    if (instance == null) {
      return;
    }
    ${nativeType ? "instance.ptr.free()" : (nativeTypeArray ? "instance.ptr.free(instance.len)" : elName + ".free(instance.ptr)")};
    instance.ptr = nullptr;
  }
  
  static ${className} fromC(Pointer<clib.${c.name}> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new ${className}();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.${c.name}> toCPtr() {
    var c = allocateZero<clib.${c.name}>();
    toC(c);
    return c;
  }
  
  @override
  toC(Pointer<clib.${c.name}> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }
  
  @override
  toCInstance(clib.${c.name} c) {
    if (c == null) {
      return;
    }
    if (c.ptr != nullptr && c.ptr != null) {
      ${nativeType ? "c.ptr.free()" : (nativeTypeArray ? "c.ptr.free(c.len)" : elName + ".free(c.ptr)")};
      c.ptr = nullptr;
    }
    c.ptr = allocateZero<${elNameAllocate}>(count : data.length);
    c.len = data.length;
    c.cap = data.length;
    for (var i = 0; i < data.length;i++) {
      ${nativeType ? "c.ptr.elementAt(i).value = data[i]" : (nativeTypeArray ? "c.ptr.elementAt(i).value = data[i].toCPtr()" : "data[i].toC(c.ptr.elementAt(i))")};
    }
  }

  @override
  toDart(Pointer<clib.${c.name}> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }
  @override
  toDartInstance(clib.${c.name} c) {
    if (c == null) {
      return;
    }
    data = List.filled(c.len, null);
    for (var i = 0; i < data.length;i++) {
      ${!nativeType && !nativeTypeArray ? "data[i] = new $elName();" : ""}
      ${nativeType ? "data[i] = c.ptr.elementAt(i).value" : (nativeTypeArray ? "data[i] = fromUtf8Null(c.ptr.elementAt(i).value)" : "data[i].toDart(c.ptr.elementAt(i))")};
    }
  }
}
''');

    return classCode.toString();
  }

  String mapNativeType(String className) {
    String t;
    switch (className) {
      case "Int8":
        t = "int";
        break;
      case "Int16":
        t = "int";
        break;
      case "Int32":
        t = "int";
        break;
      case "Int64":
        t = "int";
        break;
      case "Uint8":
        t = "int";
        break;
      case "Uint16":
        t = "int";
        break;
      case "Uint32":
        t = "int";
        break;
      case "Uint64":
        t = "int";
        break;
      case "Float":
        t = "double";
        break;
      case "Double":
        t = "double";
        break;
    }
    return t;
  }

  bool isArray(ClassElement c) {
    if (c.fields.length == 3) {
      for (var f in c.fields) {
        if (f.name != ArrayLen && f.name != ArrayCap && f.name != ArrayPtr) {
          return false;
        }
      }
      return true;
    }
    return false;
  }

  String toClassName(String cName) {
    String name = cName;
    if (name[0] == 'C') {
      name = name.substring(1);
    }
    return name;
  }
}

const ArrayLen = "len";
const ArrayCap = "cap";
const ArrayPtr = "ptr";
