import 'package:eshop/model/main_category.dart';
import 'package:eshop/utils/constants.dart';
import 'package:http/http.dart' as http;

Future<List<MainCategory>> fetchMainCategory(int offset, int limit) async {
  try {
    final response = await http.get(Uri.parse(
        Constants.apiPath + "/MainCategories?Offset=$offset&Limit=$limit"));

    if (response.statusCode == 200) {
      return mainCategoryFromJson(response.body);
    } else {
      return [];
    }
  } catch (e) {
    return [];
  }
}
