import 'package:admintest/Routes/SideMenuPages/analytics_router.dart';
import 'package:admintest/Routes/SideMenuPages/history_router.dart';
import 'package:admintest/Routes/SideMenuPages/media_router.dart';
import 'package:admintest/Routes/SideMenuPages/profile_router.dart';
import 'package:admintest/Routes/SideMenuPages/review_router.dart';
import 'package:admintest/Routes/SubMenuPages/all_products_routes.dart';
import 'package:admintest/Routes/SubMenuPages/all_brands_route.dart';
import 'package:admintest/Routes/SubMenuPages/all_categories_route.dart';
import 'package:admintest/Routes/SubMenuPages/all_shops_route.dart';
import 'package:admintest/Routes/route/routes.dart';
import 'package:admintest/Widgets/DashboardsWidgets/dashboard_widget.dart';
import 'package:flutter/material.dart';
import '../SideMenuPages/settings_router.dart';
import '../SubMenuPages/add_new_product_route.dart';

// Define a function to generate routes based on RouteSettings
PageRoute generateRoute(RouteSettings settings) {
  // Your route generation logic goes here
  // You can use settings.name to determine which route to generate
  switch (settings.name) {
    case dashBoardPageRoute:
      return _getPageRoute( DashBoardWidget());
    case profilePageRoute:
      return _getPageRoute(const ProfileRoute());
    case reviewsPageRoute:
      return _getPageRoute(const ReviewRoute());
    case analyticsPageRoute:
      return _getPageRoute(const AnalyticsRoute());
    case mediaPageRoute:
      return _getPageRoute(const MediaRoute());
    case settingsPageRoute:
      return _getPageRoute(const SettingsRoute());
    case historyPageRoute:
      return _getPageRoute(const HistoryRoute());
    case addNewPageRoute:
      return _getPageRoute(const AddProduct());
    case allProductsPageRoute:
      return _getPageRoute(AllProductsRoute());
    case categoriesPageRoute:
      return _getPageRoute(CategoriesRoute());
    case brandsPageRoute:
      return _getPageRoute(BrandsRoute());
    case shopsPageRoute:
      return _getPageRoute(ShopsRoute());
    default:
      return _getPageRoute( DashBoardWidget());
  }
}

// Define a function to get a MaterialPageRoute with the given child widget
PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}
