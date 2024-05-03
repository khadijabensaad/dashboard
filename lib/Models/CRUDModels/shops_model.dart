import 'dart:convert';

ShopModel ShopModelFromJson(String str) => ShopModel.fromJson(json.decode(str));

String ShopModelToJson(ShopModel data) => json.encode(data.toJson());

class ShopModel {
  Coordinates coordinates;
  List<dynamic> products;
  String id;
  String name;
  //DateTime createdAt;
  //DateTime updatedAt;
  int v;
  String city;
  String region;

  ShopModel({
    required this.coordinates,
    required this.products,
    required this.id,
    required this.name,
    //required this.createdAt,
    //required this.updatedAt,
    required this.v,
    required this.city,
    required this.region,
  });

  factory ShopModel.fromJson(Map<String, dynamic> json) => ShopModel(
        coordinates: Coordinates.fromJson(json["coordinates"]),
        products: List<dynamic>.from(json["products"].map((x) => x)),
        id: json["_id"],
        name: json["name"],
        //   createdAt: DateTime.parse(json["createdAt"]),
        // updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        city: json["city"],
        region: json["region"],
      );

  Map<String, dynamic> toJson() => {
        "coordinates": coordinates.toJson(),
        "products": List<dynamic>.from(products.map((x) => x)),
        "_id": id,
        "name": name,
        // "createdAt": createdAt.toIso8601String(),
        // "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "city": city,
        "region": region,
      };
}

class Coordinates {
  double longitude;
  double latitude;

  Coordinates({
    required this.longitude,
    required this.latitude,
  });

  factory Coordinates.fromJson(Map<String, dynamic> json) => Coordinates(
        longitude: json["longitude"].toDouble(),
        latitude: json["latitude"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "longitude": longitude,
        "latitude": latitude,
      };
}
