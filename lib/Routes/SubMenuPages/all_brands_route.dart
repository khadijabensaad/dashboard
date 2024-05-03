import 'package:admintest/Models/CRUDModels/brands_model.dart';
import 'package:admintest/Widgets/CRUDWidgets/add_brand_page.dart';
import 'package:admintest/Widgets/appbarwideget.dart';
import 'package:admintest/constants/const_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Controllers/CRUDControllers/brands_api.dart';
import '../../Widgets/header_widget.dart';

class BrandsRoute extends StatefulWidget {
  BrandsRoute({super.key});

  @override
  State<BrandsRoute> createState() => _BrandsRouteState();
}

class _BrandsRouteState extends State<BrandsRoute> {
  TextEditingController _searchController = TextEditingController();

  final BrandApiCall brandApiCall = BrandApiCall();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "All Brands"),
      backgroundColor: backgoundColor, // AppBar
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          children: [
            HeaderWidget(scaffoldContext: context, cntrl: _searchController),
            const SizedBox(height: 17),
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
                                      brandApiCall.deleteBrand(id);
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
