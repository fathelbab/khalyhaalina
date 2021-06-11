import 'package:collection/collection.dart' show IterableExtension;
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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Theme.of(context).primaryColor,
        
        border: Border.all(
        
          width: 3,
          color: Color(0XFFE5A352),
        ),
      ),
      padding: const EdgeInsets.only(
        right: 5,
        left: 5,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButtonHideUnderline(
            child: DropdownButton(
              elevation: 16,
                iconEnabledColor: Colors.white,
                dropdownColor: Theme.of(context).primaryColor,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                hint: Text(
                  "المدينة",
                  style: TextStyle(color: Colors.white),
                ),
                value: _selectedCity,
                onChanged: (dynamic newValue) {
                  setState(() {
                    _selectedCity = newValue;
                    cityId = cityList!
                        .firstWhereOrNull(
                            (city) => (city.name == _selectedCity))!
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
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                    .toList()),
          ),
        ],
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
