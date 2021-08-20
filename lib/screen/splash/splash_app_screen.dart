import 'dart:async';
import 'package:eshop/provider/city_provider.dart';
import 'package:eshop/screen/login/login.dart';
import 'package:eshop/utils/style.dart';
import 'package:eshop/screen/home/home_screen.dart';
import 'package:eshop/utils/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashAppScreen extends StatefulWidget {
  static const String route = "/splash";
  @override
  _SplashAppScreenState createState() => _SplashAppScreenState();
}

class _SplashAppScreenState extends State<SplashAppScreen> {
  late String token = "";
  Timer? timer;
  getSharedPrefs() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    token = CacheHelper.getPrefs(key: "token");
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    Provider.of<CityProvider>(context, listen: false)
        .fetchGovernateList(1, 200);
    getSharedPrefs();
    timer = Timer(
      const Duration(seconds: 4),
      () => Navigator.of(context).pushReplacementNamed(
        token == null || token == "" ? Login.route : HomeScreen.route,
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
