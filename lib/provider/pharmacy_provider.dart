import 'package:eshop/data/service/pharmacy_service.dart';
import 'package:eshop/utils/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eshop/model/supplier_data.dart';

class PharmacyProvider with ChangeNotifier {
  List<Supplier>? _pharmacyList = [];
  String pharmacyId = "";
  String pharmacyName = "";
  Future<String> addPharmacyItem(
      String name, String address, String phoneNumber, String image) async {
    final token = await _getToken();
    String response = await addPharmacy(
        name, address, phoneNumber, pharmacyName, image, token);
    return response;
  }

  getPharmacyList(int offset, int limit) async {
    final cityId = CacheHelper.getPrefs(key: 'cityId');
    _pharmacyList = await getAllPharmacyService(cityId, offset, limit);
    notifyListeners();
  }

  Future _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    return token;
  }

  saveUserPharmacy(String pharmacyID, String pharmName) {
    // Log.d(pharmacyName);
    pharmacyId = pharmacyID;
    pharmacyName = pharmName;
    notifyListeners();
  }

  List<Supplier>? get pharmacyList => _pharmacyList;
}
