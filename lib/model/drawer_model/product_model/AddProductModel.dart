class AddProductModel {
  late String productName;
  late String qantity;
  late String price;
  late String totalPrice;
  late String productId;

  AddProductModel(
      {required this.productName,
      required this.qantity,
      required this.price,
      required this.totalPrice,
      required this.productId});

  AddProductModel.fromJson(Map<String, dynamic> json) {
    productName = json['product_name'];
    qantity = json['qantity'];
    price = json['price'];
    totalPrice = json['total_price'];
    productId = json['product_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_name'] = this.productName;
    data['qantity'] = this.qantity;
    data['price'] = this.price;
    data['total_price'] = this.totalPrice;
    data['product_id'] = this.productId;
    return data;
  }
}
