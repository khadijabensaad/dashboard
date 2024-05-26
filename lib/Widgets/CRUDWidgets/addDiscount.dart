import 'dart:convert';
import 'package:admintest/Widgets/appbarwideget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

import '../../Models/CRUDModels/discounts_model.dart';
import '../../constants/const_colors.dart';

class AddDiscountRoute extends StatefulWidget {
  AddDiscountRoute({super.key});

  @override
  State<AddDiscountRoute> createState() => _AddDiscountRouteState();
}

class _AddDiscountRouteState extends State<AddDiscountRoute> {
  final TextEditingController _valueController = TextEditingController();
  final TextEditingController _affectedProdController = TextEditingController();
  String message = '';

  Future<void> addDiscount(DiscountsModel discount) async {
    try {
      const String url = "http://192.168.1.113:5000/discounts/addDiscount";
      final resp = await http.post(Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: jsonEncode(discount.toJson()));

      if (resp.statusCode == 200 || resp.statusCode == 201) {
        print("success, added discount!!!");
        var jsonResponse = jsonDecode(resp.body);
        setState(() {
          message = jsonResponse["message"];
        });
      } else {
        print("echec: ${resp.statusCode}");
      }
    } catch (error) {
      print("erreur: ${error}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "Add Discount Price"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 200,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, bottom: 5, top: 5),
                child: TextField(
                  controller: _valueController,
                  cursorColor: orange,
                  style: const TextStyle(
                      fontFamily: 'Poppins', fontWeight: FontWeight.w600),
                  decoration: InputDecoration(
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: orange, width: 2),
                        gapPadding: 10),
                    labelText: "Discount Value",
                    hintText: "Enter the discount value",
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
                  controller: _affectedProdController,
                  cursorColor: orange,
                  style: const TextStyle(
                      fontFamily: 'Poppins', fontWeight: FontWeight.w600),
                  decoration: InputDecoration(
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: orange, width: 2),
                        gapPadding: 10),
                    labelText: "Product Affected ID",
                    hintText: "Enter the product affected ID",
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
                  'Add Discount',
                  style: TextStyle(
                      color: darkBrown,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins'),
                ),
                onPressed: () {
                  if (_valueController.text.isNotEmpty &&
                      _affectedProdController.text.isNotEmpty) {
                    double value = double.parse(_valueController.text);
                    DiscountsModel discount = DiscountsModel(
                      value: value,
                      id: '',
                      saleProducts: [_affectedProdController.text],
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                      v: 0,
                    );
                    addDiscount(discount)
                        .whenComplete(() => Fluttertoast.showToast(
                              msg: message,
                              toastLength: Toast.LENGTH_SHORT,
                              backgroundColor: Colors.black.withOpacity(0.7),
                            ));
                  } else {
                    print('Error: Fields are empty');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
