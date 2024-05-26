import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:admintest/Models/CRUDModels/brands_model.dart';
import 'package:admintest/Widgets/CRUDWidgets/add_brand_page.dart';
import 'package:admintest/Widgets/appbarwideget.dart';
import 'package:admintest/constants/const_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Controllers/CRUDControllers/brands_api.dart';

class BrandsRoute extends StatefulWidget {
  BrandsRoute({super.key});

  @override
  State<BrandsRoute> createState() => _BrandsRouteState();
}

class _BrandsRouteState extends State<BrandsRoute> {
  TextEditingController _searchController = TextEditingController();

  final BrandApiCall brandApiCall = BrandApiCall();
  String message = '';
  String minimizeTitle(String title) {
    List<String> words = title.split(' ');
    return words.take(2).join(' ');
  }

  @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "All Brands"),
      backgroundColor: backgoundColor, // AppBar
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          children: [
            //HeaderWidget(scaffoldContext: context, cntrl: _searchController),
            const SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<BrandModel>>(
                future: brandApiCall.getAllBrands(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    return ListView.separated(
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {},
                          child: Container(
                            height: 70,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 18),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 10, left: 20),
                                    child: SizedBox(
                                      height: 120,
                                      width: 120,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const SizedBox(height: 5),
                                          Text(
                                            minimizeTitle(
                                                snapshot.data![index].name),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          /* Text(
                                            snapshot.data![index].id,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 10,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),*/
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    String? id = snapshot.data![index].id;
                                    if (id != null) {
                                      showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                icon: const Icon(
                                                    Icons.warning_amber_rounded,
                                                    size: 50),
                                                iconColor: Color(0xFF965D1A),
                                                backgroundColor:
                                                    Color(0xFFFDF1E1),
                                                title: const Text(
                                                  'Delete All Brands',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: 'Poppins',
                                                      color: Colors.black,
                                                      fontSize: 20),
                                                ),
                                                content: const Text(
                                                  'If you delete this brand, you will delete all its products!!!',
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();

                                                      // Close the dialog after deletion
                                                    },
                                                    child: const Text('Cancel',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Poppins',
                                                            color: Color(
                                                                0xFF965D1A),
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  ),
                                                  TextButton(
                                                    onPressed: () async {
                                                      setState(() {
                                                        deleteBrand(id)
                                                            .whenComplete(() =>
                                                                Fluttertoast
                                                                    .showToast(
                                                                  msg: message,
                                                                  toastLength: Toast
                                                                      .LENGTH_SHORT,
                                                                  backgroundColor: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          0.7),
                                                                ));
                                                        Navigator.of(context)
                                                            .pop();
                                                      });
                                                      // Close the dialog after deletion
                                                    },
                                                    child: const Text('Delete',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Poppins',
                                                            color: Color(
                                                                0xFF965D1A),
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
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
                                  child: Container(
                                    width: 37,
                                    height: 37,
                                    child: Icon(
                                      //     Icons.branding_watermark_outlined,
                                      CupertinoIcons.delete,
                                      color: Colors.white,
                                    ),
                                    decoration: const ShapeDecoration(
                                      color: orange,
                                      shape: CircleBorder(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const Divider(
                        height: 10,
                        thickness: 5,
                        color: Colors.white,
                      ),
                      itemCount: snapshot.data!.length,
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            InkWell(
              onTap: () {
                Scaffold.of(context).openDrawer(); // Open the drawer
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const AddBrands(),
                  ),
                );
              },
              child: Container(
                width: 60,
                height: 60,
                child: Icon(
                  Icons.add_box_outlined,
                  color: Colors.white,
                  size: 40,
                ),
                decoration: const ShapeDecoration(
                  color: orange,
                  shape: CircleBorder(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
