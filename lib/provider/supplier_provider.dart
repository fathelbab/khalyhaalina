import 'package:eshop/data/service/services.dart';
import 'package:eshop/model/supplier_data.dart';
import 'package:flutter/widgets.dart';

class SupplierProvider extends ChangeNotifier {
  List<Supplier> _supplierList = [];
  String cityId = "";
  String categoryId = "";
  fetchSupplierList(
      String categoryId, String cityId, int offset, int limit) async {
    _supplierList = await fetchSupplier(
      categoryId,
      cityId,
      offset,
      limit,
    );
    print("done"
    +" "+categoryId+" "+cityId);    notifyListeners();
  }

  setCityId(String cityId) {
    cityId = cityId;
    notifyListeners();
  }

  setCategoryId(String categoryId) {
    categoryId = categoryId;
    notifyListeners();
  }

  List<Supplier> get supplierList => _supplierList;
}
