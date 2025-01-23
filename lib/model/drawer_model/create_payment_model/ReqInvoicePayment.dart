class ReqInvoicePayment {
  late String custId;
  late String bankId;
  late String payDue;
  late var payTotal;
  late String checkNo;
  late String memo;
  late bool isInvoice;
  late bool isInvoicePreapproved;
  late List<Items> items;

  ReqInvoicePayment(
      {required this.custId,
      required this.bankId,
      required this.payDue,
      required this.payTotal,
      required this.checkNo,
      required this.memo,
      required this.isInvoice,
      required this.isInvoicePreapproved,
      required this.items});

  ReqInvoicePayment.fromJson(Map<String, dynamic> json) {
    custId = json['cust_id'] ?? "";
    bankId = json['bank_id'] ?? "";
    payDue = json['pay_due'] ?? "";
    payTotal = json['pay_total'] ?? "";
    checkNo = json['check_no'] ?? "";
    memo = json['memo'] ?? "";
    isInvoice = json['is_invoice'] ?? "";
    isInvoicePreapproved = json['is_invoice_preapproved'] ?? "";
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cust_id'] = this.custId;
    data['bank_id'] = this.bankId;
    data['pay_due'] = this.payDue;
    data['pay_total'] = this.payTotal;
    data['check_no'] = this.checkNo;
    data['memo'] = this.memo;
    data['is_invoice'] = this.isInvoice;
    data['is_invoice_preapproved'] = this.isInvoicePreapproved;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  late String proId;
  late String proName;
  late String proQty;
  late String proPrice;

  Items(
      {required this.proId,
      required this.proName,
      required this.proQty,
      required this.proPrice});

  Items.fromJson(Map<String, dynamic> json) {
    proId = json['pro_id'] ?? "";
    proName = json['pro_name'] ?? "";
    proQty = json['pro_qty'] ?? "";
    proPrice = json['pro_price'] ?? "";
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
