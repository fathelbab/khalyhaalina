import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eshop/data/service/services.dart';

class PharmacyProvider with ChangeNotifier {
  Future<String> addPharmacyItem(
      String name, String address, String phoneNumber, String image) async {
    final token = await _getToken();
    String response =
        await addPharmacy(name, address, phoneNumber, image, token);
    return response;
  }

  Future _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    return token;
  }
}
