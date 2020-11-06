import 'dart:ffi';
import 'package:flutter_test/flutter_test.dart';
import '../generate_ffi/wallets_c.dart';
import '../generate_ffi/kits.dart';
import '../generate_ffi/int8_string.dart';

void main() async {
  test('test cdl', () {
    var lib = new NativeLibrary(dlOpenPlatformSpecific("cdl"));
    expect(3, lib.add(1, 2));
    {
      //test addStr
      var s = Int8String.allocInt8("str");
      var rs = lib.addStr(s);
      Int8String.freeInt8(s); // s alloc by allocInt8, so free freeInt8
      var news = Int8String.int8toString(rs);
      expect("str 测试", news);
      lib.Str_free(rs); //rs alloc by addStr, so free memory
    }
    // test struct
    {
      var s = lib.Data_new();
      var sRef = s.ref;
      expect(10, sRef.intType);
      expect("test 测试", Int8String.int8toString(sRef.charType));
      {
        var ints = sRef.arrayInt;
        expect(2, sRef.arrayIntLength);
        expect(1, ints[0]); // 以下，这三种方法来操作数组，都可以正常工作
        expect(2, ints.elementAt(1).value);
        var dartArray = ints.asTypedList(sRef.arrayIntLength);
        expect(1, dartArray[0]);
        expect(2, dartArray.elementAt(1));
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
      lib.Data_use(s);
      {
        var data = sRef.pointData;
        expect(1, data.ref.intType);
      }

      lib.Data_free(s); //释放内存
    }
  });
}
