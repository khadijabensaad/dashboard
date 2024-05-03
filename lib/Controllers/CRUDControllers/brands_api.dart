import 'dart:convert';
import 'package:admintest/Models/CRUDModels/brands_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class BrandApiCall extends GetxController {
  //
  List<BrandModel> brands = <BrandModel>[].obs;
  @override
  void onInit() {
    // Initialize the controller
    super.onInit();
    // Fetch data when the controller is initialized
    getAllBrands();
  }

  Future<List<BrandModel>> getAllBrands() async {
    List<BrandModel> brands = [];
    const String url = "http://192.168.0.179:5000/brands/getAllBrands";
    final http.Response resp = await http.get(Uri.parse(url));
    if (resp.statusCode == 200) {
      // Decode the JSON response
      List<dynamic> jsonResponse = json.decode(resp.body);
      // Iterate over the list and create ProductModel objects
      brands = jsonResponse.map((item) => BrandModel.fromJson(item)).toList();
      print("success");
      print(resp.body);
    } else {
      print("failed: ${resp.statusCode}");
    }
    return brands;
  }

  Future<void> addBrand(BrandModel brand) async {
    try {
      const String url = "http://192.168.0.179:5000/brands/addBrand";
      //var headers = {'Content-Type': 'application/json; charset=UTF-8'};
      final resp = await http.post(Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          //khater l'ajout de user
          body: jsonEncode(brand.toJson()));

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

  Future<void> updateBrand(BrandModel brand, String id) async {
    try {
      String url = "http://192.168.0.179:5000/brands/updateBrand/${id}";
      //var headers = {'Content-Type': 'application/json; charset=UTF-8'};
      final resp = await http.put(Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          //khater l'ajout de user
          body: jsonEncode(brand.toJson()));

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

  Future<void> deleteBrand(String id) async {
    try {
      //na7ina il const khater l'id variable
      String url = "http://192.168.0.179:5000/brands/deleteBrand/${id}";
      final resp = await http.delete(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );
      if (resp.statusCode == 200) {
        print("succes");
        //
        update();
      } else {
        print("failed");
      }
    } catch (e) {
      print("echec: ${e}");
    }
  }

  void removeBrand(BrandModel brand) {
    brands.removeWhere((element) => element.id == brand.id);
    update(); // Notify listeners about the change
  }
}
/*import 'dart:convert';
import 'package:call_api/Models/user_model.dart';
import 'package:http/http.dart' as http;

class UserApiCall {
  Future<void> postUser(UserModel user) async {
    try {
      const url = "http://192.168.0.179:5000/users/addUsers";
      final resp = await http.post(Uri.parse(url));
      //add content type precaution for new errors
      headers:
      <String, String>{'Content_Type': 'application/json; charset= UTF_8'};
      //bch nrajaa tojson lil body
      body:
      jsonEncode(user.toJson());
      if (resp.statusCode == 200) {
        print("success");
      } else {
        //pour savoir ou prob?
        print("echec${resp.statusCode}");
      }
    } catch (error) {
      print("erreur: ${error}");
    }
  }
}
*/