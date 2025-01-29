class ReqDeleteTransactionData {
  late List<String> ids;

  ReqDeleteTransactionData({required this.ids});

  ReqDeleteTransactionData.fromJson(Map<String, dynamic> json) {
    ids = json['ids'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ids'] = this.ids;
    return data;
  }
}
