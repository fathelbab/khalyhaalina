// To parse this JSON data, do
//
//     final city = cityDataFromJson(jsonString);

import 'dart:convert';

CityData cityDataFromJson(String str) => CityData.fromJson(json.decode(str));

String cityDataToJson(CityData data) => json.encode(data.toJson());

class CityData {
  CityData({
    this.offset,
    this.city,
    this.limit,
    this.length,
  });

  int? offset;
  List<City>? city;
  int? limit;
  int? length;

  factory CityData.fromJson(Map<String, dynamic> json) => CityData(
        offset: json["offset"],
        city: List<City>.from(json["result"].map((x) => City.fromJson(x))),
        limit: json["limit"],
        length: json["length"],
      );

  Map<String, dynamic> toJson() => {
        "offset": offset,
        "result": List<dynamic>.from(city!.map((x) => x.toJson())),
        "limit": limit,
        "length": length,
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
    this.suppliers,
    this.doctors,
    this.services,
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
  String? nameEn;
  int? counteryid;
  Countery? countery;
  List<dynamic>? suppliers;
  dynamic doctors;
  dynamic services;

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
        countery: Countery.fromJson(json["countery"]),
        suppliers: List<dynamic>.from(json["suppliers"].map((x) => x)),
        doctors: json["doctors"],
        services: json["services"],
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
        "countery": countery!.toJson(),
        "suppliers": List<dynamic>.from(suppliers!.map((x) => x)),
        "doctors": doctors,
        "services": services,
      };
}

class Countery {
  Countery({
    this.id,
    this.nameAr,
    this.nameEn,
  });

  int? id;
  String? nameAr;
  String? nameEn;

  factory Countery.fromJson(Map<String, dynamic> json) => Countery(
        id: json["id"],
        nameAr: json["nameAr"],
        nameEn: json["nameEn"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nameAr": nameAr,
        "nameEn": nameEn,
      };
}
