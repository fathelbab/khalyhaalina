import 'package:eshop/screen/category_screen.dart';
import 'package:eshop/screen/city/city_screen.dart';
import 'package:eshop/screen/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashAppScreen extends StatefulWidget {
  static const String route = "/splash";
  @override
  _SplashAppScreenState createState() => _SplashAppScreenState();
}

class _SplashAppScreenState extends State<SplashAppScreen> {
  String cityId = "0";
  getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cityId = prefs.getString("cityId");
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getSharedPrefs();
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;

    return SplashScreen(
      seconds: 5,
      navigateAfterSeconds: cityId == "0" ? CityScreen() : HomeScreen(),
      image: Image.asset(
        'assets/images/app_logo.png',
      ),
      photoSize: 150,
      backgroundColor: Colors.white,
      loaderColor: Theme.of(context).primaryColor,
    );
  }
}
