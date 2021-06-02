import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:eshop/data/service/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  final GoogleSignIn googleSignIn = GoogleSignIn();

  bool _isSigningIn;
  Auth() {
    _isSigningIn = false;
  }

  bool get isSigningIn => _isSigningIn;

  set isSigningIn(bool isSigningIn) {
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

  Future<String> facebookLogin() async {
    try {
      final FacebookLogin facebookSignIn = FacebookLogin();
      final FacebookLoginResult result =
          await facebookSignIn.logIn(['email', 'public_profile']);
      print("abdo ${result.status}");

      switch (result.status) {
        case FacebookLoginStatus.loggedIn:
          final FacebookAccessToken accessToken = result.accessToken;
          final graphResponse = await http.get(Uri.parse(
              'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture&access_token=${accessToken.token}'));
          print("abdo ${accessToken.token.toString()}");
          final profile = json.decode(graphResponse.body);
          final response = await userFacebookSignIn(
              profile['email'],
              accessToken.token,
              accessToken.userId,
              profile['name'],
              profile['first_name'],
              profile['last_name']);
          print("abdo ${response.toString()}");
          return response;
          break;
        case FacebookLoginStatus.cancelledByUser:
          print('Login cancelled by the user.');
          return "failed";

          break;
        case FacebookLoginStatus.error:
          print('Something went wrong with the login process.\n'
              'Here\'s the error Facebook gave us: ${result.errorMessage}');
          return "failed";

          break;
      }
    } catch (e) {
      print("abdo exception ${e.toString()}");
      return "failed";
    }
    return "failed";
  }

  void logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
//  print('''
//    Logged in!
//    firstName: ${profile['first_name']}

//    lastname: ${profile['last_name']}
//    image: ${profile['picture']['data']['url']}

//    Token: ${accessToken.token}
//    User id: ${accessToken.userId}
//    Expires: ${accessToken.expires}
//    Permissions: ${accessToken.permissions}
//    Declined permissions: ${accessToken.declinedPermissions}
//    ''');
