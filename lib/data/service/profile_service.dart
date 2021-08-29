import 'dart:convert';
import 'package:eshop/model/user_data.dart';
import 'package:eshop/utils/cache_helper.dart';
import 'package:eshop/utils/constants.dart';
// import 'package:eshop/utils/log.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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
    final http.Response response = await http.post(
      Uri.parse("http://ahmedinara00-001-site1.dtempurl.com/api/MobileTokens"),
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
