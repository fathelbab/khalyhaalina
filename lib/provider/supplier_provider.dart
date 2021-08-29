import 'package:eshop/data/service/supplier_service.dart';
import 'package:eshop/model/supplier_category.dart';
import 'package:eshop/model/supplier_data.dart';
import 'package:eshop/utils/cache_helper.dart';
import 'package:flutter/widgets.dart';

class SupplierProvider extends ChangeNotifier {
  List<Supplier>? _supplierList = [];
  SupplierCategory? _supplierCategory;
  List<Category>? _supplierMainCategory;
  List<Category>? _supplierSupCategory;
  String cityId = "";
  String currentCategoryId = "0";
  String supplierMainCategoryId = "0";
  String supplierSubCategoryId = "0";

  Future fetchSupplierList(String categoryId, int offset, int limit) async {
    currentCategoryId = categoryId;
    final cityId = CacheHelper.getPrefs(key: 'cityId');
    _supplierList = await fetchSupplier(
      categoryId,
      cityId,
      offset,
      limit,
    );
    print("done" + " " + categoryId + " " + cityId);
    notifyListeners();
  }

  // fetchCurrentSupplierList(int offset, int limit) async {
  //   final cityId = await getCityId();
  //   _supplierList = await fetchSupplier(
  //     currentCategoryId,
  //     cityId,
  //     offset,
  //     limit,
  //   );
  //   print("done" + " " + currentCategoryId + " " + cityId);
  //   notifyListeners();
  // }

  setCityId(String cityId) {
    cityId = cityId;
    notifyListeners();
  }

  setSubCategory(int categoryId) {
    supplierMainCategory?.map((mainCategory) {
      if (mainCategory.id == categoryId) {
        _supplierSupCategory = mainCategory.childs ?? [];
      }
    }).toList();
    notifyListeners();
  }

  // Future getCityId() async {
  //   final cityId = CacheHelper.getPrefs(key: 'cityId');
  //   return cityId;
  // }

  List<Supplier>? get supplierList => _supplierList;

  // searchSupplierByCity(String searchTerm, int offset, int limit) async {
  //   final cityId = await getCityId();
  //   print(cityId);
  // _supplierList = await searchSupplier(
  //   searchTerm,
  //   cityId,
  //   offset,
  //   limit,
  // );
  // print("done" + " " + categoryId + " " + cityId);
  //   notifyListeners();
  // }

  Future<SupplierCategory?> getSupplierCategory(
      String supplierId, int limit) async {
    _supplierCategory = await getSupplierCategoryList(supplierId, limit);
    _supplierMainCategory = _supplierCategory!.category;
    if (_supplierCategory != null &&
        _supplierMainCategory![0].childs != null &&
        _supplierMainCategory![0].childs!.isNotEmpty) {
      _supplierSupCategory = _supplierMainCategory![0].childs;
    }
    notifyListeners();
    return _supplierCategory;
  }

  // SupplierCategory? get supplierCategory => _supplierCategory;
  List<Category>? get supplierMainCategory => _supplierMainCategory;
  List<Category>? get supplierSubCategory => _supplierSupCategory;

  void clearSuppliertList() {
    _supplierCategory = null;
    _supplierMainCategory = [];
    _supplierSupCategory = [];
    notifyListeners();
  }
}
