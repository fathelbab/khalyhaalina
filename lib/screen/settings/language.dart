import 'package:eshop/provider/settings_provider.dart';
import 'package:eshop/utils/components.dart';
import 'package:eshop/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageScreen extends StatefulWidget {
  static const String route = "/language";
  LanguageScreen({Key? key}) : super(key: key);

  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<SettingsProvider>(
      builder: (context, settings, child) => Scaffold(
        backgroundColor: Colors.grey[100],
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            width: size.width,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 50, bottom: 15),
                  height: 250,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/app_logo.png"),
                        scale: 1,
                        fit: BoxFit.fill),
                  ),
                ),
                Text(
                  getString(context, "chooseLanguage"),
                  style: TextStyle(
                    fontSize: 30,
                    color: secondaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  child: Text(
                    'العربية',
                    style: TextStyle(
                      fontSize: 25,
                      color:
                          settings.locale == "ar" ? Colors.white : Colors.black,
                    ),
                  ),
                  onPressed: () {
                    settings.changeLocale("ar");
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    primary:
                        settings.locale == "ar" ? secondaryColor : Colors.white,
                    fixedSize: Size(size.width / 1.4, 36),
                    shape: new RoundedRectangleBorder(
                      // side: settings.locale == "ar"
                      //     ? BorderSide(color: secondaryColor, width: 3)
                      //     : BorderSide.none,

                      borderRadius: new BorderRadius.circular(5.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                ElevatedButton(
                  child: Text(
                    'English',
                    style: TextStyle(
                      fontSize: 25,
                      color:
                          settings.locale == "en" ? Colors.white : Colors.black,
                    ),
                  ),
                  onPressed: () {
                    settings.changeLocale("en");
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    fixedSize: Size(size.width / 1.4, 36),
                    primary:
                        settings.locale == "en" ? secondaryColor : Colors.white,
                    // side: settings.locale == "en"
                    //     ? BorderSide(color: secondaryColor, width: 3)
                    //     : BorderSide.none,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
