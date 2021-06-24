import 'package:eshop/constant/constant.dart';
import 'package:eshop/language/app_locale.dart';
import 'package:eshop/model/bar_item.dart';
import 'package:eshop/provider/bar_style.dart';
import 'package:eshop/provider/cart.dart';
import 'package:eshop/screen/call_us/call_us.dart';
import 'package:eshop/screen/cart/cart_screen.dart';
import 'package:eshop/screen/home/category_screen.dart';
import 'package:eshop/screen/info/info_screen.dart';
import 'package:eshop/screen/pharmacy/pharmacy_screen.dart';
import 'package:eshop/widget/animated_button.dart';
import 'package:eshop/widget/badge.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    CategoryScreen(),
    InfoScreen(),
    CallUsScreen(),
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
        text: AppLocale.of(context)!.getString('info'),
        iconData: Icons.info,
        color: Color(0xFF5c8bb0),
      ),
      BarItem(
        text: AppLocale.of(context)!.getString('callUs'),
        iconData: FontAwesomeIcons.whatsapp,
        color: Colors.yellow.shade900,
      ),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _screens[_selectedPageIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
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
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.route);
              }),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          color: primaryColor,
          shape: CircularNotchedRectangle(),
          notchMargin: 10,
          child: Container(
            height: 56,
            margin: EdgeInsets.only(left: 8),
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
                            (e) => IconButton(
                              onPressed: () {
                                setState(() {
                                  _selectedPageIndex = barItems!.indexOf(e);
                                });
                              },
                              icon: Icon(
                                e.iconData,
                                color: Colors.white,
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
