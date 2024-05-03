import 'package:admintest/Controllers/CRUDControllers/shops_api.dart';
import 'package:admintest/Models/CRUDModels/shops_model.dart';
import 'package:admintest/Widgets/CRUDWidgets/add_shop_page.dart';
import 'package:flutter/material.dart';

import '../../Widgets/appbarwideget.dart';
import '../../Widgets/header_widget.dart';
import '../../constants/const_colors.dart';

class ShopsRoute extends StatefulWidget {
  ShopsRoute({super.key});

  @override
  State<ShopsRoute> createState() => _ShopsRouteState();
}

class _ShopsRouteState extends State<ShopsRoute> {
  final ShopApiCall apiShopsCall = ShopApiCall();

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
      appBar: const AppBarWidget(title: "All Shops"),
      backgroundColor: backgoundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          children: [
            HeaderWidget(scaffoldContext: context, cntrl: _searchController),
            const SizedBox(height: 10),
            /* Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  child: const Icon(
                    CupertinoIcons.arrow_left,
                    size: 20,
                    color: orange,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(height: 10),
                /*   const Text(
                  '4 RÉSULTATS TROUVÉS',
                  style: TextStyle(
                    color: orange,
                    fontSize: 13,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),*/
              ],
            ),*/
            const SizedBox(height: 7),
            Expanded(
              child: FutureBuilder<List<ShopModel>>(
                future: apiShopsCall.getAllShops(),
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
                            height: 85,
                            margin: const EdgeInsets.all(10),
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
                                            snapshot.data![index].city,
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
                                            snapshot.data![index].region,
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
                                    Icons.location_on_outlined,
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
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 5),
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
                    builder: (_) => const AddShops(),
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
