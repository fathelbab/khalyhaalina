import 'package:cached_network_image/cached_network_image.dart';
import 'package:eshop/constant/constant.dart';
import 'package:eshop/language/app_locale.dart';
import 'package:eshop/provider/doctor_provider.dart';
import 'package:eshop/utils/constants.dart';
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
        elevation: 0,
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
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height / 4,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              width: 100,
                              height: 120,
                              imageUrl: Constants.imagePath + doctorDetails.imagePath!,
                              fit: BoxFit.fill,
                              placeholder: (context, url) =>
                                  Center(child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${doctorDetails.name}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  " ${doctorDetails.doctorSpecialist?.name}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    // Image.network(imagePath + doctorDetails.imagePath,
                    //     fit: BoxFit.fill, width: double.infinity),
                    // Container(
                    //   alignment: Alignment.centerRight,
                    //   margin: const EdgeInsets.symmetric(
                    //       horizontal: 15, vertical: 10),
                    //   child: Text(
                    //     "الاسم : ${doctorDetails.name}",
                    //     style: TextStyle(fontWeight: FontWeight.bold),
                    //   ),
                    // ),
                    // Container(
                    //   alignment: Alignment.centerRight,
                    //   margin: const EdgeInsets.symmetric(horizontal: 15),
                    //   child: Text("التليفون : ${doctorDetails.phoneNumber}"),
                    // ),
                    // Container(
                    //   alignment: Alignment.centerRight,
                    //   margin: const EdgeInsets.symmetric(
                    //       horizontal: 15, vertical: 5),
                    //   child: Text("المدينة : ${doctorDetails.city!.name}"),
                    // ),
                    SizedBox(
                      height: 15,
                    ),
                    doctorDetails.doctorTimeTable!.isEmpty
                        ? Text("")
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: doctorDetails.doctorTimeTable!.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.all(4),
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: primaryColor, width: 2),
                                    color: Colors.white),
                                child: Column(
                                  children: [
                                    Text(
                                      doctorDetails
                                          .doctorTimeTable![index].doctorDay!,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        doctorDetails.doctorTimeTable![index]
                                                .doctorTime!.isNotEmpty
                                            ? Expanded(
                                                flex: 1,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      AppLocale.of(context)!
                                                          .getString("from")
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                    Text(
                                                      doctorDetails
                                                              .doctorTimeTable![
                                                                  index]
                                                              .doctorTime ??
                                                          "",
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                    Icon(Icons.access_time),
                                                  ],
                                                ),
                                              )
                                            : Container(),
                                        SizedBox(width: 5),
                                        doctorDetails.doctorTimeTable![index]
                                                    .toDoctorTime !=
                                                null
                                            ? Expanded(
                                                flex: 1,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Text(
                                                      AppLocale.of(context)!
                                                          .getString("to")
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                    Text(
                                                      doctorDetails
                                                              .doctorTimeTable![
                                                                  index]
                                                              .toDoctorTime ??
                                                          "",
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                    Icon(Icons.access_time),
                                                  ],
                                                ),
                                              )
                                            : Container()
                                      ],
                                    ),
                                    Container(
                                      margin: const EdgeInsets.all(5),
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        AppLocale.of(context)!
                                            .getString("notes")
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: primaryColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            })
                    // DataTable(
                    //     headingRowColor:
                    //         MaterialStateProperty.resolveWith<Color>(
                    //             (Set<MaterialState> states) {
                    //       return Color(0xFF5c8bb0);
                    //     }),
                    //     dataRowColor:
                    //         MaterialStateProperty.resolveWith<Color>(
                    //             (Set<MaterialState> states) {
                    //       return Color(0XFFFFFFF);
                    //     }),
                    //     columns: [
                    //       DataColumn(
                    //           label: Text(
                    //         "اليوم",
                    //         style: TextStyle(color: Colors.white),
                    //       )),
                    //       DataColumn(
                    //           label: Text(
                    //         "من",
                    //         style: TextStyle(color: Colors.white),
                    //       )),
                    //       DataColumn(
                    //           label: Text(
                    //         "الي",
                    //         style: TextStyle(color: Colors.white),
                    //       )),
                    //     ],
                    //     rows: doctorDetails.doctorTimeTable!
                    //         .map(
                    //           (timeData) => DataRow(cells: [
                    //             DataCell(Text(timeData.doctorDay!)),
                    //             DataCell(Text(timeData.doctorTime ?? "")),
                    //             DataCell(Text(timeData.toDoctorTime ?? "")),
                    //           ]),
                    //         )
                    //         .toList())
                  ],
                ),
              ),
            ),
    );
  }
}
