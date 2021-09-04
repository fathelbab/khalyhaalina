import 'dart:convert';
import 'package:eshop/model/cart_data.dart';
import 'package:eshop/utils/constants.dart';
// import 'package:eshop/utils/log.dart';
import 'package:http/http.dart' as http;

Future<List<CartData>> fetchCartItems(String token) async {
  try {
    final response =
        await http.get(Uri.parse(Constants.apiPath + "/Carts"), headers: {
      "access_token": token,
    });
    // Log.w(token.toString());
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
    // Log.w(quantity.toString());
    // Log.d(jsonEncode({
    //   "productId": productId,
    //   "qty": quantity,
    //   "description": description,
    // }));
    final response = await http.post(
      Uri.parse(Constants.apiPath + "/Carts"),
      body: jsonEncode({
        "productId": productId,
        "qty": quantity,
        "description": description,
      }),
      headers: {'Content-Type': 'application/json', "access_token": token},
    );
    // Log.w(response.body.toString());

    // Log.w(response.statusCode.toString());
    // Log.w(token.toString());
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

Future<String> updateCartItemQuantityService(int id, int? productId,
    int quantity, String? description, String token) async {
  // Log.d(jsonEncode(
  //   {
  //     "id": id,
  //     "productId": productId,
  //     "qty": quantity,
  //     "description": description,
  //   },
  // ));
  // Log.w(token);
  // Log.w(productId.toString());
  try {
    final response = await http.put(
      Uri.parse(Constants.apiPath + "/Carts/$id"),
      body: jsonEncode(
        {
          "id": id,
          "productId": productId,
          "qty": quantity,
          "description": description,
        },
      ),
      headers: {'Content-Type': 'application/json', "access_token": token},
    );
    // Log.d(response.body.toString());
    // Log.d(response.statusCode.toString());
    if (response.statusCode == 204) {
      return "done";
    } else {
      return "failed";
    }
  } catch (e) {
    // Log.e(e.toString());
    throw e;
  }
}

Future<String> removeItemFromCart(int productId, String? token) async {
  try {
    // kira
    final response = await http.delete(
      Uri.parse(Constants.apiPath+ "/Carts/$productId"),
      headers: {
        'Content-Type': 'application/json',
        "access_token": token!,
      },
    );
    // Log.d(response.statusCode.toString());
    // Log.d(response.body.toString());
    if (response.statusCode == 204) {
      return "done";
    } else {
      return "failed";
    }
  } catch (e) {
    // Log.e(e.toString());
    throw e;
  }
}

Future<String> cleartUserCart(String? token) async {
  try {
    final response = await http.delete(
      Uri.parse(Constants.apiPath + "/Orders/DeleteCart"),
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
