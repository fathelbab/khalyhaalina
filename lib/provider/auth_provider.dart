import 'dart:convert';
import 'package:eshop/utils/cache_helper.dart';
import 'package:http/http.dart' as http;
import 'package:eshop/data/service/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class Auth with ChangeNotifier {
  final GoogleSignIn googleSignIn = GoogleSignIn();

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

  Future<String> googleLogin() async {
    // googleSignIn.disconnect();
    try {
      final user = await googleSignIn.signIn();
      // print("abdo${user.displayName} ");

      if (user != null) {
        // isSigningIn = false;

        final googleAuth = await user.authentication;
        print("abdo${user.displayName} accessToken : ${googleAuth.idToken}");
        isSigningIn = true;
        String response = await userGoogleSignIn(googleAuth.idToken);
        print(response);
        return response;
        // final credential = GoogleAuthProvider.credential(
        //   accessToken: googleAuth.accessToken,
        //   idToken: googleAuth.idToken,
        // );
        //       // await FirebaseAuth.instance.signInWithCredential(credential);

      } else {
        isSigningIn = false;
        return "failed";
      }
    } catch (e) {
      print(e);
    }
    return "failed";
  }

  String prettyPrint(Map json) {
    JsonEncoder encoder = new JsonEncoder.withIndent('  ');
    String pretty = encoder.convert(json);
    return pretty;
  }

  Future<String> facebookLogin() async {
    try {
      // Map<String, dynamic> _userData;
      AccessToken? _accessToken;

      final result = await FacebookAuth.instance.login(permissions: [
        'email',
        'public_profile',
      ]);
      if (result.status == LoginStatus.success) {
        _accessToken = result.accessToken;
        // final userData = await FacebookAuth.i.getUserData(
        //   fields: "name,first_name,last_name,email,picture.width(200)",
        // );

        final graphResponse = await http.get(Uri.parse(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture&access_token=${_accessToken!.token}'));
        // print("abdo ${_accessToken.token.toString()}");
        final profile = json.decode(graphResponse.body);
        final response = await userFacebookSignIn(
            profile['email'],
            _accessToken.token,
            _accessToken.userId,
            profile['name'],
            profile['first_name'],
            profile['last_name']);

        // print("abdo ${response.toString()}");
        return response;
      } else {
        return "failed";
      }
    } catch (e) {
      // print("abdo exception ${e.toString()}");
      return "failed";
    }
  }

  void logout() async {
    CacheHelper.clearAll();
  }
}
