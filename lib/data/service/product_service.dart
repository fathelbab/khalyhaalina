import 'package:eshop/model/product_data.dart';
import 'package:eshop/utils/contants.dart';
import 'package:http/http.dart' as http;

Future<List<Product>?> fetchProduct(String? supplierId, String? categoryId,
    String searchTerm, int offset, int limit) async {
  final response = await http.get(Uri.parse(Constants.apiPath +
      "/Product/GetAll?CategoryId=$categoryId&SupplierId=$supplierId&SearchTerm=$searchTerm&Offset=1&Limit=$limit"));
  // print(apiPath
  //     "/Product/GetAll?CategoryId=$categoryId&SupplierId=$supplierId&Offset=1&Limit=100");
  // print("abdo ${response.body}");
  // print("abdo ${response.statusCode}");
  if (response.statusCode == 200) {
    return productDataFromJson(response.body).product;
  } else {
    // print(response.statusCode);
    return null;
  }
}

Future<List<Product>?> fetchProductHot(
    String supplierId, String categoryId, int offset, int limit) async {
  final response = await http.get(Uri.parse(Constants.apiPath +
      "/Product/GetAllHot?Offset=1&Limit=200&SupplierId=0&CategoryId=0"));
  // print("abdo ${response.body}");
  // print("abdo ${response.statusCode}");
  if (response.statusCode == 200) {
    return productDataFromJson(response.body).product;
  } else {
    // print(response.statusCode);
    return null;
  }
}
