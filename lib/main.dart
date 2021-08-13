import 'package:eshop/provider/auth_provider.dart';
import 'package:eshop/provider/category_provider.dart';
import 'package:eshop/provider/city_provider.dart';
import 'package:eshop/provider/doctor_provider.dart';
import 'package:eshop/provider/gifmodels_provider.dart';
import 'package:eshop/provider/images_provider.dart';
import 'package:eshop/provider/notification_provider.dart';
import 'package:eshop/provider/order_provider.dart';
import 'package:eshop/provider/product_provider.dart';
import 'package:eshop/provider/service_provider.dart';
import 'package:eshop/provider/supplier_provider.dart';
import 'package:eshop/provider/theme_provider.dart';
import 'package:eshop/screen/intro/intro_screen.dart';
import 'package:eshop/screen/splash/splash_app_screen.dart';
import 'package:eshop/utils/app_routes.dart';
import 'package:eshop/utils/cache_helper.dart';
import 'package:eshop/utils/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'language/app_locale.dart';
import 'provider/announcement_provider.dart';
import 'provider/cart.dart';
import 'provider/contact_us_provider.dart';
import 'provider/pharmacy_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

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
      providers: [
        ChangeNotifierProvider(
          create: (context) => CategoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CityProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SupplierProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PharmacyProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => GifModelsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => Auth(),
        ),
        ChangeNotifierProvider(
          create: (context) => AnnouncementProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ImagesProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (context) => OrderProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DoctorProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CallUsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ServiceProvider(),
        ),
        // ChangeNotifierProvider(
        //   create: (context) => ConnectivityProvider(),
        // ),
        ChangeNotifierProvider(
          create: (context) => NotificationProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        )
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, theme, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: AppTheme().lightTheme,
            darkTheme: AppTheme().darkTheme,
            themeMode: theme.isDark ? ThemeMode.dark : ThemeMode.light,
            supportedLocales: [
              Locale('en', ''),
              Locale('ar', ''),
            ],
            locale: Locale('ar', ''),
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
            initialRoute: token == "" || token == null
                ? IntroScreen.route
                : SplashAppScreen.route,
            routes: appRoutes(context),
          );
        },
      ),
    );
  }
}
