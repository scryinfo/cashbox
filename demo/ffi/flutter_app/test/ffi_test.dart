import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:flutter_test/flutter_test.dart';
import '../generate_ffi/wallets_c.dart' as lib;
import '../generate_ffi/kits.dart';
import '../generate_ffi/int8_string.dart';

void main() async {
  test('test cdl', () {
    expect(3, lib.add(1, 2));
    {
      //test addStr
      var pStr = "str".toNativeUtf8();
      var rpStr = lib.addStr(pStr);
      calloc.free(pStr);
      var news = rpStr.toDartString();
      expect("str 测试", news);
      lib.Str_free(rpStr); //rpStr alloc by addStr, so free memory
    }
    // test struct
    {
      var rpData = lib.Data_new();
      var sRef = rpData.ref;
      expect(10, sRef.intType);
      expect("test 测试", sRef.charType.toDartString());
      {
        var ints = sRef.arrayInt;
        expect(2, sRef.arrayIntLength);
        expect(1, ints[0]); // 以下，这三种方法来操作数组，都可以正常工作
        expect(2, ints.elementAt(1).value);
        var dartArray = ints.asTypedList(sRef.arrayIntLength);
        expect(1, dartArray[0]);
        expect(2, dartArray.elementAt(1));
        // var t = sRef.bBool;
        // var t3 = sRef.intType2;
        // if(sRef.pBool != null && sRef.pBool != nullptr){
        //   var t2 = sRef.pBool.value;
        // }
        // expect(0,sRef.bBool);
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
      lib.Data_use(rpData);
      {
        var data = sRef.pointData;
        expect(1, data.ref.intType);
        // var t = sRef.bBool;
        // var t2 = sRef.pBool.value;
        // var t3 = sRef.intType2;
        // expect(1,data.ref.bBool);
        // expect(1, data.ref.pBool.value);
      }

      lib.Data_free(rpData); //释放内存
    }
  });
}
