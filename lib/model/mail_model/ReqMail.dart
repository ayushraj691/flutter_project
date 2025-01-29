class ReqMail {
  late String to;
  late String subject;
  late String message;

  ReqMail({required this.to, required this.subject, required this.message});

  ReqMail.fromJson(Map<String, dynamic> json) {
    to = json['to'] ?? "";
    subject = json['subject'] ?? "";
    message = json['message'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['to'] = this.to;
    data['subject'] = this.subject;
    data['message'] = this.message;
    return data;
  }
}
