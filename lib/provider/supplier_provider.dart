import 'package:eshop/data/service/services.dart';
import 'package:eshop/model/supplier_data.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SupplierProvider extends ChangeNotifier {
  List<Supplier> _supplierList = [];
  String cityId = "";
  String currentCategoryId = "0";
  fetchSupplierList(String categoryId, int offset, int limit) async {
    currentCategoryId = categoryId;
    final cityId = await getCityId();
    _supplierList = await fetchSupplier(
      categoryId,
      cityId,
      offset,
      limit,
    );
    print("done" + " " + categoryId + " " + cityId);
    notifyListeners();
  }

  fetchCurrentSupplierList(int offset, int limit) async {
    final cityId = await getCityId();
    _supplierList = await fetchSupplier(
      currentCategoryId,
      cityId,
      offset,
      limit,
    );
    print("done" + " " + currentCategoryId + " " + cityId);
    notifyListeners();
  }

  setCityId(String cityId) {
    cityId = cityId;
    notifyListeners();
  }

  setCategoryId(String categoryId) {
    categoryId = categoryId;
    notifyListeners();
  }

  Future getCityId() async {
    final prefs = await SharedPreferences.getInstance();
    final cityId = prefs.getString('cityId');
    return cityId;
  }

  List<Supplier> get supplierList => _supplierList;

  searchSupplierByCity(String searchTerm, int offset, int limit) async {
    final cityId = await getCityId();
    print(cityId);
    _supplierList = await searchSupplier(
      searchTerm,
      cityId,
      offset,
      limit,
    );
    // print("done" + " " + categoryId + " " + cityId);
    notifyListeners();
  }
}
