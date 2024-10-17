class ResAllBussiness {
  late BusinessDetail businessDetail;
  late Support support;
  late BankDetails bankDetails;
  late String sId;
  late String prefix;
  late String colorCode;
  late String creditLimit;
  late bool blackFlag;
  late bool selfVerify;
  late bool selfDownload;
  late String isApproved;
  late String remark;
  late String lastUpdatedAccountmanid;
  late String lastPayment;
  late String accountManager;
  late String depositorManager;
  late String refferalManager;
  late bool isTerminated;
  late String terminatedNote;
  late String isEditRequest;
  late bool isDeleted;
  late String lastUpdated;
  late String createdOn;
  late int iV;

  ResAllBussiness(
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

  ResAllBussiness.fromJson(Map<String, dynamic> json) {
    businessDetail = (json['business_detail'] != null
        ? new BusinessDetail.fromJson(json['business_detail'])
        : null)!;
    support =
        (json['support'] != null ? new Support.fromJson(json['support']) : null)!;
    bankDetails = (json['bank_details'] != null
        ? new BankDetails.fromJson(json['bank_details'])
        : null)!;
    sId = json['_id']??"";
    prefix = json['prefix']??"";
    colorCode = json['color_code']??"";
    creditLimit = json['credit_limit']??"";
    blackFlag = json['black_flag']??"";
    selfVerify = json['self_verify']??"";
    selfDownload = json['self_download']??"";
    isApproved = json['is_approved']??"";
    remark = json['remark']??"";
    lastUpdatedAccountmanid = json['last_updated_accountmanid']??"";
    lastPayment = json['last_payment']??"";
    accountManager = json['account_manager']??"";
    depositorManager = json['depositor_manager']??"";
    refferalManager = json['refferal_manager']??"";
    isTerminated = json['is_terminated']??"";
    terminatedNote = json['terminated_note']??"";
    isEditRequest = json['is_edit_request']??"";
    isDeleted = json['is_deleted']??"";
    lastUpdated = json['last_updated']??"";
    createdOn = json['created_on']??"";
    iV = json['__v']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['business_detail'] = businessDetail.toJson();
    data['support'] = support.toJson();
    data['bank_details'] = bankDetails.toJson();
      data['_id'] = sId;
    data['prefix'] = prefix;
    data['color_code'] = colorCode;
    data['credit_limit'] = creditLimit;
    data['black_flag'] = blackFlag;
    data['self_verify'] = selfVerify;
    data['self_download'] = selfDownload;
    data['is_approved'] = isApproved;
    data['remark'] = remark;
    data['last_updated_accountmanid'] = lastUpdatedAccountmanid;
    data['last_payment'] = lastPayment;
    data['account_manager'] = accountManager;
    data['depositor_manager'] = depositorManager;
    data['refferal_manager'] = refferalManager;
    data['is_terminated'] = isTerminated;
    data['terminated_note'] = terminatedNote;
    data['is_edit_request'] = isEditRequest;
    data['is_deleted'] = isDeleted;
    data['last_updated'] = lastUpdated;
    data['created_on'] = createdOn;
    data['__v'] = iV;
    return data;
  }
}

class BusinessDetail {
  Location? location;
  License? license;
  License? ein;
  String? businessName;
  String? businessEmail;
  String? businessType;
  String? industry;
  String? website;
  String? description;
  String? businessDetailstatus;
  String? businessPhone;
  String? plan;

  BusinessDetail(
      {this.location,
      this.license,
      this.ein,
      this.businessName,
      this.businessEmail,
      this.businessType,
      this.industry,
      this.website,
      this.description,
      this.businessDetailstatus,
      this.businessPhone,
      this.plan});

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
  String? address;
  String? country;
  String? city;
  String? state;
  String? postalcode;

  Location(
      {this.address, this.country, this.city, this.state, this.postalcode});

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
  String? number;
  String? upload;

  License({this.number, this.upload});

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
  String? supportEmail;
  String? phone;
  String? supportStatus;

  Support({this.supportEmail, this.phone, this.supportStatus});

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
  String? accountName;
  String? accountNumber;
  String? routingNumber;
  String? voidCheck;
  String? bankDetailstatus;

  BankDetails(
      {this.accountName,
      this.accountNumber,
      this.routingNumber,
      this.voidCheck,
      this.bankDetailstatus});

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
