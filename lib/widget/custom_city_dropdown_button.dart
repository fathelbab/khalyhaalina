import 'dart:ui';

import 'package:collection/collection.dart' show IterableExtension;
import 'package:eshop/constant/constant.dart';
import 'package:eshop/language/app_locale.dart';
import 'package:eshop/model/CityData.dart';
import 'package:eshop/provider/city_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomCityDropDownButton extends StatefulWidget {
  @override
  _CustomCityDropDownButtonState createState() =>
      _CustomCityDropDownButtonState();
}

class _CustomCityDropDownButtonState extends State<CustomCityDropDownButton> {
  String cityId = "0";
  List<City>? cityList = [];

  String? _selectedCity;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    cityList = Provider.of<CityProvider>(context).cityList;

    return Container(
      margin: const EdgeInsets.only(right: 20, left: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.white.withOpacity(0.5),
        border: Border.all(
          width: 3,
          color: Colors.black,
        ),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(1, 2))
        ],
      ),
      padding: const EdgeInsets.only(
        right: 15,
        left: 15,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
            isExpanded: true,
            elevation: 16,
            iconEnabledColor: Colors.black,
            dropdownColor: Colors.white,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            hint: Text(
              AppLocale.of(context)!.getString("selectCity").toString(),
              style: TextStyle(color: Colors.black),
            ),
            value: _selectedCity,
            onChanged: (dynamic newValue) {
              setState(() {
                _selectedCity = newValue;
                cityId = cityList!
                    .firstWhereOrNull((city) => (city.name == _selectedCity))!
                    .id
                    .toString();
              });
              saveNewValue(cityId);
            },
            items: cityList!
                .map(
                  (city) => DropdownMenuItem(
                    value: city.name,
                    child: Text(
                      city.name ?? "",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                )
                .toList()),
      ),
    );
  }

  saveNewValue(String cityId) {
    Provider.of<CityProvider>(context, listen: false).saveUserCity(cityId);
    // final prefs = await SharedPreferences.getInstance();
    // prefs.setString('cityId', cityId);
    // print(cityId);
  }
}
