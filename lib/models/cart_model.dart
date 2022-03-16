class CartModel {
  String? userId;
  String? date;
  Products? products;

  CartModel({required this.userId,required this.date,required this.products});

  CartModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    date = json['date'];
    if (json['products'] != null) {
      products =Products.fromJson(json['products']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['userId'] = userId;
    data['date'] = date;
    data['products']=products!.toJson();
    return data;
  }
}

class Products {
  int? productId;
  int? quantity;

  Products({this.productId, this.quantity});

  Products.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productId'] = productId;
    data['quantity'] = quantity;
    return data;
  }
}