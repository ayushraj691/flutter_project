class ResAddCustomer {
  late int code;
  late String lastid;

  ResAddCustomer({required this.code, required this.lastid});

  ResAddCustomer.fromJson(Map<String, dynamic> json) {
    code = json['code'] ?? 0;
    lastid = json['lastid'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['lastid'] = this.lastid;
    return data;
  }
}
