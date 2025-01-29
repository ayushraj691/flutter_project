class ResGetAllPlans {
  late String sId;
  late String name;
  late PlanPrices planPrices;
  late String details;
  late var setupPrice;
  late var monthlyPrice;
  late String customPlan;
  late String isVisible;
  late String isDeleted;
  late String createdOn;
  late String lastUpdated;
  late var iV;

  ResGetAllPlans({
    required this.sId,
    required this.name,
    required this.planPrices,
    required this.details,
    required this.setupPrice,
    required this.monthlyPrice,
    required this.customPlan,
    required this.isVisible,
    required this.isDeleted,
    required this.createdOn,
    required this.lastUpdated,
    required this.iV,
  });

  ResGetAllPlans.fromJson(Map<String, dynamic> json) {
    sId = json['_id'] ?? "";
    name = json['name'] ?? "";
    planPrices = PlanPrices.fromJson(json['plan_prices']);
    details = json['details'] ?? "";
    setupPrice = json['setup_price'] ?? 0;
    monthlyPrice = json['monthly_price'] ?? 0;
    customPlan = json['custom_plan'] ?? "";
    isVisible = json['is_visible'] ?? "";
    isDeleted = json['is_deleted'] ?? "";
    createdOn = json['created_on'] ?? "";
    lastUpdated = json['last_updated'] ?? "";
    iV = json['__v'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': sId,
      'name': name,
      'plan_prices': planPrices.toJson(),
      'details': details,
      'setup_price': setupPrice,
      'monthly_price': monthlyPrice,
      'custom_plan': customPlan,
      'is_visible': isVisible,
      'is_deleted': isDeleted,
      'created_on': createdOn,
      'last_updated': lastUpdated,
      '__v': iV,
    };
  }
}

class PlanPrices {
  late List<String> processingFees;
  late List<String> perSwipeFee;
  late List<String> verificationFee;

  PlanPrices({
    required this.processingFees,
    required this.perSwipeFee,
    required this.verificationFee,
  });

  PlanPrices.fromJson(Map<String, dynamic> json) {
    processingFees = List<String>.from(json['processing_fees'] ?? []);
    perSwipeFee = List<String>.from(json['per_swipe_fee'] ?? []);
    verificationFee = List<String>.from(json['verification_fee'] ?? []);
  }

  Map<String, dynamic> toJson() {
    return {
      'processing_fees': processingFees,
      'per_swipe_fee': perSwipeFee,
      'verification_fee': verificationFee,
    };
  }
}
