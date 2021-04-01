import 'package:eshop/model/CityData.dart';
import 'package:eshop/model/doctor_specialist_data.dart';
import 'package:eshop/model/service_specialist_data.dart';
import 'package:eshop/provider/city_provider.dart';
import 'package:eshop/provider/doctor_provider.dart';
import 'package:eshop/provider/service_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomServiceDropDownButton extends StatefulWidget {
  @override
  _CustomServiceDropDownButtonState createState() =>
      _CustomServiceDropDownButtonState();
}

class _CustomServiceDropDownButtonState
    extends State<CustomServiceDropDownButton> {
  String _serviceSpcialistId;
  List<ServiceSpecialist> serviceSpecialist = [];

  String _selectedServiceSpecialist;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    serviceSpecialist =
        Provider.of<ServiceProvider>(context).serviceSpecialistList;
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
                "الخدمات",
              ),
              value: _selectedServiceSpecialist,
              onChanged: (newValue) {
                setState(() {
                  _selectedServiceSpecialist = newValue;
                  _serviceSpcialistId = serviceSpecialist
                          .firstWhere((speacial) =>
                              (speacial.name == _selectedServiceSpecialist))
                          .id
                          .toString() ??
                      "0";
                });
                fectchDoctorList();
              },
              items: serviceSpecialist
                  .map(
                    (service) => DropdownMenuItem(
                      value: service.name,
                      child: Text(
                        service.name ?? "",
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
    Provider.of<ServiceProvider>(context, listen: false)
        .fetchServiceInfoList(_serviceSpcialistId);
  }
}
