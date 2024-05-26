import 'package:admintest/Routes/SideMenuPages/profile_router.dart';
import 'package:admintest/Routes/SideMenuPages/signout_router.dart';

import 'package:admintest/Routes/SubMenuPages/all_brands_route.dart';
import 'package:admintest/Routes/SubMenuPages/all_categories_route.dart';
import 'package:admintest/Routes/SubMenuPages/all_shops_route.dart';
import 'package:admintest/Routes/route/routes.dart';
import 'package:admintest/Views/Auth/login.dart';
import 'package:admintest/Widgets/DashboardsWidgets/dashboard_widget.dart';
import 'package:admintest/util/main_screen_responsive.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Models/CRUDModels/user_model.dart';
import '../../Widgets/CRUDWidgets/addDiscount.dart';
import '../SideMenuPages/all_discount_route.dart';
import '../SideMenuPages/user_router.dart';
import '../SubMenuPages/add_new_product_route.dart';
import '../SubMenuPages/all_products_routes.dart';

late SharedPreferences prefs;
late String email = '';
late String name = '';
late String profilePic = '';
late String identifier = "";
Future<void> initSharedPref() async {
  prefs = await SharedPreferences.getInstance();
}

/*Route<dynamic>? generateRoute(RouteSettings settings) {
  // Your route generation logic goes here
  // You can use settings.name to determine which route to generate
  switch (settings.name) {
    case dashBoardPageRoute:
      return _getPageRoute(DashBoardWidget());
    case profilePageRoute:
      // Initialize shared preferences and handle profile route
      initSharedPref().then((_) {
        var token = prefs.getString("userToken");
        Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(token!);
        email = jwtDecodedToken['email'];
        name = jwtDecodedToken['name'];
        profilePic = jwtDecodedToken['image'];
        print(profilePic);
        identifier = jwtDecodedToken['id'];
      });
      return _getPageRoute(const ProfileRouter(
          id: '663e2a3b7cc7ca54d053c585')); // Assuming 'id' should be provided here
    // Handle other cases similarly
    default:
      return _getPageRoute(
          const LoginPage()); // Default route for unknown routes
  }
}
*/
// Define a function to generate routes based on RouteSettings
//Future<PageRoute> generateRoute(RouteSettings settings) async {
Route<dynamic>? generateRoute(RouteSettings settings) {
  // Your route generation logic goes here
  // You can use settings.name to determine which route to generate
  switch (settings.name) {
    case dashBoardPageRoute:
      return _getPageRoute(DashBoardWidget());
    case profilePageRoute:
      return MaterialPageRoute(
        builder: (_) {
          return FutureBuilder(
            future: initSharedPref(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                var token = prefs.getString("userToken");
                if (token != null) {
                  Map<String, dynamic> jwtDecodedToken =
                      JwtDecoder.decode(token);
                  email = jwtDecodedToken['email'];
                  name = jwtDecodedToken['name'];
                  profilePic = jwtDecodedToken['image'];
                  identifier = jwtDecodedToken['id'];

                  UserModel user = UserModel(
                    id: identifier,
                    email: email,
                    username: name,
                    image: profilePic,
                    password: '',
                    role: '',
                    v: 0,
                    activated: true,
                  );

                  return ProfileRouter(id: identifier, user: user);
                } else {
                  return LoginPage();
                }
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          );
        },
      );
    case usersPageRoute:
      return _getPageRoute(UsersRoute());
    case discountsPageRoute:
      return _getPageRoute(DiscountsRoute());
    /*  case mediaPageRoute:
      return _getPageRoute(const MediaRoute());
    case settingsPageRoute:
      return _getPageRoute(const SettingsRoute());
    case historyPageRoute:
      return _getPageRoute(const HistoryRoute());*/
    case signOutPageRoute:
      return _getPageRoute(SignOutPageRouter());
    case addNewPageRoute:
      return _getPageRoute(const AddProduct());
    case allProductsPageRoute:
      return _getPageRoute(const AllProductsRouter());
    case categoriesPageRoute:
      return _getPageRoute(CategoriesRoute());
    case brandsPageRoute:
      return _getPageRoute(BrandsRoute());
    case shopsPageRoute:
      return _getPageRoute(const ShopsRoute(
        shops: [],
      ));
    case addNewDiscountPageRoute:
      return _getPageRoute( AddDiscountRoute());

    default:
      return _getPageRoute(const MainScreenResponsive());
  }
}

// Define a function to get a MaterialPageRoute with the given child widget
PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}
