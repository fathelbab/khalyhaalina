import 'dart:async';

import 'package:eshop/constant/constant.dart';
import 'package:eshop/screen/city/city_screen.dart';
import 'package:eshop/screen/home/home_screen.dart';
import 'package:eshop/utils/cache_helper.dart';
import 'package:flutter/material.dart';

class SplashAppScreen extends StatefulWidget {
  static const String route = "/splash";
  @override
  _SplashAppScreenState createState() => _SplashAppScreenState();
}

class _SplashAppScreenState extends State<SplashAppScreen> {
  String? cityId = "0";
  Timer? timer;
  getSharedPrefs() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    cityId = CacheHelper.getPrefs(key: "cityId");
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getSharedPrefs();
    timer = Timer(
      const Duration(seconds: 4),
      () => Navigator.of(context).pushReplacementNamed(
        cityId == "0" ? CityScreen.route : HomeScreen.route,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/app_logo.png',
            ),
          ],
        ),
      ),
    );
  }
}
//  SplashScreen(
//       seconds: 5,
//       navigateAfterSeconds: cityId == "0" ? CityScreen() : HomeScreen(),
//       image: Image.asset(
//         'assets/images/app_logo.png',
//       ),
//       photoSize: 150,
//       backgroundColor: Colors.white,
//       loaderColor: Theme.of(context).primaryColor,
//     )