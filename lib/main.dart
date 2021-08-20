import 'package:eshop/provider/settings_provider.dart';
import 'package:eshop/screen/splash/splash_app_screen.dart';
import 'package:eshop/utils/app_providers.dart';
import 'package:eshop/utils/app_routes.dart';
import 'package:eshop/utils/cache_helper.dart';
import 'package:eshop/utils/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'language/app_locale.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  FirebaseMessaging.onBackgroundMessage(fcmBackgroundMessage);
  await CacheHelper.init();
  final prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token') ?? "";
  print(token);
  runApp(MyApp(token));
}

// this function working when app in background and when terminated
// to display firebase cloud message
Future fcmBackgroundMessage(RemoteMessage message) async {
  print("${message.notification!.body}");
}

class MyApp extends StatelessWidget {
  final token;

  MyApp(this.token);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: appProviders,
      child: Consumer<SettingsProvider>(
        builder: (context, settings, child) {
          return MaterialApp(
            title: 'Flutter Demo',
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
}
