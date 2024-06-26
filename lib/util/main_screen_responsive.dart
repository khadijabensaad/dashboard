import 'package:admintest/Helpers/local_navigator.dart';
import 'package:admintest/util/responsive_ui.dart';
import '../Routes/route/router_generator.dart';
import '../Widgets/side_menu_resp.dart';
import '../Widgets/summary_widget.dart';
import 'package:flutter/material.dart';

class MainScreenResponsive extends StatelessWidget {
  const MainScreenResponsive({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveUI.isDesktop(context);
    return Scaffold(
      //kenou tablet wala mobile rajaali sizedBox bdrawer else mataamal chay
      drawer: !isDesktop
          ? const SizedBox(
              width: 250,
              child: SideMenu(),
            )
          : null,
      endDrawer: ResponsiveUI.isMobile(context)
          ? SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: const SummaryWidget())
          : null,
      body: SafeArea(
          child: Row(
        children: [
          if (isDesktop)
            const Expanded(
              flex: 2,
              child: SizedBox(
                child: SideMenu(),
              ),
            ),
          /*Expanded(
            flex: 7,
            child: localNavigator(),
          ),*/
          Expanded(
            flex: 7,
            child: FutureBuilder(
              future:
                  initSharedPref(), // Call initSharedPref() to initialize SharedPreferences
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return localNavigator(); // Render localNavigator once SharedPreferences is initialized
                }
              },
            ),
          ),
          if (isDesktop)
            const Expanded(
              flex: 3,
              child: SummaryWidget(),
            ),
        ],
      )),
    );
  }
}
