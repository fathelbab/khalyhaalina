// To parse this JSON data, do
//
//     final serviceSpecialistData = serviceSpecialistDataFromJson(jsonString);

import 'dart:convert';

ServiceSpecialistData serviceSpecialistDataFromJson(String str) =>
    ServiceSpecialistData.fromJson(json.decode(str));

String serviceSpecialistDataToJson(ServiceSpecialistData data) =>
    json.encode(data.toJson());

class ServiceSpecialistData {
  ServiceSpecialistData({
    this.offset,
    this.result,
    this.limit,
    this.length,
  });

  int offset;
  List<ServiceSpecialist> result;
  int limit;
  int length;

  factory ServiceSpecialistData.fromJson(Map<String, dynamic> json) =>
      ServiceSpecialistData(
        offset: json["offset"],
        result: List<ServiceSpecialist>.from(
            json["result"].map((x) => ServiceSpecialist.fromJson(x))),
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

class ServiceSpecialist {
  ServiceSpecialist({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory ServiceSpecialist.fromJson(Map<String, dynamic> json) =>
      ServiceSpecialist(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
