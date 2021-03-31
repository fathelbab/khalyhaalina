// To parse this JSON data, do
//
//     final doctorData = doctorDataFromJson(jsonString);

import 'dart:convert';

DoctorData doctorDataFromJson(String str) =>
    DoctorData.fromJson(json.decode(str));

String doctorDataToJson(DoctorData data) => json.encode(data.toJson());

class DoctorData {
  DoctorData({
    this.offset,
    this.result,
    this.limit,
    this.length,
  });

  int offset;
  List<DoctorInfo> result;
  int limit;
  int length;

  factory DoctorData.fromJson(Map<String, dynamic> json) => DoctorData(
        offset: json["offset"],
        result: List<DoctorInfo>.from(
            json["result"].map((x) => DoctorInfo.fromJson(x))),
        limit: json["limit"],
        length: json["length"],
      );

  Map<String, dynamic> toJson() => {
        "offset": offset,
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
        "limit": limit,
        "length": length,
      };
}

class DoctorInfo {
  DoctorInfo({
    this.id,
    this.name,
    this.address,
    this.phoneNumber,
    this.cityId,
    this.imagePath,
    this.doctorSpecialistId,
    this.city,
    this.doctorSpecialist,
    this.doctorTimeTable,
  });

  int id;
  String name;
  String address;
  String phoneNumber;
  int cityId;
  String imagePath;
  int doctorSpecialistId;
  City city;
  DoctorSpecialist doctorSpecialist;
  List<DoctorTimeTable> doctorTimeTable;

  factory DoctorInfo.fromJson(Map<String, dynamic> json) => DoctorInfo(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        phoneNumber: json["phoneNumber"],
        cityId: json["cityId"],
        imagePath: json["imagePath"],
        doctorSpecialistId: json["doctorSpecialistId"],
        city: City.fromJson(json["city"]),
        doctorSpecialist: DoctorSpecialist.fromJson(json["doctorSpecialist"]),
        doctorTimeTable: List<DoctorTimeTable>.from(
            json["doctorTimeTable"].map((x) => DoctorTimeTable.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "phoneNumber": phoneNumber,
        "cityId": cityId,
        "imagePath": imagePath,
        "doctorSpecialistId": doctorSpecialistId,
        "city": city.toJson(),
        "doctorSpecialist": doctorSpecialist.toJson(),
        "doctorTimeTable":
            List<dynamic>.from(doctorTimeTable.map((x) => x.toJson())),
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
    this.name,
    this.suppliers,
    this.doctors,
    this.services,
  });

  int id;
  dynamic order;
  String createdDate;
  String updatedDate;
  bool isActive;
  bool isDeleted;
  dynamic createdBy;
  dynamic updatedBy;
  String name;
  List<dynamic> suppliers;
  dynamic doctors;
  dynamic services;

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"],
        order: json["order"],
        createdDate: json["createdDate"],
        updatedDate: json["updatedDate"],
        isActive: json["isActive"],
        isDeleted: json["isDeleted"],
        createdBy: json["createdBy"],
        updatedBy: json["updatedBy"],
        name: json["name"],
        suppliers: List<dynamic>.from(json["suppliers"].map((x) => x)),
        doctors: json["doctors"],
        services: json["services"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order": order,
        "createdDate": createdDate,
        "updatedDate": updatedDate,
        "isActive": isActive,
        "isDeleted": isDeleted,
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "name": name,
        "suppliers": List<dynamic>.from(suppliers.map((x) => x)),
        "doctors": doctors,
        "services": services,
      };
}

class DoctorSpecialist {
  DoctorSpecialist({
    this.id,
    this.name,
    this.doctors,
  });

  int id;
  String name;
  dynamic doctors;

  factory DoctorSpecialist.fromJson(Map<String, dynamic> json) =>
      DoctorSpecialist(
        id: json["id"],
        name: json["name"],
        doctors: json["doctors"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "doctors": doctors,
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

  int id;
  int doctorId;
  String doctorDay;
  String doctorTime;
  dynamic toDoctorTime;
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
