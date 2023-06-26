import 'dart:convert';

import 'package:flutter/services.dart';

class CashBoxConfig {
  String rateIp;
  String temp;

  CashBoxConfig({required this.rateIp, required this.temp});

  factory CashBoxConfig.fromJson(Map<String, dynamic> json) {
    return CashBoxConfig(
      rateIp: json['rateIp'],
      temp: json['temp'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    //todo
    return data;
  }
}

class Test {
  List expandStateList = [];

  void testUse() {
    rootBundle.loadString('assets/data/planTask.json').then((value) {
      List jsonList = json.decode(value);
      expandStateList
          .addAll(jsonList.map((m) => CashBoxConfig.fromJson(m)).toList());
    });
  }
}
