import 'package:flutter/foundation.dart';
import 'package:eshop/data/service/services.dart';
import 'package:eshop/model/CityData.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CityProvider extends ChangeNotifier {
  List<City> _cityList = [];
  fetchCityList(int offset, int limit) async {
    _cityList = await getAllCity(offset, limit);
    notifyListeners();
  }

  Future<void> saveUserCity(String cityId) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('cityId', cityId);
    // print(cityId);
  }

  List<City> get cityList => _cityList;
}
