class ResBusinessData {
  late Record? record;
  late PlanDetials? planDetials;

  ResBusinessData({required this.record, required this.planDetials});

  ResBusinessData.fromJson(Map<String, dynamic> json) {
    record =
        json['record'] != null ? new Record.fromJson(json['record']) : null;
    planDetials = json['plan_detials'] != null
        ? new PlanDetials.fromJson(json['plan_detials'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.record != null) {
      data['record'] = this.record!.toJson();
    }
    if (this.planDetials != null) {
      data['plan_detials'] = this.planDetials!.toJson();
    }
    return data;
  }
}

class Record {
  late BusinessDetail? businessDetail;
  late Support? support;
  late BankDetails? bankDetails;
  late String? sId;
  late String? prefix;
  late String? colorCode;
  late String? creditLimit;
  late bool? blackFlag;
  late bool? selfVerify;
  late bool? selfDownload;
  late String? isApproved;
  late String? remark;
  late String? lastUpdatedAccountmanid;
  late String? lastPayment;
  late String? accountManager;
  late String? depositorManager;
  late String? refferalManager;
  late bool? isTerminated;
  late String? terminatedNote;
  late String? isEditRequest;
  late bool? isDeleted;
  late String? lastUpdated;
  late String? createdOn;
  late int? iV;

  Record(
      {required this.businessDetail,
      required this.support,
      required this.bankDetails,
      required this.sId,
      required this.prefix,
      required this.colorCode,
      required this.creditLimit,
      required this.blackFlag,
      required this.selfVerify,
      required this.selfDownload,
      required this.isApproved,
      required this.remark,
      required this.lastUpdatedAccountmanid,
      required this.lastPayment,
      required this.accountManager,
      required this.depositorManager,
      required this.refferalManager,
      required this.isTerminated,
      required this.terminatedNote,
      required this.isEditRequest,
      required this.isDeleted,
      required this.lastUpdated,
      required this.createdOn,
      required this.iV});

  Record.fromJson(Map<String, dynamic> json) {
    businessDetail = json['business_detail'] != null
        ? new BusinessDetail.fromJson(json['business_detail'])
        : null;
    support =
        json['support'] != null ? new Support.fromJson(json['support']) : null;
    bankDetails = json['bank_details'] != null
        ? new BankDetails.fromJson(json['bank_details'])
        : null;
    sId = json['_id'];
    prefix = json['prefix'];
    colorCode = json['color_code'];
    creditLimit = json['credit_limit'];
    blackFlag = json['black_flag'];
    selfVerify = json['self_verify'];
    selfDownload = json['self_download'];
    isApproved = json['is_approved'];
    remark = json['remark'];
    lastUpdatedAccountmanid = json['last_updated_accountmanid'];
    lastPayment = json['last_payment'];
    accountManager = json['account_manager'];
    depositorManager = json['depositor_manager'];
    refferalManager = json['refferal_manager'];
    isTerminated = json['is_terminated'];
    terminatedNote = json['terminated_note'];
    isEditRequest = json['is_edit_request'];
    isDeleted = json['is_deleted'];
    lastUpdated = json['last_updated'];
    createdOn = json['created_on'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.businessDetail != null) {
      data['business_detail'] = this.businessDetail!.toJson();
    }
    if (this.support != null) {
      data['support'] = this.support!.toJson();
    }
    if (this.bankDetails != null) {
      data['bank_details'] = this.bankDetails!.toJson();
    }
    data['_id'] = this.sId;
    data['prefix'] = this.prefix;
    data['color_code'] = this.colorCode;
    data['credit_limit'] = this.creditLimit;
    data['black_flag'] = this.blackFlag;
    data['self_verify'] = this.selfVerify;
    data['self_download'] = this.selfDownload;
    data['is_approved'] = this.isApproved;
    data['remark'] = this.remark;
    data['last_updated_accountmanid'] = this.lastUpdatedAccountmanid;
    data['last_payment'] = this.lastPayment;
    data['account_manager'] = this.accountManager;
    data['depositor_manager'] = this.depositorManager;
    data['refferal_manager'] = this.refferalManager;
    data['is_terminated'] = this.isTerminated;
    data['terminated_note'] = this.terminatedNote;
    data['is_edit_request'] = this.isEditRequest;
    data['is_deleted'] = this.isDeleted;
    data['last_updated'] = this.lastUpdated;
    data['created_on'] = this.createdOn;
    data['__v'] = this.iV;
    return data;
  }
}

class BusinessDetail {
  late Location? location;
  late License? license;
  late License? ein;
  late String? businessName;
  late String? businessEmail;
  late String? businessType;
  late String? industry;
  late String? website;
  late String? description;
  late String? businessDetailstatus;
  late String? businessPhone;
  late String? plan;

