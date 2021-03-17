import 'package:eshop/screen/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashAppScreen extends StatelessWidget {
  static const String route = "/splash";
  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;

    return SplashScreen(
      seconds: 5,
      navigateAfterSeconds: HomeScreen(),
      image: Image.asset(
        'assets/images/app_logo.png',
      ),
      photoSize: 150,
      backgroundColor: Colors.white,
      loaderColor: Theme.of(context).primaryColor,
    );
  }
}
