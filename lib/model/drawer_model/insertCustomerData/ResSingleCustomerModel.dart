class ResSingleData {
 late Info info;
 late String sId;
 late String businessId;
 late List<BankId> bankId;
 late bool isDeleted;
 late String createdOn;
 late String lastUpdated;
 late int iV;

  ResSingleData(
      {required this.info,
       required this.sId,
       required this.businessId,
       required this.bankId,
       required this.isDeleted,
       required this.createdOn,
       required this.lastUpdated,
       required this.iV});

  ResSingleData.fromJson(Map<String, dynamic> json) {
    info = (json['info'] != null ? new Info.fromJson(json['info']) : null)!;
    sId = json['_id']??"";
    businessId = json['business_id']??"";
    if (json['bank_id'] != null) {
      bankId = <BankId>[];
      json['bank_id'].forEach((v) {
        bankId.add(new BankId.fromJson(v));
      });
    }
    isDeleted = json['is_deleted']??"";
    createdOn = json['created_on']??"";
    lastUpdated = json['last_updated']??"";
    iV = json['__v']??0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.info != null) {
      data['info'] = this.info.toJson();
    }
    data['_id'] = this.sId;
    data['business_id'] = this.businessId;
    if (this.bankId != null) {
      data['bank_id'] = this.bankId.map((v) => v.toJson()).toList();
    }
    data['is_deleted'] = this.isDeleted;
    data['created_on'] = this.createdOn;
    data['last_updated'] = this.lastUpdated;
    data['__v'] = this.iV;
    return data;
  }
}

class Info {
 late String custName;
 late String description;
 late String mobile;
 late String email;

  Info({required this.custName, required this.description, required this.mobile, required this.email});

  Info.fromJson(Map<String, dynamic> json) {
    custName = json['cust_name']??"";
    description = json['description']??"";
    mobile = json['mobile']??"";
    email = json['email']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cust_name'] = this.custName;
    data['description'] = this.description;
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
 late String bankState;
 late bool status;
 late bool lastPaidstatus;

  BankId(
      {required this.location,
       required this.sId,
       required this.primary,
       required this.accountName,
       required this.accountNumber,
       required this.routingNumber,
       required this.bankName,
       required this.bankAddress,
       required this.bankState,
       required this.status,
       required this.lastPaidstatus});

  BankId.fromJson(Map<String, dynamic> json) {
    location = (json['location'] != null
        ? new Location.fromJson(json['location'])
        : null)!;
    sId = json['_id']??"";
    primary = json['primary']??"";
    accountName = json['account_name']??"";
    accountNumber = json['account_number']??"";
    routingNumber = json['routing_number']??"";
    bankName = json['bank_name']??"";
    bankAddress = json['bank_address']??"";
    bankState = json['bank_state']??"";
    status = json['status']??"";
    lastPaidstatus = json['last_paidstatus']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.location != null) {
      data['location'] = this.location.toJson();
    }
    data['_id'] = this.sId;
    data['primary'] = this.primary;
    data['account_name'] = this.accountName;
    data['account_number'] = this.accountNumber;
    data['routing_number'] = this.routingNumber;
    data['bank_name'] = this.bankName;
    data['bank_address'] = this.bankAddress;
    data['bank_state'] = this.bankState;
    data['status'] = this.status;
    data['last_paidstatus'] = this.lastPaidstatus;
    return data;
  }
}

class Location {
 late String apartment;
 late String address;
 late String country;
 late String city;
 late String state;
 late String postalCode;

  Location(
      {required this.apartment,
       required this.address,
       required this.country,
       required this.city,
       required this.state,
       required this.postalCode});

  Location.fromJson(Map<String, dynamic> json) {
    apartment = json['apartment']??"";
    address = json['address']??"";
    country = json['country']??"";
    city = json['city']??"";
    state = json['state']??"";
    postalCode = json['postal_code']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['apartment'] = this.apartment;
    data['address'] = this.address;
    data['country'] = this.country;
    data['city'] = this.city;
    data['state'] = this.state;
    data['postal_code'] = this.postalCode;
    return data;
  }
}