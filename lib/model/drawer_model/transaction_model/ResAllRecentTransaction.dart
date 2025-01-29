class ResAllRecentTransaction {
  late SubscriptionInfo subscriptionInfo;
  late String sId;
  late BusinessId businessId;
  late String custId;
  late String bankId;
  late var checkNo;
  late String memo;
  late String source;
  late String txnNumber;
  late var randomNumber;
  late var payTotal;
  late bool isInvoice;
  late bool isInvoicePreapproved;
  late String payDue;
  late bool isSendInvoice;
  late bool isSusbcription;
  late bool isSchedule;
  late bool scheduleStart;
  late bool subscriptionIsInvoice;
  late bool subscriptionInvoicePreapproved;
  late bool verificationStatus;
  late String verifyToken;
  late String subscriptionType;
  late String payStatus;
  late String payMode;
  late List<String> products;

  // late List<Null> recurring;
  late bool cancelReason;
  late bool downloadBymerchant;
  late bool downloadByadmin;
  late bool isDeletedRequest;
  late bool isDeleted;
  late String createdOn;
  late String lastUpdated;
  late int iV;

  ResAllRecentTransaction(
      {required this.subscriptionInfo,
      required this.sId,
      required this.businessId,
      required this.custId,
      required this.bankId,
      required this.checkNo,
      required this.memo,
      required this.source,
      required this.txnNumber,
      required this.randomNumber,
      required this.payTotal,
      required this.isInvoice,
      required this.isInvoicePreapproved,
      required this.payDue,
      required this.isSendInvoice,
      required this.isSusbcription,
      required this.isSchedule,
      required this.scheduleStart,
      required this.subscriptionIsInvoice,
      required this.subscriptionInvoicePreapproved,
      required this.verificationStatus,
      required this.verifyToken,
      required this.subscriptionType,
      required this.payStatus,
      required this.payMode,
      required this.products,
      // required this.recurring,
      required this.cancelReason,
      required this.downloadBymerchant,
      required this.downloadByadmin,
      required this.isDeletedRequest,
      required this.isDeleted,
      required this.createdOn,
      required this.lastUpdated,
      required this.iV});

  ResAllRecentTransaction.fromJson(Map<String, dynamic> json) {
    subscriptionInfo = (json['subscription_info'] != null
        ? SubscriptionInfo.fromJson(json['subscription_info'])
        : SubscriptionInfo(
            subsCycle: "", start: "", end: "")); // Default object if null
    sId = json['_id'] ?? "";
    businessId = (json['business_id'] != null
        ? BusinessId.fromJson(json['business_id'])
        : BusinessId(
            businessDetail: BusinessDetail(businessName: ""),
            sId: "")); // Default object if null
    custId = json['cust_id'] ?? "";
    bankId = json['bank_id'] ?? "";
    checkNo = json['check_no'];
    memo = json['memo'] ?? "";
    source = json['source'] ?? "";
    txnNumber = json['txn_number'] ?? "";
    randomNumber = json['random_number'];
    payTotal = json['pay_total'];
    isInvoice = json['is_invoice'] ?? false;
    isInvoicePreapproved = json['is_invoice_preapproved'] ?? false;
    payDue = json['pay_due'] ?? "";
    isSendInvoice = json['is_send_invoice'] ?? false;
    isSusbcription = json['is_susbcription'] ?? false;
    isSchedule = json['is_schedule'] ?? false;
    scheduleStart = json['schedule_start'] ?? false;
    subscriptionIsInvoice = json['subscription_is_invoice'] ?? false;
    subscriptionInvoicePreapproved =
        json['subscription_invoice_preapproved'] ?? false;
    verificationStatus = json['verification_status'] ?? false;
    verifyToken = json['verify_token'] ?? "";
    subscriptionType = json['subscription_type'] ?? "";
    payStatus = json['pay_status'] ?? "";
    payMode = json['pay_mode'] ?? "";
    products =
        json['products'] != null ? List<String>.from(json['products']) : [];
    cancelReason = json['cancel_reason'] ?? false;
    downloadBymerchant = json['download_bymerchant'] ?? false;
    downloadByadmin = json['download_byadmin'] ?? false;
    isDeletedRequest = json['is_deleted_request'] ?? false;
    isDeleted = json['is_deleted'] ?? false;
    createdOn = json['created_on'] ?? "";
    lastUpdated = json['last_updated'] ?? "";
    iV = json['__v'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.subscriptionInfo != null) {
      data['subscription_info'] = this.subscriptionInfo.toJson();
    }
    data['_id'] = this.sId;
    if (this.businessId != null) {
      data['business_id'] = this.businessId.toJson();
    }
    data['cust_id'] = this.custId;
    data['bank_id'] = this.bankId;
    data['check_no'] = this.checkNo;
    data['memo'] = this.memo;
    data['source'] = this.source;
    data['txn_number'] = this.txnNumber;
    data['random_number'] = this.randomNumber;
    data['pay_total'] = this.payTotal;
    data['is_invoice'] = this.isInvoice;
    data['is_invoice_preapproved'] = this.isInvoicePreapproved;
    data['pay_due'] = this.payDue;
    data['is_send_invoice'] = this.isSendInvoice;
    data['is_susbcription'] = this.isSusbcription;
    data['is_schedule'] = this.isSchedule;
    data['schedule_start'] = this.scheduleStart;
    data['subscription_is_invoice'] = this.subscriptionIsInvoice;
    data['subscription_invoice_preapproved'] =
        this.subscriptionInvoicePreapproved;
    data['verification_status'] = this.verificationStatus;
    data['verify_token'] = this.verifyToken;
    data['subscription_type'] = this.subscriptionType;
    data['pay_status'] = this.payStatus;
    data['pay_mode'] = this.payMode;
    data['products'] = this.products;
    // if (this.recurring != null) {
    //   data['recurring'] = this.recurring.map((v) => v.toJson()).toList();
    // }
    data['cancel_reason'] = this.cancelReason;
    data['download_bymerchant'] = this.downloadBymerchant;
    data['download_byadmin'] = this.downloadByadmin;
    data['is_deleted_request'] = this.isDeletedRequest;
    data['is_deleted'] = this.isDeleted;
    data['created_on'] = this.createdOn;
    data['last_updated'] = this.lastUpdated;
    data['__v'] = this.iV;
    return data;
  }
}

class SubscriptionInfo {
  late String subsCycle;
  late String start;
  late String end;

  SubscriptionInfo(
      {required this.subsCycle, required this.start, required this.end});

  SubscriptionInfo.fromJson(Map<String, dynamic> json) {
    subsCycle = json['subs_cycle'] ?? "";
    start = json['start'] ?? "";
    end = json['end'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subs_cycle'] = this.subsCycle;
    data['start'] = this.start;
    data['end'] = this.end;
    return data;
  }
}

class BusinessId {
  late BusinessDetail businessDetail;
  late String sId;

  BusinessId({required this.businessDetail, required this.sId});

  BusinessId.fromJson(Map<String, dynamic> json) {
    businessDetail = (json['business_detail'] != null
        ? new BusinessDetail.fromJson(json['business_detail'])
        : null)!;
    sId = json['_id'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.businessDetail != null) {
      data['business_detail'] = this.businessDetail.toJson();
    }
    data['_id'] = this.sId;
    return data;
  }
}

class BusinessDetail {
  late String businessName;

  BusinessDetail({required this.businessName});

  BusinessDetail.fromJson(Map<String, dynamic> json) {
    businessName = json['business_name'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['business_name'] = this.businessName;
    return data;
  }
}
