import 'dart:convert';
import 'package:eshop/model/FavouriteProduct.dart';
import 'package:eshop/model/product_data.dart';
import 'package:eshop/utils/constants.dart';
import 'package:http/http.dart' as http;

Future<List<Product>?> fetchProduct(String accessToken, String? supplierId,
    String? categoryId, String searchTerm, int offset, int limit) async {
  final response = await http.get(
      Uri.parse(Constants.apiPath +
          "/Product/GetAll?CategoryId=$categoryId&SupplierId=$supplierId&SearchTerm=$searchTerm&Offset=1&Limit=$limit"),
      headers: {
        'Content-Type': 'application/json',
        'access_token': accessToken,
      });

  if (response.statusCode == 200) {
    return productDataFromJson(response.body).product;
  } else {
    return null;
  }
}

Future<List<Product>?> fetchProductHot(String accessToken, String supplierId,
    String cityId, String categoryId, int offset, int limit) async {
  try {
    final response = await http.get(
        Uri.parse(Constants.apiPath +
            "/Product/GetAllHot?Offset=1&Limit=200&SupplierId=0&CategoryId=0&cityid=$cityId"),
        headers: {
          'Content-Type': 'application/json',
          'access_token': accessToken,
        });

    if (response.statusCode == 200) {
      return productDataFromJson(response.body).product;
    } else {
      return null;
    }
  } catch (e) {}
}

Future addFavouriteProduct(String accessToken, String productId) async {
  print("kira$accessToken =====d=== $productId");
  final http.Response response =
      await http.post(Uri.parse(Constants.apiPath + "/Favorites"),
          headers: {
            'Content-Type': 'application/json',
            'access_token': accessToken,
          },
          body: jsonEncode({"productId": productId}));

  // if (response.statusCode == 201) {
  //   return productDataFromJson(response.body).product;
  // } else {
  //   print(response.statusCode);
  //   return null;
  // }
}

Future removeFavouriteProduct(String accessToken, String productId) async {
  print("kira$accessToken =====f==  $productId");
  final http.Response response = await http.delete(
    Uri.parse(Constants.apiPath + "/Favorites/$productId"),
    headers: {
      'Content-Type': 'application/json',
      'access_token': accessToken,
    },
  );
  // Log.d(response.body);
  // Log.e(response.statusCode.toString());
  // if (response.statusCode == 204) {
  //   return productDataFromJson(response.body).product;
  // } else {
  //   print(response.statusCode);
  //   return null;
  // }
}

Future<List<FavouriteProduct>?> getAllFavouriteProducts(
    String accessToken) async {
  try {
    final http.Response response =
        await http.get(Uri.parse(Constants.apiPath + "/Favorites"), headers: {
      'Content-Type': 'application/json',
      'access_token': accessToken,
    });

    if (response.statusCode == 200) {
      return favouriteProductFromJson(response.body);
    } else {
      return null;
    }
  } catch (e) {
    // Log.e(e.toString());
    return null;
  }
}
