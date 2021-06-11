import 'package:flutter/widgets.dart';

class ThemeProvider with ChangeNotifier {
  bool isDark = false;
  changeTheme(bool theme) {
    isDark = theme;
    notifyListeners();
  }
}
