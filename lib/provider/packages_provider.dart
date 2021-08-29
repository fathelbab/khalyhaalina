import 'package:eshop/data/service/packages_service.dart';
import 'package:eshop/model/packages_data.dart';
import 'package:eshop/utils/cache_helper.dart';
import 'package:flutter/material.dart';

class PackagesProviders with ChangeNotifier {
  List<PackagesData> _packages = [];
  getPackages() async {
    _packages = await getPackagesService();
    notifyListeners();
  }

  List<PackagesData> get packages => _packages;

  Future<String> confirmBuyPackage(
    String name,
    String address,
    String phoneNumber,
    int packageId,
    int price,
  ) async {
    String accessToken = CacheHelper.getPrefs(key: "token");
    return await confirmBuyPackageService(
      accessToken,
      name,
      address,
      phoneNumber,
      packageId,
      price,
    );
  }
}
