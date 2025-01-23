class ReqChangePassword {
  late String password;

  ReqChangePassword({required this.password});

  ReqChangePassword.fromJson(Map<String, dynamic> json) {
    password = json['password'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['password'] = this.password;
    return data;
  }
}
