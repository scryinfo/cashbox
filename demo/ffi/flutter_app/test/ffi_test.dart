import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../generate_ffi/cdl_c.dart' as lib;
import '../generate_ffi/int8_string.dart';
import '../generate_ffi/kits.dart';

lib.Cdl _cdc = new lib.Cdl(dlOpenPlatformSpecific("cdl"));

void main() async {
  test('test cdl', () {
    {
      //dart中字符串与指针转换
      String str = "string";
      Pointer<Int8> ptrStr = str.toPointerInt8();
      expect(str, ptrStr.toDartString());
      ptrStr.free();//不要忘记释放内存

      //动态库中，从参数返回值
      Pointer<Pointer<lib.CSample>> ptrPtr = _cdc.CSample_dAlloc();
      expect(nullptr, isNot(equals(ptrPtr)));
      _cdc.CSample_create(ptrPtr);
      if (ptrPtr.value != nullptr) {
        expect("sample name", ptrPtr.value.ref.name.toDartString());
        expect(2, ptrPtr.value.ref.list.len);
        expect("e1", ptrPtr.value.ref.list.ptr.elementAt(0).value.toDartString());
        expect(<String>["e1", "e2"], ptrPtr.value.ref.list.toList());
        _cdc.CSample_dFree(ptrPtr);//不要忘记释放内存
      }
      ptrPtr = nullptr;
    }
    expect(3, _cdc.add(1, 2));
    {
      //test addStr
      var pStr = "str".toPointerInt8();
      var rpStr = _cdc.addStr(pStr as Pointer<Char>);
      calloc.free(pStr);
      var news = rpStr.toDartString();
      expect("str 测试", news);
      _cdc.Str_free(rpStr); //rpStr alloc by addStr, so free memory
    }
    // test struct
    {
      var rpData = _cdc.Data_new();
      var sRef = rpData.ref;
      expect(10, sRef.intType);
      expect("test 测试", sRef.charType.toDartString());
      {
        var ints = sRef.arrayInt;
        expect(2, sRef.arrayIntLength);
        expect(1, ints[0]); // 以下，这三种方法来操作数组，都可以正常工作
        expect(2, ints.elementAt(1).value);
        // var dartArray = ints.asTypedList(sRef.arrayIntLength);
        // expect(1, dartArray[0]);
        // expect(2, dartArray.elementAt(1));
      }
      {
        var datas = sRef.arrayData;
        expect(2, sRef.arrayDataLength);
        expect(1, datas[0].intType);
        expect(2, datas[1].intType);
        expect(1, datas.elementAt(0).ref.intType);
        expect(2, datas.elementAt(1).ref.intType);
        //没有实现 asTypedList 方法，
      }
      {
        var data = sRef.pointData;
        expect(3, data.ref.intType);
      }
      //这个函数没有alloc新的内存，简单修改pointData.intType为1
      _cdc.Data_use(rpData);
      {
        var data = sRef.pointData;
        expect(1, data.ref.intType);
      }

      _cdc.Data_free(rpData); //释放内存

    }
    {
      //ffi 1.0.0
      var data = _cdc.Data_noPtr();
      expect(10, data.intType);
      expect("test 测试", data.charType.toDartString());
      {
        var ints = data.arrayInt;
        expect(2, data.arrayIntLength);
        expect(1, ints[0]); // 以下，这三种方法来操作数组，都可以正常工作
        expect(2, ints.elementAt(1).value);
        // var dartArray = ints.asTypedList(data.arrayIntLength);
        // expect(1, dartArray[0]);
        // expect(2, dartArray.elementAt(1));
      }
      {
        var arrayData = data.arrayData;
        expect(2, data.arrayDataLength);
        expect(1, arrayData[0].intType);
        expect(2, arrayData[1].intType);
        expect(1, arrayData.elementAt(0).ref.intType);
        expect(2, arrayData.elementAt(1).ref.intType);
        //没有实现 asTypedList 方法，
      }
      {
        expect(3, data.pointData.ref.intType);
      }
    }
  });
}
