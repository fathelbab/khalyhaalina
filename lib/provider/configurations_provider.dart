import 'package:eshop/data/service/configurations_service.dart';
import 'package:eshop/model/configurations_data.dart';
import 'package:flutter/material.dart';

class ConfigurationProvider with ChangeNotifier {
  ConfigurationsData? _configuration;

  ConfigurationsData? get configuration => _configuration;

  getConfigurations() async {
    _configuration = await getConfigrationsService();
    notifyListeners();
  }
}
