import 'package:eshop/model/city_data.dart';
import 'package:eshop/model/governate_data.dart';
import 'package:eshop/utils/constants.dart';
import 'package:http/http.dart' as http;

Future<List<Governate>?> getAllGovernate(int offset, int limit) async {
  final response = await http.get(
      Uri.parse(Constants.apiPath + "/Counteries?Offset=$offset&Limit=$limit"));

  try {
    if (response.statusCode == 200) {
      return governateFromJson(response.body).governate;
    } else {
      return [];
    }
  } catch (e) {
    return [];
  }
}

Future<List<City>?> getCityByGovernateId(
    int offset, int limit, String governateId) async {
  final response = await http.get(Uri.parse(Constants.apiPath +
      "/City/GetCityByCountery?Offset=$offset&Limit=$limit&Counteryid=$governateId"));
  try {
    if (response.statusCode == 200) {
      return cityDataFromJson(response.body).city;
    } else {
      return [];
    }
  } catch (e) {
    return [];
  }
}