  BusinessDetail(
      {required this.location,
      required this.license,
      required this.ein,
      required this.businessName,
      required this.businessEmail,
      required this.businessType,
      required this.industry,
      required this.website,
      required this.description,
      required this.businessDetailstatus,
      required this.businessPhone,
      required this.plan});

  BusinessDetail.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    license =
        json['license'] != null ? new License.fromJson(json['license']) : null;
    ein = json['ein'] != null ? new License.fromJson(json['ein']) : null;
    businessName = json['business_name'];
    businessEmail = json['business_email'];
    businessType = json['business_type'];
    industry = json['industry'];
    website = json['website'];
    description = json['description'];
    businessDetailstatus = json['business_detailstatus'];
    businessPhone = json['business_phone'];
    plan = json['plan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    if (this.license != null) {
      data['license'] = this.license!.toJson();
    }
    if (this.ein != null) {
      data['ein'] = this.ein!.toJson();
    }
    data['business_name'] = this.businessName;
    data['business_email'] = this.businessEmail;
    data['business_type'] = this.businessType;
    data['industry'] = this.industry;
    data['website'] = this.website;
    data['description'] = this.description;
    data['business_detailstatus'] = this.businessDetailstatus;
    data['business_phone'] = this.businessPhone;
    data['plan'] = this.plan;
    return data;
  }
}

class Location {
  late String? address;
  late String? country;
  late String? city;
  late String? state;
  late String? postalcode;

  Location(
      {required this.address,
      required this.country,
      required this.city,
      required this.state,
      required this.postalcode});

  Location.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    country = json['country'];
    city = json['city'];
    state = json['state'];
    postalcode = json['postalcode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['country'] = this.country;
    data['city'] = this.city;
    data['state'] = this.state;
    data['postalcode'] = this.postalcode;
    return data;
  }
}

class License {
  late String? number;
  late String? upload;

  License({required this.number, required this.upload});

  License.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    upload = json['upload'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['number'] = this.number;
    data['upload'] = this.upload;
    return data;
  }
}

class Support {
  late String? supportEmail;
  late String? phone;
  late String? supportStatus;

  Support(
      {required this.supportEmail,
      required this.phone,
      required this.supportStatus});

  Support.fromJson(Map<String, dynamic> json) {
    supportEmail = json['support_email'];
    phone = json['phone'];
    supportStatus = json['support_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['support_email'] = this.supportEmail;
    data['phone'] = this.phone;
    data['support_status'] = this.supportStatus;
    return data;
  }
}

class BankDetails {
  late String? accountName;
  late String? accountNumber;
  late String? routingNumber;
  late String? voidCheck;
  late String? bankDetailstatus;

  BankDetails(
      {required this.accountName,
      required this.accountNumber,
      required this.routingNumber,
      required this.voidCheck,
      required this.bankDetailstatus});

  BankDetails.fromJson(Map<String, dynamic> json) {
    accountName = json['account_name'];
    accountNumber = json['account_number'];
    routingNumber = json['routing_number'];
    voidCheck = json['void_check'];
    bankDetailstatus = json['bank_detailstatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['account_name'] = this.accountName;
    data['account_number'] = this.accountNumber;
    data['routing_number'] = this.routingNumber;
    data['void_check'] = this.voidCheck;
    data['bank_detailstatus'] = this.bankDetailstatus;
    return data;
  }
}

class PlanDetials {
  late String? sId;
  late String? name;
  late PlanPrices? planPrices;
  late String? details;
  late var setupPrice;
  late var monthlyPrice;
  late String? customPlan;
  late String? isVisible;
  late String? isDeleted;
  late String? createdOn;
  late String? lastUpdated;
  late int? iV;

  PlanDetials(
      {required this.sId,
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
      required this.iV});

  PlanDetials.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    planPrices = json['plan_prices'] != null
        ? new PlanPrices.fromJson(json['plan_prices'])
        : null;
    details = json['details'];
    setupPrice = json['setup_price'];
    monthlyPrice = json['monthly_price'];
    customPlan = json['custom_plan'];
    isVisible = json['is_visible'];
    isDeleted = json['is_deleted'];
    createdOn = json['created_on'];
    lastUpdated = json['last_updated'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    if (this.planPrices != null) {
      data['plan_prices'] = this.planPrices!.toJson();
    }
    data['details'] = this.details;
    data['setup_price'] = this.setupPrice;
    data['monthly_price'] = this.monthlyPrice;
    data['custom_plan'] = this.customPlan;
    data['is_visible'] = this.isVisible;
    data['is_deleted'] = this.isDeleted;
    data['created_on'] = this.createdOn;
    data['last_updated'] = this.lastUpdated;
    data['__v'] = this.iV;
    return data;
  }
}

class PlanPrices {
  late List<String>? processingFees;
  late List<String>? perSwipeFee;
  late List<String>? verificationFee;

  PlanPrices(
      {required this.processingFees,
      required this.perSwipeFee,
      required this.verificationFee});

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
