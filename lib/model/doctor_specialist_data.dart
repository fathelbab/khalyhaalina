// To parse this JSON data, do
//
//     final doctorSpecialistData = doctorSpecialistDataFromJson(jsonString);

import 'dart:convert';

DoctorSpecialistData doctorSpecialistDataFromJson(String str) =>
    DoctorSpecialistData.fromJson(json.decode(str));

String doctorSpecialistDataToJson(DoctorSpecialistData data) =>
    json.encode(data.toJson());

class DoctorSpecialistData {
  DoctorSpecialistData({
    this.offset,
    this.doctorSpecialist,
    this.limit,
    this.length,
  });

  int? offset;
  List<DoctorSpecialistt>? doctorSpecialist;
  int? limit;
  int? length;

  factory DoctorSpecialistData.fromJson(Map<String, dynamic> json) =>
      DoctorSpecialistData(
        offset: json["offset"],
        doctorSpecialist: List<DoctorSpecialistt>.from(
            json["result"].map((x) => DoctorSpecialistt.fromJson(x))),
        limit: json["limit"],
        length: json["length"],
      );

  Map<String, dynamic> toJson() => {
        "offset": offset,
        "result": List<dynamic>.from(doctorSpecialist!.map((x) => x.toJson())),
        "limit": limit,
        "length": length,
      };
}

class DoctorSpecialistt {
  DoctorSpecialistt({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory DoctorSpecialistt.fromJson(Map<String, dynamic> json) =>
      DoctorSpecialistt(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
