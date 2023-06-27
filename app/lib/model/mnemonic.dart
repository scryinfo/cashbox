import 'dart:typed_data';

class Mnemonic {
  Uint8List mn = Uint8List.fromList([]);
  String mnId = "";
  int status = 0;

  Mnemonic({required this.mn, required this.mnId, required this.status});

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
