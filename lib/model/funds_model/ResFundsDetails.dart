class ResFundsDetails {
  late FundSourcedetail? fundSourcedetail;
  late Allfunds? allfunds;

  ResFundsDetails({required this.fundSourcedetail, required this.allfunds});

  ResFundsDetails.fromJson(Map<String, dynamic> json) {
    fundSourcedetail = json['fund_sourcedetail'] != null
        ? new FundSourcedetail.fromJson(json['fund_sourcedetail'])
        : null;
    allfunds = json['allfunds'] != null
        ? new Allfunds.fromJson(json['allfunds'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.fundSourcedetail != null) {
      data['fund_sourcedetail'] = this.fundSourcedetail!.toJson();
    }
    if (this.allfunds != null) {
      data['allfunds'] = this.allfunds!.toJson();
    }
    return data;
  }
}

class FundSourcedetail {
  late String sId;
  late String name;
  late String details;
  late bool isDeleted;
  late String createdOn;
  late String lastUpdated;
  late int iV;

  FundSourcedetail(
      {required this.sId,
      required this.name,
      required this.details,
      required this.isDeleted,
      required this.createdOn,
      required this.lastUpdated,
      required this.iV});

  FundSourcedetail.fromJson(Map<String, dynamic> json) {
    sId = json['_id']??"";
    name = json['name']??"";
    details = json['details']??"";
    isDeleted = json['is_deleted']??false;
    createdOn = json['created_on']??"";
    lastUpdated = json['last_updated']??"";
    iV = json['__v']??0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['details'] = this.details;
    data['is_deleted'] = this.isDeleted;
    data['created_on'] = this.createdOn;
    data['last_updated'] = this.lastUpdated;
    data['__v'] = this.iV;
    return data;
  }
}

class Allfunds {
  late String sId;
  late FundId? fundId;
  late String businessId;
  late String txnNumber;
  late var credit;
  late var debit;
  late var balance;
  late bool status;
  late var addedNow;
  late var addedAmount;
  late String proofPay;
  late String fundSource;
  late String description;
  late String remarks;
  late var fundType;
  late String isApproved;
  late String lastUpdated;
  late bool isDeleted;
  late String isCreated;
  late int iV;

  Allfunds(
      {required this.sId,
      required this.fundId,
      required this.businessId,
      required this.txnNumber,
      required this.credit,
      required this.debit,
      required this.balance,
      required this.status,
      required this.addedNow,
      required this.addedAmount,
      required this.proofPay,
      required this.fundSource,
      required this.description,
      required this.remarks,
      required this.fundType,
      required this.isApproved,
      required this.lastUpdated,
      required this.isDeleted,
      required this.isCreated,
      required this.iV});

  Allfunds.fromJson(Map<String, dynamic> json) {
    sId = json['_id']??"";
    fundId =
        json['fund_id'] != null ? new FundId.fromJson(json['fund_id']) : null;
    businessId = json['business_id']??"";
    txnNumber = json['txn_number']??"";
    credit = json['credit'];
    debit = json['debit'];
    balance = json['balance'];
    status = json['status']??false;
    addedNow = json['added_now'];
    addedAmount = json['added_amount'];
    proofPay = json['proof_pay']??"";
    fundSource = json['fund_source']??"";
    description = json['description']??"";
    remarks = json['remarks']??"";
    fundType = json['fund_type'];
    isApproved = json['is_approved']??"";
    lastUpdated = json['last_updated']??"";
    isDeleted = json['is_deleted']??false;
    isCreated = json['is_created']??"";
    iV = json['__v']??0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.fundId != null) {
      data['fund_id'] = this.fundId!.toJson();
    }
    data['business_id'] = this.businessId;
    data['txn_number'] = this.txnNumber;
    data['credit'] = this.credit;
    data['debit'] = this.debit;
    data['balance'] = this.balance;
    data['status'] = this.status;
    data['added_now'] = this.addedNow;
    data['added_amount'] = this.addedAmount;
    data['proof_pay'] = this.proofPay;
    data['fund_source'] = this.fundSource;
    data['description'] = this.description;
    data['remarks'] = this.remarks;
    data['fund_type'] = this.fundType;
    data['is_approved'] = this.isApproved;
    data['last_updated'] = this.lastUpdated;
    data['is_deleted'] = this.isDeleted;
    data['is_created'] = this.isCreated;
    data['__v'] = this.iV;
    return data;
  }
}

class FundId {
 late String sId;
 late var available;
 late var current;

  FundId({required this.sId, required this.available, required this.current});

  FundId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    available = json['available'];
    current = json['current'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['available'] = this.available;
    data['current'] = this.current;
    return data;
  }
}
