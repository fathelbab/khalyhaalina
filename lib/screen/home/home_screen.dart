import 'package:eshop/provider/auth_provider.dart';
import 'package:eshop/screen/category/category_screen.dart';
import 'package:eshop/utils/cache_helper.dart';
import 'package:eshop/utils/style.dart';
import 'package:eshop/language/app_locale.dart';
import 'package:eshop/model/bar_item.dart';
import 'package:eshop/provider/cart.dart';
import 'package:eshop/screen/cart/cart_screen.dart';
import 'package:eshop/screen/home/home_category_screen.dart';
import 'package:eshop/screen/pharmacy/pharmacy_screen.dart';
import 'package:eshop/utils/local_notification.dart';
import 'package:eshop/widget/badge.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String route = "/home_screen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  int _selectedPageIndex = 0;
  List<BarItem>? barItems;
  List<Widget> _screens = [
    HomeCategoryScreen(),
    CategoryScreen(),
    // CallUsScreen(),
    PharmacyScreen()
  ];
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    barItems = [
      BarItem(
        text: AppLocale.of(context)!.getString('home'),
        iconData: Icons.home,
        color: Color(0xFF5c8bb0),
      ),
      BarItem(
        text: AppLocale.of(context)!.getString('category'),
        iconData: Icons.view_module_rounded,
        color: Color(0xFF5c8bb0),
      ),
      // BarItem(
      //   text: AppLocale.of(context)!.getString('callUs'),
      //   iconData: FontAwesomeIcons.whatsapp,
      //   color: Colors.yellow.shade900,
      // ),
      // BarItem(
      //   text: AppLocale.of(context)!.getString('callUs'),
      //   // iconData: Icons.apps,
      //   iconData: Icons.clear_all_sharp,
      //   // iconData: Icons.auto_awesome_motion_rounded ,
      //   color: Colors.yellow.shade900,
      // ),
      BarItem(
        text: AppLocale.of(context)!.getString('pharmacy'),
        iconData: Icons.local_pharmacy,
        color: Color(0xFF5c8bb0),
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    final String token = CacheHelper.getPrefs(key: "token");

    firebaseMessaging.getToken().then((mobileToken) {
      // print("============================");
      // print(mobileToken);

      // print("============================");
      if (mobileToken != null && mobileToken.isNotEmpty)
        Provider.of<Auth>(context, listen: false).storeMobileToken(mobileToken);
    });
    firebaseMessaging.onTokenRefresh.listen((mobileToken) {
      // print(mobileToken);
      // Log.d(mobileToken.toString());
      if (token != null || token != "") {
        Provider.of<Auth>(context, listen: false).storeMobileToken(mobileToken);
      }
    });
    // this method need to request FCM permission just in ios
    requestFirebasePermission();
    getFirebaseToken();

    //when user click message and app in background
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      Navigator.pushNamed(context, HomeScreen.route);
    });
    //when user click message and app is terminated
    initialMessage();
  }

  initialMessage() async {
    var notification = await FirebaseMessaging.instance.getInitialMessage();

    if (notification != null) {
      Navigator.pushNamed(context, HomeScreen.route);
    }
  }

  void getFirebaseToken() async {
    FirebaseMessaging.onMessage.listen((notification) {
      String image =
          notification.notification!.body!.split(":::")[1].toString();
      LocalNotification().showNotification(
        title: notification.notification!.title.toString(),
        body: notification.notification!.body!.split(":::")[0].toString(),
        image: image,
      );
    });
  }

  void requestFirebasePermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _screens[_selectedPageIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {},
        child: Consumer<Cart>(
          builder: (_, cart, child) => Badge(
            value: cart.cartItems != null && cart.cartItems!.length > 0
                ? cart.cartItems!.length.toString()
                : "0",
            child: child,
            color: Colors.red,
          ),
          child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: primaryColor,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.route);
              }),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          shape: CircularNotchedRectangle(),
          notchMargin: 10,
          child: Container(
            height: 60,
            margin: EdgeInsets.only(left: 4),
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Container(
                    // color: Colors.amber,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: barItems!
                          .map(
                            (e) => MaterialButton(
                              onPressed: () {
                                setState(() {
                                  _selectedPageIndex = barItems!.indexOf(e);
                                });
                              },
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    e.iconData,
                                    color: primaryColor,
                                  ),
                                  Text(
                                    e.text.toString(),
                                    style: TextStyle(color: primaryColor),
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                      // color: Colors.indigo,
                      ),
                ),
              ],
            ),
          )),
    );
  }

  // void _showScreen(int index) {
  //   setState(() {
  //     _selectedPageIndex = index;
  //   });
  // }
}

