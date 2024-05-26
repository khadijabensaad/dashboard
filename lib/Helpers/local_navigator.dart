import 'package:flutter/material.dart';
//import 'package:jwt_decoder/jwt_decoder.dart';

import '../Routes/route/router_generator.dart';
import '../Routes/route/routes.dart';
//import '../Routes/SideMenuPages/profile_router.dart';
//import '../Views/Auth/login.dart';
//import '../Widgets/DashboardsWidgets/dashboard_widget.dart';
import '../constants/controllers.dart';

/*Route<dynamic>? localNavigator(RouteSettings settings) {
  // Your route generation logic goes here
  switch (settings.name) {
    case dashBoardPageRoute:
      return _getPageRoute(DashBoardWidget());
    case profilePageRoute:
      initSharedPref().then((_) {
        var token = prefs.getString("userToken");
        Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(token!);
        email = jwtDecodedToken['email'];
        name = jwtDecodedToken['name'];
        profilePic = jwtDecodedToken['image'];
        print(profilePic);
        identifier = jwtDecodedToken['id'];
      });
      return _getPageRoute(const ProfileRouter(id: ''));
    // Handle other cases similarly
    default:
      return _getPageRoute(const LoginPage());
  }
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}*/

Navigator localNavigator() => Navigator(
      key: navigationController.navigationKey,
      initialRoute: dashBoardPageRoute,
      onGenerateRoute: generateRoute,
    );
