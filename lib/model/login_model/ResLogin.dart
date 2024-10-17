class ResLogin {
  late String email;
  late bool verified;
  late String userid;
  late String username;
  late String role;
  late String position;
  late int businesscheck;
  late String token;

  ResLogin(
      {required this.email,
      required this.verified,
      required this.userid,
      required this.username,
      required this.role,
      required this.position,
      required this.businesscheck,
      required this.token,
      });

  ResLogin.fromJson(Map<String, dynamic> json) {
    email = json['email']??"";
    verified = json['verified']??false;
    userid = json['userid']??"";
    username = json['username']??"";
    role = json['role']??"";
    position = json['position']??"";
    businesscheck = json['businesscheck']??0;
    token = json['token']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['verified'] = this.verified;
    data['userid'] = this.userid;
    data['username'] = this.username;
    data['role'] = this.role;
    data['position'] = this.position;
    data['businesscheck'] = this.businesscheck;
    data['token'] = this.token;
    return data;
  }
}