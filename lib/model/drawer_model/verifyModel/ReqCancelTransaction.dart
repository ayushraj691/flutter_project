class ReqCancelTransaction {
  late List<String> payId;
  late int statusCode;

  ReqCancelTransaction({required this.payId, required this.statusCode});

  ReqCancelTransaction.fromJson(Map<String, dynamic> json) {
    payId = json['pay_id'].cast<String>();
    statusCode = json['status_code']??0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pay_id'] = this.payId;
    data['status_code'] = this.statusCode;
    return data;
  }
}
