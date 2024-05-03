import 'package:admintest/Models/CRUDModels/shops_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ShopApiCall {
  Future<List<ShopModel>> getAllShops() async {
    List<ShopModel> shops = [];
    const String url = "http://192.168.0.179:5000/shops/getAllShops";
    final http.Response resp = await http.get(Uri.parse(url));
    if (resp.statusCode == 200) {
      // Decode the JSON response
      List<dynamic> jsonResponse = json.decode(resp.body);
      // Iterate over the list and create ProductModel objects
      shops = jsonResponse.map((item) => ShopModel.fromJson(item)).toList();
      print("success");
      print(resp.body);
    } else {
      print("failed: ${resp.statusCode}");
    }
    return shops;
  }

  Future<dynamic> getShopByName(String name) async {
    late ShopModel shop;
    try {
      String url = "http://192.168.0.179:5000/shops/getShopByName?name=${name}";
      final http.Response resp = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );
      if (resp.statusCode == 200) {
        dynamic jsonResponse = json.decode(resp.body);
        if (jsonResponse is List && jsonResponse.length > 0) {
          shop = ShopModel.fromJson(jsonResponse[0]);
          print("succes getShopByName");
          print(shop.coordinates.latitude);
          return shop;
        }
      } else {
        print("failure: ${resp.statusCode}");
        throw Exception('Failed to get shop: ${resp.statusCode}');
      }
    } catch (error) {
      print("$error");
      return null;
    }
  }

  Future<void> addShop(ShopModel shop) async {
    try {
      const String url = "http://192.168.0.179:5000/shops/addShop";
      //var headers = {'Content-Type': 'application/json; charset=UTF-8'};
      final resp = await http.post(Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: jsonEncode(shop.toJson()));

      if (resp.statusCode == 200 || resp.statusCode == 201) {
        print("success");
      } else {
        print("echec: ${resp.statusCode}");
      }
    } catch (error) {
      print("erreur: ${error}");
    }
  }

  Future<void> updateShop(ShopModel shop, String id) async {
    try {
      String url = "http://localhost:5000/shops/updateShop/${id}";
      //var headers = {'Content-Type': 'application/json; charset=UTF-8'};
      final resp = await http.put(Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: jsonEncode(shop.toJson()));
      if (resp.statusCode == 200 || resp.statusCode == 201) {
        print("success");
      } else {
        print("echec: ${resp.statusCode}");
      }
    } catch (error) {
      print("erreur: ${error}");
    }
  }

  Future<void> deleteShop(String id) async {
    try {
      //na7ina il const khater l'id variable
      String url = "http://192.168.0.179:5000/shops/deleteShop/${id}";
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
  }
}
