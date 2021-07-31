import 'package:eshop/model/doctor_data.dart' hide City;
import 'package:eshop/model/doctor_details_data.dart';
import 'package:eshop/model/doctor_specialist_data.dart';
import 'package:eshop/utils/contants.dart';
import 'package:http/http.dart' as http;

Future<List<DoctorSpecialistt>?> getAllDoctorSpecialist() async {
  final response = await http.get(Uri.parse(
      Constants.apiPath + "/DoctorSpecialist/GetAll?Offset=1&Limit=100"));
  try {
    if (response.statusCode == 200) {
      // print(response.body);
      return doctorSpecialistDataFromJson(response.body).doctorSpecialist;
    } else {
      // print(response.statusCode);
      return null;
    }
  } catch (e) {
    throw e;
  }
}

Future<List<DoctorInfo>?> getAllDoctorList(
    String? cityId, String? specialistId) async {
  try {
    final response = await http.get(Uri.parse(Constants.apiPath +
        "/Doctor/GetAll?Offset=1&Limit=100&CityId=$cityId&DoctorSpecialistId=$specialistId"));

    // print("done${response.body}");

    if (response.statusCode == 200) {
      // print("done${response.body}");
      return doctorDataFromJson(response.body).result;
    } else {
      // print(response.statusCode);
      return null;
    }
  } catch (e) {
    throw e;
  }
}

Future<DoctorDetailsData?> getDoctorByID(String doctorId) async {
  final response = await http
      .get(Uri.parse(Constants.apiPath + "/Doctor/getById/$doctorId"));
  try {
    if (response.statusCode == 200) {
      // print(response.body);
      return doctorDetailsDataFromJson(response.body);
    } else {
      return null;
    }
  } catch (e) {
    throw e;
  }
}
