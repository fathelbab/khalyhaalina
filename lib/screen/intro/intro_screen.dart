import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:eshop/provider/configurations_provider.dart';
import 'package:eshop/screen/home/home_screen.dart';
import 'package:eshop/screen/login/login.dart';
import 'package:eshop/utils/cache_helper.dart';
import 'package:eshop/utils/components.dart';
import 'package:eshop/utils/constants.dart';
import 'package:eshop/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

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
          bool isCached = CacheHelper.getPrefs(key: 'isCached') ?? true;
          if (isCached) {
            CacheHelper.clearAll();
            CacheHelper.savePrefs(value: false, key: 'isCached');
            Navigator.of(context).pushReplacementNamed(Login.route);
          } else {
            Navigator.of(context).pushReplacementNamed(
              HomeScreen.route,
            );
          }
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
              child: configuration.configuration?.gif != null
                  ? CachedNetworkImage(
                      imageUrl: Constants.imagePath +
                          configuration.configuration!.logo.toString(),
                      placeholder: (context, url) => Center(
                        child:
                            const SpinKitChasingDots(color: Color(0XFFE5A352)),
                      ),
                      errorWidget: (context, url, error) => Center(
                        child: Text(
                          getString(context, "emptyWallet"),
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      fit: BoxFit.contain,
                    )
                  : Center(
                      child: const SpinKitChasingDots(
                        color: Color(0XFFE5A352),
                      ),
                    ),
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  side: BorderSide(
                    width: 3.0,
                    color: primaryColor,
                  ),
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                  ),
                  primary: Colors.white,
                  padding: const EdgeInsets.all(10)),
              icon: Icon(
                Icons.arrow_back_ios,
                color: primaryColor,
              ),
              onPressed: () {
                timer!.cancel();
                if (token == "") {
                  Navigator.of(context).pushReplacementNamed(Login.route);
                } else {
                  Navigator.of(context).pushReplacementNamed(
                    HomeScreen.route,
                  );
                }
              },
              label: Text(
                getString(context, "skip"),
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }
}
