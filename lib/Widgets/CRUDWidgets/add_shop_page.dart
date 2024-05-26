import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:admintest/Controllers/CRUDControllers/shops_api.dart';
import 'package:admintest/Models/CRUDModels/shops_model.dart';
import 'package:admintest/Widgets/appbarwideget.dart';
import 'package:admintest/constants/const_colors.dart';
import 'package:flutter/material.dart';

class AddShops extends StatefulWidget {
  const AddShops({super.key});

  @override
  State<AddShops> createState() => _FormState();
}

ShopApiCall shopApiCall = ShopApiCall();

class _FormState extends State<AddShops> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _prodController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _regionController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();
  final TextEditingController _laltitudeController = TextEditingController();
  final TextEditingController _updatedNameController = TextEditingController();
  final TextEditingController _updatedIdController = TextEditingController();
  final TextEditingController _updatedCityController = TextEditingController();
  final TextEditingController _updatedRegionController =
      TextEditingController();
  final TextEditingController _updatedLongitudeController =
      TextEditingController();
  final TextEditingController _updatedLaltitudeController =
      TextEditingController();
  String message = '';

  Future<void> updateShop(ShopModel shop, String id) async {
    try {
      String url = "http://192.168.1.113:5000/shops/updateShop/${id}";
      //var headers = {'Content-Type': 'application/json; charset=UTF-8'};
      final resp = await http.put(Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: jsonEncode(shop.toJson()));
      if (resp.statusCode == 200 || resp.statusCode == 201) {
        print("success shop updated");
        var jsonResponse = jsonDecode(resp.body);
        setState(() {
          message = jsonResponse;
        });
      } else {
        print("echec: ${resp.statusCode}");
      }
    } catch (error) {
      print("erreur: ${error}");
    }
  }

  Future<void> addShop(ShopModel shop) async {
    try {
      const String url = "http://192.168.1.113:5000/shops/addShop";
      //var headers = {'Content-Type': 'application/json; charset=UTF-8'};
      final resp = await http.post(Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: jsonEncode(shop.toJson()));

      if (resp.statusCode == 200 || resp.statusCode == 201) {
        print("success of shop add");
        var jsonResponse = jsonDecode(resp.body);
        setState(() {
          message = jsonResponse;
        });
      } else {
        print("echec: ${resp.statusCode}");
      }
    } catch (error) {
      print("erreur: ${error}");
    }
  }

