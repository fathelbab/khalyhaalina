import 'package:eshop/model/city_data.dart';
import 'package:eshop/model/governate_data.dart';
import 'package:eshop/utils/constants.dart';
import 'package:eshop/utils/log.dart';
import 'package:http/http.dart' as http;

Future<List<Governate>?> getAllGovernate(int offset, int limit) async {
  final response = await http.get(
      Uri.parse(Constants.apiPath + "/Counteries?Offset=$offset&Limit=$limit"));
  print(response.statusCode);
  print(response.body);
  Log.d(response.body.toString());
  try {
    if (response.statusCode == 200) {
      // print(response.body);
      return governateFromJson(response.body).governate;
    } else {
      // print(response.statusCode);
      return null;
    }
  } catch (e) {
    Log.e(e.toString());
    throw e;
  }
}

Future<List<City>?> getCityByGovernateId(
    int offset, int limit, String governateId) async {
  final response = await http.get(Uri.parse(Constants.apiPath +
      "/City/GetCityByCountery?Offset=$offset&Limit=$limit&Counteryid=$governateId"));
  try {
    if (response.statusCode == 200) {
      // print(response.body);
      return cityDataFromJson(response.body).city;
    } else {
      // print(response.statusCode);
      return null;
    }
  } catch (e) {
    throw e;
  }
}
