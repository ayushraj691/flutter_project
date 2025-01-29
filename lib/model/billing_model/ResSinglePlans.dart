class ResSinglePlans {
  late String? sId;
  late String? businessId;
  late PlanId? planId;
  late String? createdOn;
  late String? dueDate;
  late String? lastUpdated;
  late int? iV;

  ResSinglePlans(
      {required this.sId,
      required this.businessId,
      required this.planId,
      required this.createdOn,
      required this.dueDate,
      required this.lastUpdated,
      required this.iV});

  ResSinglePlans.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    businessId = json['business_id'];
    planId = (json['plan_id'] != null
        ? new PlanId.fromJson(json['plan_id'])
        : null)!;
    createdOn = json['created_on'];
    dueDate = json['due_date'];
    lastUpdated = json['last_updated'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['business_id'] = this.businessId;
    if (this.planId != null) {
      data['plan_id'] = this.planId!.toJson();
    }
    data['created_on'] = this.createdOn;
    data['due_date'] = this.dueDate;
    data['last_updated'] = this.lastUpdated;
    data['__v'] = this.iV;
    return data;
  }
}

class PlanId {
  late String sId;
  late String name;
  late PlanPrices planPrices;
  late String details;
  late int monthlyPrice;

  PlanId(
      {required this.sId,
      required this.name,
      required this.planPrices,
      required this.details,
      required this.monthlyPrice});

  PlanId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    planPrices = (json['plan_prices'] != null
        ? PlanPrices.fromJson(json['plan_prices'])
        : null)!;
    details = json['details'];
    monthlyPrice = json['monthly_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    if (this.planPrices != null) {
      data['plan_prices'] = this.planPrices!.toJson();
    }
    data['details'] = this.details;
    data['monthly_price'] = this.monthlyPrice;
    return data;
  }
}

class PlanPrices {
  List<String>? processingFees;
  List<String>? perSwipeFee;
  List<String>? verificationFee;

  PlanPrices({this.processingFees, this.perSwipeFee, this.verificationFee});

  PlanPrices.fromJson(Map<String, dynamic> json) {
    processingFees = json['processing_fees'].cast<String>();
    perSwipeFee = json['per_swipe_fee'].cast<String>();
    verificationFee = json['verification_fee'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['processing_fees'] = this.processingFees;
    data['per_swipe_fee'] = this.perSwipeFee;
    data['verification_fee'] = this.verificationFee;
    return data;
  }
}
