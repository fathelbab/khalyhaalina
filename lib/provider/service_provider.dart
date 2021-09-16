import 'package:eshop/data/service/services_service.dart';
import 'package:eshop/model/service_details_data.dart' hide ServiceSpecialist;
import 'package:eshop/model/service_specialist_data.dart';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServiceProvider extends ChangeNotifier {
  List<ServiceSpecialist>? _serviceSpecialistList = [];
  List<ServiceInfo>? _serviceDetailsList = [];
  List<ServiceSpecialist>? get serviceSpecialistList => _serviceSpecialistList;
  List<ServiceInfo>? get serviceList => _serviceDetailsList;

  Future<List<ServiceSpecialist>?> fetchServiceSpecialist() async {
    _serviceSpecialistList = await getAllServiceSpecialist();
    notifyListeners();
    return _serviceSpecialistList;
  }

  Future fetchServiceInfoList(String? serviceSpcialistId) async {
    final cityId = await getCityId();
    _serviceDetailsList =
        await getAllServiceInfoList(cityId, serviceSpcialistId);
    notifyListeners();
  }

  Future getCityId() async {
    final prefs = await SharedPreferences.getInstance();
    final cityId = prefs.getString('cityId');
    return cityId;
  }
}
