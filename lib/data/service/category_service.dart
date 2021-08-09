import 'package:eshop/model/main_category.dart';
import 'package:eshop/utils/constants.dart';
import 'package:http/http.dart' as http;

Future<List<MainCategory>?> fetchMainCategory(int offset, int limit) async {
  try {
    final response = await http.get(Uri.parse(
        Constants.apiPath + "/MainCategories?Offset=$offset&Limit=$limit"));
    // print(Constants.apiPath + "/MainCategories?Offset=$offset&Limit=$limit");
    // print(response.statusCode);
    // print(response.headers);
    // print(response.body);
    if (response.statusCode == 200) {
      // print(mainCategoryFromJson(response.body));
      return mainCategoryFromJson(response.body);
    } else {
      // print(response.statusCode);
      return null;
    }
  } catch (e) {
    // print(e.toString());
  }
}
