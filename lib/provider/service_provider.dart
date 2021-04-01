import 'package:eshop/model/doctor_data.dart';
import 'package:eshop/model/doctor_details_data.dart';
import 'package:eshop/model/service_details_data.dart';
import 'package:eshop/model/service_specialist_data.dart';
import 'package:flutter/foundation.dart';
import 'package:eshop/data/service/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServiceProvider extends ChangeNotifier {
  List<ServiceSpecialist> _serviceSpecialistList = [];
  List<ServiceInfo> _serviceDetailsList = [];
  List<ServiceSpecialist> get serviceSpecialistList => _serviceSpecialistList;
  List<ServiceInfo> get serviceList => _serviceDetailsList;

  fetchServiceSpecialist() async {
    _serviceSpecialistList = await getAllServiceSpecialist();
    notifyListeners();
  }

  fetchServiceInfoList(String serviceSpcialistId) async {
    final cityId = await getCityId();
    _serviceDetailsList = await getAllServiceInfoList(cityId, serviceSpcialistId);
    notifyListeners();
  }

  Future getCityId() async {
    final prefs = await SharedPreferences.getInstance();
    final cityId = prefs.getString('cityId');
    return cityId;
  }
}
