class ReqCheckRoutingNo {
  late String? routingNumber;

  ReqCheckRoutingNo({required this.routingNumber});

  ReqCheckRoutingNo.fromJson(Map<String, dynamic> json) {
    routingNumber = json['routing_number']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['routing_number'] = this.routingNumber;
    return data;
  }
}