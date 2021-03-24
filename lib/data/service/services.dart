import 'dart:convert';
import 'package:eshop/constant/constant.dart';
import 'package:eshop/model/CityData.dart';
import 'package:eshop/model/announcement_data.dart';
import 'package:eshop/model/cart_data.dart';
import 'package:eshop/model/category_data.dart';
import 'package:eshop/model/image_data.dart';
import 'package:eshop/model/product_data.dart';
import 'package:eshop/model/product_details_data.dart' hide Category, Supplier;
import 'package:eshop/model/supplier_data.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
// headers: {HttpHeaders.contentTypeHeader: "application/json",
// HttpHeaders.authorizationHeader: "Bearer $token"}

Future<List<Category>> fetchCategory(int offset, int limit) async {
  final response =
      await http.get(apiPath + "/Category/GetAll?Offset=$offset&Limit=$limit");
  if (response.statusCode == 200) {
    CategoryData categoryDataFromJson(String str) =>
        CategoryData.fromJson(json.decode(str));
    // print(categoryDataFromJson(response.body).result[0].name);
    return categoryDataFromJson(response.body).result;
  } else {
    print(response.statusCode);
    return null;
  }
}

Future<List> fetchProduct(
    String supplierId, String categoryId, int offset, int limit) async {
  final response = await http.get(apiPath +
      "/Product/GetAll?CategoryId=$categoryId&SupplierId=$supplierId&Offset=1&Limit=100");
  // print(apiPath +
  //     "/Product/GetAll?CategoryId=$categoryId&SupplierId=$supplierId&Offset=1&Limit=100");
  if (response.statusCode == 200) {
    // print(response.body);
    return productDataFromJson(response.body).product;
  } else {
    print(response.statusCode);
    return null;
  }
}

Future<List> searchWithTerm(String searchTerm, int offset, int limit) async {
  try {
    final response = await http.get(apiPath +
        "/Product/GetAll?SearchTerm=$searchTerm&Offset=$offset&Limit=$limit");
    // print(apiPath +
    //     "/Product/GetAll?CategoryId=$categoryId&SupplierId=$supplierId&Offset=1&Limit=100");
    print(response.statusCode);
    print(response.body.toString());

    if (response.statusCode == 200) {
      ProductData productDataFromJson(String str) =>
          ProductData.fromJson(json.decode(str));

      // print(response.body);
      return productDataFromJson(response.body).product;
    } else {
      print(response.statusCode);
      return null;
    }
  } catch (e) {
    throw e;
  }
}

Future<ProductDetailsData> fetchProductById(int productId) async {
  try {
    final response = await http.get(apiPath + "/Product/getById/$productId");
    // print(response.body.toString());
    if (response.statusCode == 200) {
      print(productDetailsDataFromJson(response.body).name);

      return productDetailsDataFromJson(response.body);
    } else
      throw response.body;
  } catch (e) {
    // print(e.toString());
    throw e;
  }
}

Future<List<CartData>> fetchCartItems(String token) async {
  try {
    final response = await http.get(apiPath + "/Carts", headers: {
      "access_token": token,
    });
    print("token" + token);
    print(response.body.toString());
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
    int productId, int quantity, String token) async {
  try {
    final response = await http.post(apiPath + "/Carts",
        body: jsonEncode({
          "productId": productId,
          "quantity": quantity,
        }),
        headers: {'Content-Type': 'application/json', "access_token": token});
    print(response.statusCode);
    if (response.statusCode == 201) {
      return "done";
    } else {
      return "failed";
    }
    // print("abdo" + response.body.toString());
  } catch (e) {
    throw e;
  }
}

Future<List<Supplier>> fetchSupplier(
    String categoryId, String cityId, int offset, int limit) async {
  final response = await http.get(apiPath +
      "/Supplier/GetAll?CityId=$cityId&CategoryId=$categoryId&Offset=1&Limit=100");

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

Future<List<AnnouncementData>> fetchAnnouncement() async {
  try {
    final response = await http.get(apiPath + "/Announcement/GetAll");

    if (response.statusCode == 200) {
      // print(response.statusCode);
      // print(response.body);
      return announcementDataFromJson(response.body);
    } else {
      // print(response.statusCode);
      return null;
    }
  } catch (e) {
    throw e;
  }
}

Future<List<ImageData>> fetchImages() async {
  try {
    final response = await http.get(apiPath + "/Image/GetAll");

    if (response.statusCode == 200) {
      // print(response.statusCode);
      // print(response.body);
      return imageDataFromJson(response.body);
    } else {
      // print(response.statusCode);
      return null;
    }
  } catch (e) {
    throw e;
  }
}

Future<List<City>> getAllCity(int offset, int limit) async {
  final response =
      await http.get(apiPath + "/City/GetAll?Offset=$offset&Limit=$limit");
  try {
    if (response.statusCode == 200) {
      CityData cityDataFromJson(String str) =>
          CityData.fromJson(json.decode(str));

      // print(response.body);
      return cityDataFromJson(response.body).city;
    } else {
      // print(response.statusCode);
      return null;
    }
  } catch (e) {
    throw e;
  }
}

Future<void> signIn(String email, String password) async {
  print(email + " " + password);
  try {
    final http.Response response = await http.post(apiPath + "/MyLogin",
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "email": email,
          "password": password,
        }));
    final resultData = json.decode(response.body);
    print(resultData['token'].toString());
    if (response.statusCode == 200) {
      print(resultData['token']);
      final prefs = await SharedPreferences.getInstance();
      String token = resultData['token'] ?? "";
      prefs.setString('token', token);
    } else {
      throw "${resultData['message']}";
    }
  } catch (e) {
    throw e;
  }
}

Future<void> register(
    String email, String password, String firstName, String lastName) async {
  print(email + " " + password + " " + firstName + " " + lastName);
  try {
    final http.Response response = await http.post(apiPath + "/User",
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "email": email,
          "password": password,
          "firstName": firstName,
          "lastName": lastName,
          "confirmPassword": password,
        }));
    final resultData = json.decode(response.body);
    // print(response.body);
    // print(resultData['arrayMessage'].toString());
    if (response.statusCode == 200 && resultData['statusCode'] == 200) {
      // print(resultData['result']);
      // final prefs = await SharedPreferences.getInstance();
      // String token = resultData['result'] ?? "";
      // prefs.setString('token', token);
    } else {
      throw "${resultData['message']}";
    }
  } catch (e) {
    throw e;
  }
}
