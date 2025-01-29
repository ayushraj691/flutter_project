class ReqUpdateCustomer {
  late Info info;

  ReqUpdateCustomer({required this.info});

  ReqUpdateCustomer.fromJson(Map<String, dynamic> json) {
    info = (json['info'] != null ? new Info.fromJson(json['info']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.info != null) {
      data['info'] = this.info!.toJson();
    }
    return data;
  }
}

class Info {
  late String custName;
  late String description;
  late String mobile;
  late String email;

  Info(
      {required this.custName,
      required this.description,
      required this.mobile,
      required this.email});

  Info.fromJson(Map<String, dynamic> json) {
    custName = json['cust_name'] ?? "";
    description = json['description'] ?? "";
    mobile = json['mobile'] ?? "";
    email = json['email'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cust_name'] = this.custName;
    data['description'] = this.description;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    return data;
  }
}
