class ProductFilter{

  List<String>? size;
  String? colors;
  String? sortBy;
  String? sortOrder;
  String? name;
  String? region;

  ProductFilter({
      this.size,
     this.colors,
     this.sortBy,
     this.sortOrder,
     this.name,
     this.region,
    });

  Map<String, dynamic> toJson() => {
        
        "name": name,
        "colors": colors,
        "sortBy": sortBy,
        "sortOrder": sortOrder,
        "region": region,
        "size": List<dynamic>.from(size!.map((x) => x)),
        
    };
}