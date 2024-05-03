import 'package:admintest/util/responsive_ui.dart';

import '../DashboardsWidgets/custom_card_widget.dart';
import '../../data/product_info_data.dart';
import 'package:flutter/material.dart';

class ProductInfoCards extends StatelessWidget {
  const ProductInfoCards({super.key});

  @override
  Widget build(BuildContext context) {
    final productInfo = ProductInfo();
    return GridView.builder(
      itemCount: productInfo.productInfoData.length,
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: ResponsiveUI.isMobile(context) ? 2 : 4,
          crossAxisSpacing: ResponsiveUI.isMobile(context) ? 12 : 15,
          mainAxisSpacing: 12),
      itemBuilder: (context, index) => CustomCard(
        child: Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(productInfo.productInfoData[index].icon, width: 35),
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 5),
                  child: Text(
                    productInfo.productInfoData[index].value,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 11, bottom: 4),
                  child: Text(
                    productInfo.productInfoData[index].title,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins'),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
