import 'package:eshop/screen/address/city_screen.dart';
import 'package:eshop/screen/address/governorate_screen.dart';
import 'package:eshop/screen/call_us/call_us.dart';
import 'package:eshop/screen/cart/cart_screen.dart';
import 'package:eshop/screen/favourite/favourite_screen.dart';
import 'package:eshop/screen/home/category_screen.dart';
import 'package:eshop/screen/doctor_details_screen.dart';
import 'package:eshop/screen/home/home_screen.dart';
import 'package:eshop/screen/intro/intro_screen.dart';
import 'package:eshop/screen/login/login.dart';
import 'package:eshop/screen/order/order_screen.dart';
import 'package:eshop/screen/product_details/product_details_screen.dart';
import 'package:eshop/screen/product_screen.dart';
import 'package:eshop/screen/search/search_screen.dart';
import 'package:eshop/screen/services/services_screen.dart';
import 'package:eshop/screen/settings/settings.dart';
import 'package:eshop/screen/signup/signup.dart';
import 'package:eshop/screen/splash/splash_app_screen.dart';
import 'package:eshop/screen/supplier/supplier_screen.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> appRoutes(context) {
  return {
    '/': (context) => HomeScreen(),
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
    CallUsScreen.route: (context) => CallUsScreen(),
    DoctorDetailsScreen.route: (context) => DoctorDetailsScreen(),
    ServicesScreen.route: (context) => ServicesScreen(),
    SettingsScreen.route: (context) => SettingsScreen(),
    GovernorateScreen.route: (context) => GovernorateScreen(),
    IntroScreen.route: (context) => IntroScreen(),
    SupplierScreen.route: (context) => SupplierScreen(),
    FavouriteScreen.route: (context) => FavouriteScreen(),
  };
}
