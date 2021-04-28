import 'package:eshop/model/doctor_data.dart';
import 'package:eshop/model/doctor_details_data.dart';
import 'package:eshop/model/doctor_specialist_data.dart';
import 'package:flutter/foundation.dart';
import 'package:eshop/data/service/services.dart';
import 'package:eshop/model/CityData.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoctorProvider extends ChangeNotifier {
  List<DoctorSpecialistt> _doctorSpecialistList = [];
  List<DoctorInfo> _doctorList = [];
  List<DoctorSpecialistt> get doctorSpecialistList => _doctorSpecialistList;
  List<DoctorInfo> get doctorList => _doctorList;
  DoctorDetailsData _doctorDetailsData;
  DoctorDetailsData get doctorDetailsData => _doctorDetailsData;
  fetchDoctorSpecialist() async {
    _doctorSpecialistList = await getAllDoctorSpecialist();
    notifyListeners();
  }

  fetchDoctorList(String doctorSpcialistId) async {
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
}
