class ResCheckRoutingNo {
  late String? message;
  late String? institutionStatusCode;
  late String? officeCode;
  late String? newRoutingNumber;
  late String? state;
  late String? city;
  late String? address;
  late String? rn;
  late String? changeDate;
  late String? recordTypeCode;
  late String? customerName;
  late String? telephone;
  late String? dataViewCode;
  late int? code;
  late String? routingNumber;
  late String? zip;

  ResCheckRoutingNo(
      {required this.message,
      required this.institutionStatusCode,
      required this.officeCode,
      required this.newRoutingNumber,
      required this.state,
      required this.city,
      required this.address,
      required this.rn,
      required this.changeDate,
      required this.recordTypeCode,
      required this.customerName,
      required this.telephone,
      required this.dataViewCode,
      required this.code,
      required this.routingNumber,
      required this.zip});

  ResCheckRoutingNo.fromJson(Map<String, dynamic> json) {
    message = json['message'] ?? "";
    institutionStatusCode = json['institution_status_code'] ?? "";
    officeCode = json['office_code'] ?? "";
    newRoutingNumber = json['new_routing_number'] ?? "";
    state = json['state'] ?? "";
    city = json['city'] ?? "";
    address = json['address'] ?? "";
    rn = json['rn'] ?? "";
    changeDate = json['change_date'] ?? "";
    recordTypeCode = json['record_type_code'] ?? "";
    customerName = json['customer_name'] ?? "";
    telephone = json['telephone'] ?? "";
    dataViewCode = json['data_view_code'] ?? "";
    code = (json['code'] is String)
        ? int.tryParse(json['code'])
        : json['code'] as int?;
    routingNumber = json['routing_number'] ?? "";
    zip = json['zip'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['institution_status_code'] = this.institutionStatusCode;
    data['office_code'] = this.officeCode;
    data['new_routing_number'] = this.newRoutingNumber;
    data['state'] = this.state;
    data['city'] = this.city;
    data['address'] = this.address;
    data['rn'] = this.rn;
    data['change_date'] = this.changeDate;
    data['record_type_code'] = this.recordTypeCode;
    data['customer_name'] = this.customerName;
    data['telephone'] = this.telephone;
    data['data_view_code'] = this.dataViewCode;
    data['code'] = this.code;
    data['routing_number'] = this.routingNumber;
    data['zip'] = this.zip;
    return data;
  }
}
