import 'dart:convert';
import 'package:eshop/model/user_data.dart';
import 'package:eshop/utils/cache_helper.dart';
import 'package:eshop/utils/constants.dart';
import 'package:http/http.dart' as http;

Future<void> signIn(String email, String password) async {
  try {
    final http.Response response = await http.post(
      Uri.parse(Constants.apiPath + "/MyLogin/Login"),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({"email": email, "password": password}),
    );
    UserData resultData = userDataFromJson(response.body);

    if (response.statusCode == 200) {
      String token = resultData.token ?? "";
      CacheHelper.savePrefs(key: 'token', value: token);
      CacheHelper.savePrefs(
          key: 'userName',
          value:
              "${resultData.userData?.firstName} ${resultData.userData?.lastName}");
      CacheHelper.savePrefs(key: 'email', value: resultData.userData?.email);
    } else {
      // print(resultData['message']);
      throw "Unauthorized";
    }
  } catch (e) {
    throw e;
  }
}

Future<void> storeMobileTokenService(
    String accessToken, String mobileToken) async {
  try {
    // kira
    final http.Response response = await http.post(
      Uri.parse(Constants.apiPath + "/MobileTokens"),
      headers: {
        'Content-Type': 'application/json',
        'access_token': accessToken,
      },
      body: json.encode({
        "token": mobileToken,
      }),
    );
    // Log.d(json.encode({"token": mobileToken}));
    // Log.w(response.body.toString());
    // Log.i(response.statusCode.toString());
  } catch (e) {
    // Log.e(e.toString());
    // throw e;
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
