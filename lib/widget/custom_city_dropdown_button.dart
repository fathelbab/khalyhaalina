import 'package:eshop/model/CityData.dart';
import 'package:eshop/provider/city_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomCityDropDownButton extends StatefulWidget {
  @override
  _CustomCityDropDownButtonState createState() =>
      _CustomCityDropDownButtonState();
}

class _CustomCityDropDownButtonState extends State<CustomCityDropDownButton> {
  String cityId = "0";
  List<City> cityList = [];

  String _selectedCity;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    cityList = Provider.of<CityProvider>(context, listen: false).cityList;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Theme.of(context).primaryColor,
      ),
      padding: const EdgeInsets.only(
        right: 5,
        left: 5,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButton(
              iconEnabledColor: Colors.white,
              dropdownColor: Theme.of(context).primaryColor,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              hint: Text(
                "المدينة",
              ),
              value: _selectedCity,
              onChanged: (newValue) {
                setState(() {
                  _selectedCity = newValue;
                  cityId = cityList
                          .firstWhere((city) => (city.name == _selectedCity),
                              orElse: () => null)
                          .id
                          .toString() ??
                      "0";
                });
                saveNewValue(cityId);
              },
              items: cityList
                  .map(
                    (city) => DropdownMenuItem(
                      value: city.name,
                      child: Text(
                        city.name ?? "",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                  .toList()),
        ],
      ),
    );
  }

  saveNewValue(String cityId) {
    Provider.of<CityProvider>(context,listen: false).saveUserCity(cityId);
    // final prefs = await SharedPreferences.getInstance();
    // prefs.setString('cityId', cityId);
    // print(cityId);
  }
}
