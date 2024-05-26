import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:admintest/Controllers/CRUDControllers/brands_api.dart';
import 'package:admintest/Models/CRUDModels/brands_model.dart';
import 'package:admintest/Widgets/appbarwideget.dart';
import 'package:admintest/constants/const_colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddBrands extends StatefulWidget {
  const AddBrands({super.key});

  @override
  State<AddBrands> createState() => _FormState();
}

BrandApiCall _brandApiCall = BrandApiCall();

class _FormState extends State<AddBrands> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _prodController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _updatedNameController = TextEditingController();
  final TextEditingController _updatedIdController = TextEditingController();
  String message = '';
  Future<void> updateBrand(BrandModel brand, String id) async {
    try {
      String url = "http://192.168.1.113:5000/brands/updateBrand/${id}";
      //var headers = {'Content-Type': 'application/json; charset=UTF-8'};
      final resp = await http.put(Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: jsonEncode(brand.toJson()));

      if (resp.statusCode == 200 || resp.statusCode == 201) {
        print("success brand updated");
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

  Future<void> addBrand(BrandModel brand) async {
    try {
      const String url = "http://192.168.1.113:5000/brands/addBrand";
      //var headers = {'Content-Type': 'application/json; charset=UTF-8'};
      final resp = await http.post(Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: jsonEncode(brand.toJson()));

      if (resp.statusCode == 200 || resp.statusCode == 201) {
        print("success add Brand");
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
  Future<void> deleteBrand(String id) async {
    try {
      //na7ina il const khater l'id variable
      String url = "http://192.168.1.113:5000/brands/deleteBrand/${id}";
      final resp = await http.delete(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );
      if (resp.statusCode == 200) {
        print("succes brand deleted");
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
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        title: "Add Brand",
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
                    labelText: "Brandname",
                    hintText: "Enter the brand name",
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
                height: 50,
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
                height: 50,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: orange,
                ),
                child: const Text(
                  'Add Brand',
                  style: TextStyle(
                      color: darkBrown,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins'),
                ),
                onPressed: () {
                  if (_nameController.text.isNotEmpty) {
                    addBrand(BrandModel(
                            name: _nameController.text,
                            products: [_prodController.text]))
                        .whenComplete(() => Fluttertoast.showToast(
                              msg: message,
                              toastLength: Toast.LENGTH_SHORT,
                              backgroundColor: Colors.black.withOpacity(0.7),
                            ));
                  }
                },
              ),
              const SizedBox(
                height: 50,
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
                    labelText: "BrandId",
                    hintText: "Enter The Brand ID to delete it",
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
                height: 50,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: orange,
                ),
                child: const Text(
                  'Delete Brand',
                  style: TextStyle(
                      color: darkBrown,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins'),
                ),
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
                                'Delete All Brands',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                    fontSize: 20),
                              ),
                              content: const Text(
                                'If you delete this brand, you will delete all its products!!!',
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
                                      deleteBrand(_idController.text)
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
              ),*/
              const SizedBox(
                height: 30,
              ),
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
                    labelText: "Id Brand",
                    hintText:
                        "Enter the id of the brand that you want to update ",
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
                    labelText: "NewBrandName",
                    hintText: "Update the brand name",
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
                height: 50,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: orange,
                ),
                child: const Text(
                  'Update Brand',
                  style: TextStyle(
                      color: darkBrown,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins'),
                ),
                onPressed: () {
                  if (_updatedNameController.text.isNotEmpty) {
                    updateBrand(
                            BrandModel(
                                name: _updatedNameController.text,
                                products: [_prodController.text]),
                            _updatedIdController.text)
                        .whenComplete(() => Fluttertoast.showToast(
                              msg: message,
                              toastLength: Toast.LENGTH_SHORT,
                              backgroundColor: Colors.black.withOpacity(0.7),
                            ));
                  }
                },
              ),
            ],
          ),
        ),
      )),
    );
  }
}
