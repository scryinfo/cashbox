import 'dart:typed_data';

class Mnemonic {
  Uint8List mn;
  String mnId;
  int status;

  Mnemonic({this.mn, this.mnId, this.status});

  Mnemonic.fromJson(Map<String, dynamic> json) {
    mn = json['mn'];
    mnId = json['mnId'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mn'] = this.mn;
    data['mnId'] = this.mnId;
    data['status'] = this.status;
    return data;
  }
}
