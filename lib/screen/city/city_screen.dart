import 'package:eshop/provider/city_provider.dart';
import 'package:eshop/screen/category_screen.dart';
import 'package:eshop/widget/custom_city_dropdown_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CityScreen extends StatefulWidget {
  static const String route = "/city_screen";
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<CityProvider>(context, listen: false).fetchCityList(1, 100);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            child: Image.asset(
              'assets/images/app_logo.png',
            ),
          ),
          CustomCityDropDownButton(),
          SizedBox(
            height: 15,
          ),
          Container(
            width: 110,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(CategoryScreen.route);
              },
              style: ElevatedButton.styleFrom(
                onPrimary: Colors.white,
                primary: Theme.of(context).primaryColor,
              ),
              child: Text(
                "حفظ",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
