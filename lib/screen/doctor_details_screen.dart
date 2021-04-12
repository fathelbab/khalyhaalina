import 'package:cached_network_image/cached_network_image.dart';
import 'package:eshop/constant/constant.dart';
import 'package:eshop/provider/doctor_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DoctorDetailsScreen extends StatefulWidget {
  static const String route = "/doctor_details_screen";

  @override
  _DoctorDetailsScreenState createState() => _DoctorDetailsScreenState();
}

class _DoctorDetailsScreenState extends State<DoctorDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final doctorDetails =
        Provider.of<DoctorProvider>(context).doctorDetailsData;
    return Scaffold(
      appBar: AppBar(
        title: Text("المواعيد"),
      ),
      body: doctorDetails == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                width: double.infinity,
                child: Column(
                  children: [
                    CachedNetworkImage(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height / 4,
                      imageUrl: imagePath + doctorDetails.imagePath ,
                      fit: BoxFit.fill,
                      placeholder: (context, url) =>
                          Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                    // Image.network(imagePath + doctorDetails.imagePath,
                    //     fit: BoxFit.fill, width: double.infinity),
                    Container(
                      alignment: Alignment.centerRight,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Text(
                        "الاسم : ${doctorDetails.name}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text("التليفون : ${doctorDetails.phoneNumber}"),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      child: Text("المدينة : ${doctorDetails.city.name}"),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    doctorDetails.doctorTimeTable.isEmpty
                        ? Text("")
                        : DataTable(
                            headingRowColor:
                                MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                              return Color(0xFF5c8bb0);
                            }),
                            dataRowColor:
                                MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                              return Color(0XFFFFFFF);
                            }),
                            columns: [
                              DataColumn(
                                  label: Text(
                                "اليوم",
                                style: TextStyle(color: Colors.white),
                              )),
                              DataColumn(
                                  label: Text(
                                "من",
                                style: TextStyle(color: Colors.white),
                              )),
                              DataColumn(
                                  label: Text(
                                "الي",
                                style: TextStyle(color: Colors.white),
                              )),
                            ],
                            rows: doctorDetails.doctorTimeTable
                                .map(
                                  (timeData) => DataRow(cells: [
                                    DataCell(Text(timeData.doctorDay)),
                                    DataCell(Text(timeData.doctorTime ?? "")),
                                    DataCell(Text(timeData.toDoctorTime ?? "")),
                                  ]),
                                )
                                .toList())
                  ],
                ),
              ),
            ),
    );
  }
}
