import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Models/CRUDModels/user_model.dart';

class UserCallAPi {
  late SharedPreferences prefs;

  AuthCallAPi() {
    initSharedPref(); // Call initSharedPref in the constructor
  }

  Future<void> initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<List<UserModel>> getAllUsers() async {
    List<UserModel> brands = [];
    const String url = "http://192.168.1.113:5000/auth/getAllUsers";
    final http.Response resp = await http.get(Uri.parse(url));
    if (resp.statusCode == 200) {
      // Decode the JSON response
      List<dynamic> jsonResponse = json.decode(resp.body);
      // Iterate over the list and create ProductModel objects
      brands = jsonResponse.map((item) => UserModel.fromJson(item)).toList();
      print("success de getAllUsers");
      print(resp.body);
    } else {
      print("failed: ${resp.statusCode}");
    }
    return brands;
  }

  Future<UserModel> getUserById(String identifier) async {
    UserModel user;
    try {
      String url = "http://192.168.1.113:5000/auth/getUser/${identifier}";
      final http.Response resp = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );
      if (resp.statusCode == 200) {
        dynamic jsonResponse = json.decode(resp.body);
        user = UserModel.fromJson(jsonResponse);
        print("succes getUserById");
        return user;
      } else {
        print("failure: ${resp.statusCode}");
      }
    } catch (error) {
      print("$error");
      throw Exception('Request failed .. $error');
    }
    throw Exception('Request failed.');
  }

  Future<void> deleteUser(String id) async {
    try {
      //na7ina il const khater l'id variable
      String url = "http://192.168.1.113:5000/auth//deleteUser/${id}";
      final resp = await http.delete(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );
      if (resp.statusCode == 200) {
        print("succes User deleted");
      } else {
        print("failed");
      }
    } catch (e) {
      print("echec: ${e}");
    }
  }

  Future<void> deactivate(String id) async {
    final url =
        Uri.parse('http://192.168.1.113:5000/auth//desactivateAccount/${id}');

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
    );

    if (response.statusCode == 200) {
      // If the server returns an OK response, parse the JSON
      print('Deactivation successful');
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to deactivate');
    }
  }
}
  /*Future<void> postUser(UserModel user) async {
    try {
      const url = "http://192.168.1.113:5000/users/addUsers";
      final resp = await http.post(Uri.parse(url)
      //add content type precaution for new errors
       headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },);
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
  }*/

