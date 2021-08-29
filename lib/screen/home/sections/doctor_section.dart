import 'package:cached_network_image/cached_network_image.dart';
import 'package:eshop/utils/cache_helper.dart';
import 'package:eshop/utils/style.dart';
import 'package:eshop/model/doctor_data.dart';
import 'package:eshop/model/doctor_specialist_data.dart';
import 'package:eshop/provider/doctor_provider.dart';
import 'package:eshop/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../../doctor/doctor_details_screen.dart';

class DoctorSection extends StatefulWidget {
  @override
  _DoctorSectionState createState() => _DoctorSectionState();
}

class _DoctorSectionState extends State<DoctorSection> {
  List<DoctorInfo>? doctorList = [];
  late String locale;
  List<DoctorSpecialistt>? doctorSpeciaList = [];
  bool isLoading = false;
  int selecteIndex = 0;
  @override
  void initState() {
    super.initState();
    locale = CacheHelper.getPrefs(key: "locale") ?? "ar";
  }

  @override
  Widget build(BuildContext context) {
    doctorList = Provider.of<DoctorProvider>(context).doctorList;
    doctorSpeciaList =
        Provider.of<DoctorProvider>(context).doctorSpecialistList;
    return Scaffold(
      backgroundColor: primaryColor,
      body: Container(
        height: double.infinity,
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20.0),
            topRight: const Radius.circular(20.0),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // CustomDoctorDropDownButton(),
              if (doctorSpeciaList != null)
                Container(
                  width: double.infinity,
                  height: 150,
                  margin: const EdgeInsets.all(5),
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: doctorSpeciaList!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Provider.of<DoctorProvider>(context, listen: false)
                                .fetchDoctorList(
                                    doctorSpeciaList![index].id.toString())
                                .then((value) {
                              isLoading = false;
                            });
                            setState(() {
                              selecteIndex = index;
                              isLoading = true;
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 100,
                            width: 120,
                            margin: const EdgeInsets.all(3),
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                                color: primaryColor,
                                border: Border.all(
                                    color: selecteIndex == index
                                        ? secondaryColor
                                        : Colors.transparent,
                                    width: 5),
                                borderRadius: BorderRadius.circular(15)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/app_logo.png",
                                  height: 60,
                                ),
                                Text(
                                  locale == "ar"
                                      ? doctorSpeciaList![index]
                                              .nameAr
                                              ?.toString() ??
                                          ""
                                      : doctorSpeciaList![index].nameEn ??
                                          doctorSpeciaList![index]
                                              .nameAr
                                              .toString(),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),

              doctorList == null || doctorList!.isEmpty
                  ? Container(
                      height: 200,
                      child: Center(
                        child: isLoading
                            ? const SpinKitChasingDots(
                                color: Color(0XFFE5A352),
                              )
                            : Text("لايوجد طبيب متاح فى هذه المنطقة"),
                      ),
                    )
                  : LayoutBuilder(
                      builder: (context, constraints) {
                        return ListView.builder(
                            itemCount: doctorList!.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return DoctorItem(doctor: doctorList![index]);
                            });
                        // GridView.builder(
                        //   padding: const EdgeInsets.all(5),
                        //   itemCount: doctorList!.length,
                        //   shrinkWrap: true,
                        //   physics: NeverScrollableScrollPhysics(),
                        //   scrollDirection: Axis.vertical,
                        //   gridDelegate:
                        //       SliverGridDelegateWithFixedCrossAxisCount(
                        //     crossAxisSpacing: 4,
                        //     mainAxisSpacing: 4,
                        //     crossAxisCount: constraints.maxWidth > 480 ? 4 : 2,
                        //     childAspectRatio: 0.8,
                        //   ),
                        //   itemBuilder: (context, index) {
                        //     return DoctorGridItem(doctor: doctorList![index]);
                        //     return DoctorItem(doctor: doctorList![index]);
                        //   },
                        // );
                      },
                    )
            ],
          ),
        ),
      ),
    );
  }
}

class DoctorItem extends StatelessWidget {
  DoctorItem({
    Key? key,
    required this.doctor,
  }) : super(key: key);
  final String locale = CacheHelper.getPrefs(key: 'locale') ?? "ar";
  final DoctorInfo doctor;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 8,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
          color: Colors.white),
      child: ListTile(
        onTap: () {
          Provider.of<DoctorProvider>(context, listen: false).clearDoctorData();
          Provider.of<DoctorProvider>(context, listen: false)
              .getDoctorById(doctor.id.toString());
          Navigator.pushNamed(
            context,
            DoctorDetailsScreen.route,
          );
        },
        title: Text(
          locale == "ar" ? doctor.nameAr.toString() : doctor.nameEn.toString(),
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(locale == "ar"
            ? doctor.doctorSpecialist!.nameAr.toString()
            : doctor.doctorSpecialist!.nameEn.toString()),
        leading: CachedNetworkImage(
          height: 60.0,
          width: 60.0,
          imageUrl: Constants.imagePath + doctor.imagePath!,
          fit: BoxFit.fill,
          placeholder: (context, url) => Center(
            child: const SpinKitChasingDots(
              color: Color(0XFFE5A352),
            ),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
    );
  }
}

class DoctorGridItem extends StatelessWidget {
  DoctorGridItem({
    Key? key,
    required this.doctor,
  }) : super(key: key);
  final String locale = CacheHelper.getPrefs(key: 'locale') ?? "ar";

  final DoctorInfo doctor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<DoctorProvider>(context, listen: false).clearDoctorData();
        Provider.of<DoctorProvider>(context, listen: false)
            .getDoctorById(doctor.id.toString());
        Navigator.pushNamed(
          context,
          DoctorDetailsScreen.route,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 3.0,
              blurRadius: 5.0,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 70.0,
              width: 65.0,
              child: CachedNetworkImage(
                imageUrl: Constants.imagePath + doctor.imagePath!,
                fit: BoxFit.fill,
                placeholder: (context, url) => Center(
                  child: const SpinKitChasingDots(
                    color: Color(0XFFE5A352),
                  ),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              locale == "ar"
                  ? doctor.nameAr.toString()
                  : doctor.nameEn.toString(),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                  fontSize: 15.0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  doctor.phoneNumber!.length > 12
                      ? doctor.phoneNumber!.substring(12)
                      : doctor.phoneNumber ?? "",
                  style: TextStyle(
                      color: Color(0xFF575E67),
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0),
                ),
                SizedBox(
                  width: 2,
                ),
                Icon(
                  Icons.phone,
                  color: Theme.of(context).primaryColor,
                  size: 15,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
