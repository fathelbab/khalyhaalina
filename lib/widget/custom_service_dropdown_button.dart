// import 'package:eshop/model/service_specialist_data.dart';
// import 'package:eshop/provider/service_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class CustomServiceDropDownButton extends StatefulWidget {
//   @override
//   _CustomServiceDropDownButtonState createState() =>
//       _CustomServiceDropDownButtonState();
// }

// class _CustomServiceDropDownButtonState
//     extends State<CustomServiceDropDownButton> {
//   String? _serviceSpcialistId;
//   List<ServiceSpecialist>? serviceSpecialist = [];

//   String? _selectedServiceSpecialist;
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     serviceSpecialist =
//         Provider.of<ServiceProvider>(context).serviceSpecialistList;
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(5.0),
//       ),
//       margin: const EdgeInsets.all(5),
//       padding: const EdgeInsets.only(
//         right: 5,
//         left: 5,
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           DropdownButton(
//               // dropdownColor: Theme.of(context).primaryColor,

//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//               ),
//               hint: Text(
//                 "الخدمات",
//               ),
//               value: _selectedServiceSpecialist,
//               onChanged: (dynamic newValue) {
//                 setState(() {
//                   _selectedServiceSpecialist = newValue;
//                   _serviceSpcialistId = serviceSpecialist!
//                       .firstWhere((speacial) =>
//                           (speacial.name == _selectedServiceSpecialist))
//                       .id
//                       ?.toString();
//                 });
//                 fectchDoctorList();
//               },
//               items: serviceSpecialist!
//                   .map(
//                     (service) => DropdownMenuItem(
//                       value: service.name.toString(),
//                       child: Text(
//                         service.name.toString(),
//                         style: TextStyle(color: Colors.black),
//                       ),
//                     ),
//                   )
//                   .toList()),
//         ],
//       ),
//     );
//   }

//   void fectchDoctorList() {
//     Provider.of<ServiceProvider>(context, listen: false)
//         .fetchServiceInfoList(_serviceSpcialistId);
//   }
// }
