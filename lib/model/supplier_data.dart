// To parse this JSON data, do
//
//     final supplierData = supplierDataFromJson(jsonString);

import 'dart:convert';

SupplierData supplierDataFromJson(String str) =>
    SupplierData.fromJson(json.decode(str));

String supplierDataToJson(SupplierData data) => json.encode(data.toJson());

class SupplierData {
  SupplierData({
    this.offset,
    this.supplier,
    this.limit,
    this.length,
  });

  int? offset;
  List<Supplier>? supplier;
  int? limit;
  int? length;

  factory SupplierData.fromJson(Map<String, dynamic> json) => SupplierData(
        offset: json["offset"],
        supplier: List<Supplier>.from(
            json["result"].map((x) => Supplier.fromJson(x))),
        limit: json["limit"],
        length: json["length"],
      );

  Map<String, dynamic> toJson() => {
        "offset": offset,
        "result": List<dynamic>.from(supplier!.map((x) => x.toJson())),
        "limit": limit,
        "length": length,
      };
}

class Supplier {
  Supplier({
    this.id,
    this.nameAr,
    this.nameEn,
    this.imageUrl1,
    this.rate,
    this.isOpen,
    this.imagePath,
    this.imagePath1,
    this.openTime,
    this.closeTime,
  });

  int? id;
  String? nameAr;
  String? nameEn;
  dynamic imageUrl1;
  int? rate;
  bool? isOpen;
  String? imagePath;
  String? imagePath1;
  String? openTime;
  String? closeTime;

  factory Supplier.fromJson(Map<String, dynamic> json) => Supplier(
        id: json["id"],
        nameAr: json["nameAr"],
        nameEn: json["nameEn"] == null ? null : json["nameEn"],
        imageUrl1: json["imageUrl1"],
        rate: json["rate"],
        isOpen: json["isOpen"],
        imagePath: json["imagePath"],
        imagePath1: json["imagePath1"],
        openTime: json["openTime"],
        closeTime: json["closeTime"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nameAr": nameAr,
        "nameEn": nameEn == null ? null : nameEn,
        "imageUrl1": imageUrl1,
        "rate": rate,
        "isOpen": isOpen,
        "imagePath": imagePath,
        "imagePath1": imagePath1,
        "openTime": openTime,
        "closeTime": closeTime,
      };
}
