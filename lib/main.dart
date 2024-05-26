import 'package:admintest/Views/Auth/login.dart';
import 'Controllers/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'constants/const_colors.dart';
//import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  Get.put(MenuController());
  Get.put(NavigationController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //return GetMaterialApp
    return GetMaterialApp(
      debugShowCheckedModeBanner: false, //tna7i il faza il 7amra
      title: 'Find Me admin Dashborad',
      theme: ThemeData(
        scaffoldBackgroundColor: backgoundColor,
        fontFamily: 'Poppins',
        /*  textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ).apply(
          bodyColor: Colors.black,
        ),*/
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder()
        }),
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        // useMaterial3: true,
      ),
      //  home: SearchFakeProducts(),
      home: const LoginPage(),
    );
  }
}
