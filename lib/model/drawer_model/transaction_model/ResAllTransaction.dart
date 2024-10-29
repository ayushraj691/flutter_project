class ResTransactionDetail {
  late SubscriptionInfo? subscriptionInfo;
  late String sId;
  late String businessId;
  late CustId? custId;
  late String bankId;
  late int checkNo;
  late String memo;
  late String source;
  late String txnNumber;
  late int randomNumber;
  late int payTotal;
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
  late List<String> recurring;
  late String cancelReason;
  late bool downloadBymerchant;
  late bool downloadByadmin;
  late bool isDeletedRequest;
  late bool isDeleted;
  late String createdOn;
  late String lastUpdated;
  late int iV;

  ResTransactionDetail({
    this.subscriptionInfo,
    required this.sId,
    required this.businessId,
    this.custId,
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
    required this.recurring,
    required this.cancelReason,
    required this.downloadBymerchant,
    required this.downloadByadmin,
    required this.isDeletedRequest,
    required this.isDeleted,
    required this.createdOn,
    required this.lastUpdated,
    required this.iV,
  });

  ResTransactionDetail.fromJson(Map<String, dynamic> json) {
    subscriptionInfo = json['subscription_info'] != null
        ? SubscriptionInfo.fromJson(json['subscription_info'])
        : null;
    sId = json['_id'] ?? "";
    businessId = json['business_id'] ?? "";
    custId = json['cust_id'] != null ? CustId.fromJson(json['cust_id']) : null;
    bankId = json['bank_id'] ?? "";
    checkNo = json['check_no'] ?? 0;
    memo = json['memo'] ?? "";
    source = json['source'] ?? "";
    txnNumber = json['txn_number'] ?? "";
    randomNumber = json['random_number'] ?? 0;
    payTotal = json['pay_total'] ?? 0;
    isInvoice = json['is_invoice'] ?? false;
    isInvoicePreapproved = json['is_invoice_preapproved'] ?? false;
    payDue = json['pay_due'] ?? "";
    isSendInvoice = json['is_send_invoice'] ?? false;
    isSusbcription = json['is_susbcription'] ?? false;
    isSchedule = json['is_schedule'] ?? false;
    scheduleStart = json['schedule_start'] ?? false;
    subscriptionIsInvoice = json['subscription_is_invoice'] ?? false;
    subscriptionInvoicePreapproved = json['subscription_invoice_preapproved'] ?? false;
    verificationStatus = json['verification_status'] ?? false;
    verifyToken = json['verify_token'] ?? "";
    subscriptionType = json['subscription_type'] ?? "";
    payStatus = json['pay_status'] ?? "";
    payMode = json['pay_mode'] ?? "";
    products = List<String>.from(json['products'] ?? []);
    recurring = List<String>.from(json['recurring'] ?? []);
    cancelReason = json['cancel_reason'] ?? "";
    downloadBymerchant = json['download_bymerchant'] ?? false;
    downloadByadmin = json['download_byadmin'] ?? false;
    isDeletedRequest = json['is_deleted_request'] ?? false;
    isDeleted = json['is_deleted'] ?? false;
    createdOn = json['created_on'] ?? "";
    lastUpdated = json['last_updated'] ?? "";
    iV = json['__v'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (subscriptionInfo != null) {
      data['subscription_info'] = subscriptionInfo!.toJson();
    }
    data['_id'] = sId;
    data['business_id'] = businessId;
    if (custId != null) {
      data['cust_id'] = custId!.toJson();
    }
    data['bank_id'] = bankId;
    data['check_no'] = checkNo;
    data['memo'] = memo;
    data['source'] = source;
    data['txn_number'] = txnNumber;
    data['random_number'] = randomNumber;
    data['pay_total'] = payTotal;
    data['is_invoice'] = isInvoice;
    data['is_invoice_preapproved'] = isInvoicePreapproved;
    data['pay_due'] = payDue;
    data['is_send_invoice'] = isSendInvoice;
    data['is_susbcription'] = isSusbcription;
    data['is_schedule'] = isSchedule;
    data['schedule_start'] = scheduleStart;
    data['subscription_is_invoice'] = subscriptionIsInvoice;
    data['subscription_invoice_preapproved'] = subscriptionInvoicePreapproved;
    data['verification_status'] = verificationStatus;
    data['verify_token'] = verifyToken;
    data['subscription_type'] = subscriptionType;
    data['pay_status'] = payStatus;
    data['pay_mode'] = payMode;
    data['products'] = products;
    data['recurring'] = recurring;
    data['cancel_reason'] = cancelReason;
    data['download_bymerchant'] = downloadBymerchant;
    data['download_byadmin'] = downloadByadmin;
    data['is_deleted_request'] = isDeletedRequest;
    data['is_deleted'] = isDeleted;
    data['created_on'] = createdOn;
    data['last_updated'] = lastUpdated;
    data['__v'] = iV;
    return data;
  }
}

class SubscriptionInfo {
  late String subsCycle;
  late String start;
  late String end;

  SubscriptionInfo({required this.subsCycle, required this.start, required this.end});

  SubscriptionInfo.fromJson(Map<String, dynamic> json) {
    subsCycle = json['subs_cycle'] ?? "";
    start = json['start'] ?? "";
    end = json['end'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['subs_cycle'] = subsCycle;
    data['start'] = start;
    data['end'] = end;
    return data;
  }
}

class CustId {
  late Info info;
  late String sId;

  CustId({required this.info, required this.sId});

  CustId.fromJson(Map<String, dynamic> json) {
    info = json['info'] != null ? Info.fromJson(json['info']) : Info(custName: '', email: '');
    sId = json['_id'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['info'] = info.toJson();
    data['_id'] = sId;
    return data;
  }
}

class Info {
  late String custName;
  late String email;

  Info({required this.custName, required this.email});

  Info.fromJson(Map<String, dynamic> json) {
    custName = json['cust_name'] ?? "";
    email = json['email'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['cust_name'] = custName;
    data['email'] = email;
    return data;
  }
}
