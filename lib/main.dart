import 'package:eshop/constant/constant.dart';
import 'package:eshop/provider/auth_provider.dart';
import 'package:eshop/provider/category_provider.dart';
import 'package:eshop/provider/city_provider.dart';
import 'package:eshop/provider/doctor_provider.dart';
import 'package:eshop/provider/images_provider.dart';
import 'package:eshop/provider/notification_provider.dart';
import 'package:eshop/provider/order_provider.dart';
import 'package:eshop/provider/product_provider.dart';
import 'package:eshop/provider/supplier_provider.dart';
import 'package:eshop/screen/cart/cart_screen.dart';
import 'package:eshop/screen/category_screen.dart';
import 'package:eshop/screen/city/city_screen.dart';
import 'package:eshop/screen/doctor_details_screen.dart';
import 'package:eshop/screen/home/home_screen.dart';
import 'package:eshop/screen/login/login.dart';
import 'package:eshop/screen/order/order_screen.dart';
import 'package:eshop/screen/product_details/product_details_screen.dart';
import 'package:eshop/screen/product_screen.dart';
import 'package:eshop/screen/search/search_screen.dart';
import 'package:eshop/screen/signup/signup.dart';
import 'package:eshop/screen/splash/splash_app_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';

import 'language/app_locale.dart';
import 'provider/announcement_provider.dart';
import 'provider/cart.dart';
import 'provider/contact_us_provider.dart';
import 'provider/pharmacy_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token') ?? "";
  print(token);
  runApp(MyApp(token));
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
        ),  ChangeNotifierProvider(
          create: (context) => CallUsProvider(),
        ),
        // ChangeNotifierProvider(
        //   create: (context) => ConnectivityProvider(),
        // ),
        ChangeNotifierProvider(
          create: (context) => NotificationProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: primaryColor,
          fontFamily: 'Anton',
          visualDensity: VisualDensity.adaptivePlatformDensity,
          accentColor: Colors.blueGrey,
        ),
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
        initialRoute:
            token == "" || token == null ? Login.route : SplashAppScreen.route,
        routes: {
          // '/': (context) => HomeScreen(),
          Login.route: (context) => Login(),
          HomeScreen.route: (context) => HomeScreen(),
          CategoryScreen.route: (context) => CategoryScreen(),
          ProductScreen.route: (context) => ProductScreen(),
          ProductDetailsScreen.route: (context) => ProductDetailsScreen(),
          SignUp.route: (context) => SignUp(),
          SplashAppScreen.route: (context) => SplashAppScreen(),
          SearchScreen.route: (context) => SearchScreen(),
          CartScreen.route: (context) => CartScreen(),
          OrderScreen.route: (context) => OrderScreen(),
          CityScreen.route: (context) => CityScreen(),
          DoctorDetailsScreen.route: (context) => DoctorDetailsScreen(),
        },
      ),
    );
  }
}
