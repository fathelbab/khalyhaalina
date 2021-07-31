// To parse this JSON data, do
//
//     final governate = governateFromJson(jsonString);

import 'dart:convert';

GovernateData governateFromJson(String str) =>
    GovernateData.fromJson(json.decode(str));

String governateToJson(GovernateData data) => json.encode(data.toJson());

class GovernateData {
  GovernateData({
    this.offset,
    this.governate,
    this.limit,
    this.length,
  });

  int? offset;
  List<Governate>? governate;
  int? limit;
  int? length;

  factory GovernateData.fromJson(Map<String, dynamic> json) => GovernateData(
        offset: json["offset"],
        governate: List<Governate>.from(
            json["result"].map((x) => Governate.fromJson(x))),
        limit: json["limit"],
        length: json["length"],
      );

  Map<String, dynamic> toJson() => {
        "offset": offset,
        "result": List<dynamic>.from(governate!.map((x) => x.toJson())),
        "limit": limit,
        "length": length,
      };
}

class Governate {
  Governate({
    this.id,
    this.nameAr,
    this.nameEn,
  });

  int? id;
  String? nameAr;
  String? nameEn;

  factory Governate.fromJson(Map<String, dynamic> json) => Governate(
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
