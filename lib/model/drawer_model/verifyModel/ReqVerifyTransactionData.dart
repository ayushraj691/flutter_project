class ReqVerifyTransactionData {
  late List<String> ids;

  ReqVerifyTransactionData({required this.ids});

  ReqVerifyTransactionData.fromJson(Map<String, dynamic> json) {
    ids = json['ids'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ids'] = this.ids;
    return data;
  }
}
