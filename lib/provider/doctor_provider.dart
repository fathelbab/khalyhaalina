import 'package:eshop/model/doctor_data.dart';
import 'package:eshop/model/doctor_details_data.dart';
import 'package:eshop/model/doctor_specialist_data.dart';
import 'package:eshop/utils/cache_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:eshop/data/service/doctor_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoctorProvider extends ChangeNotifier {
  List<DoctorSpecialistt>? _doctorSpecialistList = [];
  List<DoctorInfo>? _doctorList = [];
  List<DoctorSpecialistt>? get doctorSpecialistList => _doctorSpecialistList;
  List<DoctorInfo>? get doctorList => _doctorList;
  DoctorDetailsData? _doctorDetailsData;
  DoctorDetailsData? get doctorDetailsData => _doctorDetailsData;
  Future<List<DoctorSpecialistt>?> fetchDoctorSpecialist() async {
    _doctorSpecialistList = await getAllDoctorSpecialist();
    notifyListeners();
    return _doctorSpecialistList;
  }

  Future fetchDoctorList(String? doctorSpcialistId) async {
    final cityId = await getCityId();
    _doctorList = await getAllDoctorList(cityId, doctorSpcialistId);
    notifyListeners();
  }

  getDoctorById(String doctorId) async {
    _doctorDetailsData = await getDoctorByID(doctorId);
    notifyListeners();
  }

  clearDoctorData() {
    _doctorDetailsData = null;
    notifyListeners();
  }

  Future getCityId() async {
    final prefs = await SharedPreferences.getInstance();
    final cityId = prefs.getString('cityId');
    return cityId;
  }

  Future<String> sendDoctorBookedDate(
    String name,
    String phoneNumber,
    String doctorId,
    String bookedDate,
  ) async {
    String accessToken = CacheHelper.getPrefs(key: 'token');
    String response = await sendDoctorBookedDateService(
        accessToken, name, doctorId, phoneNumber, bookedDate);
    return response;
  }
}
