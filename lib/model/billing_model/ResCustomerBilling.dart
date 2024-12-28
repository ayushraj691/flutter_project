class ResCustomerBilling {
  late Meta meta;
  late List<CustomerList> customerList;
  late TotalData totalData;

  ResCustomerBilling({required this.meta, required this.customerList, required this.totalData});

  ResCustomerBilling.fromJson(Map<String, dynamic> json) {
    meta = (json['meta'] != null ? new Meta.fromJson(json['meta']) : null)!;
    if (json['customer_list'] != null) {
      customerList = <CustomerList>[];
      json['customer_list'].forEach((v) {
        customerList!.add(new CustomerList.fromJson(v));
      });
    }
    totalData = (json['total_data'] != null
        ? new TotalData.fromJson(json['total_data'])
        : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    if (this.customerList != null) {
      data['customer_list'] =
          this.customerList!.map((v) => v.toJson()).toList();
    }
    if (this.totalData != null) {
      data['total_data'] = this.totalData!.toJson();
    }
    return data;
  }
}

class Meta {
  late var totalCustomer;
  late var totalTransaction;
  late var cancelTransaction;
  late var totalPayment;

  Meta(
      {required this.totalCustomer,
      required this.totalTransaction,
      required this.cancelTransaction,
      required this.totalPayment});

  Meta.fromJson(Map<String, dynamic> json) {
    totalCustomer = json['total_customer']??0;
    totalTransaction = json['total_transaction']??0;
    cancelTransaction = json['cancel_transaction']??0;
    totalPayment = json['total_payment']??0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_customer'] = this.totalCustomer;
    data['total_transaction'] = this.totalTransaction;
    data['cancel_transaction'] = this.cancelTransaction;
    data['total_payment'] = this.totalPayment;
    return data;
  }
}

class CustomerList {
  late String custName;
  late var totalPayments;
  late var totalAmount;
  late var totalCanceledChecks;
  late var totalSuccesfulChecks;

  CustomerList(
      {required this.custName,
     required this.totalPayments,
     required this.totalAmount,
     required this.totalCanceledChecks,
     required this.totalSuccesfulChecks});

  CustomerList.fromJson(Map<String, dynamic> json) {
    custName = json['cust_name']??"";
    totalPayments = json['total_payments']??0;
    totalAmount = json['total_amount']??0;
    totalCanceledChecks = json['total_canceled_checks']??0;
    totalSuccesfulChecks = json['total_succesful_checks']??0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cust_name'] = this.custName;
    data['total_payments'] = this.totalPayments;
    data['total_amount'] = this.totalAmount;
    data['total_canceled_checks'] = this.totalCanceledChecks;
    data['total_succesful_checks'] = this.totalSuccesfulChecks;
    return data;
  }
}

class TotalData {
 late var pageNumber;
 late var pageSize;
 late var totalData;
 late var totalPages;

  TotalData({required this.pageNumber, required this.pageSize, required this.totalData, required this.totalPages});

  TotalData.fromJson(Map<String, dynamic> json) {
    pageNumber = json['page_number']??0;
    pageSize = json['page_size']??0;
    totalData = json['total_data']??0;
    totalPages = json['total_pages']??0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page_number'] = this.pageNumber;
    data['page_size'] = this.pageSize;
    data['total_data'] = this.totalData;
    data['total_pages'] = this.totalPages;
    return data;
  }
}
