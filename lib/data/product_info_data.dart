import '../Models/GraphsModels/product_info_model.dart';

class ProductInfo {
  final productInfoData = const [
    ProductInfoModel(
        icon: 'assets/icons/products.png',
        value: '1000',
        title: 'Total products'),
    ProductInfoModel(
      icon: 'assets/icons/shops.png',
      value: '100',
      title: 'Total shops',
    ),
    ProductInfoModel(
      icon: 'assets/icons/users.png',
      value: '50',
      title: 'Total users',
    ),
    ProductInfoModel(
      icon: 'assets/icons/deals2.png',
      value: '32',
      title: 'Total deals',
    )
  ];
}
