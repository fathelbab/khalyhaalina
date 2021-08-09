import 'dart:convert';

import 'package:eshop/model/product_data.dart';
import 'package:eshop/utils/constants.dart';
import 'package:http/http.dart' as http;

Future<String> sendCompliatOrSuggestion(String firstName, String lastName,
    String email, String phoneNumber, String userMessage) async {
  try {
    final response = await http
        .post(Uri.parse(Constants.apiPath + "/ContactUs/PostPharmacy"),
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


