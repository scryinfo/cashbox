import 'dart:ffi';

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:ffi/ffi.dart' as ffi;
import 'package:source_gen/source_gen.dart';

enum _FieldType {
  pointerStringUtf8,
  pointerStringInt8,
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
      if (typeStruct.isExactly(c.supertype!.element)) {
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
    var typeStringUtf8 = TypeChecker.fromRuntime(ffi.Utf8);
    var typeStringInt8 = TypeChecker.fromRuntime(Int8);
    var typeStruct = TypeChecker.fromRuntime(Struct);

    classCode
        .writeln('class ${toClassName(c.name)} extends DC<clib.${c.name}>{');

    List<_FieldMeta> fieldMetas = [];
    for (var f in c.fields) {
      if (typePointer.isExactly(f.type.element!)) {
        var parameterized = (f.type as ParameterizedType).typeArguments;
        if (parameterized != null && parameterized.isNotEmpty) {
          var first = parameterized.first;
          if (typeStringUtf8.isExactly(first.element!)) {
            fieldMetas.add(_FieldMeta(
                _FieldType.pointerStringUtf8, f.name, first.element!.name!));
          } else if (typeStringInt8.isExactly(first.element!)) {
            fieldMetas.add(_FieldMeta(
                _FieldType.pointerStringInt8, f.name, first.element!.name!));
          } else if (typeStruct
              .isExactly((first.element as ClassElement).supertype!.element)) {
            fieldMetas.add(_FieldMeta(
                _FieldType.pointerStruct, f.name, first.element!.name!));
          } else {
            fieldMetas.add(_FieldMeta(
                _FieldType.pointerNativeType, f.name, first.element!.name!));
          }
        } else {
          print("can not handle the type ${f.type} in class ${c.name}");
        }
      } else {
        var first = f.type;
        if (typeStruct
            .isExactly((first.element as ClassElement).supertype!.element)) {
          fieldMetas
              .add(_FieldMeta(_FieldType.struct, f.name, first.element!.name!));
        } else {
          fieldMetas.add(
              _FieldMeta(_FieldType.baseType, f.name, f.type.element!.name!));
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
            if (isString(f.typeName)) {
              classCode.writeln('${_blankOne}${f.typeName} ${f.name} = "";');
            } else {
              classCode.writeln('${_blankOne}${f.typeName} ${f.name} = 0;');
            }

            //base type do not free

            toC.writeln('${_blankTwo}c.${f.name} = ${f.name};');
            toDart.writeln('${_blankTwo}${f.name} = c.${f.name};');
          }
          break;
        case _FieldType.pointerStringUtf8:
          {
            classCode.writeln('${_blankOne}String ${f.name} = "";');

            free.writeln(
                '${_blankTwo}if (instance.${f.name} != nullptr) {ffi.calloc.free(instance.${f.name});}');
            free.writeln('${_blankTwo}instance.${f.name} = nullptr;');

            toC.writeln(
                '''${_blankTwo}if(c.${f.name} != nullptr) { ffi.calloc.free(c.${f.name});}''');
            toC.writeln('${_blankTwo}c.${f.name} = ${f.name}.toCPtrUtf8();');
            toDart
                .writeln('${_blankTwo}${f.name} = c.${f.name}.toDartString();');
          }
          break;
        case _FieldType.pointerStringInt8:
          {
            classCode.writeln('${_blankOne}String ${f.name} = "";');

            free.writeln(
                '${_blankTwo}if (instance.${f.name} != nullptr) {ffi.calloc.free(instance.${f.name});}');
            free.writeln('${_blankTwo}instance.${f.name} = nullptr;');

            toC.writeln(
                '''${_blankTwo}if(c.${f.name} != nullptr) { ffi.calloc.free(c.${f.name});}''');
            toC.writeln('${_blankTwo}c.${f.name} = ${f.name}.toCPtrInt8();');
            toDart
                .writeln('${_blankTwo}${f.name} = c.${f.name}.toDartString();');
          }
          break;
        case _FieldType.pointerStruct:
          {
            var className = toClassName(f.typeName);
            classCode.writeln(
                '${_blankOne}${className} ${f.name} = new ${className}();');

            free.writeln('${_blankTwo}${className}.free(instance.${f.name});');
            free.writeln('${_blankTwo}instance.${f.name} = nullptr;');

            toC.writeln(
                '${_blankTwo}if (c.${f.name} == nullptr) {c.${f.name} = allocateZero<clib.${f.typeName}>();}');
            toC.writeln('${_blankTwo}${f.name}.toC(c.${f.name});');
            toDart.writeln('${_blankTwo}${f.name} = new ${className}();');
            toDart.writeln('${_blankTwo}${f.name}.toDart(c.${f.name});');

            // subStruct.writeln('${_blankTwo}${f.name} = new ${className}();');
          }
          break;
        case _FieldType.pointerNativeType:
          {
            var className = mapNativeType(f.typeName);
            classCode.writeln('${_blankOne}${className} ${f.name} = 0;');

            free.writeln(
                '${_blankTwo}if (instance.${f.name} != nullptr) {ffi.calloc.free(instance.${f.name});}');
            free.writeln('${_blankTwo}instance.${f.name} = nullptr;');

            toC.writeln('${_blankTwo}c.${f.name}.value = ${f.name};');
            toDart.writeln('${_blankTwo}${f.name} = c.${f.name}.value;');

            // subStruct.writeln('${_blankTwo}${f.name} = new ${className}();');
          }
          break;
        case _FieldType.struct:
          var className = toClassName(f.typeName);
          classCode.writeln(
              '${_blankOne}${className} ${f.name} = new ${className}();');
          free.writeln(
              '${_blankTwo}${className}.freeInstance(instance.${f.name});');
          // free.writeln('${_blankTwo}instance.${f.name} = null;');

          toC.writeln('${_blankTwo}${f.name}.toCInstance(c.${f.name});');
          toDart.writeln('${_blankTwo}${f.name} = new ${className}();');
          toDart.writeln('${_blankTwo}${f.name}.toDartInstance(c.${f.name});');
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
${free.toString()}
  }
    
  static free(Pointer<clib.${c.name}> ptr) {
    if (ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }
''');

    //static fromC
    classCode.writeln('''

  static ${toClassName(c.name)} fromC(Pointer<clib.${c.name}> ptr) {
    var d = new ${toClassName(c.name)}();
    if (ptr == nullptr) {
      return d ;
    }
    d.toDart(ptr);
    return d;
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
    if (c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }
  
  @override
  toCInstance(clib.${c.name} c) {
${toC.toString()}
  }

  @override
  toDart(Pointer<clib.${c.name}> c) {
    if (c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.${c.name} c) {
${toDart.toString()}  }''');

    classCode.writeln('}');
    return classCode.toString();
  }

  String _classArray(ClassElement c) {
    StringBuffer classCode = new StringBuffer();

    ClassElement? el;
    bool nativeTypeArray = false;
    _FieldType elementType = _FieldType.baseType;
    StringBuffer free = new StringBuffer();
    StringBuffer toC = new StringBuffer();
    StringBuffer toDart = new StringBuffer();
    {
      var typePointer = TypeChecker.fromRuntime(Pointer);
      var typeStruct = TypeChecker.fromRuntime(Struct);
      var typeStringUtf8 = TypeChecker.fromRuntime(ffi.Utf8);
      var typeStringInt8 = TypeChecker.fromRuntime(Int8);
      for (var f in c.fields) {
        if (f.name == ArrayLen) {
          ;
        } else if (f.name == ArrayCap) {
          ;
        } else if (f.name == ArrayPtr) {
          if (typePointer.isExactly(f.type.element!)) {
            var parameterized = (f.type as ParameterizedType).typeArguments;
            var first = parameterized != null && parameterized.isNotEmpty
                ? parameterized.first
                : null;
            if (first != null) {
              parameterized = (first as ParameterizedType).typeArguments;
              var firstFirst = parameterized != null && parameterized.isNotEmpty
                  ? parameterized.first
                  : null;
              if (typeStruct.isExactly(
                  (first.element as ClassElement).supertype!.element)) {
                el = first.element as ClassElement;
                elementType = _FieldType.struct;
              } else if (typePointer.isExactly(first.element!) &&
                  typeStringUtf8.isExactly(firstFirst!.element!)) {
                el = first.element as ClassElement;
                elementType = _FieldType.pointerStringUtf8;
              } else if (typePointer.isExactly(first.element!) &&
                  typeStringInt8.isExactly(firstFirst!.element!)) {
                el = first.element as ClassElement;
                elementType = _FieldType.pointerStringInt8;
              } else {
                elementType = _FieldType.baseType;
                el = first.element as ClassElement;
              }
            } else {
              print("can not handle the type ${f.type} in class ${c.name}");
            }
          }
        } else {
          //todo not a array
          print("${c.toString()}: is not array");
        }
      }
    }

    if (el == null) {
      return "";
    }

    String elName = mapNativeType(el.name);
    String elNameAllocate = el.name;
    if (elementType == _FieldType.struct) {
      elName = toClassName(el.name);
      elNameAllocate = "clib." + el.name;
    } else if (elementType == _FieldType.pointerStringUtf8) {
      elName = "String";
      elNameAllocate = "Pointer<ffi.Utf8>";
    } else if (elementType == _FieldType.pointerStringInt8) {
      elName = "String";
      elNameAllocate = "Pointer<Int8>";
    } else {
      elName = mapNativeType(el.name);
      elNameAllocate = el.name;
    }
    var className = toClassName(c.name);
    classCode.writeln('''class ${className} extends DC<clib.${c.name}>{
  List<$elName> data = <$elName>[];
  
  static free(Pointer<clib.${c.name}> ptr) {
    if (ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }
  
  static freeInstance(clib.${c.name} instance) {
    ${elementType == _FieldType.baseType ? "instance.ptr.free()" : (elementType == _FieldType.pointerStringInt8 || elementType == _FieldType.pointerStringUtf8 ? "instance.ptr.free(instance.len)" : elName + ".free(instance.ptr)")};
    instance.ptr = nullptr;
  }
  
  static ${className} fromC(Pointer<clib.${c.name}> ptr) {
    var d = new ${className}();
    if (ptr == nullptr) {
      return d;
    }
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
    if (c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }
  
  @override
  toCInstance(clib.${c.name} c) {
    if (c.ptr != nullptr) {
      ${elementType == _FieldType.baseType ? "c.ptr.free()" : (elementType == _FieldType.pointerStringUtf8 || elementType == _FieldType.pointerStringInt8 ? "c.ptr.free(c.len)" : elName + ".free(c.ptr)")};
      c.ptr = nullptr;
    }
    c.ptr = allocateZero<${elNameAllocate}>(count : data.length);
    c.len = data.length;
    c.cap = data.length;
    for (var i = 0; i < data.length;i++) {
      ${elementType == _FieldType.baseType ? "c.ptr.elementAt(i).value = data[i]" : (elementType == _FieldType.pointerStringUtf8 ? "c.ptr.elementAt(i).value = data[i].toCPtr()" : (elementType == _FieldType.pointerStringInt8 ? "c.ptr.elementAt(i).value = data[i].toCPtrInt8()" : "data[i].toC(c.ptr.elementAt(i))"))};
    }
  }

  @override
  toDart(Pointer<clib.${c.name}> c) {
    if (c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }
  @override
  toDartInstance(clib.${c.name} c) {
    data =  <$elName>[];
    for (var i = 0; i < data.length;i++) {
      ${elementType == _FieldType.baseType ? "data.add(c.ptr.elementAt(i).value)" : (elementType == _FieldType.pointerStringUtf8 || elementType == _FieldType.pointerStringInt8 ? "data.add(c.ptr.elementAt(i).value.toDartString())" : "data.add(new $elName());      data[i].toDart(c.ptr.elementAt(i))")};
    }
  }
}
''');

    return classCode.toString();
  }

  String mapNativeType(String className) {
    String t = "";
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

  bool isString(String name) {
    return name == "String";
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
