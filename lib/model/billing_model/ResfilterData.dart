class ResfilterData {
  late String sId;
  late String fundId;
  late String businessId;
  late String txnNumber;
  late int credit;
  late double debit;
  late double balance;
  late bool status;
  late int addedNow;
  late int addedAmount;
  String? proofPay; // Nullable field
  late String fundSource;
  late String description;
  String? remarks; // Nullable field
  late int fundType;
  late String isApproved;
  late String lastUpdated;
  late bool isDeleted;
  late String isCreated;
  late int iV;

  ResfilterData({
    required this.sId,
    required this.fundId,
    required this.businessId,
    required this.txnNumber,
    required this.credit,
    required this.debit,
    required this.balance,
    required this.status,
    required this.addedNow,
    required this.addedAmount,
    this.proofPay, // Nullable field
    required this.fundSource,
    required this.description,
    this.remarks, // Nullable field
    required this.fundType,
    required this.isApproved,
    required this.lastUpdated,
    required this.isDeleted,
    required this.isCreated,
    required this.iV,
  });

  ResfilterData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'] ?? "";
    fundId = json['fund_id'] ?? "";
    businessId = json['business_id'] ?? "";
    txnNumber = json['txn_number'] ?? "";
    credit = json['credit'] ?? 0;
    debit = (json['debit'] ?? 0.0).toDouble();
    balance = (json['balance'] ?? 0.0).toDouble();
    status = json['status'] ?? false;
    addedNow = json['added_now'] ?? 0;
    addedAmount = json['added_amount'] ?? 0;
    proofPay = json['proof_pay']; // Nullable, no default value
    fundSource = json['fund_source'] ?? "";
    description = json['description'] ?? "";
    remarks = json['remarks']; // Nullable, no default value
    fundType = json['fund_type'] ?? 0;
    isApproved = json['is_approved'] ?? "";
    lastUpdated = json['last_updated'] ?? "";
    isDeleted = json['is_deleted'] ?? false;
    isCreated = json['is_created'] ?? "";
    iV = json['__v'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['fund_id'] = fundId;
    data['business_id'] = businessId;
    data['txn_number'] = txnNumber;
    data['credit'] = credit;
    data['debit'] = debit;
    data['balance'] = balance;
    data['status'] = status;
    data['added_now'] = addedNow;
    data['added_amount'] = addedAmount;
    data['proof_pay'] = proofPay; // Nullable field
    data['fund_source'] = fundSource;
    data['description'] = description;
    data['remarks'] = remarks; // Nullable field
    data['fund_type'] = fundType;
    data['is_approved'] = isApproved;
    data['last_updated'] = lastUpdated;
    data['is_deleted'] = isDeleted;
    data['is_created'] = isCreated;
    data['__v'] = iV;
    return data;
  }
}
