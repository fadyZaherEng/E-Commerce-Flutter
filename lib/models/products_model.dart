class ModelProducts{
  List<ProductsModel>products=[];
  ModelProducts.fromjson(List<dynamic>json)
  {
    for(var val in json)
      {
        products.add(ProductsModel.fromJson(val));
      }
  }
}
class ProductsModel {
  dynamic id;
  String? title;
  dynamic price;
  String? description;
  String? category;
  String? image;
  Rating? rating;

  ProductsModel(
      {this.id,
        this.title,
        this.price,
        this.description,
        this.category,
        this.image,
        this.rating});

  ProductsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    description = json['description'];
    category = json['category'];
    image = json['image'];
    rating =
    json['rating'] != null ?  Rating.fromJson(json['rating']) : null;
  }
}

class Rating {
  dynamic rate;
  dynamic count;

  Rating({this.rate, this.count});

  Rating.fromJson(Map<String, dynamic> json) {
    rate = json['rate'];
    count = json['count'];
  }
}