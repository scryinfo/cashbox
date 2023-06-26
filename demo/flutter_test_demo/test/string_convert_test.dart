import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';

void main() {
  String uint8ListToHex(Uint8List bArr) {
    int length;
    if (bArr == null || (length = bArr.length) <= 0) {
      return "";
    }
    Uint8List cArr = new Uint8List(length << 1);
    int i = 0;
    for (int i2 = 0; i2 < length; i2++) {
      int i3 = i + 1;
      var cArr2 = [
        '0',
        '1',
        '2',
        '3',
        '4',
        '5',
        '6',
        '7',
        '8',
        '9',
        'A',
        'B',
        'C',
        'D',
        'E',
        'F'
      ];
      var index = (bArr[i2] >> 4) & 15;
      cArr[i] = cArr2[index].codeUnitAt(0);
      i = i3 + 1;
      cArr[i3] = cArr2[bArr[i2] & 15].codeUnitAt(0);
    }
    return new String.fromCharCodes(cArr);
  }

  hex(int c) {
    if (c >= '0'.codeUnitAt(0) && c <= '9'.codeUnitAt(0)) {
      return c - '0'.codeUnitAt(0);
    }
    if (c >= 'A'.codeUnitAt(0) && c <= 'F'.codeUnitAt(0)) {
      return (c - 'A'.codeUnitAt(0)) + 10;
    }
  }

  hexStrToUnitList(String originHexString) {
    var str = originHexString;
    if (originHexString.toLowerCase().startsWith("0x")) {
      str = originHexString.substring(2);
    }
    int length = str.length;
    if (length % 2 != 0) {
      str = "0" + str;
      length++;
    }
    List<int> s = str.toUpperCase().codeUnits;
    Uint8List bArr = Uint8List(length >> 1);
    for (int i = 0; i < length; i += 2) {
      bArr[i >> 1] = ((hex(s[i]) << 4) | hex(s[i + 1]));
    }
    return bArr;
  }

  test('string to hex ', () async {
    var backUpInfo = "0x33363938326d6e62115340924d8409a109";
    var convertInfo = hexStrToUnitList(backUpInfo);
    print("convertInfo is --->" + convertInfo.toString());
    print("convertInfo is --->" + String.fromCharCodes(convertInfo));
    var convertStr = Utf8Decoder().convert(convertInfo);
    print("convertStr is --->" + convertStr.toString());
  });
  test('string to hex test', () async {
    Utf8Codec utf = new Utf8Codec();
    // 将字符串编码为Uint8List
    Uint8List list = utf.encode("1111鹅鹅鹅");
    print(list);
    String hexStr = uint8ListToHex(list);
    print(hexStr);
    var convertInfo = hexStrToUnitList(hexStr);
    var convertStr = Utf8Decoder().convert(convertInfo);
    print("convertStr is --->" + convertStr.toString());
  });
}
