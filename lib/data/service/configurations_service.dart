import 'dart:convert';
import 'package:eshop/model/configurations_data.dart';
import 'package:eshop/utils/constants.dart';
import 'package:http/http.dart' as http;

Future<ConfigurationsData?> getConfigrationsService() async {
  try {
    final response = await http.get(
      Uri.parse(Constants.apiPath + '/Configrations'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return configrationsDataFromJson(response.body)[0];
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}
