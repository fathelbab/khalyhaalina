import 'dart:ui';
import 'package:collection/collection.dart' show IterableExtension;
import 'package:eshop/language/app_locale.dart';
import 'package:eshop/model/city_data.dart';
import 'package:eshop/provider/city_provider.dart';
import 'package:eshop/utils/cache_helper.dart';
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
  late String locale;

  String? _selectedCity;
  @override
  void initState() {
    super.initState();
    locale = CacheHelper.getPrefs(key: "locale") ?? "ar";
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
                locale == "ar"
                    ? cityId = cityList!
                        .firstWhereOrNull(
                            (city) => (city.nameAr == _selectedCity))!
                        .id
                        .toString()
                    : cityId = cityList!
                        .firstWhereOrNull(
                            (city) => (city.nameEn == _selectedCity))!
                        .id
                        .toString();
              });
              saveNewValue(cityId, _selectedCity.toString());
            },
            items: locale == "ar"
                ? cityList!
                    .map(
                      (city) => DropdownMenuItem(
                        value: city.nameAr,
                        child: Text(
                          city.nameAr ?? "",
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ),
                    )
                    .toList()
                : cityList!
                    .map(
                      (city) => DropdownMenuItem(
                        value: city.nameEn,
                        child: Text(
                          city.nameEn ?? "",
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ),
                    )
                    .toList()),
      ),
    );
  }

  saveNewValue(String cityId, String cityName) {
    Provider.of<CityProvider>(context, listen: false)
        .saveUserCity(cityId, cityName);
  }
}
