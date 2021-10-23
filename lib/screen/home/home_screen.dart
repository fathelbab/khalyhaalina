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
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String route = "/home_screen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
}
