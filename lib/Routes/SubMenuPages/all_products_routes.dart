import 'package:admintest/Controllers/CRUDControllers/products_api.dart';
import 'package:admintest/Models/CRUDModels/product_data_model.dart';
import 'package:admintest/Widgets/appbarwideget.dart';
import 'package:admintest/constants/const_colors.dart';
import 'package:flutter/material.dart';
import '../../Models/product_filter_model.dart';
import '../../Widgets/CRUDWidgets/product_details.dart';
import '../../Widgets/header_widget.dart';

class AllProductsRoute extends StatefulWidget {
  @override
  State<AllProductsRoute> createState() => _AllProductsRouteState();
}

class _AllProductsRouteState extends State<AllProductsRoute> {
  final ProductApiCall apiCall = ProductApiCall();
  ProductFilter? requette = ProductFilter(
      name: '',
      size: [],
      colors: '',
      sortBy: '',
      sortOrder: 'desc',
      region: '');
  int? nb = 0;

  void _handleFilterSubmitted(ProductFilter data) {
    setState(() {
      requette = data;
    });
  }

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
      appBar: const AppBarWidget(title: "All Products"),
      backgroundColor: backgoundColor, // AppBar
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
              child: FutureBuilder<List<ProductModel>>(
                future: apiCall.getAll(),
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
                            Scaffold.of(context)
                                .openDrawer(); // Open the drawer
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => ProductDetails(
                                  product: snapshot.data![index],
                                  index: index,
                                  currencySign: '',
                                  price: '.',
                                ),
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Container(
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      Scaffold.of(context)
                                          .openDrawer(); // Open the drawer
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (_) => ProductDetails(
                                            product: snapshot.data![index],
                                            index: index,
                                            currencySign: '',
                                            price: '.',
                                          ),
                                        ),
                                      );
                                    },
                                    child: Image.network(
                                      // snapshot.data![index].thumbnail,
                                      "http://192.168.0.179:5000/images/${snapshot.data![index].thumbnail}",
                                      height: 100,
                                      width: 110,
                                      fit: BoxFit.fill,
                                    ),
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
                                          Row(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  // Get.to(() => ReviewsPage());
                                                },
                                                child: const Icon(
                                                  Icons.star_rate_rounded,
                                                  color: orange,
                                                ),
                                              ),
                                              const SizedBox(width: 2),
                                              Text(
                                                snapshot.data![index].rating
                                                    .toString(),
                                                style: const TextStyle(
                                                    color: orange),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            '${snapshot.data![index].price} DT',
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 13,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(height: 3),
                                          /*   InkWell(
                                            onTap: () {
                                              // Check if the product is in the favorite list
                                              // if (isInFavorites) {
                                              //   controller.removeFromFavorites(controller.productsModel!.products![index]);
                                              // } else {
                                              //   controller.addToFavorites(controller.productsModel!.products![index]);
                                              // }
                                              // Get.to(() => FavoritesPage());
                                            },
                                            child: const Icon(
                                              Icons.favorite_rounded,
                                              // color: isInFavorites ? Colors.red : null,
                                              size: 20,
                                            ),
                                          ),*/
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 37,
                                  height: 37,
                                  child: const Icon(
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
          ],
        ),
      ),
    );
  }
}
/*
import 'package:admintest/Controllers/CRUDControllers/products_api.dart';
import 'package:admintest/Models/CRUDModels/product_data_model.dart';
import 'package:admintest/Widgets/appbarwideget.dart';
import 'package:admintest/Widgets/side_menu_resp.dart';
import 'package:flutter/material.dart';
import '../../Models/product_filter_model.dart';
import 'package:flutter/cupertino.dart';
import '../../Widgets/header_widget.dart';

class AllProductsRoute extends StatefulWidget {
  const AllProductsRoute({super.key, this.req});
  final ProductFilter? req;

  @override
  State<AllProductsRoute> createState() => _SearchPageState();
}

class _SearchPageState extends State<AllProductsRoute> {
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

  void _handleFilterSubmitted(ProductFilter data) {
    setState(() {
      requette = data;
    });
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
      backgroundColor: const Color(0xFFFDF1E1),
      drawer: const SideMenu(),
      appBar: const AppBarWidget(title: 'Find Me'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderWidget(
                    scaffoldContext: context, cntrl: _searchController),
                FutureBuilder<List<ProductModel>>(
                  future: _productApiCall.searchProductsWithFilter(
                      ProductFilter(
                          name: widget.req?.name,
                          colors: widget.req?.colors,
                          sortBy: widget.req?.sortBy,
                          sortOrder: widget.req?.sortOrder,
                          region: widget.req?.region,
                          size: widget.req?.size)),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
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
                                      style:const  TextStyle(
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
                                              AllProductsRoute(req: requette),
                                        ));
                                  },
                                  icon:const  Icon(
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
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) => ProductDetails(
                                            product: snapshot.data![index],
                                            index: index,
                                            currencySign: '',
                                            price: '.',
                                          ));
                            );},
                              child: Container(
                                  margin: const EdgeInsets.only(left: 2),
                                  child: Row(
                                    children: [
                                      Container(
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Image.network(
                                          "http://192.168.1.15:5000/images/${snapshot.data![index].thumbnail}",
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.3,
                                          width: 110,
                                          fit: BoxFit.fill,
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
                                                    fontWeight: FontWeight.w600,
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
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.star_rate_rounded,
                                                      color: Color(0xFFFFBD59),
                                                    ),
                                                    const SizedBox(
                                                      width: 2,
                                                    ),
                                                    Text(
                                                      "${snapshot.data?[index].rating}",
                                                      style: const TextStyle(
                                                          color: Color(
                                                              0xFFFFBD59)),
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
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 3,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    /*
                                              // Check if the product is in the favorite list
                                              if (isInFavorites) {
                                                // If the product is already in favorites, remove it
                                                controller.removeFromFavorites(
                                                    controller.productsModel!
                                                        .products![index]);
                                              } else {
                                                // If the product is not in favorites, add it
                                                controller.addToFavorites(
                                                    controller.productsModel!
                                                        .products![index]);
                                              }
                                              //  Get.to(() => FavoritesPage());
                                              */
                                                  },
                                                  child: Icon(
                                                    Icons.favorite_rounded,
                                                    color: Colors.grey,
                                                    /*isInFavorites                           //khedmet khadija
                                                  ? Colors.red
                                                  : null,*/
                                                    size: 20,
                                                  ),
                                                ),

                                                /* InkWell(
                                            onTap: () {
                                              if (isFavorite) {
                                                controller.removeFromFavorites(
                                                    controller.productsModel!
                                                        .products![index]);
                                              } else {
                                                controller.addToFavorites(
                                                    controller.productsModel!
                                                        .products![index]);
                                              }
                                              Get.to(() => FavoritesPage());
                                            },
                                            child: Icon(
                                              Icons.favorite_rounded,
                                              color: isFavorite
                                                  ? Colors.red
                                                  : null,
                                              size: 20,
                                            ),
                                          ),*/
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 40,
                                        height: 40,
                                        child: IconButton(
                                          icon: Icon(
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
                                                        ShopsList(
                                                            shops: shops)));
                                            print(
                                                "${snapshot.data?[index].shops}");
                                          },
                                        ),
                                        decoration: const ShapeDecoration(
                                          color: Color(0xFFFFBD59),
                                          shape: OvalBorder(),
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
                              color: Color(0xFF965D1A),
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
    );
  }
}
*/