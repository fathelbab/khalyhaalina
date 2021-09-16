import 'package:eshop/provider/settings_provider.dart';
import 'package:eshop/screen/product_details/product_details_screen.dart';
import 'package:eshop/screen/splash/splash_app_screen.dart';
import 'package:eshop/utils/app_providers.dart';
import 'package:eshop/utils/app_routes.dart';
import 'package:eshop/utils/cache_helper.dart';
import 'package:eshop/utils/local_notification.dart';
import 'package:eshop/utils/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'language/app_locale.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  FirebaseMessaging.onBackgroundMessage(fcmBackgroundMessage);
  await CacheHelper.init();

  runApp(MyApp());
}

// this function working when app in background and when terminated
// to display firebase cloud message
Future fcmBackgroundMessage(RemoteMessage notification) async {
  String image = notification.notification!.body!.split(":::")[1].toString();
  LocalNotification().showNotification(
    title: notification.notification!.title.toString(),
    body: notification.notification!.body!.split(":::")[0].toString(),
    image: image,
  );
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
    this.initDynamicLinks(context);
    super.didChangeDependencies();
  }

  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  Future<void> initDynamicLinks(BuildContext context) async {
    try {
      // configure listeners for link callbacks
      // when the application is active or in background calling onLink.
//https://khlihaalina.page.link/?link=khlihaalina.page.link&apn=com.kira.eshop&amv=13&ibi=com.kira.eshop&st
      FirebaseDynamicLinks.instance.onLink(
          onSuccess: (PendingDynamicLinkData? dynamicLink) async {
        final Uri? deepLink = dynamicLink?.link;

        if (deepLink != null) {
          if (deepLink.queryParameters.containsKey('id')) {
            String id = deepLink.queryParameters['id'].toString();
            // Log.w("abdo  working$id");
            // showToast(text: id);

            navigatorKey.currentState!.push(MaterialPageRoute(
                builder: (context) => ProductDetailsScreen(
                      id: id,
                    )));
            // Navigator.pushNamed(context, ProductDetailsScreen.route);
          }
        }
      }, onError: (OnLinkErrorException e) async {
        // Log.e(e.message.toString());
      });
      // getInitialLink() will called when app is terminated
      //If your app did not open from a dynamic link, getInitialLink()
      final PendingDynamicLinkData? data =
          await FirebaseDynamicLinks.instance.getInitialLink();
      final Uri? deepLink = data?.link;

      if (deepLink != null) {}

      if (deepLink != null) {
        if (deepLink.queryParameters.containsKey('id')) {
          String id = deepLink.queryParameters['id']!;

          navigatorKey.currentState!.push(MaterialPageRoute(
              builder: (context) => ProductDetailsScreen(
                    id: id,
                  )));
        }
      }
    } catch (e) {
      // print(e.toString());
    }
  }

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
