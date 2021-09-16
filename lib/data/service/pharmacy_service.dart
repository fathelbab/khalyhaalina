import 'dart:convert';
import 'package:eshop/model/supplier_data.dart';
import 'package:eshop/utils/constants.dart';
import 'package:http/http.dart' as http;

Future<String> addPharmacy(String name, String address, String phoneNumber,
    String pharmacyName, String image, String? token) async {
  try {
    final response = await http.post(
        Uri.parse(Constants.apiPath + "/Pharmacy/PostPharmacy"),
        body: jsonEncode({
          "name": name,
          "address": address,
          "phoneNumber": phoneNumber,
          "imagePath": image,
          "phramName": pharmacyName,
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

Future<List<Supplier>?> getAllPharmacyService(
    String cityId, int offset, int limit) async {
  final response = await http.get(Uri.parse(Constants.apiPath +
      "/Supplier/GetAll?Offset=$offset&Limit=200&CityId=$cityId&CategoryId=1069"));
  print(response.statusCode);
  print(response.body);
  // Log.d(response.body.toString());
  try {
    if (response.statusCode == 200) {
      // print(response.body);
      return supplierDataFromJson(response.body).supplier;
    } else {
      // print(response.statusCode);
      return [];
    }
  } catch (e) {
    // Log.e(e.toString());
    return [];
    // throw e;
  }
}
