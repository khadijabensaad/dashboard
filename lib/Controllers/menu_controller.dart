/*import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Routes/route/routes.dart';

class MenuController extends GetxController {
  static MenuController instance = Get.find();
  var activeItem = dashBoardPageRoute.obs;
  var hoverItem = "".obs;
  changeActiveItemTo(String itemName) {
    activeItem.value = itemName;
  }

  onHover(String itemName) {
    if (!isActive(itemName)) hoverItem.value = itemName;
  }

  isActive(String itemName) => activeItem.value == itemName;

  isHovering(String itemName) => hoverItem.value == itemName;

  Widget returnIconFor(String itemName) {
    switch (itemName) {
      case dashBoardPageRoute:
        return _customIcon(Icons.dashboard_outlined, itemName);
      case profilePageRoute:
        return _customIcon(Icons.person_outlined, itemName);
     /* case usersPageRoute:
        return _customIcon(Icons.star_rate_outlined, itemName);
      case discountsPageRoute:
        return _customIcon(Icons.Discounts_outlined, itemName);
      case mediaPageRoute:
        return _customIcon(Icons.photo_outlined, itemName);
      case settingsPageRoute:
        return _customIcon(Icons.settings_outlined, itemName);
      case historyPageRoute:
        return _customIcon(Icons.history_outlined, itemName);*/
      default:
        return _customIcon(Icons.logout_outlined, itemName);
    }
  }

  Widget _customIcon(IconData icon, String itemName) {
    if (isActive(itemName))
      return Icon(
        icon,
        size: 22,
        color: Colors.black,
      );

    return Icon(icon, color: isHovering(itemName) ? Colors.black : Colors.grey);
  }
}
*/