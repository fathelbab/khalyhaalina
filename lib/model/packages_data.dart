// To parse this JSON data, do
//
//     final packagesData = packagesDataFromJson(jsonString);

import 'dart:convert';

List<PackagesData> packagesDataFromJson(String str) => List<PackagesData>.from(
    json.decode(str).map((x) => PackagesData.fromJson(x)));

String packagesDataToJson(List<PackagesData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PackagesData {
  PackagesData({
    this.id,
    this.nameAr,
    this.nameEn,
    this.descriptionAr,
    this.descriptionEn,
    this.price,
  });

  int? id;
  String? nameAr;
  String? nameEn;
  String? descriptionAr;
  String? descriptionEn;
  int? price;

  factory PackagesData.fromJson(Map<String, dynamic> json) => PackagesData(
        id: json["id"],
        nameAr: json["nameAr"],
        nameEn: json["nameEn"],
        descriptionAr: json["descriptionAr"],
        descriptionEn: json["descriptionEn"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nameAr": nameAr,
        "nameEn": nameEn,
        "descriptionAr": descriptionAr,
        "descriptionEn": descriptionEn,
        "price": price,
      };
}
