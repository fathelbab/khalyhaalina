import 'dart:ui';
import 'package:collection/collection.dart' show IterableExtension;
import 'package:eshop/model/governate_data.dart';
import 'package:eshop/provider/city_provider.dart';
import 'package:eshop/utils/cache_helper.dart';
import 'package:eshop/utils/components.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GovernateDropDownButton extends StatefulWidget {
  @override
  _GovernateDropDownButtonState createState() =>
      _GovernateDropDownButtonState();
}

class _GovernateDropDownButtonState extends State<GovernateDropDownButton> {
  String governateId = "0";
  List<Governate>? governateList = [];
  late String locale;
  String? _selectedGovernate;
  @override
  void initState() {
    super.initState();
    locale = CacheHelper.getPrefs(key: "locale") ?? "ar";
  }

  @override
  Widget build(BuildContext context) {
    governateList = Provider.of<CityProvider>(context).governateList;

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
              getString(context, "governate"),
              style: TextStyle(color: Colors.black),
            ),
            value: _selectedGovernate,
            onChanged: (dynamic newValue) {
              setState(() {
                _selectedGovernate = newValue;
                locale == "ar"
                    ? governateId = governateList!
                        .firstWhereOrNull((governate) =>
                            (governate.nameAr == _selectedGovernate))!
                        .id
                        .toString()
                    : governateId = governateList!
                        .firstWhereOrNull((governate) =>
                            (governate.nameEn == _selectedGovernate))!
                        .id
                        .toString();
                ;
              });
              saveNewValue(context, governateId, _selectedGovernate.toString());
            },
            items: governateList!
                .map(
                  (governate) => locale == "ar"
                      ? DropdownMenuItem(
                          value: governate.nameAr,
                          child: Text(
                            governate.nameAr ?? "",
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        )
                      : DropdownMenuItem(
                          value: governate.nameEn,
                          child: Text(
                            governate.nameEn ?? "",
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        ),
                )
                .toList()),
      ),
    );
  }

  saveNewValue(context, String governateId, String governorateName) {
    Provider.of<CityProvider>(context, listen: false)
        .saveUserGovernate(governateId, governorateName);
    Provider.of<CityProvider>(context, listen: false)
        .fetchCityList(1, 200, governateId);
  }
}
