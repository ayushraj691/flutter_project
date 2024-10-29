class ResCustomerList {
  final Info info;
  final String sId;
  final String businessId;
  final List<BankId> bankId;
  final bool isDeleted;
  final String createdOn;
  final String lastUpdated;
  final int iV;

  ResCustomerList({
    required this.info,
    required this.sId,
    required this.businessId,
    required this.bankId,
    required this.isDeleted,
    required this.createdOn,
    required this.lastUpdated,
    required this.iV,
  });

  factory ResCustomerList.fromJson(Map<String, dynamic> json) {
    return ResCustomerList(
      info: Info.fromJson(json['info']), // Make sure Info class has a proper fromJson method
      sId: json['_id'] ?? "",
      businessId: json['business_id'] ?? "",
      bankId: (json['bank_id'] as List)
          .map((i) => BankId.fromJson(i)) // Make sure BankId class has a proper fromJson method
          .toList(),
      isDeleted: json['is_deleted'] ?? false, // Assuming is_deleted is of type bool
      createdOn: json['created_on'] ?? "",
      lastUpdated: json['last_updated'] ?? "",
      iV: json['__v'] ?? 0, // If __v is an integer, set a default value of 0
    );
  }
}

// Define your Info class with a fromJson method
class Info {
  final String custName;
  final String description;
  final String mobile;
  final String email;

  Info({
    required this.custName,
    required this.description,
    required this.mobile,
    required this.email,
  });

  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(
      custName: json['cust_name'] ?? "",
      description: json['description'] ?? "",
      mobile: json['mobile'] ?? "",
      email: json['email'] ?? "",
    );
  }
}

// Define your BankId class with a fromJson method
class BankId {
  final String id;
  final String accountNumber;

  BankId({
    required this.id,
    required this.accountNumber,
  });

  factory BankId.fromJson(Map<String, dynamic> json) {
    return BankId(
      id: json['_id'] ?? "",
      accountNumber: json['account_number'] ?? "",
    );
  }
}
