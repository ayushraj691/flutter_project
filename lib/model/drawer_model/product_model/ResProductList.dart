class ResProductList {
  late String sId;
  late String businessId;
  late String proName;
  late String proId;
  late String description;
  late String price;
  late String priceValue;
  late String image;
  late bool isDeleted;
  late String createdOn;
  late String lastUpdated;
  late int iV;

  ResProductList(
      {required this.sId,
      required this.businessId,
      required this.proName,
      required this.proId,
      required this.description,
      required this.price,
      required this.priceValue,
      required this.image,
      required this.isDeleted,
      required this.createdOn,
      required this.lastUpdated,
      required this.iV});

  ResProductList.fromJson(Map<String, dynamic> json) {
    sId = json['_id']??"";
    businessId = json['business_id']??"";
    proName = json['pro_name']??"";
    proId = json['pro_id']??"";
    description = json['description']??"";
    price = json['price']??"";
    priceValue = json['price_value']??"";
    image = json['image']??"";
    isDeleted = json['is_deleted']??false;
    createdOn = json['created_on']??"";
    lastUpdated = json['last_updated']??"";
    iV = json['__v']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['business_id'] = this.businessId;
    data['pro_name'] = this.proName;
    data['pro_id'] = this.proId;
    data['description'] = this.description;
    data['price'] = this.price;
    data['price_value'] = this.priceValue;
    data['image'] = this.image;
    data['is_deleted'] = this.isDeleted;
    data['created_on'] = this.createdOn;
    data['last_updated'] = this.lastUpdated;
    data['__v'] = this.iV;
    return data;
  }
}
