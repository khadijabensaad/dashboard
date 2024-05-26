class CategoryModel {
  String id;
  String name;
  int? v;
  List<dynamic>? products;
    DateTime createdAt;
  DateTime updatedAt;
   // Change to List<dynamic>?

  CategoryModel({
    required this.id,
    required this.name,
      required this.createdAt,
    required this.updatedAt,
    this.v,
    this.products,
     // Update to accept null
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["_id"],
        name: json["name"],
              createdAt: DateTime.parse(json["createdAt"]),
         updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        products: json.containsKey("products")
            ? List<dynamic>.from(
                json["products"].map((x) => x)) // Adjust as needed
            : null, // Handle missing products field
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
           "createdAt": createdAt.toIso8601String(),
         "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "products": products,
      };
}
