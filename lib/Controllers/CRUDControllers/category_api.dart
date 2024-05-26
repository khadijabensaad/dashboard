import 'package:admintest/Models/CRUDModels/categories_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CategoryApiCall {
  Future<List<CategoryModel>> getAllCategories() async {
    List<CategoryModel> categories = [];
    const String url = "http://192.168.1.113:5000/categories/getAllCategories";
    final http.Response resp = await http.get(Uri.parse(url));
    if (resp.statusCode == 200) {
      // Decode the JSON response
      List<dynamic> jsonResponse = json.decode(resp.body);
      // Iterate over the list and create ProductModel objects
      categories =
          jsonResponse.map((item) => CategoryModel.fromJson(item)).toList();
      print("success");
      print(resp.body);
    } else {
      print("failed: ${resp.statusCode}");
    }
    return categories;
  }
/*
  Future<void> addCategory(CategoryModel category) async {
    try {
      const String url = "http://192.168.1.113:5000/categories/addCategory";
      final http.Response resp = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(category.toJson()),
      );

      if (resp.statusCode == 200 || resp.statusCode == 201) {
        print("Success: ${resp.body}");
      } else {
        print("Failed with status code ${resp.statusCode}: ${resp.body}");
      }
    } catch (error) {
      print("Error: $error");
    }
  }

  Future<void> updateCategory(CategoryModel category, String id) async {
    try {
      String url =
          "http://192.168.1.113:5000/categories/updateCategoryName/${id}";
      final http.Response resp = await http.put(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(category.toJson()),
      );

      if (resp.statusCode == 200 || resp.statusCode == 201) {
        print("Success: ${resp.body}");
      } else {
        print("Failed with status code ${resp.statusCode}: ${resp.body}");
      }
    } catch (error) {
      print("Error: $error");
    }
  }

  Future<void> deleteCategory(String id) async {
    try {
      //na7ina il const khater l'id variable
      String url = "http://192.168.1.113:5000/categories/deleteCategory/${id}";
      final resp = await http.delete(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );
      if (resp.statusCode == 200) {
        print("succes");
      } else {
        print("failed");
      }
    } catch (e) {
      print("echec: ${e}");
    }
  }*/
}
