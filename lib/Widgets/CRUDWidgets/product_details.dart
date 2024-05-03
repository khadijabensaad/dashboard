import 'package:admintest/constants/const_colors.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import '../../Controllers/CRUDControllers/products_api.dart';
import '../../Models/CRUDModels/product_data_model.dart';
import '../appbarwideget.dart';
import 'package:admintest/util/responsive_ui.dart';

class ProductDetails extends StatelessWidget {
  final ProductModel product;
  final int index;
  final String currencySign, price;
  final bool isLarge;
  final bool lineThrough;
  final ProductApiCall productIdApiCall = ProductApiCall();

  ProductDetails({
    super.key,
    required this.product,
    required this.index,
    this.isLarge = false,
    this.lineThrough = false,
    required this.currencySign,
    required this.price,
  });

  String minimizeTitle(String title) {
    List<String> words = title.split(' ');
    return words.take(2).join(' ');
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveUI.isDesktop(context);
    final isTablet = ResponsiveUI.isTablet(context);
    return Scaffold(
      appBar: const AppBarWidget(
        title: 'Find Me',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                height: 2,
              ),
              Container(
                color: backgoundColor,
                child: Stack(
                  children: [
                    Center(
                      child: !(isDesktop || isTablet)
                          ? Container(
                              height: 300,
                              width: double.infinity,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: backgoundColor.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 3,
                                    offset: const Offset(0, 0),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  // snapshot.data![index].thumbnail,
                                  "http://192.168.0.179:5000/images/${product.thumbnail}",
                                  height: 100,
                                  width: 110,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            )
                          : Container(
                              height: 500,
                              width: double.infinity,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: backgoundColor.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 3,
                                    offset: const Offset(0, 0),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  // snapshot.data![index].thumbnail,
                                  "http://192.168.0.179:5000/images/${product.thumbnail}",
                                  height: 100,
                                  width: 110,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      left: 0,
                      child: SizedBox(
                        height: 100,
                        child: FutureBuilder<ProductModel?>(
                          future: productIdApiCall.getProductById(product.id),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(
                                  child: Text('Error: ${snapshot.error}'));
                            } else if (snapshot.hasData) {
                              return ListView.separated(
                                itemCount: snapshot.data!.images.length,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                physics: const AlwaysScrollableScrollPhysics(),
                                separatorBuilder: (_, __) =>
                                    const SizedBox(width: 10),
                                itemBuilder:
                                    (BuildContext context, int indeximg) {
                                  //   final imageSelected =  snapshot.data!.selectedProductImage == snapshot.data!.images![indeximg];

                                  return Container(
                                    width: 80,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Colors.transparent,
                                        width: 2,
                                      ),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        "http://192.168.0.179:5000/images/${product.images[indeximg]}",
                                        //   product.images[indeximg],
                                        width: 80,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  );
                                },
                              );
                            } else {
                              return const SizedBox(); // Placeholder
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        Text(
                          minimizeTitle(product.name),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        const Icon(Icons.share),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        IconButton(
                            icon: const Icon(
                              Icons.star_rate_rounded,
                              color: Color(0xFFFFBD59),
                            ),
                            onPressed:
                                () {} // Get.to(() => const ReviewsPage()),
                            ),
                        const SizedBox(width: 2),
                        Text(
                          '${product.rating}',
                          style: const TextStyle(color: orange),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Brand',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          product.brand,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Details",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      child: ReadMoreText(
                        product.description,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                        trimCollapsedText: "Show more",
                        trimExpandedText: " less",
                        trimLines: 1,
                        trimMode: TrimMode.Line,
                        colorClickableText: Colors.black,
                        moreStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 11,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w800,
                        ),
                        lessStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 11,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 130, right: 100, bottom: 10, top: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 45,
                            height: 45,
                            child: Icon(
                              Icons.location_on_outlined,
                              color: Colors.white,
                            ),
                            decoration: const ShapeDecoration(
                              color: Color(0xFFFFBD59),
                              shape: CircleBorder(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    const SizedBox(height: 10),
                    const Text(
                      "Reviews (4)",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
/*
import 'package:admintest/Widgets/side_menu_resp.dart';
import 'package:admintest/constants/const_colors.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import '../../Controllers/CRUDControllers/osm_map.dart';
import '../../Controllers/CRUDControllers/products_api.dart';
import '../../Models/CRUDModels/product_data_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../Helpers/colors_help.dart';

class ProductDetail extends StatefulWidget {
  ProductDetail({
    super.key,
    required this.identifier,
    required this.product,
    required this.index,
    this.isLarge = false,
    this.lineThrough = false,
    required this.currencySign,
    required this.price,
  });
  final String identifier;
  final ProductModel product;
  final int index;
  final String currencySign, price;
  final bool isLarge;
  final bool lineThrough;
  final ProductApiCall productIdApiCall = ProductApiCall();

  String minimizeTitle(String title) {
    List<String> words = title.split(' ');
    return words.take(2).join(' ');
  }

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  final ProductApiCall _productApiCall = ProductApiCall();
  //HelperFunctions _helperFunctions = HelperFunctions();
  final HelperFunctions _helperFunctions = HelperFunctions();
  String id = "";
  int barcode = 0;
  bool _favoriteTapped = false;
  late ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgoundColor,
        drawer: const SideMenu(),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          child: Column(children: [
            const SizedBox(
              height: 20,
            ),
            /*
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 2.8,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 220, 198, 170)
                          .withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: const Offset(0, 0),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: 
                         InkWell(child: Image.asset("assets/images/profile2.jpg",fit: BoxFit.fill,),
                         onTap: () {
                           print("Detail page:  ${widget.identifier}");
                         },)
                                          
              ),
              ),*/
            FutureBuilder<ProductModel>(
              future: _productApiCall.getProductById(product.id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  //List<String> images = snapshot.data!.images;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 2.8,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.separated(
                          separatorBuilder: (context, index) => const SizedBox(
                            width: 5,
                          ),
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.images.length,
                          itemBuilder: (context, index) => Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors
                                    .transparent, // Set the border color here
                                width: 2.0, // Set the border width here
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color.fromARGB(255, 220, 198, 170)
                                          .withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                  offset: const Offset(0, 0),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  "http://192.168.1.15:5000/images/${snapshot.data?.images[index]}",
                                  fit: BoxFit.fill,
                                  width:
                                      MediaQuery.of(context).size.width * 0.85,
                                )),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 20, bottom: 0),
                        child: Text(
                          "${snapshot.data?.name}",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                              icon: const Icon(
                                Icons.star_rate_rounded,
                                color: Color(0xFFFFBD59),
                              ),
                              onPressed: () {}),
                          Text(
                            "${snapshot.data?.rating}",
                            style: const TextStyle(
                                color: Color(0xFFFFBD59),
                                fontFamily: 'Poppins',
                                fontSize: 16),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  "Brand:    ",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Poppins',
                                      fontSize: 16),
                                ),
                                Text(
                                  "${snapshot.data?.brand}",
                                  style: const TextStyle(
                                      color: orange,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Poppins',
                                      fontSize: 16),
                                )
                              ],
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    _favoriteTapped = !_favoriteTapped;
                                  });
                                },
                                icon: Icon(
                                  CupertinoIcons.heart_fill,
                                  color: _favoriteTapped
                                      ? Colors.red
                                      : Colors.black26,
                                ))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 255, 220, 169),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(255, 161, 155, 146)
                                    .withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 3,
                                offset: const Offset(0, 0),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(children: [
                                  const Text(
                                    "Price",
                                    //  maxLines: 2,
                                    //  overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontFamily: 'poppins',
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const SizedBox(
                                              width: 16,
                                            ),
                                            Text(
                                              snapshot.data?.price == 90
                                                  ? '     '
                                                  : //condition remise discount promotion
                                                  ' ${snapshot.data?.price} DT',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall!
                                                  .apply(
                                                      decoration: TextDecoration
                                                          .lineThrough),
                                            ),

                                            const SizedBox(width: 10),

                                            /// Sale Price
                                            Text(
                                              "${snapshot.data?.price}"
                                              r" DT",
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 13,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                        /*
                                        const Row(children: [
                                          Text(
                                            "Stock:",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 10,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 6,
                                          ),
                                          Text(
                                            "In Stock",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ]),*/
                                      ]),
                                ]),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                "Colors",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              height: 40,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: ListView.separated(
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                    width: 5,
                                  ),
                                  scrollDirection: Axis.horizontal,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: snapshot.data!.colors.length,
                                  itemBuilder: (context, index) => Container(
                                    width: 40,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black, width: 2),
                                      borderRadius: BorderRadius.circular(50),
                                      color: HelperFunctions.getColor(
                                          "${snapshot.data?.colors[index]}")!,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Size",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    height: 40,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 0.0),
                                      child: ListView.separated(
                                        separatorBuilder: (context, index) =>
                                            const SizedBox(
                                          width: 5,
                                        ),
                                        scrollDirection: Axis.horizontal,
                                        itemCount: snapshot.data!.size.length,
                                        itemBuilder: (context, index) =>
                                            Container(
                                          alignment: Alignment.center,
                                          width: 50,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 255, 220, 169),
                                            border: Border.all(
                                                color: Colors.black38,
                                                width: 1),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Text(
                                            "${snapshot.data?.size[index]}",
                                            style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    "Description",
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ReadMoreText(
                                    "${snapshot.data?.description}",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                    ),
                                    trimCollapsedText: "Show more",
                                    trimExpandedText: " less",
                                    trimLines: 2,
                                    trimMode: TrimMode.Line,
                                    colorClickableText: Colors.black,
                                    moreStyle: const TextStyle(
                                      color: orange,
                                      fontSize: 12,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w800,
                                    ),
                                    lessStyle: const TextStyle(
                                      color: orange,
                                      fontSize: 12,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    "Shops",
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: snapshot.data!.shops.length * 150,
                                    width: MediaQuery.of(context).size.width,
                                    child: ListView.separated(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () async {
                                              var status = await Permission
                                                  .location
                                                  .request();
                                              if (status.isGranted) {
                                                Navigator.push(
                                                    context,
                                                    CupertinoPageRoute(
                                                        builder: (context) =>
                                                            ShopMap(
                                                              name:
                                                                  '${snapshot.data?.shops[index]}',
                                                            )));
                                              } else {
                                                print(
                                                    "Location permission is required to use the app.");
                                              }
                                            },
                                            child: Container(
                                              clipBehavior: Clip.antiAlias,
                                              height: 100,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.8,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors
                                                      .black, // Set the border color here
                                                  width:
                                                      1, // Set the border width here
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: const Color.fromARGB(
                                                            255, 220, 198, 170)
                                                        .withOpacity(0.5),
                                                    spreadRadius: 2,
                                                    blurRadius: 3,
                                                    offset: const Offset(0, 0),
                                                  ),
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                    "assets/images/marketplace.png",
                                                    width: 90,
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "${snapshot.data?.shops[index]}",
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                'Poppins',
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                        separatorBuilder: (context, index) =>
                                            const SizedBox(height: 10),
                                        itemCount: snapshot.data!.shops.length),
                                  )
                                ],
                              ),
                            ),
                          ]),
                    ],
                  );
                } else {
                  print(
                      "Hello error fi product detail page: ${snapshot.error}");
                  return const Center(
                      child:
                          //Text("hello ${snapshot.error}")
                          CircularProgressIndicator(
                    color: darkBrown,
                  ));
                }
              },
            )
          ]),
        ))));
  }
}

mixin HelperFunctions {}
*/