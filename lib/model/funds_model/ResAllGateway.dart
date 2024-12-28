class ResAllGateway {
  late String sId;
  late String name;
  late String details;
  late bool isDeleted;
  late String createdOn;
  late String lastUpdated;
  late int iV;

  ResAllGateway(
      {required this.sId,
      required this.name,
      required this.details,
      required this.isDeleted,
      required this.createdOn,
      required this.lastUpdated,
      required this.iV});

  ResAllGateway.fromJson(Map<String, dynamic> json) {
    sId = json['_id']??"";
    name = json['name']??"";
    details = json['details']??"";
    isDeleted = json['is_deleted']??false;
    createdOn = json['created_on']??"";
    lastUpdated = json['last_updated']??"";
    iV = json['__v']??0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['details'] = this.details;
    data['is_deleted'] = this.isDeleted;
    data['created_on'] = this.createdOn;
    data['last_updated'] = this.lastUpdated;
    data['__v'] = this.iV;
    return data;
  }
}
