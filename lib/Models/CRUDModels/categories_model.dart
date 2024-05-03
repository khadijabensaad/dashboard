class CategoryModel {
  String id;
  String name;
  int? v;
  List<dynamic>? products; // Change to List<dynamic>?

  CategoryModel({
    required this.id,
    required this.name,
    this.v,
    this.products, // Update to accept null
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["_id"],
        name: json["name"],
        v: json["__v"],
        products: json.containsKey("products")
            ? List<dynamic>.from(
                json["products"].map((x) => x)) // Adjust as needed
            : null, // Handle missing products field
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "__v": v,
        "products": products,
      };
}
