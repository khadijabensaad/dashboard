/*import 'package:admintest/Controllers/CRUDControllers/category_api.dart';
import 'package:admintest/Models/CRUDModels/categories_model.dart';
import 'package:admintest/Widgets/appbarwideget.dart';
import 'package:admintest/constants/const_colors.dart';
import 'package:flutter/material.dart';

class CategoriesRoute extends StatelessWidget {
  CategoriesRoute({super.key});

  final GetCategoryApiCall categoryApiCall = GetCategoryApiCall();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:const AppBarWidget(title: "All Categories"),
      body: FutureBuilder<List<CategoryModel>>(
        future: categoryApiCall.getAllCategories(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) => Container(
                color: backgoundColor,
                child: Column(
                  children: [
                    /* Image.network(
                      "http://192.168.0.179:5000/images/${snapshot.data![index].thumbnail}",
                      width: 150,
                    ),*/
                    ListTile(
                      title: Text(snapshot.data![index].name),
                      subtitle: Text(snapshot.data![index].id),
                    ),
                    Container(
                      height: 8,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(), // Display loading indicator
            );
          }
        },
      ),
    );
  }
}
*/
import 'package:admintest/Controllers/CRUDControllers/category_api.dart';
import 'package:admintest/Models/CRUDModels/categories_model.dart';
import 'package:admintest/Widgets/appbarwideget.dart';
import 'package:admintest/constants/const_colors.dart';
import 'package:flutter/material.dart';

import '../../Widgets/CRUDWidgets/add_category_page.dart';
import '../../Widgets/header_widget.dart';

class CategoriesRoute extends StatefulWidget {
  CategoriesRoute({super.key});

  @override
  State<CategoriesRoute> createState() => _CategoriesRouteState();
}

class _CategoriesRouteState extends State<CategoriesRoute> {
  final CategoryApiCall categoryApiCall = CategoryApiCall();

  TextEditingController _searchController = TextEditingController();

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
      appBar: const AppBarWidget(title: "All Categories"),
      backgroundColor: backgoundColor, // AppBar
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          children: [
            HeaderWidget(scaffoldContext: context, cntrl: _searchController),
            const SizedBox(height: 10),
            const SizedBox(height: 7),
            Expanded(
              child: FutureBuilder<List<CategoryModel>>(
                future: categoryApiCall.getAllCategories(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    return ListView.separated(
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            // Get.to(() => ProductDetails(
                            //   product: snapshot.data!,
                            //   index: index,
                            //   currencySign: '',
                            //   price: '.',
                            // ));
                          },
                          child: Container(
                            height: 70,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 18),
                            child: Row(
                              children: [
                                /*  Container(
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Image.network(
                                    // snapshot.data![index].thumbnail,
                                    "http://192.168.0.179:5000/shops/getAllShops/${snapshot.data![index].coordinates}",
                                    height: 100,
                                    width: 110,
                                    fit: BoxFit.fill,
                                  ),
                                ),*/
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
                                          Text(
                                            snapshot.data![index].name,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 10,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            snapshot.data![index].id,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 13,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(height: 3),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 37,
                                  height: 37,
                                  child: Icon(
                                    Icons.category_outlined,
                                    color: Colors.white,
                                  ),
                                  decoration: const ShapeDecoration(
                                    color: orange,
                                    shape: CircleBorder(),
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
                    builder: (_) => const AddCategory(),
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
