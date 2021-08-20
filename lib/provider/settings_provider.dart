import 'package:eshop/utils/cache_helper.dart';
import 'package:flutter/widgets.dart';

class SettingsProvider with ChangeNotifier {
  bool isDark = false;
  String locale = CacheHelper.getPrefs(key: "locale") ?? "ar";
  changeTheme(bool theme) {
    isDark = theme;
    notifyListeners();
  }

  changeLocale(String localeCode) {
    locale = localeCode;
    CacheHelper.savePrefs(key: "locale", value: localeCode);
    notifyListeners();
  }
}
