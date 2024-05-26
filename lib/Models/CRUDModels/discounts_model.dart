class DiscountsModel {
  String id;
  double value;
  List<String> saleProducts;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  DiscountsModel({
    required this.id,
    required this.value,
    required this.saleProducts,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });
  factory DiscountsModel.fromJson(Map<String, dynamic> json) => DiscountsModel(
        id: json["_id"],
        value: json["value"],
        saleProducts: List<String>.from(json["sale_products"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "value": value,
        "sale_products": List<dynamic>.from(saleProducts.map((x) => x)),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
