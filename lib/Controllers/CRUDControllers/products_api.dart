import 'dart:io';
import 'package:admintest/Models/CRUDModels/product_data_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../Models/product_filter_model.dart';

class ProductApiCall {
  Future<List<ProductModel>> searchProductsWithFilter(
      ProductFilter filtre) async {
    List<ProductModel> products = [];
    try {
      const String url =
          "http://192.168.1.15:5000/products/searchProductsWithFilter";
      final http.Response resp = await http.post(Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: jsonEncode(filtre.toJson()));

      if (resp.statusCode == 200) {
        /*print("name ${filtre.name}");
      
      print("colors ${filtre.colors}");
      print("sortBy ${filtre.sortBy}");
      print("sortOrder ${filtre.sortOrder}");
      print("region ${filtre.region}");
      print("size: ${filtre.size}");*/
        List<dynamic> jsonResponse = json.decode(resp.body);
        products =
            jsonResponse.map((item) => ProductModel.fromJson(item)).toList();
        //print("${products.length} Products recieved");
        //print("${resp.body}");
        return products;
      } else {
        print("failed: ${resp.statusCode}");
      }
    } catch (error) {
      print("erreur: ${error}");
    }
    return [];
  }

  Future<List<ProductModel>> getAll() async {
    List<ProductModel> products = [];
    const String url = "http://192.168.0.179:5000/products/getAllProducts";
    final http.Response resp = await http.get(Uri.parse(url));
    if (resp.statusCode == 200) {
      // Decode the JSON response
      List<dynamic> jsonResponse = json.decode(resp.body);
      // Iterate over the list and create ProductModel objects
      products =
          jsonResponse.map((item) => ProductModel.fromJson(item)).toList();
      print("success");
      print(resp.body);
    } else {
      print("failed: ${resp.statusCode}");
    }
    return products;
  }

  Future<ProductModel?> getProductById(String productId) async {
    ProductModel? product; // Déclarer la variable product comme nullable
    final String url =
        "http://192.168.0.179:5000/products/getProduct/$productId";
    final http.Response resp = await http.get(Uri.parse(url));
    if (resp.statusCode == 200) {
      // Decode the JSON response
      Map<String, dynamic> jsonResponse = json.decode(resp.body);
      // Create a ProductModel object from the JSON data
      product = ProductModel.fromJson(jsonResponse);
      print("success");
      print(resp.body);
    } else {
      print("failed: ${resp.statusCode}");
    }
    return product;
  }

  Future<ProductModel> getProductByBarCode(String identifier) async {
    ProductModel product;
    try {
      String url =
          "http://192.168.0.179:5000/products/getProductByBarCode?barcode=${identifier}";
      final http.Response resp = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );
      if (resp.statusCode == 200) {
        dynamic jsonResponse = json.decode(resp.body);
        if (jsonResponse is List && jsonResponse.length > 0) {
          product = ProductModel.fromJson(jsonResponse[0]);
          print("succes");
          return product;
        }
      } else {
        print("failure: ${resp.statusCode}");
      }
      return ProductModel(
        id: '',
        price: -1,
        name: '',
        rating: -1,
        barcode: -1,
        thumbnail: '',
        images: [],
        colors: [],
        v: -1,
        brand: '',
        size: [],
        shops: [],
        description: '',
        category: [],
        //createdAt: DateTime.now(),
        // updatedAt: DateTime.now()
      );
    } catch (error) {
      print("$error");
      return ProductModel(
        id: '',
        price: -1,
        name: '',
        rating: -1,
        barcode: -1,
        thumbnail: '',
        images: [],
        colors: [],
        v: -1,
        brand: '',
        size: [],
        shops: [],
        description: '',
        category: [],
        // createdAt: DateTime.now(),
        // updatedAt: DateTime.now()
      );
    }
  }

  Future<void> addProduct(ProductModel product, List<File> images) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse("http://192.168.0.179:5000/products/addProduct"),
      );

      // Add product data to the request
      request.fields['name'] = product.name;
      request.fields['price'] = product.price.toString();
      request.fields['rating'] = product.rating.toString();
      request.fields['barcode'] = product.barcode.toString();
      request.fields['colors'] = product.colors.join(',');
      request.fields['description'] = product.description;
      request.fields['size'] = product.size.toString();
      request.fields['brand_id'] = product.brand;

      // Add the thumbnail file to the request
      var thumbnailFile = await http.MultipartFile.fromPath(
        'thumbnail',
        product
            .thumbnail, // Assuming thumbnail is a String representing the file path
      );
      request.files.add(thumbnailFile);

      // Add the images files to the request
      for (var image in images) {
        var imageFile = await http.MultipartFile.fromPath('images', image.path);
        request.files.add(imageFile);
      }

      // Send the request
      var streamedResponse = await request.send();

      // Process the response
      final resp = await http.Response.fromStream(streamedResponse);

      if (resp.statusCode == 200 || resp.statusCode == 201) {
        print("success");
      } else {
        print("echec: ${resp.statusCode}");
      }
    } catch (error) {
      print("erreur: ${error}");
    }
  }
}


  //

  /*Future<void> addProduct(ProductModel product) async {
    try {
      const String url = "http://192.168.0.179:5000/products/addProduct";
      //var headers = {'Content-Type': 'application/json; charset=UTF-8'};
      final resp = await http.post(Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          //khater l'ajout de user
          body: jsonEncode(product.toJson()));

      if (resp.statusCode == 200 || resp.statusCode == 201) {
        print("success");
      } else {
        print("echec: ${resp.statusCode}");
      }
    } catch (error) {
      print("erreur: ${error}");
    }
  }
}*/

/*
import 'dart:convert';
import '../Models/product_data_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class GetApiCall extends GetxController {
  @override
  void onInit() {
    // Initialize the controller
    super.onInit();
    // Fetch data when the controller is initialized
    getAllProducts();
  }

  // List to store favorite products
  List<ProductDataModel> favoritesList = [];

  // Model to store fetched products
  ProductDataModel? productsModel;

  // RxString to hold the URL of the selected product image
  RxString selectedProductImage = ''.obs;

  // Method to fetch data from the API
  Future<List<ProductDataModel>> getAllProducts() async {
    List<ProductDataModel> models = [];
    const url = "https://dummyjson.com/products";
    try {
      // Send a GET request to fetch data
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // If the request is successful, parse the response data
        models = productDataModelFromJson(response.body);
        print("success");
        update(); // Notify listeners about the change
      } else {
        // If the request fails, print the error message
        print("Failed to load data: ${response.statusCode}");
      }
    } catch (e) {
      // If an error occurs during the request, print the error
      print("Error loading data: $e");
    }
    return models;
  }

  // Method to add a product to favorites
  void addToFavorites(ProductDataModel product) {
    favoritesList.add(product);
    update(); // Notify listeners about the change
  }

  // Method to remove a product from favorites
  void removeFromFavorites(ProductDataModel product) {
    favoritesList.remove(product);
    update(); // Notify listeners about the change
  }

  // Method to update the selected product image URL
  void updateSelectedProductImage(String imageUrl) {
    selectedProductImage.value = imageUrl;
  }
}*/
