import 'package:eshop/model/supplier_category.dart';
import 'package:eshop/model/supplier_data.dart';
import 'package:eshop/utils/contants.dart';
import 'package:http/http.dart' as http;

Future<List<Supplier>?> fetchSupplier(
    String categoryId, String cityId, int offset, int limit) async {
  final response = await http.get(Uri.parse(Constants.apiPath +
      "/Supplier/GetAll?CityId=$cityId&CategoryId=$categoryId&Offset=1&Limit=$limit"));

  if (response.statusCode == 200) {
    // print(response.body);
    return supplierDataFromJson(response.body).supplier;
  } else {
    // print(response.statusCode);
    return null;
  }
}

Future<SupplierCategory?> getSupplierCategoryList(
    String supplierid, int limit) async {
  try {
    final response = await http.get(Uri.parse(Constants.apiPath +
        "/Category/GetAll?Offset=1&Limit=$limit&supplierid=$supplierid"));

    if (response.statusCode == 200) {
      // print("${response.body}");
      return supplierCategoryFromJson(response.body);
    } else
      return null;
  } catch (e) {
    // print("$e");
  }
}
