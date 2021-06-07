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
        result:
            List<ServiceInfo>.from(json["result"].map((x) => ServiceInfo.fromJson(x))),
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
  String? imagePath;
  int? serviceSpecialistId;
  City? city;
  ServiceSpecialistt? serviceSpecialist;

  factory ServiceInfo.fromJson(Map<String, dynamic> json) => ServiceInfo(
        id: json["id"],
        name: json["name"],
        phoneNumber: json["phoneNumber"],
        address: json["address"],
        cityId: json["cityId"],
        imagePath: json["imagePath"],
        serviceSpecialistId: json["serviceSpecialistId"],
        city: City.fromJson(json["city"]),
        serviceSpecialist:
            ServiceSpecialistt.fromJson(json["serviceSpecialist"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phoneNumber": phoneNumber,
        "address": address,
        "cityId": cityId,
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
    this.name,
    this.suppliers,
    this.doctors,
    this.services,
  });

  int? id;
  dynamic order;
  String? createdDate;
  String? updatedDate;
  bool? isActive;
  bool? isDeleted;
  dynamic createdBy;
  dynamic updatedBy;
  String? name;
  List<dynamic>? suppliers;
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
        "suppliers": List<dynamic>.from(suppliers!.map((x) => x)),
        "doctors": doctors,
        "services": services,
      };
}

class ServiceSpecialistt {
  ServiceSpecialistt({
    this.id,
    this.name,
    this.services,
  });

  int? id;
  String? name;
  dynamic services;

  factory ServiceSpecialistt.fromJson(Map<String, dynamic> json) =>
      ServiceSpecialistt(
        id: json["id"],
        name: json["name"],
        services: json["services"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "services": services,
      };
}
