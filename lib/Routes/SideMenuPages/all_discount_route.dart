import 'package:admintest/Widgets/appbarwideget.dart';
import 'package:admintest/constants/const_colors.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../Controllers/CRUDControllers/discount_api.dart';
import '../../Models/CRUDModels/discounts_model.dart';

class DiscountsRoute extends StatefulWidget {
  DiscountsRoute({super.key});

  @override
  State<DiscountsRoute> createState() => _DiscountsRouteState();
}

class _DiscountsRouteState extends State<DiscountsRoute> {
  final DiscountApiCall _discountApiCall = DiscountApiCall();
  List<String> actionList = ['Delete Discount', 'Check Discounted Products'];
  String? _selectedAction;
  String message = '';
  List<DiscountsModel> _discounts = [];

  @override
  void initState() {
    super.initState();
  }

  void _onSelected(String value) {
    setState(() {
      _selectedAction = value;
    });
  }

  Future<void> deleteDiscount(String id) async {
    List<String> prod_ids = [];
    try {
      //na7ina il const khater l'id variable
      String url = "http://192.168.1.113:5000/discounts/deleteDiscount";
      prod_ids.add(id);
      var reqBody = jsonEncode({"prods": prod_ids});
      final resp = await http.delete(Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: reqBody);
      print(reqBody);
      if (resp.statusCode == 200) {
        print("succes! Products no more discounted");
        var jsonResponse = jsonDecode(resp.body);
        setState(() {
          message = jsonResponse["message"];
        });
      } else {
        print("failed");
      } //khadijabensaad4@gmail.com
    } catch (e) {
      print("echec: ${e}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "Discounts Management"),
      body: Container(
        padding: const EdgeInsets.all(24),
        margin: const EdgeInsets.symmetric(vertical: 30),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 6),
              color: darkGrey.withOpacity(0.1),
              blurRadius: 12,
            ),
          ],
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: FutureBuilder<List<DiscountsModel>>(
            future: _discountApiCall.getAllDiscounts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                print('Error: ${snapshot.error}');
                return const Center(child: Text('Failed to load discounts'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No discounts available'));
              } else {
                final discounts = snapshot.data!;
                return DataTable2(
                  columnSpacing: 12,
                  horizontalMargin: 12,
                  minWidth: 600,
                  columns: const [
                    DataColumn2(
                      label: Center(
                        child: Text(
                          'Discount ID',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      size: ColumnSize.M,
                    ),
                    DataColumn2(
                      label: Center(
                        child: Text(
                          'Discount Value',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      size: ColumnSize.S,
                    ),
                    DataColumn2(
                      label: Center(
                        child: Text(
                          'Affected Products',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      size: ColumnSize.L,
                    ),
                    DataColumn2(
                      label: Center(
                        child: Text(
                          'Actions',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      numeric: true,
                      size: ColumnSize.S,
                    ),
                  ],
                  rows: discounts.map((discount) {
                    return DataRow(cells: [
                      DataCell(Center(child: Text(discount.id))),
                      DataCell(Center(child: Text('${discount.value}%'))),
                      DataCell(Center(
                          child: Text(
                              '${discount.saleProducts.length} products'))),
                      DataCell(
                        Center(
                          child: PopupMenuButton<String>(
                            surfaceTintColor: Colors.white,
                            shadowColor: Colors.grey.shade300,
                            icon: const Icon(CupertinoIcons.ellipsis_vertical,
                                color: Colors.black, size: 20),
                            onSelected: (String value) {
                              _onSelected(value);
                            },
                            itemBuilder: (BuildContext context) {
                              return actionList.map((String item) {
                                return PopupMenuItem<String>(
                                  value: item,
                                  child: Center(
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                          fontFamily: 'Poppins', fontSize: 12),
                                    ),
                                  ),
                                );
                              }).toList();
                            },
                          ),
                          /*InkWell(
                            onTap: () {
                              String? id = discount.id;
                              if (id != null) {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          icon: const Icon(
                                              Icons.warning_amber_rounded,
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
                                            'Are you sure about deleting   this discount!!!',
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
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                            TextButton(
                                              onPressed: () async {
                                                deleteDiscount(id).whenComplete(
                                                    () =>
                                                        Fluttertoast.showToast(
                                                          msg: message,
                                                          toastLength: Toast
                                                              .LENGTH_SHORT,
                                                          backgroundColor:
                                                              Colors.black
                                                                  .withOpacity(
                                                                      0.7),
                                                        ));
                                                Navigator.of(context).pop();

                                                // Close the dialog after deletion
                                              },
                                              child: const Text('Delete',
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      color: Color(0xFF965D1A),
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                          ],
                                        ));
                              } else {
                                print("Pas de brand id");
                              }
                              /* BrandModel brandToRemove =
                                        snapshot.data![index];
                                    brandApiCall.removeBrand(brandToRemove);*/
                            },
                            child: Icon(
                              //     Icons.branding_watermark_outlined,
                              CupertinoIcons.delete,
                              color: Colors.black,
                              size: 20,
                            ),
                          ),*/
                        ),
                      ),
                    ]);
                  }).toList(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

/*import 'package:admintest/Widgets/appbarwideget.dart';
import 'package:admintest/constants/const_colors.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart';

class DiscountsRoute extends StatefulWidget {
  DiscountsRoute({super.key});

  @override
  State<DiscountsRoute> createState() => _DiscountsRouteState();
}

class _DiscountsRouteState extends State<DiscountsRoute> {
  List<String> actionList = ['AddUser', 'Delete user'];
  String? _selectedAction;
  void _onSelected(String value) {
    setState(() {
      _selectedAction = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: "Discounts Management"),
      body: Container(
        padding: const EdgeInsets.all(24),
        margin: const EdgeInsets.symmetric(vertical: 30),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 6),
                  color: darkGrey.withOpacity(0.1),
                  blurRadius: 12)
            ],
            border: Border.all(color: Colors.grey.shade300)),
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: DataTable2(
              //  showHeadingCheckBox: true,
              // checkboxAlignment: Alignment.centerLeft,
              // datarowCheckboxTheme: ,
              columnSpacing: 12,
              horizontalMargin: 12,
              minWidth: 600,
              columns: const [
                DataColumn2(
                  label: Center(
                      child: Text(
                    'Discount ID',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                  size: ColumnSize.M,
                ),
                DataColumn2(
                  label: Center(
                      child: Text(
                    'discount',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                  size: ColumnSize.S,
                ),
                DataColumn2(
                  label: Center(
                      child: Text(
                    'Affected products',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                  size: ColumnSize.L,
                ),
                
                DataColumn2(
                  label: Center(
                      child: Text(
                    'Actions',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                  numeric: true,
                  size: ColumnSize.S,
                ),
              ],
              rows: List<DataRow>.generate(
                100,
                (index) => DataRow(cells: [
                  const DataCell(Center(
                    child: Text('66368251c6c3ab2e19eb71f2' // * (10 - index % 10)
                        ),
                  )),
                  const DataCell(Center(
                    child: Text('20%' // * (10 - (index + 5) % 10)
                        ),
                  )),
                  const DataCell(Center(
                    child: Text('3 products' // * (15 - (index + 5) % 10)
                        ),
                  )),
                 
                  DataCell(
                    //Text(((index + 0.1) * 25.4).toString())
                    Center(
                      child: PopupMenuButton<String>(
                        surfaceTintColor: Colors.white,
                        shadowColor: Colors.grey.shade300,
                        icon: const Icon(CupertinoIcons.ellipsis_vertical,
                            color: Colors.black, size: 20),
                        onSelected: (String value) {
                          _onSelected(value);
                        },
                        itemBuilder: (BuildContext context) {
                          return actionList.map((String item) {
                            return PopupMenuItem<String>(
                              value: item,
                              child: Center(
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                      fontFamily: 'Poppins', fontSize: 12),
                                ),
                              ),
                            );
                          }).toList();
                        },
                      ),
                    ),
                  ),
                ]),
              )),
        ),
      ),
    );
  }
}*/

