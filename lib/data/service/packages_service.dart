import 'dart:convert';

import 'package:eshop/model/packages_data.dart';
import 'package:eshop/utils/constants.dart';
import 'package:eshop/utils/log.dart';
import 'package:http/http.dart' as http;

Future<List<PackagesData>> getPackagesService() async {
  try {
    final response = await http.get(
      Uri.parse(Constants.apiPath + "/packages"),
    );
    Log.d(response.statusCode.toString());

    Log.d(response.body.toString());
    if (response.statusCode == 200) {
      return packagesDataFromJson(response.body);
    } else {
      return [];
    }
  } catch (e) {
    Log.e(e.toString());
    return [];
  }
}

Future<String> confirmBuyPackageService(
  String accessToken,
  String name,
  String address,
  String phoneNumber,
  int packageId,
  int price,
) async {
  try {
    final response = await http.post(
      Uri.parse(Constants.apiPath + "/PackageOrders"),
      headers: {
        'Content-Type': 'application/json',
        'access_token': accessToken,
      },
      body: jsonEncode(
        {
          "id": 0,
          "userId": "",
          "price": price,
          "packageId": packageId,
          "fullName": name,
          "address": address,
          "phoneNumber": phoneNumber,
        },
      ),
    );
    Log.w(
      jsonEncode(
        {
          "id": 0,
          "userId": "",
          "price": price,
          "packageId": packageId,
          "fullName": name,
          "address": address,
          "phoneNumber": phoneNumber,
        },
      ),
    );
    Log.d(response.statusCode.toString());
    Log.d(accessToken);
    Log.d(response.body.toString());
    if (response.statusCode == 201) {
      return "done";
    } else {
      return "failed";
    }
  } catch (e) {
    Log.e(e.toString());
    throw e;
  }
}
