import 'package:admintest/Controllers/CRUDControllers/products_api.dart';
import 'package:admintest/Models/CRUDModels/product_data_model.dart';
import 'package:admintest/Widgets/appbarwideget.dart';
import 'package:admintest/Widgets/side_menu_resp.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Models/product_filter_model.dart';
import 'package:flutter/cupertino.dart';
import '../../Widgets/CRUDWidgets/product_details.dart';
import '../../Widgets/header_widget.dart';
import '../../constants/const_colors.dart';
import 'all_shops_route.dart';

class AllProductsRouter extends StatefulWidget {
  const AllProductsRouter({super.key, this.req});
  final ProductFilter? req;

  @override
  State<AllProductsRouter> createState() => _SearchPageState();
}

class _SearchPageState extends State<AllProductsRouter> {
  final ProductApiCall _productApiCall = ProductApiCall();
  ProductFilter? requette = ProductFilter(
      name: '',
      size: [],
      colors: '',
      sortBy: '',
      sortOrder: 'desc',
      region: '');
  TextEditingController _searchController = TextEditingController();
  int? nb = 0;
  late SharedPreferences prefs;
  late var token = "";
  String message = '';
  /* void _handleFilterSubmitted(ProductFilter data) {
    setState(() {
      requette = data;
    });
  }*/

  @override
  void initState() {
    // TODO: implement initState
    _searchController = TextEditingController();
    initSharedPref().then((_) {
      setState(() {
        token = prefs.getString("userToken")!;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 1));
        setState(() {});
      },
      color: darkBrown,
      backgroundColor: backgoundColor,
      child: Scaffold(
        backgroundColor: backgoundColor,
        drawer: const SideMenu(),
        appBar: const AppBarWidget(title: 'Find Me'),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeaderWidget(
                      scaffoldContext: context, cntrl: _searchController),
                  const SizedBox(height: 10),
                  FutureBuilder<List<ProductModel>>(
                    //  future: _productApiCall.getAll(),
                    future: _productApiCall.searchProductsWithFilter(
                        ProductFilter(
                            name: widget.req?.name,
                            colors: widget.req?.colors,
                            sortBy: widget.req?.sortBy,
                            sortOrder: widget.req?.sortOrder,
                            region: widget.req?.region,
                            size: widget.req?.size)),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (snapshot.hasData) {
                        nb = snapshot.data?.length;
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
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
                                    Text("  ${nb} Results Found",
                                        style: const TextStyle(
                                          color: orange,
                                          fontSize: 13,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                        ))
                                  ],
                                ),
                                IconButton(
                                    onPressed: () {
                                      requette = ProductFilter(
                                          name: _searchController.text,
                                          size: requette?.size,
                                          colors: requette?.colors,
                                          sortBy: requette?.sortBy,
                                          sortOrder: requette?.sortOrder,
                                          region: requette?.region);
                                      //name: textValue,
                                      Navigator.pushReplacement(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (context) =>
                                                AllProductsRouter(
                                                    req: requette),
                                          ));
                                    },
                                    icon: const Icon(
                                      CupertinoIcons.arrow_2_circlepath,
                                      size: 25,
                                    ))
                              ],
                            ),
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) => InkWell(
                                onTap: () {
                                  print(
                                      "Page search products: ${snapshot.data![index].id}");
                                  Scaffold.of(context).openDrawer();
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => ProductDetails(
                                        product: snapshot.data![index],
                                        index: index,
                                        currencySign: '',
                                        price: '.',
                                        identifier: snapshot.data![index].id,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                    margin: const EdgeInsets.only(left: 5),
                                    child: Row(
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.all(20),
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Image.network(
                                            "${snapshot.data![index].thumbnail}",
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.3,
                                            fit: BoxFit.fill,
                                            /*width: 110,
                                           height: 100,
                                          width: 110,
                                          fit: BoxFit.fill,*/
                                          ),
                                        ),
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
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    "${snapshot.data?[index].name}",
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                      fontFamily: 'Poppins',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  Text(
                                                    "${snapshot.data?[index].brand}",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 11,
                                                      fontFamily: 'Poppins',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.star_rate_rounded,
                                                        color: orange,
                                                      ),
                                                      const SizedBox(
                                                        width: 2,
                                                      ),
                                                      Text(
                                                        "${snapshot.data?[index].rating}",
                                                        style: const TextStyle(
                                                            color: orange),
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    "${snapshot.data?[index].price}"
                                                    r" DT",
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 13,
                                                      fontFamily: 'Poppins',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 3,
                                                  ),
                                                  const Icon(
                                                    Icons.favorite_rounded,
                                                    color: darkGrey,
                                                    size: 20,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 40,
                                          height: 40,
                                          decoration: const ShapeDecoration(
                                            color: orange,
                                            shape: OvalBorder(),
                                          ),
                                          child: IconButton(
                                            icon: const Icon(
                                              Icons.location_on_outlined,
                                              color: Colors.white,
                                            ),
                                            onPressed: () {
                                              List<String> shops =
                                                  snapshot.data![index].shops;
                                              Navigator.push(
                                                  context,
                                                  CupertinoPageRoute(
                                                      builder: (context) =>
                                                          ShopsRoute(
                                                              shops: shops)));
                                              print(
                                                  "${snapshot.data?[index].shops}");
                                            },
                                          ),
                                        ),
                                      ],
                                    )
                                    /*Column(
                                children: [
                                  ListTile(
                                    title: Text(snapshot.data![index].name),
                                    subtitle: Text("${snapshot.data![index].price}"),
                                  )
                                ],
                              ),*/
                                    ),
                              ),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                height: 10,
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.width * 0.7,
                            ),
                            const Center(
                              child: CircularProgressIndicator(
                                color: darkBrown,
                              ), // Display loading indicator
                            ),
                          ],
                        );
                      }
                    },
                  ),
                  /*Text("name: ${widget.req?.name}"),
                Text("size:${widget.req?.size}"),
                Text("colors: ${widget.req?.colors}"),
                Text("sortBy: ${widget.req?.sortBy}"),
                Text("sortOrder: ${widget.req?.sortOrder}"),
                Text("region: ${widget.req?.region}"),*/
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
