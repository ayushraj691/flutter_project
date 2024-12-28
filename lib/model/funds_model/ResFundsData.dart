class ResFundsData {
  late String sId;
  late String businessId;
  late var available;
  late var current;
  late int refund;
  late int status;
  late String lastUpdated;
  late int iV;

  ResFundsData(
      {required this.sId,
      required this.businessId,
      required this.available,
      required this.current,
      required this.refund,
      required this.status,
      required this.lastUpdated,
      required this.iV});

  ResFundsData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    businessId = json['business_id'];
    available = json['available'];
    current = json['current'];
    refund = json['refund'];
    status = json['status'];
    lastUpdated = json['last_updated'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['business_id'] = this.businessId;
    data['available'] = this.available;
    data['current'] = this.current;
    data['refund'] = this.refund;
    data['status'] = this.status;
    data['last_updated'] = this.lastUpdated;
    data['__v'] = this.iV;
    return data;
  }
}