// void initDynamicLinks() async {
//   // configure listeners for link callbacks
//   // when the application is active or in background calling onLink.
// //https://khlihaalina.page.link/?link=khlihaalina.page.link&apn=com.kira.eshop&amv=13&ibi=com.kira.eshop&st
//   FirebaseDynamicLinks.instance.onLink(
//       onSuccess: (PendingDynamicLinkData? dynamicLink) async {
//     final Uri? deepLink = dynamicLink?.link;

//     if (deepLink != null) {
//       if (deepLink.queryParameters.containsKey('id')) {
//         String id = deepLink.queryParameters['id'].toString();
//         Log.w(id);
//         Provider.of<ProductProvider>(context).getProductById(int.parse(id));
//         showToast(text: id);
//         Navigator.pop(context);
//         // Navigator.of(context).push(MaterialPageRoute(
//         //     builder: (context) => SplashAppScreen(
//         //           id: id,
//         //         )));
//       }
//     }
//   }, onError: (OnLinkErrorException e) async {
//     print('onLinkError');
//     Log.e(e.message.toString());
//   });
//   // getInitialLink() will called when app is terminated
//   //If your app did not open from a dynamic link, getInitialLink()
//   final PendingDynamicLinkData? data =
//       await FirebaseDynamicLinks.instance.getInitialLink();
//   final Uri? deepLink = data?.link;

//   if (deepLink != null) {}

//   if (deepLink != null) {
//     if (deepLink.queryParameters.containsKey('id')) {
//       String id = deepLink.queryParameters['id']!;
//       Log.w(deepLink.queryParameters.toString());
//       Provider.of<ProductProvider>(context).getProductById(
//           int.parse(deepLink.queryParameters['title'].toString()));
//       Navigator.pushNamed(context, ProductDetailsScreen.route);
//     }
//   }
// }
// Scaffold(
//       body: _screens[_selectedPageIndex],
//       floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
//       floatingActionButton: FloatingActionButton(
//           backgroundColor: primaryColor,
//           onPressed: () {},
//           child: Icon(Icons.shopping_cart)),

//       bottomNavigationBar: BottomAppBar(
//           color: primaryColor,
//           shape: CircularNotchedRectangle(),
//           notchMargin: 10,
//           child: Container(
//             height: 56,
//             margin: EdgeInsets.only(right: 8),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: <Widget>[
//                 SizedBox(width: 50),
//                 MaterialButton(
//                   onPressed: () {},
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Icon(
//                         Icons.message,
//                         color: Colors.white,
//                       ),
//                       Text(
//                         "data",
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ],
//                   ),
//                 ),
//                 MaterialButton(
//                   onPressed: () {},
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Icon(
//                         Icons.message,
//                         color: Colors.white,
//                       ),
//                       Text(
//                         "data",
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ],
//                   ),
//                 ),
//                 MaterialButton(
//                   onPressed: () {},
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Icon(
//                         Icons.message,
//                         color: Colors.white,
//                       ),
//                       Text(
//                         "data",
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ],
//                   ),
//                 ),
//                 MaterialButton(
//                   onPressed: () {},
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Icon(
//                         Icons.message,
//                         color: Colors.white,
//                       ),
//                       Text(
//                         "data",
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ],
//                   ),
//                 ),
//                 // The dummy child
//               ],
//             ),
//           )),

//     )
