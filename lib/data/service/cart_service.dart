import 'dart:convert';
import 'package:eshop/model/cart_data.dart';
import 'package:eshop/utils/constants.dart';
import 'package:eshop/utils/log.dart';
import 'package:http/http.dart' as http;

Future<List<CartData>> fetchCartItems(String token) async {
  try {
    final response =
        await http.get(Uri.parse(Constants.apiPath + "/Carts"), headers: {
      "access_token": token,
    });

    if (response.statusCode == 200) {
      return cartDataFromJson(response.body);
    } else {
      throw response.body;
    }
  } catch (e) {
    throw e;
  }
}

Future<String> addProductToCart(
    int? productId, int quantity, String? description, String token) async {
  try {
    final response = await http.post(Uri.parse(Constants.apiPath + "/Carts"),
        body: jsonEncode({
          "productId": productId,
          "quantity": quantity,
          "description": description,
        }),
        headers: {'Content-Type': 'application/json', "access_token": token});

    if (response.statusCode == 201) {
      return "done";
    } else if (response.statusCode == 401) {
      return "auth";
    } else {
      return "failed";
    }
  } catch (e) {
    throw e;
  }
}

Future<String> removeItemFromCart(int productId, String? token) async {
  try {
    final response = await http.delete(
      Uri.parse(
          "http://ahmedinara00-001-site1.dtempurl.com/api/Carts/$productId"),
      headers: {'Content-Type': 'application/json', "access_token": token!},
    );
    Log.d(response.statusCode.toString());
    Log.d(response.body.toString());
    if (response.statusCode == 204) {
      return "done";
    } else {
      return "failed";
    }
  } catch (e) {
    Log.e(e.toString());
    throw e;
  }
}

Future<String> cleartUserCart(String? token) async {
  try {
    final response = await http.delete(
      Uri.parse("https://api.khlihaalina.com/api/Orders/DeleteCart"),
      headers: {
        'Content-Type': 'application/json',
        'access_token': token!,
      },
    );
    // print(" abdo $token");
    if (response.statusCode == 204) {
      return "done";
    } else {
      return "failed";
    }
  } catch (e) {
    throw e;
  }
}
