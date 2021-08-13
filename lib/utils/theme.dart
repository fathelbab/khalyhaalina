import 'package:eshop/utils/style.dart';
import 'package:flutter/material.dart';

class AppTheme {
  final lightTheme = ThemeData(
    primaryColor: primaryColor,
    fontFamily: 'Anton',
    visualDensity: VisualDensity.adaptivePlatformDensity,
    accentColor: Colors.blueGrey,
  );
  final darkTheme = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: Color(0xFF212121),
    fontFamily: 'Anton',
    dividerColor: Colors.cyanAccent,
    textTheme: TextTheme(
      headline6: TextStyle(color: Colors.amber),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    accentColor: Colors.blueGrey,
  );
}
