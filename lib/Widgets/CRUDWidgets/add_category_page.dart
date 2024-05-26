import 'dart:convert';

import 'package:admintest/Widgets/appbarwideget.dart';
import 'package:admintest/constants/const_colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../../Controllers/CRUDControllers/category_api.dart';
import '../../Models/CRUDModels/categories_model.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _FormState();
}

CategoryApiCall categoryApiCall = CategoryApiCall();

class _FormState extends State<AddCategory> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _prodController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _updatedIdController = TextEditingController();
  final TextEditingController _updatedNameController = TextEditingController();
  String message = '';
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
        var jsonResponse = jsonDecode(resp.body);
        setState(() {
          message = jsonResponse;
        });
      } else {
        print("Failed with status code ${resp.statusCode}: ${resp.body}");
      }
    } catch (error) {
      print("Error: $error");
    }
  }

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
        var jsonResponse = jsonDecode(resp.body);
        setState(() {
          message = jsonResponse;
        });
      } else {
        print("Failed with status code ${resp.statusCode}: ${resp.body}");
      }
    } catch (error) {
      print("Error: $error");
    }
  }

  /* Future<void> deleteCategory(String id) async {
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
        print("succes category deleted");
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
        title: "Add category",
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
                    labelText: "categoryname",
                    hintText: "Enter the category name",
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
                  'Add category',
                  style: TextStyle(
                      color: darkBrown,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins'),
                ),
                onPressed: () {
                  if (_nameController.text.isNotEmpty) {
                    CategoryModel category = CategoryModel(
                      name: _nameController.text,
                      products: [_prodController.text],
                      id: '',
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                    );
                    if (category != null) {
                      addCategory(category)
                          .whenComplete(() => Fluttertoast.showToast(
                                msg: message,
                                toastLength: Toast.LENGTH_SHORT,
                                backgroundColor: Colors.black.withOpacity(0.7),
                              ));
                    } else {
                      print('Error: CategoryModel is null');
                    }
                  } else {
                    print('Error: Name field is empty');
                  }
                },
              ),
              const SizedBox(
                height: 30,
              ),
              /*Padding(
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
                    labelText: "CategoryId",
                    hintText: "Enter the category Id",
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
                  'Delete category',
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
                                'Delete Category',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                    fontSize: 20),
                              ),
                              content: const Text(
                                'If you delete this category, you will delete all its products!!!',
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
                                      deleteCategory(_idController.text)
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
                  controller: _updatedNameController,
                  cursorColor: orange,
                  style: const TextStyle(
                      fontFamily: 'Poppins', fontWeight: FontWeight.w600),
                  decoration: InputDecoration(
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: orange, width: 2),
                        gapPadding: 10),
                    labelText: "categoryname",
                    hintText: "update the category name",
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
                  controller: _updatedIdController,
                  cursorColor: orange,
                  style: const TextStyle(
                      fontFamily: 'Poppins', fontWeight: FontWeight.w600),
                  decoration: InputDecoration(
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: orange, width: 2),
                        gapPadding: 10),
                    labelText: "categoryId",
                    hintText: "Enter the category Id",
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
                  'Update category',
                  style: TextStyle(
                      color: darkBrown,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins'),
                ),
                onPressed: () {
                  if (_updatedNameController.text.isNotEmpty) {
                    updateCategory(
                            CategoryModel(
                              name: _updatedNameController.text,
                              products: [_prodController.text],
                              id: _updatedIdController.text,
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
                height: 30,
              ),
            ],
          ),
        ),
      )),
    );
  }
}
