import 'dart:convert';
import 'package:eshop/model/announcement_data.dart';
import 'package:eshop/model/cart_data.dart';
import 'package:eshop/model/image_data.dart';
import 'package:eshop/model/notification_data.dart';
import 'package:eshop/model/product_data.dart';
import 'package:eshop/model/product_details_data.dart' hide Category, Supplier;
import 'package:eshop/model/service_details_data.dart' hide City;
import 'package:eshop/model/service_specialist_data.dart';
import 'package:eshop/model/supplier_data.dart';
import 'package:eshop/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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

Future<ProductDetailsData> fetchProductById(int? productId) async {
  try {

    final response = await http
        .get(Uri.parse(Constants.apiPath + "/Product/getById/$productId"));
    print(productId);
    if (response.statusCode == 200) {
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
    final response =
        await http.get(Uri.parse(Constants.apiPath + "/Carts"), headers: {
      "access_token": token,
    });
    print("token" + token);
    // print(response.body.toString());
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
    int? productId, int quantity, String? token) async {
  try {
    final response = await http.post(Uri.parse(Constants.apiPath + "/Carts"),
        body: jsonEncode({
          "productId": productId,
          "quantity": quantity,
        }),
        headers: {'Content-Type': 'application/json', "access_token": token!});
    // print(response.statusCode);
    // print(response.body.toString());
    if (response.statusCode == 201) {
      return "done";
    } else if (response.statusCode == 401) {
      return "auth";
    } else {
      return "failed";
    }
    // print("abdo" + response.body.toString());
  } catch (e) {
    throw e;
  }
}

Future<String> removeItemFromCart(int productId, String? token) async {
  try {
    final response = await http.delete(
      Uri.parse("https://api.khlihaalina.com/api/Carts/$productId"),
      headers: {'Content-Type': 'application/json', "access_token": token!},
    );
    print(response.statusCode);
    print(productId);
    print(token);
    print("abdo" + response.body.toString());
    if (response.statusCode == 204) {
      return "done";
    } else {
      return "failed";
    }
  } catch (e) {
    print(e);
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

Future<String> createOrderbyUser(
  String customerName,
  String phoneNumber,
  String address,
  double subTotal,
  List<CartData> listOfProduct,
  String? token,
) async {
  try {
    // print(jsonEncode({
    //   "customerName": customerName,
    //   "phoneNumber": phoneNumber,
    //   "address": address,
    //   "subtotale": subTotal,
    //   "vat": 0,
    //   "orderdeitalsdto":
    //       listOfProduct.map((productData) => productData.toJson()).toList(),
    // }));
    final response = await http.post(
      Uri.parse(Constants.apiPath + "/Orders/PostOrderOrderDitales"),
      body: jsonEncode({
        "customerName": customerName.toString(),
        "phoneNumber": phoneNumber.toString(),
        "address": address.toString(),
        "subtotale": 0,
        "orderdeitalsdto":
            listOfProduct.map((productData) => productData.toJson()).toList()
      }),
      headers: {"Content-Type": "application/json", "access_token": token!},
    );
    // print("abied ${response.statusCode}");
    // print("abied ${response.body.toString()}");
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

Future<String> addPharmacy(String name, String address, String phoneNumber,
    String image, String? token) async {
  try {
    final response = await http.post(
        Uri.parse(Constants.apiPath + "/Pharmacy/PostPharmacy"),
        body: jsonEncode({
          "name": name,
          "address": address,
          "phoneNumber": phoneNumber,
          "imagePath": image
        }),
        headers: {'Content-Type': 'application/json', "access_token": token!});
    // print(response.statusCode);
    // print(response.body.toString());
    if (response.statusCode == 200) {
      return "done";
    } else {
      return "failed";
    }
    // print("abdo" + response.body.toString());
  } catch (e) {
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

// Future<List<City>?> getAllCity(int offset, int limit) async {
//   final response = await http
//       .get(Uri.parse(apiPath + "/City/GetAll?Offset=$offset&Limit=$limit"));
//   try {
//     if (response.statusCode == 200) {
//       CityData cityDataFromJson(String str) =>
//           CityData.fromJson(json.decode(str));

//       // print(response.body);
//       return cityDataFromJson(response.body).city;
//     } else {
//       // print(response.statusCode);
//       return null;
//     }
//   } catch (e) {
//     throw e;
//   }
// }

Future<List<ServiceInfo>?> getAllServiceInfoList(
    String? cityId, String? specialistId) async {
  try {
    final response = await http.get(Uri.parse(Constants.apiPath +
        "/Service/GetAll?Offset=1&Limit=100&CityId=$cityId&ServiceSpecialistId=$specialistId"));

    // print("done${response.body}");

    if (response.statusCode == 200) {
      // print("done${response.body}");
      return serviceDetailsDataFromJson(response.body).result;
    } else {
      // print(response.statusCode);
      return null;
    }
  } catch (e) {
    throw e;
  }
}

Future<List<ServiceSpecialist>?> getAllServiceSpecialist() async {
  final response = await http.get(Uri.parse(
      Constants.apiPath + "/ServiceSpecialist/GetAll?Offset=1&Limit=100"));
  try {
    if (response.statusCode == 200) {
      // print(response.body);
      return serviceSpecialistDataFromJson(response.body).result;
    } else {
      // print(response.statusCode);
      return null;
    }
  } catch (e) {
    throw e;
  }
}

Future<void> signIn(String email, String password) async {
  // print(email + " " + password);
  try {
    final http.Response response = await http.post(
        Uri.parse(Constants.apiPath + "/User/OnPost/authenticate"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(
            {"email": email, "password": password, "rememberMe": true}));
    final resultData = json.decode(response.body);
    // print(resultData['token'].toString());
    // print(resultData.toString());
    if (response.statusCode == 200) {
      // print(resultData['token']);
      final prefs = await SharedPreferences.getInstance();
      String token = resultData['token'] ?? "";
      prefs.setString('token', token);
    } else {
      // print(resultData['message']);
      throw "${resultData['message']}";
    }
  } catch (e) {
    // print(e);
    throw e;
  }
}

Future<String> userGoogleSignIn(String? accessToken) async {
  try {
    final http.Response response = await http.post(
      Uri.parse(Constants.apiPath + "/User/GoogleRegisterLogin"),
      headers: {
        'Content-Type': 'application/json',
        'access_token': accessToken!,
      },
    );
    final resultData = json.decode(response.body);
    // print(resultData['token'].toString());
    if (response.statusCode == 200) {
      // print("abdoo ${resultData['token']}");
      final prefs = await SharedPreferences.getInstance();
      String token = resultData['token'] ?? "";
      prefs.setString('token', token);
      // print("done");
      return "done";
    } else {
      return "failed";
      // throw "${resultData['message']}";
    }
  } catch (e) {
    // throw e;
    // print(e);
    return "failed";
  }
}

Future<void> register(
    String email, String password, String firstName, String lastName) async {
  // print(email + " " + password + " " + firstName + " " + lastName);
  try {
    final http.Response response =
        await http.post(Uri.parse(Constants.apiPath + "/User/PostUser"),
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
    // final resultData = json.decode(response.body);
    // print(response.body);
    // print(resultData['arrayMessage'].toString());
    if (response.statusCode == 200) {
      // print(resultData['result']);
      // final prefs = await SharedPreferences.getInstance();
      // String token = resultData['result'] ?? "";
      // prefs.setString('token', token);
    }
  } catch (e) {
    throw e;
  }
}

Future<String> userFacebookSignIn(String? email, String authToken,
    String userId, String? name, String? firstName, String? lastName) async {
  try {
    print("abdo ${json.encode({
          "authToken": authToken,
          "email": email,
          "fristName": firstName,
          "id": userId,
          "lastName": lastName,
          "provider": "FACEBOOK",
          "name": name
        })}");
    final response = await http.post(
        Uri.parse("$Constants.apiPath/User/FaceBookRegisterlogin"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "authToken": authToken,
          "email": email,
          "fristName": firstName,
          "id": userId,
          "lastName": lastName,
          "provider": "FACEBOOK",
          "name": name
        }));

    print("abdo 111 ${response.statusCode}");
    final resultData = json.decode(response.body);
    print("abdo status code  ${response.statusCode}");
    print("abdo body ${response.body.toString()}");

    if (response.statusCode == 200) {
      print("abdo token ${resultData['token']}");
      final prefs = await SharedPreferences.getInstance();
      String token = resultData['token'] ?? "";
      prefs.setString('token', token);
      // final prefs = await SharedPreferences.getInstance();
      // String token = resultData['result'] ?? "";
      // prefs.setString('token', token);
      //  return "done";
      return "done";
    } else {
      return "failed";
      // throw "${resultData['message']}";
    }
  } catch (e) {
    // throw e;
    print("abdo 111 ${e.toString()}");
    return "failed";
  }
}
