import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Models/CRUDModels/user_model.dart';

class AuthCallAPi {
  late SharedPreferences prefs;

  AuthCallAPi() {
    initSharedPref(); // Call initSharedPref in the constructor
  }

  Future<void> initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
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
}
