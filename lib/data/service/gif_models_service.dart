import 'package:eshop/model/gif_models_data.dart';
import 'package:eshop/utils/constants.dart';
import 'package:http/http.dart' as http;

Future<List<GifModels>?> getGifModels(String cityId) async {
  try {
    final response = await http.get(
        Uri.parse(Constants.apiPath + "/GifModels/GetGifModel?cityid=$cityId"));
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      return gifModelsFromJson(response.body);
    } else {
      // print(response.statusCode);
      return null;
    }
  } catch (e) {
    throw e;
  }
}
