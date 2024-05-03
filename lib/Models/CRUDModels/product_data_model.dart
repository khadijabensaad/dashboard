import 'dart:convert';

ProductModel productDModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  String id;
  String name;
  int price;
  double rating;
  int barcode;
  String thumbnail;
  List<dynamic> images;
  List<String> colors;
  String description;
  List<String> size;
  String brand;
  List<String> shops;
  List<String> category;
  //DateTime createdAt;
  //DateTime updatedAt;
  int v;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.rating,
    required this.barcode,
    required this.thumbnail,
    required this.images,
    required this.colors,
    required this.description,
    required this.size,
    required this.brand,
    required this.shops,
    required this.category,
    // required this.createdAt,
    // required this.updatedAt,
    required this.v,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["_id"],
        name: json["name"],
        price: json["price"],
        rating: json["rating"]?.toDouble(),
        barcode: json["barcode"],
        thumbnail: json["thumbnail"],
        images: List<dynamic>.from(json["images"].map((x) => x)),
        colors: List<String>.from(json["colors"].map((x) => x)),
        description: json["description"],
        size: List<String>.from(json["size"].map((x) => x)),
        brand: json["brand"],
        shops: List<String>.from(json["shops"].map((x) => x)),
        category: List<String>.from(json["category"].map((x) => x)),
        //createdAt: DateTime.parse(json["createdAt"]),
        //  updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "price": price,
        "rating": rating,
        "barcode": barcode,
        "thumbnail": thumbnail,
        "images": List<dynamic>.from(images.map((x) => x)),
        "colors": List<dynamic>.from(colors.map((x) => x)),
        "description": description,
        "size": List<dynamic>.from(size.map((x) => x)),
        "brand": brand,
        "shops": List<dynamic>.from(shops.map((x) => x)),
        "category": List<dynamic>.from(category.map((x) => x)),
        // "createdAt": createdAt.toIso8601String(),
        // "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}



/*madame
import 'dart:convert';

List<ProductDataModel> productDataModelFromJson(String str) =>
    List<ProductDataModel>.from(
        json.decode(str).map((x) => ProductDataModel.fromJson(x)));

String productDataModelToJson(List<ProductDataModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductDataModel {
  int userId;
  int id;
  String title;
  String body;

  ProductDataModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });
//getData from back
//from:converts from json _> dart
  factory ProductDataModel.fromJson(Map<String, dynamic> json) =>
      ProductDataModel(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
      );
//put data from front to back
//to:converts from object Model _>
  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
      };
}

// To parse this JSON data, do
//
//     final productDataModel = productDataModelFromJson(jsonString);
*/
/*import 'dart:convert';

List<ProductDataModel> productDataModelFromJson(String str) =>
    List<ProductDataModel>.from(
        json.decode(str).map((x) => ProductDataModel.fromJson(x)));

String productDataModelToJson(List<ProductDataModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductDataModel {
  int id;
  String title;
  String description;
  dynamic price;
  dynamic discountPercentage;
  dynamic rating;
  int stock;
  String brand;
  dynamic category;
  dynamic thumbnail;
  List<dynamic> images;

  ProductDataModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.category,
    required this.thumbnail,
    required this.images,
  });

  factory ProductDataModel.fromJson(Map<String, dynamic> json) {
    return ProductDataModel(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      price: json["price"],
      discountPercentage: json["discountPercentage"]?.toDouble(),
      rating: json["rating"]?.toDouble(),
      stock: json["stock"],
      brand: json["brand"],
      category: json["category"],
      thumbnail: json["thumbnail"],
      images: List<dynamic>.from(json["images"].map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "price": price,
        "discountPercentage": discountPercentage,
        "rating": rating,
        "stock": stock,
        "brand": brand,
        "category": category,
        "thumbnail": thumbnail,
        "images": List<dynamic>.from(images.map((x) => x)),
      };
}
*/