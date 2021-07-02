import 'package:eshop/data/service/address_service.dart';
import 'package:eshop/model/city_data.dart';
import 'package:eshop/model/governate_data.dart';
import 'package:eshop/utils/cache_helper.dart';
import 'package:flutter/foundation.dart';

class CityProvider extends ChangeNotifier {
  List<City>? _cityList = [];
  List<Governate>? _governateList = [];
  String governateId = "0";
  String userGovernate = "0";
  String cityId = "";
  String userCity = "";
  fetchGovernateList(int offset, int limit) async {
    _governateList = await getAllGovernate(offset, limit);
    notifyListeners();
  }

  fetchCityList(int offset, int limit, String governateId) async {
    _cityList = await getCityByGovernateId(offset, limit, governateId);
    notifyListeners();
  }

  saveUserGovernate(String governorateID, String governorateName) {
    CacheHelper.savePrefs(key: "governorateId", value: governorateID);
    CacheHelper.savePrefs(key: "governorateName", value: governorateName);
    cityId = "0";
    governateId = governorateID;
    notifyListeners();
  }

  saveUserCity(String cityID, String cityName) {
    CacheHelper.savePrefs(key: "cityId", value: cityID);
    CacheHelper.savePrefs(key: "cityName", value: cityName);
    cityId = cityID;
    notifyListeners();
  }

  List<City>? get cityList => _cityList;
  List<Governate>? get governateList => _governateList;
}
