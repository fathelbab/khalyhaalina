import 'dart:ui';

import 'package:eshop/language/app_locale.dart';
import 'package:eshop/provider/city_provider.dart';
import 'package:eshop/screen/home/category_screen.dart';
import 'package:eshop/utils/components.dart';
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
    // Provider.of<CityProvider>(context, listen: false).fetchCityList(1, 100);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/delivery_employees.jpg'),
              fit: BoxFit.fill,
            ),
          ),

          //I blured the parent container to blur background image, you can get rid of this part
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 50, bottom: 25),
                    width: 200,
                    height: 150,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 10,
                          offset: Offset(0, 1), // changes position of shadow
                        ),
                      ],
                      image: DecorationImage(
                          image: AssetImage("assets/images/app_logo.png"),
                          fit: BoxFit.fill),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  CustomCityDropDownButton(),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Consumer<CityProvider>(
                        builder: (context, address, child) {
                      return ElevatedButton(
                        onPressed: () {
                          if (address.cityId != "0") {
                            Navigator.of(context)
                                .pushReplacementNamed(CategoryScreen.route);
                          } else
                            showToast(
                              text: getString(context, "cityError"),
                              bgColor: Colors.red,
                            );
                        },
                        style: ElevatedButton.styleFrom(
                            onPrimary: Colors.white,
                            primary: secondaryColor,
                            elevation: 15,
                            shape: StadiumBorder()),
                        child: Text(
                          AppLocale.of(context)!.getString("save").toString(),
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
