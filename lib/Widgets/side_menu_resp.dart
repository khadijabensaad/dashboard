import 'package:admintest/Controllers/navigation_controller.dart';
import 'package:admintest/Routes/SideMenuPages/profile_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/const_colors.dart';
import '../constants/controllers.dart';
import '../Routes/route/routes.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.8,
      backgroundColor: backgoundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Obx(() => ListView(
              children: <Widget>[
                const SizedBox(
                  height: 40,
                ),
                ListTile(
                  onTap: () {
                    navigationController.navigateTo(dashBoardPageRoute);
                    //Get.to(() => const DashboardRouter());
                  },
                  leading: const Icon(
                    Icons.dashboard_outlined,
                    color: Colors.black,
                  ),
                  title: const Text(
                    "Dashboard",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                ListTile(
                  onTap: () => _handleTileTap("Products"),
                  leading: const Icon(
                    CupertinoIcons.cube,
                    color: Colors.black,
                  ),
                  title: const Text(
                    "Products",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  trailing: const Icon(Icons.arrow_drop_down),
                ),
                if (NavigationController.instance.selectedMenuItem.value ==
                        "Products" &&
                    NavigationController
                        .instance.selectedSubMenu.value.isNotEmpty)
                  Column(
                    children: [
                      for (String item in NavigationController
                          .instance.selectedSubMenu.value)
                        buildSubMenuItem(
                            [], item, 0), // Adjust parameters as needed
                    ],
                  ),
                ListTile(
                  onTap: () {
                    navigationController.navigateTo(profilePageRoute);
                    //Get.to(() => const ProfileRouter(id: '',));
                  },
                  leading: const Icon(
                    Icons.person_outlined,
                    color: Colors.black,
                  ),
                  title: const Text(
                    "Profile",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    navigationController.navigateTo(usersPageRoute);
                    //Get.to(() => const DashboardRouter());
                  },
                  leading: const Icon(
                    // Icons.rate_review_outlined,
                    Icons.supervisor_account_outlined,
                    color: Colors.black,
                  ),
                  title: const Text(
                    "Users",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                   // navigationController.navigateTo(discountsPageRoute);
                    _handleTileTapDiscount("Discounts");
                  },
                  leading: const Icon(
                    Icons.price_change_outlined,
                    color: Colors.black,
                  ),
                  title: const Text(
                    "Discounts",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  trailing: const Icon(Icons.arrow_drop_down),
                ),
                if (NavigationController.instance.selectedMenuItem.value ==
                        "Discounts" &&
                    NavigationController
                        .instance.selectedSubMenu.value.isNotEmpty)
                  Column(
                    children: [
                      for (String item in NavigationController
                          .instance.selectedSubMenu.value)
                        buildSubMenuItem(
                            [], item, 0), // Adjust parameters as needed
                    ],
                  ),
                /*  ListTile(
                  onTap: () {
                    navigationController.navigateTo(mediaPageRoute);
                    //Get.to(() => const DashboardRouter());
                  },
                  leading: const Icon(
                    Icons.photo_outlined,
                    color: Colors.black,
                  ),
                  title: const Text(
                    "Media",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    navigationController.navigateTo(settingsPageRoute);
                    //Get.to(() => const DashboardRouter());
                  },
                  leading: const Icon(
                    Icons.settings_outlined,
                    color: Colors.black,
                  ),
                  title: const Text(
                    "Settings",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    navigationController.navigateTo(historyPageRoute);
                    //Get.to(() => const DashboardRouter());
                  },
                  leading: const Icon(
                    Icons.history_outlined,
                    color: Colors.black,
                  ),
                  title: const Text(
                    "History",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),*/
                ListTile(
                  onTap: () {
                    //Get.to(() => const DashboardRouter());
                    navigationController.navigateTo(signOutPageRoute);
                  },
                  leading: const Icon(
                    Icons.logout_outlined,
                    color: Colors.black,
                  ),
                  title: const Text(
                    "Sign Out",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 1000,
                ),
              ],
            )),
      ),
    );
  }

  void _handleTileTap(String title) {
    if (NavigationController.instance.selectedMenuItem.value != title) {
      // If the selected menu item is different than the current one,
      // update the selected menu item and submenu
      NavigationController.instance.selectedMenuItem.value = title;
      // Here you can fetch submenu items based on the selected title
      // For now, let's assume the submenu items are hardcoded
      List<String> subMenuItems = [];
      switch (title) {
        case "Products":
          subMenuItems = [
            "Add New",
            "All Products",
            "Categories",
            "Brands",
            "Shops"
          ];
        case "Discounts":
          subMenuItems = [
            "Add new discount",
          ];

          break;
        // Add cases for other menu items if needed
      }
      NavigationController.instance.selectedSubMenu.value = subMenuItems;
    } else {
      // If the selected menu item is the same as the current one,
      // toggle the visibility of the submenu
      NavigationController.instance.selectedSubMenu.value =
          NavigationController.instance.selectedSubMenu.value.isEmpty
              ? [
                  "Add New",
                  "All Products",
                  "Categories",
                  "Brands",
                  "Shops",
                  "Add new discount"
                ]
              : [];
    }
  }

  void _handleTileTapDiscount(String title) {
    if (NavigationController.instance.selectedMenuItem.value != title) {
      // If the selected menu item is different than the current one,
      // update the selected menu item and submenu
      NavigationController.instance.selectedMenuItem.value = title;
      // Here you can fetch submenu items based on the selected title
      // For now, let's assume the submenu items are hardcoded
      List<String> subMenuItems = [];
      switch (title) {
        case "Discounts":
          subMenuItems = [
            "Add new discount",
            "All discounts"
          ];

          break;
        // Add cases for other menu items if needed
      }
      NavigationController.instance.selectedSubMenu.value = subMenuItems;
    } else {
      // If the selected menu item is the same as the current one,
      // toggle the visibility of the submenu
      NavigationController.instance.selectedSubMenu.value =
          NavigationController.instance.selectedSubMenu.value.isEmpty
              ? ["Add new discount","All discounts"]
              : [];
    }
  }

  Widget buildSubMenuItem(List<String> data, String title, int index) {
    // You need to implement your logic here to build a submenu item
    // For now, let's just return a simple ListTile with the title
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 13,
          fontWeight: FontWeight.w600,
          fontFamily: 'Poppins',
        ),
      ),
      onTap: () {
        switch (title) {
          case "Add New":
            navigationController.navigateTo(addNewPageRoute);
            break;
          case "All Products":
            navigationController.navigateTo(allProductsPageRoute);
            break;
          case "Categories":
            navigationController.navigateTo(categoriesPageRoute);
            break;
          case "Brands":
            navigationController.navigateTo(brandsPageRoute);
            break;
          case "Shops":
            navigationController.navigateTo(shopsPageRoute);
            break;
          case "Add new discount":
            navigationController.navigateTo(addNewDiscountPageRoute);
            break;
              case "All discounts":
            navigationController.navigateTo(discountsPageRoute);
            break;
          default:
            navigationController.navigateTo(dashBoardPageRoute);
        }
      },
    );
  }
}
