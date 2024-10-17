class ReqAddcustomerDetails {
 late String description;
 late String mobile;
 late String email;
 late String custName;
 late List<Items> items;

  ReqAddcustomerDetails(
      {required this.description, required this.mobile, required this.email, required this.custName, required this.items});

  ReqAddcustomerDetails.fromJson(Map<String, dynamic> json) {
    description = json['description']??"";
    mobile = json['mobile']??"";
    email = json['email']??"";
    custName = json['cust_name']??"";
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['cust_name'] = this.custName;
    data['items'] = this.items.map((v) => v.toJson()).toList();
      return data;
  }
}

class Items {
 late bool primary;
 late String accountName;
 late String accountNumber;
 late String confirmAccountNumber;
 late String routingNumber;
 late String address;
 late String apartment;
 late String city;
 late String country;
 late String state;
 late String postalCode;

  Items(
      {required this.primary,
       required this.accountName,
       required this.accountNumber,
       required this.confirmAccountNumber,
       required this.routingNumber,
       required this.address,
       required this.apartment,
       required this.city,
       required this.country,
       required this.state,
       required this.postalCode});

  Items.fromJson(Map<String, dynamic> json) {
    primary = json['primary']??"";
    accountName = json['account_name']??"";
    accountNumber = json['account_number']??"";
    confirmAccountNumber = json['confirm_account_number']??"";
    routingNumber = json['routing_number']??"";
    address = json['address']??"";
    apartment = json['apartment']??"";
    city = json['city']??"";
    country = json['country']??"";
    state = json['state']??"";
    postalCode = json['postal_code']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['primary'] = this.primary;
    data['account_name'] = this.accountName;
    data['account_number'] = this.accountNumber;
    data['confirm_account_number'] = this.confirmAccountNumber;
    data['routing_number'] = this.routingNumber;
    data['address'] = this.address;
    data['apartment'] = this.apartment;
    data['city'] = this.city;
    data['country'] = this.country;
    data['state'] = this.state;
    data['postal_code'] = this.postalCode;
    return data;
  }
}