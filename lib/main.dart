import 'package:eshop/provider/settings_provider.dart';
import 'package:eshop/screen/product_details/product_details_screen.dart';
import 'package:eshop/screen/splash/splash_app_screen.dart';
import 'package:eshop/utils/app_providers.dart';
import 'package:eshop/utils/app_routes.dart';
import 'package:eshop/utils/cache_helper.dart';
// import 'package:eshop/utils/local_notification.dart';
import 'package:eshop/utils/theme.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'language/app_locale.dart';

void main() async {
 
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  
  await CacheHelper.init();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // final token;

  // MyApp(this.token);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void didChangeDependencies() {
   
    super.didChangeDependencies();
  }

  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: appProviders,
      child: Consumer<SettingsProvider>(
        builder: (context, settings, child) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            title: '',
            debugShowCheckedModeBanner: false,
            theme: AppTheme().lightTheme,
            darkTheme: AppTheme().darkTheme,
            themeMode: settings.isDark ? ThemeMode.dark : ThemeMode.light,
            supportedLocales: [
              Locale('en', ''),
              Locale('ar', ''),
            ],
            locale: Locale(settings.locale, ''),
            localizationsDelegates: [
              AppLocale.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            // this method localeResolutionCallback return  device current locale
            localeResolutionCallback: (currentLocale, supportedLocales) {
              if (currentLocale != null) {
                print(currentLocale.languageCode);
                for (Locale locale in supportedLocales) {
                  if (currentLocale.languageCode == locale.languageCode) {
                    return currentLocale;
                  }
                }
              }
              return supportedLocales.first;
            },
            initialRoute: SplashAppScreen.route,
            routes: appRoutes(context),
          );
        },
      ),
    );
  }

  // Future<Uri> _createDynamicLink(bool short) async {

}
