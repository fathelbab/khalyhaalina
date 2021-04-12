import 'dart:convert';
import 'package:eshop/constant/constant.dart';
import 'package:eshop/model/CityData.dart';
import 'package:eshop/model/announcement_data.dart';
import 'package:eshop/model/cart_data.dart';
import 'package:eshop/model/category_data.dart';
import 'package:eshop/model/doctor_data.dart' hide City;
import 'package:eshop/model/doctor_details_data.dart';
import 'package:eshop/model/doctor_specialist_data.dart';
import 'package:eshop/model/image_data.dart';
import 'package:eshop/model/notification_data.dart';
import 'package:eshop/model/order_data.dart';
import 'package:eshop/model/product_data.dart';
import 'package:eshop/model/product_details_data.dart' hide Category, Supplier;
import 'package:eshop/model/service_details_data.dart' hide City;
import 'package:eshop/model/service_specialist_data.dart';
import 'package:eshop/model/supplier_data.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
// headers: {HttpHeaders.contentTypeHeader: "application/json",
// HttpHeaders.authorizationHeader: "Bearer $token"}

Future<List<Category>> fetchCategory(int offset, int limit) async {
  final response = await http
      .get(Uri.parse(apiPath + "/Category/GetAll?Offset=$offset&Limit=$limit"));
  if (response.statusCode == 200) {
    CategoryData categoryDataFromJson(String str) =>
        CategoryData.fromJson(json.decode(str));
    // print(categoryDataFromJson(response.body).result[0].name);
    return categoryDataFromJson(response.body).result;
  } else {
    // print(response.statusCode);
    return null;
  }
}

Future<List> fetchProduct(
    String supplierId, String categoryId, int offset, int limit) async {
  final response = await http.get(Uri.parse(apiPath +
      "/Product/GetAll?CategoryId=$categoryId&SupplierId=$supplierId&Offset=1&Limit=100"));
  // print(apiPath
  //     "/Product/GetAll?CategoryId=$categoryId&SupplierId=$supplierId&Offset=1&Limit=100");
  if (response.statusCode == 200) {
    // print(response.body);
    return productDataFromJson(response.body).product;
  } else {
    // print(response.statusCode);
    return null;
  }
}

Future<List> fetchProductHot(
    String supplierId, String categoryId, int offset, int limit) async {
  final response = await http.get(Uri.parse(apiPath +
      "/Product/GetAllHot?Offset=1&Limit=200&SupplierId=0&CategoryId=0"));
  // print("abdo ${response.body}");
  if (response.statusCode == 200) {
    return productDataFromJson(response.body).product;
  } else {
    // print(response.statusCode);
    return null;
  }
}

