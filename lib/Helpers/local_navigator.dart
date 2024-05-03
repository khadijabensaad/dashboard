import 'package:admintest/Routes/route/router_generator.dart';
import 'package:admintest/Routes/route/routes.dart';
import 'package:admintest/constants/controllers.dart';
import 'package:flutter/material.dart';

Navigator localNavigator() => Navigator(
      key: navigationController.navigationKey,
      initialRoute: dashBoardPageRoute,
      onGenerateRoute: generateRoute,
    );
