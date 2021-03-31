import 'package:eshop/constant/constant.dart';
import 'package:eshop/language/app_locale.dart';
import 'package:eshop/screen/call_us/call_us.dart';
import 'package:eshop/screen/category_screen.dart';
import 'package:eshop/screen/info/info_screen.dart';
import 'package:eshop/screen/pharmacy/pharmacy_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String route = "/home_screen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedPageIndex = 0;

  List<Widget> _screens = [
    CategoryScreen(),
    InfoScreen(),
    CallUsScreen(),
    PharmacyScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _showScreen,
        currentIndex: _selectedPageIndex,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: primaryColor,
        unselectedItemColor: Color(0XFF494949),
        elevation: 5,
        selectedFontSize: 14,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: AppLocale.of(context).getString('home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: AppLocale.of(context).getString('info'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.call),
            label: AppLocale.of(context).getString('callUs'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_pharmacy),
            label: AppLocale.of(context).getString('pharmacy'),
          ),
        ],
      ),
    );
  }

  void _showScreen(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }
}