Future<List> searchWithTerm(String searchTerm, int offset, int limit) async {
  try {
    final response = await http.get(Uri.parse(apiPath +
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

Future<ProductDetailsData> fetchProductById(int productId) async {
  try {
    final response =
        await http.get(Uri.parse(apiPath + "/Product/getById/$productId"));
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
    final response = await http.get(Uri.parse(apiPath + "/Carts"), headers: {
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
    int productId, int quantity, String token) async {
  try {
    final response = await http.post(Uri.parse(apiPath + "/Carts"),
        body: jsonEncode({
          "productId": productId,
          "quantity": quantity,
        }),
        headers: {'Content-Type': 'application/json', "access_token": token});
    // print(response.statusCode);
    // print(response.body.toString());
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

Future<String> removeItemFromCart(int productId, String token) async {
  try {
    final response = await http.delete(
      Uri.parse("https://www.khlihaalina.com/api/Carts/$productId"),
      headers: {'Content-Type': 'application/json', "access_token": token},
    );
    // print(response.statusCode);
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

Future<String> cleartUserCart(String token) async {
  try {
    final response = await http.delete(
      Uri.parse("https://api.khlihaalina.com/api/Orders/DeleteCart"),
      headers: {
        'Content-Type': 'application/json',
        'access_token': token,
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
  String token,
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
      Uri.parse(apiPath + "/Orders/PostOrderOrderDitales"),
      body: jsonEncode({
        "customerName": customerName.toString(),
        "phoneNumber": phoneNumber.toString(),
        "address": address.toString(),
        "subtotale": 0,
        "orderdeitalsdto":
            listOfProduct.map((productData) => productData.toJson()).toList()
      }),
      headers: {"Content-Type": "application/json", "access_token": token},
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
    String image, String token) async {
  try {
    final response = await http.post(
        Uri.parse(apiPath + "/Pharmacy/PostPharmacy"),
        body: jsonEncode({
          "name": name,
          "address": address,
          "phoneNumber": phoneNumber,
          "imagePath": image
        }),
        headers: {'Content-Type': 'application/json', "access_token": token});
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

Future<String> sendCompliatOrSuggestion(String firstName, String lastName,
    String email, String phoneNumber, String userMessage) async {
  try {
    final response =
        await http.post(Uri.parse(apiPath + "/ContactUs/PostPharmacy"),
            body: jsonEncode({
              "email": email,
              "firstName": firstName,
              "lastName": lastName,
              "phone": phoneNumber,
              "message": userMessage,
            }),
            headers: {'Content-Type': 'application/json'});
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

Future<List<Supplier>> fetchSupplier(
    String categoryId, String cityId, int offset, int limit) async {
  final response = await http.get(Uri.parse(apiPath +
      "/Supplier/GetAll?CityId=$cityId&CategoryId=$categoryId&Offset=1&Limit=100"));

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
    final response =
        await http.get(Uri.parse(apiPath + "/Announcement/GetAll"));

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

Future<List<Notifications>> fetchNotification() async {
  try {
    final response = await http
        .get(Uri.parse(apiPath + "/Notifications/GetAll?Offset=1&Limit=100"));

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

Future<List<ImageData>> fetchImages() async {
  try {
    final response = await http.get(Uri.parse(apiPath + "/Image/GetAll"));

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
  final response = await http
      .get(Uri.parse(apiPath + "/City/GetAll?Offset=$offset&Limit=$limit"));
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

Future<List<DoctorInfo>> getAllDoctorList(
    String cityId, String specialistId) async {
  try {
    final response = await http.get(Uri.parse(apiPath +
        "/Doctor/GetAll?Offset=1&Limit=100&CityId=$cityId&DoctorSpecialistId=$specialistId"));

    // print("done${response.body}");

    if (response.statusCode == 200) {
      // print("done${response.body}");
      return doctorDataFromJson(response.body).result;
    } else {
      // print(response.statusCode);
      return null;
    }
  } catch (e) {
    throw e;
  }
}

Future<List<ServiceInfo>> getAllServiceInfoList(
    String cityId, String specialistId) async {
  try {
    final response = await http.get(Uri.parse(apiPath +
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

Future<List<DoctorSpecialistt>> getAllDoctorSpecialist() async {
  final response = await http
      .get(Uri.parse(apiPath + "/DoctorSpecialist/GetAll?Offset=1&Limit=100"));
  try {
    if (response.statusCode == 200) {
      // print(response.body);
      return doctorSpecialistDataFromJson(response.body).doctorSpecialist;
    } else {
      // print(response.statusCode);
      return null;
    }
  } catch (e) {
    throw e;
  }
}

Future<List<ServiceSpecialist>> getAllServiceSpecialist() async {
  final response = await http
      .get(Uri.parse(apiPath + "/ServiceSpecialist/GetAll?Offset=1&Limit=100"));
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

Future<DoctorDetailsData> getDoctorByID(String doctorId) async {
  final response =
      await http.get(Uri.parse(apiPath + "/Doctor/getById/$doctorId"));
  try {
    if (response.statusCode == 200) {
      // print(response.body);
      return doctorDetailsDataFromJson(response.body);
    } else {
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
        Uri.parse(apiPath + "/User/OnPost/authenticate"),
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

Future<String> userGoogleSignIn(String accessToken) async {
  try {
    final http.Response response = await http.post(
      Uri.parse(apiPath + "/User/GoogleRegisterLogin"),
      headers: {
        'Content-Type': 'application/json',
        'access_token': accessToken,
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
        await http.post(Uri.parse(apiPath + "/User/PostUser"),
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

Future<String> userFacebookSignIn(String email, String authToken, String userId,
    String name, String firstName, String lastName) async {
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
    final response =
        await http.post(Uri.parse("$apiPath/User/FaceBookRegisterlogin"),
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
    ;
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
