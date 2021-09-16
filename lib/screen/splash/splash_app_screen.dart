import 'dart:async';
import 'package:eshop/provider/city_provider.dart';
import 'package:eshop/provider/configurations_provider.dart';
import 'package:eshop/provider/product_provider.dart';
import 'package:eshop/screen/intro/intro_screen.dart';
import 'package:eshop/screen/login/login.dart';
import 'package:eshop/screen/product_details/product_details_screen.dart';
import 'package:eshop/utils/animations.dart';
import 'package:eshop/utils/components.dart';
import 'package:eshop/utils/log.dart';
import 'package:eshop/utils/style.dart';
import 'package:eshop/utils/cache_helper.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashAppScreen extends StatefulWidget {
  static const String route = "/splash";
  final String? id;

  const SplashAppScreen({Key? key, this.id}) : super(key: key);
  @override
  _SplashAppScreenState createState() => _SplashAppScreenState();
}

class _SplashAppScreenState extends State<SplashAppScreen> {
  String token = "";
  Timer? timer;

  @override
  void initState() {
    super.initState();
    checkConnection().then((value) {
      if (value) {
        Provider.of<CityProvider>(context, listen: false)
            .fetchGovernateList(1, 200);
        Provider.of<ConfigurationProvider>(context, listen: false)
            .getConfigurations();

        token = CacheHelper.getPrefs(key: "token") ?? "";

        timer = Timer(const Duration(seconds: 4), () {
          Navigator.of(context).pushReplacementNamed(IntroScreen.route);
        });
      } else {
        WidgetsBinding.instance!
            .addPostFrameCallback((_) => _showStartDialog());
      }
    });
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

  _showStartDialog() async {
    return showGeneralDialog(
      context: context,
      barrierLabel: '',
      barrierDismissible: true,
      transitionBuilder: (context, _animation, _secondaryAnimation, _child) {
        return Animations.grow(_animation, _secondaryAnimation, _child);
      },
      pageBuilder: (_animation, _secondaryAnimation, _child) {
        return AlertDialog(
          content: Text(
            getString(context, "internetProblem"),
            style: TextStyle(
              color: primaryColor,
              fontSize: 20,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                getString(context, "yes"),
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 20,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context)
                    .pushReplacementNamed(SplashAppScreen.route);
              },
            ),
          ],
        );
      },
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
