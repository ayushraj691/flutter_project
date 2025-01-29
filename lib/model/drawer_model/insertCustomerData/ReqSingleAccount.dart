class ReqSingleAccount {
  late bool? primary;
  late String? accountName;
  late String? accountNumber;
  late String? routingNumber;
  late String? apartment;
  late String? address;
  late String? country;
  late String? city;
  late String? state;
  late String? postalCode;

  ReqSingleAccount(
      {required this.primary,
      required this.accountName,
      required this.accountNumber,
      required this.routingNumber,
      required this.apartment,
      required this.address,
      required this.country,
      required this.city,
      required this.state,
      required this.postalCode});

  ReqSingleAccount.fromJson(Map<String, dynamic> json) {
    primary = json['primary'] ?? false;
    accountName = json['account_name'] ?? "";
    accountNumber = json['account_number'] ?? "";
    routingNumber = json['routing_number'] ?? "";
    apartment = json['apartment'] ?? "";
    address = json['address'] ?? "";
    country = json['country'] ?? "";
    city = json['city'] ?? "";
    state = json['state'] ?? "";
    postalCode = json['postal_code'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['primary'] = this.primary;
    data['account_name'] = this.accountName;
    data['account_number'] = this.accountNumber;
    data['routing_number'] = this.routingNumber;
    data['apartment'] = this.apartment;
    data['address'] = this.address;
    data['country'] = this.country;
    data['city'] = this.city;
    data['state'] = this.state;
    data['postal_code'] = this.postalCode;
    return data;
  }
}
