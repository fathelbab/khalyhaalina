// To parse this JSON data, do
//
//     final serviceDetailsData = serviceDetailsDataFromJson(jsonString);

import 'dart:convert';

ServiceDetailsData serviceDetailsDataFromJson(String str) =>
    ServiceDetailsData.fromJson(json.decode(str));

String serviceDetailsDataToJson(ServiceDetailsData data) =>
    json.encode(data.toJson());

class ServiceDetailsData {
  ServiceDetailsData({
    this.offset,
    this.result,
    this.limit,
    this.length,
  });

  int? offset;
  List<ServiceInfo>? result;
  int? limit;
  int? length;

  factory ServiceDetailsData.fromJson(Map<String, dynamic> json) =>
      ServiceDetailsData(
        offset: json["offset"],
        result: List<ServiceInfo>.from(
            json["result"].map((x) => ServiceInfo.fromJson(x))),
        limit: json["limit"],
        length: json["length"],
      );

  Map<String, dynamic> toJson() => {
        "offset": offset,
        "result": List<dynamic>.from(result!.map((x) => x.toJson())),
        "limit": limit,
        "length": length,
      };
}

class ServiceInfo {
  ServiceInfo({
    this.id,
    this.name,
    this.phoneNumber,
    this.address,
    this.cityId,
    this.descriptionAr,
    this.descriptionEn,
    this.imagePath,
    this.serviceSpecialistId,
    this.city,
    this.serviceSpecialist,
  });

  int? id;
  String? name;
  String? phoneNumber;
  String? address;
  int? cityId;
  String? descriptionAr;
  String? descriptionEn;
  String? imagePath;
  int? serviceSpecialistId;
  City? city;
  ServiceSpecialist? serviceSpecialist;

  factory ServiceInfo.fromJson(Map<String, dynamic> json) => ServiceInfo(
        id: json["id"],
        name: json["name"],
        phoneNumber: json["phoneNumber"],
        address: json["address"],
        cityId: json["cityId"],
        descriptionAr: json["descriptionAr"],
        descriptionEn: json["descriptionEn"],
        imagePath: json["imagePath"],
        serviceSpecialistId: json["serviceSpecialistId"],
        city: City.fromJson(json["city"]),
        serviceSpecialist:
            ServiceSpecialist.fromJson(json["serviceSpecialist"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phoneNumber": phoneNumber,
        "address": address,
        "cityId": cityId,
        "descriptionAr": descriptionAr,
        "descriptionEn": descriptionEn,
        "imagePath": imagePath,
        "serviceSpecialistId": serviceSpecialistId,
        "city": city!.toJson(),
        "serviceSpecialist": serviceSpecialist!.toJson(),
      };
}

class City {
  City({
    this.id,
    this.order,
    this.createdDate,
    this.updatedDate,
    this.isActive,
    this.isDeleted,
    this.createdBy,
    this.updatedBy,
    this.nameAr,
    this.nameEn,
    this.counteryid,
    this.countery,
    this.doctors,
    this.services,
    this.suppliers,
  });

  int? id;
  dynamic order;
  DateTime? createdDate;
  DateTime? updatedDate;
  bool? isActive;
  bool? isDeleted;
  dynamic createdBy;
  dynamic updatedBy;
  String? nameAr;
  dynamic nameEn;
  int? counteryid;
  dynamic countery;
  List<dynamic>? doctors;
  List<dynamic>? services;
  List<dynamic>? suppliers;

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"],
        order: json["order"],
        createdDate: DateTime.parse(json["createdDate"]),
        updatedDate: DateTime.parse(json["updatedDate"]),
        isActive: json["isActive"],
        isDeleted: json["isDeleted"],
        createdBy: json["createdBy"],
        updatedBy: json["updatedBy"],
        nameAr: json["nameAr"],
        nameEn: json["nameEn"],
        counteryid: json["counteryid"],
        countery: json["countery"],
        doctors: List<dynamic>.from(json["doctors"].map((x) => x)),
        services: List<dynamic>.from(json["services"].map((x) => x)),
        suppliers: List<dynamic>.from(json["suppliers"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order": order,
        "createdDate": createdDate!.toIso8601String(),
        "updatedDate": updatedDate!.toIso8601String(),
        "isActive": isActive,
        "isDeleted": isDeleted,
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "nameAr": nameAr,
        "nameEn": nameEn,
        "counteryid": counteryid,
        "countery": countery,
        "doctors": List<dynamic>.from(doctors!.map((x) => x)),
        "services": List<dynamic>.from(services!.map((x) => x)),
        "suppliers": List<dynamic>.from(suppliers!.map((x) => x)),
      };
}

class ServiceSpecialist {
  ServiceSpecialist({
    this.id,
    this.nameAr,
    this.nameEn,
    this.services,
  });

  int? id;
  String? nameAr;
  dynamic nameEn;
  List<dynamic>? services;

  factory ServiceSpecialist.fromJson(Map<String, dynamic> json) =>
      ServiceSpecialist(
        id: json["id"],
        nameAr: json["nameAr"],
        nameEn: json["nameEn"],
        services: List<dynamic>.from(json["services"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nameAr": nameAr,
        "nameEn": nameEn,
        "services": List<dynamic>.from(services!.map((x) => x)),
      };
}
