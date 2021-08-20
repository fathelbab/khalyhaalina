import 'dart:convert';
import 'package:eshop/utils/constants.dart';
import 'package:eshop/utils/log.dart';
import 'package:http/http.dart' as http;

Future<String> sendComplainsOrSuggestionService(String firstName, String lastName,
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

Future<String> sendOnlineSupportService(
  String firstName,
  String lastName,
  String phoneNumber,
  String address,
  String comment,
) async {
  try {
    final response = await http.post(
      Uri.parse(Constants.apiPath + "/OnlineSupports"),
      body: jsonEncode(
        {
          "fristName": firstName,
          "lastName": lastName,
          "address": address,
          "phoneNumber": phoneNumber,
          "comment": comment
        },
      ),
      headers: {'Content-Type': 'application/json'},
    );
    Log.d(response.statusCode.toString());
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
