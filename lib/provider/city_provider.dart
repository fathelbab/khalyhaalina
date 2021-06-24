import 'package:eshop/data/service/address_service.dart';
import 'package:eshop/model/city_data.dart';
import 'package:eshop/model/governate_data.dart';
import 'package:eshop/utils/cache_helper.dart';
import 'package:flutter/foundation.dart';

import 'package:shared_preferences/shared_preferences.dart';

class CityProvider extends ChangeNotifier {
  List<City>? _cityList = [];
  List<Governate>? _governateList = [];
  String governateId = "0";
  String cityId = "0";
  fetchGovernateList(int offset, int limit) async {
    _governateList = await getAllGovernate(offset, limit);
    notifyListeners();
  }

  fetchCityList(int offset, int limit, String governateId) async {
    _cityList = await getCityByGovernateId(offset, limit, governateId);
    notifyListeners();
  }

  saveUserGovernate(String governateID) {
    CacheHelper.savePrefs(key: "governateId", value: governateID);
    cityId = "0";
    governateId = governateID;
    notifyListeners();
  }

  saveUserCity(String cityID) {
    CacheHelper.savePrefs(key: "cityId", value: cityID);
    cityId = cityID;
    notifyListeners();
  }

  List<City>? get cityList => _cityList;
  List<Governate>? get governateList => _governateList;
}
