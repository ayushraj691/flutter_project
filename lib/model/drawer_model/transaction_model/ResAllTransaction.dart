class ResTransaction {
  late String sId;
  late String custId;
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
  late bool cancelReason;
  late bool downloadBymerchant;
  late bool downloadByadmin;
  late bool isDeletedRequest;
  late bool isDeleted;
  late String createdOn;
  late String lastUpdated;
  late int iV;

  ResTransaction(
      {
        required this.sId,
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
        required this.cancelReason,
        required this.downloadBymerchant,
        required this.downloadByadmin,
        required this.isDeletedRequest,
        required this.isDeleted,
        required this.createdOn,
        required this.lastUpdated,
        required this.iV});

  ResTransaction.fromJson(Map<String, dynamic> json) {

    sId = json['_id'] ?? "";
    custId = json['cust_id'] ?? "";
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

    data['_id'] = this.sId;
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
