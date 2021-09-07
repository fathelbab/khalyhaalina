import 'package:eshop/model/service_details_data.dart' hide ServiceSpecialist;
import 'package:eshop/model/service_specialist_data.dart';
import 'package:eshop/utils/constants.dart';
import 'package:http/http.dart' as http;

Future<List<ServiceInfo>?> getAllServiceInfoList(
    String? cityId, String? specialistId) async {
  try {
    final response = await http.get(Uri.parse(Constants.apiPath +
        "/Service/GetAll?Offset=1&Limit=100&CityId=$cityId&ServiceSpecialistId=$specialistId"));

    // print("done${response.body}");

    if (response.statusCode == 200) {
      // print("done${response.body}");
      return serviceDetailsDataFromJson(response.body).result;
    } else {
      // print(response.statusCode);
      return null;
    }
  } catch (e) {
    throw e;
  }
}

Future<List<ServiceSpecialist>?> getAllServiceSpecialist() async {
  final response = await http.get(Uri.parse(
      Constants.apiPath + "/ServiceSpecialist/GetAll?Offset=1&Limit=100"));
  try {
    if (response.statusCode == 200) {
      // print(response.body);
      return serviceSpecialistDataFromJson(response.body).result;
    } else {
      // print(response.statusCode);
      return [];
    }
  } catch (e) {
    return [];
  }
}
