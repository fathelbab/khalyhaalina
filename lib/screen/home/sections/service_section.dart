import 'package:cached_network_image/cached_network_image.dart';
import 'package:eshop/utils/style.dart';
import 'package:eshop/language/app_locale.dart';
import 'package:eshop/model/service_details_data.dart';
import 'package:eshop/model/service_specialist_data.dart';
import 'package:eshop/provider/service_provider.dart';
import 'package:eshop/screen/services/services_screen.dart';
import 'package:eshop/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ServiceSection extends StatefulWidget {
  @override
  _ServiceSectionState createState() => _ServiceSectionState();
}

class _ServiceSectionState extends State<ServiceSection> {
  List<ServiceInfo>? serviceList = [];
  List<ServiceSpecialist>? serviceSpecialist = [];
  int selecteIndex = 0;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    serviceSpecialist =
        Provider.of<ServiceProvider>(context).serviceSpecialistList;
    serviceList = Provider.of<ServiceProvider>(context).serviceList;
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            // isDoctor=true
            // CustomServiceDropDownButton(),
            if (serviceSpecialist != null)
              Container(
                width: double.infinity,
                height: 150,
                margin: const EdgeInsets.all(5),
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: serviceSpecialist!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Provider.of<ServiceProvider>(context, listen: false)
                              .fetchServiceInfoList(
                                  serviceSpecialist![index].id.toString())
                              .then((value) {
                            setState(() {
                              isLoading = false;
                            });
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
                                serviceSpecialist![index].name ?? "",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            serviceList == null || serviceList!.isEmpty
                ? Container(
                  height: 200,
                  child: Center(
                      child:
                           isLoading
                              ? CircularProgressIndicator()
                              :
                          Text("لايوجد خدمات متاح فى هذه المنطقة")),
                )
                : LayoutBuilder(
                    builder: (context, constraints) {
                      return ListView.builder(
                          itemCount: serviceList!.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return ServiceItem(service: serviceList![index]);
                          });
                      // return GridView.builder(
                      //   padding: const EdgeInsets.all(5),
                      //   itemCount: serviceList!.length,
                      //   shrinkWrap: true,
                      //   physics: NeverScrollableScrollPhysics(),
                      //   scrollDirection: Axis.vertical,
                      //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      //     crossAxisSpacing: 4,
                      //     mainAxisSpacing: 4,
                      //     crossAxisCount: constraints.maxWidth > 480 ? 4 : 2,
                      //     childAspectRatio: 0.8,
                      //   ),
                      //   itemBuilder: (context, index) {
                      //     return ServiceGridItem(service:serviceList![index]);
                      //   },
                      // );
                    },
                  )
          ],
        ),
      ),
    );
  }
}

class ServiceItem extends StatelessWidget {
  const ServiceItem({
    Key? key,
    required this.service,
  }) : super(key: key);

  final ServiceInfo service;
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
        onTap: () {},
        title: Text(
          service.name.toString(),
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        subtitle: Row(
          children: [
            Expanded(
                child: Text(
              service.serviceSpecialist!.name.toString(),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            )),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                Navigator.pushNamed(context, ServicesScreen.route, arguments: {
                  "name": service.name ?? "",
                  "serviceName": service.serviceSpecialist!.name ?? "",
                  "serviceAddress": service.address ?? "",
                  "servicePhoneNumber": service.phoneNumber ?? "",
                });
              },
              child: Text(AppLocale.of(context)!
                  .getString("serviceRequest")
                  .toString()),
            ),
          ],
        ),
        leading: CachedNetworkImage(
          height: 70.0,
          width: 70.0,
          imageUrl: Constants.imagePath + service.imagePath!,
          fit: BoxFit.fill,
          placeholder: (context, url) =>
              Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
    );
  }
}

class ServiceGridItem extends StatelessWidget {
  const ServiceGridItem({
    Key? key,
    required this.service,
  }) : super(key: key);

  final ServiceInfo service;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ServicesScreen.route, arguments: {
          "name": service.name ?? "",
          "serviceName": service.serviceSpecialist!.name ?? "",
          "serviceAddress": service.address ?? "",
          "servicePhoneNumber": service.phoneNumber ?? "",
        });
        // Provider.of<DoctorProvider>(context, listen: false)
        //     .getDoctorById(serviceList[index].id.toString());
      },
      child: Container(
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
              height: 65.0,
              width: 65.0,
              child: CachedNetworkImage(
                imageUrl: Constants.imagePath + service.imagePath!,
                fit: BoxFit.fill,
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              service.name!,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                  fontSize: 15.0),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                Navigator.pushNamed(context, ServicesScreen.route, arguments: {
                  "name": service.name ?? "",
                  "serviceName": service.serviceSpecialist!.name ?? "",
                  "serviceAddress": service.address ?? "",
                  "servicePhoneNumber": service.phoneNumber ?? "",
                });
              },
              child: Text("اطلب خدمة"),
            ),
          ],
        ),
      ),
    );
  }
}
