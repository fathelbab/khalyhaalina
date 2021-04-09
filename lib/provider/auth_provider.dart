import 'package:eshop/data/service/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  Future<String> userGoogleRegister(String accessToken) async {
    String response = await userGoogleSignIn(accessToken);
    return response;
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
        String response = await userGoogleRegister(googleAuth.idToken);
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

  void logout() async {
    await googleSignIn.signOut();
    isSigningIn = false;
  }
}
