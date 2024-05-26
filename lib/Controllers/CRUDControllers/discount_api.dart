import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../Models/CRUDModels/discounts_model.dart';

class DiscountApiCall extends GetxController {
  //
  List<DiscountsModel> discounts = <DiscountsModel>[].obs;
  @override
  void onInit() {
    // Initialize the controller
    super.onInit();
    // Fetch data when the controller is initialized
    getAllDiscounts();
  }

  Future<List<DiscountsModel>> getAllDiscounts() async {
    List<DiscountsModel> discounts = [];
    const String url = "http://192.168.1.113:5000/discounts/getAllDiscounts";
    final http.Response resp = await http.get(Uri.parse(url));
    if (resp.statusCode == 200) {
      // Decode the JSON response
      List<dynamic> jsonResponse = json.decode(resp.body);
      // Iterate over the list and create ProductModel objects
      discounts =
          jsonResponse.map((item) => DiscountsModel.fromJson(item)).toList();
      print("success");
      print(resp.body);
    } else {
      print("failed: ${resp.statusCode}");
    }
    return discounts;
  }

  Future<void> addBrand(DiscountsModel discount) async {
    try {
      const String url = "http://192.168.1.113:5000/discounts/addDiscount";
      //var headers = {'Content-Type': 'application/json; charset=UTF-8'};
      final resp = await http.post(Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          //khater l'ajout de user
          body: jsonEncode(discount.toJson()));

      if (resp.statusCode == 200 || resp.statusCode == 201) {
        print("success");
        //
        update();
      } else {
        print("echec: ${resp.statusCode}");
      }
    } catch (error) {
      print("erreur: ${error}");
    }
  }

  Future<void> updateBrand(DiscountsModel discount, String id) async {
    try {
      String url = "hhttp://192.168.1.113:5000/discounts/updateBrand/${id}";
      //var headers = {'Content-Type': 'application/json; charset=UTF-8'};
      final resp = await http.put(Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          //khater l'ajout de user
          body: jsonEncode(discount.toJson()));

      if (resp.statusCode == 200 || resp.statusCode == 201) {
        print("success");
        //
        update();
      } else {
        print("echec: ${resp.statusCode}");
      }
    } catch (error) {
      print("erreur: ${error}");
    }
  }

  Future<void> deleteDiscount(String id) async {
    try {
      //na7ina il const khater l'id variable
      String url = "http://192.168.1.113:5000/discounts/deleteBrand/${id}";
      final resp = await http.delete(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );
      if (resp.statusCode == 200) {
        print("succes discount deleted");
        //
        update();
      } else {
        print("failed");
      }
    } catch (e) {
      print("echec: ${e}");
    }
  }

  void removeDiscount(DiscountsModel discount) {
    discounts.removeWhere((element) => element.id == discount.id);
    update(); // Notify listeners about the change
  }
}
