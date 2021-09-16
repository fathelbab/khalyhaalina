// To parse this JSON data, do
//
//     final pharmacyData = pharmacyDataFromJson(jsonString);

import 'dart:convert';

PharmacyData pharmacyDataFromJson(String str) =>
    PharmacyData.fromJson(json.decode(str));

String pharmacyDataToJson(PharmacyData data) => json.encode(data.toJson());

class PharmacyData {
  PharmacyData({
    this.offset,
    this.result,
    this.limit,
    this.length,
  });

  int? offset;
  List<Pharmacy>? result;
  int? limit;
  int? length;

  factory PharmacyData.fromJson(Map<String, dynamic> json) => PharmacyData(
        offset: json["offset"],
        result: List<Pharmacy>.from(
            json["result"].map((x) => Pharmacy.fromJson(x))),
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

class Pharmacy {
  Pharmacy({
    this.id,
    this.order,
    this.createdDate,
    this.updatedDate,
    this.isActive,
    this.isDeleted,
    this.createdBy,
    this.updatedBy,
    this.name,
    this.phramName,
    this.address,
    this.phoneNumber,
    this.imagePath,
  });

  int? id;
  dynamic order;
  DateTime? createdDate;
  DateTime? updatedDate;
  bool? isActive;
  bool? isDeleted;
  dynamic createdBy;
  dynamic updatedBy;
  String? name;
  String? phramName;
  String? address;
  String? phoneNumber;
  String? imagePath;

  factory Pharmacy.fromJson(Map<String, dynamic> json) => Pharmacy(
        id: json["id"],
        order: json["order"],
        createdDate: DateTime.parse(json["createdDate"]),
        updatedDate: DateTime.parse(json["updatedDate"]),
        isActive: json["isActive"],
        isDeleted: json["isDeleted"],
        createdBy: json["createdBy"],
        updatedBy: json["updatedBy"],
        name: json["name"],
        phramName: json["phramName"] == null ? null : json["phramName"],
        address: json["address"],
        phoneNumber: json["phoneNumber"],
        imagePath: json["imagePath"],
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
        "name": name,
        "phramName": phramName == null ? null : phramName,
        "address": address,
        "phoneNumber": phoneNumber,
        "imagePath": imagePath,
      };
}
