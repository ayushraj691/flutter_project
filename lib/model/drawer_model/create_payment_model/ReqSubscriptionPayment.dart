class ReqSubscriptionPayment {
  late String custId;
  late String bankId;
  late var payTotal;
  late String checkNo;
  late String memo;
  late bool subscriptionIsInvoice;
  late bool subscriptionInvoicePreapproved;
  late bool isSusbcription;
  late String subscriptionType;
  late String start;
  late String subsCycle;
  late String end;
  late List<Items> items;

  ReqSubscriptionPayment(
      {required this.custId,
     required this.bankId,
      required this.payTotal,
      required this.checkNo,
      required this.memo,
      required this.subscriptionIsInvoice,
      required this.subscriptionInvoicePreapproved,
      required this.isSusbcription,
      required this.subscriptionType,
      required this.start,
      required this.subsCycle,
      required this.end,
      required this.items});

  ReqSubscriptionPayment.fromJson(Map<String, dynamic> json) {
    custId = json['cust_id']??"";
    bankId = json['bank_id']??"";
    payTotal = json['pay_total']??0;
    checkNo = json['check_no']??"";
    memo = json['memo']??"";
    subscriptionIsInvoice = json['subscription_is_invoice']??false;
    subscriptionInvoicePreapproved = json['subscription_invoice_preapproved']??false;
    isSusbcription = json['is_susbcription']??false;
    subscriptionType = json['subscription_type']??"";
    start = json['start']??"";
    subsCycle = json['subs_cycle']??"";
    end = json['end']??"";
    if (json['items'] != null) {
      items =<Items>[];
      json['items'].forEach((v) {
        items.add(Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cust_id'] = this.custId;
    data['bank_id'] = this.bankId;
    data['pay_total'] = this.payTotal;
    data['check_no'] = this.checkNo;
    data['memo'] = this.memo;
    data['subscription_is_invoice'] = this.subscriptionIsInvoice;
    data['subscription_invoice_preapproved'] =
        this.subscriptionInvoicePreapproved;
    data['is_susbcription'] = this.isSusbcription;
    data['subscription_type'] = this.subscriptionType;
    data['start'] = this.start;
    data['subs_cycle'] = this.subsCycle;
    data['end'] = this.end;
    if (items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  late String id;
  late String sId;
  late String proId;
  late String proName;
  late String proQty;
  late String proPrice;

  Items(
      {required this.id,
      required this.sId,
      required this.proId,
      required this.proName,
      required this.proQty,
      required this.proPrice});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id']??"";
    sId = json['_id']??"";
    proId = json['pro_id']??"";
    proName = json['pro_name']??"";
    proQty = json['pro_qty']??"";
    proPrice = json['pro_price']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['_id'] = this.sId;
    data['pro_id'] = this.proId;
    data['pro_name'] = this.proName;
    data['pro_qty'] = this.proQty;
    data['pro_price'] = this.proPrice;
    return data;
  }
}
