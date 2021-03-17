import 'package:flutter/foundation.dart';
import 'package:eshop/data/service/services.dart';
import 'package:eshop/model/CityData.dart';

class CityProvider extends ChangeNotifier {
  List<City> _cityList = [];
  fetchCityList(int offset, int limit) async {
    _cityList = await getAllCity(offset, limit);
    notifyListeners();
  }

  List<City> get cityList => _cityList;
}
