class ReqCreatePayment {
  late String custId;
  late String bankId;
  late var payTotal;
  late String checkNo;
  late String memo;
  late List<Items> items;

  ReqCreatePayment(
      {required this.custId,
      required this.bankId,
      required this.payTotal,
      required this.checkNo,
      required this.memo,
      required this.items});

  ReqCreatePayment.fromJson(Map<String, dynamic> json) {
    custId = json['cust_id'] ?? "";
    bankId = json['bank_id'] ?? "";
    payTotal = json['pay_total'] ?? "";
    checkNo = json['check_no'] ?? "";
    memo = json['memo'] ?? "";
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items.add(Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cust_id'] = custId;
    data['bank_id'] = bankId;
    data['pay_total'] = payTotal;
    data['check_no'] = checkNo;
    data['memo'] = memo;
    data['items'] = items.map((v) => v.toJson()).toList();
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
    data['pro_id'] = proId;
    data['pro_name'] = proName;
    data['pro_qty'] = proQty;
    data['pro_price'] = proPrice;
    return data;
  }
}
