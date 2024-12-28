class ResSinglePayment {
  late SubscriptionInfo subscriptionInfo;
  late String sId;
  late BusinessId businessId;
  late CustId custId;
  late BankId bankId;
  late int checkNo;
  late String memo;
  late String source;
  late String txnNumber;
  late int randomNumber;
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
  late List<Products> products;
  late List<String> recurring;
  late String cancelReason;
  late bool downloadBymerchant;
  late bool downloadByadmin;
  late bool isDeletedRequest;
  late bool isDeleted;
  late String createdOn;
  late String lastUpdated;
  late int iV;


  ResSinglePayment(
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
      required this.recurring,
      required this.cancelReason,
      required this.downloadBymerchant,
      required this.downloadByadmin,
      required this.isDeletedRequest,
      required this.isDeleted,
      required this.createdOn,
      required this.lastUpdated,
      required this.iV});

  ResSinglePayment.fromJson(Map<String, dynamic> json) {
    subscriptionInfo = (json['subscription_info'] != null
        ? new SubscriptionInfo.fromJson(json['subscription_info'])
        : null)!;
    sId = json['_id']??0;
    businessId = (json['business_id'] != null
        ? new BusinessId.fromJson(json['business_id'])
        : null)!;
    custId =
        (json['cust_id'] != null ? new CustId.fromJson(json['cust_id']) : null)!;
    bankId =
        (json['bank_id'] != null ? new BankId.fromJson(json['bank_id']) : null)!;
    checkNo = json['check_no']??0;
    memo = json['memo']??"";
    source = json['source']??"";
    txnNumber = json['txn_number']??"";
    randomNumber = json['random_number']??0;
    payTotal = json['pay_total']??'';
    isInvoice = json['is_invoice']??false;
    isInvoicePreapproved = json['is_invoice_preapproved']??false;
    payDue = json['pay_due']??"";
    isSendInvoice = json['is_send_invoice']??false;
    isSusbcription = json['is_susbcription']??false;
    isSchedule = json['is_schedule']??false;
    scheduleStart = json['schedule_start']??false;
    subscriptionIsInvoice = json['subscription_is_invoice']??false;
    subscriptionInvoicePreapproved = json['subscription_invoice_preapproved']??false;
    verificationStatus = json['verification_status']??false;
    verifyToken = json['verify_token']??"";
    subscriptionType = json['subscription_type']??'';
    payStatus = json['pay_status']??"";
    payMode = json['pay_mode']??"";
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products.add(Products.fromJson(v));
      });
    }
    recurring = json['recurring'].cast<String>();
    cancelReason = json['cancel_reason']??'';
    downloadBymerchant = json['download_bymerchant']??false;
    downloadByadmin = json['download_byadmin']??false;
    isDeletedRequest = json['is_deleted_request']??false;
    isDeleted = json['is_deleted']??false;
    createdOn = json['created_on']??"";
    lastUpdated = json['last_updated']??"";
    iV = json['__v']??0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subscription_info'] = subscriptionInfo!.toJson();
      data['_id'] = sId;
    data['business_id'] = businessId.toJson();
    data['cust_id'] = custId.toJson();
    data['bank_id'] = bankId.toJson();
      data['check_no'] = checkNo;
    data['memo'] = memo;
    data['source'] = source;
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
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    data['recurring'] = this.recurring;
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
  late String start;
  late String subsCycle;
  late String end;

  SubscriptionInfo({required this.start, required this.subsCycle, required this.end});

  SubscriptionInfo.fromJson(Map<String, dynamic> json) {
    start = json['start']??'';
    subsCycle = json['subs_cycle']??"";
    end = json['end']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start'] = this.start;
    data['subs_cycle'] = this.subsCycle;
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
    sId = json['_id']??0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.businessDetail != null) {
      data['business_detail'] = this.businessDetail!.toJson();
    }
    data['_id'] = this.sId;
    return data;
  }
}

class BusinessDetail {
  late String businessName;
  late String businessEmail;
  late String businessPhone;

  BusinessDetail({required this.businessName, required this.businessEmail, required this.businessPhone});

