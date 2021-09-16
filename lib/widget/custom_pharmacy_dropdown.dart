import 'dart:ui';
import 'package:collection/collection.dart' show IterableExtension;
import 'package:eshop/provider/pharmacy_provider.dart';
import 'package:eshop/utils/cache_helper.dart';
import 'package:eshop/utils/components.dart';
// import 'package:eshop/utils/log.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PharmacyDropDownButton extends StatefulWidget {
  @override
  _PharmacyDropDownButtonState createState() => _PharmacyDropDownButtonState();
}

class _PharmacyDropDownButtonState extends State<PharmacyDropDownButton> {
  String pharmcyId = "0";
  // List<Governate>? governateList = [];
  late String locale;
  String? _selectedPharmacy;
  @override
  void initState() {
    super.initState();
    locale = CacheHelper.getPrefs(key: "locale") ?? "ar";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // governateList = Provider.of<CityProvider>(context).governateList;

    return Consumer<PharmacyProvider>(
      builder: (context, pharmacy, child) => Container(
        margin: EdgeInsets.all(5.0),
        padding: EdgeInsets.only(right: 10, left: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.white,
          // border: Border.all(
          //   width: 3,
          //   color: Colors.black,
          // ),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 1,
                offset: Offset(1, 2))
          ],
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
                getString(context, "choosePharmacy"),
                style: TextStyle(color: Colors.black),
              ),
              value: _selectedPharmacy,
              onChanged: (dynamic newValue) {
                print(newValue);
                setState(() {
                  _selectedPharmacy = newValue;
                  pharmcyId = pharmacy.pharmacyList!
                      .firstWhereOrNull((pharmacy) {
                        String name = locale == "ar"
                            ? pharmacy.nameAr.toString()
                            : pharmacy.nameEn ?? pharmacy.nameAr.toString();
                        if (name == _selectedPharmacy)
                          return true;
                        else
                          return false;
                      })!
                      .id
                      .toString();
                });
                saveNewValue(context, pharmcyId, _selectedPharmacy!);
              },
              items: pharmacy.pharmacyList!
                  .map((pharmacy) => DropdownMenuItem(
                        value: locale == "ar"
                            ? pharmacy.nameAr
                            : pharmacy.nameEn ?? pharmacy.nameAr,
                        child: Text(
                          locale == "ar"
                              ? pharmacy.nameAr!
                              : pharmacy.nameEn ?? pharmacy.nameAr.toString(),
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ))
                  .toList()),
        ),
      ),
    );
  }

  saveNewValue(context, String pharmacyId, String pharmacyName) {
    // Log.d(pharmacyId);
    // Log.d(pharmacyName);
    Provider.of<PharmacyProvider>(context, listen: false)
        .saveUserPharmacy(pharmacyId, pharmacyName);
  }
}
