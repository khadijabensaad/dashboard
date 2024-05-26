import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String id;
  String username;
  String email;
  String password;
  bool activated;
  String image;
  String role;
  // List<dynamic> favorites;
  //DateTime createdAt;
  // DateTime updatedAt;
  int v;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.activated,
    required this.image,
    required this.role,
    //    required this.favorites,
    //   required this.createdAt,
    // required this.updatedAt,
    required this.v,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["_id"],
        username: json["username"],
        email: json["email"],
        password: json["password"],
        activated: json["activated"],
        image: json["image"],
        role: json["role"],
        //  favorites: List<dynamic>.from(json["favorites"].map((x) => x)),
        //  createdAt: DateTime.parse(json["createdAt"]),
        // updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "email": email,
        "password": password,
        "activated": activated,
        "image": image,
        "role": role,
        // "favorites": List<dynamic>.from(favorites.map((x) => x)),
        //    "createdAt": createdAt.toIso8601String(),
        //   "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