  BusinessDetail.fromJson(Map<String, dynamic> json) {
    businessName = json['business_name']??"";
    businessEmail = json['business_email']??"";
    businessPhone = json['business_phone']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['business_name'] = this.businessName;
    data['business_email'] = this.businessEmail;
    data['business_phone'] = this.businessPhone;
    return data;
  }
}

class CustId {
 late Info info;
 late String sId;

  CustId({required this.info, required this.sId});

  CustId.fromJson(Map<String, dynamic> json) {
    info = (json['info'] != null ? new Info.fromJson(json['info']) : null)!;
    sId = json['_id']??0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.info != null) {
      data['info'] = this.info!.toJson();
    }
    data['_id'] = this.sId;
    return data;
  }
}

class Info {
  late String custName;
  late String mobile;
  late String email;

  Info({required this.custName, required this.mobile, required this.email});

  Info.fromJson(Map<String, dynamic> json) {
    custName = json['cust_name']??"";
    mobile = json['mobile']??"";
    email = json['email']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cust_name'] = this.custName;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    return data;
  }
}

class BankId {
  late Location location;
  late String sId;
  late bool primary;
  late String accountName;
  late String accountNumber;
  late String routingNumber;
  late String bankName;
  late String bankAddress;
  late String bankCity;
  late String bankState;

  BankId(
      {required this.location,
      required this.sId,
      required this.primary,
      required this.accountName,
      required this.accountNumber,
      required this.routingNumber,
      required this.bankName,
      required this.bankAddress,
      required this.bankCity,
      required this.bankState});

  BankId.fromJson(Map<String, dynamic> json) {
    location = (json['location'] != null
        ? new Location.fromJson(json['location'])
        : null)!;
    sId = json['_id']??0;
    primary = json['primary']??false;
    accountName = json['account_name']??"";
    accountNumber = json['account_number']??"";
    routingNumber = json['routing_number']??"";
    bankName = json['bank_name']??"";
    bankAddress = json['bank_address']??"";
    bankCity = json['bank_city']??"";
    bankState = json['bank_state']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['_id'] = this.sId;
    data['primary'] = this.primary;
    data['account_name'] = this.accountName;
    data['account_number'] = this.accountNumber;
    data['routing_number'] = this.routingNumber;
    data['bank_name'] = this.bankName;
    data['bank_address'] = this.bankAddress;
    data['bank_city'] = this.bankCity;
    data['bank_state'] = this.bankState;
    return data;
  }
}

class Location {
  late String address;
  late String country;
  late String city;
  late String state;
  late String postalCode;

  Location(
      {required this.address, required this.country, required this.city, required this.state, required this.postalCode});

  Location.fromJson(Map<String, dynamic> json) {
    address = json['address']??"";
    country = json['country']??"";
    city = json['city']??"";
    state = json['state']??"";
    postalCode = json['postal_code']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['country'] = this.country;
    data['city'] = this.city;
    data['state'] = this.state;
    data['postal_code'] = this.postalCode;
    return data;
  }
}

class Products {
  late ProDetail proDetail;
  late String sId;
  late String paymentId;
  late int iV;

  Products({required this.proDetail, required this.sId, required this.paymentId, required this.iV});

  Products.fromJson(Map<String, dynamic> json) {
    proDetail = (json['pro_detail'] != null
        ? new ProDetail.fromJson(json['pro_detail'])
        : null)!;
    sId = json['_id']??0;
    paymentId = json['payment_id']??"";
    iV = json['__v']??0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.proDetail != null) {
      data['pro_detail'] = this.proDetail!.toJson();
    }
    data['_id'] = this.sId;
    data['payment_id'] = this.paymentId;
    data['__v'] = this.iV;
    return data;
  }
}

class ProDetail {
  late String proId;
  late String proName;
  late String proQty;
  late String proPrice;

  ProDetail({required this.proId, required this.proName, required this.proQty, required this.proPrice});

  ProDetail.fromJson(Map<String, dynamic> json) {
    proId = json['pro_id']??"";
    proName = json['pro_name']??"";
    proQty = json['pro_qty']??"";
    proPrice = json['pro_price']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pro_id'] = this.proId;
    data['pro_name'] = this.proName;
    data['pro_qty'] = this.proQty;
    data['pro_price'] = this.proPrice;
    return data;
  }
}
