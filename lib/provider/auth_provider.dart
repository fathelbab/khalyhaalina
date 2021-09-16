import 'dart:convert';
import 'package:eshop/data/service/profile_service.dart';
import 'package:eshop/utils/cache_helper.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';

class Auth with ChangeNotifier {
  bool? _isSigningIn;
  Auth() {
    _isSigningIn = false;
  }

  bool? get isSigningIn => _isSigningIn;

  set isSigningIn(bool? isSigningIn) {
    _isSigningIn = isSigningIn;
    notifyListeners();
  }

  Future<void> userSignIn(email, password) async {
    try {
      await signIn(email, password);
    } catch (e) {
      throw e;
    }
  }

  Future<void> userRegister(email, password, firstName, lastName) async {
    try {
      await register(email, password, firstName, lastName);
    } catch (e) {
      throw e;
    }
  }

  String prettyPrint(Map json) {
    JsonEncoder encoder = new JsonEncoder.withIndent('  ');
    String pretty = encoder.convert(json);
    return pretty;
  }

  Future<void> storeMobileToken(String mobileToken) async {
    String accessToken = CacheHelper.getPrefs(key: "token");
    await storeMobileTokenService(accessToken, mobileToken);
  }

  void logout() async {
    CacheHelper.clearPrefs(key: 'token');
    CacheHelper.clearAll();
  }
}
