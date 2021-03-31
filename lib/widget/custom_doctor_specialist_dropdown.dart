import 'package:eshop/model/CityData.dart';
import 'package:eshop/model/doctor_specialist_data.dart';
import 'package:eshop/provider/city_provider.dart';
import 'package:eshop/provider/doctor_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDoctorDropDownButton extends StatefulWidget {
  @override
  _CustomDoctorDropDownButtonState createState() =>
      _CustomDoctorDropDownButtonState();
}

class _CustomDoctorDropDownButtonState extends State<CustomDoctorDropDownButton> {
  String _doctorSpcialistId;
  List<DoctorSpecialistt> doctorSpeciaList = [];

  String _selectedDoctorSpecialist;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    doctorSpeciaList =
        Provider.of<DoctorProvider>(context).doctorSpecialistList;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
     
      ),
     margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.only(
        right: 5,
        left: 5,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButton(
              // dropdownColor: Theme.of(context).primaryColor,

              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              hint: Text(
                "التخصص",
              ),
              value: _selectedDoctorSpecialist,
              onChanged: (newValue) {
                setState(() {
                  _selectedDoctorSpecialist = newValue;
                  _doctorSpcialistId = doctorSpeciaList
                          .firstWhere((speacial) =>
                              (speacial.name == _selectedDoctorSpecialist))
                          .id
                          .toString() ??
                      "0";
                });
                fectchDoctorList();
              },
              items: doctorSpeciaList
                  .map(
                    (speacial) => DropdownMenuItem(
                      value: speacial.name,
                      child: Text(
                        speacial.name ?? "",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  )
                  .toList()),
        ],
      ),
    );
  }

  void fectchDoctorList() {
    Provider.of<DoctorProvider>(context, listen: false).fetchDoctorList(_doctorSpcialistId);
  }
}
