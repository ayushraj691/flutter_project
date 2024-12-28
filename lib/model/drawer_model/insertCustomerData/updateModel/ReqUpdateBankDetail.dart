class ReqUpdateBankDetail {
 late String accountName;
 late String accountNumber;
 late String address;
 late String apartment;
 late String city;
 late String country;
 late String custId;
 late String postalCode;
 late bool primary;
 late String routingNumber;
 late String state;

  ReqUpdateBankDetail(
      {required this.accountName,
      required this.accountNumber,
      required this.address,
      required this.apartment,
      required this.city,
      required this.country,
      required this.custId,
      required this.postalCode,
      required this.primary,
      required this.routingNumber,
      required this.state});

  ReqUpdateBankDetail.fromJson(Map<String, dynamic> json) {
    accountName = json['account_name']??"";
    accountNumber = json['account_number']??"";
    address = json['address']??"";
    apartment = json['apartment']??"";
    city = json['city']??"";
    country = json['country']??"";
    custId = json['cust_id']??"";
    postalCode = json['postal_code']??"";
    primary = json['primary']??"";
    routingNumber = json['routing_number']??"";
    state = json['state']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['account_name'] = this.accountName;
    data['account_number'] = this.accountNumber;
    data['address'] = this.address;
    data['apartment'] = this.apartment;
    data['city'] = this.city;
    data['country'] = this.country;
    data['cust_id'] = this.custId;
    data['postal_code'] = this.postalCode;
    data['primary'] = this.primary;
    data['routing_number'] = this.routingNumber;
    data['state'] = this.state;
    return data;
  }
}
