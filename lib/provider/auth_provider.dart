import 'package:eshop/data/service/services.dart';
import 'package:flutter/widgets.dart';

class Auth with ChangeNotifier {
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
}
