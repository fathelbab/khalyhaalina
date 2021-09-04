import 'dart:convert';
import 'package:eshop/model/announcement_data.dart';
import 'package:eshop/model/cart_data.dart';
import 'package:eshop/model/image_data.dart';
import 'package:eshop/model/notification_data.dart';
import 'package:eshop/model/product_data.dart';

import 'package:eshop/model/supplier_data.dart';

import 'package:eshop/utils/constants.dart';
import 'package:eshop/utils/log.dart';
import 'package:http/http.dart' as http;

// headers: {HttpHeaders.contentTypeHeader: "application/json",
// HttpHeaders.authorizationHeader: "Bearer $token"}

Future<List<Product>?> searchWithTerm(
    String? searchTerm, int offset, int limit) async {
  try {
    final response = await http.get(Uri.parse(Constants.apiPath +
        "/Product/GetAll?SearchTerm=$searchTerm&Offset=$offset&Limit=$limit"));
    // print(apiPath +
    //     "/Product/GetAll?CategoryId=$categoryId&SupplierId=$supplierId&Offset=1&Limit=100");
    // print(response.statusCode);
    // print(response.body.toString());

    if (response.statusCode == 200) {
      ProductData productDataFromJson(String str) =>
          ProductData.fromJson(json.decode(str));

      // print(response.body);
      return productDataFromJson(response.body).product;
    } else {
      // print(response.statusCode);
      return null;
    }
  } catch (e) {
    throw e;
  }
}

Future<String> createOrderbyUser(
  String customerName,
  String phoneNumber,
  String address,
  String receivedDate,
  double subTotal,
  List<CartData> listOfProduct,
  String? token,
) async {
  try {
    final response = await http.post(
      Uri.parse(Constants.apiPath + "/Orders/PostOrderOrderDitales"),
      body: jsonEncode({
        "customerName": customerName.toString(),
        "phoneNumber": phoneNumber.toString(),
        "address": address.toString(),
        "subtotale": 0,
        "recivedDate": receivedDate,
        "orderdeitalsdto":
            listOfProduct.map((productData) => productData.toJson()).toList()
      }),
      headers: {"Content-Type": "application/json", "access_token": token!},
    );
    // Log.d(jsonEncode({
    //   "customerName": customerName.toString(),
    //   "phoneNumber": phoneNumber.toString(),
    //   "address": address.toString(),
    //   "subtotale": 0,
    //   "recivedDate": receivedDate,
    //   "orderdeitalsdto":
    //       listOfProduct.map((productData) => productData.toJson()).toList()
    // }));
    // Log.d(token);
    if (response.statusCode == 200) {
      return "done";
    } else {
      return "failed";
    }
    // print("abdo" + response.body.toString());
  } catch (e) {
    // print("abied ${e.toString()}");
    throw e;
  }
}

Future<List<Supplier>?> searchSupplier(
    String searchTerm, String? cityId, int offset, int limit) async {
  print(cityId);
  final response = await http.get(Uri.parse(Constants.apiPath +
      "/Supplier/GetAll?Offset=1&Limit=150&CityId=$cityId&SearchTerm=$searchTerm"));
  print(cityId);
  print(response.body);
  print(response.statusCode);
  if (response.statusCode == 200) {
    SupplierData supplierDataFromJson(String str) =>
        SupplierData.fromJson(json.decode(str));

    // print(response.body);
    return supplierDataFromJson(response.body).supplier;
  } else {
    // print(response.statusCode);
    return null;
  }
}

Future<List<AnnouncementData>?> fetchAnnouncement() async {
  try {
    final response =
        await http.get(Uri.parse(Constants.apiPath + "/Announcement/GetAll"));
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      return announcementDataFromJson(response.body);
    } else {
      // print(response.statusCode);
      return null;
    }
  } catch (e) {
    throw e;
  }
}

Future<List<Notifications>?> fetchNotification() async {
  try {
    final response = await http.get(Uri.parse(
        Constants.apiPath + "/Notifications/GetAll?Offset=1&Limit=100"));

    if (response.statusCode == 200) {
      // print(response.statusCode);
      // print(response.body);
      return notificationsDataFromJson(response.body).notification;
    } else {
      // print(response.statusCode);
      return null;
    }
  } catch (e) {
    throw e;
  }
}

Future<List<ImageData>?> fetchImages() async {
  try {
    final response =
        await http.get(Uri.parse(Constants.apiPath + "/Image/GetAll"));

    if (response.statusCode == 200) {
      return imageDataFromJson(response.body);
    } else {
      return null;
    }
  } catch (e) {
    throw e;
  }
}
