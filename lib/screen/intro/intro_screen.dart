import 'dart:async';
import 'package:eshop/provider/configurations_provider.dart';
import 'package:eshop/screen/home/home_screen.dart';
import 'package:eshop/screen/login/login.dart';
import 'package:eshop/utils/cache_helper.dart';
import 'package:eshop/utils/components.dart';
import 'package:eshop/utils/constants.dart';
import 'package:eshop/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IntroScreen extends StatefulWidget {
  static const String route = "/intro";
  const IntroScreen({Key? key}) : super(key: key);

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  String token = "";
  Timer? timer;
  @override
  void initState() {
    super.initState();

    token = CacheHelper.getPrefs(key: "token") ?? "";
    timer = Timer(
      const Duration(seconds: 15),
      () {
        if (token == "") {
          Navigator.of(context).pushReplacementNamed(Login.route);
        } else {
          Navigator.of(context).pushReplacementNamed(
            HomeScreen.route,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ConfigurationProvider>(
      builder: (context, configuration, child) => Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Image.network(
                Constants.imagePath +
                    configuration.configuration!.gif.toString(),
                fit: BoxFit.contain,
              ),
            ),
            Row(
              children: [
                TextButton.icon(
                  style: ButtonStyle(),
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: primaryColor,
                  ),
                  onPressed: () {
                    timer!.cancel();
                    Navigator.of(context).pushReplacementNamed(
                      HomeScreen.route,
                    );
                  },
                  label: Text(
                    getString(context, "skip"),
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
