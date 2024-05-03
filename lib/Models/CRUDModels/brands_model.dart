import 'dart:convert';

BrandModel brandModelFromJson(String str) =>
    BrandModel.fromJson(json.decode(str));

String brandModelToJson(BrandModel data) => json.encode(data.toJson());

class BrandModel {
  String?
      id; // zidna ? maaneha optionnel w zidna na7ina required mel constructeur
  String name;
  //DateTime? createdAt;
  //DateTime? updatedAt;
  int? v;
  List<dynamic> products;

  BrandModel({
    this.id,
    required this.name,
    //this.createdAt,
    //this.updatedAt,
    this.v,
    required this.products,
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) => BrandModel(
        id: json["_id"] ?? "",
        // Check if it's not null, assign an empty string if null
        name: json["name"],
        v: json["__v"],
        products: List<dynamic>.from(json["products"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        //"createdAt": createdAt.toIso8601String(),
        //"updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "products": List<dynamic>.from(products.map((x) => x)),
      };
}
/*import 'dart:convert';

List<UserModel> userModelFromJson(String str) =>
    List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String userModelToJson(List<UserModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel {
  String name;
  String email;
  String password;

  UserModel({
    required this.name,
    required this.email,
    required this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json["name"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "password": password,
      };
}
*/