/*
  Future<void> deleteShop(String id) async {
    try {
      //na7ina il const khater l'id variable
      String url = "http://192.168.1.113:5000/shops/deleteShop/${id}";
      final resp = await http.delete(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );
      if (resp.statusCode == 200) {
        print("succes shop deleted");
        var jsonResponse = jsonDecode(resp.body);
        setState(() {
          message = jsonResponse;
        });
      } else {
        print("failed");
      }
    } catch (e) {
      print("echec: ${e}");
    }
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        title: "Add Shop",
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, bottom: 5, top: 5),
                child: TextField(
                  controller: _nameController,
                  cursorColor: orange,
                  style: const TextStyle(
                      fontFamily: 'Poppins', fontWeight: FontWeight.w600),
                  decoration: InputDecoration(
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: orange, width: 2),
                        gapPadding: 10),
                    labelText: "Shopname",
                    hintText: "Enter the Shop name",
                    labelStyle: const TextStyle(
                        color: orange,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: 'Poppins'),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: orange, width: 2),
                        gapPadding: 10),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: orange, width: 2),
                        gapPadding: 10),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, bottom: 5, top: 5),
                child: TextField(
                  controller: _cityController,
                  cursorColor: orange,
                  style: const TextStyle(
                      fontFamily: 'Poppins', fontWeight: FontWeight.w600),
                  decoration: InputDecoration(
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: orange, width: 2),
                        gapPadding: 10),
                    labelText: "Shopcity",
                    hintText: "Enter the Shop city",
                    labelStyle: const TextStyle(
                        color: orange,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: 'Poppins'),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: orange, width: 2),
                        gapPadding: 10),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: orange, width: 2),
                        gapPadding: 10),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, bottom: 5, top: 5),
                child: TextField(
                  controller: _regionController,
                  cursorColor: orange,
                  style: const TextStyle(
                      fontFamily: 'Poppins', fontWeight: FontWeight.w600),
                  decoration: InputDecoration(
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: orange, width: 2),
                        gapPadding: 10),
                    labelText: "Shopregion",
                    hintText: "Enter the Shop region",
                    labelStyle: const TextStyle(
                        color: orange,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: 'Poppins'),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: orange, width: 2),
                        gapPadding: 10),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: orange, width: 2),
                        gapPadding: 10),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, bottom: 5, top: 5),
                child: TextField(
                  controller: _longitudeController,
                  cursorColor: orange,
                  style: const TextStyle(
                      fontFamily: 'Poppins', fontWeight: FontWeight.w600),
                  decoration: InputDecoration(
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: orange, width: 2),
                        gapPadding: 10),
                    labelText: "Shoplongitude",
                    hintText: "Enter the Shop longitude coordinate",
                    labelStyle: const TextStyle(
                        color: orange,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: 'Poppins'),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: orange, width: 2),
                        gapPadding: 10),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: orange, width: 2),
                        gapPadding: 10),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, bottom: 5, top: 5),
                child: TextField(
                  controller: _laltitudeController,
                  cursorColor: orange,
                  style: const TextStyle(
                      fontFamily: 'Poppins', fontWeight: FontWeight.w600),
                  decoration: InputDecoration(
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: orange, width: 2),
                        gapPadding: 10),
                    labelText: "Shoplaltitude",
                    hintText: "Enter the Shop laltitude coordinate",
                    labelStyle: const TextStyle(
                        color: orange,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: 'Poppins'),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: orange, width: 2),
                        gapPadding: 10),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: orange, width: 2),
                        gapPadding: 10),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, bottom: 5, top: 5),
                child: TextField(
                  controller: _prodController,
                  cursorColor: orange,
                  style: const TextStyle(
                      fontFamily: 'Poppins', fontWeight: FontWeight.w600),
                  decoration: InputDecoration(
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: orange, width: 2),
                        gapPadding: 10),
                    labelText: "ProductId",
                    hintText: "Enter The product ID",
                    labelStyle: const TextStyle(
                        color: orange,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: 'Poppins'),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: orange, width: 2),
                        gapPadding: 10),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: orange, width: 2),
                        gapPadding: 10),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: orange,
                  ),
                  child: const Text(
                    'Add Shop',
                    style: TextStyle(
                        color: darkBrown,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins'),
                  ),
                  onPressed: () {
                    if (_nameController.text.isNotEmpty &&
                        _cityController.text.isNotEmpty &&
                        _regionController.text.isNotEmpty &&
                        _longitudeController.text.isNotEmpty &&
                        _laltitudeController.text.isNotEmpty) {
                      double longitude =
                          double.parse(_longitudeController.text);
                      double latitude = double.parse(_laltitudeController.text);
                      addShop(
                        ShopModel(
                          name: _nameController.text,
                          products: [_prodController.text],
                          city: _cityController.text,
                          region: _regionController.text,
                          coordinates: Coordinates(
                            longitude: longitude,
                            latitude: latitude,
                          ),
                          createdAt: DateTime.now(),
                          updatedAt: DateTime.now(),
                          v: 0,
                          id: '',
                        ),
                      ).whenComplete(() => Fluttertoast.showToast(
                            msg: message,
                            toastLength: Toast.LENGTH_SHORT,
                            backgroundColor: Colors.black.withOpacity(0.7),
                          ));
                    }
                  }),
              const SizedBox(
                height: 30,
              ),
              /*    Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, bottom: 5, top: 5),
                child: TextField(
                  controller: _idController,
                  cursorColor: orange,
                  style: const TextStyle(
                      fontFamily: 'Poppins', fontWeight: FontWeight.w600),
                  decoration: InputDecoration(
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: orange, width: 2),
                        gapPadding: 10),
                    labelText: "ShopId",
                    hintText: "Enter the shop Id",
                    labelStyle: const TextStyle(
                        color: orange,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: 'Poppins'),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: orange, width: 2),
                        gapPadding: 10),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: orange, width: 2),
                        gapPadding: 10),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: orange,
                ),
                child: const Text(
                  'Delete Shop',
                  style: TextStyle(
                      color: darkBrown,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins'),
                ),
                /*onPressed: () {
                  if (_idController.text.isNotEmpty) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Delete brand'),
                          content: const Text(
                              'Are you sure you want to delete this brand?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                // Close the dialog when cancel button is pressed
                                Navigator.of(context).pop();
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                shopApiCall.deleteShop(_idController.text);
                                Navigator.of(context)
                                    .pop(); // Close the dialog after deletion
                              },
                              child: const Text('Delete'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },*/
                onPressed: () {
                  if (_idController.text.isNotEmpty) {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              icon: const Icon(Icons.warning_amber_rounded,
                                  size: 50),
                              iconColor: Color(0xFF965D1A),
                              backgroundColor: Color(0xFFFDF1E1),
                              title: const Text(
                                'Delete Shop',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                    fontSize: 20),
                              ),
                              content: const Text(
                                'If you delete this shop, you will delete all its products!!!',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    // Close the dialog after deletion
                                  },
                                  child: const Text('Cancel',
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: Color(0xFF965D1A),
                                          fontWeight: FontWeight.bold)),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    setState(() {
                                      deleteShop(_idController.text)
                                          .whenComplete(() =>
                                              Fluttertoast.showToast(
                                                msg: message,
                                                toastLength: Toast.LENGTH_SHORT,
                                                backgroundColor: Colors.black
                                                    .withOpacity(0.7),
                                              ));
                                      Navigator.of(context).pop();
                                    });
                                    // Close the dialog after deletion
                                  },
                                  child: const Text('Delete',
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: Color(0xFF965D1A),
                                          fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ));
                  }
                },
              ),
              const SizedBox(
                height: 30,
              ),*/
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, bottom: 5, top: 5),
                child: TextField(
                  controller: _updatedIdController,
                  cursorColor: orange,
                  style: const TextStyle(
                      fontFamily: 'Poppins', fontWeight: FontWeight.w600),
                  decoration: InputDecoration(
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: orange, width: 2),
                        gapPadding: 10),
                    labelText: "ShopId",
                    hintText: "Enter the shop Id",
                    labelStyle: const TextStyle(
                        color: orange,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: 'Poppins'),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: orange, width: 2),
                        gapPadding: 10),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: orange, width: 2),
                        gapPadding: 10),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, bottom: 5, top: 5),
                child: TextField(
                  controller: _updatedNameController,
                  cursorColor: orange,
                  style: const TextStyle(
                      fontFamily: 'Poppins', fontWeight: FontWeight.w600),
                  decoration: InputDecoration(
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: orange, width: 2),
                        gapPadding: 10),
                    labelText: "Name",
                    hintText: "Update the shop's name",
                    labelStyle: const TextStyle(
                        color: orange,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: 'Poppins'),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: orange, width: 2),
                        gapPadding: 10),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: orange, width: 2),
                        gapPadding: 10),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, bottom: 5, top: 5),
                child: TextField(
                  controller: _updatedCityController,
                  cursorColor: orange,
                  style: const TextStyle(
                      fontFamily: 'Poppins', fontWeight: FontWeight.w600),
                  decoration: InputDecoration(
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: orange, width: 2),
                        gapPadding: 10),
                    labelText: "City",
                    hintText: "Update the shop's city",
                    labelStyle: const TextStyle(
                        color: orange,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: 'Poppins'),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: orange, width: 2),
                        gapPadding: 10),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: orange, width: 2),
                        gapPadding: 10),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, bottom: 5, top: 5),
                child: TextField(
                  controller: _updatedRegionController,
                  cursorColor: orange,
                  style: const TextStyle(
                      fontFamily: 'Poppins', fontWeight: FontWeight.w600),
                  decoration: InputDecoration(
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: orange, width: 2),
                        gapPadding: 10),
                    labelText: "Region",
                    hintText: "Update the shop region",
                    labelStyle: const TextStyle(
                        color: orange,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: 'Poppins'),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: orange, width: 2),
                        gapPadding: 10),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: orange, width: 2),
                        gapPadding: 10),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, bottom: 5, top: 5),
                child: TextField(
                  controller: _updatedLongitudeController,
                  cursorColor: orange,
                  style: const TextStyle(
                      fontFamily: 'Poppins', fontWeight: FontWeight.w600),
                  decoration: InputDecoration(
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: orange, width: 2),
                        gapPadding: 10),
                    labelText: "Longitude",
                    hintText: "Update the shop longitude coordinates",
                    labelStyle: const TextStyle(
                        color: orange,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: 'Poppins'),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: orange, width: 2),
                        gapPadding: 10),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: orange, width: 2),
                        gapPadding: 10),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, bottom: 5, top: 5),
                child: TextField(
                  controller: _updatedLaltitudeController,
                  cursorColor: orange,
                  style: const TextStyle(
                      fontFamily: 'Poppins', fontWeight: FontWeight.w600),
                  decoration: InputDecoration(
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: orange, width: 2),
                        gapPadding: 10),
                    labelText: "Latitude",
                    hintText: "Enter the shop Latitude coordinate",
                    labelStyle: const TextStyle(
                        color: orange,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: 'Poppins'),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: orange, width: 2),
                        gapPadding: 10),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: orange, width: 2),
                        gapPadding: 10),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: orange,
                ),
                child: const Text(
                  'Update Shop',
                  style: TextStyle(
                      color: darkBrown,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins'),
                ),
                onPressed: () {
                  if (_updatedNameController.text.isNotEmpty) {
                    updateShop(
                            ShopModel(
                              name: _updatedNameController.text,
                              products: [_prodController.text],
                              city: _updatedCityController.text,
                              id: _updatedIdController.text,
                              coordinates: Coordinates(
                                  longitude: double.parse(
                                      _updatedLongitudeController.text),
                                  latitude: double.parse(
                                      _updatedLongitudeController.text)),
                              region: _updatedRegionController.text,
                              createdAt: DateTime.now(),
                              updatedAt: DateTime.now(),
                              v: 0,
                            ),
                            _updatedIdController.text)
                        .whenComplete(() => Fluttertoast.showToast(
                              msg: message,
                              toastLength: Toast.LENGTH_SHORT,
                              backgroundColor: Colors.black.withOpacity(0.7),
                            ));
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      )),
    );
  }
}
