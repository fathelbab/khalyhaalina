// To parse this JSON data, do
//
//     final doctorDetailsData = doctorDetailsDataFromJson(jsonString);

import 'dart:convert';

DoctorDetailsData doctorDetailsDataFromJson(String str) =>
    DoctorDetailsData.fromJson(json.decode(str));

String doctorDetailsDataToJson(DoctorDetailsData data) =>
    json.encode(data.toJson());

class DoctorDetailsData {
  DoctorDetailsData({
    this.id,
    this.nameAr,
    this.nameEn,
    this.address,
    this.phoneNumber,
    this.cityId,
    this.descriptionAr,
    this.descriptionEn,
    this.imagePath,
    this.doctorSpecialistId,
    this.city,
    this.doctorSpecialist,
    this.doctorTimeTable,
  });

  int? id;
  String? nameAr;
  String? nameEn;
  String? address;
  String? phoneNumber;
  int? cityId;
  String? descriptionAr;
  String? descriptionEn;
  String? imagePath;
  int? doctorSpecialistId;
  City? city;
  DoctorSpecialist? doctorSpecialist;
  List<DoctorTimeTable>? doctorTimeTable;

  factory DoctorDetailsData.fromJson(Map<String, dynamic> json) =>
      DoctorDetailsData(
        id: json["id"],
        nameAr: json["nameAr"],
        nameEn: json["nameEn"],
        address: json["address"],
        phoneNumber: json["phoneNumber"],
        cityId: json["cityId"],
        descriptionAr: json["descriptionAr"],
        descriptionEn: json["descriptionEn"],
        imagePath: json["imagePath"],
        doctorSpecialistId: json["doctorSpecialistId"],
        city: City.fromJson(json["city"]),
        doctorSpecialist: DoctorSpecialist.fromJson(json["doctorSpecialist"]),
        doctorTimeTable: List<DoctorTimeTable>.from(
            json["doctorTimeTable"].map((x) => DoctorTimeTable.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nameAr": nameAr,
        "nameEn": nameEn,
        "address": address,
        "phoneNumber": phoneNumber,
        "cityId": cityId,
        "descriptionAr": descriptionAr,
        "descriptionEn": descriptionEn,
        "imagePath": imagePath,
        "doctorSpecialistId": doctorSpecialistId,
        "city": city!.toJson(),
        "doctorSpecialist": doctorSpecialist!.toJson(),
        "doctorTimeTable":
            List<dynamic>.from(doctorTimeTable!.map((x) => x.toJson())),
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

class DoctorSpecialist {
  DoctorSpecialist({
    this.id,
    this.nameAr,
    this.nameEn,
    this.doctors,
  });

  int? id;
  String? nameAr;
  dynamic nameEn;
  List<dynamic>? doctors;

  factory DoctorSpecialist.fromJson(Map<String, dynamic> json) =>
      DoctorSpecialist(
        id: json["id"],
        nameAr: json["nameAr"],
        nameEn: json["nameEn"],
        doctors: List<dynamic>.from(json["doctors"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nameAr": nameAr,
        "nameEn": nameEn,
        "doctors": List<dynamic>.from(doctors!.map((x) => x)),
      };
}

class DoctorTimeTable {
  DoctorTimeTable({
    this.id,
    this.doctorId,
    this.doctorDay,
    this.doctorTime,
    this.toDoctorTime,
    this.doctor,
  });

  int? id;
  int? doctorId;
  String? doctorDay;
  String? doctorTime;
  String? toDoctorTime;
  dynamic doctor;

  factory DoctorTimeTable.fromJson(Map<String, dynamic> json) =>
      DoctorTimeTable(
        id: json["id"],
        doctorId: json["doctorId"],
        doctorDay: json["doctorDay"],
        doctorTime: json["doctorTime"],
        toDoctorTime: json["toDoctorTime"],
        doctor: json["doctor"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "doctorId": doctorId,
        "doctorDay": doctorDay,
        "doctorTime": doctorTime,
        "toDoctorTime": toDoctorTime,
        "doctor": doctor,
      };
}
