import 'dart:convert';

import 'package:eshop/model/doctor_data.dart' hide City;
import 'package:eshop/model/doctor_details_data.dart';
import 'package:eshop/model/doctor_specialist_data.dart';
import 'package:eshop/utils/constants.dart';
import 'package:eshop/utils/log.dart';
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

Future<String> sendDoctorBookedDateService(String accessToken, String name,
    int doctorId, String phoneNumber, String bookedDate) async {
  try {
    final response = await http.post(
      Uri.parse("http://ahmedinara00-001-site1.dtempurl.com/api/BookedDoctors"),
      headers: {
        'Content-Type': 'application/json',
        'access_token': accessToken,
      },
      body: jsonEncode(
        {
          "userId": 0,
          "isDeleted": true,
          "bookedDate": bookedDate,
          "doctorId": doctorId,
          "name": name,
          "phone": phoneNumber
        },
      ),
    );
    Log.d(jsonEncode(
      {
        "userId": 0,
        "isDeleted": true,
        "bookedDate": bookedDate,
        "doctorId": doctorId,
        "name": name,
        "phone": phoneNumber
      },
    ));
    Log.d(response.statusCode.toString());
    Log.d(accessToken);
    Log.d(response.body.toString());
    if (response.statusCode == 201) {
      return "done";
    } else {
      return "failed";
    }
  } catch (e) {
    Log.e(e.toString());
    throw e;
  }
}
